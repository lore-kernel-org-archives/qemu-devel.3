Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B51EE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8d1-0004Pl-O4; Sun, 12 Jan 2025 19:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8d0-0004PW-4l
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:26 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cy-0000jb-BJ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:25 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1889937f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729302; x=1737334102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ4Q1ZYjWhR78jDu3ct+Sy0h6LO2CCqvtQz5hazIz8Q=;
 b=y13TtijWvsFtvqWe6kFxJe8N82+SCOHGp1m0EWgV6ioM6iaeg1KLnrfPLZ3vuwTz6N
 6+On5StMl+UqfquTRRFMpJ4AZTGXl5UaHq5S0hwChzN7PWjQg4fY+IWVsi27/TkyYjTU
 GCb+X5Y5WVAR/+0CzpxtJZ7ALH+0HzDD7dAUcVo4euRtxNO4VayNqgPiKatGTTyHmVz1
 6PBFtb0d/vsub5vXWLKVK5x/Z8C3pJsaysnWLEinUVE/Py8x3opZSFGgNzUCkzKrvAl6
 FjuP5IXSHPs9HghqRjb285xqZqlL2G43C60BkwILR7F3kReHNpesJfqbzfGsRZCs+pQ+
 X2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729302; x=1737334102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ4Q1ZYjWhR78jDu3ct+Sy0h6LO2CCqvtQz5hazIz8Q=;
 b=jVlMUmAPpVlmrSwdj+higkMzJk+MVzsFJzikhXgP/WdYtBiAfJuyTe7zyMxEy/YO61
 j7PrCIbC8UT4+9K4ntNuvKczf67fDP7cc4S4yvMwQIGVX1Xq0Il75R1XYgbJDHAKtEm3
 7JAvHJv5xa03H100z3seLuXt7MLQqEhsILwxBwT/o69Vy73JLkBFGBmCxLgdnOPkj4+v
 pSlYuZl3lC7uw/Z0f9Wk9HxBLZlU9deKjTxepwVPMNPFAkjjLerA8GTJz4Na2rE6LXoD
 IpsU56r2vhZRBYHOXodZ7LX+x18549MxE4ZefdDm7GOQT8tcBoEZCvkjzRvqxmGbbB9j
 DAsg==
X-Gm-Message-State: AOJu0YzCG5QzuJRRzHTjkUjruMvLvkA37LoYhQcGshWIPUlXRFNot6Cf
 1BQbMzE8XTBcFI3STnnQm12m80XVmxNnegvLpbVvKk38saQ9c783B3H8i/oQk/B0z/sRvRxeuNr
 5JHE=
X-Gm-Gg: ASbGncvXIkUQIhVaengT9RHtk8NAALy205+hP1IGuAwaHSdiEjR+ZU8Z0sJMtWP8esx
 XSIzhQQwFAyFvmqVLSVRIMyLq2Dn5G+YHjBcMQZ9GRZoB9RWP/h+vQIITljmQA/V1CKLrpblgsj
 SCcOhizHvSm+GLl+1ApawLgSXtLf2Orgca4Np2tCddKM6RLoxg2yHQ+xfmLSE/wX7ZlHvXv7xIn
 gbuXj2il2ztnO8PIg+tlZGbZXIp2wQ5dHXns8YUdTDCzElqkMwxxI71l+5svt5OiDqAnHQemUfb
 HYH4lN+Zmep27C4KRwdXqZzBhBWocZc=
X-Google-Smtp-Source: AGHT+IEf9Z1EGiAzCaZUL02LwjLwKNffKp3EwpDBa4beoAX1Jh4H3JFKpzbvwMX69wQwZTaG7vxUzA==
X-Received: by 2002:adf:ae59:0:b0:38a:88b8:97a9 with SMTP id
 ffacd0b85a97d-38a88b898b4mr12288545f8f.2.1736729302291; 
 Sun, 12 Jan 2025 16:48:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e384f2bsm10728193f8f.41.2025.01.12.16.48.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 05/23] hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
Date: Mon, 13 Jan 2025 01:47:30 +0100
Message-ID: <20250113004748.41658-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Propagate the target specific CPU env to the locally
declared bl_gen_nop() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 918ce7795c4..b2be9267516 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -67,9 +67,9 @@ static void st_nm32_p(void **ptr, uint32_t insn)
 }
 
 /* Base types */
-static void bl_gen_nop(void **ptr)
+static void bl_gen_nop(const CPUMIPSState *env, void **ptr)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         st_nm32_p(ptr, 0x8000c000);
     } else {
         uint32_t *p = *ptr;
@@ -247,7 +247,7 @@ void bl_gen_jump_to(void **p, target_ulong jump_addr)
 {
     bl_gen_load_ulong(p, BL_REG_T9, jump_addr);
     bl_gen_jalr(p, BL_REG_T9);
-    bl_gen_nop(p); /* delay slot */
+    bl_gen_nop(&MIPS_CPU(first_cpu)->env, p); /* delay slot */
 }
 
 void bl_gen_jump_kernel(void **p,
-- 
2.47.1



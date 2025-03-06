Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63F2C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVv-00055z-FI; Thu, 06 Mar 2025 10:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUf-0004Nk-Ek
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUd-0006iF-TR
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390e702d481so461865f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276238; x=1741881038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOGFUYxB5eZJvISEgMjDmq17fgmjL5t+bLCA40GL5/4=;
 b=sGUixhDTDP4YJvKfgKGxwlfUQD/TGN+WjBWcMFUW7bMpaVlH2yIRS66/pPNWblLRb2
 N/DovEPQTN0e7rXrUIaVqQtY7hLJcWiXjy67om/MfobYN9QpSRAzNTtUFsIIwpj0fEmu
 +OaAwKDqe1IsEbPz6nTGSiNf9AbRZ0ik9EjvZK+eCM8/aeSfSWCJ0baA8Q8Yyn8q6kJ2
 JGiKDph5YGNHx1Ij/UV606TDnlc8M+XxkMJ60b/2AhyBp5MfB761qh2td7aepci+ou9b
 RZcRMVtRyYu0OfEe3oVilLZTfpes9rbd/0aDVaX7FzxAVuw0RYxJe4/Ikhf3rFbkOgUD
 tJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276238; x=1741881038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOGFUYxB5eZJvISEgMjDmq17fgmjL5t+bLCA40GL5/4=;
 b=W/BcTGx2JyijIiXd8dPUn+PUy//AL2YUJ6td0O6BFamjiQXnwL4rE+9uexskJCIBH+
 rOi8c6N6fsJeUbK442G8+ViwFr6E4PGY7rATmjAw5L69llEumE9IAImd8nw1+QXT3qm7
 4QKKIOYTtG5Y1ehle/094BSI038lsJFb1qMCwASRjqPXpKCNqjMHPhOq1C6r8E4EpAUY
 R4kx4fKCm/1KUgaxFUjpbaM0/KL8knrV7WgPBjXCB3TpuiQj7/u4v06VKZbO0KkKFILr
 zX5e4c0O50zd4CUjd2WrpTc4dDVdL8cIZATMt4JGy3Sy2WB2aHarPMpE0H+MIhpmVlZ/
 9FpQ==
X-Gm-Message-State: AOJu0Yzc1XAsKgXNdA+bxJimB9memFO0jKWdMnExIaXpLiBqilglV/pH
 mI2Dez2VRRm59oqwP1Cr8dUU+pZxPLC+p9vyJmkKHsr4HgrX5r3ot80U1h+R28Ebiu+LFcmB4bd
 T8d4=
X-Gm-Gg: ASbGncuszculHjDF9v6e5c+L+2xNP0+sNuSYUCOi9asOv2FkkswXiuDkMOx6eXm+9PD
 v1tb9aTN0OceGDjZlQ8dDgK0/MhESJTwg+48Hq+b5p3hPx6vJbDicAwslitsJ/hAFBkEKj+kbQ2
 fnUd2ETixQZE4BiAN6TT3S6qXWX6p26U6HwMuBbMup14qkFE4IV5kY3YLbSYGFa69Vms2hieCBX
 +3jDfwzsoAL1KuN/aTT3h5LpJ8RhCsk/B+XV+lmP+kLC6LZsQGjvaaStllIag2QenRhFq238YKu
 VCCCmFPBpCeFZiG/OdNWJr9H2Y2qafUAq0E9a+ucsdHTQFmW++WN4X697SUg6dVDA4PRb76WFI/
 mhUZOqeXLL1NSxWvXeHY=
X-Google-Smtp-Source: AGHT+IGqRe7gw6ucQlUUysGIBukpbQwlDIaaEUW5EtRZjIyXt8e+xg5m4KVJOcdBSdyBoDAY+2GMhg==
X-Received: by 2002:a5d:5f4d:0:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-3911f725ea9mr6391563f8f.5.1741276238053; 
 Thu, 06 Mar 2025 07:50:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfb16sm2406334f8f.29.2025.03.06.07.50.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/54] target/mips: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:22 +0100
Message-ID: <20250306154737.70886-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-6-philmd@linaro.org>
---
 target/mips/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0b267d2e507..e76298699ab 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -428,13 +428,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     if (!(cpu_env(s)->insn_flags & ISA_NANOMIPS32)) {
-#if TARGET_BIG_ENDIAN
-        info->print_insn = print_insn_big_mips;
-#else
-        info->print_insn = print_insn_little_mips;
-#endif
+        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                         : BFD_ENDIAN_LITTLE;
+        info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
+                                             : print_insn_little_mips;
     } else {
         info->print_insn = print_insn_nanomips;
+        info->endian = BFD_ENDIAN_LITTLE;
     }
 }
 
-- 
2.47.1



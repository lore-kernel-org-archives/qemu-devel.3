Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D5ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NFY-0000xD-5J; Wed, 08 Oct 2025 02:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFF-0000s9-64
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NFD-0000c6-77
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:01:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso56029175e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759903305; x=1760508105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=METBz19oMX6CRWEew7m9bIZba5dshSYUEXQl793Ow70=;
 b=aZj/CnNE53hOPRY5fwyUIwo2EoWyiSI0+jJ2n/r6+T+hA6HfyHcKZHo1YWDhg6JuEc
 pIsu5Y8M6Y8QK/ijRkBGN8TjKXyX7Jc5gHau2pqINR459p0fBzZgOhapB3ZHTFquUcc+
 W0oSQp4uiS7V9BO2xiWePg9240yjhThAKApU0E6xTr5c+vJR/M3rXAqueeLwn6hJAuWp
 UniRI0rK8asMh0G7ONMsnMFsGiWa5VjZAY/ENe7NPtEIdp5rGc2+vy2Jjz2OB4r/xzAM
 NcilzGy2D+34aYPxo2jeT0aT1nFDCVFiggQ3hgJkDwYiS0LCNUS/exNvrglqaEqvWiEB
 E+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759903305; x=1760508105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=METBz19oMX6CRWEew7m9bIZba5dshSYUEXQl793Ow70=;
 b=grrH47GolJdM98eDducd18dK8/iQWbOJTldyqQwmjwlm+F+kQe02djJy5AWbNaWlb8
 C2J9bs5hS/CJfYh6cjNRmMm5dVhRlFckazrrFXQyjQkv8f9XN35BGJ19mPVlvnfxL+PJ
 J9hhQea6gdrYQPTdiqTu37uPpj22Fvr2J5egRW0+F/PHh2F6AdzSudskGpksACibZS/i
 4Jl6TJZ8DNRwsS5tyMmVSrCMpWmzXK0Betjg5AIN7KFFvk2VsodMkeS/p4KXFl8FbxBs
 jHsWtSeXi5qwNIcQ050UqKR3YSrDT/jEynhyD11AH1FNFO3yGzufiISnhzCuwLPOXHI2
 NW3g==
X-Gm-Message-State: AOJu0YynP0PDqYcDgBWuUD9qRiVIDvw6BXYP+154m/uw7Jd3rUrwc6RO
 qUreejuLPvRpAx8nLKUxBVZMc1VP/m3KTwBhIj1S3HQutYDQCBqJYmMqshzt9rk65rPyxey4lAw
 zLXxm4qZn+w==
X-Gm-Gg: ASbGncs9tOhCIII6cibTEQwu3xg+7vT8nGazipBOXdpKXKbs10f0fOPE/4g9Th3sd2z
 9J7QbEDj68ixarBkSVLMzSWWHBMl7UqDalYEz5ewisXxX0gw1nToKkP89JlTcAWfmA4RNu4S+4F
 /XibYczsY/W6ry/8R3w0gJHVNy0EuS8Z04tS2FWM/mjDmJA1dxUPtwfB6H3XHbgmGBUWl2RMlXz
 a7LfpcoS4YT1h3+dv9/ajO+ymWki4a3nR652w8r/oAYv0C0glWdq8eYukVeF4LuB3TMlZa+1CYx
 x9YmYk3jPLZS9LYvsGyfe7c7U8uXzR8gh2YI7HVXPmgM0CiHhf69tQ+Xi8F6l8z3O4nF3eoqipJ
 Etn1IzAVxqlABB7ByPVDicYXTb92zQ7gsdz+G0RpRDTs1AMx+2k0orME1N08fHxPdJvoXo9jstq
 /uzWsuB43OWqHjU2o7kQKsyfm7
X-Google-Smtp-Source: AGHT+IFf1XQxIXBbZWa3U4rVg0H3J9SIu0muAxscgdqVCPihPdWI9B9JDKMk+juPjdrbmnC5anWjLw==
X-Received: by 2002:a05:600c:699b:b0:46e:410f:f645 with SMTP id
 5b1f17b1804b1-46fa9af8fa5mr15126635e9.21.1759903305096; 
 Tue, 07 Oct 2025 23:01:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf8288sm22477635e9.2.2025.10.07.23.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:01:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] target/microblaze: Remove target_ulong use in
 gen_goto_tb()
Date: Wed,  8 Oct 2025 08:01:27 +0200
Message-ID: <20251008060129.87579-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008060129.87579-1-philmd@linaro.org>
References: <20251008060129.87579-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5098a1db4dc..ff33e64a710 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -116,7 +116,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
     gen_raise_exception_sync(dc, EXCP_HW_EXCP);
 }
 
-static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
         tcg_gen_goto_tb(n);
-- 
2.51.0



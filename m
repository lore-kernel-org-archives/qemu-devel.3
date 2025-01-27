Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E0CC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNiH-000793-BB; Mon, 27 Jan 2025 06:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhl-0006ed-2J
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhj-0006xl-7j
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso1981050f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978897; x=1738583697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtP8AqLeYQZjrWpkd4lk6XaR5TxrmGrkOXytBFmi5uw=;
 b=QREw+1H04fdQiHuHy/p+50Mg631LuJM9DrsDzccTtY+N1dEXTyptEBzhnx4SHAA5dM
 z8MQ6z3RXt05R5WUZ1SDiw4d0u/yVF0AfLEwlVKPEEslCjNuV3tiXqSyFNSXiLH5HSPg
 6WdY9HP/YgcgAKtaR/EPjziOmT9wtLG2RYiIBPLLH5m4kBG7GqL/BjY3mIg3gxlEJ6kI
 F7Y3kBfopKcqtbFG13GWDGrcptWpOh1/Vyx+KxFL8yjrqisOg1zkQa5lW2YaSqTcSs0p
 gjEnYCcJT8Pg2LnxapkzCZd9AxrTPqL2u+7zzPWownJ8zEovRMWxAvRrwugZcAsFqT78
 VsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978897; x=1738583697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtP8AqLeYQZjrWpkd4lk6XaR5TxrmGrkOXytBFmi5uw=;
 b=gv7iTVICLmHNDxaZWtqOge4a7u6KWgf9UPDtmiLnfjCjCY7WuUxtqWtDPXJXb5uavr
 Y1Pfm98j7uAcY0slyqPXTrv+T9M61G52hWteuaDqxU5JddnUo58ft52Uforv+AMhod7m
 iG7LoQ8k6zfAIkVuTbnb27w1cmmpUTKtr+cprBGxIL/Eim9WCBhu0HX+HpAvRkKA6BDY
 6I/UAAp4otzPFnqhuk1xsl+bispy07FkvrNKah26JrdN14/amr5C1D9bqf5seYDhTTY6
 KOdtlfU8CWg4yJUYgDTFnCuykHRRTxsxYdw4XtjZ6isEImvTldmjc5ENiiMsNSS8tuaj
 JPAg==
X-Gm-Message-State: AOJu0YxVk6Avx2o35O0xZDd8m1EkuelwuLeg3+xyFOuMYfdIbxdYrrBE
 2bJLA4QZH6Dtlid5pucMF4KdKNvqV4ZMMHzHZA4d2ehWN8H+dPtFY87o2FzhTWiU5oxXtvgOnRC
 WVIU=
X-Gm-Gg: ASbGncsVBJINsz1F4/oAVqgKHnb9m4XDMpmCGPBLyxCaHBh+ActPVl8ewjAIv3qQK1J
 e2st1YvTgCriSf0xx/SOy1IgW5va0FJybqkyosJazOKmnU3t9Qh/X8IChx8C4EYrXmOXovCRz5A
 4pj7h5KAk2F0sJDEJqnK/XBbWYAUgyGRAQJ+B1JuSHJTQDrCm3xunwb7i919MOgMHYWmcLqib/O
 bGFRd14a9Z2IjaUCYRSIISxNcRyVK3NA1zyBtyKcmz/0XcrO65hVVd3RHNC44sF1sAx4UZ9/RfX
 rDzxicjL2aME7fokg4MA9opN61YTzW4RcShcqUiJjOKKBBt1V06rTxY=
X-Google-Smtp-Source: AGHT+IFa1m9BSfeZPrSdjVs7GMwYclXXgrDCVXWFBsfY7RdZiaq5fBnntdwOIwihd6nMffLYLDKuYg==
X-Received: by 2002:a05:6000:1111:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-38bf57a266amr29419753f8f.40.1737978897072; 
 Mon, 27 Jan 2025 03:54:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1baf3esm11045471f8f.75.2025.01.27.03.54.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/10] target/ppc: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 27 Jan 2025 12:54:22 +0100
Message-ID: <20250127115426.51355-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/ppc/cpu_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ed85448bc7d..c3263f26219 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7398,6 +7398,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
+    } else {
+        info->endian = BFD_ENDIAN_BIG;
     }
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
-- 
2.47.1



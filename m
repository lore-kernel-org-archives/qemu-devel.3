Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B54CC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Ff-0004Jz-Sq; Wed, 02 Apr 2025 17:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fd-0004If-BC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Fb-00067Q-OB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso1723765e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627834; x=1744232634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dmyx3JTZYFq9p9197cADu5kbBYB8RIN9hQSzz7RhzyM=;
 b=hmHvLSt2NeWKHGTpT3ARv2t9AT5cza9u8WiAyvdsuknkk3XiB20EH+PRt/ZPAbthsB
 3rfp0P8Ia4OQpakXq/2u8oxhQWCc0VEGiJSI97ky9Fh/aNAqetwZYBpjfqm6DAmwJIQG
 53ho8dfdXgCoyD2OXYe1QXxYr2LRmHeDgetuIb8nJBmkPbjJFoTdz139Gp/7JKWOOUjx
 N3eSTm8tg4WM9YvWnowM6alOobCGSHPb5tLEN3h95+IeF3Odn867sMO53fAJGM13jz4h
 5wD54Z6K+4Wg5Ilk+bfZJI+3Nj3YBgog5rHuciMmxdaLR7x4MAmiHDYlOjCAcfD20NXe
 IjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627834; x=1744232634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dmyx3JTZYFq9p9197cADu5kbBYB8RIN9hQSzz7RhzyM=;
 b=klSbhdf7R1aVATbYp7g910oculewDmRLnkKKmyZZb5OwT8PFnTiAI3UM3LKL+2Ivv3
 OHff8nkgvb+jKVQsbUpb116L/Gl82G0wl459r1EmTQM7fRhFtuhmjygykEMFQnvx6En0
 CyoibYfWlk40+KyxOFtondhYCIFUWhO7L0VXaaH3VNLOubQ9Y+nPJrnWB9D1av6NkyU0
 R1nsJAnzgvJzs0eDt3VRQUdmRjO4SJQCnwjPmRiBNrfRKcCPtbdAV00pZ/auCaZp6eEq
 fpzF+fVA5gMwlAA/8vIY4GVAl33xLyOQMc3+2usH6NUQlcl5XFn0m7B68H4I/KbImLut
 51jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSCO/Ba8+Ei3vLHkRv0DB2QZKfzMfM1y3sjzzIMw10oU+iQ4Hefz9GWlVzZEPV6fMUa6FQEiQNBQOi@nongnu.org
X-Gm-Message-State: AOJu0Ywux74Ez4rws206PoENOLxv5DQFRUuRTe7fWm5kneQEN47gODhS
 HOnimq5NcA4l71AaPPLV3gSZubu+rwZIQm9JOQ2o4MmO0QcZUhKx97FOiQDlBMVl49DDnbENMwc
 k
X-Gm-Gg: ASbGncszZBlFI6vvBFwHwhuPkZeG2NF8a2X0BzTD2BZ58MHWfzv1LpSFOyUaKBe8Yph
 R6clVZnhCvWg4y77ohQkMHmoCjx4Gcu+TF1hasM1KCFVqrB7ZAk5DN+0ZOG8iw8VguVjv5LbJkt
 S4Tu6kxiQphM+YkrCv6cjrXL014E5h8XemeqJ4necTs6j/BgjPBL6cENdid4vmM6e0M5FEqQOGs
 KJzhenbT440jrtAW9Bcmx9Ey65iS/zhwjUzVLPaqAWCMXbYNMA8jH7crudPemSXSI1Y93G5R3nP
 trbNY2/cZVO7j/6TFbzTNxaqf996KJ3ByKcB/NIdskV3MhgtCmPXN0rnbOAz02cX6EHC2sy1GH3
 e8nEGVnKriRkDPfTKO7I=
X-Google-Smtp-Source: AGHT+IG8pNs9POLoM1LW27FqdR7PKhbMuZxT2uhYl8YLX6iWMZ7t2TygPzvHfj0ScfRrUEhW5TBRcA==
X-Received: by 2002:a05:600c:5108:b0:43c:f629:66f3 with SMTP id
 5b1f17b1804b1-43db624be12mr158671285e9.18.1743627834098; 
 Wed, 02 Apr 2025 14:03:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663573sm18460291f8f.33.2025.04.02.14.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 05/43] target/alpha: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:02:50 +0200
Message-ID: <20250402210328.52897-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 935ad2ee1ae..99d839a2792 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,6 +239,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .translate_code = alpha_translate_code,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
+    .mmu_index = alpha_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
@@ -263,7 +264,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
-    cc->mmu_index = alpha_cpu_mmu_index;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
-- 
2.47.1



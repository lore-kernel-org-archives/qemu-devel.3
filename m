Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370C1C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmqO-0006Fb-5v; Mon, 27 May 2024 22:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpw-0005ZR-0e; Mon, 27 May 2024 22:45:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpu-000423-7x; Mon, 27 May 2024 22:45:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so250856b3a.0; 
 Mon, 27 May 2024 19:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864311; x=1717469111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxijtPcNuNAmolOxSVas1wwngjgg5P1pW7tz7cm2XA8=;
 b=gz3x2a7zGIEidmK1aW+gOfAusDipcKbEZWvpSIMhyOG0rO5T+zKWfiMY3QVXpWqu5x
 2U4EVmBuul2zlQasSHuRV/DynyBZsKwBVOgQnRwZNOXfus5YWLSwOrgTijkjk2EGvZCG
 vMLRujoq0+3wTxK896g/ha8REtMfJLNHDwq0WjaGfE28tqeMxnm4wyz/Nu49Ot44Wgyt
 lfTOqReNlBZ9Aiz8AYtW01o4FWSTFuLFlFshF5dUzalj41n6ggJdyryUka52uqvvHe3x
 nh6E4F5Wqu9k3vnz7DfVcv4FjZjwdBSS5iimVAJ48tIfRRXzK5QIRIN2J1EP8KzB8JdQ
 B2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864311; x=1717469111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxijtPcNuNAmolOxSVas1wwngjgg5P1pW7tz7cm2XA8=;
 b=lfoZGqQfrossswLSEfLsacc6NA5z8Dm27sITbEWtz/H9PdgDiq6vjsIkNBXexMygfM
 b0Dod6jd/TIYDKmpnm194rN6b0082z+q8WVKI+ZYO0TuTM7/vrMqlnRFP66vFaxxj2ve
 4cCKcSDAC4gnF96iL1sWJfBeDupZxeb1sPj+/QlZy6y2TX2x/6t3R3KH/V+Y46QADVW4
 BPaPKD5JsJUcjhJOilYvx4i+iqNMA/IY/r0pbU/tL9Nr1qBZ4Ob5rtKIKksm8wtnEzuK
 6g/Ip81QAH94EHU5uG7e/CHuXSGuAwGUupRpZfsdhDdGDktM20m7+WqgGihwx4Ns31U2
 +thA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2HGjmGVSU29M26rLW4Bkc600az5hbzYkIpDaQU45AiG0JYCkgk+ChQDF5+kY3iKdKjsLUiGQYcCx6L6BtXwCzjD7qF/6Z
X-Gm-Message-State: AOJu0YyIDieoYqKmsGQ9M+IPYC9f+wwDxRJelNBS9WSpbpbryq4uRsMb
 DBSBDW9CAanOZqm8S5KHhIfWQv5yO0bJ+/6qd8KfnsuEJAmRa7ZEyiSldw==
X-Google-Smtp-Source: AGHT+IEho5U/SZCPN7r7+9RmZVKYTBsEx/Zx153SQbcEnc2A89sys3PY5Hyhn1K+zqIZfteqoileZA==
X-Received: by 2002:a05:6a20:3ca2:b0:1b0:19d5:f400 with SMTP id
 adf61e73a8af0-1b212dd4446mr12146567637.23.1716864311019; 
 Mon, 27 May 2024 19:45:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexei Filippov <alexei.filippov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 22/28] target/riscv: do not set mtval2 for non guest-page faults
Date: Tue, 28 May 2024 12:43:22 +1000
Message-ID: <20240528024328.246965-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexei Filippov <alexei.filippov@syntacore.com>

Previous patch fixed the PMP priority in raise_mmu_exception() but we're still
setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2 stage
translation part, mtval2 will be set in case of successes 2 stage translation but
failed pmp check.

In this case we gonna set mtval2 via env->guest_phys_fault_addr in context of
riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and mtval2
should be zero, according to RISCV privileged spec sect. 9.4.4: When a guest
page-fault is taken into M-mode, mtval2 is written with either zero or guest
physical address that faulted, shifted by 2 bits. *For other traps, mtval2
is set to zero...*

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240503103052.6819-1-alexei.filippov@syntacore.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 574886a694..a02497d778 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1376,17 +1376,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
-            }
-
-            if (ret != TRANSLATE_SUCCESS) {
+            } else {
                 /*
                  * Guest physical address translation failed, this is a HS
                  * level exception
                  */
                 first_stage_error = false;
-                env->guest_phys_fault_addr = (im_address |
-                                              (address &
-                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+                if (ret != TRANSLATE_PMP_FAIL) {
+                    env->guest_phys_fault_addr = (im_address |
+                                                  (address &
+                                                   (TARGET_PAGE_SIZE - 1))) >> 2;
+                }
             }
         }
     } else {
-- 
2.45.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008CC27C52
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hg-0007NZ-IW; Mon, 03 Jun 2024 07:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5ha-0006yR-3P; Mon, 03 Jun 2024 07:18:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hY-0006UT-7x; Mon, 03 Jun 2024 07:18:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70264bcb631so861219b3a.2; 
 Mon, 03 Jun 2024 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413486; x=1718018286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxijtPcNuNAmolOxSVas1wwngjgg5P1pW7tz7cm2XA8=;
 b=dQVwjhvlkJpBpRLKRLWvfKs413DjBUF+Dc02PMW40xsIsM/mlyuo/tpUM0fGuv2oIw
 EPa35z5vvNQVuTLsWuFZSqzK2GfjDYA99zD3ZADCA0Mpl36FhBYI41WcE1qC/9MK1N4L
 oW2g1DJnF8TBNYWgdsDFhHKxpdADOiP3fxQ3UrS7ZUv8R3F5+BxKw9NgAm3m8+g54zu4
 G5fJFM5DKchD7DOGu+cno9ud58DsmH1Bb143TqLQix2N+pCjgibjEbgSQWQIf3aygQV1
 oRjUkGkyAIX+r+8kNaGdCURg9GpmQs6r8bIBbrNGNvyweKxZBvnnkqRfHN1kqMXhM0vt
 PIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413486; x=1718018286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxijtPcNuNAmolOxSVas1wwngjgg5P1pW7tz7cm2XA8=;
 b=kCA41cPp2CRoYTDXZPDhXPghyuYwkeeohScrQZyvYQvYUHWbw35oKQErEv8mswNtTq
 OnVffMgMG74lmOO4tZypypfqRsFdVogZiB3KFJunuBHeGvBwHugK4OTPAr7QjiaRvpUc
 2B6HiorWixGVtosw08jjStb0ahpHI2KPEZio9yE6tpam+GOT/IsGULhlm0tuYpFjzHQa
 tM7jr6jGiVSJHafoco6xl1YPjDfss3ecWRwC1Lu7seN7SgQA5aHLsaNuFomZBmCV7hBI
 lOPklVpiYbQnQ5OZWUP5bJfv91sTYNwMecuik8mlY2Qze9d46cW5l+pNueQGtJFMWwqo
 Y5yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhe1LAULb2w2gibor8OJev7EwwNfZm80y40rj87afgbTgIkGSOrZoPjzlygX1CMAPKXojSPVFSVCfuphzqmDtYtKJxNdPX
X-Gm-Message-State: AOJu0YxN2qSI4cTi3eMWT5pJNKQJP9QCDLKKrwRQ2BHmnUR20k1cHCRY
 YVQlwOfXmMxamZrLSpMmzm7Z6/PLF1+8QHRwq2y7bWzJJb8RP6G4pOHRfg==
X-Google-Smtp-Source: AGHT+IGTX3sVXNmCpwF4evW2ehWf0+K4fA+ODjk/VIUvCoS+0aDVSP2VlhPBc2Tpu0+NAEMEdpVrSw==
X-Received: by 2002:a05:6a20:a115:b0:1b1:e7de:4d36 with SMTP id
 adf61e73a8af0-1b26f0f1b28mr9232152637.2.1717413484743; 
 Mon, 03 Jun 2024 04:18:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:18:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexei Filippov <alexei.filippov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL v2 22/27] target/riscv: do not set mtval2 for non guest-page
 faults
Date: Mon,  3 Jun 2024 21:16:38 +1000
Message-ID: <20240603111643.258712-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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



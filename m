Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695BFC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2V-0003Lc-Ae; Wed, 01 Jul 2026 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2T-0003Ex-TB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:29 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2S-0004oj-EJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:29 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-137335bc3caso975357c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901167; x=1783505967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp72y72ZYgpjZ3El6NcBALD3KeSi/ftqY/n9UJcn88E=;
 b=b/oFCE/e++H8s/tSKxF/Ktlx1cfiRpv1OdtDX4sdxx24hC0LuGLFkzQiI+IporD8De
 Xr252wwO1h4LmImqDopuD3HL8WPvqg3Mce1ZH7vguIgsd4TkNVQvcq6tzdzhVobQN99E
 Va2ZrdtmzIJhGkBXPBHWhb6IGkWsjN5R0cPxbBP0Zl3hYhs25ZksVzLTy76hcvCDPG6e
 XKBVRkA57HLoZgXyfCXUIa7992oT3/EyDvDa3w7DPZ1g078rnZHTCMyQizS2p50DS3wC
 btPiwQwKL4VNB+6VcwOknDw/pTWCCSwx9ZLe2nwGmHLegp8dSGiEuZDyxfJxZIoVqv1e
 KC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901167; x=1783505967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lp72y72ZYgpjZ3El6NcBALD3KeSi/ftqY/n9UJcn88E=;
 b=SSjSHEGAOvqpGYM5h5Jo6hM4RVFIr6BIQnG38VqXzGj47sWQxsWWWSHm3DyImJcN+G
 Yvo31G/P/ba1RUXBSETNtPzavjL+zu5goqw6sX9u2TeLnoL02zSzGLdBrjlfyMma3Mfn
 SsrkICNgVBauDvlJr+3P0zUlZg6HsT/Z3Phg6mCA7bpGuyIba1WIBGDSVrriX7qAl5Ft
 hKuWdlsFCsRu5SD7j29f3TkOwNW3MQR3M8RPsSq/UsluWJQEOo796vamgiRRugVRFUxb
 sZpYyS+38DyPFg5VWNv1wdszV/gikM9LwPuJARW1wJELJPyzElTfxe0cMqDVoGKtY8KE
 i7iw==
X-Gm-Message-State: AOJu0YxK5dvj08pYMa/RNqSQ3BJB0gnF/o8z9b+z3aUBQNR/xPWLSMWv
 LQt0zzvp8b8MlO3XCU0O0kT5nrV5q+xhcXer6VnO91UoGyyXEDOy5jymAKMurg==
X-Gm-Gg: AfdE7cn3CD9Kie7YsIbmf3nv7VyQg+/k2LRqTZYoXCnyhmuxqBpcbf/Tp4No+I5YA/4
 mF+LEc9CACyLBpi8H2doOcHI1HLKvxqqugu9Jg2KibfSNmjB4j7iM3M7bfMV9ACqk3On2tuORHH
 lfzf7t14fDbf6y5ZNwmhjPCTCWy3dQ1IPEId44z2Aj6JWSbpk8cf45PZKbVfiYNvRiv0k7r66AK
 IAuWcYJw9BF58b3s14shtApt3WRr3BMtUctlhhrV+FepoFSoCU/KKg0en34/emKSJ3y9wkdz5dp
 kmAZanlJlgIpNCy1MENUMywMGAQQIiotqQLYF9AwORkU4Gy+IDejsx1m83ou1/miUSyj6BKJMo7
 +OmixC5LjezZCC+9LdTKSe0E4teqLuQAn/3EjNLzsR2PxohAXDQ0vAdMD1SavbPw+T0xwBXzxYR
 J1V5+1JRHb1DGSpK54hhJwP5zx91BfF9I=
X-Received: by 2002:a05:7022:1287:b0:138:1130:5fd3 with SMTP id
 a92af1059eb24-13b39105ddbmr184858c88.10.1782901166730; 
 Wed, 01 Jul 2026 03:19:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Inochi Amaoto <inochiama@gmail.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/39] target/riscv: Check PMP before updating PTE
Date: Wed,  1 Jul 2026 20:17:39 +1000
Message-ID: <20260701101752.2522962-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Inochi Amaoto <inochiama@gmail.com>

According to the RISC-V spec, the PTE update is a supervisor write
operations, and it should also follow the CPU PMP configuration like
the PTE read.

Cc: qemu-stable@nongnu.org
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260622113402.563196-1-inochiama@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 59edcdd370..2db07f5dfb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1655,10 +1655,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
+        int pmp_prot, pmp_ret;
+
         if (!adue) {
             return TRANSLATE_FAIL;
         }
 
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_PMP_FAIL;
+        }
+
         /*
          * - if accessed or dirty bits need updating, and the PTE is
          *   in RAM, then we do so atomically with a compare and swap.
-- 
2.54.0



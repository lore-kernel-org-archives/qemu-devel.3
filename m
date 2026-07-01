Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFBEC44500
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1S-0007um-2n; Wed, 01 Jul 2026 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1I-0007tD-FN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:19 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1F-0004NS-5L
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:15 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-137335bc3caso973803c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901091; x=1783505891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUwEwMNsdOnQXvI4sKTKgIiKNo/dHs30yRWt8rLVeEs=;
 b=shOYFK2EyKLTSNEz1/wg0KXPQn9S0NRf/ecP+lL76JTKc8/UQDmGeBbx9y73xSYEpo
 LkWGDmPKQFjWup6ZXUGGWkhNqf2S7aD9YahQOr2rfMz19m2vX3i8JwrDK5FIAZi8Ncy9
 C0scm5j1BfBo/IbUbmjnj1a1/ZeidbMXy3XDSQvDAX3mFORVqh3oEHbOfbIVIzZxvuJi
 uF8REK1oy24bSdiam41Ya6dTPgFCLrZyZvirm0r74mhzFkUxKyKxXkxjMFsu8KeI9Eno
 s+SAQbQfOtkW20NneleHRs6pQaNBMuF2SXUrU/VrKBulUrecu5e7rOyPf7Yd9mCttIrN
 +wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901091; x=1783505891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sUwEwMNsdOnQXvI4sKTKgIiKNo/dHs30yRWt8rLVeEs=;
 b=W9+T3dYWpMRiE1DtK6w9iDooGNyeCgMfXvZrnj5OeAfOJqDmpQ5ocH5sgzEMAMN/Mw
 utPs9jEFEzCrpzdwttfDnMRALCNbiNwn2xd/r1Tm5Xh3/NTgMi1NMFwMCX9iCvR/K3OO
 L5WJsVZcahWoGt3mxKbFpzTcfMZJVQ9WSHHB1qJk/oVuY/kRFwfZ5n3g2aCb0iabEAR0
 gDn23k6Uq5nBbrW45FgwtHc6kOR+Vch0evOq1kzyk31lofo0VsaCKZ27Igc9Zqs1pUti
 P4Iz/nUpdzTS60B1dJIEdOZP2Htw44K3jA/qYYNscq8Caq+bH3RMzJ53cpSngexHZvci
 RCnw==
X-Gm-Message-State: AOJu0Yxb6h24+kp41tehHKOQe6Uq9QWr9sRAVqrvNYlvLcML/3fbsYKl
 EzaZwGjWLnfZ8oCqCtaLqx1UJZg+rUY6dKNKEQZfxb/Sp2dk2yGuT4IWG+234w==
X-Gm-Gg: AfdE7cmbYFoPsvz6Kpq50DVatl11v59ANU0Oeh5qnUrmsIRMOEFDUAbndh2CgFvn0Tj
 QexYOAELoExKDS7seL6fAOo3tsom0YW+jJTb+RlCa6HBUmcaSrvrg47tJlyyqSigMGLZ8XvNUig
 ZW7OWJYzIosB6sXacPuBON+1AbiPq+7M+iJRAGYeWO/geEyFdRojeWI0cd6kWEkBbJoz1xBQ5WS
 Z/h70JQBe85RZcy/rDtnrq7xEYodTeHSBrIdl8HwA5bs7uJv8Hq2UvTABOGsIWBFT6++049ElzB
 qb8ubk7x5GBKxSXPoJOxACdVQbkN2ZBEOVU6VYreR1h54WTAxeHiiQIMvzdAnMm9QwTqucx7fey
 UufF0IMC0xVT6sJ2/dLh0YcLiHErFnrxf2HiYldH2o2riqWMzB/WvPJlBB7yaI92okeRKnNdjS6
 EcRQAd8Om3sG4Hs+ZgLr8IU2duuRu01bM=
X-Received: by 2002:a05:7022:4595:b0:134:feba:401 with SMTP id
 a92af1059eb24-13b3916e058mr188860c88.37.1782901091319; 
 Wed, 01 Jul 2026 03:18:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 01/39] target/riscv: Avoid NULL deref in IMSIC CSR write
Date: Wed,  1 Jul 2026 20:17:14 +1000
Message-ID: <20260701101752.2522962-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

rmw_xireg_aia() and rmw_xtopei() were changed to store the IMSIC
callback's value in a local before passing it back to the caller.
For write only CSR accesses that pointer is NULL, causing a crash when
guest programs write to xireg or xtopei, such as when the guest sets up
the IMSIC.

This only happens when setting aia=aplic-imsic so none of the existing
boot tests caught it.

Fix it by guarding the pointer dereference as done for other CSRs.

Fixes: 63469ad75dcc ("target/riscv: Fix arguments to board IMSIC emulation callbacks")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260617054034.1020724-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dd9726fcf4..dd790d5bef 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2733,7 +2733,9 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
                                     AIA_MAKE_IREG(isel, priv, virt, vgein,
                                                   riscv_cpu_mxl_bits(env)),
                                     &wide_val, new_val, wr_mask);
-            *val = wide_val;
+            if (val) {
+                *val = wide_val;
+            }
         }
     } else {
         isel_reserved = true;
@@ -3009,7 +3011,9 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
                     AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein,
                                   riscv_cpu_mxl_bits(env)),
                     &wide_val, new_val, wr_mask);
-    *val = wide_val;
+    if (val) {
+        *val = wide_val;
+    }
 
 done:
     if (ret) {
-- 
2.54.0



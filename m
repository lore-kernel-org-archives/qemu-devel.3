Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E1D68B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdD6-0005kU-3H; Thu, 14 Nov 2024 12:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBdCL-00058V-RQ; Thu, 14 Nov 2024 12:00:06 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1tBdCK-0002oa-2A; Thu, 14 Nov 2024 12:00:01 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ff5edabf02so2954041fa.0; 
 Thu, 14 Nov 2024 08:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731603598; x=1732208398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QidHyKIR/8KXX90H2PkoPiSmqSziZyUxaQk/K/KgwY=;
 b=j0sd3B7ZGyPVEg8fvPEtHvWTaEJDYkHltb+Cob5XH1nLgWjB+J8ZpW1ov2mwFF3JI7
 sqj/bI9nHhIdugVKyqZjEfwhxXICcZ6l8fxzJWHsL6WqgibfPXB8AjPCshphE7nKqOEw
 IR/ClwL50uDSWvUkZLbRihg6Xa+2SJBIdaNshWq3Fo0A1A3g+m4qq4oSLMZlaut7EqsE
 Vv2g9g0h5ZZ81qaHISGIBkUR7tpBEMxbEhw5Jf1zJH9khPuKYjf75TZlogQeA6Sl+dPW
 x6qnzbHEhX2WtZB0bWPb55XxkOpB38qj2z+lEFgTtLBFO/d4RQHaghl7dOOnURvVCEQk
 n1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731603598; x=1732208398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QidHyKIR/8KXX90H2PkoPiSmqSziZyUxaQk/K/KgwY=;
 b=JybWv0qGH3T24fp7hW4xC2Vdlzl4cXkdy7wZqbGvyCECCPPj1C0N7roaF3T5eKTxTy
 hQDeOIr+geiSjVzO6zDPluvHFlfSkw6ZR4etYKhPztPiDl2hYZ+ckofO8MBFKfpiamll
 rW7N+wVVOisIzMiaMnuSKGWEB6coNteOfdMt+LpJXA/r298fOgl3VRbR3BpUIKYXNq3c
 BzVmZ4Gqm5stfHkIyu0M8aN9BNaPkO4Vg5LdhPA35+2NRb/Ta5QbAcP8qYpSP3uwj9Ic
 Oxy9jaJY9DgLpDzn5D64OpGXm9brZq7t/esCHqLKMsiUJvl529LL6ZEd2zFuhoQTZVPQ
 Id/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSf4XlXHTalDbeZ05pFLXvA+2zogNnz9+S/CkPIbGQMQxhlYi630PcqOxXmAkxiEv6zT4lrFEVsMR@nongnu.org
X-Gm-Message-State: AOJu0YzTvnh9onWZMzTV7ayW50fhkrLP7kexAFGItCROhBeIHT+J7wmh
 gSjXDWLmICr4avILFh/z4G+TSJn1fOVXbJ27oaVIGuE4piJAAvg0IjxEC16jANg=
X-Google-Smtp-Source: AGHT+IESRot7UJLotm8zl3hw5ABjYSLGxj0hWebYfOuHi3JNx2erTY6B+ZkSMKsfyx8HKxd3W4p/DA==
X-Received: by 2002:a2e:b8d5:0:b0:2f9:cc40:6afe with SMTP id
 38308e7fff4ca-2ff2021ed1dmr114865101fa.14.1731603597578; 
 Thu, 14 Nov 2024 08:59:57 -0800 (PST)
Received: from fedora.. ([2a00:1370:8180:90b:6639:2dc0:6fb5:8401])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff598907aesm2346701fa.100.2024.11.14.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:59:55 -0800 (PST)
From: Pavel Skripkin <paskripkin@gmail.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 2/2] arm/ptw: respect sctlr.{u}wxn in get_phys_addr_v6
Date: Thu, 14 Nov 2024 19:59:53 +0300
Message-ID: <20241114165953.6894-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241114165900.6399-1-paskripkin@gmail.com>
References: <20241114165900.6399-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=paskripkin@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

get_phys_addr_v6() is used for decoding armv7's short descriptor format.
Based on ARM ARM AArch32.S1SDHasPermissionsFault(), WXN should be
respected in !LPAE mode as well.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 target/arm/ptw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2a3933adec..892932620e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1169,6 +1169,8 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
     uint32_t dacr;
     bool ns;
     int user_prot;
+    int wxn = arm_wxn_enabled(env, mmu_idx);
+    int uwxn = arm_uwxn_enabled(env, mmu_idx);
 
     /* Pagetable walk.  */
     /* Lookup l1 descriptor.  */
@@ -1288,6 +1290,15 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         if (result->f.prot && !xn) {
             result->f.prot |= PAGE_EXEC;
         }
+
+        if (result->f.prot & PAGE_WRITE) {
+            /* WXN works for PL1&0, while UWXN only for PL0. */
+            if (wxn)
+                result->f.prot &= ~PAGE_EXEC;
+            if (uwxn && regime_is_user(env, mmu_idx))
+                result->f.prot &= ~PAGE_EXEC;
+        }
+
         if (!(result->f.prot & (1 << access_type))) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
-- 
2.46.0



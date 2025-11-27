Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8A2D116E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPdA-0002nP-Dx; Wed, 26 Nov 2025 19:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ipcnaQcKCqcUHcPKLTNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--navidem.bounces.google.com>)
 id 1vOPd8-0002mf-Dj
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:02 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ipcnaQcKCqcUHcPKLTNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--navidem.bounces.google.com>)
 id 1vOPd6-0005zQ-Tc
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:02 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-343823be748so238166a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202379; x=1764807179; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qogo5XeCyONqmCex4kreHDGd7JJBizCMCbTlMRm4Tt4=;
 b=GmF5UXyQGr+eyeRd4gZBnbApoM9qsZvH+/WAJD3N9UKMTxLEnpyHhaL89U2PFV3k/6
 CSIXd7GQWfB/Wzh8xsVEfO0o3ub+4qNigxWylp6fPfAvvJmC5u/qF+E2aW+yiB9dnoNT
 MwQXuUGOcHUx1xpOd5HYNRxjrILHQRXuv2bkpGEZupL++Ysygblpydli2i30SDC3MuEV
 P6EnjI/RQaeff2jmbPupT7LkEYXwqYRHbsZbs7hwDX6mtNw+inKNnzRrKI3jE3TttGxT
 np6QRZONs+wl2YJf9M79lB4XwcSiIiaoR0Fp9ctuuGMom1CDeXDl4e2aZ70yuZrBwlb2
 0IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202379; x=1764807179;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qogo5XeCyONqmCex4kreHDGd7JJBizCMCbTlMRm4Tt4=;
 b=xBDDw+LizklY73THer2Qn8BRYoEGGosp3CIbLGqPmqGlqUjAQtp+81H1QdsNdJd6uT
 ysdCZeC78+u+Yb/B864n4niUlqkGmNdY7cVb/kQp8ocUSBW7cGptJp6fgr5lOmT/3Kkq
 NVNoaHX5vOpNS/5ihsOGRDEYtKhVUvC2VyAcDYTEJPdILEE3r5taD/QQjCSasE2N965y
 G/3V63eqW7reoUOUnd3I6sRkdsvIZ4ywAnqmewDm3C5iv7ZjQP6imKI3uGv6RMnpV0q/
 tt7nVw8dIxnZPBAtMGWg8ZtNz6sUeiSUyptbnP3KOoWOdVDF6UV/NP5kDkA5I6aS1M9f
 pORQ==
X-Gm-Message-State: AOJu0YwLcRpjsUrNK4gD08a2/78aPnTOHOS92zrD6wQmojsQufCY0COC
 gCRQLpCcRoKhn03Ya0I8gustMSsd8a7J1zPd5/ufUyOqLIemLW+8gBEQWV1/KUr76xOwn3LK+Yo
 o++0ftpHScWM0L6sb4jyw5KP1ADi6APd9QzjMZ5U+5l2cjSrcrTYc2sGgUDTjZEMND9QzC35f+Y
 sJKFrFGCOrAy64zFitfk/IU1RCJ/27Cl6lgHuOVT0u
X-Google-Smtp-Source: AGHT+IG7BttCfwkZnLZRj5hNQkC6oUAMELQk7TcVFb45kIvnBHNlYnvtCxBYFNPPvmC9SBhg9wowIcKYLgZk
X-Received: from pjbsh16.prod.google.com ([2002:a17:90b:5250:b0:33b:b0fe:e54d])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a4e:b0:341:2150:4856
 with SMTP id 98e67ed59e1d1-3475ed50953mr9253879a91.17.1764202378738; Wed, 26
 Nov 2025 16:12:58 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:45 +0000
In-Reply-To: <20251127001247.1672873-1-navidem@google.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-4-navidem@google.com>
Subject: [PATCH v2 3/5] tests/qtest: ahci-test: Check only implemented ports
 in verify_state
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>,
 John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3ipcnaQcKCqcUHcPKLTNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--navidem.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The verify_state helper function in ahci-test.c incorrectly
assumed that all 32 potential AHCI ports were implemented. During post-
migration checks, it would loop through all 32 ports, attempting to
read registers for non-existent ones.
This resulted in an out-of-bounds access on the main HBA BAR. This
latent bug was exposed by the recent introduction of strict bounds
checking in the libqos PCI accessors, which now correctly triggers a
fatal assertion.
Fix this by modifying the loop in verify_state to first read the
AHCI_PI (Ports Implemented) register and then only check the state
for ports that the device reports as present.

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/ahci-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f..06c5bd08d8 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -81,6 +81,7 @@ static void string_bswap16(uint16_t *s, size_t bytes)
 static void verify_state(AHCIQState *ahci, uint64_t hba_old)
 {
     int i, j;
+    uint32_t ports_impl;
     uint32_t ahci_fingerprint;
     uint64_t hba_base;
     AHCICommandHeader cmd;
@@ -99,7 +100,14 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     g_assert_cmphex(ahci_rreg(ahci, AHCI_CAP), ==, ahci->cap);
     g_assert_cmphex(ahci_rreg(ahci, AHCI_CAP2), ==, ahci->cap2);
 
+    ports_impl = ahci_rreg(ahci, AHCI_PI);
+
     for (i = 0; i < 32; i++) {
+
+        if (!(ports_impl & (1 << i))) {
+            continue; /* Skip unimplemented ports */
+        }
+
         g_assert_cmphex(ahci_px_rreg(ahci, i, AHCI_PX_FB), ==,
                         ahci->port[i].fb);
         g_assert_cmphex(ahci_px_rreg(ahci, i, AHCI_PX_CLB), ==,
-- 
2.52.0.158.g65b55ccf14-goog



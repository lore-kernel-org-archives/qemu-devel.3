Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5884EC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 16:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbmK-0007Ty-W3; Mon, 24 Feb 2025 11:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tmbmI-0007TO-Tr; Mon, 24 Feb 2025 11:57:59 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tmbmH-0002pA-Dn; Mon, 24 Feb 2025 11:57:58 -0500
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-221057b6ac4so89076025ad.2; 
 Mon, 24 Feb 2025 08:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740416275; x=1741021075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3dWlk7xDgb1CUcA/8KFyJ9yfBRx9gna7Q3yZXDSfHSo=;
 b=kyq9evOtOwIbCrJS3A3sQnJZINc/YanY4WuXcmA2YTkAofFMGOShl547XwmkTvqsG1
 iWLjYFF+kgXhPApAFI6q9R78rDlSMywDAU3xz0psPYzu7jXeXMPZvYSbznJ8SjACUc5W
 zgaZ3jcNyDSNwyTuPGtf/PL/1yhcpfsU33oIHcSqtRCMYew25T61r1NjdSUJbn7ukasT
 ptzwx9BaNjlo27m7pTxziNeRKf4Sk0xNff5AW2Cc8+XlX/gCaDaVfsi93gGKTDS3TKWK
 Gl4j9B+uoynQCmcX4bx/oF+2v/X9uDO8KpgCxJJfN0UbB3XReCsxRtd4r4JU28qMKYEt
 KFYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXgiALWhAZdjCfIbyyCaiete1wJNOc8phZDeNbLCEFWqkvMejLqM8uYfu2Ht1ImUp/6/gil6j4Uw==@nongnu.org
X-Gm-Message-State: AOJu0YxhRnkeg03uA1SDoFIMo75Rtd5ywOpgzCy9G+V0empGApcMr321
 7nj49R/nAPr52OZ33mnhQ5bNap0y6bqU83MjptdYh28BhZsoo77ZAVD6ZQ==
X-Gm-Gg: ASbGnctvbb/j+HMJPLsc4N786VREUK/gecEPQRHa4uuD0aJAI7lepakFD5CsKKupCKB
 Fl1yE94O0NQ6pAUvkahljmRu1Pez/1MIa5WLgYvsTGvR5U2r7JaJyTPTOLy9Isvd0sETdZhLbC2
 i3i1BBkY27DWWAEKhq6ViUK5mUmVcT4vBsFSiDpkonEWm4ECvpW8w+9y3MHEREzYU4LOlIce7Xi
 AZteAuAQAROllTbp6a+r92/fyjzKt7zgEntaYHloMkSvTK/ztYEJtTVEtSidDHFvvirqtuCxtEi
 g5bXdJWCzthCB3ui0gyAfTJgWWk6OOAwhunVK6hC/c90uPUnTTQqSMrBaw==
X-Google-Smtp-Source: AGHT+IFO+MvrP0qJP77F2BdXDHjplwptesjMA2Tszs+8ggzBtN3vfUEGSxULBDb+5W8PE1wsJwIx3w==
X-Received: by 2002:a05:6a20:8407:b0:1ee:e785:a082 with SMTP id
 adf61e73a8af0-1eef52c926bmr25147289637.1.1740416274861; 
 Mon, 24 Feb 2025 08:57:54 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:370f:48e2:5d68:7347:53fe:9673])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ae07fec1f8esm12845795a12.28.2025.02.24.08.57.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Feb 2025 08:57:54 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] hvf: arm: disable SME feature
Date: Mon, 24 Feb 2025 08:57:34 -0800
Message-ID: <20250224165735.36792-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.170; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f170.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

macOS 15.2's Hypervisor.framework exposes SME feature on M4 Macs.
However, HVF does not properly support it yet causing QEMU to
fail to start when HVF accelerator is used on these systems.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 target/arm/hvf/hvf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e..261db2d227 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -899,6 +899,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
 
+    /*
+     * Disable SME which is not properly handled by QEMU yet
+     */
+    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.41.0



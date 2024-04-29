Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AE9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hdr-0000ke-20; Sun, 28 Apr 2024 23:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ExMvZggKCi4cWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com>)
 id 1s1Hde-0000Xn-PN
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:10 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ExMvZggKCi4cWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com>)
 id 1s1Hdd-0004ER-1Z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:10 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-de5a8638579so4268915276.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361107; x=1714965907; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=q94uWS1YQXHoDg0rgHPsnmyBhsFRL1jhexQXc24g9Qw=;
 b=xiRCY/VRWr1/IuocvZbjk1nGokwMshNIIutWngbhbBNnoxHJUd928+PWjRN/wexDZA
 KvlqjjOhxafClhPhFDunFXPxZSv8jM0KHEOxC/vUW4EvbisKkcnozH8LkyZknNVDBfSO
 FKLBOF+6Y0vFqzCv4u7G3YQtLCn3mN3LDgXtF1kR2Rt3HBUG71kHoV6aEPPR785xgqOv
 j8rS490CR6feEduz3EXokkch4UqJ1XPYm9mXukIG8xPv9TNL4QUhR9f0HWlcj2YUzAnN
 4FtO1/wL26EGcznR/teGCoPgSh/1RNDjyNb5d+Ppd7C/SFM2FxJ2H/5SFDQkmjSCYUVK
 i/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361107; x=1714965907;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q94uWS1YQXHoDg0rgHPsnmyBhsFRL1jhexQXc24g9Qw=;
 b=Y2jeUp73Fy+m+nwxcpZGuBqD9xGt4pYKZJYEUMvBtGAnvbkYLe86OKjAPO5dIWC8Vy
 Cxk7/7WnK+PhcVFMulfa7aKyAspJNgzRq5S3t1Qjtr/oQzMwUc/aGrtnG1XvoSW4gcy0
 TTacmhFP1fnwWUW5k0fvKNS2Oav3FymR2olWOgBDyECT0LLtffmOXpNaMkbfXrs5plee
 Do/3TvV6svYWBssOIaR2j+cizgFAK8ElKgG2dteKSmE2WNLAEFKdpxTqxqP0Hlzg+xDi
 jc0oltTLDa45QL6EoLx3LbpkQFp6GqhbVFAQylSEpMqtC5v/Abo+m6YppXxXsjGFxYyO
 XPWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOV3gkpzrG3yV+0t1DEf9br09BmS2PPlQOBN03hDltUKbwR6XzuFVOg9XRCi44NhcIk/8Zdra41kxLvoTeFAG+LxvsjE=
X-Gm-Message-State: AOJu0YwhHoZWHSc04bo4A3H3eMjURNRC30Mwegx+RppqVv47HdFYICqJ
 wo1DrXjIYdnbUg2j+Obdyp7tG20k0ed7tx32wBd9Dr8erDwj1G67xbux4HeIImbQVmI+0PgAhgS
 0qDM/Z3lI8w==
X-Google-Smtp-Source: AGHT+IFzjdp0ZFh+5foz0mnbvtgE1awhtYue+fJ/8/OHkDVv5HMZ11PEbTlWGFgZAJns8v0t5tc1xyQJL4Xp0w==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1006:b0:dcd:3a37:65 with SMTP id
 w6-20020a056902100600b00dcd3a370065mr988183ybt.7.1714361107332; Sun, 28 Apr
 2024 20:25:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:59 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-16-smostafa@google.com>
Subject: [RFC PATCH v3 15/18] hw/arm/smmuv3: Advertise S2FWB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3ExMvZggKCi4cWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

QEMU doesn's support memory attributes, so FWB is NOP, this
might change in the future if memory attributre would be supported.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 88f6473d33..8a11e41144 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -287,6 +287,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
     if (FIELD_EX32(s->idr[0], IDR0, S2P)) {
         /* XNX is a stage-2-specific feature */
         s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
+        if (FIELD_EX32(s->idr[0], IDR0, S1P)) {
+            /*
+             * QEMU doesn's support memory attributes, so FWB is NOP, this
+             * might change in the future if memory attributre would be
+             * supported.
+             */
+           s->idr[3] = FIELD_DP32(s->idr[3], IDR3, FWB, 1);
+        }
     }
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
-- 
2.44.0.769.g3c40516874-goog



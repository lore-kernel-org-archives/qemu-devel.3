Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BAFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEoY-00023v-JP; Mon, 01 Jul 2024 07:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <37IyCZggKCks5z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1sOEoW-000236-Am
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:16 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <37IyCZggKCks5z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1sOEoS-0005BH-Ak
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:15 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4256c2a2e8dso21167715e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831788; x=1720436588; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=qxpHwQ7ZLe0+eKBQXYl3PeRw1kiPzmlmXkdnv1EDlyk=;
 b=3lOJn3bhORHz3+XtgnIZD905VcwnI8TLSTihnndc1efzMKZ9KFETEuY6CvR7b96ENY
 sTQV9olLheihyZLoeUJaDkZPsoXEtqFt0FiGZtZuU3mH+F1VE0+E+g02BmGJWWYh/UA0
 jrAM7KZwl0pP4mgFpXMmx4MlIrwVS64yQTxbovJLbvGv+lD+F8oz0sBUxmMVMml9ezJr
 zE5p3ah51lAM/reeerdJqepkcBg0fqfYjN4fmE+O7+IRSivAcbERBmhYrS+4eVHTpxTN
 AL1oTGexCPS0l2uKsQ6nNVlaghz2Eqmsn3rCsbxJlO72tgGQCRTXw5jzzdCaDDvsuhQm
 9E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831788; x=1720436588;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qxpHwQ7ZLe0+eKBQXYl3PeRw1kiPzmlmXkdnv1EDlyk=;
 b=vkwRh+haRwlps5XXh55lkyBCyFx4KTuAN0/4neVhQfjltbfX0uI7xQ3MTGhGKh8qz/
 s1Hp0LNxIVpMmvK8HvfzBzxM9JvXMcbSioKhFSGya8vN1IwGdh4788zuW7YFnHYYMepQ
 x8VAHF90/ufVdF6yoshTmobh+C4oigsra9TYThJso1m6Qm758G2pYsNbVpHYy202FlHQ
 xfpZuQq8rDjSt3tAMHnBUr8p4AK8yZrAneJvT7QpbtQzWBmBjw/H4/07IM1C1EPMYsUw
 Isw6Ge+M8949ehfJwE6kUsY8NpDiUUfQ/QKWljcC9TGkSoWCAVJXhYgsnyxnOiSx9Pqr
 I94Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX4Wa23nxI3rQbG5ktypHq4Yh7PadG5Dp0bP6IyEHZHVvs5CXuZnCko4yAvu55SmwQmmZH0WPwi3WgFxcFuQnw7m8wvXU=
X-Gm-Message-State: AOJu0Yw1O8cxeVh3s0e6ItPt31tZbTjHfMgGJNBGklQVBxDvT/KnzcMN
 u3lZVGgNvSQbj637L3EUpTr91xA7LBYPZosF/FnK/Oor6whkenK9zuPuKm/yeSF7zplD6P5e5vz
 UkqHL/e4AcQ==
X-Google-Smtp-Source: AGHT+IF8cxj1aSXEUWa68rT0Cuu9AhGmCho3GCpbqZvCZuxtG5rXVQ/+ZoV0t+qybSSVhA28kmzbKU77w3buAg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:1d0f:b0:425:7ac6:96f8 with SMTP
 id 5b1f17b1804b1-4257ac6994amr138575e9.0.1719831788201; Mon, 01 Jul 2024
 04:03:08 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:23 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-2-smostafa@google.com>
Subject: [PATCH v4 01/19] hw/arm/smmu-common: Add missing size check for
 stage-1
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=37IyCZggKCks5z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

According to the SMMU architecture specification (ARM IHI 0070 F.b),
in =E2=80=9C3.4 Address sizes=E2=80=9D
    The address output from the translation causes a stage 1 Address Size
    fault if it exceeds the range of the effective IPA size for the given C=
D.

However, this check was missing.

There is already a similar check for stage-2 against effective PA.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1ce706bf94..eb2356bc35 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -381,6 +381,16 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
             goto error;
         }
=20
+        /*
+         * The address output from the translation causes a stage 1 Addres=
s
+         * Size fault if it exceeds the range of the effective IPA size fo=
r
+         * the given CD.
+         */
+        if (gpa >=3D (1ULL << cfg->oas)) {
+            info->type =3D SMMU_PTW_ERR_ADDR_SIZE;
+            goto error;
+        }
+
         tlbe->entry.translated_addr =3D gpa;
         tlbe->entry.iova =3D iova & ~mask;
         tlbe->entry.addr_mask =3D mask;
--=20
2.45.2.803.g4e1b14247a-goog



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B28C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hd9-0000H1-Qg; Sun, 28 Apr 2024 23:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38hIvZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1s1Hd8-0000Fg-B8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:38 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38hIvZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1s1Hd6-0003vv-Rb
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:38 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-34d0be5b688so408635f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361074; x=1714965874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=t4fDtAqBHvik6c00yf3CE8uzzU6Ock9eQkwSvIwh/JI=;
 b=VYTsKj1MxfrkE/NB+hB1rpVg5xx+Y19Vh2c67NMRdYj/lci36sT97uuF1cCGyrFCKa
 1cyq73A3RsKQHVtiu2InoIsZFufn/2VC745Mmo0ykkilaTpRjd7BTiL6ZE9B1DXRq0xR
 C6CNJechPAOFUsj8nspJXhOi1QGQEhfbI9MOY4P5jbg+JaCHv3Yj1PwCQ8eFHj3VepsI
 SbiUqPcHiRurld7ITkkgWz+byvrfNLSFRZ8fHjX4WfLuXNBjK84WghO8kfnPs6CYsNlW
 vTP8vE+IfMz38uq/e4k6IK0wL6W20UJLkXU2xSmnQQGuj71TK6+WGX04qfEQTjLWU2m4
 chbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361074; x=1714965874;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t4fDtAqBHvik6c00yf3CE8uzzU6Ock9eQkwSvIwh/JI=;
 b=hQZDw/UaPqGLwTzUxgvRlHQ7IbFiYhLNrewQFqfU51BAogI7ucxEgdEaLpZ6dEkMIT
 Gw/dHyeffwceAVKbTs6XEmrieAix0hkDYw7GVpqAixclQYFrZKeIrrXcXswBSy/X91fB
 ETpMR6irDQ8DnQjlyctsfhz8hurZFiCk+RCiP8EmCiJe2IjUXYrcb/fZlq8UWbKmS6Ds
 /AnV1jxEkfbdUDbtPdDwL4X5hZKPuAxOstLN6io8xjlLVD+uuhRYDmMHXrq5hS1gxbN2
 vXREBQESpZwgIgkp4XfkmM0Ar+u+D+X/iNYC5txFPl4uS9O1VM5bzky69URBHx/KAS7g
 GGxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW+UkBEd3qMSVfJvNBTpGc/UsUNysqygwsg2IWIJM3tAIKCHSutR+0ARqj1UBehxGa/IGdkLhp03l1p92/3r5xs/UWOjQ=
X-Gm-Message-State: AOJu0Yw5VR5Ay4IeIdjfeTAb1p5uuiflwZExm8oZVuW36HLwyEBgFp7B
 my9rS2eJlLoxzzJpbx9N9UsFkkc7I/FdYj40VJOzrBjjxCTp1pI6AMcloFGA1CBECp62WZevt/V
 iwL8jTBkyxA==
X-Google-Smtp-Source: AGHT+IHTewv4ewCx2m33Lu518GlLek76sLkfFW/hEqOUcoHrf5P5HmaSPCpCKExWDpHRXQP+CcFHQkwLBZtonQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:1212:b0:34a:6e5b:6c37 with SMTP
 id e18-20020a056000121200b0034a6e5b6c37mr19534wrx.10.1714361074056; Sun, 28
 Apr 2024 20:24:34 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:45 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-2-smostafa@google.com>
Subject: [RFC PATCH v3 01/18] hw/arm/smmu-common: Add missing size check for
 stage-1
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=38hIvZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
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
2.44.0.769.g3c40516874-goog



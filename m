Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094FFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL1-00046N-O6; Mon, 15 Jul 2024 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qeGUZggKCvouoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com>)
 id 1sTHL0-00040l-BG
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:38 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qeGUZggKCvouoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com>)
 id 1sTHKu-000415-9H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:38 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03b3f48c65so7048300276.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033130; x=1721637930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=xKw3mGktA92OXzn4f9adqHYmUJCgi3sm+YL6zF4rMAc=;
 b=eemPsofqFojIQcrZ6M23/JiO1riJb2ZPxFhBlbZxr2oupYrVlJEku18y4B0XrfFQHS
 ahkZcyL7M5c6xOGh+JbazTqgw76MIjCKoly6DKlpB78opH0e+IoLV+maOfdnpTItKhKV
 BQUpgPT6shbqGZLX7WDW3rvjXHeDCtJQ5QOSHMAMWD2LCiotXnyDZkfzECGXZcBMiu1l
 vxVx7fGbjwwVf755y0PBd4KxCoLz+XY/8qSNVZ29x6gHE0d9gQkmLqprHBiQbHtDwN8X
 roPazfLQrRAgR5TcJddvCJerat0BkE4tp4301Yw/vGdw+lAxiKQtLl2SAuobTVOrNu5N
 v29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033130; x=1721637930;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xKw3mGktA92OXzn4f9adqHYmUJCgi3sm+YL6zF4rMAc=;
 b=CjIWZdzf7WLl21W5sMZpvJ4EuFFfeYkWiTmH+IIag2FuxcCFmj5NUuJbFzF/w+7SZu
 mWDKeN0caKQ8cXFouBkmowu9cBeXLkdgDrvvuCRW+xVIL0bU86mq77W7h05AYyRgyICL
 NCTrOrldkSHuwAqM+YepVx1Dsp0dnoOBipT62l0g8tP7XeFRyK+/zgKkdO7yqoNScWcQ
 WManJNY5+SpwZysBl9FLM4UDvWzkTRaoslYeHXw5YhvaS3cmMH+xev1g/dZe2rKJtD0s
 q4bmQaXvM+eXnk5dCB1kLPFdgxlIajzCY6i1s2HbzvWjdL5zfFWAl7mplv40YKSN0MCw
 z9dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCyrQcKNY84CKDd4LqMAB3OPMUCaP4K15PWBnOMAAbDLObjcmITXy3ksgcT+O85/m1C1yrzihy56r/XllGAROSjfgc9QI=
X-Gm-Message-State: AOJu0YxYFjJOmnBvNQncU+eJWHeiykYhutrx7MaTOGKlsGB3d4bh7IJP
 YggQtLHwHBVzfo4GoeRkCibY/+WYF8jRIw+bR2oGzL1G0ncL/rB/KWacgM5/dx9LiBeDdD0Fkaf
 diDwO7oqXIg==
X-Google-Smtp-Source: AGHT+IGO0KcFyjN1gRosAk+SCnqkSdSUonL59FPP5CWTEaYBqM6PQ0MfE0m95/y1oqm8vANJpUZqv2OIt8y87g==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:114b:b0:e05:74ca:70ce with SMTP
 id 3f1490d57ef6-e0574ca77fbmr537739276.4.1721033129837; Mon, 15 Jul 2024
 01:45:29 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:01 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-2-smostafa@google.com>
Subject: [PATCH v5 01/18] hw/arm/smmu-common: Add missing size check for
 stage-1
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3qeGUZggKCvouoquvchciqqing.eqosgow-fgxgnpqpipw.qti@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
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
2.45.2.993.g49e7a77208-goog



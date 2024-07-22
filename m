Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1540C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqOW-00045Q-7v; Mon, 22 Jul 2024 06:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ADaeZggKCiEPJLPQ7C7DLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--smostafa.bounces.google.com>)
 id 1sVqOT-00041I-SK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:35:49 -0400
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ADaeZggKCiEPJLPQ7C7DLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--smostafa.bounces.google.com>)
 id 1sVqOS-0005AS-4o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:35:49 -0400
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-a77bfa15f92so305757666b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721644545; x=1722249345; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FaQCOP+IWpEVPIVvBuJpa+7D6aB2VEzvLHq1vpTRfXs=;
 b=qvav7wZBaNGuq4YvPij8WHlQh3r5k4FsWJi4vRvWUcIo7fdhCIgjdpGldqgmD9Avjg
 SJuGOZGirxBqxxRVfP3idW73sflN6roSMLwq7c4m8PwAaFqGwvcHjTPVNurEn548UVes
 d0ZCEj82nnl8YDRrLQXr54bnkRqRXxRcNRyRr3kO1X9upOpZoxzH3Kn2zdpWAkujnCk6
 q0rIBYcLo1lmT7mVvn3fCWpjJ+FXjrvP5JtTnkaGY39uJEN9p2oHuCdh8qaF20mCdzt6
 NqcrmrACAxbdNCMcscWCys+RKh7a9uDB82a64GPOYoyHxj7xA6soHnEsWO/+cI/rDsuH
 kAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721644545; x=1722249345;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaQCOP+IWpEVPIVvBuJpa+7D6aB2VEzvLHq1vpTRfXs=;
 b=IA4KdCsMcQxNEFpxG2rq5RkIe85tWaB3py0z6QMfhA1ijWHo6cRCTlgy4L5Ec3shph
 C9t6EqQ9SWUaxTKVIiaYvqiXrFBxV9DxpV5IaEDc3600mtwrJ44HL2JCsPFmhv2js5Jv
 dZI7uet+w+sJj+cVhP4wXuL8BaU2gvDCzmqjSAlPuU6COUN5QjrSZotyzlkBbCuMQ07L
 p/o9AHXnz0bNXLkfyuhvJmYokMM8feIXdyxniRlvArjACgJQ4LwSCk/6NnlsWK8lnucv
 pBLGgANXOGJLi/gPRhsp67uNvOroXOO7q0r4uwepzYC8eikZs2CAwU/7qV2NTDN1Llkd
 bFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYb7h4R0tR9nw+4A6MydHKdMpXLpOBijmQVr0Qj1L84mD9fJJA3OmCiEaARytiJCR/dYjJbeBP/p7CnWxctqBIgO1fKsU=
X-Gm-Message-State: AOJu0YxHB3z162b9dgVir09M+jru6NQB702qonJq9xX6xTGv6Q8f8zWS
 DAqFZbpHMQmqj7js0GJIhS2qzlP2zkwXS7AFhaJOwrUl4nBVuxx6J2AkS604LuUfJWTI7rkZpM6
 ORviupVQCHg==
X-Google-Smtp-Source: AGHT+IHGSc7TqHAPxj/AKlwqZqRLW2LNNVMh8ymB9w8DFNgK4a8L/K6joP1BAHJ8vPW7m91Re26GnXzngVAHEQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a17:906:5fc6:b0:a77:fadc:6815 with SMTP
 id a640c23a62f3a-a7a41c1d96emr484366b.0.1721644544900; Mon, 22 Jul 2024
 03:35:44 -0700 (PDT)
Date: Mon, 22 Jul 2024 10:35:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240722103531.2377348-1-smostafa@google.com>
Subject: [PATCH] hw/arm/smmuv3: Assert input to oas2bits() is valid
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::649;
 envelope-from=3ADaeZggKCiEPJLPQ7C7DLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--smostafa.bounces.google.com;
 helo=mail-ej1-x649.google.com
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

Coverity has spotted a possible problem with the OAS handling
(CID 1558464), where the error return of oas2bits() -1 is not
checked, which can cause an overflow in oas value.

oas2bits() is only called with valid inputs, harden the function
to assert that.

Reported-By: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com/
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0ebf2eebcf..b6b7399347 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -599,7 +599,8 @@ static inline int oas2bits(int oas_field)
     case 5:
         return 48;
     }
-    return -1;
+
+    g_assert_not_reached();
 }
 
 /* CD fields */
-- 
2.45.2.1089.g2a221341d9-goog



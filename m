Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F7CF31AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXc-0002sW-7m; Wed, 19 Nov 2025 06:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXY-0002qT-8v
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXV-0001tI-N8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:39:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477a219db05so23608385e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552396; x=1764157196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWFmulcyAYLlojJst2j+AUfpLHkRImQzp1f8BUoZkh0=;
 b=njBFHqCFcWk8fA3kN3t/Z7HeBpfu/UA1SawAxtpj/VPwkhIhRu1WyjYRYPGfMoMS3K
 O0P7gcX1B00pn26TqgP0sF9QnPuOrpBagO/WRZ3qtJnRsI+2vB1U5TjQFKR78/6DcOY2
 ng09/HEv5zP0hpG9qcS1qClBTam6thmoLKlepJAEI7oAAacJxW6kaNXDp7WSD6OrSnmg
 iXlmCt6U/rjRKBwl46Kronx6TNMr77LXhFuKycGKsQeF2zfkno5iUsiWkeNdVRb4I7gW
 IZe1gtf98HIFwORNgvP0Gv+s+TwgbS0H7a00BfmgT8Uqh5IgcIzsOiovwdNTahH3ZCMy
 1IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552396; x=1764157196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWFmulcyAYLlojJst2j+AUfpLHkRImQzp1f8BUoZkh0=;
 b=qJNEwmBpk7cir5WNlpVO13mXxpgqXnZRxCZ5GCo7GIk1HazOETRHuBhMdcQ4ohQAXt
 SZ2ozRUjFoefeJUsA/uNRZp55HClXRNBQiRYOvDGe8hrNwU9cGaUStGVeK0MROYnUBpo
 KPpbcYFNWFLNd143b3k3En8Rl+4R8Bw98W5xAJj7EkENPa28GGCpvlwQHgCNvoXRjCYg
 JpmaEZpCPbCJQNod+iiWfiERlC9h9Cx1Uhvhx6KkLLWro9WaWCKZCd7mcY+chikAOgCo
 L6p+BTKDyNZTZJ0+qzJOrq6v1e9TBYdB8HEm7NBob4hRlT421PHM/I3DRoSAuuYaBuDq
 /biA==
X-Gm-Message-State: AOJu0YxjeExDDVTQnTjkP744V2+xHwR53+9xC5fT53DOZN4N11obeYCY
 JyHlHoPasaY5V1HNSGl4VBBaN+JRU4C36aqQ/ojAyaBqitnUIZcDxmNHwuzEyTkL6KH9biYhwaX
 F0goj
X-Gm-Gg: ASbGnctG12X3mRaT79cUAXyEuQw1hdqeNmSkA+ycYwb7npp5tElkDWTxYjdG7Bt9yol
 GF4wz2mU6t2jHq8D5DzmpbnSZKktlx0hlYehw5U25RAC/o4gGwuP+ISleyQ9dGskVfMne1bGvdX
 NwC19BuN1idy/QtCxBhkoWIPGYsEcjwd4gr0AO8Q4E1iYFcsW1UXBMVU9myQ/ApBcyiKDh3Eh6V
 MaNauWB5PDoYpj7v9OhE8End8oBVQOc0Um00UW5OwV9IHo4/rar18NS15oS5J3jTI1bwfQAJSwe
 gcBFYlo0Bt+VhG06Mv3SByemppgsk3NLeTnVrVZGtYrIyHvdzrrv+eZeiN8TWwtJdwL2ylPQIZL
 1S/nlVA/hhc25wpHYodDbkEvMJDUDsyOTxqARvq7ZpeAZFC3Rt1V4NPabOAffi0mBtNxF8iBuuU
 LIlm1Yud9ZR7G/1W1v8j2+fg==
X-Google-Smtp-Source: AGHT+IEwFWkYHUpHzkffJakfjhsSk9CNuwfMQkraAv9bzN95RVtdmw6ykPwoeWiGNqllMHIzYJntEw==
X-Received: by 2002:a05:600c:1d19:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4778feadf96mr176857165e9.29.1763552395619; 
 Wed, 19 Nov 2025 03:39:55 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b103d312sm53639005e9.13.2025.11.19.03.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8085E5F8C1;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 2/9] contrib/gitdm: add group-map for Huawei
Date: Wed, 19 Nov 2025 11:39:45 +0000
Message-ID: <20251119113953.1432303-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

While we do see contributions from the top-level domain some
contributors also post via other addresses.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 contrib/gitdm/group-map-huawei | 5 +++++
 gitdm.config                   | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-huawei

diff --git a/contrib/gitdm/group-map-huawei b/contrib/gitdm/group-map-huawei
new file mode 100644
index 00000000000..c287dd5d2b3
--- /dev/null
+++ b/contrib/gitdm/group-map-huawei
@@ -0,0 +1,5 @@
+#
+# Some Huawei contributors submit via another domain
+#
+
+mchehab+huawei@kernel.org
diff --git a/gitdm.config b/gitdm.config
index 06ac729c7bc..2d75dd4deee 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-amd AMD
 GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
 GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-facebook Facebook
+GroupMap contrib/gitdm/group-map-huawei Huawei
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-netflix Netflix
-- 
2.47.3



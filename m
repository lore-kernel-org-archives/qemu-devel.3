Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167A8CF259D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Iez-00040G-KW; Mon, 14 Oct 2024 06:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Iep-0003yt-3z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Iem-0006U2-Vc
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c973697b52so1472384a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903030; x=1729507830; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b6bafoQ4AEmroXUTOf4RMDPzol5f3xKj5qcmoPEW4WI=;
 b=q3b5woZC1CIIRnSaEf19MINkXBEZmCe9hHuzCS8mLnrt3uAOa4XldDZ7fb/iCMAWhX
 UyGrUl8MKBdgRg8z+rC7lD2eIqICR0oZ30q35dSxEDqyhNcSaurma53rRxwPJc9vei8I
 uOeggp33QnPSGgyoB6Jz/2AIA786yxdDkoAq7wKrirnIPZ823EQD/SPQBETCoS7ZU+yS
 1cUVTVT9P2TVl/aUW6E5rKs7frA5ci5GR0aG5/fR2Y3IQr/h8kQepKLq8VIWqxM/EDUu
 QFQQj4fPVkRJRZljLPFmLlODqgZr1kAWpo2a4IzWeEPv5+Ka30pBsH8KNwBXS7MtgK45
 1N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903030; x=1729507830;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6bafoQ4AEmroXUTOf4RMDPzol5f3xKj5qcmoPEW4WI=;
 b=a/kKIrN/K6xdGzSAJ1tR1OkM6bJyHOyjzYNY7kFYvVwpe5WGKMzSByvEivh8q4AsRa
 gt9GxBEtcUeODCOEefNW+xzdmVVeGFfOzutgJa7tpj/X/wTggyUZAvOh0cJQ0H8pq9sP
 1Dwfqa2h59kXipIiu8NLfxW7LeUBpBSOaYvFkaofMP9Ja6WPDO9iiwbNVSTvlVzaoUkA
 8djBz+JDuEhSc9QLNuR+adXZlL9iBXnO7/SKECuvj9Z2o3C8iQ6bSdovqWCyDtpRhUXs
 +xuTWP0v3YEv1rA3asPAI4nQ8vdj/7aoNSYU05HIvHOMkHNqWRj3FMX6tb0VWlInNfWj
 TLMA==
X-Gm-Message-State: AOJu0YxSwQq3eq1ZMRQ5sNxEYjugTYMo0UkcIyDfwNVmCY0eRayGff+U
 ZXOQF6QGDiZhc4IBedus7LuYWLhFC74g2oRuJT8DH3SAMnPECFLd/H2pVS01mWg=
X-Google-Smtp-Source: AGHT+IHEq+IXWN+UL05J0PR2GuoGIrY6O9CXXhOZ8K3tR0R6x1iSbzEfnVMHWkSxiOIHwcSIuq54Ww==
X-Received: by 2002:a17:907:7242:b0:a99:ff43:ca83 with SMTP id
 a640c23a62f3a-a99ff43d09dmr434786266b.14.1728903030245; 
 Mon, 14 Oct 2024 03:50:30 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0b25226esm165504466b.59.2024.10.14.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:50:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 0/4] No-op support for Arm FEAT_XS, feedback needed
Date: Mon, 14 Oct 2024 13:48:54 +0300
Message-Id: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABb3DGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0NL3cSiXN201MQS3YpiXXPj1NSUJCPjFEtjcyWgjoKi1LTMCrBp0bG
 1tQAet9eFXQAAAA==
X-Change-ID: 20240919-arm-feat-xs-73eedb23d937
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=n3V+VVQvSEXeK/GAnYRkazxno+QILIS5TUpLyNPBbMk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EUGQwZXZWMmhRNFRvbFFsa1J1REVjZnFCeVhDCmxmb29JSmhTeWtYejM5b1NE
 WkNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnd6M2RBQUt
 DUkIzS2Nkd2YzNEowS3dDRC85OXJCcTZWK3NqSTBKaW1QRS9IeVd3NmlNWjJkVHpEcEJHTkErZw
 pJOFVzM1lXbktneUc0eXZvK08veFFjdHNYclBQa2FkTFJZeHZBa2hQQWFZRm5mOE9SM0swMG9pS
 lpOenpkTHdwClFqT3lEMlJUSm85bFZzV1FPSkRYNjF0Q01Bd3ZzaDNQNHBxcGZtaU9DY0MvWXVi
 RTduU2c0Ky9Bc0lWQjZhUUoKazhvM1ppT1phM01RTDM1SnNQY0E4NnhWc1FCMTBpZmNlVTBGNTB
 EUTZONG5VUTFjUll3cnBYSDY4YWNSU0grNwprOVhleVlVcnZQQndLN1pYRi8yUXNNRXRqNnRhc3
 RqZjNHU3NuMkVVOVR6aWxsbGhRWDJGTDJraVkvWWQyU3VtCm4wTGFER0Y2Q3ZBNlErUWEwTHZxT
 nhiekZVTmJKK2drY3dETmJyeGx2WWRSdlgzc2N1NTRRQXpqd09RQVZlZ1MKMm1FYjB1RHNxYy9i
 eG5GUXhVUXRZbmMxbHpwaVdqcGpOV0dyMm9ORDhWU1hRWkhSSVhlREtyNGsvNmhjR3kwcwpNTlR
 lS21UV1laZ2ZVc1VRUkRkdUZsMVRPMVhTKzdFQVBJQUJ6K2ozS3cyTzJpSUFCQUY1Nnd5SVhWNk
 ZYaFVtCmZWN2ZKL2ZoWEpDTGdRZlNocXgraktzNFJnWDVPVUh2U2NHbDZoVlJ6S0E4b3NQNHpSW
 nUxcHVmQ0VsRzRycnQKRUd0NzdjR29kdCtpUzNLUHVRVE1SSm5NOXQxOGZLa2UwOWRNTXNXNzlr
 MEZUUTJKcWs5eHU0VlFQbGVKK1pMNApiZDZOR0lWbCtrckRFb2crSTBqSmRpanFJWmFhQXBoYmo
 yZm8vUlArSmczVCtKZEFmWlRXd2FhZ2hDMTFJVXk4CndTZ2owZz09Cj1YNkdnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

This series is an initial incomplete attempt at adding support for the
FEAT_XS feature in aarch64 TCG. This feature was introduced in ARMv8.7:
it adds a new memory attribute XS which indicates that a memory access
could take longer than usual to complete and also adds instruction
variants for TLBI maintenance and DSB.

These variants are implemented as no-ops, since QEMU TCG doesn't
implement caching.

This is my first foray into TCG and certain things weren't clear to me:

1. How to make sure the feature is implemented properly. Since we model
   cache maintenance as no-ops my understanding is the only
   functionality we need to provide is to expose the FEAT_XS feature bit
   and also make sure the nXS variants trap properly if configured with
   fine-grained traps.
2. Is there a point in adding a TCG test? If I read the manual
   correctly, the nXS variants should trap to the undefined instruction
   vector if unimplemented.

These patches lack support for FGT for now.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (4):
      arm: Add FEAT_XS's TLBI NXS variants
      arm/tcg: add decodetree entry for DSB nXS variant
      arm/tcg/cpu64: add FEAT_XS feat in max cpu
      tests/tcg/aarch64: add system test for FEAT_XS

 target/arm/cpu-features.h          |   5 +
 target/arm/helper.c                | 366 +++++++++++++++++++++----------------
 target/arm/tcg/a64.decode          |   3 +
 target/arm/tcg/cpu64.c             |   1 +
 target/arm/tcg/translate-a64.c     |   6 +
 tests/tcg/aarch64/system/feat-xs.c |  27 +++
 6 files changed, 255 insertions(+), 153 deletions(-)
---
base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
change-id: 20240919-arm-feat-xs-73eedb23d937

--
γαῖα πυρί μιχθήτω



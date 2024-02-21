Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B996CC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqDl-0000OE-1Q; Wed, 21 Feb 2024 12:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HzDWZQwKCg41opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1rcqDi-0000Nd-MB
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:22 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HzDWZQwKCg41opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1rcqDg-0007ho-Qu
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:17:22 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc6ade10cb8so13819738276.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708535839; x=1709140639; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LdESWrhZSTXfzqZQoBtj0qn4uDZe1pLjkAyWgBYDPNo=;
 b=yyjGsS20i5GW5qQPVqxmFGYSHtCDrLWs/FU4XlWhYv5X0tDYcSsV9Oe5OL7FkLKxTW
 McHazsyLJmzFW98Cz4rfLh5nBzzoQ56Qe5YrNwRJF9lTLHvuJkuPzXZzGwGHH++9swrf
 TdkzdWq2qTDrl935p9+9wh5VTBPu4bGkXzLfkVoYQl0L2dbk+vIZGJaqg7fQlEfuEJ8H
 rvhO4MNgU+ecfRLvDfD3rvsxqVDgzFnDKsPLxWApmHyWIvGxXAxQelc0riAxJPL06kYW
 Wt2c8bAvvzOCPTBdprZeFZiBD1j8N1lp+vexojZJjUTPQHpuZvlO4WJoprQiDJH0krrK
 ZIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535839; x=1709140639;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdESWrhZSTXfzqZQoBtj0qn4uDZe1pLjkAyWgBYDPNo=;
 b=If3AzZx0CKX6MlTT2rd+BwXVV3s+zqlWuO40Gdn2xzmUAQW41Rin6U6dkJmOo1r00Z
 4fugrcYmco/fewtl9ixfFDAYkM+ctvnssqJsKgslHMa+yKhMhemfB4HIkuYVNMSk/h6g
 d1uJ68iGP6MgTzf7zF6IVZDzFjzGFrP2AunZ3uobUV3dUT83KUb/bQyFOuP9lc9WGMLF
 7LnTnVXvoDCFXbJ4GMnxGULAt9wlUmjpxVZSwKGczKQoo5dAAkhGWTmtndnAnt19HMdl
 GDeZcvJhZCsU9wP6WeNDvY2SLfmUZOvSt5mTUpT2hhVwyGL48xTddK2KGWMsy6Y6McqD
 epAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWa/StiBPvg7JvEZoK3LsvzFgl2qxmUN+7FbZZmI4lcqOkkG0YesLCTUv8Q58XHgHM2KwPc+dQNPsmQgCrFDwHSRbsTjk=
X-Gm-Message-State: AOJu0YxXqpKg0GAibQtVnC1odtECBImi68bUsVwfHZc012hO/yfM58Bl
 HmJvdZd4NQDEKPpH8fOzvipB2etUs6wzaOw39f+l5crd/etW7M3DsaQwxg5Y55sovNR7VaZUWRZ
 ZoHogPGTXMx2I1NaHkrZtU93QWQ==
X-Google-Smtp-Source: AGHT+IFF1ynep4eeUowo5Z3vyyDNfaWeNs1uY60BtmeX0/uZIEUvLsM7ZAXuR7PpLJxr5Rv3ho8OoRPTuzlkgUn/l5c=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:6902:1003:b0:dc6:e884:2342 with
 SMTP id w3-20020a056902100300b00dc6e8842342mr13913ybt.5.1708535839333; Wed,
 21 Feb 2024 09:17:19 -0800 (PST)
Date: Wed, 21 Feb 2024 17:17:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221171716.1260192-1-nabihestefan@google.com>
Subject: [PATCH 0/2] ARM SMMUv3 StreamID Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, eric.auger@redhat.com, 
 roqueh@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3HzDWZQwKCg41opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

This patch series modifies the ARM SMMUv3 to be able to work with an
implementation specific StreamID that does not match exactly the PCIe BDF.
The way to achieve this is by converting the smmu_get_sid and smmu_iommu_mr
functions to virtual functions that can be overridden by inheritance, making
sure the StreamID is consistently 32 bits and removing the hardcoding of the
SMMU_IDR1.SIDSIZE to 16 bits.

Roque Arcudia Hernandez (2):
  hw/arm/smmuv3: Check StreamIDs against SMMU_IDR1.SIDSIZE value
  hw/arm/smmu-common: Create virtual function for implementation defined
    StreamID

 hw/arm/smmu-common.c         | 12 ++++++++++++
 hw/arm/smmuv3.c              |  4 +++-
 include/hw/arm/smmu-common.h | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog



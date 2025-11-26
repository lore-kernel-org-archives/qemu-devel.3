Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8A4D1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEq4-0001pu-NT; Wed, 26 Nov 2025 07:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpm-0001cp-L8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpk-0003Nm-QX
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso39526665e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764160879; x=1764765679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FCn/RFtesIvSy+oCDXPuPETQANWEumhqApq9lXNOCC4=;
 b=cl0+4NbjptX5F1HQuCpvbI4AAJbuVPmbfJH93Ja7Gw6l1irwQmN4mKTd2+CtRQtZwW
 vZeIIZ06T3AtiYqC42mvmX9YI+tas3NjxUmO8LTSs7G8o3S08su1x6I6V0+BCbG47/il
 xq7Mg+GNrgS2YskTM8qzw8fO3oweZbKHKops2BM+XHExjLn5ig0QVyv039BApWmZpXzl
 gYJSRNGgLHOTSp8ckELNPv6JDIOj7JvJ2hVStfj1vypf4E3bOAxvXGcllZfrg2KQp29p
 9E0BvE08a+ZLGRddSgDLbp93u92HWOy3HxKWHHh2EupQbCVdCXK9TtTouLN3Lh6kFZiu
 xfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160879; x=1764765679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCn/RFtesIvSy+oCDXPuPETQANWEumhqApq9lXNOCC4=;
 b=PmwxWeWfdsybiTWeegRL2WMkK+I58H5zIB9HPMZWmAzUvQDU6vJv4oqr7ureu/p3Mr
 Pl84ayLpqh9Z3HDye6flghOVQlnv4J48OKOREisEMED7cLoPmQJHN46JqNfQbqOCkY4H
 tVuZ7fRO5YRF9Mv/rZAlzNqwaili2jEHtYddJKaaqNlYmDt9UFDwbbnmjCHONa/SJoZk
 GMEBTiWwJBBRzXs/KvcEfSwFxRsiPQJy5ziApcyxZbM9irwxdKSOyvzs+nq9Q1L4ThCT
 UnXLvMlkXJ+d3/DICmKR/1w/EeJ2fkBy7daNpITZeBrVdTP8tuJKsXxbFFjaZqRlE5QL
 ZTSA==
X-Gm-Message-State: AOJu0Ywo6lb27pFntqBqEGL9pU9Mnteh5Bi5j1/vAfWWbRms3RL3cWMa
 TMxk65xCcq+K3SfrFatlApv3uiQnnWerQbu/MufC601yUcyO2YegGCtCjvtr/Ia4fUa0W0yzSk/
 zB/hS
X-Gm-Gg: ASbGncsxmldOODFXIy1Qi7GXOH+ZBhkx/xD9RIl7iKEjBJO2BnARkDrC3MgpzGIZ3+Q
 8lZFQ3dYH7rC84rY2yVdW/906UDCRJ6lTgHBF2OKcWb5099J3Hh3GsoX1TjbLVMMGuxs1cttjTB
 CM/HHFZuJUv15Lv18vuG/kSaEEJWfSLevsXWda+3wQWuoO7nz+WVCsDo1ckeMrb5hcTaN5482Xr
 PnmFKiLx1Eq9jqvQJkkJh7GM9Cz/P/5jxULTiRmwYTZL+/7ywdWKWmpuEzmUbNMO/MnDhwE3XzZ
 z1MT1lPVN6xS3B7JW26Aw1oiUnDy8ks7MI6wkjev9uFiR2fSHuztGd1ehxZHiS2/x9zPN5F/2BZ
 WXEMuMAKzbZy6kZ9+JiVDHDwb5LgK7CHv0nseKUW4L1NoOW0r2hkTMA1GTHKVOy0KWUi/sZDH7l
 ypCsaRlr6jdL0=
X-Google-Smtp-Source: AGHT+IHvwaXPOdYtD577PYNDgJTbzWzYrlpV/VH/40EK/opNl23cXH1tJWdq9HijSps1Sg+/rNZ34g==
X-Received: by 2002:a05:600c:4f14:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-477c10c802bmr203197165e9.3.1764160878818; 
 Wed, 26 Nov 2025 04:41:18 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:a692:d4e2:eaed:fc4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm40044246f8f.5.2025.11.26.04.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:41:18 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V3 0/4] Basic ASID2 Support
Date: Wed, 26 Nov 2025 12:36:46 +0000
Message-ID: <20251126124116.351685-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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

Addressed some more review comments - thank you Alex and Richard for the reviews.

Changes in v3:
- Patch 2&3 (was 2):
  - Split patch 2 into 2 parts, one enabling FNG1, FNG0, and A2, and another
    enabling ASID2 for cpu_max. The patch enabling cpu_max can be dropped or
    reverted later if not desired at this time.
- Patch 4 (was 3):
  - Check for presence of TCR2_EL1 in test, abort test if not present.
  - Additionally test that new fields read as RES0 if ASID2 is not present.

Changes in v2:
- patch 2:
  - Added FNG1, FNG0, A2 to mask for tcr2_el2_write
- patch 3:
  - Changed test for ASID from "=0x100" to "!= 0"

*** BLURB HERE ***

Jim MacArthur (4):
  target/arm: Enable ID_AA64MMFR4_EL1 register.
  target/arm: Allow writes to FNG1, FNG0, A2
  target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
  tests: Add test for ASID2 and write/read of feature bits

 target/arm/cpu-features.h        |  7 +++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              | 10 ++++-
 target/arm/tcg/cpu64.c           |  4 ++
 tests/tcg/aarch64/system/asid2.c | 75 ++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31CEC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg5e-0006gk-Lx; Tue, 02 Jul 2024 12:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5d-0006g6-Ih
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5Z-0008UP-UC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:10:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso27050335e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936640; x=1720541440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t+GbJBD58UyWaUHFeiM6fRRrol1LCDDEUBkP2sRRWQ=;
 b=dAHkw/olkc4sWbVLMOCYXcLhWxcNtG3qLCe/HyjmXL7v1Kl3Jn2KkSBG4IvK4WjBKr
 gKQMSri2aYDBSasP8RQ8eDPJfT3ddnQedTDSgHJj0BmiJw+rW65ByJi53SeHXOrflapJ
 5v8VFuCya8VX1hAOc9fkfmTZJyXZ9KXsar8GjxhFH8SOVFCxdzGJKSh/diuIs8zCkbzy
 ZYlsPKMKcOidG6XibsLBg1m7x1J+GNgCzctZiGGg/BCWpk8I1KCo8dHHRtTqq7gBXZOw
 AycAqIyH+IcZseuyc74tL2Xi7/ZY8P9HxZO4msBYEwXbzi7icgxnnPN4hOBIMd+7ovDO
 7cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936640; x=1720541440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t+GbJBD58UyWaUHFeiM6fRRrol1LCDDEUBkP2sRRWQ=;
 b=UFuqogtYv9xqFfke02yHtG8H+Zo8AyAH+29QNu6fR7Fpdp/oDe8S21ghsU58htDgrz
 cO5L4NiluroELsT+RetaXkIJ8vqmNLkvozNlvtzI27hTT4nzRXAf6D5BZNxpC+u+FbjV
 sXtHdQZxBYjq02WmXJcJyHUIVd+PGVZ6Yf/NlTgmK93kGvL2P7H5+tMPAQx2XIXhVBNI
 yHwWniPEzsOqwo80rpxLZwvIbDroGIBO9UMeNKg2jTcfsVlrEEXyxFqL1hcGcna72V5n
 JO2KBe5cyqhsFZthlWPaTPa/i6g/hF0IC46t5uHLx1LHnsbaocAz1fSFLCttdHQDtpKY
 g1eg==
X-Gm-Message-State: AOJu0YyJJBJZBUsBjRsuw7Q9K1qM9KbSIrFkW5Mu40UGM37qqRvtrH6X
 EvUoWFVHXKrwDNVrjAGeKKyTl8cX7kJnljPApbdyWGSWz3nvrPcjevGU69efE8pmIAnOirj9PZV
 t
X-Google-Smtp-Source: AGHT+IHV8oQPTs1w/MJrgrSf8wwEkjBNNcun7HXo+1KEX9OnG8LpmAcix1W2N7TPPOsudy858f6mSg==
X-Received: by 2002:a05:600c:1604:b0:425:5f0e:bb69 with SMTP id
 5b1f17b1804b1-4257a05f0a6mr57323665e9.38.1719936640047; 
 Tue, 02 Jul 2024 09:10:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bcbsm204602385e9.35.2024.07.02.09.10.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 09:10:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v43 1/2] hw/sd/sdcard: Use spec v3.01 by default
Date: Tue,  2 Jul 2024 18:10:30 +0200
Message-ID: <20240702161031.59362-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702161031.59362-1-philmd@linaro.org>
References: <20240702161031.59362-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Versioned machine types with a version of 9.0 or
earlier retain the old default (spec v2.00).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
v43: update versioned machines (danpb)
---
 hw/core/machine.c | 1 +
 hw/sd/sd.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..4377f943d5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    {"sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b158402704..808dc1cea6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2471,7 +2471,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.41.0



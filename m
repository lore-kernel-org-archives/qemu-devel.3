Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A69C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUku-0004MW-D8; Mon, 12 Aug 2024 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUks-0004EU-Au; Mon, 12 Aug 2024 09:06:34 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUko-00046y-W1; Mon, 12 Aug 2024 09:06:33 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f136e23229so45106261fa.1; 
 Mon, 12 Aug 2024 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467986; x=1724072786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTEAe/pOjkrnvyxDHYihrpK7ln2+IQNSmZ/kBKccldI=;
 b=Ftrn+2ExZQkHYqwooiueNwAuRA4GXGvJrDaxoErPSYIhjezvcF+l0tvyL3oNgwpCYh
 4BGlmMwRavg76xExoF9Zb/7gs0gXIUSglnFYxNQC55JvlCPXkESBGLxbAyAid/8aGXla
 W1Q2PEaJ3XiHTJcEu+a17H9fulWc40uiEV4dadDdUXEBb//Gm7HId5fx6GtfYOHJyaOk
 x9MBfbj7E8s6S5Nwvp2J5Q1bsLRxSh/wuaXU4M3Q2ZY5BrGTZDDVHf0+AQT5uY2UG6lU
 GXiQzV0wi9F2JychJcejN7lMxB2WEVjFl7ht6sQHsRJRW6AIuQiEI3hWUxJTuwvrQwHw
 vBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467986; x=1724072786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTEAe/pOjkrnvyxDHYihrpK7ln2+IQNSmZ/kBKccldI=;
 b=BVVHNt5daK1DnbV6pCapXN9Ze1h1fvVBKp/KfFp1sADDc4OmvnSPCbNmfSHiLfeobz
 tKyrX74S5Frc8jSxo6Ov05tSosR1IhU98xt8RsYMtqmx7HiCsPCFznintj9GL+kkR8WZ
 qEAGV8xjf/BdUYyOfow5ksw7qY86s3YrjD9E7EG6SeupfZN6VkXzJtXDAy2zYo8Li7pi
 xfv7C/DY6ncLhQDbjD5j1w2zHFc0XbIm5FQdvu3jyB8uTiyikZqFF9eZc+udlZeG582b
 MMqkzC5bqZIyzBWZ7A3sgNcoe5DLFikfGy4q68AcGqsfCFpoqIcAAWFogI6Z0LUHNkzA
 71Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOQWZcm7Op7of7EuKUxGWlK8etF8oh0FS/AWtsIX2VGdSiXzOP3+i9UkXDFM6EKYjaf8qeKCgJ8/CS9cZaP9tig3ke
X-Gm-Message-State: AOJu0YzEqgh8Jx2iW6HFU9LywkjkyaKqThzOLTx5IWoTNxFbRH437IiA
 E5t3b10qR1/q8TASedeyR/SfHYvxh3C84oMvTaUPtrmQLs9QYRt9PmezfFpb
X-Google-Smtp-Source: AGHT+IH0EXdKyQvoxf37ygreO5y2jLBKuw9Hze8ISbhMj2e1iAgBShVHSABDPv6QJ/gpCgSqjwyxEQ==
X-Received: by 2002:a05:651c:507:b0:2ef:2c86:4d43 with SMTP id
 38308e7fff4ca-2f2b714656amr1654731fa.3.1723467985346; 
 Mon, 12 Aug 2024 06:06:25 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f2920525b7sm8607681fa.121.2024.08.12.06.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:24 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v1 06/10] hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
Date: Mon, 12 Aug 2024 15:06:01 +0200
Message-ID: <20240812130606.90410-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Rename xen_arm.c -> xen-pvh.c to better express that this
is a PVH machine and to align with x86 HVM and future PVH
machine filenames:
hw/i386/xen/xen-hvm.c
hw/i386/xen/xen-pvh.c (in preparation)

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/meson.build              | 2 +-
 hw/arm/{xen_arm.c => xen-pvh.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/arm/{xen_arm.c => xen-pvh.c} (100%)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0c07ab522f..769fe9ec1a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -59,7 +59,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
+arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen-pvh.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen-pvh.c
similarity index 100%
rename from hw/arm/xen_arm.c
rename to hw/arm/xen-pvh.c
-- 
2.43.0



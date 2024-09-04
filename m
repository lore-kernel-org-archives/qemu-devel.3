Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E09ACD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsg2-0001nP-Dq; Wed, 04 Sep 2024 12:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfl-0001HK-2D; Wed, 04 Sep 2024 12:16:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsff-0002Gw-IV; Wed, 04 Sep 2024 12:15:54 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f504652853so76084761fa.0; 
 Wed, 04 Sep 2024 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466548; x=1726071348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UdvH3BfQ7ZFjeKvJ3vJphtRrv7BJb81oMyMgddOC7g=;
 b=dVkcSJTymENuvCJiZWqJt189pJNDPJsJmrJUCNJtWWUvYhwlHaffmoCG2wmTYbnSc1
 ic0tak/DnK98hXk7Xwda9pk4Cgmbo1TT0xR0nH1HboMkDFY9QT1wQwYTda6Tar1Y1qIm
 oQLe4BN1DWQ7rqG4pukDuI4m1KOA2WWmL1EenWH6jrAuXO/U5nYu4scwVPY7axQTV4N/
 t0yvcVIyXPuBTl8ZCEGQ7Pm8jY24mftFX8ovgzN+W3VbTVKXEB7z7++xenoM8+QzmcvJ
 pOSpMeLXCpforkLiwJpjHK8ZLdqTRRBa7wjAjQV22XRkrPjEyccRod/nzYG5xCey82jk
 MNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466548; x=1726071348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UdvH3BfQ7ZFjeKvJ3vJphtRrv7BJb81oMyMgddOC7g=;
 b=MdEzsx9h9iN7BxcfZzLs5JVGcvvnTYpNf6UukIBU7q/XSz/T2Car/zX/7qw13ytoJk
 az9myM3TJnRM0xDEwtUTabgzzOb2A39LNwEzRyQfcO1+hHxKui3tKDepDoMUwFwqU5Wv
 lwtrxT5GJhAU9ZGA1nvjtxfrU8/FcVq+w4OPAYnsffnpSDrvt9L5s051jAGLwjvtPffi
 8YALi54cU0jerYn2fgc1WI89ZgwxyfEhYDAOo7O2LNsicPcZqCF26DgALWNVrXls0XrH
 0zTPD/0aiF4Ou8FpuZO9B4OV3rhla8JuwV0EtuCq8bTHFlFR/64hM9eNZxnakLA1DWpe
 9+XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBl763/D4wqZIMWLDIGrQoV+J2RSKaZDtQUp/sfEO7y/VXkzFnq4Y+ESaonV3DOhJYx2hcPSjL5Q==@nongnu.org
X-Gm-Message-State: AOJu0Yz/5iEUUhM02jDOq/xDvHdXakouenZBedAM1GatKVVERqXsHhA/
 O/KzbS9RpuDbn462qPxve1MjcCnCKZVUXSAuNUI7BhBh+AT2f8EXCUHhKKGI
X-Google-Smtp-Source: AGHT+IE45vRxHAq5eEpoyZwDxuEOBpO1l1yUi0y7mTpVkk1pHSrAlDEkmoWFTNi0vvfiboSA/TFkcA==
X-Received: by 2002:a05:651c:1507:b0:2f5:104b:f2c with SMTP id
 38308e7fff4ca-2f61e0b27f4mr114070401fa.39.1725466548140; 
 Wed, 04 Sep 2024 09:15:48 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f614ed192dsm26313971fa.7.2024.09.04.09.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 05/12] hw/arm: xenpvh: Remove double-negation in warning
Date: Wed,  4 Sep 2024 18:15:29 +0200
Message-ID: <20240904161537.664189-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22d.google.com
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/arm/xen_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index fda65d0d8d..16b3f00992 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -165,7 +165,7 @@ static void xen_arm_init(MachineState *machine)
     xam->state =  g_new0(XenIOState, 1);
 
     if (machine->ram_size == 0) {
-        warn_report("%s non-zero ram size not specified. QEMU machine started"
+        warn_report("%s: ram size not specified. QEMU machine started"
                     " without IOREQ (no emulated devices including virtio)",
                     MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
         return;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4272FC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whroM-00038p-FO; Thu, 09 Jul 2026 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroK-00037p-O0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroJ-0003b9-8F
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669EwShJ2062330
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2guKjLLIh6Yke0jP3jv0CWfwxa2kqm9ufX7O6VOiGc=; b=XHvzB/KzA1f7RJaI
 ofMa5MieFSjYdS3/9GWgVd5NQ36neZIYXRSICVoSHW/n2B+zZ7EHItNLmie55IGX
 XMbUqjj8M95sD6vvxABxZEgf/GDoBOAPlTAzNXmhWLgvOKyyXZk5y6Ona79Iaeot
 fEKrNNf4WeM72blzcSIv16VZB86QI4Ot5M7FVgYFEjfUEp6n22INScppzvWhYdOj
 qLZ0MetBcWT0RiPBt60LaEhN8fS7V1oFLgCpm3seffBJBEAJyXoZfBly3saQkACQ
 LcJz5O5+kG7kPFyo5ebmElyncCNu6mSCnV7elWcXqIVBL9L3KKBQ8EfOPJX4ABOt
 5wXPwA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvj8jfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:41:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso30076361cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615274; x=1784220074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2guKjLLIh6Yke0jP3jv0CWfwxa2kqm9ufX7O6VOiGc=;
 b=WMK80AlYDXk9zHkY3Dl7USDZla3bYXow5c6UDx6w3mT6gS642kemGVyoSp0cg3/4AH
 zkcAzTXa4KTmviVM+hmDzm1vhLRJ8URtumU2cUjzTKwbg1BBcHidUqE1ykykCAsvFzX+
 lj/85VAlfEgEi2DBTTFtl4V/RL2hMdoGdyVibUvQkai2fNe8hQ7sSViP3+ENFzK4Hywz
 Oit1SXEKcMMLSj1ZXYNj6NeGJKi7DS/coPvoo0LZliHghICJAXEbSdE++h1bRZtw2wsF
 YnQrS7gtQ+88kKmaIFCvhtg5vcZPEUJodinBN/6+zVgXQhEgHahf1eSFuaZTj/Y8egh9
 wqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615274; x=1784220074;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2guKjLLIh6Yke0jP3jv0CWfwxa2kqm9ufX7O6VOiGc=;
 b=gDVtIjLidCxuz+cbc4vGc63vhx/SRE55am7VyE4MJpMS36UBiEpOmoGL/b+HDVWCRY
 padJxmh6jTYqfZx4k18/EeBX2djPx054+/ktWpKieXxbFWofSG/6fAz/mYtQ0JR/7x3y
 0n7dvk0Bbv2h7aXh30CT5dnuuAtq/nkcZWXoywjmmDnM9Dog5gVO8YBq+fhapaRlewMy
 QR9F1Nk8Ur/jxH9NvQ8Dv+gD2gbqQawwoOpBbgn6mOvhfCngba0D5aUVYkK7gTpMrRXZ
 Vm2p0YiCmmuZ/jd/LZ/+p062Nnjj/ICfXxdVjZrzBtj8JKIYzTQ+Ff3jgE9nVLu3RQvq
 scgQ==
X-Gm-Message-State: AOJu0YyoRkDoQeI0UC5zcItGbicg/ZIDVZtYtwhbUyXCVWv3oGmFQT/r
 8dm5Iu0R7OhimZ/HjpYMh/JsBfc+SsY50t6MaL29l/pqPeiYtPTM95z3CI/uV5nWB/iKkRhIstr
 nV+7ett1qbINho0SWZTD8JVQuUl71GuMc430T9R8MAxH0XRgF/WFdDHDV74dlLsxqWA==
X-Gm-Gg: AfdE7cn3pTyKeFU56aNzY/rXxa6vdaBMXcTDwC1v32mt8blxEgq/1WYpmswVRAvkuhh
 CAtqFR4StxXWm2QoWiOgbaxXTPxg9OmbSIWGSLALC13A0WTFi6TBSrV+Jqf7NAJ8iaiAZS7RfgU
 TRTWvrh7JXHDJriIl9CN8Du+4g+skepZTNimOsIIyMCvva1ZHHKi6xs6w8oq4WYuBEvkTnHVriT
 GHzUzmaHsMC0g+fl7AsG0G4rlUXjV64udGJr35FkrVg/P0YFv0zRzwHODSUqQMam45x4MlZKBTv
 LKbQMvyL7eepeZsfo/GZJoap2AWbLvsPwgDJpmHeyE9ab9Hizx+1Oyt/WoRjjHDmt+FshORaMOs
 ssLR4qwqDlbQmZkvoVs0PGcBGCrykFoBv9/9XmTVanFfbHOwsVHyDsrMA0DXAjZn+IqoF
X-Received: by 2002:a05:622a:1f89:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-51c8b4bacd7mr87241051cf.62.1783615273723; 
 Thu, 09 Jul 2026 09:41:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1f89:b0:51c:c29:d4c7 with SMTP id
 d75a77b69052e-51c8b4bacd7mr87240751cf.62.1783615273349; 
 Thu, 09 Jul 2026 09:41:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm53890854f8f.15.2026.07.09.09.41.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jul 2026 09:41:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT
 Kconfig dependency
Date: Thu,  9 Jul 2026 18:41:00 +0200
Message-ID: <20260709164103.37614-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709164103.37614-1-philmd@oss.qualcomm.com>
References: <20260709164103.37614-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX5gS0pWUBlfgx
 ESAaLBffX6P/Fx/LrwyeAina/PWdwg3yfaHbolIXDVDj4QBGFZoA3omUdDrNGSXeGc6aWPFvCm5
 ytCN16Cp4r1eGSaim/FzCmwO1ubyBO92t90s2a6+zFuehf+zq/OH0B2GyiiT0Au59nEIBvofnjR
 G/ZUQJPlUt2zWc4uYxGzsgIRYzAE4ILSWACF4QXADioKycsXvWB0Rtmsz60v5GsXDf98zjgB1wu
 uz7zR3Ny0rzQEGe2XiszJ+D+OVPECJ/b3OfYyaSNQZPSFYdyTlCZDGcTsezMYqA4pziK/wd4sqy
 4GuWc9kxBhF0EksMHd9JtECSBKTaO3lj+tm+hKlbYlWLzMUWBuEJKA4cEI2LGJEZdqmCQ6TT86B
 Ap+1DFTsi7/MM1Qi37awZ9H7UU7gHEb6gXY7tg0LxzhK2QKqfylh0XjGWzvXJx4L0e2c587cRAF
 PnhQa5wWkLk1G2x5FHA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a4fcf2a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=5Fcm2OjPWWNMJlL2lxwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: IDaitvzVFGZxC6k7tH2vdMgBpWtJhasu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX0mQ9fMGlzQOL
 Q5Oks5qbugkkPxM7vmQJRADiU92Moa8gyUGDOH4wUGHpe06WikuqgqWFvNP14BRSlX1JdaCP2OQ
 gvjARpCxYrYHHItbVfksoVbJG9H+3yw=
X-Proofpoint-ORIG-GUID: IDaitvzVFGZxC6k7tH2vdMgBpWtJhasu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the missing Kconfig dependency on PCIE_PORT to avoid the
following runtime error:

  Type 'aspeed.pcie-root-port' is missing its parent 'pcie-root-port-base'

No need to have ASPEED_SOC select PCI_EXPRESS since it is
already selected by PCI_EXPRESS_ASPEED.

Cc: qemu-stable@nongnu.org
Fixes: 2af56518fa9 ("hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address configurable")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 1 -
 hw/pci-host/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 82e0bc2e700..00e2d938033 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -557,7 +557,6 @@ config ASPEED_SOC
     select MAX31785
     select FSI_APB2OPB_ASPEED
     select AT24C
-    select PCI_EXPRESS
     select PCI_EXPRESS_ASPEED
 
 config MPS2
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 8cbb8304a3f..bda6e161f1c 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -49,6 +49,7 @@ config PCI_I440FX
 config PCI_EXPRESS_ASPEED
     bool
     select PCI_EXPRESS
+    select PCIE_PORT
 
 config PCI_EXPRESS_Q35
     bool
-- 
2.53.0



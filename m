Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SxWReTME;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zur3iKRP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpE-0007rG-LS; Tue, 27 Oct 2026 15:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmp1-0006QN-R9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoz-0002DU-QX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHSKH2997855
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PoSr9Qh+nNATOwCnPzcMqEi0g3cI3p9Gj3BAJbiMTQk=; b=SxWReTMEJezApHiB
 HuYp2MqifjKpkCBqZVv68j2k2AsT1bEHxnOt28EP2bcnmXDsswdXTYID3SNWbrzk
 1zoEG7shI7Rw3ZQOuaEntC9k58S1ZF4qRAQr/StzCNYV5TizyT6vYyYMzblApb5X
 eesOh5D0Z8uCbR6/wOmjH53hmxHlX558anlfvlLPuARm/M0kn1WEL61HeuiCXJ8q
 qpmRglY+MMggQk2vDo+kdSBAsr9+feIkKR+jLQy75iIdwW9d1AIh5/OXo64BDgp8
 MUlFvYBjPkOPUtWwG0DlH18mxLRxRwNQQRJpP4BSu1muePLpIjr6f3HfpwQoA7xC
 2l6jaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1jcjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f322ef7d3so29981585a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129215; x=1793734015; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PoSr9Qh+nNATOwCnPzcMqEi0g3cI3p9Gj3BAJbiMTQk=;
 b=Zur3iKRPu5sZP4P/QxD7catKw6cDbDEcaPGHnUt/U6N98Cg0ZpIRzYu1zw0nvm9rKu
 n4tt6U0T6CL8pfOyFuIOFCgWI4yzyZlQlbidjlbR8d7p90yN29oEI0NLBgvYJyE6LiCD
 OnTx19NubLcpDwqpV64kyOx99wfoLKcsX8U1vP1fNWLm7TkXY2QiVznNJkIw9q09um+V
 Pgq1M2Ek/VoPR9nLcE4wT/9xpt6VZYhdBlpUP4VuFXTdhqjUMW1HaXeBBtXjJQTI6khJ
 8zG/WHy0kfXimQf315rzZNEDkMZVLYl9rt41M1CjCrXHcj3N+5/dY0NkSOWmweDwl5Hi
 9pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129215; x=1793734015;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PoSr9Qh+nNATOwCnPzcMqEi0g3cI3p9Gj3BAJbiMTQk=;
 b=VXIB4+VphEoq15/KZWKzzRdMgaWOiaQH1c7qyHep1nF5E2ACcaExaOcAILkuWDt20r
 32QLnVE/G4RlxU9Bu3PhN0ASCg+5gRyjjx6PkWzzvJU7FcT/XN0ibxcTGDNyXYVnx7p+
 ZXy5x1+I/dout1Z9POlSkukQ+C3IwFa4jPi2jisEXodBAQJW4yY8uxJXl1S+6CyVM0mW
 tCwlKDt2bsSKT9+k3Yg7z+ZIh99MykZtvUQj/L7pCd/NxLTW+qKgnG1Id9rFO620Kz5K
 BaHanrSlBwFOC+EaxWAb26WqMSrk6yEpsXnfqHn3EKc/T2sFEY8e18M6Ylzr1jGXAHGw
 2Iag==
X-Gm-Message-State: AFq9FYLcO9Nfj7ybsHxqDoIhu9PN6ItjK2zABG6TPCeceHj872bb+2xT
 mpYL9awhl95G3dJ9DOrmbALv7Sv+Pb2RuIA28NNiLzbDctqB8cHs1qdJFFv00kJZSpHsZv2eqzT
 2WukKeSY21IjXoroBLOvFXJuUEloHQL0JfXa+lIhFLKc61RsxTUP5KODvBcnKW3nI+A==
X-Gm-Gg: AYBFou1578RXJH3zgvJBC3LhwVRIIgdUyKOxO/oyA9lMcB+jK0APKrW0mFNSQnaMtKi
 ufc8lBhYjGBHtW4zmj7M2trynU2QU1a1z5w10HCscCRqh48HRAqnJ8r+fZAwn3oJtG8hZU9pF4Y
 VjQITvwcTBGd5zJ9ecnElsZa/smOiO8lOh2Q1eMifK6G8LFJyr93lihDnktzsLC3iepisNx8RwG
 shd8PvVDOQpVOBzh5EpmxsTcaphusHX5/YXYnfF2ZFzqpJazHnIK/Gknz12X4zehsqwUfk4DEHv
 KxaKgMvzyoxrhr8naOuvY/+zVycy2Pm9/pQB/yA2yrB62gIk5uBEh6np9cZCz8JNG0pEcI9xmR4
 97L1OD3GdZPZwQ9UAvLN8UmUCXISHrAGX7tiIw+VS/vBJ/7kguLTgF4Cr
X-Received: by 2002:a05:620a:6016:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-940ef964acbmr1750516385a.45.1793129215382; 
 Tue, 27 Oct 2026 12:26:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6016:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-940ef964acbmr1750511685a.45.1793129214819; 
 Tue, 27 Oct 2026 12:26:54 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952b0418esm2224025e9.11.2026.10.27.12.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/59] Kconfig: Extract config FSL_IMX7_SNVS from config IMX
Date: Tue, 27 Oct 2026 20:23:09 +0100
Message-ID: <20261027192341.9197-29-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0fb00 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=5lDbTlto3pJDAP_1x8UA:9
 a=OxilXL1js4uPhECT:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: TSWqSmIBXw6JxujheEDMYuJqSzl7oXwO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4Ojs31ECjfWf
 Ja/EHremo0GT2+yQPO7+wNZ+l+z9kr5oElocNJM+hEHHEeSGUOYFoFX12zhX3oDGOtsV79tEMS/
 ZyWz4XloKoUBCLvdIJgpPT1I8H8SxXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX6sSDNB3nAp95
 Gp+TL7yxWitPkn6Yw4roOP7rxR18LFMWR1PJlLjz2mCn/HqpPfU2qlW5yvOGPEjBqJZebwQ2nWl
 Bjs2ppwtxq/JIdeZwaXjkEnXqn3KjGuSSuDuobrlHuaTBN/sf6/pZ7CXbpGfdNG0QXUEy/sgKZf
 9l55D8ZK+3le5osqZ+c1e0xdQwTHX+FQ2+AbPWMED6IsM9ikmmgkpFvDa/cNboHRl4YMmjDLemV
 rN7nLz/Mo2R1bDZnkR1UGKFpWxdt3vLRkKWNB+0jsEonkr0RlAtAU0TDWIHVw07KX2tB+kofSRv
 /tTPOQY2Ps8RCsjFgH7Mibv+sn5xb0bL6zvzCoj+6Ln5w7cRGksZyBRcSh9SWehsxhRt1rxjcmn
 L9vawONYt0yr7FW79AJZrugPQmsZ8Xik5RnjeohzycvlEGP3q5xtwAjTYOTfWEbr4rBAaUCq14i
 BKplEEQfRKOFCo52zsw==
X-Proofpoint-GUID: TSWqSmIBXw6JxujheEDMYuJqSzl7oXwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config FSL_IMX7_SNVS to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-24-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 5 +++++
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5e6b81bfbb95..c01b1ea979bf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -506,6 +506,7 @@ config FSL_IMX6
     imply I2C_DEVICES
     select A9MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -581,6 +582,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
     select PCI
     select IMX
@@ -600,6 +602,7 @@ config FSL_IMX8MP
     imply PCI_DEVICES
     select ARM_GIC
     select CAN_FLEXCAN
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -625,6 +628,7 @@ config FSL_IMX8MM
     imply PCI_DEVICES
     imply I2C_DEVICES
     select ARM_GIC
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -665,6 +669,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ce9fabb8edc8..a69c56ecc69b 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -103,6 +103,9 @@ config FSL_IMX6_SRC
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SNVS
+    bool
+
 config FSL_IMX7_SRC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 44a21b9faf63..f4a4bc1c482a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -64,6 +64,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SNVS', if_true: files('imx7_snvs.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
@@ -74,7 +75,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6_ccm.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_snvs.c',
   'imx_ccm.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
-- 
2.55.0



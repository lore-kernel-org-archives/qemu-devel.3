Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AE606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nK+k0uuA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LrGT3wQA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpW-0001Jr-5o; Tue, 27 Oct 2026 15:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpT-00017U-EH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpQ-0002Hz-V1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHpFC4036054
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aCYHpJ/P3Gn3VFwnE21cCPUzNvlBOm/7ggsp3gZuCpQ=; b=nK+k0uuA6bap9OHb
 /XfNP/M3w45QM9aSg5VtEhcPVlRg/13FOTPZy00qLIqAxxeB4bKTc/6E9G2tnu5F
 v3638vgjRmz4YyzAUp67UwJfYl9iMAa4ySaWVg/d4hnuIcXVWxqZNB3PcJsFr2Uo
 t7mO1gxxxtQP9IYQ7q9yfRi1suWHfJfGgbr8kTEG9nW9S2Okf0b5AApPq2hdJheP
 HXlCy9ISdbOHXak0V/9muZk50E6LNN/AUfOqCFQ9Gi5fmiaz6myMFFBJvv49cyhu
 bc7rrCWu8HsMxu+Tx/GRLlcqPkuoGTt/HgjHZDqd4VwYtgdsSs+1ck6qu8Qwea8m
 27HJBQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjprqp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso249219085a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129242; x=1793734042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aCYHpJ/P3Gn3VFwnE21cCPUzNvlBOm/7ggsp3gZuCpQ=;
 b=LrGT3wQACcpaVf6zs41SQnxs3h9zmcJo4ArivNfF3YDxj17v0SBbrobhTA8bnJtsJf
 NkLkfzN0ckz2Feq4MjBh7IXA645+Wv4Ay2uRISEPi5XqKhD27TFp279oLvWRbyTf5CKg
 bfTyqO2yhO6yxfBZfQxWryzfXvMC/p3Sab7YMaiNtN9vHjXp52JjtJqBjsTDhei796vQ
 LuaoWMhl1YmvlWvkoUypkkY1w9iZ5O96k/Z/ky4uiwSES9J/M4dTUFM8bZcDXweUripa
 u445Y3sSmRpvEx+BeBA9UMB6zY2t5OeFOZoUicCjuI347oN4npioJwS9oR/P8UIOCULO
 ughA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129242; x=1793734042;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aCYHpJ/P3Gn3VFwnE21cCPUzNvlBOm/7ggsp3gZuCpQ=;
 b=O6Zv939NoIW788g6/ydGYitwQDwTKDeWysdKIuclujq2sd2A5v6WR1pcOokYviQDya
 xmJ7LWjJqPXvTmSM6wu+x06IIOFImxcPij6nuac1VBYeVeN5Prr+phz0iyIpFScp/RTw
 0XIKmQv1lUY57wY0QxvWWO9eWj8xJvQry1hnUSwXyVsxXH4Jjk+LzOniBkn/dV8Z86HC
 nNtVgpzehaBfSVNzrlL8Os4OM0IAmuVaUaBIB7Hutt49dQQukgbT1i3FSSRPRdisJRpE
 A+aatheCTN8Wb0cTcztoaqeTb2eU//jzHAyq9p2NphUf97Icit0T6e0H1goo0BHGrw08
 TBcg==
X-Gm-Message-State: AFq9FYJwTSyaKZ0wLhSUdLHdhVJw+F+yJzlYZbjsF6yYZO4ju2i5rB2I
 NnuN17I86pMwYLjL+5BJWyR1DBibIs8Uc6FNeRrh7ecXQPNJbPlsdADxxAhT1N9JDXu0Ennm+8x
 GXHsdG5TgoxJJID1p+aIkzvzSHNpN7Xj2g3Jfr49pnpCCUDnkYVeY1Qi1pXjT/yvSyg==
X-Gm-Gg: AYBFou2EUupL0J8yjFkoZ4GgI9O9ME3ZaNjGNxA46tXMwZr+tCXOl/M3SjhwGVHyuln
 FGdDbtnmTfDLw7JjYFB6uZkbYAbEa1SJEqTTIOfQhSLvSx9cHHV/FIbqg+1tAFt9iaCTy9qIVuf
 pwR1cHWPfKaSkB35wJkDJuu4RPGIQeOpZg8N836XOjdxBGvQCb/rkq9raRuxAVLHfPab8AJvkMB
 hULPkwVUxHdV1uWbxQKgv8fwHjSuaZoiV31MUOOcnvK9CJW9RrrWyf1za2YYQRYw97qVf6DGsxy
 ZtZiUk3f1bveEZFLaDNKB/jR22icAHjBBt9vFG2VGVONsfPrJhu1Eddw88msby4X9c5nTYuJIwJ
 tyjoaOSc8nrPZuacIFiIU4X1PRVWfwbvLCjcR9ZPaFSg5xgVkDD98mIkx
X-Received: by 2002:a05:620a:4054:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-943f3f27babmr643712685a.0.1793129242338; 
 Tue, 27 Oct 2026 12:27:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4054:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-943f3f27babmr643708185a.0.1793129241545; 
 Tue, 27 Oct 2026 12:27:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm25200443f8f.47.2026.10.27.12.27.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/59] Kconfig: Extract config GPIO_IMX from config IMX
Date: Tue, 27 Oct 2026 20:23:13 +0100
Message-ID: <20261027192341.9197-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9jEFua//47Gf
 IDPHPJmw0JtTXqcIGxfSYnpQn9kTEMjc3CVCAMm3/loXs/GePA5bPq38ywG5cIADK0GIHa3NGPX
 D8gq257BCGFqdFHyvgXfUhZBNK3E6IJkYbImxCq2tpxX+6oXBsbOUz2HHWpXUIVTRi2cL0iXa0C
 YzI4m774TTEZ/1ORbSoZCIIlCF9LBitCjKCUPeZ+b1g83ukhg7D8UvxKCRyJPrvUTHPGwJZ7cVB
 nMc8LvEuZIU2ZsoJj0bczSgV1YufPiC/mKJmK3qWNfe8dLa4YqVqsmUUSEls2stSWnbAq3oPHh9
 05eJVNACG0CDB4VMtOfTXooIVC2OJnqXSZgBwGnZhtINUqh8REpKkW5JHJMGFruycgCx9BuQO0O
 X8Lqe1ajVI1I5W1ED/m6jJSMJk1MRn8g8jpahI+c2emddKkJK0ygsvxkGOdG8OtA6+8drx+Eq6/
 QxFygl1mJvz9IqqblLQ==
X-Proofpoint-ORIG-GUID: nEMw8vK7oRDa9n6Ne2IpKOehd0FWVKyG
X-Proofpoint-GUID: nEMw8vK7oRDa9n6Ne2IpKOehd0FWVKyG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX040KBclX5vrU
 RJZiTI/l4bTFzZa0c+xi/ZpqyXhG3NgaId4hKJOeVQbdAEyj4wH6b86/c8130QnZHWLQmwxGHOe
 Tj7Yu3tuLZMrTbtx8G44PhLy7zD14ng=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae0fb1b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=AV7NJlB2dRExfWgJ-qAA:9
 a=egRM8HxTFvu5Bn7Q:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
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
config GPIO_IMX to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-28-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 7 +++++++
 hw/gpio/Kconfig     | 3 +++
 hw/gpio/meson.build | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4b52df2a324f..92e6e3b4790b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX25_CCM
+    select GPIO_IMX
     select IMX
     select IMX_AVIC
     select IMX_EPIT
@@ -497,6 +498,7 @@ config FSL_IMX31
     depends on TCG && ARM
     imply I2C_DEVICES
     select FSL_IMX31_CCM
+    select GPIO_IMX
     select SERIAL_MM
     select IMX
     select IMX_AVIC
@@ -514,6 +516,7 @@ config FSL_IMX6
     select FSL_IMX6_CCM
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX_EPIT
     select IMX_FEC
@@ -594,6 +597,7 @@ config FSL_IMX7
     select FSL_IMX7_GPR
     select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
+    select GPIO_IMX
     select PCI
     select IMX
     select IMX_FEC
@@ -616,6 +620,7 @@ config FSL_IMX8MP
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -643,6 +648,7 @@ config FSL_IMX8MM
     select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
+    select GPIO_IMX
     select IMX
     select IMX_FEC
     select IMX_GPT
@@ -684,6 +690,7 @@ config FSL_IMX6UL
     select FSL_IMX6_SRC
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
+    select GPIO_IMX
     select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index ea0fb72b4062..5ea2c5f4277f 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -1,6 +1,9 @@
 config PL061
     bool
 
+config GPIO_IMX
+    bool
+
 config GPIO_KEY
     bool
 
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 8ede5e88ae5e..d60dc42ab303 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -1,3 +1,4 @@
+system_ss.add(when: 'CONFIG_GPIO_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
@@ -6,7 +7,6 @@ system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
 system_ss.add(when: 'CONFIG_ZAURUS_SCOOP', if_true: files('zaurus.c'))
 
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
-- 
2.55.0



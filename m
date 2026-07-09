Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A112EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whroY-0003BN-Ny; Thu, 09 Jul 2026 12:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroU-0003A4-S6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whroR-0003cA-Hh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:41:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669GPx3x2319004
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 16:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9QebU+MNsT2OdSqbSlYYVFrJtMb+QkrQbrdiQLBQFZ0=; b=J0lcEYuJtPMqJtQz
 SP92/1GflV7Cm2SR02hcZz5QOSt3uFbG/W0cvTg3GvTiNAO6tlqIrhfbD93bd1Tj
 C4QGrpLHpXzY/ItUJCWIVkKL2a/F28eB1GwqKKIx2vrua9dawcxE3WNBSg/Qdaip
 jHO2T12wC0x4omrIXz69oX/QM33dLEuVmon3cBHkgo0kc3kj/MjJ5qx3G09CXxPj
 i6saW9fG8tHXYtJk8QvxPE5XKRamC6IppHF/DOZ9R8ipjtcJel6nEwVsyn++plyk
 3WuaQlMxCaighINvOyGjjC1E44cqo5gsckRP6e/eLnl8ZXPAWjrkucNJKkxKkCMH
 5hHQPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mr3es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:41:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso686921cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783615281; x=1784220081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9QebU+MNsT2OdSqbSlYYVFrJtMb+QkrQbrdiQLBQFZ0=;
 b=fUQNMGtZZrsO/DN98WQeUMRULyy09cRmygWn7S+quZaICS1o/+P8cWWJxXtVASh1xi
 LX2MZvWZNFfQCoxAVzYQnuBAP25oijzh+zNZYfVb7FeVDAJGxF5vzOmSnTDzIkYIkfD6
 xYqIRtlO+hNjn6ENT7CBPiuQ79EzrdGAx4pl7ST7Y0rTK2+CtBhRg4gP5Kld1MDvEk1D
 K441s6d4n4Mq1HI9x72npZnylXkU5+WTB9csoVkIOZ8CAp0qQ/eMEAZk/RNTAxCBT4jU
 3AR2deejE3g8OleLKUhWx4dq6PFa1FSdokqUamXr67oRogCbuzPeH2nJiWI0Plozpfve
 9fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783615281; x=1784220081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9QebU+MNsT2OdSqbSlYYVFrJtMb+QkrQbrdiQLBQFZ0=;
 b=suqaAAHQZ0Hu//oArJvOsruVM/Y9oITmGApimMWYPuNKny27ILtnv0SCxY2ZmN1fK7
 za595QuSoJ8CVbt+XHXXo/nfB8PsBCIY80ijuinDOmtrfkDNzfxCx6Ua0UvMc77vPmIx
 03XJi9D6nU772kEgxMew6YKXI+2j1457A1FvKCMKHVqtKJq7Fp3HGAuJygKcZAIsUwQp
 JG8K9f0leOgxETo9+zaxJ547Vi5p7iGTrSPlOHaVawByIGchtcS1GKa+2xc2DnmfJKoE
 YTI4oCEMt2gww/DkO96JCQjvwbAtxySe1HcZN05710mtzODNx2cdyq9NammeCAA82bTp
 Enig==
X-Gm-Message-State: AOJu0Yxzi8yvOmWKb058FjdK0mQpzCbHHhmhMIiSWpdzq8r5R1gGl2i9
 92cKy7lP9gzWSIjTgN0Q4JDdPHLuxmcVB03ldtRiKc04yLM1DOxdioGSsIDx/LJHNf7AGK0/dKg
 V+WL3+mcZO8i+bGIHbPB3yYPgE/L9lTjDuPEYfkekAmiuQprDEfI7V/bsqawdpx+jAw==
X-Gm-Gg: AfdE7cmcq8usjRI+tHOAL8e4LIU5nVrsylKgygZy/ykhV346gILWH8emex5xPatiyE4
 sogOxok7+Fapwi4jodnjAqf5aXoPuuTmS5d4AkXHzJZiDDv1xWFcjtRR/udcWZcQPOskCI954N0
 Dwbf1aM7Bc/TPvMbLr045bghdEJHML+xDR2WGYQT+6R/mPtGSIIxdzTVzdiWu4TNIAXmRtUBhiF
 XZIohKFUpUVTISC4rNBuU9enhwvK2rOzNwRoz+EYqfQUS4pTebXbuNHstNR0MLBdDpdHLq+lme1
 zDCLVmV9KJ6+4T6VrVwknd/9kPYLFYxArawCBTAhHBTx/C25Db0emlWjFgFSJqtp3LJK7bsYHGN
 qr7rSHCd569YkFxdp9i3diKNIw7EPIIOF6e/JoA4vVvBvdTiehr/vyZznG6hGGUcDX4Mx
X-Received: by 2002:a05:622a:1dcd:b0:51c:98f:f288 with SMTP id
 d75a77b69052e-51caa12810amr214801cf.25.1783615281429; 
 Thu, 09 Jul 2026 09:41:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1dcd:b0:51c:98f:f288 with SMTP id
 d75a77b69052e-51caa12810amr214411cf.25.1783615281065; 
 Thu, 09 Jul 2026 09:41:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb66beddsm80776075e9.0.2026.07.09.09.41.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jul 2026 09:41:20 -0700 (PDT)
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
Subject: [PATCH 2/3] hw/arm/aspeed: Add missing Kconfig dependencies on
 required components
Date: Thu,  9 Jul 2026 18:41:01 +0200
Message-ID: <20260709164103.37614-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709164103.37614-1-philmd@oss.qualcomm.com>
References: <20260709164103.37614-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o51fuzyeG9u3a9sgtsXd_9t8I2qn4Ade
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX9aO1BNlBTfrw
 fBGdvpE5fQkonHNRFuZDPnHZNkxJumwqXdVqCA9KfzRLM8WEWE/QuuDt4H51zsn64tN3vE1Y3uL
 l9RRSGtEwKEWLEd9HCLvf4ENgPlGTKc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE2MyBTYWx0ZWRfX4dE80dD+uD00
 h6CSy34H6dGb1CbQt3Abo1qdEZyzniqQBWIMMp8X6toXDYD6YQZ+XjIYjQf+fTjtCS7R6skTma1
 mbEsLireyCn1Ydmc/RAAvhVZb8FY2fEUfVZF8/AVMsozSPUHaEuIGh8NCmnRnBhR28dlJNp8WVG
 IwZTZfJw5PmI86+M2Vpfk8zPku8R2dW4eKAFkDEFSZ8OlZS2QmLjvU96TA/oPT55rBGxXd0Rjnu
 Uo77iUamwzuvc7zLtNzpl7fezAbBkCOcCo8TLV2Qv+SqM3TcQCpSznGsNPhXrPNSFMQmfEjNw57
 vZ15YGgrqJfhOk8qwH5H9JoUg1I1O076UKQwGhoVI7bYEmSmM+QqqhS1lyUYsCRupDuFCoiGnXW
 1TeqUgd99gXm3FVuvv0h2rITYaM/t5kmA7YVdgVquw0w05erCOm7f9kLetrQpIMLLyw61+bk6RB
 +pilVBKI3Fi4ivFIYoA==
X-Proofpoint-GUID: o51fuzyeG9u3a9sgtsXd_9t8I2qn4Ade
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a4fcf32 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=mjaNlZT-9ziipFgz8p4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090163
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

Add various missing Kconfig dependencies of the Aspeed SoCs:

- USB EHCI (commit bfdd34f1caa "hw/arm: ast2400/ast2500: Wire up
  EHCI controllers")
- OR-IRQ (commit d831c5fd868 "aspeed/intc: Add AST2700 support")
- SDHCI (commit 2bea128c3d0 "hw/sd/aspeed_sdhci: New device"
  and f25c0ae1079 "aspeed/soc: Add AST2600 support")

This fixes the following runtime issues:

  qemu-system-aarch64: unknown type 'platform-ehci-usb'
  qemu-system-aarch64: unknown type 'or-irq'
  qemu-system-aarch64: unknown type 'generic-sdhci'

Cc: qemu-stable@nongnu.org
Fixes: 2bea128c3d0 ("hw/sd/aspeed_sdhci: New device")
Fixes: f25c0ae1079 ("aspeed/soc: Add AST2600 support")
Fixes: d831c5fd868 ("aspeed/intc: Add AST2700 support")
Fixes: bfdd34f1caa ("hw/arm: ast2400/ast2500: Wire up EHCI controllers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 00e2d938033..6f5b2add66e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -551,6 +551,7 @@ config ASPEED_SOC
     select TMP105
     select TMP421
     select EMC141X
+    select OR_IRQ
     select UNIMP
     select LED
     select PMBUS
@@ -558,6 +559,8 @@ config ASPEED_SOC
     select FSI_APB2OPB_ASPEED
     select AT24C
     select PCI_EXPRESS_ASPEED
+    select USB_EHCI_SYSBUS
+    select SDHCI
 
 config MPS2
     bool
-- 
2.53.0



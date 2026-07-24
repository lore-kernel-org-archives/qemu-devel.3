Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869A0C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V4-000531-So; Thu, 23 Jul 2026 20:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uw-0004yw-86
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Us-0006Af-Jt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeGKg1055198
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uNvbefpG79X
 gJOOHxD0yrANzV5oPejAjg5jbPYHwwGg=; b=XLPN8z3WiFRS66/Qrb7iARJ/mBE
 BGax4hxcbU+SLpNZMWV9WeCaQmUT+5opbzKryQG0nYgSW0KamIu7RrW8ClUoIHR4
 et4X5PtHBxa+BDNrda5gPXoQXLL4f5fCxfV59kmepDnrv0QcueS+DGpPiuE0DRpx
 M2XYQpz8Qh83Pn+K7x64zI8OUIvR2L7YeRTOex20B+XzN0Y4MQ9QnWY86vDaWWZK
 q81AzWzb4KWr4K9lVxLUwrN2Y1JjzLRiOFNMmOiPaljIMf1ISKMhBuja+83LaB4z
 k6Fb96JBpLTQf8uYCoQvDcDBpZf850vo32AdjjikHOlKzLw8VMGujalMOVg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fknbmj2ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so900264a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851826; x=1785456626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNvbefpG79XgJOOHxD0yrANzV5oPejAjg5jbPYHwwGg=;
 b=OQRNn8SIduZ7kqdXPt14x9EpI8BmN/lGXhZOzrCMtzqCXP7PThwMGDypzeAsCz+T0E
 P2PNuGAZ3Knr1uf4i9pec6Ej0474+gZaZCvwq1yi609Vp3MlwWabhl2IcMcfOfAF2XSz
 WMNb9YQaPSLXrPjsz9GJZUjSKc68yqqj2Ay8UUgzqbJdIiJc9m+Y8GASoiNrOfNtsafV
 mdz98Kggybvmp6i5KWB2Ugx3h41QpX5BnW/vIGsAkuBVmQR/piayMDtvnA3lKMu1llXe
 tZU/raDkhNvA7cDWcuK+v1hUyrfALCj83IL5mk67nteYl9wUTSPUSHlg6xPKzIc3W6QA
 lOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851826; x=1785456626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uNvbefpG79XgJOOHxD0yrANzV5oPejAjg5jbPYHwwGg=;
 b=TxyrMrV/Km7FvgbsnmTcBGx/un2clZ9BrDK6FgK+t71VmA8Gy3eDeTi2cdnF9B++IT
 Cd8Qzfn+vIOm0Eze5b+Pnxn1zTBZhtP3pit+EeD9uAbG9eD8FwYJBpcAxWrPrsMpObgR
 PfzRSL4ZP95lBCP85Fd25SVKILDA1+h/piEztajY4I3OC+NkZAfdIlsZNV5ft86093wq
 h1EpJLbxtvf1N9XnKro80mifyx7GKUUTnVKpiigk+NpwPcDEmxGSrPcBAejDgR3fKe8v
 DZlYvoc4Cofovr+6/dTr/a1FGUJjP8vWr1YTO6IFzrisTayrLEHY18EMLzc6d+IAnWhN
 3/nQ==
X-Gm-Message-State: AOJu0YzioddVUJER9jg70qpYOAu9xCITLcelrlpV2rc4GVClfGfPwJpz
 qcHsXSQ4Pski0S6IjXow93bAs0IFPop1cLbwWJcOnK0vbtg6LVdGqCJJ/dBBf/vogiw3pzfUVWc
 1h1RFlGb/gNC2JhkjDQr3//fEsuviknw7bxbTke40A8JPNux2hGlgv7veaRHBXDPpSg==
X-Gm-Gg: AR+sD138ZPHF1DanfhsoPGlrTdLrqCyVIoqHKQD2qjp7Pd02igqIiJa18TN1DR3uaEX
 6wAJ/bGfAX2HFNmvmVRgYq3Be3cWYiH0uoDeP+Il2zmdNzvPEg55lieo6/kmsXNFZ1zlgHs8x+x
 uDNGQaw4tkAzVQnzqm+pQ/mV4HyjwdxNQwa3kjrkeczUnCZjxnPFazeernkBayVJVCJ7EjyGftV
 DTR+MOoUaogUueVuuUR57NO0pWTiaKTDC2WxNb8XYoh+yGjXGyjp2lxJvh/4WYQqn7Vm9AUAaU7
 ndSOhRZCG+2bLuftxdqNQDkwY16tt7qWd4TNQhGl6VFRepW4AI6hD5Aczx1J2/AneZTOzOqBKjc
 6aVIoUYqbFkkcdQ+A5JIwvubVcoZdBnbwRWnkHucuYNNgRDY2BGxf62DlOAGaPtZn8dEA0+4=
X-Received: by 2002:a05:6a21:1f8d:b0:3c3:8d4c:667a with SMTP id
 adf61e73a8af0-3c44afc3a1amr6039385637.18.1784851826097; 
 Thu, 23 Jul 2026 17:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f8d:b0:3c3:8d4c:667a with SMTP id
 adf61e73a8af0-3c44afc3a1amr6039343637.18.1784851825367; 
 Thu, 23 Jul 2026 17:10:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 21/27] hw/arm: remove machines-qom.h
Date: Fri, 24 Jul 2026 00:09:41 +0000
Message-ID: <20260724000948.234657-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e742j6p/ c=1 sm=1 tr=0 ts=6a62ad73 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=zGOHuIfDRQ6MhNDD-BEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 6jjDsLcyIFEYEfDOKgXUnmsQhbjtrcjP
X-Proofpoint-GUID: 6jjDsLcyIFEYEfDOKgXUnmsQhbjtrcjP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX6BLQeT0OMkP3
 kmxT+Xd5WWRmFpDzA9z4vhZQKP4mjBoH3MZFO3sMmiifWzyLyQy38DwrmTpdQHBkbL2Apx+9E8B
 9RweUzJJMdNf5Zgfu8CoUeHPH/6Whfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXyakqHSmwkTEp
 oNkDhrSJfPBALdui1GjnrFCe6kCKfMHhcXkB9Miir5KWfTRt91QvN5slG9hHlj/yoXZ0EwVmWms
 9JzE8DcOn6tcSPzI4ecDofOd1r73wEsWpKn1BdUQiZGo2ZIemLMSAJPuKjaMGysLCReuE995mxU
 uNSrcodWCsDzBjzt1bPMqqTxCSTjzSpGxgf7t0E1VCEz1iV1QzA5wFxFWDZTHWqE/b8+vPb/phY
 J3f+WBkih147Bw1rZ2JdKdcWspOkVVlyqLxMAXU8x0PkbQJofdiIaq9qGZlWQ4DBY6JQsJeY3MM
 tdMPS9unIKoT7vnvory5LGRXXWo7gZ2ZTMaDe+8ouD7Be4DQ5pyyuNO2BnQLC8XdMxHC2g13qRW
 n2VSuWlooDbR9G63as/ZAJZsZ16HD51jqiTdFb+aE+SbPYNzTDyTBXNwKPEA9XFWUjw1WmoAABs
 ZUcaf65PsZNiaMx2AkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c         |  1 -
 configs/targets/arm-softmmu.c             |  1 -
 hw/arm/aspeed.c                           |  1 -
 hw/arm/aspeed_ast1040_evb.c               |  1 -
 hw/arm/aspeed_ast10x0_evb.c               |  1 -
 hw/arm/aspeed_ast2400_palmetto.c          |  1 -
 hw/arm/aspeed_ast2400_quanta-q71l.c       |  1 -
 hw/arm/aspeed_ast2400_supermicrox11.c     |  1 -
 hw/arm/aspeed_ast2500_evb.c               |  1 -
 hw/arm/aspeed_ast2500_g220a.c             |  1 -
 hw/arm/aspeed_ast2500_romulus.c           |  1 -
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  1 -
 hw/arm/aspeed_ast2500_tiogapass.c         |  1 -
 hw/arm/aspeed_ast2500_witherspoon.c       |  1 -
 hw/arm/aspeed_ast2500_yosemitev2.c        |  1 -
 hw/arm/aspeed_ast2600_anacapa.c           |  1 -
 hw/arm/aspeed_ast2600_bletchley.c         |  1 -
 hw/arm/aspeed_ast2600_catalina.c          |  1 -
 hw/arm/aspeed_ast2600_evb.c               |  1 -
 hw/arm/aspeed_ast2600_fby35.c             |  1 -
 hw/arm/aspeed_ast2600_fuji.c              |  1 -
 hw/arm/aspeed_ast2600_gb200nvl.c          |  1 -
 hw/arm/aspeed_ast2600_rainier.c           |  1 -
 hw/arm/aspeed_ast27x0-fc.c                |  1 -
 hw/arm/aspeed_ast27x0_evb.c               |  1 -
 hw/arm/b-l475e-iot01a.c                   |  1 -
 hw/arm/bananapi_m2u.c                     |  1 -
 hw/arm/collie.c                           |  1 -
 hw/arm/cubieboard.c                       |  1 -
 hw/arm/digic_boards.c                     |  1 -
 hw/arm/exynos4_boards.c                   |  1 -
 hw/arm/imx25_pdk.c                        |  1 -
 hw/arm/imx8mm-evk.c                       |  1 -
 hw/arm/imx8mp-evk.c                       |  1 -
 hw/arm/integratorcp.c                     |  1 -
 hw/arm/kzm.c                              |  1 -
 hw/arm/max78000fthr.c                     |  1 -
 hw/arm/mcimx6ul-evk.c                     |  1 -
 hw/arm/mcimx7d-sabre.c                    |  1 -
 hw/arm/microbit.c                         |  1 -
 hw/arm/mps2-tz.c                          |  1 -
 hw/arm/mps2.c                             |  1 -
 hw/arm/mps3r.c                            |  1 -
 hw/arm/msf2-som.c                         |  1 -
 hw/arm/musca.c                            |  1 -
 hw/arm/musicpal.c                         |  1 -
 hw/arm/netduino2.c                        |  1 -
 hw/arm/netduinoplus2.c                    |  1 -
 hw/arm/npcm7xx_boards.c                   |  1 -
 hw/arm/npcm8xx_boards.c                   |  1 -
 hw/arm/olimex-stm32-h405.c                |  1 -
 hw/arm/omap_sx1.c                         |  1 -
 hw/arm/orangepi.c                         |  1 -
 hw/arm/raspi.c                            |  1 -
 hw/arm/raspi4b.c                          |  1 -
 hw/arm/realview.c                         |  1 -
 hw/arm/sabrelite.c                        |  1 -
 hw/arm/sbsa-ref.c                         |  1 -
 hw/arm/stellaris.c                        |  1 -
 hw/arm/stm32vldiscovery.c                 |  1 -
 hw/arm/versatilepb.c                      |  1 -
 hw/arm/vexpress.c                         |  1 -
 hw/arm/virt.c                             |  1 -
 hw/arm/xen-pvh.c                          |  1 -
 hw/arm/xilinx_zynq.c                      |  1 -
 hw/arm/xlnx-versal-virt.c                 |  1 -
 hw/arm/xlnx-zcu102.c                      |  1 -
 hw/core/null-machine.c                    |  1 -
 hw/nitro/machine.c                        |  1 -
 hw/remote/machine.c                       |  1 -
 include/hw/arm/machines-qom.h             | 16 ----------------
 target-info-qom.c                         |  1 -
 target/arm/machine.c                      |  1 -
 73 files changed, 88 deletions(-)
 delete mode 100644 include/hw/arm/machines-qom.h

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 381a9f686a5..9efeb366e3b 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 4f946708864..8785ea01824 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a48c4420583..fc57ad168a9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -14,7 +14,6 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index a15c8a15335..4a31c1a3261 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index 8dff7d54f31..f7048a260b6 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 36bed532328..6521cac69c9 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index b8d0510a7bb..0f7a7e8d29e 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 485d747f27f..ba603977a3b 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 10f52279425..d278bc996ec 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index b0f9649a7cf..4c33de3838f 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 7f926b3a496..a6385ea0ccf 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 2dacb65362f..c44b55da1e8 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 7fb25532cdc..09cba4896b6 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 8545f1f97ba..d263d0e5b6c 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/misc/led.h"
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index d7a1090ad65..34b249b5933 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 70d42297287..9ecc12b40b5 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index ba7dd554d7d..42b4f048dde 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/gpio/pca9552.h"
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index e3e540ec0d9..fe43b39a51a 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index f32a9930e5d..e11c4cc6a2c 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index 12b52795b6e..2907dd94076 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index eb901686b74..fe11aef9a51 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index 27cd80509b0..57040715695 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8e18d710e75..0553a6cb600 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 4c11c0fbf3e..f0fd94f33bc 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,7 +22,6 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index eb2b52a9b0b..ca255a4787e 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index aa626aa1e58..d847f41b9d1 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -29,7 +29,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/core/split-irq.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/display/dm163.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index b96268ef0f3..be44c5b955b 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index ace8f908703..332912e9d37 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -15,7 +15,6 @@
 #include "hw/core/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index b80cd4ade7a..2340a691dd0 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,7 +22,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
 static struct arm_boot_info cubieboard_binfo = {
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 1210a6a888e..6b6085fc5f2 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -29,7 +29,6 @@
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "hw/arm/digic.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/core/loader.h"
 #include "system/qtest.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 8007ac8e76e..0c6dca31efc 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -28,7 +28,6 @@
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "system/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index b9113ee983a..05cc7bc7517 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -28,7 +28,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index f660015e207..9b510e67fff 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -11,7 +11,6 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mm.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index b37a76e1529..bf54f3e40c5 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -10,7 +10,6 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 489afdaf163..c10deee12e9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -13,7 +13,6 @@
 #include "migration/vmstate.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index b97ef4c932c..6cc72c04632 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index a39cb001ce2..ff5463127f1 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -12,7 +12,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/max78000_soc.h"
 #include "hw/arm/boot.h"
 
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index cbd41056522..c8518d0c5f0 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -14,7 +14,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index f4e31407fe5..87a63840627 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index bd93c3f7798..98366a277cf 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,7 +12,6 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index fb857209659..2cf4054c431 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -52,7 +52,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 5249248eb52..6cb04645318 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 6b7392769b0..23db8b3f089 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -37,7 +37,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 67d7a8d00de..5d2228b71e7 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -32,7 +32,6 @@
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/qdev-clock.h"
 #include "system/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 20acc80b378..aa6a05c6008 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -26,7 +26,6 @@
 #include "system/system.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a3f98ca95a2..ef4357edf64 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -15,7 +15,6 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index d9b74b9065a..d5651b5fb8b 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -30,7 +30,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (120MHz) */
 #define SYSCLK_FRQ 120000000ULL
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index c0ef997184c..1bc324dbc85 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -30,7 +30,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (168MHz) */
 #define SYSCLK_FRQ 168000000ULL
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 6237cd050d9..8242b995fd0 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -17,7 +17,6 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/npcm7xx.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 132b10961ee..b88e5cee3fb 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -19,7 +19,6 @@
 #include "chardev/char.h"
 #include "hw/core/boards.h"
 #include "hw/arm/npcm8xx.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev.h"
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 9dbae8238b3..0e3d4182b5d 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* olimex-stm32-h405 implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 475ec4007a0..7071eb341df 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -32,7 +32,6 @@
 #include "hw/arm/omap.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/qtest.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 9cfc1e077e9..c5900eb2a29 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,7 +26,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 static struct arm_boot_info orangepi_binfo;
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 71f2493bcb9..18a2155a025 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -24,7 +24,6 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 515f6296ca3..16c471846ba 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -11,7 +11,6 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/core/registerfields.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 1319316a56f..a83eb28abeb 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -12,7 +12,6 @@
 #include "target/arm/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/split-irq.h"
 #include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index e48eb10b2d2..0975f83eaa7 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -14,7 +14,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2879aca8818..28bf1e30fec 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -35,7 +35,6 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/core/boards.h"
 #include "hw/ide/ide-bus.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 9bae6325501..a8e914e457a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -15,7 +15,6 @@
 #include "hw/sd/sd.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index b87b57da61c..39746a31fa5 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* stm32vldiscovery implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 0c84669236a..922f76bb113 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -12,7 +12,6 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "system/system.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 25b7bbb9b6c..a768e6e13a7 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -26,7 +26,6 @@
 #include "qemu/datadir.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e6d44cf25fd..daba9af79f1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -37,7 +37,6 @@
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/virt.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 6ac4fc16602..cc60a2d49d6 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6b6bf37fdec..ca9f074ace6 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -20,7 +20,6 @@
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index b08682f1e9e..e33a2233313 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -21,7 +21,6 @@
 #include "hw/arm/fdt.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b3383a2bb83..1a418424555 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index c1ecf3214fd..2aa748233b3 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,7 +16,6 @@
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 2d001a32fe2..be2b5bc5401 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -31,7 +31,6 @@
 #include "system/system.h"
 #include "system/nitro-accel.h"
 #include "qemu/accel.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/eif.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 932d14e53e9..188647fd4ed 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -24,7 +24,6 @@
 #include "hw/core/qdev.h"
 #include "hw/remote/vfio-user-obj.h"
 #include "hw/pci/msi.h"
-#include "hw/arm/machines-qom.h"
 
 static void remote_machine_init(MachineState *machine)
 {
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
deleted file mode 100644
index f64de7bfc8d..00000000000
--- a/include/hw/arm/machines-qom.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * QOM type definitions for ARM / Aarch64 machines
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_ARM_MACHINES_QOM_H
-#define HW_ARM_MACHINES_QOM_H
-
-#include "hw/core/boards.h"
-#include "qemu/target-info.h"
-#include "qemu/target-info-qom.h"
-
-#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index d7b8fbd4fcd..30982d9d18b 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -12,7 +12,6 @@
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/machines-qom.h"
 
diff --git a/target/arm/machine.c b/target/arm/machine.c
index b5eeb586007..f8636d2606e 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -12,7 +12,6 @@
 #include "migration/vmstate.h"
 #include "qemu/target-info-qom.h"
 #include "target/arm/gtimer.h"
-#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
-- 
2.43.0



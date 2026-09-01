Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6228EC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyi-0002Mf-26; Tue, 01 Sep 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyg-0002ME-NS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyc-0003WZ-Qq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgZgH3737589
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XMSZUSsRfdV
 ngwDJ/jb6PEq/TU7trbYnSOSZI86aZ8E=; b=baomW4u+XhRbKJUuBmfuwxi077h
 XAu1bmxZUNzyh6SxGcmzoQGhzpy+zHwL/bRIWiPAHOF+wPkwDPlkA9D0ugJ6nIXZ
 UPkQqPogGESqVuEa+DKTjsqYivBNayu4oJG+Y2RJGEq0MAUFi1NwM9FpZ86h+LRv
 8pYfu7Wcbfi6AT7MylE3k27SHPXjFxBe2k01PD33zoe9aaUtlc5D6H0JxWZIj7mB
 Vm6BqGxblVrKVGJGMT5Ax0HenHEbb8S305ZiXnv0otQmxUxeuu/B9uQy39unMyAY
 ACq6kNnbHtmE6B9qAcVVfLPUpOQ4LFyC5s1ZCR5RIYX06QmTUcaGowoHZOQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdynt1x0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:21:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso595226a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294061; x=1788898861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XMSZUSsRfdVngwDJ/jb6PEq/TU7trbYnSOSZI86aZ8E=;
 b=Tokma8H+GSDA26SH/E6sMpPU92CqRcYzpe/nI9Psr6/t+iCFnOC3QU4mGzu4TMvxtC
 dJ43UUA5ST6VNZqLEHUpb+n4IMHkPMnpig5+A2bvz55afjQIhkwPk6pAbSvT2BNkSbsz
 9idTcIqmPEfqRHxl53RA8sMV2ikWhgKouC0U/t3JO0ouuEOeWIyXgY07AW52hIw3CZ0g
 Y3cbW3d72LGHXN0OiHxgfIzzCPFuSu+c1nffq7rJfG8+GcCOgZgak3tpjduU9cHquSh+
 tloW4aPAicXUQRSxV0wJWwKgbrE1NxCRjW0DE4Eqaht6w2C+I7EX11XfV+G9cBRe/xG0
 R0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294061; x=1788898861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XMSZUSsRfdVngwDJ/jb6PEq/TU7trbYnSOSZI86aZ8E=;
 b=nJwWUzmS7g+Ff2L/QliiS8nJFrH1Zl66O7xiLKbrP4VhLnVxmTUr4dQvZusrzIXA1N
 Ji/PnRSaztzQvHrxShX5Jcw1d2yw6ygs5Q/+JPGstkY/TO2ynxTXxJ8RYL1uRy84Y3m1
 IdON27BoY3OP9iY1XG3zP+hruGWe16kqccpNgiQCjiRZbVGmUhVyn03tKeqHAMCFGbpV
 9TbUoKnncoFM32Wl6S6OqqV55JL5tjSdZECz6zwmjbRB2Ku4Al3gavEDaDUf/WrOzMrr
 Llrb73JoZM/9ZSmNlSFEFXywv6Nghr7wsenf8supyWc5/iIUoU2xQXH9OCK6wA44+pK9
 m5FQ==
X-Gm-Message-State: AFuF++moC1nqUQa4w7ekkI+Nynu16loLOX5tauLyBoXBK7vnLGOi09+n
 N7spGVAvNTxcYjELuECnOs8DXE9ZXAaxFfWIauYpXiiQrQGqGFuyqQbVZ9p4ILAFGRajIJwFhpc
 vYlERTJ7UC148mpQGlbVjo6pRqjro8KbEzM1EArf62x7e3YXP4GgeytIwAOTpwg4B0w==
X-Gm-Gg: AYBFou3cYxQ/KUVxDJUpFh54DmUAh4EpzD9rOoVACeghfc9N3qwfZ+w1DIkWKoueqCo
 giKS0PJAfz0IHjOoyOaTHczdMuW2KHBszsy/mhrBcBLATqMk9Woqf1IV7KLfZq3MAmM+SenxZP4
 q/GhIDRIQPqnenPPIQDoaDFkF5rq5RdR/TCQZUNdCKpAoZshUfmVtnkuvuauWjUr3ZTIYQd45b7
 VaKWDqYUeDZX1K/9Vv3ze0b8l0AQDbW6oVI3bj1gkttDv+MOkxt5qCBr4Aqq8pSHJ03SRuigdiF
 FfXwW6hKr/NrNL02GnIyNoXpM4G4UlA1zzlQDpFmCpdwICjRdrodB8RoNj4Zps6TTBfYa+m37FO
 gFkr3zT9BtJHrKZOhY109iX+sulKqXFmyVg8z5yAC5wifnF3Vli2fyNKwu0Y=
X-Received: by 2002:a17:90b:590f:b0:398:9be5:b417 with SMTP id
 98e67ed59e1d1-3989be5b4bdmr44330668a91.18.1788294060344; 
 Tue, 01 Sep 2026 13:21:00 -0700 (PDT)
X-Received: by 2002:a17:90b:590f:b0:398:9be5:b417 with SMTP id
 98e67ed59e1d1-3989be5b4bdmr44330565a91.18.1788294059631; 
 Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/14] hw/arm: remove machines-qom.h
Date: Tue,  1 Sep 2026 20:20:39 +0000
Message-ID: <20260901202043.26532-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX5WFJIacuZyY4
 60+jd4vvm57DCFGSUvL7GUevL+1RtWvgPu8BJMXqOdkp+Nu/SiCu+MrJ6QUXuyAU0JJV+IQUYd/
 xgtmklUfvv5ZqpqNVOEXGO2dqoMvY2HV/09AuecfxR4YkFIc4HNZsTf58nJ2gRpLS42QJCHLkIW
 jvYXwVxScg/3uoB142d1m2Dv3w8nli541L9laNw5IaXKBRDSJUSSpIBp0dcy7sFh4BEHCq7Ajy8
 x163VMhQywHHGlAJNfcmJ3PSWbVNcf8EZ5mjiPUCz7FUxgpnx2TV/ZpuGhHYm4pDm/lPjsp5c11
 5YEGxfPohSbkXjh0z1QgjW5q0R+XcnD+bW7cgJDrnExlmXGQf+TD77uh5fCn/IFgHb6w+dkiHP+
 rR/OECHNKColLSSK36YOeZEs3CSmzqS3IWTaD0tR/neCeqHW0/iEAwRMXpzmeHzabHJYnEF07yy
 9JDHW11bu+YP2vYEm4w==
X-Proofpoint-ORIG-GUID: 2R7N_B97m5HP12uCNU7OA6QZWv6sgrld
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX51kzeVN3RCfc
 E/xnPJ+e5Ec/MtuTTPmE1qRSo1Q1lNuzFC53u2Fl3Z7k4go0ofxmNi4V/hhznZdek8MQda+YyKs
 8HQmGLXTkp6FPrAC4OyshK+MzfWPjz4=
X-Authority-Analysis: v=2.4 cv=LfkMLDfi c=1 sm=1 tr=0 ts=6a9733ad cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=oVOCmnCwC0CRNczbz68A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 2R7N_B97m5HP12uCNU7OA6QZWv6sgrld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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

Header is now empty so we can remove it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
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
 hw/arm/ax3000-boards.c                    |  1 -
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
 include/hw/arm/machines-qom.h             | 14 --------------
 target-info-qom.c                         |  1 -
 target/arm/machine.c                      |  1 -
 72 files changed, 85 deletions(-)
 delete mode 100644 include/hw/arm/machines-qom.h

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8fa16b3831c..a7cfbd6c5e0 100644
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
index dd68f9e25c7..486f0f6a1ba 100644
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
index f377e955adc..c937bb74665 100644
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
index f4918683c3d..e2350e5b6ca 100644
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
index e1ddf682315..e8cbbb8a052 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 86d49fd1dee..c75898cc6d1 100644
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
index 5f616252e0b..6ca2a36322c 100644
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
index 3c654c62dd6..00bb1c61053 100644
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
index b2ed623f680..340a74408b6 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 77fa028b096..5a7e49d6ccd 100644
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
index 1771f376480..6cb567526c4 100644
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
index 4cc349c3236..26ddb673470 100644
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
index 48c813f3c8f..3ba1ed5f6fa 100644
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
index e82f5c98f26..697be58b0e4 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sensor/adc128d818.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 9dda83ad4c0..2822f6bdf5a 100644
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
index f91e0635908..23636ab6985 100644
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
index 404083b61dc..8a17c4453e9 100644
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
index 6bcda0ac630..65d98fafec6 100644
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
index cf49149fe9a..8a87c2dbee3 100644
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
index 705561afe39..311feb82023 100644
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
index 6e5debc8bc1..43a8f01a9e7 100644
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
index ccfa4ade265..73362b60d2a 100644
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
index 0deb3127c21..460c9ff0d2e 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index c7248f9f52b..dc98ee7b71a 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "hw/arm/ax3000-boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 04dce2d19ce..de19212ab85 100644
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
index 15c878d1636..8f59111fd4e 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_BPIM2U_MACHINE MACHINE_TYPE_NAME("bpim2u")
 OBJECT_DECLARE_SIMPLE_TYPE(Bpim2uMachineState, BPIM2U_MACHINE)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 4b930e6ba12..ca6b3addb7b 100644
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
index 511b71fbd7e..ae27056938f 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,7 +22,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
 #define TYPE_CUBIEBOARD_MACHINE MACHINE_TYPE_NAME("cubieboard")
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index c7ecf22a958..90c19106ad0 100644
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
index 62f7cbe875e..78632877df8 100644
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
index 3246512c214..243c30a67e7 100644
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
index ffe8e494a57..8a5737502fd 100644
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
index 389e7c86d21..3f376f86d91 100644
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
index 25ecd931e76..382ea7850d8 100644
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
index 909dd929e63..387bf54ced1 100644
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
index 290a14c8ad9..ed50bb91979 100644
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
index a3dafb20131..40071d2c7b9 100644
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
index cb4536faadd..db8a62e5f6c 100644
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
index 85285861c5f..c1a3f6903fe 100644
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
index 865009c1e0e..d767207e2e1 100644
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
index b13b7bc55ec..35d867328a9 100644
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
index d6f4c1640ab..eedb877e4bc 100644
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
index 8d00fef43b0..1372d7f628a 100644
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
index 1b161487e7e..571bee1b72b 100644
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
index 84d20bca72b..e1a336e861a 100644
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
index 6a639264d61..0db8798b4bd 100644
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
index d04ab8aeea4..5ac0eb81637 100644
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
index 025de42dac6..9c526a26839 100644
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
index 2a04cf4f2c9..4b3af165034 100644
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
index 154501fc3c7..de9ac4978ce 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* olimex-stm32-h405 implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c3fe4187b8b..a7e469ea6a3 100644
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
index 3f06716c364..7a19732f5df 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,7 +26,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
 OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7ff3e8400e6..fadbacb2534 100644
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
index 08fcdf58c9f..7d3eed96304 100644
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
index aee7d05c3e6..ceba0331b08 100644
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
index ec307388f45..05dfabd9376 100644
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
index 06a0032a1b3..bb9570f6db7 100644
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
index f634918868b..f41315e1928 100644
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
index 0b39543c1ff..d899a134b38 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* stm32vldiscovery implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 1db9bc1eb24..f94bf96599e 100644
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
index 1e29fe0f09c..914cda66d20 100644
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
index 40650a5ecbf..f40ec93ee9f 100644
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
index b47dd9efd81..f05956c1662 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8ebd8e5ccd5..c1897ab1cf3 100644
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
index e06a0c55549..4018f2bf7d1 100644
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
index da8b3ede873..bb596218540 100644
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
index bb8878299bc..88d01960a01 100644
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
index 6580e0d9683..ced782f6a9c 100644
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
index e3eebbdefbc..00000000000
--- a/include/hw/arm/machines-qom.h
+++ /dev/null
@@ -1,14 +0,0 @@
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
-
-#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index eb9491338ca..7959853e0da 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -12,7 +12,6 @@
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 61106f9def6..7005f4e5d77 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -11,7 +11,6 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
-#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
-- 
2.43.0



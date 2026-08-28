Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A91C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Y2-0000QX-De; Fri, 28 Aug 2026 18:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xy-0000Jx-3g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xv-0005ko-Mn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTLEX3776092
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qc9JH3sKH10
 m6l2azd877++QjvYXSajPRX0RNPFg1hU=; b=oV4Lg9KqTuO2cNKbT5FtP+smi12
 B9FPumofVykc8+6DD2q/c9yEE11z5Lmi4iNVcwnXHpVsO23v+QZEAF1YUSbz6BnV
 FwL1+RE3lcsGZDz13bCAYR/oe0N/0xtzNc90Q2LwSkv+qVfat8DQ9t4hHj6Opj6f
 jtHt8pKW13kdN70paCUmOnHdnh76jJ5Rg7rCRMMiwtzq1HVtO7YoXgSq1tDcHnrK
 0EK5o9qgeIgcab6Fn9mmz5b5dG8pCLU+GMRdRoD61QOlE/857Vc3rrrE1tn/Y5Vf
 OvyevJNaN+iggNXY8wGwm2OI0yjCLkoEPqyi/ux+W5oPD/vTJ5V5IhI1eMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er83m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-396901263b6so2402398a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957967; x=1788562767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qc9JH3sKH10m6l2azd877++QjvYXSajPRX0RNPFg1hU=;
 b=Qhxqm7forzetL07U7U9+gLvCMSFd+iGdi1p5OnXO4bF1vabXNLQKfQXoJ0jIkZME0t
 cLxfbx4thaN/I8AtUmhC7EQAVVrt+TmxIUpvBF/6UQaewu24nykmHT42Fw6UEZb+6xgo
 sXm2ql4qKXEIxdXsNEKwzl70R7axm7LCVzk6jl8iUeULJVGqOFYbswK0YqSto2YeYf0b
 rr/AbVvyMwQsGWAv5eYiuChWxD8yiHQzy6Vyin5eXPRrYAq2jmFfv9oatGIqdT++RRvC
 ckyL7tkCv/v6kHkLPgq+dDHdEAP+hKYnuA5Q2fbVwCApyVl4yvtyJDQhzCJGbZ8f4Gg7
 Pgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957967; x=1788562767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qc9JH3sKH10m6l2azd877++QjvYXSajPRX0RNPFg1hU=;
 b=Jj95UthmFeYORH9OcW2xTZBHUDFDSnwEV5I/qf51AmWmNfHAuEFzP52VwkKAAgsMqd
 dq4tvQiNTPsF2SzXfSis0Y23FmDG0nJTIV/nwdFoSwVu+PEEgfadwGXI27pj2H7tt6GS
 HVvSF+KRUwQ0bTLjK0vdS1phIyUffhvXWv9GKhLxP9CNgAxOTxmOVoYmKpDQD/KaNeri
 /Ctl2vjQWZVWCe/b4hgLohSZZyl1uoK65aRbqywWkY0NAP9R+VnoxzINIK8y5QYFrw2j
 XcaUPadZM1hwAsyD8S6KjzfBqD7EQNBPuVVxt0yPTIwTtSnY+ygLikG5VypHqwBC2H0j
 zGgA==
X-Gm-Message-State: AFuF++k9TZJzY3VxjfWQ4tzHnmJq09zXZoRQOTHjJC/5OjzSrToKkpGv
 6NkqZPoUtDqR3E9PxmLkJXeby22RkiIr46CqQUTIZI+jR+N6PJhoRxrK+E8BLUwyT1yS+bdzSWM
 2NRfYH5Nkivx2D9oeSiwOZapd1P/5qIdF+hvBRhTqbqcD4Kccg7+aHvdJCmaAsvWqaA==
X-Gm-Gg: AYBFou04Zwm2nBv0fI8iBSsxvDTjOt9qMlPc1S9Z51xIDIJra454J3sllFNYXGcN8Jq
 8JzO1WCAxshHO6EM1R0pksG2GtB7oLTkTryVuVA1Akrsxw1CXxJOCpQOCUeAB1/y/JHeOGl4Jer
 ukLZjPkbhPY6+odrtCQ+YUVHqwCYNkyfNk/NAHGZXw8ijQL4xnn4Wr08ZZniV+v7yJkamnit3OG
 tZl5yJLiWCrCeJgxyzrlVVT6s15iYB2eAPOPi0bmdcx646WFfCgve1id2Ho0pJ7oEcoxOcu7e6v
 cLg3kFvDqglKn0/tPUKYKnVSAu9eevW81FNOzUKciPoRnXcHH3X1lRzk/bq4mjLdptPLnE3Sf3E
 hmKfbSNwuiiM+ldoco3xhlX+ktsgPrlJDsAexvyu9i8uHh6r925jl3rUxegY=
X-Received: by 2002:a17:90b:4a92:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-396d0f75f22mr18202546a91.9.1787957967408; 
 Fri, 28 Aug 2026 15:59:27 -0700 (PDT)
X-Received: by 2002:a17:90b:4a92:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-396d0f75f22mr18202487a91.9.1787957966904; 
 Fri, 28 Aug 2026 15:59:26 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/47] hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
Date: Fri, 28 Aug 2026 22:58:31 +0000
Message-ID: <20260828225901.367438-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uumSTFE4zhTmXzN7jw9hv-ikMJCls18d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX+JUJiGcVx+QW
 WUZ5Hh/RcWdQLHPrPKjD12HR5eabfl2pBDY0C2+E+9xE+Q4qd3zdc/1MkpJ5iIiHb6HXwbH7Owk
 lFoXI5xpBusRWI1yefOLhPOPXOFQoHgpuH58fWXibtIlFCUqXfUgIhYHl0GrulorCaato03qXPb
 frWCtatZuD86XdwYXhY6dooS5WQCnEw5BujvBetDJmzHBZbPWRK6T2zhRiirs2ltvbWz7mlxiS/
 iKavkr5Lce7JqEOix3FaHoxTqKrpREWr5TaMKugjRhGgt7HcBooI8RygQiqf0BHgXWr0w/Ixjqt
 EiU5FE0vWcXBLsb59CZVmpLHlNHk/nWUvMcROljROgrezs6Vma/dVdxmwaezIQnjtQDaELEtUU1
 3ubXb8JWVIpx2Rxs6lFdnTrWmghgaj+GITprkJUMmF+UcEw47cXs2O9+qwYr3YD8u9nzVp9Sw8q
 dMFK0U7eCOM5gObqTIQ==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212d0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=vQY24nbS3a5ORmXlo28A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: uumSTFE4zhTmXzN7jw9hv-ikMJCls18d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXxjHYaA/tgiEa
 kuSWu9xokYkVhPvWncVsLZBdT2+G/naUJuna37POBRZnHHXkz6TPWQMkMRGAxPzUPYjbyb09eLF
 oSnAS//6SCRtKCe6TYbffptTKvxM5yQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
 hw/arm/digic_boards.c         |  2 +-
 hw/arm/imx25_pdk.c            |  2 +-
 hw/arm/kzm.c                  |  2 +-
 hw/arm/max78000fthr.c         |  2 +-
 hw/arm/mcimx6ul-evk.c         |  2 +-
 hw/arm/msf2-som.c             |  2 +-
 hw/arm/netduino2.c            |  2 +-
 hw/arm/netduinoplus2.c        |  2 +-
 hw/arm/olimex-stm32-h405.c    |  2 +-
 hw/arm/stm32vldiscovery.c     |  2 +-
 include/hw/arm/machines-qom.h | 14 --------------
 11 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ed12f542001..c7ecf22a958 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -146,4 +146,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE_ARM("canon-a1100", canon_a1100_machine_init)
+DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index f7a51481af0..3246512c214 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -150,4 +150,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("imx25-pdk", imx25_pdk_machine_init)
+DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 1aa5b49de92..909dd929e63 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -138,4 +138,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE_ARM("kzm", kzm_machine_init)
+DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 530ca9dd964..290a14c8ad9 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -48,4 +48,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE("max78000fthr", max78000_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 6e9d92b1f1d..a3dafb20131 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -78,4 +78,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("mcimx6ul-evk", mcimx6ul_evk_machine_init)
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 1ada1a13613..8d00fef43b0 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -109,4 +109,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("emcraft-sf2", emcraft_sf2_machine_init)
+DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index c32deaf43ba..6a639264d61 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -66,4 +66,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE_ARM("netduino2", netduino2_machine_init)
+DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index a90dcbe8c26..d04ab8aeea4 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -66,4 +66,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("netduinoplus2", netduinoplus2_machine_init)
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index e801e4308ed..154501fc3c7 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -72,4 +72,4 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE_ARM("olimex-stm32-h405", olimex_stm32_h405_machine_init)
+DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 8f93c0036a3..0b39543c1ff 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -69,4 +69,4 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE_ARM("stm32vldiscovery", stm32vldiscovery_machine_init)
+DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 449592beda0..e3eebbdefbc 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,18 +11,4 @@
 
 #include "hw/core/boards.h"
 
-/*
- * A machine defined with the DEFINE_MACHINE_ARM() macro will be
- * available in both qemu-system-arm and qemu-system-aarch64 binaries.
- *
- * One defined with DEFINE_MACHINE_AARCH64() will only be available in
- * the qemu-system-aarch64 binary.
- */
-#define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
 #endif
-- 
2.43.0



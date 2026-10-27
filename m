Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A0606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dhXtFCG3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LbrtnCCY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmny-0002zh-Ex; Tue, 27 Oct 2026 15:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmn2-0002Ke-CG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmx-0001q1-6I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPol3553880
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w29Ypi4oSViCbtK99W8qKVU81/HO03HjG7qv3E5a43g=; b=dhXtFCG3JPzXUb9m
 oxkqDqJt4xxOyk2ShY1QjVAmxjaA2AHBZ4OoZDQoL4jJW/Yxp3fNYUjX2UkihCC5
 CGmCx0+z7Uxv+EFfstKRRqc5vN6SYtDCxdHSOX6XTLVsOtK1wcsoTN5YYD2tWizX
 UXvS6Yv7/zg7EeEnPJ+O+9wB6YiJQIQvMo2O1cbqTIDVjByFRhkOUkoRefGNyXce
 /VF2qj5uWhc7rkAS91lOGkRbIPdq9npIFm84eQSYNK3u+F3BPWjxyRKqpAkW/DGY
 9eFFIU3UTeJKFnZSIlSjdgKJApFFQC10waMYgDuRuz8dHug7HxhGVAJ6fAuj/Wkl
 rJ300w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-535066512b0so7772051cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129086; x=1793733886; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w29Ypi4oSViCbtK99W8qKVU81/HO03HjG7qv3E5a43g=;
 b=LbrtnCCYnVuibmgEiS6v3smsTFSDj99q/70tFX7eCuEr/v38HHIBvZv0LztxZu9W3l
 Z0cuBHcJb5L6yI2534PBk5o3BEvl0zRXEsMfuO9AVXCb8rhIX8zrRAZSCuwvuyOEn+Wn
 qLEtQhpJqzABm/7CjqeXN+RcjoRTCgevih5YgRvZ0KZwLbcAPeKizdNI1cXhc24l+NFU
 JsaOclrMS7l+D+C+RRksp3OxYEA8ChKbBOQf5Ya6RuoU8XzZH3EDcB0GpfwkeCmCxTjZ
 REhZ3OEqeoExAIqeZNn6HFuFRLm9JqTVFDZL1oJt7utFg9doFLBTbhykzi/c/w1qm/Z/
 bgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129086; x=1793733886;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w29Ypi4oSViCbtK99W8qKVU81/HO03HjG7qv3E5a43g=;
 b=n6685BwJzBCMMslNIII79BgAqn9U5dLjbNVhR7clx09gd1L+WFLk1unEtgoMAvPATa
 JRohrooDZSUde2sjecZ1FjkKY7wmMLml2uHcZk67hM3knCjgwByhGI1bklH+my3Y6k9x
 O/PQr1y0ocwy7tRWJgSz7KUgGPjFxYXK16vafO0vc+LgCMeSHupk5JNcfV3M6L5gk09/
 GrDGWKPCGrUooe3RzqBnt7c+n0FXuOrmueZUZ2ZMEamI8p7/oRGb3a/KnNolyJdkZ5yq
 H2oWBb01xhKbhtB4LPUV8aINnLEdjVuiTWJSSH1v1M8gpNSb4KyPrTEg1CpItgOZBftx
 qsIA==
X-Gm-Message-State: AFq9FYKTemnCwayVjyIJ1xZSSQVYR5aAAbYDgheM5q7D+9bvxINhhKkx
 u+cVNP5AQvlGLcahcGupyzjocmZy1Al53qTUbaAprdSE0KfV+1usb2+nwHpHP0gfbdYX98czFbU
 c/TdrZuwWrIvZ7D4PCjmqtyepG9lujfdeWmBQb1MGVS+CNF+o73be5erE7bg8qGxbvA==
X-Gm-Gg: AYBFou3aCRZ1KqDgD/QukhuRGAeMurUanMBX93IZSxm6SKS8fRPZVo0yShJuHpmhBXU
 THiPAtPXLqEEUmLaygIPlRwOmazZD2geQKC2GauJQS/hQorteQ4TW09xLhVxrGqGD+Ym+LYnoJ/
 McahZi9pncaOfmkDVZ1dOkHziACdxLiAjLqJsuazsgybT2Jhyl/VoRmdFFOtKOcr8lmPEXf1Ywo
 WQXtzC4SFTimF11ViIxABUmMK4Kx6suXpOZG63qdNYZCQvtGA7jYyg5ckOqXP4mVsO4WRGoTxI6
 OTaHu/EBOfZXZpOhMIVnKAARtmFHh/s4VmqpffDek5NEEMRyqdi3UDRb7wTKsJhq8LSdyfSElvT
 TY/gRRXmcNSIi+WbdtkWuBJjSRWMyMIb6IGtV2helhxWZzch4W5O1TnpC
X-Received: by 2002:a05:620a:4515:b0:93f:22c4:e92f with SMTP id
 af79cd13be357-940ef90f7dfmr1620264685a.54.1793129085829; 
 Tue, 27 Oct 2026 12:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93f:22c4:e92f with SMTP id
 af79cd13be357-940ef90f7dfmr1620260785a.54.1793129085203; 
 Tue, 27 Oct 2026 12:24:45 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952ee2889sm1816945e9.13.2026.10.27.12.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/59] hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default
Date: Tue, 27 Oct 2026 20:22:50 +0100
Message-ID: <20261027192341.9197-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX1YKAz/SJoJBR
 GsRKYz4FZUfX9ujz7wKbPN7wsRU4ouUxeMDlhSO/4XDKqkwUa2dRlcmE5rzX+wjXjZjlmVPtyIL
 FWkKPSz27m3R5fFRTpN9MPNkp+4PZ4MDGhe834G/DRpU23NPj8riKB05B4gdE05gblZ4sZLWJ/L
 YkprFfjxNfiVxp4PoFi5VpTXFV5SZumI1asuy7Xu2lnjfsa1XOIBlMYusAmXvD9Qikw1/MCP4EQ
 k6Vji035oSlOM+Ie8+g4fzE9W3ODOY9hH/zdf9DcDxLiB8e23chrT332ViYvJjaNroR39O4SvhJ
 /EP/vJjmotpNRcbCP3RQ//CfwS72MhxaWWbWFmNDSBux9lZH88BBqgcdx4JOZIUQsbOZ9WIeoPW
 S/42WeQGkXn8Nh3XxFk+53QWSXIwibymYxXEQ73YbbBc1BM7F2tqneae2Z7Km81FHa90qp6VUCp
 1i6aHodsARclCy1spCw==
X-Proofpoint-GUID: aJmI3mTrVCBNgcKxBA6JstGkq9qIv0GI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXw70eCt7XMtFV
 xo2bx2lk0sCMKWgfKswBXGbHFhAPO1WQrS/yJaeqIQ36CLOedNxHrKtK6piRNmWUQnAI3kSVRzy
 Lz7PjFIlku7qeBliMxKwMt2tAUI538Q=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fa7e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=HwNrnQn7U88IyNFgozsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: aJmI3mTrVCBNgcKxBA6JstGkq9qIv0GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Having four CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone. Also
reflect this in the board documentation.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/system/arm/sabrelite.rst | 4 ++--
 hw/arm/sabrelite.c            | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/sabrelite.rst b/docs/system/arm/sabrelite.rst
index d3a3c01dd6db..b8ac9548f592 100644
--- a/docs/system/arm/sabrelite.rst
+++ b/docs/system/arm/sabrelite.rst
@@ -55,7 +55,7 @@ To boot the newly built Linux kernel in QEMU with the SABRE Lite machine, use:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel arch/arm/boot/zImage \
       -dtb arch/arm/boot/dts/imx6q-sabrelite.dtb \
@@ -89,7 +89,7 @@ the -kernel argument, along with an SD card image with rootfs:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel u-boot
 
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 05dfabd9376d..34f302f83c6c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -17,6 +17,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "system/qtest.h"
 
 struct SabreliteMachineState {
@@ -139,7 +140,9 @@ static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
+    mc->default_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sabrelite.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.55.0



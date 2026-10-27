Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58070606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DN7agEjr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SeeuXf6X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpN-0000Sn-Bf; Tue, 27 Oct 2026 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpL-0000L2-6u
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpJ-0002Gp-8k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIALb3486335
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H8WA//NgOVo1jWnA6sZZHm8LNmFJ41d52YMJfO1Z/DY=; b=DN7agEjrNsayETE4
 Me/a/+hjU/qs2ttekx5H/paJ7+8Vr7MBWuIxmc+UvTyiqtRDtW0yNI5c7UGs2le7
 r0yiVgcCfK3EGSmOsrd8e4EZNPsTlU7xdLh/FqSFEGPRFnT2MmzV+nlGT9GgKV7O
 Wg6AFGe8+LxyV6+nAV41dYW5gwpik4Dxs42KYV8jvCGKtXE15xRYqIVLAwrx/CO0
 qAe1fU2t0GJ37FvohebTydhBhTHpFXbpTQGT9ciUN+yGGzDDo8q5yfpfXqkFATTq
 tZxkssSCbM/k471+4/Q2CKB9f4mFUAYxUiJjybWQGh9kbeN3glk6JV/MeVpSH1gW
 n9RGQA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc30m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so24529385a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129235; x=1793734035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H8WA//NgOVo1jWnA6sZZHm8LNmFJ41d52YMJfO1Z/DY=;
 b=SeeuXf6XHjiu20NOtBVtyvq2MSt8RjlO1+X57nIyNisaMJ+8J4Ijt9suq+DjHeSDn8
 Zb9ryhvK5Lsf08mEQcfso4RiianpM9/g9RwAspHdzi53q0w9X0eYcniCM+C8UotLUU97
 ZS8r//q/l+MPPmHpKDNEQjd945iKKFfNJz4gCpDgIbTtSjhRQnjM56ZVyUyABXJCAFxG
 kJ5C3gP8elgJSO/11zODRUum8tXhXdIDtg9nVc2T5TEqzsqQZf6G1vZxOOcgnm9xoY05
 3xEX8gVhhO5TfoMA+5BgKeB5yO6/tTF7Cslt1meUWzIlRVkcCGiTsWnrrmPoFXGfoZeJ
 NSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129235; x=1793734035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H8WA//NgOVo1jWnA6sZZHm8LNmFJ41d52YMJfO1Z/DY=;
 b=E4ocQHK2TTjU6mftseDsiWdNI6jrpgoaQuQ2y0ZayQV72VQ+TnKMXlEFUkf+M2VRm+
 9KUtfASispWjGu4P07zWh3Ngqk3g5fAJlORRb5xwGjRx9HAiGnotIn9UyhPVTdY58H9G
 NZpmbSpTsN656ihoYfm60SdefCXoZXeI+FXNqCyhzlPZVr4ZMe6mXORTWc8DdxFd1955
 vXEvwr/Ikyoln7aBry45NJB8bTSVJcW46qF7VDj/MJYq7qcH8YKfCj50MJ/UIXyxIeZU
 TVZ4R4cDyv2SiH7a6pl2yxtasMUNe1xjb71KOQ6QWwzTkIHsbS4FEc1uRMBnER1JzvDh
 qVSQ==
X-Gm-Message-State: AFq9FYJ7QtQFIYbhJaoqasnl/ZcnTlBbAQy5Ljy/+DSOOo3VI1DSM48p
 CGGMwgKGAm3B7aGnnt4AdEDzif9gciiq4qzwhMrSw5wQuPF9kF0VefMPA2EgKPE+hpxj0wIaCuX
 NHiJznO3BoaLQLx4PFWNahS+WcH4M0paggqBJ6Z645JtgR6D7VjykOTuXIh2AaK/xzQ==
X-Gm-Gg: AYBFou366iW+QC+Yh2hCcvFTWMFBiFM3Hn9WbJkPEoLb88GETOxbxEzq9dMP4hjcfhT
 akChPApd1YwDVGr4Nb5HN2FenSxVv6iAHT7NW9QqM9pyyXCfbTkgbe859tltzj3YY4fWQj75Qsx
 K7/Ss8z/QFRJvvXyzAdCBjLOzp0+a3BABl6J8zPa4RAtcqg8dzrPZmZr1X670I9Vm6oNOuBl1YK
 fFga8NH8qDgjQyIwrI1D4AFG+HAu2wa+M8djLfZ1iv9bxlp6lSp0rpgiuf60ytbhWk1PYiSDTnt
 cwlWh36onB5z9XTP6DEjpkLU/LEFL+XFQw/MuUueRnA3cPHiwkks/HXJLEExIF8dpDgeDmqSZN9
 IHilijTpO+RGLQuPtv8+3u+RDlAcE1iUpMI57XLPSXlQ17TXqpTRKiz67
X-Received: by 2002:a05:620a:460f:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-940ef7af32emr1637643685a.1.1793129235371; 
 Tue, 27 Oct 2026 12:27:15 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-940ef7af32emr1637640385a.1.1793129234840; 
 Tue, 27 Oct 2026 12:27:14 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952541340sm1793115e9.6.2026.10.27.12.27.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/59] Kconfig: Extract config IMX_EPIT from config IMX
Date: Tue, 27 Oct 2026 20:23:12 +0100
Message-ID: <20261027192341.9197-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX2WkyhDOWuwwl
 lSRUCK7KmroO9XJMTcs5RaFfzoEiog+4ErBAz1yaBq456DkvsNBAqRNMXmAPR+w+4ZEyxzVMTY4
 hIeUtVYjq950zi3Ny2Km5r273IovNFI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5AtnCNoypnDL
 XiiA6Pqpi9bWL7da45iIIrf/J76TjB1qmUqTamYXT1UkHsjGEiBSwY7OfeqVp2jtIHHDCq5D1cu
 +LALYnoIoLcYnhn6VMby0Xk1y1U88ehzoRV0mgUNYD/SNczYVcLkv56ckN0njrIlAp2TuqdB5YQ
 cTj21vVNO/1Q8EaUFDIAUV9x45+YSY8t6zQZ8VESteyBIF1Shk2lG74igAtKYqhWS8eujB59oD4
 Ydyz31E4A9z2j7G0HMRwHALubE2X0z5tCld28I4GnZHtP6vtKUegSsiKvixBQQl6HrtCQsTCfhG
 2LGL9gnC5WG1TMkHgwoSLY4C8rjwaB54nCBsBTkzaqBfi2XwvuRtWJQXo72V159T4UDXtjo9Wim
 qt3blzjFLcI799NEmaYxf/do17Yjjun/KcaCe/cb91BFZH5TqJDHgBOomatY3H7yannZ6G7n+vG
 Ylz8PbQoLOBZ1Cfpkfg==
X-Proofpoint-ORIG-GUID: PzuLYK9m0ChW-muzWJa7z81H-lb_cwGF
X-Proofpoint-GUID: PzuLYK9m0ChW-muzWJa7z81H-lb_cwGF
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fb14 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=hGyT-vGbCqUQOYL4C_EA:9
 a=0W9TD_AsGAYKDBPL:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_EPIT to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-27-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig       | 4 ++++
 hw/misc/Kconfig      | 2 --
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 57bff99c2585..4b52df2a324f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config FSL_IMX25
     select FSL_IMX25_CCM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -499,6 +500,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_EPIT
     select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
@@ -513,6 +515,7 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select IMX
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -683,6 +686,7 @@ config FSL_IMX6UL
     select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
+    select IMX_EPIT
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index de95648f0b0b..d625141aafd0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -91,8 +91,6 @@ config ECCMEMCTL
 
 config IMX
     bool
-    depends on IMX_CCM
-    select PTIMER
     select SSI
 
 config IMX_CCM
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 49a4d20e55b1..e098376d4087 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -23,6 +23,11 @@ config I8254
     bool
     depends on ISA_BUS
 
+config IMX_EPIT
+    bool
+    depends on IMX_CCM
+    select PTIMER
+
 config IMX_GPT
     bool
     depends on IMX_CCM
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 477dd47486ea..e2bcdbdf6530 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -15,7 +15,7 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
+system_ss.add(when: 'CONFIG_IMX_EPIT', if_true: files('imx_epit.c'))
 system_ss.add(when: 'CONFIG_IMX_GPT', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
-- 
2.55.0



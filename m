Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB079CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoY-0005RU-D3; Mon, 11 May 2026 23:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoW-0005QW-Em
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoU-00009i-Ad
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6kM1866618
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Iyn0ECigGfT
 Dh8zjQpNLe6CYnFsy1PMLfQ28kHZZHKs=; b=VXxHGG4kMZ4cCKrkmJiq02C/vHA
 0UXHqk2P5hWkCWKJV/nbo1QwLH2dxMUBWjQG4YsuiIjepM+5ZGH+V+lAy5b8+qQz
 CvRM6KlM+RIHTsRloMOwzTc418g/MhNoJ9jxicOZPUWkGAgN2awo6cqxvMTlhvPY
 PyQHNPrKA8flagy7FXkk8P++iUVPWJmxhJLkfwnY30EoJ8QL+Whk1MHYveZBR7aL
 mXtaJkGbZGuIqMJ4a34btKqFZtUkfZ9c2CyRoz/J3pchxsQrZl+j6IHgDwg7KO2N
 DHolsVZzVdYaau1uRuCs2wuU5ufN+tJNdvtlMrKswB533FCrWpPRTL6Noqg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2925d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so2849619eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556579; x=1779161379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iyn0ECigGfTDh8zjQpNLe6CYnFsy1PMLfQ28kHZZHKs=;
 b=WPoyMqhLgLioAtaFcwcsVM2cBS73papghYR+sXiXzqy7EjHfcNJO/fNF7mZ35ZzWF3
 PIu9SRirfq2AzIbEIiT3KmM7t7RW0lTSqLyZsJ0+7K2dVDzhsaw/nOB92SRaR+FViZrP
 eczJq65LJ9L6RdyTy6CG2o6U6J6z2+ZVaF8o4e73ybgWBY3P/orgw8/ceGNYH4zgP358
 146movgg5avDpcYEG7xl7d29uXxpzmtRGtbAg61NvcMrxeBQVrAud4eTEqFfvfiobpfw
 eZui9DAtbQ/v/XlS6Rqy0hXVltFqd4vsTou647IrOB9bUXLit4cyDo9LLOa/Vkq3CQ6m
 6YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556579; x=1779161379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iyn0ECigGfTDh8zjQpNLe6CYnFsy1PMLfQ28kHZZHKs=;
 b=R0c0efAHBv0NJBfq5jtN3X1sM+3COUgvl6RKdt897ESQKZtN1wnJJFNFqFi0nLzKD6
 qdiSS2xZ0XoV4Dz2SA9ucXIlZF7rL95IuX5y7Uij7ceZlNiqLYVE2yCsz44DMo76Aopa
 enzlSrsBOub43xcOaohDKlL8oePNY89NrtFo8WEgufawX2vjEHM4e4srGMt87kBfuaDp
 +AJEp3muPpUnYS/YTUutBN1if9maU8ux3rmb5BblpLI0MerZMxN7HMVxZ9xk59Ek1Q44
 S9WuPAQ6V1FitNsQ330L9KMx+ZCEeH1HKEJPF/xhX6r2XLQGpZCNBbLdmWm30/3BQYeM
 iGvA==
X-Gm-Message-State: AOJu0YzD6hwv43HJ9TDdpCM1oUUxKe4DrR1oGCuB/wylxDmHtF2W5roK
 cURf6pWSgfG8Aajlfq/KwIteyJ+ipvn0vsdzT5JOazvbSa4xnl+71i5xi6Y8ce9rE3ySPoHcEZH
 tX5hIkHBLD6dsZrltk5wDsV0lBaiPLpmAFacfAfQkPP9kYt96i1dO4aHU2yX+SOliNw==
X-Gm-Gg: Acq92OEwK+ra0E+Ew197oDI8Qaqa9CX0ATLeqkkkQnhmrGNI05peyq9nRNN6ArgdtSb
 JLAkvoK7xlloqCSymYWwpBs092DwCLfnohqVjO6JmUAf89de5bQjozFh/wp11iLrVTOGMlbo8c1
 0IRGySnImntRZA6UopGCKtmMAilUhOWhuXtvngUTRnR7RsX1kFYQeHRaChCGBEC+DEsMEGkT9L2
 Vsc2NTUk/MKolv9ct0D1Awrx8SRWw5G0qswuDMEsSvNPEQq7H2zKwViIH/VN2OZtO5SuRuhLtMJ
 sCoSJozcrAgU0f+SmjA1AaM+QbzHfxS94b6Dj94UALtnS+hmHObvoRdjsR9dS4WU62D7abq65kX
 ZUn29ZctGe3sOZGXAzENzGrCU4hifhHwFhABv17vG41B+abr+m3ClA04qEjc1
X-Received: by 2002:a05:7301:24a5:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-2ffd57c438dmr718071eec.3.1778556578967; 
 Mon, 11 May 2026 20:29:38 -0700 (PDT)
X-Received: by 2002:a05:7301:24a5:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-2ffd57c438dmr718060eec.3.1778556578363; 
 Mon, 11 May 2026 20:29:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:37 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 03/14] target/riscv: make riscv-qmp-cmds use isa_data_arr[]
Date: Tue, 12 May 2026 00:29:15 -0300
Message-ID: <20260512032926.1978818-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QYjDCKq8c_jMiB4C7JxscN3LgQdB4g2K
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a029ea4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=6oxEnRjBsO9o_5No1nIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: QYjDCKq8c_jMiB4C7JxscN3LgQdB4g2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX9hdOWVF3e6Hg
 Bz1ald5Vf1R+raE4PJ2xWpV481LF6RFr8C6p6Gj6JWR3K3CBh5hYQMErCDOqSghMXeYqPkpMtqS
 TSosrzwnHBgblOfqQuHyzH3LE/6MQWe47qmMiNsZVpYUUIB1qLiMQuoW7qZGZGCldRyUh8Q4xJl
 EKopKSzlPPrs4QwSdxXirZzXDIxKZ1CUvP69k9NnXMw412T785RX+jWiIFpuPrFtYUjhJC8pjSw
 z+3aBp2Gs0xdQvjHcCK5Afcvau4gn01LvLS7l1LBCWLii+t39YjM2ZYOLnjZ2qxdxw2tfFP5CAP
 TULKksm5KXNJGYrHdemP70DNH/tkbLuJWCsDzjdFyoI0CWKjm4U4UVphJMx9JfplmL2yRTBSE7v
 QTWDtTsIQ0LiAg3ELGaymI+e7z5/Q6sdP1LMxMxyrF3R6ZOqpBF3PlcJ3g79fgtWI171mz0qP7K
 0d78/3wMPR0DAGBYFhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We want to reduce the usage of the riscv_cpu_* arrays in
target/riscv/cpu.c, centering everything in isa_edata_arr[] instead, to
reduce data duplication and make our lives a bit easier when adding new
extensions.

To do that we'll have to make isa_edata_arr[] do what the other arrays
are currently doing, not breaking existing semantics in the process.
The riscv_cpu_* arrays have a few exclusive uses:

- set default extensions for rv32 and rv64;
- create user CPU properties;
- misc uses around tcg-cpu.c and kvm-cpu.c.

We'll slowly make isa_edata_arr[] supersede these arrays.  Start by
adding a new 'prop_name' field in RISCVIsaExtData.  This field is needed
because not all extensions have properties and not all properties match
the riscv,isa string name.

Create two additional macros and reclassify existing isa_edata_arr[]
entries as follows:

- ISA_EXT_DATA_ENTRY creates an entry where prop_name == riscv,isa.
  Most of our regular extensions fall into this category;
- ISA_EXPERIMENTAL_EXT_DATA_ENTRY: same as above but add a "x-" to the
  prop name, i.e. prop_name == "x-" + riscv,isa;
- ISA_INTERNAL_EXT_DATA_ENTRY: used to declared internal extensions.  By
  'internal' we mean users/management can't set them on or off.

With these new macros we can start our simplification by changing
riscv-qmp-cmds to use isa_edata_arr[].  We'll just scroll through it
once and gather what we need.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c            | 60 +++++++++++++++++++++++------------
 target/riscv/cpu.h            |  1 +
 target/riscv/riscv-qmp-cmds.c | 30 ++++--------------
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee8f6e5296..42555cb28f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -97,8 +97,24 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
 #include "cpu_cfg_fields.h.inc"
 }
 
+/* Use this for regular user facing extensions */
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
-    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+    {#_name, #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Same as above but for experimental extensions. We'll add a
+ * "x-" right after "_name" when creating the user property.
+ */
+#define ISA_EXPERIMENTAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, "x-" #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
+
+/*
+ * Internal extensions are extensions we will declare in the
+ * riscv,isa DT but they don't have an user property, i.e.
+ * users/management can't enable/disable them.
+ */
+#define ISA_INTERNAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
+    {#_name, NULL, _min_ver, CPU_CFG_OFFSET(_prop)}
 
 /*
  * Here are the ordering rules of extension naming defined by RISC-V
@@ -121,13 +137,13 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
-    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
-    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -141,7 +157,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
@@ -211,13 +227,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
-    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
-    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
@@ -232,20 +249,21 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
-    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
-    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0,
+                                has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
-    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
-    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
-    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
-    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_INTERNAL_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
@@ -253,7 +271,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
-    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 224c81900d..669735c5cd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -996,6 +996,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
+    const char *prop_name;
     int min_version;
     int ext_enable_offset;
 } RISCVIsaExtData;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 8a1856c50e..93e6b7fa68 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -90,27 +90,14 @@ static void riscv_obj_add_qdict_prop(Object *obj, QDict *qdict_out,
     }
 }
 
-static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
-                                         const RISCVCPUMultiExtConfig *arr)
+static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out)
 {
-    for (int i = 0; arr[i].name != NULL; i++) {
-        riscv_obj_add_qdict_prop(obj, qdict_out, arr[i].name);
-    }
-}
+    const RISCVIsaExtData *edata;
 
-static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_out)
-{
-    const RISCVCPUMultiExtConfig *named_cfg;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    QObject *value;
-    bool flag_val;
-
-    for (int i = 0; riscv_cpu_named_features[i].name != NULL; i++) {
-        named_cfg = &riscv_cpu_named_features[i];
-        flag_val = isa_ext_is_enabled(cpu, named_cfg->offset);
-        value = QOBJECT(qbool_from_bool(flag_val));
-
-        qdict_put_obj(qdict_out, named_cfg->name, value);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_obj_add_qdict_prop(obj, qdict_out, edata->prop_name);
+        }
     }
 }
 
@@ -220,10 +207,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     qdict_out = qdict_new();
 
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_exts);
-    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
-    riscv_obj_add_named_feats_qdict(obj, qdict_out);
+    riscv_obj_add_multiext_props(obj, qdict_out);
     riscv_obj_add_profiles_qdict(obj, qdict_out);
 
     /* Add our CPU boolean options too */
-- 
2.43.0



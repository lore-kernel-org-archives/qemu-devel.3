Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC21E6B274
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 11:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY0yA-0002At-VX; Tue, 23 Dec 2025 06:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vY0y9-00028t-Qo
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:54:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vY0y6-0007yZ-LC
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:54:23 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BNADLMl1889626
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 11:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Bwp+Jnp+eWAvIVi5GPsvMNIFuKvdi9pns1E
 DD3DL9dw=; b=Ccgln5Sqb9nsNEDM0PyibccX42sfm7m+2rqqr12PrzPV+Tqk3a8
 PeFIzK1SfI/AEtIAwD3RAuxoy6sdk8fwjvYTFAxwqenK9Eqzz0jsT+MSTgwtgmYa
 sJXVN0xrjd1LETDFtwuvrGRwopVR4Z0Jp+75tJEqH/r9cpvIq/kKSJKsLogYhdp/
 DPoMXIy/ZunKZM81yeFjLAOvvjYgY6tFnblN4vt61mcLxELGe3P1rNR5Vf6odniv
 9yWBXW/tbV9V078aSz8heI4sGebmxAT+HNOsm0AL/woY5da/Hd+yhrcCNrKxYCfN
 awSv/cH0gX9qse4MowD8+sj6kRpE7LbBOew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b770aker4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 11:54:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso10559795a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766490859; x=1767095659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwp+Jnp+eWAvIVi5GPsvMNIFuKvdi9pns1EDD3DL9dw=;
 b=SZ7r+7lwi/ZGhcygJBHrclNQtWZsgvXzz+GHTRtcKoIWFaEuz3UyoGW8Tqh5cUuYSZ
 73VF5X4WJVM3C9xWn3bTh/Z9/ED6lwucFQ0ukIU6pCu/vsvTZAi0ra2DvmxJq+UOnMiK
 //15/EpgeZ7q7IKBaqAfkCPTOvoaume6wcem8alTpNASg1kLj5pxTVod0vFoTNJ8NRzT
 fyx3RDMbrZdftGwZSGl8d3OtgxyQ4sG9H51gwLZ8A8wN851Yo6oGC+4Nfw/oS6D1WtZ1
 CYXkuoSkee7Ms+mbMI7bDeF/44hlayixO0lh1V6jUhrnWQK/YywtJs9R452YMrFUC0+2
 nwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766490859; x=1767095659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwp+Jnp+eWAvIVi5GPsvMNIFuKvdi9pns1EDD3DL9dw=;
 b=HcYsS56Doqg4gwuwrqVwLXIsNLZM3uhD1hV31ww6nMvPRfSUkXsKxpjc1hdT2yavjz
 swmTgVOEbmmvjH5KEcve5hrqoF6HhkBoWC2IE3WhqRcCWsz3fN5Dfnmfxt9HedJOWZDC
 dnRCX0R6oACxk5au3zdxg1u3As/gyiu6OpVpQNgmObSmfJTBsJhDah9JPrYWojPVxGgt
 7rog2Bhi+CpHcx83t848CNtnTLPmukLqHGQ3N84ojAwONYqT0MioG9HO/JpZMOwYykAA
 886kMe3tQqEmFkblYgH/GTKw9WXZwC5GqS3cXXxnac9CBBvAuiHUoWsRylWhKYojVuui
 QjUA==
X-Gm-Message-State: AOJu0YyplCCuLJLG7+0Av3gKVWbQc2/aXNvLv4j38aZm5POvtqp7N3RR
 RLJULThfAddAVJqd80yIWUp0Lyg1b5Yua6Km7OIzhjJoAlDIskQ2cQS3h4jFT/9GftOPBInBCgi
 CGuFr45QUXjLbed/AqMjwcDMtfN5/n2jYaxSiN3bUsGuhLIm2cE2zAfFQNmAMLN4zwg==
X-Gm-Gg: AY/fxX4zPAnq+Rlv6/lx8L87oe3nIlz2hijsmBnnOhSSLIFP0t4rURyAbXvh7KPp+tQ
 j1FFz+2PIBeVhES1S6M4hBJSGDAEjTcg/ZK1lpGwy0DYAxAH2Il98g56gNApveCilVrPz8yglYo
 YFXQY6XISmxOAyBY8/bOoYL+PEcZ4dpXrCqFA9Bz1l8lVayx9pi2cilzM31hWleYTLdI+twGWRJ
 0pTW2I0tGugkQHsFoFBuPqvGkeWwtpZANjr2mhMwQsB4BpSywfDmcgWJYuwEFzvM5Cxgq1iaadN
 r8ddJh+V4VLKbJhcBjLE4Uz9V/hotNLUO40Gou4SsHtQOJaS9bPgG+GwP5RnxzNOwm7sJ3khM86
 wc9Mfz+4OXvGzpH5og/Hy8WVZ7LKjewGcKoRhX2ZNM7lvOAo=
X-Received: by 2002:a05:7300:50e2:b0:2af:cd0a:ef8c with SMTP id
 5a478bee46e88-2b05ec9162dmr15289165eec.36.1766490858825; 
 Tue, 23 Dec 2025 03:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNzE0mFlagRutwYcf+e7VGPfW+aqJlZbQn4k8xQbG3WYROilYfkmid56p15VwFDx4gLzoF0A==
X-Received: by 2002:a05:7300:50e2:b0:2af:cd0a:ef8c with SMTP id
 5a478bee46e88-2b05ec9162dmr15289137eec.36.1766490858238; 
 Tue, 23 Dec 2025 03:54:18 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b05ff8634csm36428044eec.3.2025.12.23.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 03:54:17 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/tcg: allow vendor CPUs to enable extensions
Date: Tue, 23 Dec 2025 08:54:11 -0300
Message-ID: <20251223115411.1292566-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA5NiBTYWx0ZWRfXx2y4YJj7ZmOR
 90U+PLVTBHIuaIE93v2gBPCeZyo5k7uMHiUlrlyRiJAU31jP6MDd2xnPqBfHh/LkDf/XG3pSfAh
 rCmRwpeCi3JOa97sKOuty/HNUq4IOBIMgnW6UbtbxORrXYJO2YjMqLZsN4VC9qkBh54rc0tDpvL
 eAfi41dUey2WIIrwJkPAR3hvOWdxuMexjNMxgAAwFeFVso39EHUmp/4scZ17lDI/Lsow0U/wD/2
 0kFYy9HMIyvrJH73v7XjYCwC6Fv2wF7kCGfJza6oRjBIuVhm3Kpi0Ed7ke2Nsx7NcqLOI23anJl
 X0Aca5nsgkf2aGyasCUy2xpTlWRFp+qshisjFPJokAhOif9I4aLpHdOxC9Z5Q5UGmNSPOI8MYeM
 dOg2/Z/IdHHEukuTyISEVEPiIlG4eM0wJSq0OaLa6XHot2C+NtbbgnU1bRnZzn5JY7cNDHDSqKd
 dUT9JkbGjtRXgEddPjg==
X-Authority-Analysis: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=694a82ec cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ps5dUtS__jMTQjSizQMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: LPtt5IlFYo5kU75GR9Cdgx4LBEqcylfg
X-Proofpoint-ORIG-GUID: LPtt5IlFYo5kU75GR9Cdgx4LBEqcylfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230096
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I went through a situation where a developer attempted to enable an
extension X when using a vendor CPU, and he got shutdown by the "<name>
CPU does not allow enabling extensions" message. I explained that he
couldn't run this simple test using a vendor CPU because, by doing so,
the vendor CPU is no longer the vendor CPU. As a reply I got "yes, I am
aware of that, I am explicitly adding X to it in the command line". I
then elaborated that an alternative would be to use rv64i and add each
CPU extension manually in the cmd line, or maybe use 'rv64' or 'max' CPU
and enable/disable a bunch of stuff to match the vendor CPU + X. And I
felt annoyed by my own explanation.

The distinction between vendor CPU and generic CPUs goes back 3-4 years.
Back then every new extension added in QEMU was also being enabled in
the 'rv64' CPU, along with validation logic to enable more extensions as
dependencies, and vendor CPUs of that time were being affected by it.
Guardrails were added to prevent vendor CPUs from changing due to the
influx of new exts added in rv64.

The code is more mature and stable now and I believe the concept of
vendor vs generic CPUs is no longer needed. We could get rid of the
distinction altogether, treat rv64 as a vendor CPU with all its current
extensions enabled by default, and every CPU can do anything. Users can
then have full control of the CPU they want to use and we'll have less
code to deal with.

A lot of refactor and code juggling will be required before making that
happen though. For now let's allow vendor CPUs to enable extensions.
We're keeping all other restrictions in place (pmp, mmu, vlen, block
sizes ...) because each restriction lifted can have side effects and
should be handled separately.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d3968251fa..122b8b52a7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1478,7 +1478,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 {
     const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
-    bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
     if (!visit_type_bool(v, name, &value, errp)) {
@@ -1493,13 +1492,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value && vendor_cpu) {
-        g_autofree char *cpuname = riscv_cpu_get_name(cpu);
-        error_setg(errp, "'%s' CPU does not allow enabling extensions",
-                   cpuname);
-        return;
-    }
-
     if (value) {
         cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
     }
-- 
2.51.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83922CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdp7-0005nj-MT; Mon, 11 May 2026 23:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoz-0005bM-At
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdow-0000Jz-ED
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:30:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6Tqt2202229
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g0sLsOJiKsG
 7CRXlyrA+OGUmdp6eKHEfqU36No0AIQU=; b=VSooAKC17dGstoVAAo8fze0Dl1z
 HKAK1gxl53HThGjmFx4X0y22+3zO6ovu9902vjlQius2WVfkmUpaBSnDhHMa+sVX
 Aa1hSJR8cYPPDh79v/+GZOySQ26S1kC6ExwYy9bU/S7aRbEanX+NmO8OTT279Hcr
 8F5aqQ+V86uSSCwAr5P/KWQ/ph2C63QdgVA4EW7SZoQoGE0c5EBAYP11wDvYNNX4
 z1PgOTbpeXVL1YVLQUEoIwCqZ13c2So/BHu0OcJfimGui5QB6SK5v/XmjFexjntl
 B2nHIUgW5BALmgUHVxLLh9dROxTccHRt4oICsBrChEcJ5GIzcgj3pe/nnsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyh7hp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f2d983d109so5817635eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556596; x=1779161396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0sLsOJiKsG7CRXlyrA+OGUmdp6eKHEfqU36No0AIQU=;
 b=N0fwKSV5unTv238G7/BilGuJZVtDHBLmP15ZfQxIuK15H+9wh8W6KOHggpZVUdFGgq
 LUPC0aQjGOPlnIQsMwnsxxdz/h1usMyMoTWNfytjp2rTBVFKNYpKmS6Vxp+JrnIjGQLk
 6pX6CRxulvVwvKbmUfbPr+mhg2Vz0AxwrKtUHWKyJftmW6NIplvO7E3ivP9WYF6cDJpb
 JskSYSg5z/0b5ozt0+TzzdoGGuZh1BAwLOOCmev/zNMxxMHCkj5c5z+9I/Mgei9Mc243
 4/+vdqvwV/ZgWNecomwvuqPP51gRwD35v1K8yk9Na5Kn3jnp2fCHtXug05/XMhXrZeBv
 fMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556596; x=1779161396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0sLsOJiKsG7CRXlyrA+OGUmdp6eKHEfqU36No0AIQU=;
 b=Gz8fbKPhRVPDyAxWQHVbECeEhoiWPJClBOXHBAtw83CUt7I3golj3cFopFRa9n7qtG
 NHidg7ejcyBAG8t00nL9NU2tqM/FUWRyBVEsI0miZlrj2wHU+VL0pJRSU29/dFuJaRBO
 PCKsnuO/vvrnAnpmUl+RlQmcKHeUAs0Z8lO1qjAgjPHYVqbZNGOR43CAwUZZg5/bHfc1
 3KLvztCAJBN8wlWnWVVFzOlxSL9N8uze+ARqYZFwpb8+xACEYumlkum6Ve6qmGv7nCgW
 6wZV1wK4kOEyMOBxamk3/gJT6OBtkzCH64Xk+43d4+BQn16Ot2+M4UjDymiEkPm81OIk
 fXMQ==
X-Gm-Message-State: AOJu0Yy1EVbEj8Q2xl9ztjzQP+6Hv8ypnI/xrZDT+oE+EPhCyCfptOM8
 iF+/j7BJ/+n/h6U7i+x3jSslL4Ue2FmMW7POvWzIOe5unOHKYbyTHwi3BtMCCGI+mv1bhkTus7O
 F2N65dKFoRijiO7Iu8HHFg0qIcTcFDB7rJaPHxigIh7qoAKnHvGffU6nove9ugxL5wg==
X-Gm-Gg: Acq92OF/3Py7nXU/Eg3bRXNaq/raG59OAvQAaI3Z7YHX5vdL/LRCQGd8qpZOZF7/Cc+
 pXP3gPplLdpCKv9G0t2P3F8005V8qGFIk+LyyYE/pN3CklCkBU5BnmlMfZaFn1Oxc2Si8ouJjJW
 eBtP8ynmAL43HMGUw3LSUu6UKJzkxUCVr++sZqiy6QpKBbrYiBUw0jiBSNaWwPk1avvEqBtOCRf
 Pdd5YeSogdCd7OPXzRVcIs9EMGcNN1HYH2I5/L7PHJmbgXbTSU7OcxJj9KAzU4ppVd/fmlk1Cbe
 k0An5MleCk681NclGoGlP/eQqqQSJR4ErHSV7qm6hECDHOP0dztIsrsQlJMab9IuSiqbwACaPGL
 KfkGGiKSoJFoZfTsnd6WwcP2mgvUunNnDcgjycwAe5W9aN8b4FeCKSX0h72YI
X-Received: by 2002:a05:7301:578d:b0:2ed:e16:6b4d with SMTP id
 5a478bee46e88-2f85eb30a75mr8454784eec.35.1778556596180; 
 Mon, 11 May 2026 20:29:56 -0700 (PDT)
X-Received: by 2002:a05:7301:578d:b0:2ed:e16:6b4d with SMTP id
 5a478bee46e88-2f85eb30a75mr8454773eec.35.1778556595685; 
 Mon, 11 May 2026 20:29:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 10/14] target/riscv/tcg: use isa_edata_arr[] to enable max
 exts
Date: Tue, 12 May 2026 00:29:22 -0300
Message-ID: <20260512032926.1978818-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX2EtJ3rQeKNbq
 VsiOKxU4zxqFV6KtDcePKBbVGWP2kXCnDvH3mMGoiv8XNxQb0U3Lw3Y7r8vjq+5AE8AzQ1m0qcZ
 dZrzngilxH6+NfOqrg9nqM+uZ9BPcQvuTdDoh3pviChs7EdgSPT5303WBnhrSdDh8L2xNOtDT5U
 mWPm9cq0M1Pa0o6jo0F8O5/6EPJaBD5qszvVTh7C1cQUQkoJuWziSlSE43jU6U0mfNxSBzCd68T
 AnLsCFQWXUeMerEyVMPwyARPmpjHzY013FREvUUHHz6yIAC0F5Q1APl+phtV2zj0T6bSgcYmr46
 /O2VbRv8lZ6wgNVF622t5uaVVy+fiQw5zsUhLbnEQe7JTOlPs2AoRpjgSGng06e53rCJoKOqrvN
 2/m2W4XSSRrgM5fAy1PxVRUk10P0+3qd8NdwNYCASPx2Qkl7eVR3nHskIo9gHRRdNpOyPbJcLJc
 u6oBoc6eGEFTi71sNIg==
X-Proofpoint-GUID: Hz1bgCanNAW-sf_NbX3BnHW9jyeKX_4R
X-Proofpoint-ORIG-GUID: Hz1bgCanNAW-sf_NbX3BnHW9jyeKX_4R
X-Authority-Analysis: v=2.4 cv=Y5XIdBeN c=1 sm=1 tr=0 ts=6a029eb5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=GeI1Fvk0TT0tVSHP69sA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Use isa_edata_arr[] to enable all feasible extensions.  Filter
experimental and vendor extensions by checking if the riscv,isa or the
prop name starts with 'x'.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b7d59f40f2..eb48a76a6d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1614,13 +1614,18 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *prop;
+    const RISCVIsaExtData *edata;
 
     /* Enable RVG and RVV that are disabled by default */
     riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVV);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        isa_ext_update_enabled(cpu, prop->offset, true);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->name[0] == 'x'
+            || (edata->prop_name && edata->prop_name[0] == 'x')) {
+            continue;
+        }
+
+        isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
     }
 
     /*
-- 
2.43.0



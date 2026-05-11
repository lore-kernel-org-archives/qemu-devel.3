Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EB7CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhd-0001Aw-Mo; Mon, 11 May 2026 09:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhX-000173-1J
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhT-0007cz-NZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BCNNKU774903
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W099VahclOU
 5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=; b=pnvkh3kuR+tm3zl/0ps4oAtHUvD
 xcMjmu7bKI0Y6qHJH2j95UVU4KO41jQ6N5Iw6vkRW7xP+9mfHrg8K8ec8KTbgWj+
 QIiTEv5crG5ADG4DR3Y2fL51FcMc6mTbYw2pXCFxUCbwlWHfHoSoI0aL16kpW7LN
 KwP9Pe7iXq0+E3M+fPvNy7oDzX6MKgmhmBs6wz8Hse4WELzCFVJx/qyYIkRHzFLM
 GJjPUpyEPRLNq4nX3qzrIr1x7yiodPD7flgmDyhIOrthxFVgsrxS3E/FF70r0udh
 wKKl+mze7a442DomLgkJyqV9b56S+xvMAOIzK+GO0TN5GhJyvwtcSKY98pA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32he4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b7105dfb5eso94279926d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506173; x=1779110973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W099VahclOU5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=;
 b=Ec0nIsaVYIFTAWaiZ3XKXEJOCmTmK0UKNrL3qZWV+iw59GgvhFrlHZ9lALpXsLDDMd
 7PVNbjd1CXtO9lSi3jbL7oFC1kGeW+2TijgduKfZzBk4gFunpH5HQkOcGJQ5A96JnC4w
 Vs5h7ff/kjtmZ7LDpmdNW3Y0VTAIiYxLgWiKd5ATS2ElX+z9SawSbW+IZDNO5guG6XFZ
 o3t0y6/RmZxkzJI7z0CWk2QfR/Nc3bwYL8ekOOBVNT3fEdmYunyN1A6Ru5gSDWLBDl67
 uUwGTHyOUuhni18zXsqMpmYdtwX0is1zKMMCFaIxD8FvqQ0yZflB4vCQhZAyEU4O2BRF
 VdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506173; x=1779110973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W099VahclOU5qOAugYqR+hKsc8FjL1ROzYvzOkD4n+0=;
 b=Ni6iLznhRWZex1z0shE5fCaYAMbr81QwUNWJ0tlaqsE+fz9uBWK8TDgWXcjxqQSnHm
 B8FQU6RvU3+bfZaZLXYGcUMtyPKP/SkeW1eBntRiY2ffoDQRYOw+h2uy0FC20qW87nYP
 5vMQs7mF8TeURM5m75iX3j0QK9tR4p9YRGMdrjtpBxPOryskhanwDoEA6lmssrGDMBfH
 WrXkbPm8kbjFiJcZZvzQkwWoly75Rc77nUsls0dDX/WiJaVt5LmLsAgtyKSp3SruoFSh
 V/VKc1AD3fQimNGwZY7q8nSzPrUoLa/wSPpDMMIhFzASDSWD+i5Hczi1Ln4019VYgrSz
 643g==
X-Gm-Message-State: AOJu0YzfWgss8cGCxqbLyGnGGxyJBUjrp/9vpzwp0jDxNcR6JfpO5til
 ++r1OnuAYxw5Rap0MoXCFMI1NfWpSe3jfRTJR8/29yGYMTUZrbJD0mDgdCEtKgZfmMXwLHNktzn
 xgA0/wf4vlCJT6cr9fA8YOx1sLRRWmI7DGlmCZ7WhzPSAoGCdf/sV+B0oSNOTbIV84Q==
X-Gm-Gg: Acq92OF6Fmh6tN2PqNuElzcZ+kbTTzkkYBzN+ZncyqdNCYEt8WUeQ/93gpuVHucvSYm
 wKOAPaZzWhD9Xx3eb/6w5EpHHmg4RnP96978PWxU+2xZkTRkizaursjiKgUXTr1qb5z2YN4rZnY
 /HNdQvHMb1wE3prYFw3QGXdiD8+fmtpp21zVJd6/3UVHxUwCR6CHFVDkQ6AUhwAI7PBcdAyCqap
 bJYkGT8PPcqQxpOcwAKjHx+GdcAdRscvYoSfc6Ha6fd0JAChOYm4wmKxSbeD8aG4iJ7AIVtlCN6
 z/zpFL5aa2fK8VJGHohfh0HAPNeqChB4gy8ey9I+WgqvWjURBWgcjV6bo009797Oep5Uowd+KsK
 Xbdq3E/nPxQyYqm0em9ScccNFfOQ6+HpQp4i2APA93MPnYPb49yzMDFMQ+TAeqRz3aDJzDPU=
X-Received: by 2002:a05:6214:ac4:b0:8a7:1745:c50a with SMTP id
 6a1803df08f44-8bf43be6f36mr233472236d6.41.1778506172775; 
 Mon, 11 May 2026 06:29:32 -0700 (PDT)
X-Received: by 2002:a05:6214:ac4:b0:8a7:1745:c50a with SMTP id
 6a1803df08f44-8bf43be6f36mr233471536d6.41.1778506172203; 
 Mon, 11 May 2026 06:29:32 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:31 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 08/13] target/riscv/kvm: use isa_edata_arr[] for unavailable
 props
Date: Mon, 11 May 2026 10:29:05 -0300
Message-ID: <20260511132910.1738069-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eAAV3OWWLe-owXLxrP_ndJl4MksFf0Zz
X-Proofpoint-GUID: eAAV3OWWLe-owXLxrP_ndJl4MksFf0Zz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX7Be8aal3l58H
 yBT2JevAVc2OCSh5/S+1qesYZNIaMb53B5Wjgb5gS8g3nh7pADJgMra9/uMA0euFZMqu80388nT
 SkGAXqwh7IvtydIXwQDJEVxoLhdd5RnjlJNegByF90QdI1+DGkAPKyuGli+et0jubAzJDRs7GAn
 qbXE3hB4CQhIl/b8XH3ZwQy+R0/otx5oGTIc/Ez35rupbVBdWCMR2kOWtkfH95wiJuvQo5vj9kK
 KRlsCu1fwLM8g2uCsi2C5J7f54vKWQxqABjncezN8d/0BjOONYkan/84FU2oqvS5k2Q8S5oWauj
 toScVW4p1U4UHsilFKJ/WPpiCso92DRLKTbBfL0gUU8Gw9cyMy8aeADnE/MkzWC+svtzy+GIT/y
 Kg/UkuPI1mxofpziIVJmPYjbxYHgys0eh/9IfrTX/czmzG9faAY65HY+KvKMmy4qwoB2fdpos7R
 /l/vQYUynRgGNSAtjcw==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a01d9be cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=rmwbAOuY7PkRKRYIosgA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
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

Use isa_edata_arr[] directly instead of going through 3 different arrays
to populate the unavailable KVM properties.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-cpu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b047ffa9c0..7f56f64d79 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -525,20 +525,9 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
-static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-}
-
 static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
 {
+    const RISCVIsaExtData *edata;
     int i;
 
     riscv_add_satp_mode_properties(cpu_obj);
@@ -572,9 +561,15 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
+    /*
+     * Mark all isa_edata_arr properties that collides with
+     * a KVM property as unavailable.
+     */
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            riscv_cpu_add_kvm_unavail_prop(cpu_obj, edata->prop_name);
+        }
+    }
 
    /* We don't have the needed KVM support for profiles */
     for (i = 0; riscv_profiles[i] != NULL; i++) {
-- 
2.43.0



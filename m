Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A275CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByNO-0006Tj-OL; Wed, 30 Sep 2026 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByN6-00066w-W9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByN4-0000rv-R6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfEk64014402
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gdnue3HpjS60XlqIAot4rWXNu0pQdK8uUTPTWvh2zVc=; b=jNJKEmgcR1x77Lte
 o3QBvceN54WWMbtP/cu8OanCS0Lfrg8hUKbWwbT3SIXrZNMo3Fy0p7t2/Yo3BcGD
 V9gYFA5IoLuDO1RVQjltSoUld+vzLQ281z2VL16wD0antUSQfwwFXwiit17dN+ef
 Xy3CxWo1ClQEVobaXY/MvfUpLucGcWbvK899WfwdzTO8vtP/AzK5/i9srvsFeewe
 3t/Sn/sAmIN8HzXt+57ixZdNj2JUmh4lLR1pQD4g5wfEkk10zjKX54+0iwqmxed1
 wqqHryT7Mf9Vj7oHtlGQ7yOggEexbLMbWeGzbqld/Ne8mBs7VfSF0awyl0/opRE0
 n074ag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27jsnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c58ee2116so1010167785a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790332; x=1791395132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gdnue3HpjS60XlqIAot4rWXNu0pQdK8uUTPTWvh2zVc=;
 b=KbmCz9/sUDdH7K+2hjESmqEb20RWXv4emWeiP8nlo+SsODcffT0xkHeV1M4TQSLLHK
 N+BbzrUOgRWJJ+yOA433dn7+/V7fSm79fv2haZuwrhDHbRpT3NRL9Dh0UJ/p5jNAgpQQ
 ISl/XSP5tZ/rhUaLoLu+LX+3fsRwvyQlAeuvfQo/fEtAeVm2/vmBIHHLD5Pg1B6KDm3w
 AwARL5Ircu+DUjX+c+wczkFULmhvRFBBPJw68jBF7L/+e1vZE2iFhZkNGvATbB4Ta8td
 y+K1gCxVMHYKT7uWNVXmrn1uWNEwbWIcnKYDjZHAeDI7Ews3OhUOzQ4ZNsuPHf70M54+
 bKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790332; x=1791395132;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gdnue3HpjS60XlqIAot4rWXNu0pQdK8uUTPTWvh2zVc=;
 b=tO4ccjleD8WJToprqUBh5Vm4Jln9+ggQF7ubD36GLrKLN85AHHG1UwPEakVTCO9Gbp
 BQn8/ViemfUO9Hlh6oBLVNQLkWFRpACBMhBggy9RLRpPC1akPZQvwawHP+Rsjz4Ffuba
 koRJ8kFV/1FtnIZHq5k4jknY8O3BQWDMfvPWUyaH1ROu+mfG90bZc+qAoH1weNM4h8IV
 jPdjS3dgujFfuLDaNL/PqaGu7l2vp33xoKA5ZO+EE5iEXg3bb58twl215U0ZoHpxNuJg
 uSxNasMu7CSI//55FkhLmstPOjaMMMzko2fL6rin4s+t7P+agZ57yRpugX7vRu1qJxkx
 OyMg==
X-Gm-Message-State: AFuF++lT138X1vDr2vp9/12FY2Cp0H0E1D76/p44nUWiZzK78GQckCFl
 zEd+sMnsj8ul7UAOW7j83Bhqj/xZ+SGkMxQOxZCpEyr82BdwxUg0mtsTlXWvs8+rB6/RWVu39pO
 K6G4yzMhV03/u+Ovqta1qlyxsjUkqVmQFjfOdeQNWRCDs13K+I+WACrk7k+tV1q2JFQ==
X-Gm-Gg: AYBFou0WQ2Ixa5JocFLXYw95IuwXe7n/TJ7CUoJ3ry02nMhp/NOCb26//PjFrmKEFgs
 DYEqPA1C+WN/4xn1QOGI7v/BzJgHZabxprqJIiA6igRtAPB+J9OtkIQg017m0AEMKH9+WEWmWSx
 XS701R+Ji5sjQdYr15i1iR2cKqUgYO9K1YPIpmlcLBomDl5hwJJL0wmsmyNlsSa3IFbQRaOj+h7
 +i78T8lQSHLP57SKnWWdsrdGb5AnZvmlKWzjEp2XoKWbzgQ2E2Uy6fBrbTbt93rzA3RrzOqR0T8
 V+ifhZZVmXmC4+GpIHKPVFBV6pWxsdjdQhqXBJ7KNubXbwlbQQh7dkVjLDnAOqgcj8Mpl08DFqY
 6Vq+zkrIdJj0z7Rsx17OlQS1jJvmaqA/TENoQoQ82
X-Received: by 2002:a05:620a:8906:b0:939:6dee:4b09 with SMTP id
 af79cd13be357-93ca97849d7mr403440785a.51.1790790332243; 
 Wed, 30 Sep 2026 10:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:8906:b0:939:6dee:4b09 with SMTP id
 af79cd13be357-93ca97849d7mr403433085a.51.1790790331810; 
 Wed, 30 Sep 2026 10:45:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692ae3fsm546673f8f.26.2026.09.30.10.45.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:45:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 3/7] target/riscv: Clarify riscv_accel_set_irq() arguments
Date: Wed, 30 Sep 2026 19:45:03 +0200
Message-ID: <20260930174508.81497-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX1SFm8wgssUow
 3y8uHN5dNlC+Mpd5s0wusM+087dSce2DUEw9MAVsdtXJR2cUjBCSOuMKW82b1UyIhthi728qYmL
 vdYicnIekLaB6S23RInxCFn4HnRGfqM=
X-Proofpoint-GUID: 82DOjU9qA4NucVk3Kj6Gmr86IP61DhNB
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd4abc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=urvbL2ETff7qRChc5isA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX5VhGx1EOLKsR
 72vWAd7a9uHSDfMER2kCH78juETOhBKerSWles97mtIGDpVXB0yzmfcaIKKeJuRwOwHQjbYlATZ
 LqbaMRSNf+aOD6sC0GBAbForGJK96RhCAiMxIO7wZv3VJfrc0wECbDEbyBiCIsv06piI4nqbAEt
 bKx4vBLffDKdTZVk4tUTDhz4vOZDL8KtcjlgR9Ic0EPp3+M9nT896yiHbyZc09W+Va+Tm+KSND/
 puTqhws3QZryx7SK7zRsOuIvdZK7hVXH+ilQVBIIFW1krTQAe+4WY03cvFrtH5KjaQvIZGZNaeD
 r7cLe+7oKiL3Yz4/nFj7CSKb3XRVvc2HxJ1FkjItEiuRXbV6AoFoFkUshXiFl2PG2uyrfiLLtLb
 xVNJYAmNMtLOwwG48kqzfDot7iXuNnNNaz5Eo1VtMaadSNw5wU3qtIFZ+Q1RtnDKPjwR6H6MmbN
 ILOia/9o0vGiOqurgHg==
X-Proofpoint-ORIG-GUID: 82DOjU9qA4NucVk3Kj6Gmr86IP61DhNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Use per-accelerator locals to make the differing conventions
explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
number and a level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/time_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index ede1a4c2a34..29bbebb96fc 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -25,18 +25,24 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 
-static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+static void riscv_accel_set_irq(RISCVCPU *cpu,
+                                int irq_or_mask, int level_or_value)
 {
     if (kvm_enabled()) {
+        int irq = irq_or_mask;
+        int level = level_or_value;
+
         kvm_riscv_set_irq(cpu, irq, level);
     }
 
     if (tcg_enabled()) {
-        riscv_cpu_update_mip(&cpu->env, irq, level);
+        uint64_t mask = irq_or_mask;
+        uint64_t value = level_or_value;
+
+        riscv_cpu_update_mip(&cpu->env, mask, value);
     }
 }
 
-
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-- 
2.55.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A5606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kujsnu4Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=flYR1/ww
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTjV-0000Zp-BF; Thu, 12 Nov 2026 07:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTit-0007y3-Aa
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRTip-0002U1-PA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:16:10 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC7j0h1126169
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nyRHXgmeRfJ
 p7uChumkczt55UlW5hmRo4yOOlB6ipro=; b=Kujsnu4QpLKAP1VxYIkLt8Jowp0
 d7xSd67DT5LRqGn0fLvFl5NQJ9j2DK5Aw//nWkfIabt1ofhCS7YesshZF3VXrY7X
 8I8Vh0gNJO8sXqwKUwNDOmIlq/mCVYV9QY3QjjI6+dW5A9F0dry8qfJWxlXFhMjZ
 dn1jdbRxi0UoAC7rGATtJHSaW6Lt4QjySm2/UcfARjo5voZ+9x5iAQnpkctTKKgU
 ECMHsDLOZ4zzwywjW2+Zp4pg6Fa9MY1Tc4MRx05qeEcqfu4yRKgztL/4QSqCdlN2
 59xRucNjMEapWlLlZAvgTbwXAZm565ZgckxEmR+A7nmI53SCOFBCLY7LqYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a08xq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:16:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338c215ed2so64075721cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794485763; x=1795090563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyRHXgmeRfJp7uChumkczt55UlW5hmRo4yOOlB6ipro=;
 b=flYR1/wwKkzT2bwiugNGrxwZRS7lqA2ZDhK36lUHw5Gasjyk9o1n8z8MkTBkk+fiWp
 mPCXYACt0QF3qTa2rLTxevYulTJx2/5Z3djvGh8afzCaDfMLiAPs5Wkfacz+H/w4vUYA
 ZvmMH9stkcb9lfM961yE1GkCKaCyCgADDde6W992CkK7vUoxL3zPNIB0VIx8L9UGRfHS
 Uqr6jSs0pGudsutoKmJpOCjMQH6auN9lPEOBLdteyWKTJCHQS/+goVXbPXW4pXdBj2oc
 NsZ8oxOg+/5CTJw64reHyPARN+08v7NjmF1lQBRx3IyP4cHGXlxZCKsYFdjcZSt1TiCV
 eoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485763; x=1795090563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyRHXgmeRfJp7uChumkczt55UlW5hmRo4yOOlB6ipro=;
 b=e+GoGL1LQc48g/v6PPzQ5Jg2GJ3KP2nV4cXpjF2Zk4PAAjauFAQ1bq4T3PaKu+MidZ
 7QIJB/2uzGZLM9s1Yob4vdiGMbvZBpq5xXWeQ1JRNF8MMo+/xK86IliNzUkOZQJ6h9pY
 v8JAsvtwnPL8wHPH5iFsH+e95BWSt0+Bj165eH1yc/nKo2mB5LTKAbpCSAeJ1FV4ZN7p
 eUt0LKXo40h8u26P8/rrUHSHJj9W/zf4P0Sq9B8QBzGD6MQ/0RdECcTdydVI3dBsB3Pf
 8Sr/NTKLxIvWbpXunv5ZYLEgJI80weRFClGcIMNa5CY1LEnmOtonF3k/EgKDhkv9vM33
 KTLw==
X-Gm-Message-State: APuU4Z+VucYFRJKMTwTImtFAgkTA0GTVBgDf1AccEZgX2iIaWJM/BveG
 RwqpY1y0RqDNf6bkABoCljOHiOJlaJhrt8zyx+iY7mDtsNz3hTLd51H3USyBccahE9/mbAyc7rh
 oW/wk9GqXbe8aXqLpIeeiwuhzdQIMWPdXw18lUHZZZhBK7GNiDT3Z29RUN04l16jclQ==
X-Gm-Gg: AYBFou1EAbv1hwUHa1wy4t2IUfl4V8jNu+wtzm3SMyYBa+MklzK4y+ytJ/zrydExqhX
 rxuC5vRLkLzlQRHupIbohqRazeF4f+ar9lSOHOlZOt8+I6v1BagmdQvdvWY8KR1YvzLiDszmFJ2
 AFje1O2cUoLT1KSW19gXBPCJRCjE/l49v7vrsGMXnXdzflOcobPr0hP/YWpmrEpTvJ1aw4iEcvG
 fNbGvBkce+8/7smvfK9quyZXynRLI43d82rDeU98mjjJwOe22whaFKbYtP1s3DL38z0SfZFdZEl
 3oshQTPkFssqv0tcHImuH57vHYEZOkY8pRG+4cybpQfGlc+BCL44v/CmqjxhLiF+GL0dp2uoAEa
 2K+P/6cfXrvTgXSbA38+QKNM2jmdrRArD8OsqWxjUoK+29oGwuIdHrGWFwes3Pj6tNi36ceIFS3
 0WdYWNOgVtQ7K82M8IuiNb9IBmycMotvvstyxEIXKiucbT
X-Received: by 2002:a05:622a:4d44:b0:530:ea8c:1b6b with SMTP id
 d75a77b69052e-556bdbeba75mr86119671cf.3.1794485763089; 
 Thu, 12 Nov 2026 04:16:03 -0800 (PST)
X-Received: by 2002:a05:622a:4d44:b0:530:ea8c:1b6b with SMTP id
 d75a77b69052e-556bdbeba75mr86119181cf.3.1794485762446; 
 Thu, 12 Nov 2026 04:16:02 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af6096asm73538651cf.5.2026.11.12.04.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:16:00 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/5] hw/riscv: allow machines to set 'hpm-counters' for
 riscv-iommu-sys
Date: Thu, 12 Nov 2026 09:15:49 -0300
Message-ID: <20261112121553.485439-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
References: <20261112121553.485439-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xlo0jy9IbWGEOKXUAPKYeH5fmV6cbrYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfX5nSlIJ0LUeIe
 EHkot1FJTT/34jR4ltakTfj0rOnT2VYeSsBv63vG4j8QsdQDXJtTm100cSVc/qYOcut+BuhImLz
 1pYhOnRdYRH090EQWt0Rh5hoFpWJcJjh8TJEWmz8tuK1aaPCwzy8go4f4meGwN5nTIKMUh2gK+D
 f7SR41euKljXYZUUJxtJ2tKJuJKNp4bluiOscyk5S/vavO1qsx/tAuQ1qo6wEAQHGBGn+QwFEkH
 a9cZbXGQYVNqWXk//WuE/xTXPrYqYqcwWTsYYrhZxjes04TMqiw/bzXj6+0IBfW72qOfSu4CjJw
 nUuWjZhojJgqjOgcTCgdFJskIfhD8hQr8N06UD0/rVrSelUE3RUiyDKW2jRqTQjFFv3/TXkgnE6
 xVZSZv0taUIpZmPkcBmfM0/XHotVZyZlLGSeWcPg8yFJMYCuDNSrDDEciab3I5J1TdahngVtXTo
 Kfh15zLwok/LNfUwiTg==
X-Proofpoint-ORIG-GUID: xlo0jy9IbWGEOKXUAPKYeH5fmV6cbrYu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OCBTYWx0ZWRfXx1v1rxqWPlIK
 +H/QE8FMalTfahCH1bevqxRaDCTE5HTlhWw1+UoVt0LAyvqnFi/fiITUURpz2Pmv0N42BO81a32
 WgYeYGi4v0l8+Fr2Wk7jKbil4oC/P7c=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5ae03 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=48PXcFng3gF8bjtwisEA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The riscv server soc requirements [1] dictates in rule "IOM_200" that
the IOMMU must have at least 4 event counters.  As it stands today we're
creating an iommu-sys device with RISCV_IOMMU_IOCOUNT_NUM (31) counters.

Following the design of setting just the minimal spec requirements, set
hpm-counters to 4.  We're doing that by adding a new argument in
riscv_create_iommu_sys().  In case more IOMMU parameters need to tweaked
in the device we might consider a different approach, but for now this
suffices.

The hpm-counters value used in the 'virt' board is default val from
riscv-iommu, i.e. there's no change in 'virt' board configuration with
this patch.

[1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-sys.c     | 4 ++++
 hw/riscv/riscv-iommu.h         | 1 +
 hw/riscv/server_platform_ref.c | 2 ++
 hw/riscv/virt.c                | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 258c171efd..3a9e22080a 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -219,6 +219,7 @@ static void riscv_iommu_sys_init(Object *obj)
 
 DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                                     hwaddr addr, int base_irq,
+                                    int hpm_counters,
                                     bool is_32_bit)
 {
     DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
@@ -237,6 +238,9 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                              is_32_bit ? 34 : 56,
                              &error_fatal);
 
+    object_property_set_int(OBJECT(iommu_sys), "hpm-counters",
+                            hpm_counters, &error_abort);
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
 
     return iommu_sys;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 403d10b321..0f755b0992 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -107,6 +107,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
 void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
 DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                                     hwaddr addr, int base_irq,
+                                    int hpm_counters,
                                     bool is_32_bit);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79..f8016e14b0 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -67,6 +67,7 @@
 #define SYSCON_POWEROFF                        0x2
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
+#define RVSERVER_IOMMU_HPM_COUNTERS            4
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -636,6 +637,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
     }
 
     riscv_create_iommu_sys(mmio_irqchip, s->memmap[RVSERVER_IOMMU_SYS].base,
+                           RVSERVER_IOMMU_HPM_COUNTERS,
                            IOMMU_SYS_IRQ, false);
 
     s->machine_done.notify = rvserver_ref_machine_done;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8bc5a7b072..88de49aa6e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -947,7 +947,8 @@ static void virt_machine_init(MachineState *machine)
 
     if (virt_is_iommu_sys_enabled(s)) {
         riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
-                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
+                               IOMMU_SYS_IRQ, RISCV_IOMMU_IOCOUNT_NUM,
+                               riscv_is_32bit(&s->soc[0]));
     }
 
     s->machine_done.notify = virt_machine_done;
-- 
2.43.0



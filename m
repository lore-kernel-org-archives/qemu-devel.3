Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629C606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQ+Q0nQ9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BH2bGic4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHpq-0000b2-Jb; Fri, 23 Oct 2026 12:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHpm-0000aD-Ae
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHpf-0001U3-1B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2wqo3733915
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S8cjDPsH4rq
 o57RKzD8Jt0nRW6vxtfzZu90DOJ58YCA=; b=DQ+Q0nQ9wZhVotZcRf0vGBeqljD
 iZT2yaSmfbxpNmURoZ21CqKQT2KTQ0faZtDiO9ucHa9gq9X8C+VNKjQfM5wVwdXN
 BmAUuccJ0lIE+R07MY8RN3DOsjosKQqgiVCbPusDOypCopdss0sCrxaszO+TWA1j
 8f/vISVE1kzwOvDzBG1SuEVOZN7o01zFx2RoIo0DqYnkrig8cSJHfEahwSe2Rs1P
 RHEcvcL8AxPg93yT/gUW/2nzMOsyqk56H5weaZi9oPQ2Z7db+Hr7QQMHc3Ff/+2+
 gvzryqOAkXoY5YlISZDGf1ZYxxN5f2IdOISYxHrsqqM+ecn83DVtfJP7kAw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug0yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b4bf686ceso33365806d6.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771765; x=1793376565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8cjDPsH4rqo57RKzD8Jt0nRW6vxtfzZu90DOJ58YCA=;
 b=BH2bGic4yxUWgZJTs9s4JPFf+Xnu+LMBl31AS2/58ffYfHySNI+mGxuAry/DftR4V+
 UvpX7XvajoSQ58HkjkD18BK+Q/xCxCIjmrnNP/8tbj6k2VFuZac0IpB3OsOGZg8IAdvg
 M2hGQFd1Hza5yBxdA3E395/qaZeDM5UcG+QYyMt2GjPsH15655j8K6sXdEhoBiY3C1wp
 oxUoS1H02h4BudwMtf3kaNf0DI3xUL38NLNy7t8ywGPyXmBa3aqw3POde5Odc/XRHKJ6
 uDt+GHTPIfRi5gjuHCbT5BuQEzu8wlUryq3BT808uRvefcKG5OBMjjLT2D264k/iHIjF
 tJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771765; x=1793376565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S8cjDPsH4rqo57RKzD8Jt0nRW6vxtfzZu90DOJ58YCA=;
 b=vu7NUixTQJIOfvNAEKnxYIpvPqoca3RA4XtmbE4UsafNvXt22Q2DNUcdpCCCHjbWwf
 V12qiFPk7CAucIym5f2izYLfg7I5MGXaIwxSc6Dlw3TaIxH/UaXkLNo0n221lhMBJ5Dv
 zm2bfCgRDS8VM/wv707IYL9rAOt+rLYdg9aWdRlrITxEdyoFvBvpJSHvqo4SngPu5dXt
 CIMztMEachvG17UvulIjeM2KU6WwL98vZj16qYrKAh/Yx5FLKYhBtnicqoVISsSKo96a
 GYH6BhZ3/acKMODnJasAAxNP0XR51JzvEFndVArKrNSrrU+jOSUw9Hl6UPs2CFR3e/sH
 RU+Q==
X-Gm-Message-State: AFq9FYK+ZV3xFQhr9M0w7PR234X+CQnShGTmdkD0x+GM25OWklXZyxDO
 fM7KG6h5yS8DouKuszIzVUF9VnkE+U32QPUfydUhogHXZoIBqANisooh7EDyZ/bjEKiqdrD1mu3
 6eeWizrQt23avKRrsDopsKLA0cvr6Dj1CjqCdCfaJ0ccoPQ3d2UCDe3GjeT9qalWxPw==
X-Gm-Gg: AYBFou0zacz7qBPFsmcEza2vvV5YkdnwYZd/YYzvP4/nEgIxQ+2yb4lmRNtxDU6mW/1
 Mjfe5gD+dMnopq4exepbyHdGwYotQXOR/4kJmHB9wlk0r+mgGZR3ECwqA62fQiZ3cLnaajjKppi
 rgWwmSRnergSkBnl4BCy3TaMZs4O1cWfdXk7/BD/GVFGEzJSsc5n9z1fNVFwCBSaTNGEJG1IpY+
 njFCdjV9yTaw2RZWuvO+Vr1zARbnKoQwTq1vAchIHRCMyEX2w3kBGQ7M07NMnH+HLxPtd8JY7Fu
 8ECpiCGx+viDPoYy5p+TpWYKJpI16QJpr7NPHybgqEt+oloP5GxM/J9ccuLmtkv2pwwfQDvxDGn
 M2bUYJWrer4nhtLxCf6jweXslA1AiWeTd+lab9Q==
X-Received: by 2002:a05:6214:5986:b0:919:8a63:22f with SMTP id
 6a1803df08f44-91c3a9e1fa9mr39205136d6.15.1792771764929; 
 Fri, 23 Oct 2026 09:09:24 -0700 (PDT)
X-Received: by 2002:a05:6214:5986:b0:919:8a63:22f with SMTP id
 6a1803df08f44-91c3a9e1fa9mr39204686d6.15.1792771764511; 
 Fri, 23 Oct 2026 09:09:24 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:23 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/6] hw/riscv/server_platform_ref: set iommu hpm counters to 4
Date: Fri, 23 Oct 2026 13:09:09 -0300
Message-ID: <20261023160913.24992-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX90/zQbHtcygn
 FpKLxFZvz3PuOL7A4bsP03aMjQOsrejFNEUk0FLH3brxQQ41HX8TU9mYzf8dRSOjKmIv5mOEd6z
 G6ym7cem784TAap8ViAgL2NATP2rSYg=
X-Proofpoint-GUID: DgBnmiIJOTTZlvZrskkpyTNFc75xExFa
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb86b5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=YHBa8Q_7aVoFoIsRzr8A:9 a=1HOtulTD9v-eNWfpl4qZ:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: DgBnmiIJOTTZlvZrskkpyTNFc75xExFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfXwY78Ukp89Hkv
 SRHIihRkF30OM6wrkHvEFFYbacFP6gB+uWE1DW3sB+hBzkW2xRot1CbTlxMB6ajlHXIOqNbR7S4
 0QHm4BTEiA4T6FX9RdwTS6o6PeROGcVITbt5YFK/iolsIRLultRcBNDv6ZrbNHMjxoaFu58332E
 JxhPSQRiEboyDpZoEnW4eVdeuA4h6b+eEoQCQFXDh/nHBHJ1tLG3KdFjcDhNd9YaNGIVv+EEeSO
 7nZLEl2kuU4BVG2yAzNgQ+qdM4ciTFU4pySuNA2FfEVVfSJowbxGKab39iobT3RvbDJc5qPG6y5
 nDLLmX2BMubmi8zJIRxRSBaPhaH34ZiJYMh2OqT+T5A2r61MY+GrxTvVgJC20UTI5kUbg3Keg+a
 dZxe2+O5e6i9dWHARS2oSpji6liQ/ymigUaptqKYYRkUteM9R/B1/8VVzArgDmTuSPHOWrTsqVH
 WohAX7++rkgJo6atCzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The riscv server soc requirements [1] dictates in rule "IOM_200" that
the IOMMU must have at least 4 event counters.  As it stands today we're
creating an iommu-sys device with RISCV_IOMMU_IOCOUNT_NUM (31) counters.

Following the design of setting just the minimal spec requirements, set
hpm-counters to 4.

[1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/server_platform_ref.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index e9536515da..ea24720a08 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -67,6 +67,7 @@
 #define SYSCON_POWEROFF                        0x2
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
+#define RVSERVER_IOMMU_HPM_COUNTERS            4
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -639,6 +640,9 @@ static void rvserver_ref_machine_init(MachineState *machine)
     iommu_sys = riscv_create_iommu_sys(mmio_irqchip,
                                        s->memmap[RVSERVER_IOMMU_SYS].base,
                                        IOMMU_SYS_IRQ, false);
+
+    object_property_set_int(OBJECT(iommu_sys), "hpm-counters",
+                            RVSERVER_IOMMU_HPM_COUNTERS, &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
 
     s->machine_done.notify = rvserver_ref_machine_done;
-- 
2.43.0



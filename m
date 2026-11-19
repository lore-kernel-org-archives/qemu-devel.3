Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEE606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EI3/8hZp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWUJXHbT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTxRC-000499-QT; Thu, 19 Nov 2026 03:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxRA-00047s-QI
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTxR8-0001Dj-Ns
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 03:24:08 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wGqY1534880
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3TVHY9ySHYw
 sgNq6P7xkXcHCMyQ08aYCW+Bze0hAuhw=; b=EI3/8hZpBta5AvwHBkBq4gJcNaL
 NpcBZihIgTnpZ6EZc6IjM8WFzJ08FAobAefPcdEBcMSfkysA5UfpQA4yaviUf0Js
 E52OmyZlPywUoAsGqrzNHATpLommzFVHAFLBvJoL5nQGp/JONifZiXMCK9VKLL2w
 8vApnjQs4xCl8yQHTbrmPRH8GHNU8vzsF0oiYCXvysmmkwdRKYFj53zgBYyRjYzR
 yqshY2IRJ5hn8vgZPVXNxDp26W4Y9Ya4UtQNMSvVAaX/wbh7flcc9S2JDfri8zah
 rdRYxkpeMvHcrjqbatZYioG1c6mLfmB6O1xtDArDNxK9O1qg2IoQ23mvkAA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcc5c5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 08:24:04 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9210e1277efso46682446d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 00:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076644; x=1795681444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TVHY9ySHYwsgNq6P7xkXcHCMyQ08aYCW+Bze0hAuhw=;
 b=BWUJXHbTqhdh0NUGQbR+ZncVq12lBe09Z+VNvkU1b8haotG6mmppRJBmOwKA9ZFVmK
 6tr2/a4pTl+KqobUjrPcpn6jROXoLeGTpPv3ObEdE0rp4lgH//FjK4AWGCZk9riPuZqL
 a+lhChJOrTnNeu5NVMh7xvqq+DQ36biWbbZDItwcdeQUoIsoFRFs18Fgr10WEzr7WCRD
 +u7K34/AXZPE2LggbkVs8IbX05TXUPAmENwMSO0I6XjkOUYA7qQkjaDh28Eoqd8RgjqW
 QkCDvFhY5KzDawPkQs5+6Aj67cqNsY06OxMgYgS8xmMSNSAS8QKNRC0xDiDYdUgCGQIv
 6yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076644; x=1795681444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TVHY9ySHYwsgNq6P7xkXcHCMyQ08aYCW+Bze0hAuhw=;
 b=xCZXOHf61YVaf2zG5pQ/HTgVC5urVlUyqcgvlNm6TPVD9V7XoM7YYHPgyCgEEgka2G
 4ZCQrDA5tkrIhmKmHwh+9o91Rhm1D91oG9eCnZBPtuBn3XIjjEgf4IsS8I0rioPdVgAH
 Cju0BX4e4HjH5nFaUkEAU5hiw/c6pa09jdV7rLXGrfSVcz1xWTirIh98uU9SwQs4plcN
 7lUCnJPyDBWCQFhlhi84zFGoKS3Juww7M7FP9kNr/xHiC2Euy+8sXTnetNL2J5JXzgtB
 JS7Cs4Ntsv5us3lgFubOTuYaEXWyya+LDp/jqBinLH4eZyfkOSittJR1Yq0cdQTFYkL+
 Hv8Q==
X-Gm-Message-State: APuU4Z8EDY9UjqKRUtsNkjd61xHuAyaykyuUKM/6DG0pJ4M6DnP6FLjk
 dTwCUJ2xzRu08UA2m0jCV88E1dRUE9M+S8xL6sxjHae3JoVU+ct6X2RFffpTkC5xyj0K7z73XX1
 dUIzJx4fPINJt1OFvdljOAr3zdT1HTjiEXhSkdbtKapYhfuWh+oKPns4LvrYsn0NU6w==
X-Gm-Gg: AZFdTZe1FJE6uw+A0JqoscytfJ2HmlIdem1laCRcSN07efsVcqa3bN/suNVv6kImBqb
 gr4f8NSZXCwGBktwzPFfxuoVpdsqSU7s+lcgw/SdOfRPQCpS03TVrwIEyXl41/grD3MAOme2Aip
 OZS3NbRq1wtQM7OmCIVRYazDOjOhD+PGNbpcA5Fd6SwSAkBpzHBCFb8+VoIyI/M3iFryeXsvA8q
 jfYs66EEzkFsSkJ5t0Sp+IhrDoiAEswb4iY1yEoocOoDmZmgnuO93zzK7/T5w3z+psMKlq2lQMK
 BTmaiWQXLDoGUvbqr3nvB94HtSU1hrpiAKUfttlKgjNKLemDd/qLlmDGCSEn5sbHpIPhP36Uxyb
 inGiJIdByh2RYPPUFuPdbqXpLU3upz0jKTtuae8exSdOHZMTomSnG3Vp/aeui+sW9cTUyLwkaBh
 dPCYD05V+S
X-Received: by 2002:a05:6214:1d2f:b0:91e:bcf7:82f7 with SMTP id
 6a1803df08f44-92114debcc7mr84339986d6.13.1795076643626; 
 Thu, 19 Nov 2026 00:24:03 -0800 (PST)
X-Received: by 2002:a05:6214:1d2f:b0:91e:bcf7:82f7 with SMTP id
 6a1803df08f44-92114debcc7mr84339746d6.13.1795076643124; 
 Thu, 19 Nov 2026 00:24:03 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([179.193.8.137])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9211a6318aesm34524136d6.39.2026.11.19.00.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:02 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 1/5] hw/riscv: allow machines to set 'hpm-counters' for
 riscv-iommu-sys
Date: Thu, 19 Nov 2026 05:23:51 -0300
Message-ID: <20261119082356.1264726-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afeb224 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=a6tGUzlCxnQfwxx7nGpYxQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=48PXcFng3gF8bjtwisEA:9 a=iYH6xdkBrDN1Jqds4HTS:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5NNYuMcbsywk
 BRGBNfS55RPKqYAceCx6sPJutetJP7TNFi1fxbuvYC8SYKQn84O26N8rbJhd78Imp2x5TJrYhGe
 4HXKLjEzcuRxDj0PnplJ4H6Qg7/yhi0LRvwL8pCsNpId8sZh7hJGiOHNEZ3/le43r3bcKsswzbW
 +HRuDepwPcN6B8nw5e+IZiTugkm6VZysafIIBbOYombO1ZD25194Auo1cGUXqcpe/+Ekx85ONp4
 nGl+dhIMLG+i7g5D7Pymi7HBkhOt6z9L7u5Vualrrlh9qweAmrbq8GQK+DmhQXRho2M0qANx4bf
 wWb/CPgB2vISshpKp6mYzs6E7aA4IcfDSOA2GmkDSF1GFpCEPWWPdXMBc7jLwwX9t/5tsMXzxfa
 q0kLiFHCcz2IshLSv0+oqzMQzQ+r3mHatqMYTblYOHhDNJLYykqQsAmNuZ0oper3cbrn+0Q58YV
 C1U51LOMIcQAkuXxrIg==
X-Proofpoint-ORIG-GUID: j1Nkak8xFw_mA4CEUW5upTI7-QpY4pbF
X-Proofpoint-GUID: j1Nkak8xFw_mA4CEUW5upTI7-QpY4pbF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX4hgNEqkGgudp
 3ss8zOnhUpo8Z7L3zKd6eh9OS1BXgxJ6CAWbYQjTfEOmQNfvQLItnuNNiDNN8XDiuiEQljWaSSP
 W4jsplESVdkY1h+fTMpjulQB9Xr7gWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
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
hpm-counters to 4.  We're doing that by adding a new argument in
riscv_create_iommu_sys().  In case more IOMMU parameters need to tweaked
in the device we might consider a different approach, but for now this
suffices.

The hpm-counters value used in the 'virt' board is default val from
riscv-iommu, i.e. there's no change in 'virt' board configuration with
this patch.

Note that the 'Fixes' tag points to the riscv-server-ref initial commit
because the IOM_200 rule should have been there from the start.  There's
nothing inherently wrong with the initial commit for
riscv_create_iommu_sys().

[1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html

Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
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
index 22b3149ee8..fb770cf6fb 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -67,6 +67,7 @@
 #define SYSCON_POWEROFF                        0x2
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
+#define RVSERVER_IOMMU_HPM_COUNTERS            4
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -641,6 +642,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
     }
 
     riscv_create_iommu_sys(mmio_irqchip, s->memmap[RVSERVER_IOMMU_SYS].base,
+                           RVSERVER_IOMMU_HPM_COUNTERS,
                            IOMMU_SYS_IRQ, false);
 
     s->machine_done.notify = rvserver_ref_machine_done;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dceb3ff55e..016003d73d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -962,7 +962,8 @@ static void virt_machine_init(MachineState *machine)
 
     if (virt_is_iommu_sys_enabled(s)) {
         riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
-                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
+                               IOMMU_SYS_IRQ, RISCV_IOMMU_IOCOUNT_NUM,
+                               riscv_is_32bit(&s->soc[0]));
     }
 
     s->machine_done.notify = virt_machine_done;
-- 
2.43.0



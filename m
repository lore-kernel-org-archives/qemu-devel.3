Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0EC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZuHWLxAB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kdEiDkzR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHqg-0000l2-6L; Fri, 23 Oct 2026 12:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq7-0000dt-Od
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq4-0001VE-7e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE63L64064343
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hKngGAPqb7H
 KNATxHsXTSIaJgaUH84fCv+sGCJ8OAw0=; b=ZuHWLxABamoSbuiemRfaOcw+MrC
 8z+ABgT9lEofOOwPNQhyqyJcmDY/vyyNTPlmGKaw+dhXkXdbX1B6NLzRAuhe73jS
 /BNekUH+xbL0OTsyDhn2pUSvPpHk5+m+pMOfd7XjoSGUcAO8oilNG1rXBiph1GOK
 ob2wSXPqAOzacHIETuCiluRsk3xk5JAlz4AqBEZ5Nv7gEAl56dhYfSuBc7+jqa9H
 AzoKlKK46aVwMVhTr84HPouDNP4sLuYTVxxyNpULiDz0mtswEUcgraR4GuypFSVw
 8K+Acpk0GFmnO9ZTDD1/YgBrh66sebaeEA19AR/DbPzp7nRKkwZmbM9jaJg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcfr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9195c59ac8cso31309866d6.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771774; x=1793376574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hKngGAPqb7HKNATxHsXTSIaJgaUH84fCv+sGCJ8OAw0=;
 b=kdEiDkzRH/rbZREOaRXWNmhF8IkirjPyx/wECjRrB/UMCn+Q9sqsyRTcLNbj46uPpD
 g5p0QNIxwsxoMQ++XfF9z7QaEHZy2Jemd2+zVj+DFtr+ZKIZdg4sBIw6NBfNyCDh+9OQ
 XLwtmyc504YlhF9lNOAkSM27MSQGibjZ4uwC2KtGXShP5XnwZQYMEV4dsIMOaJTrHSnN
 nLK371Wox+5ka+wAdVFtBt5R0t+f1eFPM0K4wNDKgd8UEuRJjZ/NHNDBsU6XNE4O58Uj
 1ZWWJfaIaCF1sC1jMcjhVrYwkVnj7rJtyfKv9c8ITBYYef0DdkMrNHKkDsfjjEdbbtf9
 mBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771774; x=1793376574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hKngGAPqb7HKNATxHsXTSIaJgaUH84fCv+sGCJ8OAw0=;
 b=UUvGkFg2oaF5UClzL4/n/jyRNEK+p4NhSlFnDthacELtO7TXeVj2QuYuoRPJtV97EH
 aKL4e735jcTNp11CPusC4mjsw9bJvYDh1zz9jVvPQeEmHBf12AJqvgtDMsSFkU54DcbX
 eqlLTTwizVRLD+poazJiGKXNO4rJNAb7tcFenG1RsqnipgcAw3QMw4ee+o1DPVLL62jS
 4ujq4EzFWpYJGh/BBIjKSQEwkE8vX99LPDnAlDNJTs34vD64AxXfENoJU6kDV+ecoXZp
 B98IoOugD/MZOGifW8WjnBuL9P95eJ8hdRGJbnCn4lTyQrERLIJ1Jlr6JsuFEgzCd+bu
 mHBQ==
X-Gm-Message-State: AFq9FYIIzq3XnSEgCuyolllGLxmgzvT4uv7DuQcLwtPDXe1lzWf/o0AI
 Ff8pA5YzvKPn/0jpYdCXzvHVAyhRfzwJI79NrP14UW9fOKCwIsHb5t89BIIR3ahkyOF+sbu8tu9
 Db48kdp7oNXNdCPpmSi3NZZ4uvgcOoxBJ0KIMghNpTwbfNomG/FcSC4CFjabPiFtaDw==
X-Gm-Gg: AYBFou2kxORdDvm1Bmm9THuOVsXzDPaTCTQ47XmAncnN3kptIb+vykj5kWJ67Ngscgx
 7+RDzJ7wNa0uqGHlnMJj3mnyAUwhJYIfdTo21bsmy1YxjYkYW/HsGH9HTnVUA2M6+wve7xZWcea
 5ZBbG2tSGQjrPzYbqxkqYZY/GHbAB5ggAvMFuxsPymuwHob7eo96BCOdp1XcNhanX5SilcQgeq7
 0TT4eRLa6Ln4+06f0rDnJmnVWWYvGhTIaLS4xBrlj5XvJSabT9YpVf2WmNZD1dWvwRS9zAatxpt
 sy4XxwAn8UGlfOuTuSUiybua2mpZZvXS8RucRKnMKbgFppJm0glnZby9PYQXOuoimQ8fxhzemHp
 ps+LlvCnzr4xxZf0mx2ck2M74OuGkhsO+bfTCOw==
X-Received: by 2002:a05:6214:3c8e:b0:91b:9061:b808 with SMTP id
 6a1803df08f44-91c3a8bc7aamr38651176d6.21.1792771774529; 
 Fri, 23 Oct 2026 09:09:34 -0700 (PDT)
X-Received: by 2002:a05:6214:3c8e:b0:91b:9061:b808 with SMTP id
 6a1803df08f44-91c3a8bc7aamr38650606d6.21.1792771774042; 
 Fri, 23 Oct 2026 09:09:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 5/6] hw/riscv/virt.c: fix base baud in serial_mm_init()
Date: Fri, 23 Oct 2026 13:09:12 -0300
Message-ID: <20261023160913.24992-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uTXgE39T0Kiwv13Mw8EFUM63E8pWeTan
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX5kwHwI0z3bNA
 FH5oJvOrR6dXpCAxiS/Zi5Pa11XJxRe/V9pfdEwgkfWejDzhTKGQzmvauIISwBNuMEXUahinpfu
 BDYzsohp1i8qLHarHc66iYeGP+7nlss=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb86bf cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YBD5noFLO0MiZe3rPCsA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1nA/hZO5wyys
 tQLOBMc2gFsqMis+tAN3+q/mswvPpolKaiPJbT/HVapPHz6w+rd6l21rwZIgogOvErdMkhsC/kR
 bhaf/CH5RgukeGSaQ6FVj1R39e7nD6i5tr7lZHW8tgyzx0JVXwYNg4wIkNlq3bdVJI7HEGClzfr
 RCJBJCo7w+YHEoj04w4NAR1r6P8Ns97a66k7ZKZAP2Y/Daswx6ddv1dfH9ph9MMBi0PI+YWpBiz
 bqsL3qH1ggCtlTtHA9KjknJzOKU4Rc4miLHVXeFvKXgssCY7IvS4Ak7tI3fFRAcR45dRES2BqdQ
 A5ek37SCp2JGAr1320e/8VnPQv3A+9cf+nirTlyPfQ6ybxWim/Mby+21LANjphu1gW2FbmNjKL/
 Eoh2/AQxAdj++A7DrQ2fIQAP4hYxGX8dLp4i4bA5d24YAC8T6I+488sJYalvPa70hqW6k0EzREa
 4Bm9HhlVfk6cB+EKHcA==
X-Proofpoint-ORIG-GUID: uTXgE39T0Kiwv13Mw8EFUM63E8pWeTan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

We've been using a base baud of 399193 to create the UART devices
while, at the same time, reporting a clock frequency that represents
a 230400 baud rate.

This pattern dates back to the initial RISC-V port and so far seems to
be doing okay.  Linux thinks that we have a 230400 baud serials and
nothing seems of.  Or better yet: no one has complained about a
potential bug in the UART devices since 2018.

All this said, set the UARTs baud rate in serial_mm_init() to match
what Linux has been seeing all this time.

Fixes: 04331d0b56a0 ("RISC-V VirtIO Machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c         | 10 ++++++----
 include/hw/riscv/virt.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c4447d971b..03c17ce7d8 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -908,13 +908,15 @@ static void virt_machine_init(MachineState *machine)
         VIRT_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
-        0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
-        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                   0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ),
+                   RISCV_VIRT_UART_BASE_BAUD,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     if (serial_hd(1)) {
         serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
-            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
-            serial_hd(1), DEVICE_LITTLE_ENDIAN);
+                       0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ),
+                       RISCV_VIRT_UART_BASE_BAUD,
+                       serial_hd(1), DEVICE_LITTLE_ENDIAN);
         s->uart1_present = true;
     }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9a..f66d2f3342 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,6 +121,8 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
+#define RISCV_VIRT_UART_BASE_BAUD  230400
+
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
-- 
2.43.0



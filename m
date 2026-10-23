Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC6606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T8Lrj/op;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LwvOEHNV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHqr-0000nY-4l; Fri, 23 Oct 2026 12:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq7-0000ds-Of
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq1-0001Uz-8W
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5wob2109142
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9cxXdeYXoSj
 5qiwMX3CVbxaJApluvZXN6CyEkrkon6w=; b=T8Lrj/op7M2fd5oTuucQh6lLkLa
 q6Y5gz+T3nsdfaJMSJUc/X8+yIYIsww9Ote8gJ2Gsmsq1TVBt3D7A6gvv8egQIgT
 Rb9BHcFdS4rQE6nKqXxV7GiT/aDjrgb5W1gROgpxuEEe0dEFVdv2S/Co293aVTwT
 75AtluH31q1mErY1pnXWAazp5fxAxvTn4fkZ/SaCYRAtLdXe+gNicP2YZrDyS0tT
 zKGy3r1mlaULzdzU5TN2RctbGltIt8B5gsl6pswuEe7kKa4Nae9R+TW2Hi2G/OsF
 RQvFPTSAEfj+6fT+9r9PW/g6y+8csk4nrFA0Rri97YZ30oSbG1SucmUJSdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4fgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-535131e4c25so23092011cf.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771771; x=1793376571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9cxXdeYXoSj5qiwMX3CVbxaJApluvZXN6CyEkrkon6w=;
 b=LwvOEHNVy4p/0wr564n+uXEIOu2hCDTYuuNdEu4SQ/UqNAhClO/9x523EhXAdgoxBB
 TmxN5u7Q6BNnaOYixE9vISyTAjhqJmNcQ2jmR5vxNZpPt9QB5BO2g6ouUtDihG621LaZ
 owlnVgT031XUOG4Y6UcxIJtBM+bVYdfbx2WNOnq/NZcdGY/oCBCgGx7K+H5hU39zpSjd
 s6lUt2lK/vplJFHeMPF+z8EGP0al+yoxPRTJ0dpKVzQ25dVPJOXmBXSAMN5yVL6I8ziH
 XKTH7F9E5qqLTn6+1JIuZ6en+RXQkC3OISej/24OKMemSs01SldVxMd7N5Nw5OmqTA6h
 vbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771771; x=1793376571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9cxXdeYXoSj5qiwMX3CVbxaJApluvZXN6CyEkrkon6w=;
 b=hbcyx/KRCr8NLr9TXltoJTGea3TEnx5b+hPpAxo2lUqZOxye+BRwdMZlaeWIgT/EfL
 2FJaHKy9l9wD5ebI709q6SCHl/aZyLg7EQ2ZNXameernSgXjRrDECePjQkq4zogIkHt3
 ZiLHlntIiZlKgfHy/qoCwcd/HlZkVnwQY9Hpuene7uiaGD5ojiBSbyAfF2/vHxuDs5nd
 vFCpYEX2WQf5VrHuR5rbcZ4E1HuCrAvZK2WXmwffJzp2PUp/P2huaPMm2Ry4jLwH081M
 pP9CyQ3vALxySDST4OazZ998EWmEzsQRAnCiqDzPCQqqPj8pxLqpIx6Y67lybggjRBB1
 aU+A==
X-Gm-Message-State: AFq9FYK7uKjByy9kNJKvRRZlpKc6v8yghJ9JKKqO2SRNAMAVhkiet705
 HWFRvc8pCPMXcvdT91EFf667j0UrdMw0f+us2I9W8LFx1ggFNc3EA5/M2M0DAt6yXFgZmCVrKr+
 9I6Jom6pJ/Y4sDoxacLGs3ZDnOg5IdZ6nBzvbsdZEkc/iOIyIR/cnAMnUq1iBRdVwew==
X-Gm-Gg: AYBFou0UkHeahAlyKedd5SJqhZQASATUaOdZ38zwOLy20BtRgMTUCpSpwH/QrCCnZW1
 HDwuU43chxn8WmfXAPvnXSbbFz4O7UO/ZcqcyHmhryPZtTjraJAX756mMY4a2NSdNDc/0+VMV1u
 BM+flS/lAqOwfQgFKHbvHBAWcLxbt21pYzriBSRqAkRjBHNA/6DLYxy8f9fAd7PfpYPrM7CjrBJ
 ZTZlGfaXet0tUS/I8jSW+TbujiP7kQ/Y6SE4a9Y0kJO2CwXm1VLrD11XfkjFNYlDIe1s2PEMMd9
 eNFD3OLn9/J6I3GD2IJnYh4R9XVIX4AcJQxC0MNrwc1ogYHFp6TFxz3VX6NblP22u7DOURGq1Hr
 YYfUx++tVAIGwCQO4w9k7E1xwuzn+1vb8eu81tg==
X-Received: by 2002:a05:622a:2586:b0:536:4cf:4875 with SMTP id
 d75a77b69052e-536c2964993mr36232401cf.71.1792771771031; 
 Fri, 23 Oct 2026 09:09:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2586:b0:536:4cf:4875 with SMTP id
 d75a77b69052e-536c2964993mr36231751cf.71.1792771770500; 
 Fri, 23 Oct 2026 09:09:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 4/6] hw/riscv/server_platform_ref: fix UART baud rate
Date: Fri, 23 Oct 2026 13:09:11 -0300
Message-ID: <20261023160913.24992-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1lS7WD1C8DoD
 hIer83c1LmT4bcNYSC6roULKRAz7tSNvE8TFhPatAgHxUGGuy31UHhWhhlRr74y0IWsodfaJL15
 iQyGomwBLeZhvZ45ADLNo4gceV8XltjOFusKA0uoO7DmyfzdpV4+ZBE7PPJXahALH3EpynGu28P
 g4aZh+lVvlRC3ewhi5TRiG2ZS7PRTU0joxPOPwHZN3kgWaHiU71W/975i+AE4D6WVVvqT9sxJcW
 PVbEOcArzbxcC5vBo/h7WMY1xcCczm1LSo79F9WZxZPVZt9bVWe226Vh3KKxTapHoyKaM/iqn37
 ihhCDSXj1oz/VRTztU4jMKR6UVOLmjYMIYd+1jUsKUToPRa7p7qdDYLoCAyVC2+mjOtcc8PXVrY
 kGqmcEF/bapiCpxtzbARt+Z4n+ssIcT05k7J4nuewNF5FRQQTpa1KBpBEhYbHP1sMcdCXV9VWzv
 HIG6MyjCVi8af/Iy2Gw==
X-Proofpoint-GUID: XNueuQpxOYy2mBAn6DK_OeJqs487JHg2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX6MG//nHjld4a
 rzaYEM7BkmuM4EBdZUWNP3jHA95ZENaocQ01H5mPUn1Z6ORl3q1Gia6bcpZ/f7KMC+w8tmJG0uf
 LBCSGyP9XhMy9/WTQDLWLgwI5o7Clss=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb86bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=HyuSmn1QhchWdNVMt-0A:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: XNueuQpxOYy2mBAn6DK_OeJqs487JHg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The riscv-server 1.0 spec requires an UART with 115200 baud, per rule
"HPER_020" described in [1].

At this moment we're doing two things: the FDT is being created using
the default UART base baud of 230400, and the device itself is being
created using a baud of 399193.  This odd value was inherited from the
RISC-V 'virt' machine when implementing the first interaction of the
riscv-server-ref board.  Linux doesn't seem to care: dmesg reports a
base baud of 230400, a value derived from what we're writing in the DT,
and the serial seems to work fine.

Straight everything up by setting the required base baud of 115200
everywhere applicable.  And for good measure let's also change the boot
test to be sure that userpace is reading the intended serial base baud.

[1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html

Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/server_platform_ref.c              | 8 +++++---
 tests/functional/riscv64/test_server_ref.py | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 3191615c02..e86c37400d 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -68,6 +68,7 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
 #define RVSERVER_IOMMU_HPM_COUNTERS            4
+#define RVSERVER_UART_BASE_BAUD                115200
 
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
@@ -315,7 +316,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
-                          0,
+                          RVSERVER_UART_BASE_BAUD,
                           irq_mmio_phandle);
     name = riscv_fdt_get_uart_nodename(rvserver_ref_memmap[RVSERVER_UART0].base);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
@@ -614,8 +615,9 @@ static void rvserver_ref_machine_init(MachineState *machine)
                                                     RVSERVER_PLATFORM_BUS_NUM_IRQS);
 
     serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
-        0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
-        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                   0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ),
+                   RVSERVER_UART_BASE_BAUD,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", memmap[RVSERVER_RTC].base,
         qdev_get_gpio_in(mmio_irqchip, RVSERVER_RTC_IRQ));
diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
index ad29094dbe..fa7225ccc1 100755
--- a/tests/functional/riscv64/test_server_ref.py
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -71,6 +71,9 @@ def do_test_boot_linux_test(self, tpmstate_dir=None):
         wait_for_console_pattern(self, 'Linux version')
         wait_for_console_pattern(self, 'Machine model: RISC-V Server Platform')
 
+        # Check that we have the intended base baud for the serial
+        wait_for_console_pattern(self, 'base_baud = 115200')
+
         # Test e1000e network card functionality
         wait_for_console_pattern(self, 'e1000e')
         wait_for_console_pattern(self, 'Network Connection')
-- 
2.43.0



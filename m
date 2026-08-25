Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8004C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycc-0003TI-CH; Tue, 25 Aug 2026 17:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycZ-0003Ri-Eh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycX-0002Fr-JT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLAQF63101136
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2xwFh4IjNi5
 ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=; b=c1VwDv0FknXPwOBMOTnlgfTv1Q7
 8KBUx76l2T6MLiMfrphBbe+hYzMwMIMOLMiaP8oi9vay7rFWUnKrJBMrqB/5qrcw
 84zIs8pdA1vwPNTOkA1sPjtBfuXj9skTeOxWJ/pE3M+e9X/dcDu7Cuk/HRDIqhfy
 ngYYllVHAo3pyOd4o0ddFXq8RxViiqSlyemWpwK2+uqWvY1n1XRnnBU/nT4sKLFj
 xaNAx3vo6/FUorbNSeVXUVHwCHkCZ6XuvonvbhtieGOBTsV34PT0tKHcCrIomurS
 WqgEXLR2egw7zPq6UyvJWo88xzI3zQqYsGRv7jmAuC5JviytVQ8VpoekQBg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bkua1vn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f08560ea44so3650606d6.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693027; x=1788297827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2xwFh4IjNi5ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=;
 b=TlBbJi0kij8GseCIqBr0p7ytQezfaLXM64WkW+MQizRyP1gpxC1R3dkZLIUx/oJWzc
 9ZBwXrgfJzyCp6TMF8QQJLHT22SrMtu+VeVGX7uWwPq7DLXC2g7FJ+8sXqr8w5k1SJGD
 9OchGdMlU8oeXUL2I6Gwk/gJu21wLKhsnHSOCBqXoc/yRNIhThxoPhH1qJPsbIzD09zi
 7phpTGSZg+zFYVVNP5uiPb5+F8N93Gskp+5NMZZyq0PUzk3v413x6GnILCFHoQiu/oag
 ZoofolTrhfblVdPFTDvEQa7mP6BGKzaTm4dqAPK6zcHiO3Fl2Cxvq5/zNdxAFcmU4mOF
 D06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693027; x=1788297827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2xwFh4IjNi5ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=;
 b=rim3qzBNRy/FeO6Hkr233cD8V3AhkglEUJIOXuLdoPKVJgxTSKdmBPIojjGEmmYcQZ
 d/Mp2wrhN0ZriTbazdsfVjy0LJRfsk/nQoy6Z6twCaDaEmftXzmsWb70ire9Xoo9edwF
 etYqFQxJ3pFsV4tYU4p/Zwb2WEwpjLMHId3M+QQZN5EYVemuGjQIpOwR0qhuP2bDBPC4
 xPxbX4EVkIhsNOgWUbjJ+G9n0VKsqCSrlZ1EYtYO3IjCmJwN7eGPvCz/GxjsUGqnmcbo
 Sya6hDSwfNDy1afoIi3dGBHroi95B2ThzYem4/C4xQrKou1Z6Hy7D8kTjQdSLSZRBhMV
 IuPg==
X-Gm-Message-State: AFuF++lbVpuxt09ByvtIz1Yn+4EEgqSv8H09fU9DIO/jmEoPcBdswga0
 1eb5M1/JIgEELofmPVMHbHGYTw2gVn9iaXUIK5uqchnfFXbpB4zIXrAHHF+Pb0pCPs/t6TpZt7w
 cutiVKAUtsfe0f6Yp9PGSd7lYN1V5H6nyiO8NNDJUstYgRb96V2+HqrPKkUdtqSoKQA==
X-Gm-Gg: AR+sD10m/urhNAOjRT9mF70J+Q8PzWRW4oqwu1NJZ+GxwZd79ikBngFbTh/om6UAEKT
 nyTqTkcEGKVmN7MSH8Tzj6c0VM069B8x/Xaj3nhCy72nSbBzeZEFBzno+PqmNW/tMk8kAYKtzqj
 BORoAUUMkwcKLjbXt6/ydI0+sJjYsxAgwitcS5PKgnp7CxI7RadLkalyTFoZprw5qmpV8R5/Add
 XgT3MVuIo86WbdCFAxQgCpBtXzU47csmpg4AwzrRp850LfR9r1oDQPzBUWlBYUZYTrCj3eZl3Zi
 ZLMbYk3mOwKVAA44nLchM/wvW07mbKNVzb9EFm6oNMa6cj8LrGxchXIucjuBfdbAeagXinwpQuH
 yheVLFaSfMYePaCXkIRw2NRDGpOIlIar33vEm/w==
X-Received: by 2002:a05:6214:5691:b0:90a:6c34:f8aa with SMTP id
 6a1803df08f44-90cc7929cb2mr21382446d6.27.1787693026713; 
 Tue, 25 Aug 2026 14:23:46 -0700 (PDT)
X-Received: by 2002:a05:6214:5691:b0:90a:6c34:f8aa with SMTP id
 6a1803df08f44-90cc7929cb2mr21381946d6.27.1787693026275; 
 Tue, 25 Aug 2026 14:23:46 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 01/13] hw/riscv/fdt-common, virt.c: add create_fdt_flash()
Date: Tue, 25 Aug 2026 18:23:13 -0300
Message-ID: <20260825212326.1907-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bliCGwi4NZVGdkJ0nEJd13gYUnBw4EVu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX20IbcV23MZVj
 Py++GGfHk1IOPO4EAQz9J4mcPS/ynBra5fNDCZ0L/G2LEGSqVlrnwMgZI5/gnN02/29AeBhbaF/
 /l6Gm53j25ismcjIIbtwFA1FTgNUESg=
X-Authority-Analysis: v=2.4 cv=TZGmcxQh c=1 sm=1 tr=0 ts=6a8e07e3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=agbqTSZeYTzrP7BmR6QA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: bliCGwi4NZVGdkJ0nEJd13gYUnBw4EVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX4K4gSaW8Y7eN
 RZrvPiPQ7mP6GXTLOTtgWe1VGDCTimBJem54Vs6+OxovxnDzAjn3JAL6KXzU0lDrSZ9vLsjEb22
 QqQGAKhL6mzRt2bdyJy4TsysUSUspiinE8rZQ9idFdMhMwXt+9L9ZFUhiMdXdliTHhV9KdwMWZn
 6jLxFKteOa1NGRPxgCGY23ayYDUOb3m/GolV+/1dVEuf4rElP4x7nFLBxU0dDHZHAqfXbv9sTzC
 7tcQD0t17NoQR/3Z/PvgRAjiedveAwEf1+eB8lfhO14wEJ3jO08siNalCeTlnazdXCNqRB1g/QY
 8XCwaRKXh5mVVcn+miItCVLnJaonbRdx9rWY6OtDm4Zmq56JTzMi/bHn8mT9Cj+RRjRhAxykxsn
 j0KmHCaVzmO827dTAV26/CQchEg7Pb1mPo52EO7vNPkCCw6dWUYz1uLjS6k34scCVUNU8x8LJDJ
 42jf5dtyUvppUnPmUzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a common helper to create a cfi-flash compatible flash subnode.

This change only affects the existing 'virt' board for now but it will
be used by the future 'riscv-server-ref' board in the future.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 12 ++++++++++++
 hw/riscv/virt.c               | 18 ++----------------
 include/hw/riscv/fdt-common.h |  1 +
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index aa143a618b..e74423a225 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -282,3 +282,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
                     fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
 }
+
+void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
+{
+    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, flashbase, 2, flashsize,
+                                 2, flashbase + flashsize, 2, flashsize);
+    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d..33a121abd9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -865,21 +865,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
     }
 }
 
-static void create_fdt_flash(RISCVVirtState *s)
-{
-    MachineState *ms = MACHINE(s);
-    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
-    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
-
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, flashbase, 2, flashsize,
-                                 2, flashbase + flashsize, 2, flashsize);
-    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
-}
-
 static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -1040,7 +1025,8 @@ static void create_fdt(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s);
+    create_fdt_flash(ms->fdt, s->memmap[VIRT_FLASH].base,
+                     s->memmap[VIRT_FLASH].size / 2);
     create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 1729a6abc6..6e438e0278 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -36,4 +36,5 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                      uint32_t cells_size, uint32_t ndev_sources,
                      bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
 #endif
-- 
2.43.0



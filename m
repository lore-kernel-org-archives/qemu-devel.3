Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCBC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLSZ-0003GU-8C; Wed, 26 Aug 2026 17:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSX-0003Fo-Nx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSW-0001K9-3K
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdJjW2001174
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qhlM4AGMyCVZ95dreHz0+kTWKwM4+JZGvYvBNFPS+MY=; b=JzH4r8B3ZRC2ePMs
 QVVbT7dV60t76LQ7DMSgKhxdrGP/SPti4hTHN7omXsCRjW9MBC+3LtVjYZhpJBtU
 U91M2ynCkMHqThXayT6PxQGgotCpHHg3H/dNJwJ1QfztVWkWyyFWimbPm7NReOnp
 m3nT4RC0gR2obXwc3i8S8TFkd8u52O0kX/JesQwjDbh/aOjPiR6v1lEkKUZG/UJS
 KYf+4Qs6eS2Cao29SxO782VFSaOtZ7mmj3Vf3efQE/ag8VzYH8E4mV2Car11WjSl
 JNTNFFfn+SPScNv+1Knb473XZTOH+jBN/kDr7jXE1mn0ncGiE3R919yLA3p1gS8A
 0pQKRA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec8w69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:46:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cd14f82c8so5716816d6.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780818; x=1788385618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qhlM4AGMyCVZ95dreHz0+kTWKwM4+JZGvYvBNFPS+MY=;
 b=ga0z/szv/CSrcInnW5XjnJ95I/5mRp3wBOsr6Og1qbXhHRYpmDvc2cpfmpqYswmSJS
 +KzkeMZZBaI6Sr73aix67Ul751UmZZMqhYjSkmv+uks39wHTmJCfZETrRvZ7FI/hgZZA
 vp4C53a+AHKfb+UI0J/JVBAsPPmUhfLnxmK9KM0LwecCypJVEM8D0JW7FxMum3gmN9PG
 44j0UzDcyF1LDPOgXQ7oT5Ez1Njy6/UpoL02g7kj7QD9p0nJyg4bKFYNk4tG4XdWPHBt
 c/MCyOywk1/xZ/LIdxji+uHlVe3PhMystU0e5y/eXuVd8Ohm0e0AJVEXE2B5W5T/FAMB
 BI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780818; x=1788385618;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qhlM4AGMyCVZ95dreHz0+kTWKwM4+JZGvYvBNFPS+MY=;
 b=DTCPIaAi/2YfJg7fS4/SfKZbnutCq6W0XDevgqMzcAfC/4sld2mzl1kag7BnilL0X1
 l0xvHq9g5fgqhcWgjcOHJealNMjEWt1Z98VDq307Vu9sMhW6x9veUKPf9eZRMt8Zfqv/
 7T+oBTaD7NzPY1KKas47s2jI/dBTTeGYMv66Slk3I9OCotzwPXk27hOI06lFe2BctRZl
 JmrbjtM4hIP0UocDqb5Z1iJnyXfDV1Sl5FuFjvMtk7tCmHvEBIKV0EQ+S9htyxX7fLED
 TtOvFhWLCfLcosheXLqz7HnNfXhw+5SnpjOFLr8XiJpMe1/mAIh1hO7pxRLvVtpRJxXe
 UTcw==
X-Gm-Message-State: AFuF++n9UzemRjghjkdA8nBJE/WBNg+Ity/hu31oI8HVyQN1jRoTD0+y
 5jsuEqrFfuDAXSp3C8EXBVTPWoNVw0aK0xSHPtU0tWC6jF88EMVaoRiD5kpcBNwLk87kmovATaz
 P/hapgaHZ/L9sOQulSYLS0Rb42aeXxz5f88gmK2FBq87t9D7vO+KUMiH0+PxUD8a0Hw==
X-Gm-Gg: AR+sD100BNIO1mE+lULjPjX7W11CdxceQN/P62ghTh5ImV/w1uGGhY7ezdStw6KEKDp
 uX+UxK4C6arX1xhhi6d+Bxh5YUmcrdC0q45WrNWZTJKj/cBdGmHVPhTHIOVbNwoY5DQgThW+BVO
 CEZ3TCXY2fHa+mskEBB+HRkATQTSampAguuZij9tekkAGRNq3gCqWNDQ7Z8bX2GH7TW0+P+18OW
 ut3OgYb/nAVr9duP4Q6RjWQegs3XDpuWb5pGLHZZ0gVYIbasdIxKDnpuodEknzVwtKqszPJKXPh
 ++Ef9nrCAb/bzuVb0l5w7HLiTxIl2/GPlpIhpEKByckcJ2++T/rUbAJ3WRmKUPSjBquJEEVczO5
 k2JyreQl9S6h8D+7+Z5utOb1YNKzRLbjsS0lqrQ==
X-Received: by 2002:a05:6214:6354:b0:90c:cd19:1ae8 with SMTP id
 6a1803df08f44-90ccd191b20mr60683136d6.25.1787780817635; 
 Wed, 26 Aug 2026 14:46:57 -0700 (PDT)
X-Received: by 2002:a05:6214:6354:b0:90c:cd19:1ae8 with SMTP id
 6a1803df08f44-90ccd191b20mr60682816d6.25.1787780817158; 
 Wed, 26 Aug 2026 14:46:57 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:46:56 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 02/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_flash()
Date: Wed, 26 Aug 2026 18:46:30 -0300
Message-ID: <20260826214643.122728-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f5ed2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=plQfXIS7czum7OicmoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: eVYigqskRCNwMaIMoaiRD2Zv9ITE0iYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX/aUiiT2M5rCX
 btgwRlYEwZRejGwN9kUdhvs943NeUb76gj3flRAaOjCmmCg4q8oCxHhOkL57WbmKAD3IDiyxsP4
 +VmiaRElQsDm8jCXnqOibo5JnZ3OjtF2Y7iinN0+6pSzmSxhMyLnWmkhVQsqy/ArN1xqJ9qFC1h
 t49ItXasFqA7aYmvb49YTOAJ6j9Vwovbqpm7BEFVDQkshh963YOmYDg4R4mJartEL/cETKusFy1
 oc2KmPg4A4EjQu2EF9VPTLJJ32NlhI9IZBcbXWkXAwKzdjbIcYf3hS63Ql4/f7O9lWioGUcQZKm
 kGYCu3phr4yKgz71blvOetFNv0zlpUWqTuULIHriqCg52CnVCd312ZoxW+8NxSaBGAU8/d65vw5
 QdwhaEaOR3NbYWpDdPh0lQ2USYDamf5tWD2GSx2A/j5hdw/6QkG6K+WOstUFcv/FI3r4h4FSqtb
 IudJIynUvIn1gZCIgZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX/AX54MjbscYC
 0LsUJi/HWCUjmI9QsP5eUXIoJp1FSdXoDm5+4UpmJYJbCIcyqNZrENNHkHE4ooUczo7jQAq3TFY
 oddfghJqiu789Rw+WqqAtKFdkaGVemc=
X-Proofpoint-GUID: eVYigqskRCNwMaIMoaiRD2Zv9ITE0iYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260183
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 12 ++++++++++++
 hw/riscv/virt.c               | 18 ++----------------
 include/hw/riscv/fdt-common.h |  1 +
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 3a8da03cfb..6fcc1ce21f 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -283,3 +283,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
                     fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
 }
+
+void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
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
index db0f7ecb81..56b984c5e5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -866,21 +866,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
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
@@ -1042,7 +1027,8 @@ static void create_fdt(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s);
+    riscv_create_fdt_flash(ms->fdt, s->memmap[VIRT_FLASH].base,
+                           s->memmap[VIRT_FLASH].size / 2);
     create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 371971d79d..b422da6aef 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -38,4 +38,5 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            uint32_t cells_size, uint32_t ndev_sources,
                            bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
 #endif
-- 
2.43.0



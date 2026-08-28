Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7FBC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03MQ-0007HT-Mv; Fri, 28 Aug 2026 16:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MP-0007Ge-A9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MN-0006TK-MB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJsC643880698
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bP2TM9hnKPVBATNAxSJcFqIOG/po49HZ7jY9qs2bEME=; b=bFppLdhxQEev08ac
 98p1m82POQ5O6cBzMcu//0VTeqPBbokTTMo20jfWz3JSlwQ/P8JwaeFZ71vq5S+E
 7bWGCLqRaQ7god79PVTDCO14slRD2FqLT8/KNQERChVk448MDwsNrYDjY+r7Aspq
 AV5JVv8YJo4nodDkCjqQ7RYjtuA0DZZ9nICeG6g+mll9vhyCGhjEIbWJmPYzr9mU
 VngFCvybk/XlongN4RmQ2huQn0+tcisMB5K2CWR89MzK2D0D+ANtxYM7omd/TnvQ
 Cw02sq78ozHK/pTCX9glElqwdv1lfZfObgd51ticvjUf33J0tkpODPh6Iib/jVeS
 0LscJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfg3ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939062ecda9so130330985a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949574; x=1788554374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bP2TM9hnKPVBATNAxSJcFqIOG/po49HZ7jY9qs2bEME=;
 b=ZLujZ3V35A4Fl1ni6cH5xjHbj0/7hpt5PRwShDK3sH5PNH7B4i4kMAW4noPtisW8U/
 RqENIzHaaSqDUQF9/6+D+HLOcrTFlbeVo6aZisbmIE2H0wX9ypgSsNic70LBgg4DQB0I
 ZVt4xCRJUxi1dL9+xdFxiCqgXfGaubeCOgzxtg79goGwBsStrTRpe7ZJ4pBla4gYw8Me
 Zad9YtYlIrQVkyVUZ3KV18Dv6tndY42oebLOyXKHtnzBn1QYo+129TtNHyX/xFxQOPoI
 /JlP2Mtuqk38ozj4kwa05oZznDApnYNdnAUOvAQQ+Js6hpAOzn8M15JfCp+6l5WSnV+D
 eGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949574; x=1788554374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bP2TM9hnKPVBATNAxSJcFqIOG/po49HZ7jY9qs2bEME=;
 b=iZ9QLBlGkPFoCfs/WASK7Sgo8qpSxnFd9xGlTXGg0+rDPwqxTC8ItIVND2//h0IzbW
 x1PV167Uy9MeUgWKFtTpCDHl0qREZx8evPeSvrYL6REkLsaanTSouTvUyati1+2TGL6X
 Zvf2JdOQRrl14MH42HiajuLRE27gLAURQGgoDcrDKYL37p7Ye2xXfYWiIO6tOUhC27+2
 V7t+5YnLcacjt8DJ2/6e7NVImySTvtguK7AlhF4mzAlYtxicYeileUwWtb2ntxbNY47C
 FCs1k9b9pJsG+PWj8PEU1iBVKoM9C+24QPGxBpC5BMcndZV/N6xCP/o4dz77qXhh+dzP
 lB6Q==
X-Gm-Message-State: AFuF++m/xyjxUYqpJL6iq5OZGC3m8Gb9KP/i4n6heqmwmwbTeujdYXxz
 7PYplKNOB8+v7zy7RsZ7A3ZKZE4vHaqt/7FLLqa+szfEm7JTJXwsbDeHBN28/yM6xws9qkeS+jZ
 Dd2KmltRrkyd+uhKjYh4ug5KfXDu4NjeU+JbsLsusIajOsiCbKc/VrTy853C2S0D0Zw==
X-Gm-Gg: AR+sD10kO433MavcZxxxsQG4xH/20mpoThkXZYAbKAa8l4BphvGc/vQFe/Tmas36CRq
 uZIOj28H+3nhXY7RxSPz2GYlyGyxUPSAWcKC6Pf6z7c2kZd/Lx+WBxetE5HCFCzqqqRDVpq8Ei/
 /aMQhZQBimT848/HmHWC3ajNIgykZhrD68wIDAyQCGV3F1eo4uNOmrYVtedu7zSNESITN+vlixv
 RUEhHG9479sQlgOUvspU92D3pBYikrE8NvceTRZ7N3/rIhxyKw4D6BuGCroj8hb0f2AHNEbdufD
 Px3LM4KCmPIwFf9LfUGzxk4pKwfqMhVRl11NWGEy2TM7WIHw0mhaccUH4GGOj+E9nKqlnTtj3Xa
 Taxh3w+zsjUyeQX5ILzXUO9pzOVjtjG9+f2Rd8A==
X-Received: by 2002:a05:620a:2b90:b0:939:1f43:cea4 with SMTP id
 af79cd13be357-9391f43cfa9mr532395985a.15.1787949574069; 
 Fri, 28 Aug 2026 13:39:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:939:1f43:cea4 with SMTP id
 af79cd13be357-9391f43cfa9mr532389185a.15.1787949573552; 
 Fri, 28 Aug 2026 13:39:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 02/15] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_flash()
Date: Fri, 28 Aug 2026 17:39:04 -0300
Message-ID: <20260828203918.350131-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX76+d4W8IA7YQ
 1m46NZka92DMIdFmsMhtkcFOCKE3Gon9Hk7XESpUc5NPECY9h611JER6NVWwRY2MrlXJ1LL6i6E
 4o2gzIBlCJ1ySzhRji3Tuf/tsm1K8lnlqqHQjSireodi2ojj2KbL6UEmO+NiYQ7H2gFkPB7CedK
 9fBEfzfv9FEUYBGWFLl+K0zDviNsoSaInbWeq+OUDX5mqhvfw87gN/1c4WA+CBwnkTHqYGse6ou
 JIH6Ft/3bqCoSK03FvCJDFNxqlgJZ0+xeXQgNCPz/hbpenRFPj0nYpvXg84oyKRVwEh3tc9zq2o
 oWe7Pgzr4IEFcHY194sqqm6RxIMFeHahyhe4dzBm4X2eGAOv/wJ1zqb/FgG0eGUList9R3bVX09
 cfuKkSiIvk4ycyQmr3diqN4WUxXIOzvatFjDiCnkYYyK1MMUtgs5gPoyYhk3pLTLEEbMGdHwOtj
 HON9sm/PVeQUT1mq0qw==
X-Proofpoint-ORIG-GUID: uEl73lnWo3COvBWAkRpPFBD_vdcjh0UC
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a91f206 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=plQfXIS7czum7OicmoMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfXyzXuVsCS/Hyz
 HuDV3BwUz+vlmOYwFBlUKIsUoYuKR6LglxTcVMvtyYuaBV9nl19kqXdQkja0bsMhr4pUzvLlUIn
 iksmKf1zOxc3OWTDVj++zqmL2XvHw7A=
X-Proofpoint-GUID: uEl73lnWo3COvBWAkRpPFBD_vdcjh0UC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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
Reviewed-by: Chao Liu <chao.liu@processmission.com>
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
index b796220fc2..e48337dfd9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -867,21 +867,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
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
@@ -1043,7 +1028,8 @@ static void create_fdt(RISCVVirtState *s)
 
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9ECC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYN-0005FD-RM; Thu, 27 Aug 2026 18:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYM-0005Dy-CM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYI-0001Ax-J3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLss3848961
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N2OSowAW61ArPpCDoPFuyUhUfujPc6kA+zxGuTvZsiE=; b=alnJtb1gYz1jPToQ
 da/YAhSd1hqQRV5yyxHPsE1pbZMbj+tULPd+VcOIwK6sKnAK70N/QaHxwpGwE1VP
 KU9SidQp0lmpx6rpzORHzUnH6SNvVXK+8wbmk6677ur9R/ITafY2UOt+H5eLKm6y
 6MhuPXnSTwuWdoNanvWVGHF1K5hreBMkrYb+pTHN6IxG21kiYNtxiqqMZ1e3fms4
 Omrrp2viiybwPffZR2jRBZL2bd8FuHx0r1QH2GQzoMaPzfeKOWejt/W0TkVKg8vg
 JZONk5z7dd11WCDKH8UXo8qWnuk377T07S6RqHAzhn0kwDEPcyw/GeQ8s6zImaM6
 b+KjuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a81v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93494cce712so45235485a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869587; x=1788474387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N2OSowAW61ArPpCDoPFuyUhUfujPc6kA+zxGuTvZsiE=;
 b=BzFKQ754O7spdThjnF8IBX/UaBKhLXOn40gZwC0LIxwSXTAWfsUjYC1nm3wnyeOePp
 1S8F0FlxLQBKVWv0s2yIxhHBpv0IvjjoY2HTvgBPQti3AHJ0DDvV1WiPDy5CasnY5P8o
 VweMh+oRpLvS4ffhWjKbHYhVBUIIXJX8+1wx5yeBlAUBZ+km0mMZt90HMaRQ2YP5JYyf
 k3zjXteE0q9jcuCUWZSG1r2OHn7ezSEeU1z250ApLHqu0JCqb/1F6Ijl/dEdMdlL9rit
 S32xujeFnqGHlai2gS0/m4X4MNfKbjci9ACVJnhzUEbiiHVZZhmavKNjJx2VXRaJkyh5
 uvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869587; x=1788474387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2OSowAW61ArPpCDoPFuyUhUfujPc6kA+zxGuTvZsiE=;
 b=iJBUpkpXEeTTdbRhYLlaRlF6UE+EJzKczzOfE2AWxTs6xDAjakHeySjbzFgrWPxoLP
 P4tNAvuUNOmKZ4CQb1g0b/g5LV4IuQsei68inh7KLPOd8s04LitcIG6qbQuU694811kS
 tJQcxqS5pxfyykveCgxiEbGTg0lBTwo80QhWI0vhprNN2BX0HxEeVORIh07oiWj1AgGI
 RhLpSN9dCTBZNdZeGjgmuViYbldPiZMQKcPtLkFr+lCX7AGiMHt9qTppAKVhdmgBH5HT
 OrxOUupsI7Vrqexyo7BBGXyRqXU023pvG1mZCiQvIFPj3rxQlsT4bjpbT1lTgxJVmlUx
 7VYg==
X-Gm-Message-State: AFuF++kgjfgdL22eXgtCoen3IsyjJOFFHpiDsZfC77j2QjsTOBsILulV
 S/xBN+wDs+53QQHVxZUUscss2hYdDcq1fePiKVP6G/W4k31Wa8wYGobbXs/rEXbiMs1BlArKLTB
 hh4jVnVG4MTCQOE1he+bdBZbLlsIY4kK3XfZxDVM4RfQOFPx6PqhaoKtbkx2aYpmTZg==
X-Gm-Gg: AR+sD12fXLxjDi1NBdnjjNeGdi7/K8QQEHvUmEHJDHb3WDL1tw4V3gflrgNXAYyPiCt
 vPlk/galL68omCIjnzMnQto3gMhC+S251E0ix/qrTlfJo0k4IdzfN8rBtWbjzzz5Z8mPu221wzR
 UX1BcIGFuzgNPz5J/ExKRg/m4pIZjcO02u1pqMGPj2wm3us+xgbrTFGGFDN88r8QWMXydpZ4shC
 jKaQZ23KsdIvHC0pVBbh1IF3k/7NBgVhAXmIesOEKSQV2VamG68uAHmfbKdHtLRjnR+xPNCjBkM
 Z0cE0gGzgjqdnb0ptMuYoqadmYH2mwDzf74dVOPJII5oV5TcRlFeADAd11b7i0hKkVE7QlEplyt
 t0DJa2exNn8O4RIxevhvFWO/AaqLHbVwRFSt4Bg==
X-Received: by 2002:a05:620a:9de:b0:939:3c0:7520 with SMTP id
 af79cd13be357-939137e2d4fmr217742485a.18.1787869586898; 
 Thu, 27 Aug 2026 15:26:26 -0700 (PDT)
X-Received: by 2002:a05:620a:9de:b0:939:3c0:7520 with SMTP id
 af79cd13be357-939137e2d4fmr217737985a.18.1787869586295; 
 Thu, 27 Aug 2026 15:26:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 02/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_flash()
Date: Thu, 27 Aug 2026 19:25:55 -0300
Message-ID: <20260827222608.329788-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX0JoPsfiAG52O
 SC6ZP4qr6mXXKHODVit0+vS/0qBYXwz6m/e45sV1zEdfgFbVQMPJt1OrGF1x+244HJ9psdNy7I6
 piuppXoKSqWCLQMDen71q5ji1r8PULA90HBw2s++yJr2FRkdpB9ys64UYfrUDzwiVW59BP6ozfc
 iUZJdSOM5C5uEgAg+aBGUeLFtO9IMugNHq/SWj8BQgGhoI7wsVI25IRNGLl0o0J173/+jd1jSoz
 G50Ec5UeBncoZ8GeLtqB0QyRfg+H4L+UvY3GTVKTDutPQ1R4O3fz0OyQ1r9sp8CCXPu+hjNP2i6
 lGlEuZa6lRDaWgDSxpwmlRgjGKKn+3GmS1z+SLwISNk6EQ1U28aGyUHQ60LBmylC+crXMjNt1Fz
 FiHxanVRMnDWMddWMMf7imeAM0N+EIbyP9hK/kbwXFe7w5mxJon9yhLnmOFZ00ThDyfHd4cztkb
 j47N1b+N+pW9zDNyO9w==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b993 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=plQfXIS7czum7OicmoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: zISzCKsF9Uh3NDvxjxHzmI5Awm3am2GR
X-Proofpoint-ORIG-GUID: zISzCKsF9Uh3NDvxjxHzmI5Awm3am2GR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX6KqYj6f7UJHU
 CWQzCCgrPx1eh5Jz4Icd9JTluXhGxSrYsamEixQJFUxZyzLoJTacR36x4pjtY3Vf6G3Y4zCQgav
 PLtG+Aly5QI/CuTNzMS57Hvgs+SKNdA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



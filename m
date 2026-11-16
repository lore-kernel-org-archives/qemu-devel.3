Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C9606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZFGkakDR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dsjF5/z6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT64y-0006sq-9I; Mon, 16 Nov 2026 18:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64j-0006mI-R4
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT64h-00059G-Es
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:25:25 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJenjS2727710
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3SjpamYB+ObW21/fwHJmI37OjTdNmeMF+p5JD+ApNWk=; b=ZFGkakDRhiZ/JnEC
 IsOkN9m4aI3XRkvsB4zqB7FwoOmSfC7rjHlLnou3aeIZG2ZtwxIHYGljCxKAVjS3
 t7gjoAFyJNmt3Bb/iUoNm8zzAY7g9CAS9pSc5WIVXkOAdybqIwr79s2230xAS4ZP
 k7Ays6O6KBjSdql9RDIEHDP6dJsrjYppEYMhMXhCZEITeMGRFUDQOttjKgT0ae+S
 B69exaq6MPP2XaO3VZCU49yDqlDOxjny+Fv8vupyTbDdI7tFNFLmWJuUchsyobv7
 aACYSZtZItpmjUx6ahz83RWpaiWhohY8LMUxEsZCwCPnlIa56EnGq+Gobx3ARRKD
 kzMQNA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regv37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:25:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961511b61so553973485a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871521; x=1795476321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SjpamYB+ObW21/fwHJmI37OjTdNmeMF+p5JD+ApNWk=;
 b=dsjF5/z63M+90x0DJi0ubuAoCKDgxGEV5we3Mm4bl9fSlkqKGhzzd6fZ7W1O/7cNVu
 cCDKMV8M0IAuCo9pxyVwKyDGHdOR5fpZgNlzkLt9lQBgtw0j+txK9JyHE04zG0kmup+0
 w7x4mQxPtP5r3NA5KX9KWSTDYmOByj2AsLQ4+hrIYUXGkhUxUat0yOamujKkHCtV4jN8
 j6xhzYt0Zjtgz5DpATSRwkLE5uz5bnN+RLD6x2j0UghP7kiJTbLeSdmbSyfe4+jEL3j+
 5ZzjgmWkWdBwx6KPkUVN7Ucdo4xxzQs+GPmDiCq2uvmDflbD4vfCS9u6f87XmqWSgKPY
 So9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871521; x=1795476321;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3SjpamYB+ObW21/fwHJmI37OjTdNmeMF+p5JD+ApNWk=;
 b=sJwrpWqd0ShaTg22dQydcH3pV94Lh+knZqiI7xlVLxPDtbZjc886Rekw3Irfe45S1A
 0CQe6Kmtc5MqYGf18cR3AOBVZvCOP8OPLkaQZacJ2UkQZH7XVnjASCj8AbLtP2WN+gJ/
 SF15aLHyRaEEKfDVqzgM8ABtAwn4w3rtpvBMmKTE0NS3L+L0lHNAJpqGlGrzHVmTGTcL
 l9W7iB5EJyNxanQGm5Jwz0I8H/RjWGYrFtTtzYxUTAWQQmu2nPgHWWv69erlEMq8A2ec
 Q1Db8XfYgzNVI6QnkNeu7gVaMPr3x9MGYWQT344RzNP1t+EYCWnV6I2etFB/ZdWJpXho
 cdTg==
X-Gm-Message-State: APuU4Z+AAPmSEnp+4WP/tToKgLD4Np2OYLP/2FJ/tc64pX59L2R3ScRZ
 zskREjrcbuTCFMeN/Etn+V186YbB5pVYmyvIPMLC9aRd7bIeb/KDeXOQDbOZAcuf1cc3SlXx2be
 Ev+Dkk165J4ZqXR2DtRRXU57RB1SbA0q8fxBT00N5IDCqThQOmOBetrk12mcArzKGBg==
X-Gm-Gg: AYBFou0f/pOlbPProhgzDnp+h00ecz0u3VGv3jZeoHDrcxeiNsRO4YfQ0tqVFa00yHV
 yIMXEg9xpBNvmPirL9y+mUTOxksOWDfzfUuB3mlBu5iw8oWWmVBH84FX/UgH5gBeSQEHwz9TaMq
 25C3tndj4QRP41uUfopmr8S9Uw3XYL2eWnNAb5uKj+rhWlDoezDNT7gIOLgsBoK19CvA1QiytvE
 DnglCIE/7SYxOTa5gkJyNf0/XS4BG+9hzaEX0ZRZOzoh7X3RL0TKbDEvQ0qCUwKrNNNnf65u5mI
 BqRX5pcCQwpIaS8D2pMK02N0suUSgSUlivqFfo02rgOM4OWN2U7FDKde/5rTp5I7a4kG6TQkMoJ
 dCtDDZTfh81zH+N/jkXCW8Tmnf8ZpAW5rKRyPCqApGkdI+r9lYk0GvQUf6kbm8CfLkm4qGr0sVA
 je0/b+4BQE7WWm6Q==
X-Received: by 2002:a05:620a:4399:b0:949:7759:7faa with SMTP id
 af79cd13be357-9497759914dmr871859885a.60.1794871520820; 
 Mon, 16 Nov 2026 15:25:20 -0800 (PST)
X-Received: by 2002:a05:620a:4399:b0:949:7759:7faa with SMTP id
 af79cd13be357-9497759914dmr871857085a.60.1794871520350; 
 Mon, 16 Nov 2026 15:25:20 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm25345998f8f.5.2026.11.16.15.25.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:25:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/22] hw/i386: move bios functions into x86-bios.c
Date: Tue, 17 Nov 2026 00:23:26 +0100
Message-ID: <20261116232335.31593-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXxsSsYD6I9Y0+
 407NyX7VaYuJeNmB5sj9YL3yg6TxYBR/7qkcB0LQaJt6mJARRtwGNDzRlxNXX5prtc/H9i7A/RE
 8gqz5DFz70HqeXcfWi2k7mrquIEOrw4=
X-Proofpoint-ORIG-GUID: 9zTEkg0iMUb2pABoke9QutpweANKzv1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX1kwd0Lm5fELy
 B9WTmn0bTpz7uL63R4Rdg/xxikPJIr1AAVLyAtMdoGRqvUmSTV7qLqgLhVsbOoOBXLJlNT951pB
 iixHaYIoJ0pkvtVB6fozcnE9uOQJMAXQRjb3rxSnWUPbsUs/2ZNvx0/n386Oqkjx9i7yWOGX/gY
 OI/W35GqbmWqmQTdTMgmVM+y0n6FW8NTG/HT2ccBqzbN0YFyxhrL2EiCMaw2AjJS2WoCxoXjP3K
 SStMfn/XUm7iNicK32zgGFXPo0uXFtLLpz9lvV3ej6tL3AhH42gjGzJfvDy7w7K7pB26Wbyme++
 wxlChetL5aOX7FKvZsUZIO8oyHouimEioJiYHpNgUJEzBQlmpOJImIAqXSAJeqf8X4o/Y1pYw83
 jilIhq9AFu1PNmdeSws426YiLJxYjDTLeZ0Bb7fWkPE7/C67Da1/biUvzuvJStgqSbC3jDxPPxN
 sZJXxN/mRrLuJMf2Nyw==
X-Proofpoint-GUID: 9zTEkg0iMUb2pABoke9QutpweANKzv1D
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb90e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-uGbPBS1G-rfqM4RPtMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: John Snow <jsnow@redhat.com>

Currently, these functions are located in x86-common.c. However, when
configuring QEMU with `--without-default-devices`, we encounter a
linking error at final assembly time where these functions cannot be
located.

Split these functions out into a new x86-bios.c module to allow
defaultless compilations of x86_64 to succeed.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20261106191356.1207295-1-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/i386/x86-bios.c   | 143 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/x86-common.c | 125 -------------------------------------
 hw/i386/x86.c        |   1 -
 hw/i386/meson.build  |   1 +
 4 files changed, 144 insertions(+), 126 deletions(-)
 create mode 100644 hw/i386/x86-bios.c

diff --git a/hw/i386/x86-bios.c b/hw/i386/x86-bios.c
new file mode 100644
index 000000000000..525e42e7252f
--- /dev/null
+++ b/hw/i386/x86-bios.c
@@ -0,0 +1,143 @@
+/*
+ * x86 bios loading functions
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2019, 2024-2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/datadir.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+
+#include "hw/core/loader.h"
+#include "hw/i386/x86.h"
+#include "kvm/tdx.h"
+#include "target/i386/sev.h"
+
+void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+                       MemoryRegion *bios, bool read_only)
+{
+    uint64_t bios_size = memory_region_size(bios);
+    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
+
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
+                                        isa_bios, 1);
+    memory_region_set_readonly(isa_bios, read_only);
+}
+
+static int get_bios_size(X86MachineState *x86ms,
+                         const char *bios_name, char *filename)
+{
+    int bios_size;
+
+    if (filename) {
+        bios_size = get_image_size(filename, NULL);
+    } else {
+        bios_size = -1;
+    }
+    if (bios_size <= 0 ||
+        (bios_size % 65536) != 0) {
+        goto bios_error;
+    }
+
+    return bios_size;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                                char *filename, int bios_size,
+                                bool isapc_ram_fw)
+{
+    ssize_t ret;
+
+    /* BIOS load */
+    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
+        memory_region_init_ram_guest_memfd_private(
+            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
+        if (is_tdx_vm()) {
+            tdx_set_tdvf_region(&x86ms->bios);
+        }
+    } else {
+        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
+                               bios_size, &error_fatal);
+    }
+    if (sev_enabled() || is_tdx_vm()) {
+        /*
+         * The concept of a "reset" simply doesn't exist for
+         * confidential computing guests, we have to destroy and
+         * re-launch them instead.  So there is no need to register
+         * the firmware as rom to properly re-initialize on reset.
+         * Just go for a straight file load instead.
+         */
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+        load_image_size(filename, ptr, bios_size);
+        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+    } else {
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
+        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
+        if (ret != 0) {
+            goto bios_error;
+        }
+    }
+
+    return;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+void x86_bios_rom_reload(X86MachineState *x86ms)
+{
+    int bios_size;
+    const char *bios_name;
+    char *filename;
+
+    if (memory_region_size(&x86ms->bios) == 0) {
+        /* if -bios is not used */
+        return;
+    }
+
+    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+
+    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+    load_image_size(filename, ptr, bios_size);
+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+}
+
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    int bios_size;
+    const char *bios_name;
+    g_autofree char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
+
+    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
+        /* map the last 128KB of the BIOS in ISA space */
+        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                          !isapc_ram_fw);
+    }
+
+    /* map all the bios at the top of memory */
+    memory_region_add_subregion(rom_memory,
+                                (uint32_t)(-bios_size),
+                                &x86ms->bios);
+    return;
+}
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dcd4fa8eb798..350fcbc20e18 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -995,128 +995,3 @@ void x86_load_linux(X86MachineState *x86ms,
     option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     nb_option_roms++;
 }
-
-void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
-                       MemoryRegion *bios, bool read_only)
-{
-    uint64_t bios_size = memory_region_size(bios);
-    uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
-
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
-                                        isa_bios, 1);
-    memory_region_set_readonly(isa_bios, read_only);
-}
-
-static int get_bios_size(X86MachineState *x86ms,
-                         const char *bios_name, char *filename)
-{
-    int bios_size;
-
-    if (filename) {
-        bios_size = get_image_size(filename, NULL);
-    } else {
-        bios_size = -1;
-    }
-    if (bios_size <= 0 ||
-        (bios_size % 65536) != 0) {
-        goto bios_error;
-    }
-
-    return bios_size;
-
- bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
-}
-
-static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
-                                char *filename, int bios_size,
-                                bool isapc_ram_fw)
-{
-    ssize_t ret;
-
-    /* BIOS load */
-    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd_private(
-            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
-        if (is_tdx_vm()) {
-            tdx_set_tdvf_region(&x86ms->bios);
-        }
-    } else {
-        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
-                               bios_size, &error_fatal);
-    }
-    if (sev_enabled() || is_tdx_vm()) {
-        /*
-         * The concept of a "reset" simply doesn't exist for
-         * confidential computing guests, we have to destroy and
-         * re-launch them instead.  So there is no need to register
-         * the firmware as rom to properly re-initialize on reset.
-         * Just go for a straight file load instead.
-         */
-        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
-        load_image_size(filename, ptr, bios_size);
-        x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
-    } else {
-        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
-        ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
-        if (ret != 0) {
-            goto bios_error;
-        }
-    }
-
-    return;
-
- bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
-}
-
-void x86_bios_rom_reload(X86MachineState *x86ms)
-{
-    int bios_size;
-    const char *bios_name;
-    char *filename;
-
-    if (memory_region_size(&x86ms->bios) == 0) {
-        /* if -bios is not used */
-        return;
-    }
-
-    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-
-    bios_size = get_bios_size(x86ms, bios_name, filename);
-
-    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
-    load_image_size(filename, ptr, bios_size);
-    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
-}
-
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
-{
-    int bios_size;
-    const char *bios_name;
-    g_autofree char *filename;
-
-    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-
-    bios_size = get_bios_size(x86ms, bios_name, filename);
-    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
-
-    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        /* map the last 128KB of the BIOS in ISA space */
-        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
-                          !isapc_ram_fw);
-    }
-
-    /* map all the bios at the top of memory */
-    memory_region_add_subregion(rom_memory,
-                                (uint32_t)(-bios_size),
-                                &x86ms->bios);
-    return;
-}
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 4b75b7406a81..5f842351daff 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -35,7 +35,6 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/topology.h"
-
 #include "hw/core/nmi.h"
 #include "kvm/kvm_i386.h"
 
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index e16930c43197..6bb73b8731cc 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -5,6 +5,7 @@ i386_ss.add(files(
   'monitor.c',
   'multiboot.c',
   'x86.c',
+  'x86-bios.c',
   'x86-cpu.c',
 ))
 
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7815DC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEb-0002Mz-MP; Sun, 16 Aug 2026 10:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEU-0002Cy-Ud
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcES-0002Cp-UA
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlA6x3533416
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ekAhsfwKJ5maIu+35xZAK4X0xH7ZJuguxCqmpYcflHE=; b=mqVbaJbQYTGd83DQ
 cljMRkRd4NlSIa52KAdhzuomNpQNYltVwuImo7OjHTEWn4u1PwqQKYvgfGUT+Zp7
 O4UUH3JPc0+iH83hf7I3kD4GjvYDt36mM9QNemx+Fzw4TmzFWH4XlsW6gasII2GH
 OfeHrDWaNqsLEsUJPndBVQiOI95wmsj4fxQEa4wGThtaL32e3BpEC+H4f8dk+tt6
 LtthREDT2fSVMGbqOItH4NskGMr7vNXEyAuSgB0h2xraB7ey6RXqRlF+EXWiFZGT
 EkEFGdYrnuIZR8VFml5yHpLS1hvs2Gdpvy09Dp0WloG/REA6GITUVxSGf7GOM/WS
 bcjylw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3mqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so31797641cf.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891983; x=1787496783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ekAhsfwKJ5maIu+35xZAK4X0xH7ZJuguxCqmpYcflHE=;
 b=PpxcvbfXEGVYMcs5dQfiHGNqEJ0qc7PXBBga41glGISnXNyL7aIun/Y8m8S0fa1wXP
 CVpI8w76pu4UD9/SnyTuiFlkJJp5VeNM27oUobSxTstA7fpSXZORmgP2okX2Dm7BqB05
 QXIQLTTPGNAnz8vNNM9o1scZjTnFtqo7lk/sYe+3dBQ1Qf7DA83et7jiFxIz3hgc9vUG
 x9yAzlgUMp8QilJOoLegQheC+UjjgQQ7vNYRn/MsCYVLUVmI2CeHAoVhIp8E+D+UinuJ
 rQWFTaDT3pkBw+Ab67HltoZOfHsT/nMKSAbGvEcu4PwpPaaFlpxpTSU8P+o5Sf8CM87B
 NjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891983; x=1787496783;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekAhsfwKJ5maIu+35xZAK4X0xH7ZJuguxCqmpYcflHE=;
 b=qNBss7CNBK2c9V+owCDRpsz+1uoTnH9FTFrtS/KC3nx4LhMKCNhF/eXYz07YtyDE/k
 3sZnFF7uWf8pkBuMNmoIB47u0ZFsCt0zdD8tcdbJe59hmBWD4wElRbZNq7Hv8yLsh1Pm
 KUagAwi7cbUpDVyy2KZPUYy12Fdnh+vNao7cCCvUHCMRvHqLy1CRfdREqADEbOkfTUaa
 cqe8ebwWrKKyYuI1dOTH3f1SZ/iPdOdbS9zprjVhPK/Hju/9ev7oKuxaDAh4j7UqrN7p
 6Lmv6xhJ96lOOJmJhoZUko01zRbhU5OfUkiv4RWIt/C6CgS18ozXrovJvGZsJenzkg5D
 /EnA==
X-Gm-Message-State: AOJu0Yys1l0B3sFZ6KYpNVyitie5H/0yxvzXbf9oz7tMHzFEAlbheFf2
 MZhEGvpGWQl4wXehO2s/6Ql80B976U6lPnUsFaNvuKmyVKFxiUmlomPye70kbeiFC0oSZbdNwyG
 aFZkUfVvWX4oIgxHIbsfe74ELuBAQuPZh05dLDI9xvg10NAaCP9Lf2ASNEyJKqKyINA==
X-Gm-Gg: AR+sD12xb2+GKqOelypGF018JzaYbbTfqLfx1hAfCIBUZX+zs3Es70hMuvpbhBVLKrP
 6D1lWEobwmXs/8qWS8rSJVHGFPhDOvalIktUw2aiDY01CuAtw9vdcACpge1rOlP1K7Q0WWBegIp
 ciTSNubKxRHA4V8TrEWR/fpE+JcPLBOAPft0xKC+5rpBA8oH8fmA7PDc4Ycjx0N6Jcv3KKyrCip
 J3D7K9xJijlEnGJduQHKP7cCKIpvwFihz6Caw4a0e61dlqySJK9XS7/Zd5Z7vafcvjP9og23U++
 3/nVjOVhrEYAnyYYwMfHdbAFW8V6CcIk+H19XQNgP3XVSAn2ZvobyXSgaVLv3P9nUCm3wsLkwdu
 tx+orDrpxBekulMlwFOsZ+9pdMR20+EEWTXQ5OSXKzQ==
X-Received: by 2002:a05:622a:349:b0:52d:8256:ac33 with SMTP id
 d75a77b69052e-52d8542058cmr193139951cf.28.1786891983320; 
 Sun, 16 Aug 2026 07:53:03 -0700 (PDT)
X-Received: by 2002:a05:622a:349:b0:52d:8256:ac33 with SMTP id
 d75a77b69052e-52d8542058cmr193139571cf.28.1786891982837; 
 Sun, 16 Aug 2026 07:53:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-481626fd0f0sm16539978f8f.28.2026.08.16.07.53.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/56] system: Extract QMP memsave/pmemsave commands to
 physmem-qmp-cmds.c
Date: Sun, 16 Aug 2026 16:45:49 +0200
Message-ID: <20260816144556.69009-51-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81cecf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=7DZkrcYYXL7zIbTVLmcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: zz3cPwpVYNrvhj0cEAoUA1IOo6tpHKzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX2QXC7kuBMwt6
 Yuw8XL1PhA9/2M7K7j/ifsJy1X2QLLtQNKvFmAojnqVkGLM/KpkW/8jtTWJkFgp+F7MksJQo5vS
 5OISuP454085xHhJmrySxHfG/Ei8HuWBOLXE1A7IExZtzTI03cEjZUVGVJOkzt8ijQp1VkJ1TTy
 ErJcXRy7mSBcQoeCgWZ9haFsMDPDy5Svvgxs4D72Mg+carGZ+orze1Q8W9PWyigCUzvF7ZfBnUP
 rCdSyP0W1PDsVVTNrFQHEGYtdeOM5D8NSW2+QbDPsCKLOr2LNXGKkfLDxvYlXvJJbpCSz9ezCsm
 LxsCxT3CmAS/tLtgxpg67Q7dXL027Od0AcEsDTKjDVPjScTRF/V/lSoUE4oW8g8WoAMW57P4DIP
 W3fwRS5BQnkSGw02oItblT1jbZyQM4N51TBvg0/6ITLOO24JHqIKkoRqcTX8Tg/XV3ooSdr9Qf4
 O0/T11CQa6Lnykm0WKQ==
X-Proofpoint-ORIG-GUID: zz3cPwpVYNrvhj0cEAoUA1IOo6tpHKzB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX/nX4yfdU0E6i
 S7lgUPn3+17Vj3nl0E69dx7UBtWzl15hlzOhkwVMKD7lx2NOmC0wrpcEbxtfHrYlGzdimKD+izl
 jzLIAl5gBsAuwwoSAQu1VEapx1fZ8ss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Keep cpus.c related to vCPU scheduling, move the QMP handlers
related to dumping physical memory to file to their own unit.
Fix a pair of checkpatch.pl errors doing so:

  ERROR: braces {} are necessary for all arms of this statement
  #185: FILE: system/physmem-qmp-cmds.c:51:
  +        if (l > size)
  [...]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-16-philmd@oss.qualcomm.com>
---
 MAINTAINERS               |   1 +
 system/cpus.c             |  92 --------------------------------
 system/physmem-qmp-cmds.c | 107 ++++++++++++++++++++++++++++++++++++++
 system/meson.build        |   1 +
 4 files changed, 109 insertions(+), 92 deletions(-)
 create mode 100644 system/physmem-qmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bad65aeda50..b51f5c3e602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3436,6 +3436,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
+F: system/physmem-qmp-cmds.c
 F: system/memory_ldst*
 F: system/memory-internal.h
 F: system/ram-block-attributes.c
diff --git a/system/cpus.c b/system/cpus.c
index aa2510bf8fc..43ff10cf008 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -25,9 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine-tls.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-events-run-state.h"
-#include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/hw_accel.h"
@@ -40,7 +38,6 @@
 #include "system/physmem.h"
 #include "system/replay.h"
 #include "system/runstate.h"
-#include "migration/misc.h"
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
 #include "hw/core/boards.h"
@@ -831,92 +828,3 @@ int vm_stop_force_state(RunState state)
         return ret;
     }
 }
-
-void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
-                 bool has_cpu, int64_t cpu_index, Error **errp)
-{
-    FILE *f;
-    uint64_t l;
-    CPUState *cpu;
-    uint8_t buf[1024];
-    uint64_t orig_addr = addr, orig_size = size;
-
-    if (migration_guest_ram_loading()) {
-        error_setg(errp, "Guest memory access not allowed during migration");
-        return;
-    }
-
-    if (!has_cpu) {
-        cpu_index = 0;
-    }
-
-    cpu = qemu_get_cpu(cpu_index);
-    if (cpu == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
-                   "a CPU number");
-        return;
-    }
-
-    f = fopen(filename, "wb");
-    if (!f) {
-        error_setg_file_open(errp, errno, filename);
-        return;
-    }
-
-    while (size != 0) {
-        l = sizeof(buf);
-        if (l > size)
-            l = size;
-        if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
-            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRIu64
-                             " specified", orig_addr, orig_size);
-            goto exit;
-        }
-        if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, "writing memory to '%s' failed",
-                       filename);
-            goto exit;
-        }
-        addr += l;
-        size -= l;
-    }
-
-exit:
-    fclose(f);
-}
-
-void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
-                  Error **errp)
-{
-    FILE *f;
-    uint64_t l;
-    uint8_t buf[1024];
-
-    if (migration_guest_ram_loading()) {
-        error_setg(errp, "Guest memory access not allowed during migration");
-        return;
-    }
-
-    f = fopen(filename, "wb");
-    if (!f) {
-        error_setg_file_open(errp, errno, filename);
-        return;
-    }
-
-    while (size != 0) {
-        l = sizeof(buf);
-        if (l > size)
-            l = size;
-        physical_memory_read(addr, buf, l);
-        if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, "writing memory to '%s' failed",
-                       filename);
-            goto exit;
-        }
-        addr += l;
-        size -= l;
-    }
-
-exit:
-    fclose(f);
-}
diff --git a/system/physmem-qmp-cmds.c b/system/physmem-qmp-cmds.c
new file mode 100644
index 00000000000..d85430357d5
--- /dev/null
+++ b/system/physmem-qmp-cmds.c
@@ -0,0 +1,107 @@
+/*
+ * QMP commands to dump physical memory
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/qmp/qerror.h"
+#include "hw/core/cpu.h"
+#include "system/physmem.h"
+#include "migration/misc.h"
+
+void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
+                 bool has_cpu, int64_t cpu_index, Error **errp)
+{
+    FILE *f;
+    uint64_t l;
+    CPUState *cpu;
+    uint8_t buf[1024];
+    uint64_t orig_addr = addr, orig_size = size;
+
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
+    if (!has_cpu) {
+        cpu_index = 0;
+    }
+
+    cpu = qemu_get_cpu(cpu_index);
+    if (cpu == NULL) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+                   "a CPU number");
+        return;
+    }
+
+    f = fopen(filename, "wb");
+    if (!f) {
+        error_setg_file_open(errp, errno, filename);
+        return;
+    }
+
+    while (size != 0) {
+        l = sizeof(buf);
+        if (l > size) {
+            l = size;
+        }
+        if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRIu64
+                             " specified", orig_addr, orig_size);
+            goto exit;
+        }
+        if (fwrite(buf, 1, l, f) != l) {
+            error_setg(errp, "writing memory to '%s' failed",
+                       filename);
+            goto exit;
+        }
+        addr += l;
+        size -= l;
+    }
+
+exit:
+    fclose(f);
+}
+
+void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
+                  Error **errp)
+{
+    FILE *f;
+    uint64_t l;
+    uint8_t buf[1024];
+
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Guest memory access not allowed during migration");
+        return;
+    }
+
+    f = fopen(filename, "wb");
+    if (!f) {
+        error_setg_file_open(errp, errno, filename);
+        return;
+    }
+
+    while (size != 0) {
+        l = sizeof(buf);
+        if (l > size) {
+            l = size;
+        }
+        physical_memory_read(addr, buf, l);
+        if (fwrite(buf, 1, l, f) != l) {
+            error_setg(errp, "writing memory to '%s' failed",
+                       filename);
+            goto exit;
+        }
+        addr += l;
+        size -= l;
+    }
+
+exit:
+    fclose(f);
+}
diff --git a/system/meson.build b/system/meson.build
index 377adce8035..64e06e7abcc 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -19,6 +19,7 @@ system_ss.add(files(
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
+  'physmem-qmp-cmds.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DD8C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMM-0002U4-DR; Wed, 12 Aug 2026 17:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLv-000202-SK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGLs-0007rv-2A
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2Mjs1743372
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4yh5CKrAm943x0CiLRXtdl2IgSauY6gT5P+gn0EJiUE=; b=aiTYijhAoJg/4u0v
 5OcEtYBN1Cc9WtpAJ0ewjXk4HQD5Ig2AfwsVa5/wPgpI0tcAGVBYP67bgXq1ekMt
 sBDF7RagL3s1YMYvu9/cA2UF5q/pRj5E7QeGJcJ120aNeQwlOP3kGGxJA5zsz14t
 R0sUJTG/omi/Qvb2qKmMwFSCa2yzZyLaiLeo3bXllmtJvqwMkoVVQbDdwKoOHovv
 7SYM4vA77UVWscG9gyWx3wcwzlgerg/c41aW/nbSXWTOEKlQTyMWD43+KT6SGp9G
 2DsWah9OCA1WSUNx0NJRfA55l3U2+m5EXnPJMWyPHV8kFFkiJgC0oN7MKlecmSC/
 V1CY9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nutb7f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso3115651cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569545; x=1787174345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4yh5CKrAm943x0CiLRXtdl2IgSauY6gT5P+gn0EJiUE=;
 b=Uc51hejxbtkDW9HEljNkVrg/HWbtv9XLilXxo1E/RGkOPpqhNqa8c6CP32omL98EMg
 Kf6y4wRX0UobNIhdU8INAtmYjoNjOeetqNvBA/5kxEYEqLyg68pP6Rd4FYtghnAwFlhz
 vQOJsmautQmC6cXo6cW8bdviEiAsTnKXh/c+zDW/ddzE400wA1iJn6wlVYnsbY6Clz+m
 cOs2sIEka+YRrf3RvGld0CpA0XRxbuxH53ZgX/HnKSNwy0NOZ/lyqOQpcpkS57He9FJJ
 KAqnY8EMNRJJENO6zJsHS00/81Ncx7z2S2fsNvQNxHkbE/pPLs+X+V30W1IXNmt9ZQER
 CsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569545; x=1787174345;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4yh5CKrAm943x0CiLRXtdl2IgSauY6gT5P+gn0EJiUE=;
 b=Jl7v43T+2q3TKr5QEbIE3IKM+koDlgggWHB0o6qzarkYaWz6Ot72esDononJsMkynf
 VZ9DqqDqvJbTJ4+LV3WDCI9OAtxipWjiJjo4kkro34dt7WYSUftDobfKMb6sLw5ldar5
 6xaXiOTEqLJhqe4gRTxMeemvjQJRP05vxtZxU2/VuOXwxEC5INRQlAO0vb0N6FU+PGLH
 bM9jz3kFGda62Y01VfNwktNoWaEgGsoZiNRfK/eAGi/iUbHYECE1HzA1Nku7CP4NzqE5
 qXL5UFIvjJ4oGyfqx9hgG5t7Kqe6vphLZ5GOhVWyg3fvy/7Hc+xj8xY4zxtbAh7KmK/7
 PHuw==
X-Gm-Message-State: AOJu0YxjjutYqjr/wqaKkyEaaIVtrhI61oXjPkz4klAPBY13a/oDpA0u
 S9lnhB/0vsh+Dkqsa1L1ximqmh/nWKYno3LH7mUkj8gMDXgzO4InZt2qHzGgNxWrrukrkI9LzZD
 CdWJF/1SIn8WiYPAER75EK3xMwG0yCDjRGD0CmuvWoQASqFK44FsYvBu7TClXL2/TxQ==
X-Gm-Gg: AR+sD11mmCP6ExV3YZj35n5b1Ihyoy19nV9taRuF4VK3ZRCr34lddUGtiL/6KTbpmCf
 1COF3qPAkHfC3+V6h1oo+nf64SEbL0tAly6R3lnsSaz9cpzgK03auHCAHgFlYLPRAX3LLt3RSd/
 AiRYyOW3eFqgpsc/n/wBu3Axsjlndv9iivR+d8tw4hDyIY8acvVWrAQsT2U6G5ybhBY2vQOrAP3
 Ta3v/zHNtn6cC43+OMxDxKcVj7FRRl3aJWmNWpouWOBy4nMRUdplGGCXVj84BQfXX7Co+en1gPY
 ZN3I/g+9bOMCx8qggy9W2XOfLhG6U0WiN4SMkY95BJyL4qKEzo97pjzUAxeA+q02FctRTWAeJtu
 +ZDIpOtycDyp1rxtjLWVTgRcTbWCPZMSz1cEd0nNmMQ==
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-52d74a6f672mr4134911cf.7.1786569545233; 
 Wed, 12 Aug 2026 14:19:05 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id
 d75a77b69052e-52d74a6f672mr4134221cf.7.1786569544586; 
 Wed, 12 Aug 2026 14:19:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5b6c21sm566199f8f.27.2026.08.12.14.19.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 15/23] system: Extract QMP memsave/pmemsave commands to
 physmem-qmp-cmds.c
Date: Wed, 12 Aug 2026 23:16:59 +0200
Message-ID: <20260812211708.92824-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXx/lgenDvNEZC
 ijBZhd7t8ws5lwNMiwAjZ2dPRS/X1dhfVjeAJndz3Q4H/8Ki6eF2UDSkwhaAqeMS4g0TkamoN7A
 grRVc7BI3qHH/RzlIT3sE+P/m4aPMbs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfXyx/8XNLEvw6L
 o5oc0AOA9sM3x95WOUHwmit/bOjfAwQHOs5dpY/sNSRTlExgTsSRLDBUZUjESUn1ncXKXq2D+T/
 wIkswqvu+LC/jlLyECWtzXdxMP8w4oQWqrE6+oZebsQ675zrEFvN/VI1a8GLqnFEnimlbEF0AN0
 NsLC1/fGwQfdk4+WYVxbgbxcTqWQCpdS/TADsybcrzE/Ujeyq8XNDW1IPfKRnJrlelzrWGVAILZ
 uE++WK6W4cnGpdwgFb/h3G/mhI2fhW+0rwyF93kMRxbVnb3fCnqbNqvSph4gDAkjAB8vclIBNuB
 aashVKrcfeVYXtgmgVezV0EbHkAieQmgSLQJeuuF1YvxIzfkL+Ak+A0FIIyqfVKHfVNE5E82Rcp
 9eYqFn0stkDOr5YWfoRR7Wzh65yLCuzpZ1OYOomTKlVMvzUocEsmQ93F1lqszm1vqJMxfuYQh/z
 D7yzoaLLOZeA2hAkwZA==
X-Proofpoint-ORIG-GUID: VaMlR_E9MKNanxc-QVKhIwHq2dVFrRNV
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7ce34a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=7DZkrcYYXL7zIbTVLmcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: VaMlR_E9MKNanxc-QVKhIwHq2dVFrRNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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
---
 MAINTAINERS               |   1 +
 system/cpus.c             |  92 --------------------------------
 system/physmem-qmp-cmds.c | 107 ++++++++++++++++++++++++++++++++++++++
 system/meson.build        |   1 +
 4 files changed, 109 insertions(+), 92 deletions(-)
 create mode 100644 system/physmem-qmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a33fbeebf61..f4689530b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3419,6 +3419,7 @@ F: system/ioport.c
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



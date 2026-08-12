Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8od-0006bm-Bc; Wed, 12 Aug 2026 09:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8m7-0004Ab-PC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8m4-0006sS-Gj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:13:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4mmG3311926
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aFyJnJW9gX2KVvO370AmDZhKgBUk1x36zwxEEGt8Rnw=; b=UYVWm/uegc3trRjg
 NDND8XsfqlEFpyvK//dpHnC2xfAaRlFgu0nS/D+qHt6GcGLn/AzUBo15utG9rrRO
 v88/H9mnyN9juJkUCIB3cI11/e6SnCVojUrJ6p+bOIomYP+z8qZqb2hcZ71ehFvE
 BRzNoeAZdXp3mRQquqKQ8AO6Rk+UPNUF/wcweDCXFBPLS0y8Y8n0RXb32lRN+cw+
 NWtd5BjgpJ7XjFNXnHiak5VtNLT00ZyQFd9pKDmdSKzTV+63umyPzti2+TudaW49
 UjIsqOudNmfhd22MnvniTBoeznu5dWhIczPLwhd5N5t8C5Dl8NZbBeel9gG2lO6i
 mgNlHA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d0ucr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:13:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so10798926d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540418; x=1787145218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aFyJnJW9gX2KVvO370AmDZhKgBUk1x36zwxEEGt8Rnw=;
 b=A5oIwiU0R7PcaSY7Oh3ZXfqrYE6bpDlvkc8ysMVKhf5pfIFPKY5mg12QqBVCpQbfvO
 lTUB9sL2UO89BJe1StyRFMEOXHd4Xf57BbocdUstAkg6HiHg8sJ+jrKOyE8ygu0Rzx+2
 TWQ+Xb3iPfiTS6eOdKeyBefXQEtjUPCm6YVfnF1Frt3JIl2Vj6j+PqWixGgVtCPn4d8e
 eXoeAirPWk+75JBcUgVF7yzKoNrgS+f626iNhCtTPy/7lfwge1PtmpUnSNjhcwzQ06qm
 vkaEDTrx5kFq7egXokagvqjD/OErGTiMgJDFpMd8ycnDZxCBKYKV0fezyHxdaZSTAWVT
 fEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540418; x=1787145218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aFyJnJW9gX2KVvO370AmDZhKgBUk1x36zwxEEGt8Rnw=;
 b=Snzag4Jsc/AiLgPVbw6N5rCTYJur5nrjtJ3icw8LugpLWxJY4qQRvLk1vR9qcagteL
 tKFW044K8blUDq3z9Usb+7FPdMARxKaede/jfhaWNWpFQlO1026tpcd+WOMlpvnG0Z/A
 IBumKP8aOtRw/cUuNEA56VRyN5Fpc3ozLD+Rz7UNhXC7F7NyC6QnsdQi1CP0Kz3PJ+2j
 ZaU7Xu5ziv0OAq7exEaqisNPzf3YCT243aZmEm6g4y8POgdKP+wgMBDiiquh2UbFwI4B
 tvGUg6HuONJU9cXEGD2mfbfNkcM5l9GgdbzCAnb0PpsGa6hIlgNKJC4MvAMRK48BFhZ1
 lnDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiR+jO7E5IBaD6hA/871T/x36plj10K7ZLcU4JwAlGl7K0xnp87qYiL/IfJ7gIZzdUh9ifd+KOs+iy@nongnu.org
X-Gm-Message-State: AOJu0YynZWiEUb3DCLLaWzPZupIvoyaF5VicoQ7HDV+2b5wKIxG58L7B
 biRqok/UnMbH3l8YcLBohXBvi0HeCkSe+dFgHuX1vF4wjWs6GbPAEvFIP5r2w9gb+NXz7ua1/Es
 36GqPY4jgCtwQMDadjsa71ZiKVwue26Xku9spjyXMlSOeiV9x88FUwIWi1Q==
X-Gm-Gg: AR+sD117l4xdPR6m0XYSwNOpBFGfGJtgIhYD5tYH+Yrn02eJ9CLFjU7gb3z72xsdWaa
 N5YZjR9esRpnfyEICEXt1cAiJqdzDYVKreh9HRiB6cGJojI5zJiPXJPIAljucI17xJKRbPMkptU
 8KlCwe5RFXpsv26mVhlT5L8WVwejyhTB6gX7AfZ+dc63Xp2kjApqk8k0+2AunlDyV10AlRdbVjx
 uWkj8DtvgbjTTTVuglNaA0Bn9O+5Og0uIoS90euXnRVBRj0RO+TtA8QU5d6pe9iZJ+IIkRbZZKA
 SIUNVuWDVO8z8p8gaXtSD48XMbKipc90NPqu81lJFZdU55vS0f4BhOGbNy1zNk4W7D1tuJXfVa8
 a09fb60GGT7uc27DRGtIWaOf8HXi4s+XVOg7l3KQ7zg==
X-Received: by 2002:a05:622a:e183:20b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52d6c36eb66mr9420701cf.41.1786540417573; 
 Wed, 12 Aug 2026 06:13:37 -0700 (PDT)
X-Received: by 2002:a05:622a:e183:20b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52d6c36eb66mr9420311cf.41.1786540417103; 
 Wed, 12 Aug 2026 06:13:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98ce0bsm49276855e9.11.2026.08.12.06.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:13:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 15/16] system: Extract QMP memsave/pmemsave commands to
 physmem-qmp-cmds.c
Date: Wed, 12 Aug 2026 15:11:46 +0200
Message-ID: <20260812131147.83188-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SraqIY8GLjemKTo9F4iafCriWSTdXvnC
X-Proofpoint-GUID: SraqIY8GLjemKTo9F4iafCriWSTdXvnC
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c7182 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=r45cMcW8mIPJ2GNrZIoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxx+6RrC/3D+U
 NvPHql53Pg8LUGS6t4bMuCFDKC3TUHumQSoqsGM8/FPYqSFxKMImI+Mj6IgOGOHUn+fkNhOBZ5s
 29WWh3qVdmiayQvvTuSsWvvXocQ/Tb5ajt7x1oHkvlIeIgN8xHdARyr5dTToG2ErTPOGUPvZl4v
 FQ6t7mjw2RqMInkarAvLI96nj03mY60FCbY+e1XEIx0LiABglelJm1owjYn5LrTG6X7c7DuXi0S
 5eTV3dNG6trvJ4R7VfadMmAT4UxkKJnBdmQnI2+hlIZKVyNJ020wbeMibV+KyB6zYCAsREnNgEc
 DuTewlWMoxeAcAcjsxI9027NWlAH3L0r+kAHzBM36bXTM2sbQ5LNjwAPz0xmFDAeZp1Z58YAU06
 ZCkUHNN/+wDnPNHz/hEdZW7lkq0Oo+ZilbOR08WFNDWp79+tktnl18cBGALnIbdigVuA/+hk6r9
 Ppmb7l69Ka8wo1+0W/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX9VDqlEIrm2+u
 Z1AuoB99RaJvtiB/ip41p7UmwtLoURSlQHDp5t35gWDL44J9vdyQZKsW3h+u6iuo9raGmdCsDGK
 x0g7QNenNVVaI5NXcZCUTeIaH9hrNuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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
---
 system/cpus.c             |  92 --------------------------------
 system/physmem-qmp-cmds.c | 107 ++++++++++++++++++++++++++++++++++++++
 system/meson.build        |   1 +
 3 files changed, 108 insertions(+), 92 deletions(-)
 create mode 100644 system/physmem-qmp-cmds.c

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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A208CCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwD-0002bj-1u; Thu, 18 Jun 2026 08:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwB-0002Xr-O5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwA-0001U8-1F
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArkdE1608939
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OtiPS78G+VPXO7O3XPuKRCNU39oloyqSTIkwRcGKQwM=; b=ilK7P8a/EXQn5QNC
 KgvN4AVhtld5uqvPnkw+MImyYYOoZWlEnXTUA021tfPNx0+RDC2dGzaDkFzii1vE
 WjVLSVEfCsMSkBkZR7xH7MWaOBKROdy3xiGdAb7QJV3AqGt+DPHEcu4HZx7JScQi
 HgCU9LT7BrY2WjmV7xo4QUTyJrhA7OqMhrrC+bBq2H+aM0EBnp6h9jg7QezeXY7F
 yqbrbCyst9lFWXRviZwnt0D/KljWEkFOuyRL5Vil3AFRkZFlkUOelRZNaE2jI5Nl
 +Sb+mWjK9feGCBsB4J7+AlxqkmQ4RfkeAZurtpW86e5LZULUzCwOACyu0i/oOyV1
 w1XwQg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7kk7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c554284973so1094791137.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786015; x=1782390815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtiPS78G+VPXO7O3XPuKRCNU39oloyqSTIkwRcGKQwM=;
 b=Cb6H55L2qLZlNqzdpRFE2SKp1A4G9ucz0nTJGDazZpqfs6I+8FLOv3V6YM4ct2Pj+9
 0Cyc/fzfTvzpW6Kuwizv3tDVseBbZOO6HJkviaxIOlJZFpJ6M+VkkIOafqguaFjDB1Fz
 jTRyZIxNXxPabCcS/KwKhnyy1CLxsZ86jO9dnTzGb9945GjnXe2R5dhQz8Sff6FOj5qh
 XkiIdw4mbTmqsNsD1PKyK2+gm56LlAEg4xpkd4a+GI6IhfgqCPvaytHZHEJZzV26bYd+
 vLBazy7t9fjfGLzcqZTFO7Y8MHHc+DVngrHlgd1Rv8flkBxv2Mnc9kyhEZI7oRKND6PA
 9khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786015; x=1782390815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OtiPS78G+VPXO7O3XPuKRCNU39oloyqSTIkwRcGKQwM=;
 b=M1SXpuI+LEbHCe4Nj+tJlguR9lB1gFHs5LIV21SLy2DZvgBSlGhgTk1/Icn0hzvZQ2
 GScLus66o/jKjYKJHFF0OP7KtLxnMyxKjaJhlF6AhFICrl5ugp8Fdvr7sGQHMIrCY7e/
 3NL4se+6M0z42cNB7qg+eEx8ne+zrg4evJ9ec0pSYQIJNhUmuebB+cOqgKWV3kxmrrYy
 pWDoeQhiN1UFQGc+ulu8pqvNG9noTrIOhyTXhPMbJO/fia5bo2iySRS8SdymNWq4muEV
 5jfT+R50LRn1xCCcymbVuCdgobAk5+2UxxSCwgCcwjjojc4ygT4DCL2BtEI37Gk01KZf
 AuCA==
X-Gm-Message-State: AOJu0Yz9o4GcdhcIrDSLKeUjXcBM3qB9mnyOB4HY/bXonLQoe3H26/LO
 bSW6YFS3Gj6j2EjCcyLDmv1Br+AmjH9oF6fG40yK6mYBdK/kDz7EXgOuBYnMNnEghxrY8ynBWH0
 w0vALlx75aopH101NN710CX0KsXpD+diMxTiIgJyVdTZSWQv+MndhJ268/Vbz9QkM7g==
X-Gm-Gg: AfdE7cmJYSUL7tcob/+RLU0WNJIPQpAw8itBkuXf0GdvmGrhOFilER6SRxZlqgWwZs0
 kT+fX/UQHUwlezbIhHbTIJXPC4zf/fRt4HJBL+oN/TbrbzsgWFUVps5o2OyaYpo9CZCKmyIKvxl
 Zi3P3lLrfvTraIxOR/YiNYIqwtwGBr5jyj/krnybel+ZOy1QHo1QPsOh95p+SWEKdZb82zrqyxw
 tlTiZghk7+tsGMvmTHoFa8Wqyd4/m1SSrJw2PQe3lUok5Nzesx3B/bxAJV+RAKpKavENjHv6ph0
 L+Og0euLvnuqRpMosYnirQ7R7gipcBCUtmrjTq/W4+o+V5XnTFUXJRd2SHmIgscY1d8xJNb1xEp
 th9U5j9u6xIDLZ+FY94fLo3azLFR33GHWG2rxGJHafelePx8HeXjbez3ZcBrnNoFZpoHg
X-Received: by 2002:a05:6102:3e1f:b0:631:4e9a:bab with SMTP id
 ada2fe7eead31-7246c67f247mr5428183137.18.1781786015319; 
 Thu, 18 Jun 2026 05:33:35 -0700 (PDT)
X-Received: by 2002:a05:6102:3e1f:b0:631:4e9a:bab with SMTP id
 ada2fe7eead31-7246c67f247mr5428175137.18.1781786014901; 
 Thu, 18 Jun 2026 05:33:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm63231214f8f.19.2026.06.18.05.33.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/48] accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
Date: Thu, 18 Jun 2026 14:28:19 +0200
Message-ID: <20260618122825.90331-43-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX33kAxJsIeRQc
 skUiWNgv7QaHkDfpcwocjOUxcv9TMxhslXkDvPmr5SZFh9UJG4Gj8D1MnL8rBHvrQ9Sn6RN6Y6X
 gm6/MJzmIb0kSvyINqArGvvDjNUjjc2QBXn1q8eqg/mwyCVKw18miDxCBoZnS2/NLQdwm5DFtuU
 Qebz8Q3KytvdjVq58NstO4JwX8QSt7QQ7BddUIOfH5we7kUKVdRzOgzOgReYeAcJp1dNa+dUOT/
 Y+Nf8qo6IhqtlORKKzLYzGc/DTj7ZTqbNT/k8padxiYS/83NOtrHP6WiDP3k+9wZMezm5PHJS/z
 XBjudL6Jliis/XlqgDNdN0oy3ULxRWmlXMM445azGedQHHw9OqbHlCaROa32TZjTSw57rYKx9Vl
 56n0fqHFwWC5eAgWLOzDs65dfUEMLAO2MShlBqwLeZwhanXyn2E+9d1YpYPbtFWmWUQ+CvbFrDp
 YZdiVagFlD1GvQT3ldg==
X-Proofpoint-GUID: 9yel3RkI_w0ehgfU48-TpHgoNVb4q7SD
X-Proofpoint-ORIG-GUID: 9yel3RkI_w0ehgfU48-TpHgoNVb4q7SD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX/ZSrZuRZdo9g
 LGEkPGtnE/2f7/ubT1K0Ni8cOKmyeH8WrAvOvvvx9ErmgNZ7pxL+ED5NzRS/MGHrHP4ooqN5f/C
 h8UORS+hcvDwt/BUYJmgEJTilk+5/hU=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33e59f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=D6UqOzzrtHFSm9VVf0MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

In order to keep TCG-specific functions under a TCG
API namespace, add the "accel/tcg/cpu-loop.h" header
and move cpu_exec() declaration to it. Add a bit of
documentation.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-5-philmd@oss.qualcomm.com>
---
 bsd-user/freebsd/os-proc.h   |  1 +
 include/accel/tcg/cpu-loop.h | 21 +++++++++++++++++++++
 include/exec/cpu-common.h    |  3 ---
 include/user/cpu_loop.h      |  2 +-
 accel/tcg/cpu-exec.c         |  1 +
 accel/tcg/tcg-accel-ops.c    |  1 +
 bsd-user/main.c              |  1 +
 7 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 include/accel/tcg/cpu-loop.h

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 72ccf23e17e..1cf3c43de34 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -14,6 +14,7 @@
 #include <sys/procdesc.h>
 #include <sys/wait.h>
 
+#include "accel/tcg/cpu-loop.h"
 #include "target_arch_cpu.h"
 
 pid_t safe_wait4(pid_t wpid, int *status, int options, struct rusage *rusage);
diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
new file mode 100644
index 00000000000..6a3c8ed48b2
--- /dev/null
+++ b/include/accel/tcg/cpu-loop.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU TCG CPU loop API
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ACCEL_TCG_CPU_LOOP_COMMON_H
+#define ACCEL_TCG_CPU_LOOP_COMMON_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+/**
+ * cpu_exec:
+ * @cpu: the cpu context
+ *
+ * Returns one of the EXCP_* definitions (see "exec/cpu-common.h").
+ */
+int cpu_exec(CPUState *cpu);
+
+#endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a781dba770b..09915dc4c44 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -111,9 +111,6 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 
-/* accel/tcg/cpu-exec.c */
-int cpu_exec(CPUState *cpu);
-
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 346e37ede8b..c9d49398f01 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -22,7 +22,7 @@
 
 #include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
-
+#include "accel/tcg/cpu-loop.h"
 
 /**
  * adjust_signal_pc:
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 7292ff15060..9c754b03656 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "trace.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3bd98005042..c179cd4adeb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c3274..4f1544342eb 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -39,6 +39,7 @@
 #include "user/guest-base.h"
 #include "user/page-protection.h"
 #include "accel/accel-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
-- 
2.53.0



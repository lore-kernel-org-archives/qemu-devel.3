Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D5606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FGCREJ0G;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SvX+YByy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBen-0004Yf-D1; Thu, 19 Nov 2026 18:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBel-0004Ui-7T
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:35:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUBei-00009g-ME
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:35:06 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1FlD373337
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sPFYBR4hvnNxiluSBZ4vX03GXGSVReWpMvePJhuCbdo=; b=FGCREJ0GEIT2cjVW
 WdZleLvNkOLG+PA00ZX9/uFfcresAif9dczAc4tm71QGAwkr50oLoDh7vl3Zs6+n
 r/6kbp2x/hGxU6OMtzei5Cr5fpeZBogsYOViHU0Tx9pdKs/eqe75T4CjI4O43Yww
 TCCtbr7u+b/X08K8oz18yH7o4gecvNoaJJJohenOp/2kfhNKeEkybuXMD876ePQL
 pYRV7U+BUcAEliDl9pseyTiAhVFI7n8s6K/mw5VVMHCyRx2rY5syusrqRYCODYXf
 9jZGT9iYX2mCCNwnIKEQrzeJArsWeE3V/wa9sSUDrfGvZ4IHH4vtGmUEN2OoIpyD
 1Her7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymkkgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:35:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so79483885a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795131302; x=1795736102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sPFYBR4hvnNxiluSBZ4vX03GXGSVReWpMvePJhuCbdo=;
 b=SvX+YByyB6QqLSwnFjR2XzygzQ8Gr971AEzXO6I92EN0UbEaUMlxQydTDWJyfVPnHx
 HyLcbf+EqR98wmcpbmqTluOAru1X7qBpzpiE5Nf3Jx2U1GAo5IEj91o6fXOQ2N90VjRw
 AUcxyBY1GpdTiCdx9mJaXbbqP0SCdIpwlvMPIIkolfxtxO19lv2r7SUglf/ZvuBS/3yE
 XDk2znywamEGLv8tRELgCiNdSBGvZ5OB3oq4s4T2H3CEL2DvIU278TBALQ1e8WBp5G1j
 xd0h3YHRErZfT3oLs/RmjGkPI6WtCw0uVBWAmI6X1fdOR35TUE6XRFtIqeP13Qd7ztwz
 1jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131302; x=1795736102;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sPFYBR4hvnNxiluSBZ4vX03GXGSVReWpMvePJhuCbdo=;
 b=btMCgUghDrsAR9vlCC/ma6R8hrbfCFz+lnZIu8Saj0uQzR0JlFj4LZag7x+Lo6ZyWs
 qgIx+KpbgHexrJPe3X+IwCDck28brF9zBD9gsMMY8A554WO5v7phEgDVuIZBm5XMAL3d
 94/moDN81xafYQ40UnLHtLi0v8ZbQqgYCpT+YxvlKXwX5iTV2FZrejMfI9ybFLUK7sFK
 weBuvJ+aUassnPg7VBFwrYkNXOeTamQYoVslQ39vuifL77CX7LIpiY+PX6xptWqgJG17
 ynrberUL8GZ2i1hcuUP0EkAGSKNf+7Ea8OFztMGEv7MgQaIVeAf3V6RgPSafQjgpCT/u
 9T+Q==
X-Gm-Message-State: APuU4Z9amAIl2fMV/g+1do4uhWM5oFvh95zMN9XbITH/cmGwHJfJTRMP
 Q1lF0VO/9dpBMH5Gy9qtzWtdXsLAkNn8RyoL9g2pMxNj8TkVM8Qn1BvHP8HF/Z1xpACrA8TT7CQ
 h0IgMHvoshmYhZRx/+Qq0Od0yEyHp3pyRr9SUdxyY/VXFF1xk+f6cOL3/K9MBfO4tFuF1
X-Gm-Gg: AYBFou1tKfGgPOPhOHcLUEfHxMaWlPXsT6RpI+tcPDKiKeUjB1HOsdAr3EPIXsTdeh6
 7Y9WQIUDe1TcIXpZWK28tECP4Nu2PXS+MCBPL5Qd7UFEidZj17mmRJaWjLtb3TF2hd99E2qtAjR
 zOlRKd+GEI/ySrDhbQcBFClm/JV6zcnsois3TpBc7S87pJes0X2KhNsqrdyOgTM72RRl2qc2moc
 B6+V4RanvQpXzLHYqlJoqMtrbCN4N3A3S/tZ9G3gYbKkwo+9hWPPYYgrb3dvamfPDRMYs1tWMz1
 D7h4OkaZV9FJ1fARrVD1NRJJnOBMYbZdxFhore6SUCbQwefGmrw+2oN8kZT8QgY66VICgWt2l7W
 nYCmkp+L2j4rIvyWSUpTEaCwpD4EkGHwO9VRUMvOuduLR2qQGWiPQsWYDJ8TjzetBT7jx/HHv4p
 Ioen9ZHlbVG6V65Q==
X-Received: by 2002:a05:620a:44c2:b0:93f:2d52:613a with SMTP id
 af79cd13be357-949ba95dba9mr222798185a.29.1795131301882; 
 Thu, 19 Nov 2026 15:35:01 -0800 (PST)
X-Received: by 2002:a05:620a:44c2:b0:93f:2d52:613a with SMTP id
 af79cd13be357-949ba95dba9mr222794685a.29.1795131301347; 
 Thu, 19 Nov 2026 15:35:01 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm81211265e9.3.2026.11.19.15.35.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:35:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 1/2] tests/bench: Add macos-pollbench
Date: Fri, 20 Nov 2026 00:34:50 +0100
Message-ID: <20261119233451.47453-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119233451.47453-1-philmd@oss.qualcomm.com>
References: <20261119233451.47453-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX6Wz9TOv6cxfg
 4Pzg3Zq9hm9T2x8Ht7dSYDHgOfJ+g4HQlqm1fzAq52ep3q/duuYeSWxkFbXeIAy7LA8f5XUDNC4
 w4lTPgCT5/36gtjocME9sfH54v6flxI=
X-Proofpoint-GUID: NGojGr6qSLcACvZ0xmr5PiNgBKlkdiME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5NCBTYWx0ZWRfX8iHJcvRJHP84
 C8ffc1+bQrHZzORRPXcgquWN5MaLcTIbibptS8qRyNCNe0SUpn3t9F3NBXcsZAZNhpkHt8IY8Hf
 CxSf/k4kFdpXi6pDerkEDYZuVJfc7vfANdTd82vkTGkUHiNvvin8xFBZLvjjcv2I1xCXjJhXwZF
 fbUiRHUw76LOz8MYYm5lnwXzaZd1tOvOy/11dbXSfRFaghjXEfd8Cb6V5WtgIGTLrzYMCrEYyVb
 96h3lHowWPVabyczBzrRLwm2sszJR1ftIGaCmP/cSUPaDqBegqmKnTu4F1ktgK58fOxGDdxX65o
 wKjcQH7QBpHKnYtor8omW+uUtaMTPThyhsb6iTTHQlFFnQZphTgBCA7xAZI93PtUx/TIIwohIO/
 +G9+4uT5C0fJGjPhK1AvxdbOQPq/ufI4ecXDFMMnSVd8tl3zN0mYA9gB6llocHM6S3Mv128ar+T
 CiVQ9DMw4Acn6ncX0zA==
X-Proofpoint-ORIG-GUID: NGojGr6qSLcACvZ0xmr5PiNgBKlkdiME
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6aff87a7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FojOpH369lakRZaHAP0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190094
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

Benchmark macOS wait primitives on an idle descriptor, modeling
qemu_poll_ns() on a host without ppoll(2). It reports interval
percentiles, CPU time per wait via getrusage(), and wakeup rate for
poll with g_poll()'s rounded-up timeout, truncated poll, pselect,
kevent, one-shot EVFILT_TIMER, nanosleep, a poll+nanosleep hybrid,
and, with --all, poll+spin, a mach_wait_until() kicker thread,
and THREAD_TIME_CONSTRAINT_POLICY variants.

Built only on Darwin with build_by_default: false. Run as
./tests/bench/macos-pollbench [period_ns] [iters] [--all]; the
default period is 1.047 ms, one 9600 8N1 serial character.

Results on Apple Silicon M1 at 1.047 ms (medians of 3 runs): g_poll
2.264 ms / 11 us, hybrid 1.139 ms / 11 us, kevent 1.187 ms / 7 us,
poll+spin exact but 1038 us.

AI-used-for: microbenchmark
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/bench/macos-pollbench.c | 290 ++++++++++++++++++++++++++++++++++
 tests/bench/meson.build       |   6 +
 2 files changed, 296 insertions(+)
 create mode 100644 tests/bench/macos-pollbench.c

diff --git a/tests/bench/macos-pollbench.c b/tests/bench/macos-pollbench.c
new file mode 100644
index 000000000000..a0639d1ddfb8
--- /dev/null
+++ b/tests/bench/macos-pollbench.c
@@ -0,0 +1,290 @@
+/*
+ * macOS poll/sleep wait-primitive benchmark.
+ *
+ * Models qemu_poll_ns() on a host without ppoll(2): wait on an idle pipe
+ * read end for one period, repeatedly, with the timer re-armed at fire
+ * time. The poll, pselect and kevent variants watch the pipe; nanosleep,
+ * the one-shot timer and the Mach variants only sleep. Reports the
+ * interval distribution (p10/median/p90/max), the CPU time per wait
+ * (getrusage) and the wakeup rate.
+ *
+ * Variants: poll with the timeout rounded up to ms (what g_poll() does),
+ * poll truncated to ms, pselect/kevent/nanosleep with ns resolution, a
+ * one-shot EVFILT_TIMER kevent, the poll+nanosleep hybrid used by the
+ * Darwin branch of qemu_poll_ns(), plus --all extras (poll+spin,
+ * mach_wait_until() kicker thread, THREAD_TIME_CONSTRAINT_POLICY).
+ *
+ * Usage: macos-pollbench [period_ns] [iters] [--all]
+ * Default: 1047000 ns (1.047 ms, one serial character at 9600 8N1), 3000
+ * iterations.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/event.h>
+#include <sys/resource.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <mach/mach.h>
+#include <mach/mach_time.h>
+#include <mach/thread_policy.h>
+#include <pthread.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+static int64_t now_ns(void)
+{
+    struct timespec ts;
+    clock_gettime(CLOCK_MONOTONIC, &ts);
+    return ts.tv_sec * 1000000000LL + ts.tv_nsec;
+}
+
+static int cmp(const void *a, const void *b)
+{
+    int64_t x = *(const int64_t *)a, y = *(const int64_t *)b;
+    return x < y ? -1 : x > y;
+}
+
+static int pfd[2], kq;
+
+/* poll with timeout rounded up to whole ms (g_poll / qemu_timeout_ns_to_ms) */
+static void w_poll_ms_up(int64_t ns)
+{
+    struct pollfd p = { pfd[0], POLLIN, 0 };
+    poll(&p, 1, (int)((ns + 999999) / 1000000));
+}
+
+/* poll with timeout truncated to whole ms: busy-waits below 1 ms */
+static void w_poll_ms_down(int64_t ns)
+{
+    struct pollfd p = { pfd[0], POLLIN, 0 };
+    poll(&p, 1, (int)(ns / 1000000));
+}
+
+static void w_pselect(int64_t ns)
+{
+    fd_set r;
+    FD_ZERO(&r);
+    FD_SET(pfd[0], &r);
+    struct timespec ts = { ns / 1000000000LL, ns % 1000000000LL };
+    pselect(pfd[0] + 1, &r, NULL, NULL, &ts, NULL);
+}
+
+static void w_kevent(int64_t ns)
+{
+    struct kevent ev;
+    struct timespec ts = { ns / 1000000000LL, ns % 1000000000LL };
+    kevent(kq, NULL, 0, &ev, 1, &ts);
+}
+
+static void w_nanosleep(int64_t ns)
+{
+    struct timespec ts = { ns / 1000000000LL, ns % 1000000000LL };
+    nanosleep(&ts, NULL);
+}
+
+/*
+ * poll whole ms (floor), then nanosleep the sub-ms remainder (Darwin
+ * qemu_poll_ns())
+ */
+static void w_hybrid(int64_t ns)
+{
+    int64_t start = now_ns();
+    struct pollfd p = { pfd[0], POLLIN, 0 };
+    int r = poll(&p, 1, (int)(ns / 1000000));
+    if (r == 0) {
+        int64_t rem = ns - (now_ns() - start);
+        if (rem > 0) {
+            struct timespec ts = { rem / 1000000000LL, rem % 1000000000LL };
+            nanosleep(&ts, NULL);
+        }
+    }
+}
+
+/* poll whole ms, then spin the sub-ms remainder */
+static void w_poll_spin(int64_t ns)
+{
+    int64_t end = now_ns() + ns;
+    struct pollfd p = { pfd[0], POLLIN, 0 };
+    if (ns >= 1000000) {
+        poll(&p, 1, (int)(ns / 1000000) - 1);
+    }
+    while (now_ns() < end) {
+        /* spin */
+    }
+}
+
+/* one-shot EVFILT_TIMER with ns resolution, re-armed each call */
+static void w_kevent_timer(int64_t ns)
+{
+    struct kevent ev, out;
+    EV_SET(&ev, 1 /*ident*/, EVFILT_TIMER, EV_ADD | EV_ONESHOT,
+           NOTE_NSECONDS, ns, NULL);
+    kevent(kq, &ev, 1, &out, 1, NULL);
+}
+
+/*
+ * kicker thread with mach_wait_until(); the main thread blocks on a Mach
+ * semaphore. Deadline computed in the helper each round.
+ */
+static semaphore_t sem;
+static mach_timebase_info_data_t tbi;
+static int64_t kick_period;
+/* written by main, polled by the kicker; no locking needed in a benchmark */
+static volatile int kick_run = 1;
+static pthread_t kick_thread;
+
+static void *kicker(void *arg)
+{
+    (void)arg;
+    while (kick_run) {
+        uint64_t dl = mach_absolute_time() +
+            (uint64_t)((double)kick_period * tbi.denom / tbi.numer);
+        mach_wait_until(dl);
+        semaphore_signal(sem);
+    }
+    return NULL;
+}
+
+static int mach_thread_setup(int64_t ns)
+{
+    kick_period = ns; /* set before the thread starts: kick_period=0 spins */
+    kick_run = 1;
+    return pthread_create(&kick_thread, NULL, kicker, NULL);
+}
+
+/* stop the kicker so it cannot perturb the following variants */
+static void mach_thread_teardown(void)
+{
+    kick_run = 0;
+    pthread_join(kick_thread, NULL);
+}
+
+static void w_mach_thread(int64_t ns)
+{
+    semaphore_wait(sem); /* blocking; the helper always signals */
+}
+
+/* run under THREAD_TIME_CONSTRAINT_POLICY */
+static int set_time_constraint(int64_t ns)
+{
+    thread_time_constraint_policy_data_t pol;
+    thread_port_t self = pthread_mach_thread_np(pthread_self());
+    uint64_t per = (uint64_t)((double)ns * tbi.denom / tbi.numer);
+
+    pol.period = per;
+    pol.computation = per / 2;
+    pol.constraint = per;
+    pol.preemptible = 0;
+    return thread_policy_set(self, THREAD_TIME_CONSTRAINT_POLICY,
+                             (thread_policy_t)&pol,
+                             THREAD_TIME_CONSTRAINT_POLICY_COUNT);
+}
+
+struct variant {
+    const char *name;
+    void (*wait)(int64_t);
+    int (*setup)(int64_t);      /* returns 0 on success, else variant skipped */
+    void (*teardown)(void);
+    bool extra;                 /* only run with --all */
+};
+
+static void run(struct variant *v, int64_t period, int n)
+{
+    struct rusage r0, r1;
+    int64_t *iv = malloc(n * sizeof(*iv));
+    int64_t last;
+    int64_t total = 0;
+    double cpu;
+
+    if (!iv) {
+        perror("malloc");
+        exit(1);
+    }
+
+    if (v->setup && v->setup(period)) {
+        printf("%-14s skipped: setup failed\n", v->name);
+        free(iv);
+        return;
+    }
+    getrusage(RUSAGE_SELF, &r0);
+    last = now_ns();
+    for (int i = 0; i < n; i++) {
+        v->wait(period);
+        int64_t t = now_ns();
+        iv[i] = t - last;
+        last = t;
+    }
+    getrusage(RUSAGE_SELF, &r1);
+    if (v->teardown) {
+        v->teardown();
+    }
+    cpu = (r1.ru_utime.tv_sec - r0.ru_utime.tv_sec) +
+          (r1.ru_stime.tv_sec - r0.ru_stime.tv_sec) +
+          (r1.ru_utime.tv_usec - r0.ru_utime.tv_usec) * 1e-6 +
+          (r1.ru_stime.tv_usec - r0.ru_stime.tv_usec) * 1e-6;
+    for (int i = 0; i < n; i++) {
+        total += iv[i];
+    }
+    qsort(iv, n, sizeof(*iv), cmp);
+    printf("%-14s p10 %.3f  median %.3f  p90 %.3f  max %.3f ms"
+           "  cpu %6.1f us/wait  wakes/s %8.1f\n",
+           v->name, iv[n / 10] / 1e6, iv[n / 2] / 1e6, iv[n * 9 / 10] / 1e6,
+           iv[n - 1] / 1e6, cpu / n * 1e6, n / (total / 1e9));
+    free(iv);
+}
+
+int main(int argc, char **argv)
+{
+    int64_t period = argc > 1 ? atoll(argv[1]) : 1047000;
+    int n = argc > 2 ? atoi(argv[2]) : 3000;
+    int all = argc > 3 && !strcmp(argv[3], "--all");
+    struct kevent kev;
+
+    if (argc > 4 || (argc > 3 && !all) || period <= 0 || n <= 0) {
+        fprintf(stderr, "usage: %s [period_ns>0] [iters>0] [--all]\n", argv[0]);
+        return 1;
+    }
+    /* tcon poll changes the thread policy for good: keep it last */
+    struct variant vs[] = {
+        { "poll ms-up",   w_poll_ms_up },
+        { "poll ms-down", w_poll_ms_down },
+        { "pselect ns",   w_pselect },
+        { "kevent ns",    w_kevent },
+        { "kevent-timer", w_kevent_timer },
+        { "nanosleep",    w_nanosleep },
+        { "hybrid",       w_hybrid },
+        { "poll+spin",    w_poll_spin, NULL, NULL, true },
+        { "mach-thread",  w_mach_thread, mach_thread_setup,
+          mach_thread_teardown, true },
+        { "tcon poll",    w_poll_ms_down, set_time_constraint, NULL, true },
+    };
+
+    if (pipe(pfd) < 0) {
+        return 1;
+    }
+    kq = kqueue();
+    if (kq < 0) {
+        perror("kqueue");
+        return 1;
+    }
+    EV_SET(&kev, pfd[0], EVFILT_READ, EV_ADD, 0, 0, NULL);
+    if (kevent(kq, &kev, 1, NULL, 0, NULL) < 0) {
+        perror("kevent register");
+        return 1;
+    }
+    mach_timebase_info(&tbi);
+    semaphore_create(mach_task_self(), &sem, SYNC_POLICY_FIFO, 0);
+    printf("period %.3f ms, %d iterations\n", period / 1e6, n);
+    for (size_t i = 0; i < sizeof(vs) / sizeof(vs[0]); i++) {
+        if (all || !vs[i].extra) {
+            run(&vs[i], period, n);
+        }
+    }
+    return 0;
+}
diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 4cd7a2f6b526..740b1ba7ac3f 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -17,6 +17,12 @@ executable('atomic64-bench',
            dependencies: [qemuutil],
            build_by_default: false)
 
+if host_os == 'darwin'
+  executable('macos-pollbench',
+             sources: files('macos-pollbench.c'),
+             build_by_default: false)
+endif
+
 benchs = {}
 
 if have_block
-- 
2.55.0



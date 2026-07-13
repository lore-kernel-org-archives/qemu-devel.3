Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB3C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjL3M-00037Q-Rg; Mon, 13 Jul 2026 14:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3K-00036q-Gz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjL3I-0006e2-1a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 14:06:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DH6O2H2107720
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AeYNuaxl3yH
 NN0qU6rIsG/7D7pj6cWSHdttKSmt5/N8=; b=hrlgOM8fr7RcCy6VuBk3G9GSYZn
 yf9aeZ/zoR+kIqr0rTNnlQA6TRoa5xDoHT1w/QWb9CHoKrQuX+U6VbDgU6EM4R/f
 UfHUireTNG7N7X++YI8bHBKLMciQLQ4Xr3v5fhGv93ijrR0CUcj++XTW+WpDAxSc
 baXuFaohvweWOrBPg5XfDYlQ7FCS9m/EpteHVhBh2qfDYJwCQgAu9QD1+f7F2bxw
 ApKSWUboOEZ+c7ztL8WBuX0i3LuwExWqoISlvhSky5OLPDT0oWn5ZmOwwSyzQgQy
 C0OvJL5WVxHFJwh8HB+Uvz8gyZ/g8P5hJwwIt9K3QUHhQUVMxOqBJFEf/pg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j07xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:06:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84857446424so7049720b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783966006; x=1784570806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AeYNuaxl3yHNN0qU6rIsG/7D7pj6cWSHdttKSmt5/N8=;
 b=CWm+9Bp6X1XT2nWzZi1w1uZ+vKiFHUDgqNoihg+yOklx97gP3m06+DFURKQW83vRM6
 NG11LMVOKyUBV5TTHJIXnXmNe3lQKCrmV3zRKVTdLG0q/MXlaks/BzQ7Qg/8GsLyc09e
 zwqvl5ESNMCSmAdnExR6A+bWphRtc+g3UWK8HnRZ48t4lr3/B8pV+hVt9PtTJpdfgbMC
 S7T2hERafcp4vHPOZuwwNs5/4OnTTJxywq3+ND7too3gtOGIDbUM4tjDBfnTUHudzeqt
 nY4SkF5rlueQ9eTeqvouBYrPffopWjIfoQ0R8d5To9I35Yylf8RyDksENL9YWDpJ9vTq
 metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783966006; x=1784570806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AeYNuaxl3yHNN0qU6rIsG/7D7pj6cWSHdttKSmt5/N8=;
 b=TGWkBV+6xuSJK65QrnXvxwgvn8At+3efwPBFxyqoUwPmZRU6Zr9nQ9tTLj1bmE6Uj2
 JAFL/spYGTAaDp4L5w59gsFBi5zGH2eC8jkgC3118WEqWtzo9Y6OeQXr7vLMxfQ+q/Y9
 ZMR00BZ3LlIlWiyhF4XiObHOCOwPN9/Aw2uP2slRwB2/yvVG9g8Qt3fApUp+JRaxm0ts
 BGpan5ZkxE6PWEC6XG8SK+VkRkaBDYBZj/3rQJBnu4eRWSzZLqGWijIhq1pzevMorTHz
 vGp72k2nnGIC9FLDKoR8a5d52I/HBiueOezD49O5sXiLTliTLqJHxtFlskHlcQvWpcGO
 GdUw==
X-Gm-Message-State: AOJu0Yz+TgRz60Oh+ELEAVd6DijRVk0c1G9OUiA+9r5U5Wkp5zw+X3dp
 LZhl7ruQ5ZJG6BYFEvqyHIgTCUGSbTq+Rxr3/6P5uT1Gtu68aLrg1YDV0NRH5F4M53YJEsx5tHz
 Bql2fKXPE6QmEnZuTDNFBeTeOgKbxrDjmT3KGtNwLf2nU7dsf/TosLtgcYrptZkCDKQ==
X-Gm-Gg: AfdE7clikxI4hFlq3rapfzQ9uJTF1wBlascl/EPetO+xF30ZLVhsfr9AYfMY9Dd+yUq
 tEmHB4l90Zs5lMU063i4JfFC6OO/KXmoIspevGEwUYxi9RBL/LP+s4ikswcmYCt6UQ3z5mV6Gy+
 AS492Oz+hVxUNsUJjmbiPewJ84Em0p0NqMBbWrtFjSPVRk0xss32OwbbOpUFYYn4flOiEY/2G2w
 TN75UEgPVpugKGqUJbLkxUjwSGuaPoUtYypsJVf/jFe6fyWRInOCWRT/Gwapp42u5AnNE1rKE3p
 iEAJ32E+z0kDKOpHlKYXlZ/oRmCJ3WBhGMQ+sYqUqGQMcNLUIC77pf+U9rrvEAA84e6ihKiAK//
 hX690VlQ5jsDnsob8RqgSMO0yo3k+c7BcUoVShXR1HYz9mtKFkKa2SIUQfHMwHTH6Owc9MgXcDk
 Kqr7q9aw==
X-Received: by 2002:a05:6300:2204:b0:3c0:9c19:65b0 with SMTP id
 adf61e73a8af0-3c110a57dcfmr11300373637.72.1783966005788; 
 Mon, 13 Jul 2026 11:06:45 -0700 (PDT)
X-Received: by 2002:a05:6300:2204:b0:3c0:9c19:65b0 with SMTP id
 adf61e73a8af0-3c110a57dcfmr11300334637.72.1783966005261; 
 Mon, 13 Jul 2026 11:06:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm27501109c88.4.2026.07.13.11.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:06:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] contrib/plugins: add a minimal dlcall plugin
Date: Mon, 13 Jul 2026 11:06:37 -0700
Message-ID: <20260713180638.2228609-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260713180638.2228609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfX4kNKrq/R6KAu
 cMuoCDtSeUf5273Ki4fy0pDl5X27VQeTOi1Z3hVAPmb8oroIXRsxzVydIZcrQeSu6hE739wE228
 htVhBej8lDCNHf4VbKZul2Rx+3S5a7s=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a552936 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=TBq7--GwHvIaXDVWMgMA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: gSWT0NcL9rb-p5W0NZjfAHDJJIlwU-5a
X-Proofpoint-ORIG-GUID: gSWT0NcL9rb-p5W0NZjfAHDJJIlwU-5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NyBTYWx0ZWRfXwGAkViTbkbFF
 dwRZg8X6vPE+1U6BkENTnzP4ZqYoyDibvLYH/REY90slIX5pedEm+YBVnmUxs88xMun/0YY0u+r
 sLlimJXkPYWqR9Y4b2zMNtY56r98pOQqmUniI+hZru/v+BQbkMl9UAXhRevSMQJ4HH/QQIOdg41
 5Xwq9rJLPlZzZIhY/RzWE2BYhgQMw8ZNQxAbdWMsAo32iKQ9uzqb5M+QpFOi+bDnN5o4LW1XrN3
 8Dkq8orGGLMfXeIvfOmfdV1Oxcs5KC4W9bZtL8B/C+PBdhQcwMxA5scAcErf/lVpi5hpOaUdsOY
 I9ILgWGKj4CbcmK1wMw3ATOf7Hy9gOHUkSzywnFph/GsniVqUX4Auf1E33YoevD9N1/kTfOI9AA
 5/hImPw0l3eUd5NTOLJPTXcSSLHbFdZB9xUUSonsCTuBRyEIDshMoFBiXZ14woQBneJ7wgtW1nd
 AquYUy1hiHetKAc2xpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130187
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Add a minimal dlcall plugin that lets the guest invoke host functions
through magic system calls. The plugin registers a vCPU syscall filter
callback that intercepts a reserved syscall number and dispatches a set
of pass-through operations: querying host attributes, loading and freeing
shared libraries, resolving symbols, retrieving the last library error,
and invoking a host function through a common interface.

The magic syscall number defaults to 4096 and can be overridden at load
time with the "syscall_num=N" argument; values low enough to clash with a
real syscall are rejected.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260711094523.622997-2-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/dlcall.c    | 248 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   5 +
 2 files changed, 253 insertions(+)
 create mode 100644 contrib/plugins/dlcall.c

diff --git a/contrib/plugins/dlcall.c b/contrib/plugins/dlcall.c
new file mode 100644
index 00000000000..9d2230b2d1a
--- /dev/null
+++ b/contrib/plugins/dlcall.c
@@ -0,0 +1,248 @@
+/*
+ * Copyright (C) 2026, Ziyang Zhang <functioner@sjtu.edu.cn>
+ *
+ * dlcall (Dynamic Linking Call) plugin: lets a linux-user guest invoke host
+ * functions by issuing a magic system call. The guest can ask QEMU to dlopen()
+ * a host shared library, dlsym() a symbol, and call it with guest-supplied
+ * arguments.
+ *
+ * The plugin intentionally keeps the QEMU side lightweight and prescribes
+ * nothing about how a library is thunked. Any toolchain can implement the
+ * userspace side. Lorelei is one end-to-end implementation (guest/host
+ * runtimes plus a thunk compiler that generates thunks from a library's
+ * headers):
+ * https://github.com/rover2024/lorelei
+ *
+ * See docs/about/emulation.rst|Dynamic Linking Call for details and examples.
+ *
+ * WARNING: trusted guests only. The guest can load arbitrary host libraries
+ * and execute arbitrary host code with arbitrary arguments, i.e. full code
+ * execution in the QEMU host process. It is NOT a sandbox and provides no
+ * isolation; only load it for guests you fully trust.
+ *
+ * WARNING: requires guest_base == 0, which is qemu-user's default. Pointer
+ * operands are dereferenced as host addresses directly, and the invoked host
+ * functions dereference guest pointers with no address translation, so guest
+ * and host must share a single address space. A non-zero guest_base (e.g. set
+ * via -B/-R) would make every pointer off by guest_base and hit unrelated
+ * host memory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <glib.h>
+#include <dlfcn.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * The magic system call number for dlcall.
+ *
+ * It defaults to DLCALL_SYSCALL_DEFAULT and can be overridden at load time
+ * with the "syscall_num=N" argument. To avoid hijacking a real syscall the
+ * guest might issue, N must be at least DLCALL_SYSCALL_MIN: every Linux ABI
+ * keeps its syscall numbers well below this; numbers from here up are free.
+ */
+enum {
+    DLCALL_SYSCALL_DEFAULT = 4096,
+    DLCALL_SYSCALL_MIN = 4096,
+};
+
+static int64_t dlcall_syscall_num = DLCALL_SYSCALL_DEFAULT;
+
+/*
+ * dlcall calling convention.
+ *
+ * The guest issues the magic system call (dlcall_syscall_num). The first
+ * argument (a1) is one of the call IDs below; the remaining arguments (a2, a3,
+ * a4, ...) are that ID's operands. All pointer operands are guest virtual
+ * addresses that the plugin dereferences as host addresses directly (see the
+ * guest_base requirement above). Results are written back through
+ * caller-provided "out" pointers rather than returned in the syscall value.
+ *
+ * The syscall return value (*sysret) only reports dispatch status: 0 on a
+ * recognised ID, -EINVAL for an unknown one. The actual success/failure of an
+ * operation (e.g. a NULL handle from dlopen) is delivered through its out
+ * pointer, exactly like the underlying libdl call.
+ *
+ * Operands per ID:
+ *
+ *   DLCALL_ID_GET_HOST_ATTRIBUTE
+ *     a2  const char *key        in:  attribute name to query
+ *     a3  const char **attr_ptr  out: matching value, or NULL if unknown
+ *
+ *   DLCALL_ID_LOAD_LIBRARY                            (wraps dlopen)
+ *     a2  const char *path       in:  library path
+ *     a3  int flags              in:  dlopen() flags (e.g. RTLD_NOW)
+ *     a4  void **handle_ptr      out: library handle, or NULL on failure
+ *
+ *   DLCALL_ID_GET_PROC_ADDRESS                        (wraps dlsym)
+ *     a2  void *handle           in:  library handle
+ *     a3  const char *name       in:  symbol name
+ *     a4  void **entry_ptr       out: symbol address, or NULL if not found
+ *
+ *   DLCALL_ID_FREE_LIBRARY                            (wraps dlclose)
+ *     a2  void *handle           in:  library handle
+ *     a3  int *ret_ptr           out: dlclose() return value (0 on success)
+ *
+ *   DLCALL_ID_GET_LIBRARY_ERROR                       (wraps dlerror)
+ *     a2  const char **error_ptr out: last libdl error string, or NULL
+ *
+ *   DLCALL_ID_INVOKE_PROC                             (calls the symbol)
+ *     a2  void *proc             in:  function pointer, signature
+ *                                     void (*)(void *arg1, void *arg2)
+ *     a3  void *arg1             in:  first argument forwarded to proc
+ *     a4  void *arg2             in:  second argument forwarded to proc
+ */
+enum DlcallID {
+    DLCALL_ID_GET_HOST_ATTRIBUTE,
+    DLCALL_ID_LOAD_LIBRARY,
+    DLCALL_ID_GET_PROC_ADDRESS,
+    DLCALL_ID_FREE_LIBRARY,
+    DLCALL_ID_GET_LIBRARY_ERROR,
+    DLCALL_ID_INVOKE_PROC,
+};
+
+static inline const char *query_host_attribute(const char *key)
+{
+    if (strcmp(key, "emu") == 0) {
+        return "qemu";
+    }
+    return NULL;
+}
+
+static inline void invoke_proc(void *proc, void *arg1, void *arg2)
+{
+    typedef void (*Func)(void * /*arg1*/, void * /*arg2*/);
+    Func func = (Func) proc;
+    func(arg1, arg2);
+}
+
+static bool vcpu_syscall_filter(unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                int64_t *sysret, void *userdata)
+{
+    if (num == dlcall_syscall_num) {
+        switch (a1) {
+        /* Query host attribute by a reserved key. */
+        case DLCALL_ID_GET_HOST_ATTRIBUTE: {
+            const char *key = (const char *) a2;
+            const char **attr_ptr = (const char **) a3;
+            assert(attr_ptr);
+            *attr_ptr = query_host_attribute(key);
+            *sysret = 0;
+            break;
+        }
+
+        /* Load a shared library. */
+        case DLCALL_ID_LOAD_LIBRARY: {
+            const char *path = (const char *) a2;
+            int flags = (int) a3;
+            void **handle_ptr = (void **) a4;
+            assert(handle_ptr);
+            *handle_ptr = dlopen(path, flags);
+            *sysret = 0;
+            break;
+        }
+
+        /* Get the address of a function in a shared library. */
+        case DLCALL_ID_GET_PROC_ADDRESS: {
+            void *handle = (void *) a2;
+            const char *name = (const char *) a3;
+            void **entry_ptr = (void **) a4;
+            assert(entry_ptr);
+            *entry_ptr = dlsym(handle, name);
+            *sysret = 0;
+            break;
+        }
+
+        /* Free a shared library. */
+        case DLCALL_ID_FREE_LIBRARY: {
+            void *handle = (void *) a2;
+            int *ret_ptr = (int *) a3;
+            *ret_ptr = dlclose(handle);
+            *sysret = 0;
+            break;
+        }
+
+        /* Get the last error message for a library event. */
+        case DLCALL_ID_GET_LIBRARY_ERROR: {
+            const char **error_ptr = (const char **) a2;
+            *error_ptr = dlerror();
+            *sysret = 0;
+            break;
+        }
+
+        /* Invoke a function of a common interface. */
+        case DLCALL_ID_INVOKE_PROC: {
+            void *proc = (void *) a2;
+            void *arg1 = (void *) a3;
+            void *arg2 = (void *) a4;
+            assert(proc);
+            invoke_proc(proc, arg1, arg2);
+            *sysret = 0;
+            break;
+        }
+
+        default:
+            *sysret = -EINVAL;
+            break;
+        }
+        return true;
+    }
+    return false;
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (info->system_emulation) {
+        fprintf(stderr, "plugin dlcall: only useful for user emulation\n");
+        return -1;
+    }
+
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "syscall_num") == 0) {
+            const char *val = tokens[1];
+            char *endptr = NULL;
+            guint64 num;
+            if (!val || *val == '\0') {
+                fprintf(stderr,
+                        "plugin dlcall: missing value for syscall_num\n");
+                return -1;
+            }
+            num = g_ascii_strtoull(val, &endptr, 0);
+            if (*endptr != '\0' || g_strrstr(val, "-") != NULL) {
+                fprintf(stderr,
+                        "plugin dlcall: invalid syscall_num '%s'\n", val);
+                return -1;
+            }
+            if (num < DLCALL_SYSCALL_MIN || num > G_MAXINT64) {
+                fprintf(stderr,
+                        "plugin dlcall: syscall_num %s is out of range; "
+                        "it must be >= %d to avoid clashing with a real "
+                        "syscall\n", val, DLCALL_SYSCALL_MIN);
+                return -1;
+            }
+            dlcall_syscall_num = (int64_t) num;
+        } else {
+            fprintf(stderr, "plugin dlcall: unknown option '%s'\n", opt);
+            return -1;
+        }
+    }
+
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 099319e7a17..e7fc4d6d8f5 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -19,6 +19,11 @@ if host_os != 'windows'
   contrib_plugins += 'lockstep.c'
 endif
 
+if host_os == 'linux'
+  # dlcall passes guest calls through to host libraries; linux-user only
+  contrib_plugins += 'dlcall.c'
+endif
+
 if 'cpp' in all_languages
   contrib_plugins += 'cpp.cpp'
 endif
-- 
2.47.3



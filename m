Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D7D109B485
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7aWv-0000Rl-Ju; Tue, 31 Mar 2026 10:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7WrF-0008FZ-TU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:02:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7WrC-0000kp-MZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 07:02:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so66264015e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774954918; x=1775559718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNXBaHHUoEeUfML+1Ns1mcvgvdBnRcRcsN47PYzl2XY=;
 b=nOgp+BFbXWIHK8ois8PzXY2dLeZUnqbRAgzxhlp7XlUprg/Gc6MFPY6XhXJWNquIG7
 rwl7ilJ18XKlBd08wVR58M5YBXTSzkC3U8dEHqsFeROxB8pZBu0ytpCwW0lKdZ9F/1fi
 D7zqPMpKZNyWW5LJ0Wo2ARypS8GLKlW0XS3joLb/UXCDjPjb9tg4rpUPIz99qIakgy0a
 8PysOElqbnXqzmHRhrSHeYZ9Lw6su+SNjDLIv00ByBONTwEC23TUpOjmtrbrEVEo3P9R
 lfipPgLtAM5C9QGPJLY8QsCEs/IluTdFzEd28mzp0PW99esjwlndm7RrJP7A6ZmY/YLZ
 gWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774954918; x=1775559718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNXBaHHUoEeUfML+1Ns1mcvgvdBnRcRcsN47PYzl2XY=;
 b=Mcolmf5//j852ex/eAKOKyQ5/lUSmFHG+Bfq1z7R9w0kOyVYTxSWul75q7v0IL8iCD
 DPdoKQY9JYlD3fb+hsoirsdkOpO2ZTlxUWXgapXnggYHSKSjADhiM5a9qu9+UT2e2mdd
 EMVh6sEIkgis6HA8sZWgYSW6cnTF6QezB17OxCtSmVQFAjZityS9JVYqU0B3VTle8Mrm
 tVDY/No6/GfNL9W2ezs38RXPKLVZBOQSeOCMRg/VCPzIn/kkfJWlIctkR2FGWQoC7YGQ
 +DV3PkcM9Z/BOWsrNX7evz+rk4QJp6APuJH2Zk6OSn3e07/5okb2GKYjR3svSHlV3vUd
 TRvg==
X-Gm-Message-State: AOJu0YxpfCVplcTiBtivLcymFvx/9qhqEIOIiu1wzjL/pvlx5zTPKKmF
 9PxEFIXrtVaVz9IxoaCfHscnrZENuLMmtf+Np4/+5Pww4d2Q5WU7Jed7Lhuv4UGF
X-Gm-Gg: ATEYQzyVwV+Dtpgqa6kqZ2A6JfyWFyL0xKOhUcXsV1mrnM0hkXkfdFxrZcs5ybuGZyI
 AXhRkyk7v5wqDQu3OoTqwOXzBk6Yd68Zhp3Gf0udoT2lbC5IW78A7TdGKni8wEsVNGGijioYaV+
 C2MPHRT03BNxMXtQYR2SWInUM9LvYM0GLDQz40ex5XMkiw6XcuJt95DXB0rEUyLT4gwo5hQGqGp
 vRe6fG23ehJkmEb0FBnM5xip6jXAv8J95By0jgWnjp0L962Ar48m0ny+KBzX9gToER9i6CBwQmo
 bPhfhsMut04zYtMgqtgvpXuOm9RbgxgW0XTefS6yvL6PNtPqXy07QEarkqzeZAEXEr1WsrV5AdZ
 suI3HaR7VxWmx64toVQRsi8RyyT4wCgk4HQG2zKV/iJLhmyuQUH8tOptp0q33mLD6PcRdkVOkGu
 fNxKQoOyRTabSUBi0728igVB0uHt5RWe98FlkpquozTjM+ElsD249SuyV4siSo8bIc11NFOeOMZ
 PU+9KDy1X84GNcasw==
X-Received: by 2002:a05:600c:a407:b0:485:4526:ee06 with SMTP id
 5b1f17b1804b1-48727e8bd95mr233368335e9.11.1774954917901; 
 Tue, 31 Mar 2026 04:01:57 -0700 (PDT)
Received: from mvf41desk.lan (102.94.249.5.rev.vodafone.pt. [5.249.94.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f279bsm23836571f8f.16.2026.03.31.04.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 04:01:57 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Vila=C3=A7a?= <machadovilaca@gmail.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
 =?UTF-8?q?Jo=C3=A3o=20Vila=C3=A7a?= <machadovilaca@gmail.com>
Subject: [PATCH] qga: implement 'guest-get-nvidia-smi' command
Date: Tue, 31 Mar 2026 12:01:35 +0100
Message-ID: <20260331110135.92883-1-machadovilaca@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=machadovilaca@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 31 Mar 2026 10:57:12 -0400
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

---
 qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 837be51c40..631a8a9ee6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)
     return ret;
 }
 #endif
+
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
+{
+    const gchar *argv[] = {
+        "nvidia-smi",
+        "--query-gpu=index,name,driver_version,"
+            "temperature.gpu,utilization.gpu,utilization.memory,"
+            "memory.total,memory.free,memory.used",
+        "--format=csv,noheader,nounits",
+        NULL
+    };
+    g_autofree gchar *stdout_buf = NULL;
+    g_autofree gchar *stderr_buf = NULL;
+    gint exit_status;
+    GError *gerr = NULL;
+    GuestNvidiaGpuList *head = NULL, **tail = &head;
+
+    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
+                      G_SPAWN_SEARCH_PATH,
+                      NULL, NULL,
+                      &stdout_buf, &stderr_buf,
+                      &exit_status, &gerr)) {
+        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message);
+        g_error_free(gerr);
+        return NULL;
+    }
+
+    if (exit_status != 0) {
+        error_setg(errp, "nvidia-smi failed (exit %d): %s",
+                   exit_status, stderr_buf ? stderr_buf : "unknown error");
+        return NULL;
+    }
+
+    gchar **lines = g_strsplit(stdout_buf, "\n", -1);
+    for (int i = 0; lines[i] != NULL; i++) {
+        gchar *line = g_strstrip(lines[i]);
+        if (*line == '\0') {
+            continue;
+        }
+
+        gchar **f = g_strsplit(line, ", ", 9);
+        if (g_strv_length(f) < 9) {
+            g_strfreev(f);
+            continue;
+        }
+
+        GuestNvidiaGpu *gpu     = g_new0(GuestNvidiaGpu, 1);
+        gpu->index              = (int)g_ascii_strtoll(f[0], NULL, 10);
+        gpu->name               = g_strdup(g_strstrip(f[1]));
+        gpu->driver_version     = g_strdup(g_strstrip(f[2]));
+        gpu->temperature        = (int)g_ascii_strtoll(f[3], NULL, 10);
+        gpu->gpu_utilization    = (int)g_ascii_strtoll(f[4], NULL, 10);
+        gpu->memory_utilization = (int)g_ascii_strtoll(f[5], NULL, 10);
+        gpu->memory_total       = (int)g_ascii_strtoll(f[6], NULL, 10);
+        gpu->memory_free        = (int)g_ascii_strtoll(f[7], NULL, 10);
+        gpu->memory_used        = (int)g_ascii_strtoll(f[8], NULL, 10);
+
+        QAPI_LIST_APPEND(tail, gpu);
+        g_strfreev(f);
+    }
+    g_strfreev(lines);
+
+    return head;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..a78d5b71f5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2764,3 +2764,67 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
     g_hash_table_destroy(interface_metric_cache);
     return head;
 }
+
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
+{
+    const gchar *argv[] = {
+        "nvidia-smi",
+        "--query-gpu=index,name,driver_version,"
+            "temperature.gpu,utilization.gpu,utilization.memory,"
+            "memory.total,memory.free,memory.used",
+        "--format=csv,noheader,nounits",
+        NULL
+    };
+    g_autofree gchar *stdout_buf = NULL;
+    g_autofree gchar *stderr_buf = NULL;
+    gint exit_status;
+    GError *gerr = NULL;
+    GuestNvidiaGpuList *head = NULL, **tail = &head;
+
+    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
+                      G_SPAWN_SEARCH_PATH,
+                      NULL, NULL,
+                      &stdout_buf, &stderr_buf,
+                      &exit_status, &gerr)) {
+        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message);
+        g_error_free(gerr);
+        return NULL;
+    }
+
+    if (exit_status != 0) {
+        error_setg(errp, "nvidia-smi failed (exit %d): %s",
+                   exit_status, stderr_buf ? stderr_buf : "unknown error");
+        return NULL;
+    }
+
+    gchar **lines = g_strsplit(stdout_buf, "\n", -1);
+    for (int i = 0; lines[i] != NULL; i++) {
+        gchar *line = g_strstrip(lines[i]);
+        if (*line == '\0') {
+            continue;
+        }
+
+        gchar **f = g_strsplit(line, ", ", 9);
+        if (g_strv_length(f) < 9) {
+            g_strfreev(f);
+            continue;
+        }
+
+        GuestNvidiaGpu *gpu     = g_new0(GuestNvidiaGpu, 1);
+        gpu->index              = (int)g_ascii_strtoll(f[0], NULL, 10);
+        gpu->name               = g_strdup(g_strstrip(f[1]));
+        gpu->driver_version     = g_strdup(g_strstrip(f[2]));
+        gpu->temperature        = (int)g_ascii_strtoll(f[3], NULL, 10);
+        gpu->gpu_utilization    = (int)g_ascii_strtoll(f[4], NULL, 10);
+        gpu->memory_utilization = (int)g_ascii_strtoll(f[5], NULL, 10);
+        gpu->memory_total       = (int)g_ascii_strtoll(f[6], NULL, 10);
+        gpu->memory_free        = (int)g_ascii_strtoll(f[7], NULL, 10);
+        gpu->memory_used        = (int)g_ascii_strtoll(f[8], NULL, 10);
+
+        QAPI_LIST_APPEND(tail, gpu);
+        g_strfreev(f);
+    }
+    g_strfreev(lines);
+
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..8abbf71131 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1876,6 +1876,65 @@
   'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
 }
 
+##
+# @GuestNvidiaGpu:
+#
+# Information about a single NVIDIA GPU as reported by nvidia-smi.
+#
+# @index: GPU index (0-based), stable across reboots for a given
+#         hardware slot
+#
+# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
+#
+# @driver-version: version string of the installed NVIDIA driver
+#
+# @temperature: GPU die temperature in degrees Celsius
+#
+# @gpu-utilization: GPU compute engine utilization in percent (0-100)
+#
+# @memory-utilization: GPU memory controller utilization in percent
+#                      (0-100)
+#
+# @memory-total: total framebuffer memory in MiB
+#
+# @memory-free: free framebuffer memory in MiB
+#
+# @memory-used: used framebuffer memory in MiB
+#
+# Since: 10.1
+##
+{ 'struct': 'GuestNvidiaGpu',
+  'data': {
+      'index':              'int',
+      'name':               'str',
+      'driver-version':     'str',
+      'temperature':        'int',
+      'gpu-utilization':    'int',
+      'memory-utilization': 'int',
+      'memory-total':       'int',
+      'memory-free':        'int',
+      'memory-used':        'int'
+  }
+}
+
+##
+# @guest-get-nvidia-smi:
+#
+# Query NVIDIA GPU information via nvidia-smi inside the guest.
+#
+# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)
+# detected by the NVIDIA driver.
+#
+# Errors:
+#   - If nvidia-smi is not installed or not found in $PATH
+#   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
+#     device)
+#
+# Since: 10.1
+##
+{ 'command': 'guest-get-nvidia-smi',
+  'returns': ['GuestNvidiaGpu'] }
+
 ##
 # @GuestNetworkRoute:
 #
-- 
2.53.0



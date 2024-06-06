Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8JX-0002b5-Ri; Thu, 06 Jun 2024 04:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8JW-0002Yy-HU
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:17:38 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8JU-0000cy-6C
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:17:38 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eacd7e7ad7so8328641fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717661853; x=1718266653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yPskSSs4QP/AmtFrMRW6vALHS2N7oEPdODcqp1a6qso=;
 b=yQBaJH8zGqsWkhtzFRDJZZ1hkt9M5n3yfpO9qTsOSW3ui2f0tRwIPECClL9e9di2Vk
 OV+qRi7sdvrcxWwboo5jHOozdILJ7sEjQUJ8L0Q8FdWdecJAxetthMAawaAlXEwl9iYA
 D91XNm85kB0B3hqx9AbX8g9PurLn1OxXrU5GYxKLuX/6qaLxcOFec5gLyAOCLHOPaNHd
 7sjR5FQcJDj38DGzWEAXTm6YDizGHRzceYcUKgR7XcyNIgSFLcfHdXxnhwuQ5h50mezc
 YLckqaO9SEeH6Ul3GyAVSWp/IrMJZnY7GxHt51woxcEGzUemKrcS8aZvLFSrUg8MmLTA
 VrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661853; x=1718266653;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yPskSSs4QP/AmtFrMRW6vALHS2N7oEPdODcqp1a6qso=;
 b=NV8gLcdDDuT3orBO2IjI09mkNlDZoJoohU58LtNk9PlxSS1YSr3mmwHWy76RbOJMmh
 8+Ab1T+gBfN/zN/nbQf6L8AoJL7uz2ge5imbP34MCX8hQFdPHJG2zs1YlAOpHcQd9mHN
 NlWmX4Fil9ve4+srrhhBtpWm25J2kIW+ditN8gMJVlUfdx2vywHKNGgpZznU2ItsCMHh
 GaKhNZBc2AwBygbSbekLgbAEiQOH23srT+OqZKdPjZXgoe83APSIMj4ABjNV5r4JUXFp
 KhI005wvxLYO1EJbyVWN/Xbtvxo/pH/PtgHSTsR4gswhPJ57j7T2kqTqfaObxttYECp4
 3FlQ==
X-Gm-Message-State: AOJu0YyJc8hqrXqoDgu0QVny3nJhGy8CrBsQJBxiKBhoUmehdbGRL7ac
 guuYmDtKUyvPSAG8VSifj8xqS2pugZ71MX36ewNk+CMz3E6D9NmjQBo0xAZXdJ0eZhhNobPahUQ
 gc38=
X-Google-Smtp-Source: AGHT+IFt1sUOCnxHNaf7LsmCFO9S9KqZsEifhMkT8IVCN0iRy7eXHXpPF8lurRnwGH4R25hq9iz9tg==
X-Received: by 2002:a2e:a7d6:0:b0:2ea:ca11:eef3 with SMTP id
 38308e7fff4ca-2eaca11f015mr28480151fa.4.1717661852709; 
 Thu, 06 Jun 2024 01:17:32 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c690dsm12950475e9.34.2024.06.06.01.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:17:32 -0700 (PDT)
Date: Thu, 06 Jun 2024 11:08:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 02/20] qga: move linux vcpu command impls to
 commands-linux.c
User-Agent: meli 0.8.5
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-3-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-3-berrange@redhat.com>
Message-ID: <engd6.q216wfwyfd8b@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 04 Jun 2024 16:49, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>The qmp_guest_set_vcpus and qmp_guest_get_vcpus command impls in
>commands-posix.c are surrounded by '#ifdef __linux__' so should
>instead live in commands-linux.c
>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> qga/commands-linux.c | 141 +++++++++++++++++++++++++++++++++++++++++++
> qga/commands-posix.c | 139 ------------------------------------------
> 2 files changed, 141 insertions(+), 139 deletions(-)
>
>diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>index 214e408fcd..78580ac39d 100644
>--- a/qga/commands-linux.c
>+++ b/qga/commands-linux.c
>@@ -13,6 +13,7 @@
> 
> #include "qemu/osdep.h"
> #include "qapi/error.h"
>+#include "qga-qapi-commands.h"
> #include "commands-common.h"
> #include "cutils.h"
> #include <mntent.h>
>@@ -284,3 +285,143 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>     return i;
> }
> #endif /* CONFIG_FSFREEZE */
>+
>+/* Transfer online/offline status between @vcpu and the guest system.
>+ *
>+ * On input either @errp or *@errp must be NULL.
>+ *
>+ * In system-to-@vcpu direction, the following @vcpu fields are accessed:
>+ * - R: vcpu->logical_id
>+ * - W: vcpu->online
>+ * - W: vcpu->can_offline
>+ *
>+ * In @vcpu-to-system direction, the following @vcpu fields are accessed:
>+ * - R: vcpu->logical_id
>+ * - R: vcpu->online
>+ *
>+ * Written members remain unmodified on error.
>+ */
>+static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
>+                          char *dirpath, Error **errp)
>+{
>+    int fd;
>+    int res;
>+    int dirfd;
>+    static const char fn[] = "online";
>+
>+    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
>+    if (dirfd == -1) {
>+        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
>+        return;
>+    }
>+
>+    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
>+    if (fd == -1) {
>+        if (errno != ENOENT) {
>+            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
>+        } else if (sys2vcpu) {
>+            vcpu->online = true;
>+            vcpu->can_offline = false;
>+        } else if (!vcpu->online) {
>+            error_setg(errp, "logical processor #%" PRId64 " can't be "
>+                       "offlined", vcpu->logical_id);
>+        } /* otherwise pretend successful re-onlining */
>+    } else {
>+        unsigned char status;
>+
>+        res = pread(fd, &status, 1, 0);
>+        if (res == -1) {
>+            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
>+        } else if (res == 0) {
>+            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
>+                       fn);
>+        } else if (sys2vcpu) {
>+            vcpu->online = (status != '0');
>+            vcpu->can_offline = true;
>+        } else if (vcpu->online != (status != '0')) {
>+            status = '0' + vcpu->online;
>+            if (pwrite(fd, &status, 1, 0) == -1) {
>+                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
>+                                 fn);
>+            }
>+        } /* otherwise pretend successful re-(on|off)-lining */
>+
>+        res = close(fd);
>+        g_assert(res == 0);
>+    }
>+
>+    res = close(dirfd);
>+    g_assert(res == 0);
>+}
>+
>+GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>+{
>+    GuestLogicalProcessorList *head, **tail;
>+    const char *cpu_dir = "/sys/devices/system/cpu";
>+    const gchar *line;
>+    g_autoptr(GDir) cpu_gdir = NULL;
>+    Error *local_err = NULL;
>+
>+    head = NULL;
>+    tail = &head;
>+    cpu_gdir = g_dir_open(cpu_dir, 0, NULL);
>+
>+    if (cpu_gdir == NULL) {
>+        error_setg_errno(errp, errno, "failed to list entries: %s", cpu_dir);
>+        return NULL;
>+    }
>+
>+    while (local_err == NULL && (line = g_dir_read_name(cpu_gdir)) != NULL) {
>+        GuestLogicalProcessor *vcpu;
>+        int64_t id;
>+        if (sscanf(line, "cpu%" PRId64, &id)) {
>+            g_autofree char *path = g_strdup_printf("/sys/devices/system/cpu/"
>+                                                    "cpu%" PRId64 "/", id);
>+            vcpu = g_malloc0(sizeof *vcpu);
>+            vcpu->logical_id = id;
>+            vcpu->has_can_offline = true; /* lolspeak ftw */
>+            transfer_vcpu(vcpu, true, path, &local_err);
>+            QAPI_LIST_APPEND(tail, vcpu);
>+        }
>+    }
>+
>+    if (local_err == NULL) {
>+        /* there's no guest with zero VCPUs */
>+        g_assert(head != NULL);
>+        return head;
>+    }
>+
>+    qapi_free_GuestLogicalProcessorList(head);
>+    error_propagate(errp, local_err);
>+    return NULL;
>+}
>+
>+int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>+{
>+    int64_t processed;
>+    Error *local_err = NULL;
>+
>+    processed = 0;
>+    while (vcpus != NULL) {
>+        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
>+                                     vcpus->value->logical_id);
>+
>+        transfer_vcpu(vcpus->value, false, path, &local_err);
>+        g_free(path);
>+        if (local_err != NULL) {
>+            break;
>+        }
>+        ++processed;
>+        vcpus = vcpus->next;
>+    }
>+
>+    if (local_err != NULL) {
>+        if (processed == 0) {
>+            error_propagate(errp, local_err);
>+        } else {
>+            error_free(local_err);
>+        }
>+    }
>+
>+    return processed;
>+}
>diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>index 76af98ba32..a8ef41f175 100644
>--- a/qga/commands-posix.c
>+++ b/qga/commands-posix.c
>@@ -2003,145 +2003,6 @@ void qmp_guest_suspend_hybrid(Error **errp)
>     guest_suspend(SUSPEND_MODE_HYBRID, errp);
> }
> 
>-/* Transfer online/offline status between @vcpu and the guest system.
>- *
>- * On input either @errp or *@errp must be NULL.
>- *
>- * In system-to-@vcpu direction, the following @vcpu fields are accessed:
>- * - R: vcpu->logical_id
>- * - W: vcpu->online
>- * - W: vcpu->can_offline
>- *
>- * In @vcpu-to-system direction, the following @vcpu fields are accessed:
>- * - R: vcpu->logical_id
>- * - R: vcpu->online
>- *
>- * Written members remain unmodified on error.
>- */
>-static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
>-                          char *dirpath, Error **errp)
>-{
>-    int fd;
>-    int res;
>-    int dirfd;
>-    static const char fn[] = "online";
>-
>-    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
>-    if (dirfd == -1) {
>-        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
>-        return;
>-    }
>-
>-    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
>-    if (fd == -1) {
>-        if (errno != ENOENT) {
>-            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
>-        } else if (sys2vcpu) {
>-            vcpu->online = true;
>-            vcpu->can_offline = false;
>-        } else if (!vcpu->online) {
>-            error_setg(errp, "logical processor #%" PRId64 " can't be "
>-                       "offlined", vcpu->logical_id);
>-        } /* otherwise pretend successful re-onlining */
>-    } else {
>-        unsigned char status;
>-
>-        res = pread(fd, &status, 1, 0);
>-        if (res == -1) {
>-            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
>-        } else if (res == 0) {
>-            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
>-                       fn);
>-        } else if (sys2vcpu) {
>-            vcpu->online = (status != '0');
>-            vcpu->can_offline = true;
>-        } else if (vcpu->online != (status != '0')) {
>-            status = '0' + vcpu->online;
>-            if (pwrite(fd, &status, 1, 0) == -1) {
>-                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
>-                                 fn);
>-            }
>-        } /* otherwise pretend successful re-(on|off)-lining */
>-
>-        res = close(fd);
>-        g_assert(res == 0);
>-    }
>-
>-    res = close(dirfd);
>-    g_assert(res == 0);
>-}
>-
>-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>-{
>-    GuestLogicalProcessorList *head, **tail;
>-    const char *cpu_dir = "/sys/devices/system/cpu";
>-    const gchar *line;
>-    g_autoptr(GDir) cpu_gdir = NULL;
>-    Error *local_err = NULL;
>-
>-    head = NULL;
>-    tail = &head;
>-    cpu_gdir = g_dir_open(cpu_dir, 0, NULL);
>-
>-    if (cpu_gdir == NULL) {
>-        error_setg_errno(errp, errno, "failed to list entries: %s", cpu_dir);
>-        return NULL;
>-    }
>-
>-    while (local_err == NULL && (line = g_dir_read_name(cpu_gdir)) != NULL) {
>-        GuestLogicalProcessor *vcpu;
>-        int64_t id;
>-        if (sscanf(line, "cpu%" PRId64, &id)) {
>-            g_autofree char *path = g_strdup_printf("/sys/devices/system/cpu/"
>-                                                    "cpu%" PRId64 "/", id);
>-            vcpu = g_malloc0(sizeof *vcpu);
>-            vcpu->logical_id = id;
>-            vcpu->has_can_offline = true; /* lolspeak ftw */
>-            transfer_vcpu(vcpu, true, path, &local_err);
>-            QAPI_LIST_APPEND(tail, vcpu);
>-        }
>-    }
>-
>-    if (local_err == NULL) {
>-        /* there's no guest with zero VCPUs */
>-        g_assert(head != NULL);
>-        return head;
>-    }
>-
>-    qapi_free_GuestLogicalProcessorList(head);
>-    error_propagate(errp, local_err);
>-    return NULL;
>-}
>-
>-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>-{
>-    int64_t processed;
>-    Error *local_err = NULL;
>-
>-    processed = 0;
>-    while (vcpus != NULL) {
>-        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
>-                                     vcpus->value->logical_id);
>-
>-        transfer_vcpu(vcpus->value, false, path, &local_err);
>-        g_free(path);
>-        if (local_err != NULL) {
>-            break;
>-        }
>-        ++processed;
>-        vcpus = vcpus->next;
>-    }
>-
>-    if (local_err != NULL) {
>-        if (processed == 0) {
>-            error_propagate(errp, local_err);
>-        } else {
>-            error_free(local_err);
>-        }
>-    }
>-
>-    return processed;
>-}
> #endif /* __linux__ */
> 
> #if defined(__linux__) || defined(__FreeBSD__)
>-- 
>2.45.1
>
>


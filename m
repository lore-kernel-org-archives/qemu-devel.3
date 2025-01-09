Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7274DE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvma-0008MP-2t; Thu, 09 Jan 2025 11:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvmW-0008M1-3T
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:53:16 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tVvmS-0004lc-IR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:53:14 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso1757704a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736441590; x=1737046390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFPG3vtagIjWQDrIfBWtwD87girSPnIfPZVcnJtDFaI=;
 b=EXEuHOpIsqqBSARcWzGx6fyElB7IQ8YKx15To7oppuZ9bjB5LqOIcrFrjNzzKTeoXe
 r5aN7+l84gpPV8uplYAWLCK9fc1+uFBQeFzWD8+qqJL2emQOv60zb4Hc3IpStV/obK9B
 uTE/2zmoqxE8GbS9ZAsQjNPEgOPO0NfuRTeOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736441590; x=1737046390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFPG3vtagIjWQDrIfBWtwD87girSPnIfPZVcnJtDFaI=;
 b=hvq4ebZ4vSsKKObe6PPDbD5ItOJF2xrlBYQVol14kMrpkSdtIGHMhAN2wm6fHq0DvG
 MBvahQSYGwNNjBD6wf977FfnTv6spdfYbgg6UuK9w0nQLpv2h9XW2SufAFBHh9hAMNo0
 w0ASpGV6nMOeWs9PPC0n06QLaobMcMKqb7r2GuhgCLgfqbESwwVyRuI4mf3NnLHLUbqa
 g5YC0ZaIZrEAsaDS9lyycGVok09Xtl/EIqSYB0IKGTdlz+kpCw9SsLYLaL9HaEmjAWaR
 QIZc7ijF3IYcvGBX0g4sZ9Nc+6WJoKF3gsjo9uTiriNRCFSHU+mN38sMBbImNnMg3qXL
 VECA==
X-Gm-Message-State: AOJu0YygXXEnNKqPlcvyxfay5cp97YojuF2cbOBZCLhVHNW6eRplRqLq
 88JmIDeW5s2CoY/QGku+OYSgXmt4uWr2d9lFnnhtoqWnacUpaC5p7M/LRhbJjm98MI7ogo6MGPz
 c
X-Gm-Gg: ASbGncsSRTNv3e8SEDlTes01d2Bac0imgvCopUw2H5uN/++45TW4gdvPOlLdht9fxV8
 sNG7a3BsBNA+RZq2rXsw+yNMQff4Ag9VlADdmbqWUgHq7pGQi9K9lRnsR0kgIy7/8iucuIGVV8g
 mNyNBNdYhE5yBJrHexvGyJR9xx6qKi4NLglXw+uxDx5kqnKlOt2x7wUWckv4RYRZMPoHYx2tgao
 qzIh0ppPb/b4pQdcv9CDts+VZuKXGTKdGdoUFb2Fe3H2NyZ9I2Sb0Hl/vgfZHq5MOo=
X-Google-Smtp-Source: AGHT+IEz6qx9kQS5GG0suU4+aH8afVchE/kbuaGCek4OwD21/xD8B0SAVRHHt950XLLRsbI8wiVm7A==
X-Received: by 2002:a05:6402:5254:b0:5d3:fc60:a504 with SMTP id
 4fb4d7f45d1cf-5d972e17891mr6477983a12.20.1736441589808; 
 Thu, 09 Jan 2025 08:53:09 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046d7d5sm738166a12.66.2025.01.09.08.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:53:09 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v2] xen: do not use '%ms' scanf specifier
Date: Thu,  9 Jan 2025 17:52:39 +0100
Message-ID: <20250109165239.16851-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=roger.pau@cloud.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'm' parameter used to request auto-allocation of the destination variable
is not supported on FreeBSD, and as such leads to failures to parse.

What's more, the current usage of '%ms' with xs_node_scanf() is pointless, as
it just leads to a double allocation of the same string.  Instead introduce and
use xs_node_read() to read the whole xenstore node.

Additionally fix the errors paths to not use error_prepend(), as that could
lead to a segmentation fault because xs_node_scanf() only initializes errp when
returning a value smaller than 0:

Program terminated with signal SIGSEGV, Segmentation fault.
Address not mapped to object.
    fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50)
    at ../qemu-xen-dir-remote/util/error.c:142
142         g_string_append(newmsg, (*errp)->msg);
[...]
(gdb) bt
    (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ", ap=0x15cd0165ab50) at ../qemu-xen-dir-remote/util/error.c:142
    (errp=0x15cd0165ae10, fmt=0x15c4dfeade42 "failed to read console device type: ")
    at ../qemu-xen-dir-remote/util/error.c:152
    (backend=0x43944de00660, opts=0x43944c929000, errp=0x15cd0165ae10)
    at ../qemu-xen-dir-remote/hw/char/xen_console.c:555

With the change to use xs_node_read() instead of xs_node_scanf() errp will
never be initialized, and hence error_setg() should be used unconditionally.

Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v1:
 - Introduce xs_node_read() helper.
 - Merge with errp fixes.
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org
---
 hw/char/xen_console.c           | 12 +++++++-----
 hw/xen/xen-bus-helper.c         | 12 ++++++++++++
 hw/xen/xen-bus.c                |  4 ++--
 include/hw/xen/xen-bus-helper.h |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index ef0c2912efa1..a3591df1af2e 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -550,8 +550,9 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
-        error_prepend(errp, "failed to read console device type: ");
+    type = xs_node_read(xsh, XBT_NULL, fe, "type");
+    if (!type) {
+        error_setg(errp, "failed to read console device type");
         goto fail;
     }
 
@@ -568,7 +569,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
 
     snprintf(label, sizeof(label), "xencons%ld", number);
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "output", NULL, "%ms", &output) == 1) {
+    output = xs_node_read(xsh, XBT_NULL, fe, "output");
+    if (!output) {
         /*
          * FIXME: sure we want to support implicit
          * muxed monitors here?
@@ -582,8 +584,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
     } else if (number) {
         cd = serial_hd(number);
         if (!cd) {
-            error_prepend(errp, "console: No serial device #%ld found: ",
-                          number);
+            error_setg(errp, "console: No serial device #%ld found",
+                       number);
             goto fail;
         }
     } else {
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index b2b2cc9c5d5e..115c5b1a8ce8 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -142,6 +142,18 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
     return rc;
 }
 
+char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
+                   const char *node, const char *key)
+{
+    char *path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key)
+                                     : g_strdup(key);
+    char *value = qemu_xen_xs_read(h, tid, path, NULL);
+
+    g_free(path);
+
+    return value;
+}
+
 struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,
                                     const char *key, xs_watch_fn fn,
                                     void *opaque, Error **errp)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index adfc4efad035..aaede5d9ecb2 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -156,8 +156,8 @@ again:
             !strcmp(key[i], "hotplug-status"))
             continue;
 
-        if (xs_node_scanf(xenbus->xsh, tid, path, key[i], NULL, "%ms",
-                          &val) == 1) {
+        val = xs_node_read(xenbus->xsh, tid, path, key[i]);
+        if (val) {
             qdict_put_str(opts, key[i], val);
             free(val);
         }
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
index d8dcc2f0107d..79f0787332ed 100644
--- a/include/hw/xen/xen-bus-helper.h
+++ b/include/hw/xen/xen-bus-helper.h
@@ -37,6 +37,8 @@ int xs_node_scanf(struct qemu_xs_handle *h,  xs_transaction_t tid,
                   const char *node, const char *key, Error **errp,
                   const char *fmt, ...)
     G_GNUC_SCANF(6, 7);
+char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
+                   const char *node, const char *key);
 
 /* Watch node/key unless node is empty, in which case watch key */
 struct qemu_xs_watch *xs_node_watch(struct qemu_xs_handle *h, const char *node,
-- 
2.46.0



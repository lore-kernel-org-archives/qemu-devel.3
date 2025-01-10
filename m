Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54814E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBQq-0007Lm-7B; Fri, 10 Jan 2025 04:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQo-0007L9-FB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:54 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tWBQm-00018G-OB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:35:54 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d9882a936eso3308070a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736501751; x=1737106551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fl8lgxmL+/V36LVrcdeJiI3S1Q/yOAFdboy4Zc6RdL0=;
 b=VHdekNdcMd76t64MaVNV4qBk5uOaxoR6EkRJH+F3+DE0ezWKGz0L34ErhgcKT1b0y8
 vzb3exFJ8ud8fA+fvNe0kO5J4SIYVudKmVODKHzzQZHhgz49CxURZq0Iavo6sPgh6AEu
 vZ9A3NWOFoncWC6ggt+O5OcuBcWXCY/WT8oYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736501751; x=1737106551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fl8lgxmL+/V36LVrcdeJiI3S1Q/yOAFdboy4Zc6RdL0=;
 b=Rs6KFDX0HMTWcHMMzrv8O0qZE/1xVB6wO20cylNN7/ilXYpVcwpcGkSIgjzwNuSNs4
 InxMizfXuxvg33TwnJkJna0ft2RgIXIt8P6bA8AyofgtB7wrfFMwmBL4Zp3dKlzbpEmP
 hqJ5AbQi8z+fCvIZIMjbbIUbpT9wovgk8e71QvVPcVWSqafdg509gbjDF/FKWqQBK1II
 ceKfmQ/BmgP8yk0QBRb7ix/t1ZyJMNHeXXef0qpQmTq0B4iuvKpFgB+hcviWKquKrCz3
 hxKTD7zZbBhzZWjA2/C9hKrGVRUVRWkC9CC62V6kiR5NNlzuaY6UBmfyBJfismhhgq/t
 wqhQ==
X-Gm-Message-State: AOJu0Yz9noWGcTcUR2jyeMdUAwyyWb7GoOjlsnLvhxgHqIW9Uvt1XJOE
 4e8efetqNNO+eVqxJWdmnNZiG147zh/zpu+jYzQM9UN9F87meRHX9a6AMn0IZoK/nPSaNYggVoG
 J
X-Gm-Gg: ASbGncur/ovG22zpicppiihfeavZWFTDXe/+nXzsT+XUaEVeSCP75lBrfXbdY+F/eY2
 qENBvskA4bMmQt/Z5SwJuG3llLz30UyDY9yAm9Ds2sBWBFimULu+f1MVE2LV1yamBg2o/VmBcT2
 XRkmPDQQHK9bXVJP/dXWKWW53fobWZvRHCVxzTQK4XqEGvviW1DwBDWtNli5gUsYSvNDuymKan7
 5iqoDlXPIoNOwr/9TszrPlM+3a5P61AZ0yryNVqm2WhEoxUIxX3yUDbsnToQlvgPmk=
X-Google-Smtp-Source: AGHT+IEo9mpyvl6MxMhMK3vDEIeyTCqPvEtk3ZTUCN5P4v3M5pMXiIevI2rskGgecot8tg5zTq3PXg==
X-Received: by 2002:a05:6402:50c6:b0:5d3:cfd0:8d3f with SMTP id
 4fb4d7f45d1cf-5d972e4cc1amr9661346a12.24.1736501750881; 
 Fri, 10 Jan 2025 01:35:50 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c98d6sm1406017a12.35.2025.01.10.01.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 01:35:50 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: [PATCH v2 2/2] xen: do not use '%ms' scanf specifier
Date: Fri, 10 Jan 2025 10:35:31 +0100
Message-ID: <20250110093531.23221-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250110093531.23221-1-roger.pau@citrix.com>
References: <20250110093531.23221-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=roger.pau@cloud.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
it just leads to a double allocation of the same string.  Instead use
xs_node_read() to read the whole xenstore node.

Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v2:
 - New version of xs_node_read().
 - Fix usage of %ms in xen-block.c

Changes since v1:
 - Introduce xs_node_read() helper.
 - Merge with errp fixes.
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org
Cc: qemu-block@nongnu.org
---
 hw/block/xen-block.c     |  3 ++-
 hw/char/xen_console.c    |  6 ++++--
 hw/xen/xen-bus.c         | 14 ++++++++++++--
 include/hw/xen/xen-bus.h |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 306d38927cf4..034a18b70e28 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -239,7 +239,8 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
         return;
     }
 
-    if (xen_device_frontend_scanf(xendev, "protocol", "%ms", &str) != 1) {
+    str = xen_device_frontend_read(xendev, "protocol");
+    if (!str) {
         /* x86 defaults to the 32-bit protocol even for 64-bit guests. */
         if (object_dynamic_cast(OBJECT(qdev_get_machine()), "x86-machine")) {
             protocol = BLKIF_PROTOCOL_X86_32;
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index ef0c2912efa1..989e75fef88f 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -550,7 +550,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
+    type = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "type");
+    if (!type) {
         error_prepend(errp, "failed to read console device type: ");
         goto fail;
     }
@@ -568,7 +569,8 @@ static void xen_console_device_create(XenBackendInstance *backend,
 
     snprintf(label, sizeof(label), "xencons%ld", number);
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "output", NULL, "%ms", &output) == 1) {
+    output = xs_node_read(xsh, XBT_NULL, NULL, errp, "%s/%s", fe, "output");
+    if (output) {
         /*
          * FIXME: sure we want to support implicit
          * muxed monitors here?
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index adfc4efad035..85b92cded4e2 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -156,8 +156,8 @@ again:
             !strcmp(key[i], "hotplug-status"))
             continue;
 
-        if (xs_node_scanf(xenbus->xsh, tid, path, key[i], NULL, "%ms",
-                          &val) == 1) {
+        val = xs_node_read(xenbus->xsh, tid, NULL, NULL, "%s/%s", path, key[i]);
+        if (val) {
             qdict_put_str(opts, key[i], val);
             free(val);
         }
@@ -650,6 +650,16 @@ int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
     return rc;
 }
 
+char *xen_device_frontend_read(XenDevice *xendev, const char *key)
+{
+    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
+
+    g_assert(xenbus->xsh);
+
+    return xs_node_read(xenbus->xsh, XBT_NULL, NULL, NULL, "%s/%s",
+                        xendev->frontend_path, key);;
+}
+
 static void xen_device_frontend_set_state(XenDevice *xendev,
                                           enum xenbus_state state,
                                           bool publish)
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 38d40afa3798..2adb2af83919 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -91,6 +91,7 @@ void xen_device_frontend_printf(XenDevice *xendev, const char *key,
 int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
                               const char *fmt, ...)
     G_GNUC_SCANF(3, 4);
+char *xen_device_frontend_read(XenDevice *xendev, const char *key);
 
 void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
                                    Error **errp);
-- 
2.46.0



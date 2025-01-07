Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C5FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5xT-0005Qb-O6; Tue, 07 Jan 2025 04:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xR-0005QD-Sc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:33:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1tV5xQ-0006KD-8s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:33:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso105776975e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1736242382; x=1736847182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXMJwJkD6GoreE4rq36bTo/n6oNP+S5NtP/Em4G4kUk=;
 b=H732gq64P26N8HSKGLeDVYPS1UV5KgMAF0F4RixJGJaqZp7knvxr9uH6Unxluk5NlM
 HU9xLUFB43PKx9zIHsSVqydRcOQRvyXWHICI0x/tdTX7vRuck6IPQPZAHhRsPKYZd1tM
 8//5aLAUnwgCQ3rLJrRC6Ct/04eytbeZCeOxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736242382; x=1736847182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXMJwJkD6GoreE4rq36bTo/n6oNP+S5NtP/Em4G4kUk=;
 b=EUsX/5zPom9YOYTmyshiAo/ydC2AmYeCl59cUpK/npTmOYKH5mQC1/EeXqqzjdlJJ/
 BKUqZyD6Wo31WkqJZIhton4qN7GHz2zUl4OZd6dO8cwf+REc6ov6op5jdfvuAlW+y34M
 WfeyMXIut/AtZgFcbMfPiBII7rkCAPnuYpXDEoebqRyn4ZqPos9Qys4b+6YO4XqLs7QK
 ky0wb0vZN6hNkCFIKM/TBKiKJgY4jIu8PLHJzQXtS6zRBUAz8cE+QZ7csh+/lH60XBAP
 QGabHTA/lF3Ko/q7QDHvD9WPcun1LOYy/SfD9UpTPO5QG6Y7lTlOn07MhJTHABlnN5w/
 /YJg==
X-Gm-Message-State: AOJu0YyX/4O7jXbKF2mCiplIgICEwfalLgQXk3VewYGi1VWA5dx3xJwy
 eXoIoP9y//4iUJ8CLvDzVG0XMjWuvsJQ6fU/4Jhh2C9hKHokvWZ04yY7GvpGAPTgQt0vkbMK3G4
 R
X-Gm-Gg: ASbGncs/e0ev78k3W4og7n+1o8JdjUuqY6vYMfEg1qFtD9HiRbLpuPQ8/xexXPVjmlU
 PK9RmJJQH6v5uDqgFpdmpjK57H2BOn0iI74yr1kzH1cDNLFXkupaGVbtUJh4MivSIP+gWVOi3Sb
 f6YUwtP3Q5arcvhj2Bcl0z32KGr1FYYG3jafT8yZi9PCz4Ca6nUshnAIpvMK0aj8rZ1XMT2Od+8
 mn4l/2h9ZCHI6y5IXrL6BVQNz+9r2o6HFPLtMG0SqY1aHigqaZ82/hYC23JVQ==
X-Google-Smtp-Source: AGHT+IEix0l+GrmL6GlNsHgpdBKlhdge3KcJsVrThXIBxIDP7VrUAOxyB//Zy8/3JjeQgqN+VJe5zw==
X-Received: by 2002:a05:6000:4012:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38a221fa6bamr42191038f8f.13.1736242382216; 
 Tue, 07 Jan 2025 01:33:02 -0800 (PST)
Received: from localhost ([84.78.159.3]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6abesm49900025f8f.90.2025.01.07.01.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:33:01 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: qemu-devel@nongnu.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] xen: do not use '%ms' scanf specifier
Date: Tue,  7 Jan 2025 10:31:40 +0100
Message-ID: <20250107093140.86180-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250107093140.86180-1-roger.pau@citrix.com>
References: <20250107093140.86180-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=roger.pau@cloud.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.179, RCVD_IN_DNSWL_NONE=-0.0001,
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
it just leads to a double allocation of the same string.  Instead use
qemu_xen_xs_read() to read the whole xenstore node.

Fixes: a783f8ad4ec9 ('xen: add a mechanism to automatically create XenDevice-s...')
Fixes: 9b7737469080 ('hw/xen: update Xen console to XenDevice model')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org
---
 hw/char/xen_console.c | 11 +++++++++--
 hw/xen/xen-bus.c      |  7 +++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index af706c7ef440..18afd214c2f6 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -531,6 +531,7 @@ static void xen_console_device_create(XenBackendInstance *backend,
     const char *name = xen_backend_get_name(backend);
     unsigned long number;
     char *fe = NULL, *type = NULL, *output = NULL;
+    const char *node_path;
     char label[32];
     XenDevice *xendev = NULL;
     XenConsole *con;
@@ -550,7 +551,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
         goto fail;
     }
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
+    node_path = g_strdup_printf("%s/type", fe);
+    type = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
+    g_free(node_path);
+    if (!type) {
         error_setg(errp, "failed to read console device type: ");
         goto fail;
     }
@@ -568,7 +572,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
 
     snprintf(label, sizeof(label), "xencons%ld", number);
 
-    if (xs_node_scanf(xsh, XBT_NULL, fe, "output", NULL, "%ms", &output) == 1) {
+    node_path = g_strdup_printf("%s/output", fe);
+    output = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
+    g_free(node_path);
+    if (!output) {
         /*
          * FIXME: sure we want to support implicit
          * muxed monitors here?
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index adfc4efad035..9be807649e77 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -142,6 +142,7 @@ again:
 
     opts = qdict_new();
     for (i = 0; i < n; i++) {
+        const char *node_path;
         char *val;
 
         /*
@@ -156,8 +157,10 @@ again:
             !strcmp(key[i], "hotplug-status"))
             continue;
 
-        if (xs_node_scanf(xenbus->xsh, tid, path, key[i], NULL, "%ms",
-                          &val) == 1) {
+        node_path = g_strdup_printf("%s/%s", path, key[i]);
+        val = qemu_xen_xs_read(xenbus->xsh, tid, node_path, NULL);
+        g_free(node_path);
+        if (val) {
             qdict_put_str(opts, key[i], val);
             free(val);
         }
-- 
2.46.0



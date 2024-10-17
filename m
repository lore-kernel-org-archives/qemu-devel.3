Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E7D3C533
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 21:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1YQv-0003W7-LA; Thu, 17 Oct 2024 17:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SYcRZwYKCtwPMOSCFEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--roqueh.bounces.google.com>)
 id 1t1YQn-0003VN-1Q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:18 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SYcRZwYKCtwPMOSCFEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--roqueh.bounces.google.com>)
 id 1t1YQl-0006nf-C5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:16 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e3c638cc27so28131387b3.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729201993; x=1729806793; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=t8McOsxV8sRtUClZQ3Bo3BJecAGF4zLurNe2HC/luCE=;
 b=LpeLxMwHqtvfmGcJhDKyqWMzE+Eobu4JxHsxlQj4Rw89VrBL8cEC2B2XJKsS19ak8e
 L43OQfQM3KAeqzYpAgH2VfHQYCiFGwSXLiw0NcJDeOwHAbEwWazo54YdZpvHc8NdS9A6
 +nTQ8Y0UgqNYLfOP4xzjO2BgLxaY38sQPO/RXvVVG4xH7Id3uyRQpdx/162jGQUbW7UM
 SjBTEaby1hBnkLYh7Ss4QzTDPQzkgPpr3EEiQM0DbNDZ1wxUgzGRZ0b7QPI9xvGNSXwJ
 74GhHWt0rqUDBZFvg2TWUoW7mvGcR3Mgcs+Mm04ofHOf1vWQGsWiJljnqP17yEqs1HBI
 Cy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729201993; x=1729806793;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8McOsxV8sRtUClZQ3Bo3BJecAGF4zLurNe2HC/luCE=;
 b=UH5Efz/2Bwjxbv7QGgfGv6h+p+A2nFYvwcz+3C1YRysYqd+ROoxcmWryaEU5K3pWuy
 AAGAgrsxhIf8DAhIrl6uQKRvYSbiLCy2H/ODMxhNMnmoq6p/hs0s7Kvw5OlBGvANlK3x
 AoLuZ/83bjcOxZ4ODeuB2D4i3+CBzAXOJu2DUteVKBol/iOCey87iyJBlXPEHjYIBfoG
 fvN68pIdNQG1VH5UNNTVN9DFHqvBjV+dLXQiWZVUKlkj8SG8NgugQJEWaKTXlgk67mjx
 bTQM/WScklyZBVFT6zQSm9csKsmoq6Dbv9ZK+ZDBRtlowLa7O2U9SXj2UbccvH/sOuNG
 n+5A==
X-Gm-Message-State: AOJu0YzB6Ndf1wUiEBNjbCGLyc/lPgIKLaOMEu3PrpmUYrbWtDSZDEUJ
 V1USjeIM7PK9zVCfJx6RWd9hhp/nl9B/eQsWZlwq1CzD2N24khrZPZjUhXbLcuxsZcsjUKfM7Lh
 O1w==
X-Google-Smtp-Source: AGHT+IF86U4cnv6PrISgfx/+cC5cxTkqq3TUF3Bg19FTIE/hsZXiSmPdvoobo05dQd1sj/RLsM+og2rg1Ro=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:690c:2e90:b0:6e3:1627:e866
 with SMTP id
 00721157ae682-6e5bfbd836bmr38237b3.3.1729201993186; Thu, 17 Oct 2024 14:53:13
 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:53:03 +0000
In-Reply-To: <20241017215304.3916866-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017215304.3916866-2-roqueh@google.com>
Subject: [PATCH 1/2] ui: Allow injection of vnc display name
From: Roque Arcudia Hernandez <roqueh@google.com>
To: ankeesler@google.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, venture@google.com, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3SYcRZwYKCtwPMOSCFEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Andrew Keesler <ankeesler@google.com>

Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identification
Data) is propagated by QEMU such that a virtual display presents legitimate
metadata (e.g., name, serial number, preferred resolutions, etc.) to its
connected guest.

This change propagates an optional user-provided display name to
QemuConsole. Future changes will update downstream devices to leverage this
display name for various uses, the primary one being providing a custom EDID
name to guests. Future changes will also update other displays (e.g., spice)
with a similar option to propagate a display name to downstream devices.

Currently, every virtio-gpu virtual display has the same name: "QEMU
Monitor". We hope to be able to inject the EDID name of virtual displays in
order to test guest behavior that is specific to display names. We provide the
ability to inject the display name from the display configuration as that most
closely resembles how real displays work (hardware displays contain static EDID
information that is provided to every connected host).

It should also be noted that EDID names longer than 12 bytes will be truncated
per spec (I think?).

Signed-off-by: Andrew Keesler <ankeesler@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 include/ui/console.h | 1 +
 ui/console-priv.h    | 1 +
 ui/console.c         | 8 ++++++++
 ui/vnc.c             | 8 +++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 5832d52a8a..74ab03ed72 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -408,6 +408,7 @@ int qemu_console_get_index(QemuConsole *con);
 uint32_t qemu_console_get_head(QemuConsole *con);
 int qemu_console_get_width(QemuConsole *con, int fallback);
 int qemu_console_get_height(QemuConsole *con, int fallback);
+void qemu_console_set_name(QemuConsole *con, const char *name);
 /* Return the low-level window id for the console */
 int qemu_console_get_window_id(QemuConsole *con);
 /* Set the low-level window id for the console */
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 43ceb8122f..9f2769843f 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -18,6 +18,7 @@ struct QemuConsole {
     Object parent;
 
     int index;
+    const char *name;
     DisplayState *ds;
     DisplaySurface *surface;
     DisplayScanout scanout;
diff --git a/ui/console.c b/ui/console.c
index 5165f17125..f377fd8417 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1452,6 +1452,14 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
+void qemu_console_set_name(QemuConsole *con, const char *name)
+{
+    if (con == NULL) {
+        return;
+    }
+    con->name = name;
+}
+
 int qemu_invalidate_text_consoles(void)
 {
     QemuConsole *s;
diff --git a/ui/vnc.c b/ui/vnc.c
index 93a8dbd253..7d6acc5c2e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "power-control",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "name",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **errp)
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
     g_autoptr(SocketAddressList) saddr_list = NULL;
     g_autoptr(SocketAddressList) wsaddr_list = NULL;
-    const char *share, *device_id;
+    const char *share, *device_id, *name;
     QemuConsole *con;
     bool password = false;
     bool reverse = false;
@@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **errp)
     }
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
+    name = qemu_opt_get(opts, "name");
+    qemu_console_set_name(vd->dcl.con, name);
+
     if (saddr_list == NULL) {
         return;
     }
-- 
2.47.0.rc1.288.g06298d1525-goog



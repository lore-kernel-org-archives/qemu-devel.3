Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B357DCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PP9-00009U-0A; Thu, 16 Oct 2025 10:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9PP7-00009I-Ur
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v9PP3-0008Tr-GG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760626584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bKRAus6HdVcn682X1+0P7SmXTLcO6cGl1ErIELft2Ds=;
 b=dJvcGwOOTsWAYwfdK6LazfXEmmXLR64ASs1SXsyiyXsb2BXmLP1Ss3Nj67jnDHCG7lrDTH
 XPxlZXNy2cJYHvSdqL/4cS/Mk3vRxStO0dyNdqmoIsx0LJqz4Fa11iqLg/ROyK3QD5v92W
 MBXj4u/pdoWZiQzPAyyF3g4ku2KUCnY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-rc568c4wMk-PUw5psihbKg-1; Thu, 16 Oct 2025 10:56:23 -0400
X-MC-Unique: rc568c4wMk-PUw5psihbKg-1
X-Mimecast-MFC-AGG-ID: rc568c4wMk-PUw5psihbKg_1760626582
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso752560f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760626582; x=1761231382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKRAus6HdVcn682X1+0P7SmXTLcO6cGl1ErIELft2Ds=;
 b=B2qg+h7rlno5Nc9AmHWwpPBFmyxMJVmguQ8lMNM5OA2MhYAg7iMpZpPpn5AvIUjiMT
 zA+GkAWuCM5mM3A/HSleragsE65RO6G/sE7yPldE/GKxV/v3e6IQKl9iXjCI7QoSPWZN
 1a1WD8K+UU6p2KXwsQvGHWIXr5Y7ZiidJgMlnPLvZP+i2xFlI62rgMJMko/gCtt68GKS
 D9nxOKLCB5H8cqY1feuhEebBx+m32RtVX2JSpFy+6M52ukTGH02pzZ89QtHWWdF+m4pI
 yFeliVKz9ji8CuTux7PHW3s/WwyG0JyPu753+0VQL6AAzRY5/V3LjSMQa6qjVJxrOijN
 2JDw==
X-Gm-Message-State: AOJu0YyExhWTJIBKL1M++gJtFIL/XAydrbq41+MZLPfg6fNLAlaXSnsk
 qGYrII4ffsUOi4PhivIdU+X0cSSxn/SdTSVOLn3GtdWVdQ4UaYQCKkztB1u4cKM58kBdnxOL0Zx
 bQIU60Nj3ZJ17oEhON/xxQN2sMqv44fjwCeQ2Mtcm7WOU663r8bPHNxVFXknbXoShABlwooVKsk
 Zbm9nLusR0v83N4P3zx22Ei+EXNH5+vZqyXkj5SXF8
X-Gm-Gg: ASbGncsrfdoAJiz1nW3hnRmG4VKUG3m7MEDStxv1At11f+4ogKz2ZuGnf3aMzGe+Yey
 9uyW7BI2UhsPs7IgV5RUySPTLhMLgMkkP0HaF7q5Ksn+gz+M1JUPrIkyuRzMfTMnOjFYdn7O++6
 r9a5ex5Yzc8NKUuPdtKjruN/fJn0TZoMwz7K12AkFmlbDAmMHaPhkD5no5plTfk9vx7xFAcaC/c
 wM2b4y6duWDMReL0/uM/iFSZJl8Ajq9Oiz9ApeHJG3YkRnW5hVSy/WeEotWuvzWyJq+S8Omd1vg
 PguQiUs4eOfxU0vrfNBRVAroUhzpcdtMB6lKDucYeoTmP9P3CzJqbDiFjbdYo/7ESh3dxnqDg54
 OcaFS/r/nbfO/pcr3RbvHa57DbGgWAutdtT56lnP36Kwlw9jgqTr3JxNNqVk+HBrbExzQMU24hl
 0=
X-Received: by 2002:a05:6000:2888:b0:427:2e8:fe53 with SMTP id
 ffacd0b85a97d-42704d7eac3mr294268f8f.6.1760626581653; 
 Thu, 16 Oct 2025 07:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnkNkx4gaoII/mtiHK6Q2V5m2qzQcfNwpWbBojpz75vSrsXpsXCqXBKm1vSpXxRfmrcCkYvA==
X-Received: by 2002:a05:6000:2888:b0:427:2e8:fe53 with SMTP id
 ffacd0b85a97d-42704d7eac3mr294246f8f.6.1760626581155; 
 Thu, 16 Oct 2025 07:56:21 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114460fe1sm33868415e9.17.2025.10.16.07.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 07:56:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH] rust: remove useless glib_sys bindings
Date: Thu, 16 Oct 2025 16:56:19 +0200
Message-ID: <20251016145619.1324585-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

The definition of types needed for g_autolist(), g_autoslist(),
g_autoqueue() need the imports for GList, GSList and GQueue
to appear everything.  Rust code is never going to see those,
since they are not used in structs.  Block the types from
appearing in the bindings.

Co-authored-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                        | 1 +
 rust/bql/src/bindings.rs           | 2 +-
 rust/chardev/src/bindings.rs       | 4 ++--
 rust/hw/char/pl011/src/bindings.rs | 2 +-
 rust/hw/core/src/bindings.rs       | 2 +-
 rust/migration/src/bindings.rs     | 2 +-
 rust/qom/src/bindings.rs           | 2 +-
 rust/system/src/bindings.rs        | 2 +-
 rust/util/src/bindings.rs          | 2 +-
 9 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 25813490d22..6cb85b173d0 100644
--- a/meson.build
+++ b/meson.build
@@ -4255,6 +4255,7 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/include/.*',
     '--allowlist-file', meson.project_build_root() + '/.*',
     '--blocklist-file', glib_pc.get_variable('includedir') + '/glib-2.0/.*',
+    '--blocklist-type', '.*_([a-z]*autoptr)$',
     ]
   if not rustfmt.found()
     if bindgen.version().version_compare('<0.65.0')
diff --git a/rust/bql/src/bindings.rs b/rust/bql/src/bindings.rs
index 8c70f3a87ce..efd76790fb2 100644
--- a/rust/bql/src/bindings.rs
+++ b/rust/bql/src/bindings.rs
@@ -19,7 +19,7 @@
 )]
 
 use glib_sys::{
-    guint, GArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue, GSList, GSource,
+    guint, GArray, GHashTable, GHashTableIter, GPollFD, GPtrArray, GSList, GSource,
 };
 
 #[cfg(MESON)]
diff --git a/rust/chardev/src/bindings.rs b/rust/chardev/src/bindings.rs
index c95dc89c56d..6447c72b7e3 100644
--- a/rust/chardev/src/bindings.rs
+++ b/rust/chardev/src/bindings.rs
@@ -20,8 +20,8 @@
 
 use common::Zeroable;
 use glib_sys::{
-    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GList, GMainContext,
-    GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc,
+    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GMainContext,
+    GPollFD, GPtrArray, GSList, GSource, GSourceFunc,
 };
 
 #[cfg(MESON)]
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
index 52a76d0de5c..654be9185b1 100644
--- a/rust/hw/char/pl011/src/bindings.rs
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -22,7 +22,7 @@
 
 use glib_sys::{
     gboolean, guint, GArray, GByteArray, GHashTable, GHashTableIter, GIOCondition, GList,
-    GMainContext, GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc, GString,
+    GMainContext, GPollFD, GPtrArray, GSList, GSource, GSourceFunc, GString,
 };
 
 #[cfg(MESON)]
diff --git a/rust/hw/core/src/bindings.rs b/rust/hw/core/src/bindings.rs
index 65b9aae7536..dd334944600 100644
--- a/rust/hw/core/src/bindings.rs
+++ b/rust/hw/core/src/bindings.rs
@@ -21,7 +21,7 @@
 use chardev::bindings::Chardev;
 use common::Zeroable;
 use glib_sys::{
-    GArray, GByteArray, GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList, GString,
+    GArray, GByteArray, GHashTable, GHashTableIter, GList, GPtrArray, GSList, GString,
 };
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
diff --git a/rust/migration/src/bindings.rs b/rust/migration/src/bindings.rs
index 24503eb69bd..e9c058386c2 100644
--- a/rust/migration/src/bindings.rs
+++ b/rust/migration/src/bindings.rs
@@ -19,7 +19,7 @@
 )]
 
 use common::Zeroable;
-use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
+use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/qom/src/bindings.rs b/rust/qom/src/bindings.rs
index 91de42f2426..e61259ec2ef 100644
--- a/rust/qom/src/bindings.rs
+++ b/rust/qom/src/bindings.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
+use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/system/src/bindings.rs b/rust/system/src/bindings.rs
index 6cbb588de3d..2a5ba43c4f1 100644
--- a/rust/system/src/bindings.rs
+++ b/rust/system/src/bindings.rs
@@ -20,7 +20,7 @@
 
 use common::Zeroable;
 use glib_sys::{
-    guint, GArray, GByteArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue,
+    guint, GArray, GByteArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray,
     GSList, GString,
 };
 
diff --git a/rust/util/src/bindings.rs b/rust/util/src/bindings.rs
index c277a295add..3514a66f5fa 100644
--- a/rust/util/src/bindings.rs
+++ b/rust/util/src/bindings.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{guint, GList, GPollFD, GQueue, GSList, GString};
+use glib_sys::{guint, GPollFD, GString};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6894FC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXeb-0005xn-NP; Fri, 24 May 2024 12:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXea-0005wq-5Y
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeY-0006xs-82
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T19z2VhLiDxwW2xj7PM4ylgGCJRFuMIgK7muAk4JXtI=;
 b=Y9xkXRl4kVv9+0SdOgvVgMZp1LJmoXs5kF0vYtePoWJRWJhszYjAiVgiu7nXqwCWoTVpDm
 qUROygjakqBZSAHlq4TR3lEPNkS2r0VE1KbEfLoXK9MrefVAzb5Yv6fGrp+mdc59c6XJjy
 1ggksA4QrBltjY84To9Ylv+4HGf0KFk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-6fOOeuNVPi-FBENPdMDkJg-1; Fri, 24 May 2024 12:20:20 -0400
X-MC-Unique: 6fOOeuNVPi-FBENPdMDkJg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5785ef2b57aso453378a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567618; x=1717172418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T19z2VhLiDxwW2xj7PM4ylgGCJRFuMIgK7muAk4JXtI=;
 b=bt0edpmFLnrAGJsaW/y8cHWFaaVdn7vLJL6Q/2p3nk7oE2m6eU2VhHrJzoKUeU2QfZ
 qZzIYmOBdHH+EL0F1YsxYYZVQaAirBM5asu+/WXnNNbELz7DQ0wwEbFWI6tI0qo9sY+4
 H8CkHJtuAqcpMKyzfHa+4o6aUIDl2G4CJXO40kPxgpgE0vygWmZbk+Uzq3KOxBNFu9a+
 5KqQd1mFPDd2ohEJHN9oeNxpD86eWNdwBCVajRbMmRLD94Xu+YJZlbEkrL2Jut19GLCj
 GD2pms5f0RgD0ZvqEaI1ZSm1XgUg1dgIikMz2kfDtngZVfyWWS5SLpopSLod7BAgsI+W
 OskA==
X-Gm-Message-State: AOJu0YysKGr75PwwH8RE2zjPspH66/5TK8QtFvJKzmO0fmyfNqvWpLff
 twlaM55JO9Ls61G+wu9GQwF8t8/gjjmZHTAlJMSHJhtvLobZa8N6j90rvYn5ITOi449UOpWj8aW
 bF4KPJsCTJEO1gksDtAKEYi1ghsvMZhmjmkCPY1nYLxPtiG9jvQsrPXzAORGVINxt4MsWBXPX1L
 TD9ZWOsT8bIrRt5VjO3+8/ftC7H7W7zSpc8lYg
X-Received: by 2002:a50:cd9d:0:b0:574:ffb1:eb52 with SMTP id
 4fb4d7f45d1cf-578519c2f4bmr1890066a12.34.1716567618565; 
 Fri, 24 May 2024 09:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1pRnOtoHrr+W35yt+VdNT6KX0JJUXAviYnbk2HjkBrALMIiXvUAhkLfepmP3rNAMTYT9lXQ==
X-Received: by 2002:a50:cd9d:0:b0:574:ffb1:eb52 with SMTP id
 4fb4d7f45d1cf-578519c2f4bmr1890046a12.34.1716567618080; 
 Fri, 24 May 2024 09:20:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524b9e80sm1904834a12.85.2024.05.24.09.20.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] migration: remove unnecessary zlib dependency
Date: Fri, 24 May 2024 18:20:05 +0200
Message-ID: <20240524162006.1271778-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524162006.1271778-1-pbonzini@redhat.com>
References: <20240524162006.1271778-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

zlib code is only used by the emulators, not by the tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           | 2 +-
 migration/dirtyrate.c | 1 -
 migration/qemu-file.c | 1 -
 migration/meson.build | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 7fd82b5f48c..63866071445 100644
--- a/meson.build
+++ b/meson.build
@@ -3696,7 +3696,7 @@ libmigration = static_library('migration', sources: migration_files + genh,
                               name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(link_with: libmigration,
-                               dependencies: [zlib, qom, io])
+                               dependencies: [qom, io])
 system_ss.add(migration)
 
 block_ss = block_ss.apply({})
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index d02d70b7b4b..1d9db812990 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include <zlib.h>
 #include "hw/core/cpu.h"
 #include "qapi/error.h"
 #include "exec/ramblock.h"
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9ccbbb00991..b6d2f588bd7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include <zlib.h>
 #include "qemu/madvise.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
diff --git a/migration/meson.build b/migration/meson.build
index 8815f808374..bdc3244bce0 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -29,7 +29,7 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
   'threadinfo.c',
-), gnutls)
+), gnutls, zlib)
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c'))
-- 
2.45.1



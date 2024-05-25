Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E509AC25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfv-0003gV-Eb; Sat, 25 May 2024 07:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfr-0003cz-2F
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfm-0004CX-Aj
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T19z2VhLiDxwW2xj7PM4ylgGCJRFuMIgK7muAk4JXtI=;
 b=M4mOb56ck9Hm53ie48aQAzgP8zOl0XbE00b0d+xfofPG0mNA+42Nr6h4bp7N/81Ts/m+A/
 qV9pQmjskAtEuzZpYP46vth2mcbrL8493avUctzTTPZWxt1kOWyI3fw7fdzmEtrIMqNezW
 wnWvHXIHVgbzQ4pWGVRLxk57hPeH0kI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-fagN3y3MMlmgdMHRTdfSjQ-1; Sat, 25 May 2024 07:34:47 -0400
X-MC-Unique: fagN3y3MMlmgdMHRTdfSjQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266ffd474so90899766b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636885; x=1717241685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T19z2VhLiDxwW2xj7PM4ylgGCJRFuMIgK7muAk4JXtI=;
 b=bmrq3ESKl1hyuxBXSCHpxDKOVeCyW/k4dc0VWQeLFZua1PiMax3f8opzOawdJ1dz79
 6OYJTV9bjozM3n30oOkiMQHEFVRFrdU8GggCaBZoBf6i7GZchy9ULeEt+Rhm8eWoAAwl
 zp3/R6+G4WaxTZ8N2+dAg9peaiDvn41b8+tdOBMfEbIms9+Hdh92T/SPRCXesVH9cdB8
 F+xw/LGbmuxswYM8Liy8Yb9BtOc9NYPZf6HAz5XVTP9qtY3Bt+79MkpHpqzFqYpvVsG/
 DFf3dOydauhuLzK9pdejMkGWsUMjTz8rqkzC+CoKyw75GRzpRrSoPyMCThkd4gj0NfmC
 cEfg==
X-Gm-Message-State: AOJu0Ywg7xuhZAmBf2O2iE/rjta3KXAc+sO2OthePRGdz581S1Z8Dxtw
 JVm3l5UAId6hfpNhLxouR6oddPhrGOi0uzyQkhyXdrEq7v9g9ZdePkTzrkxGKbcW0a8V1PLhngq
 6O7f5/vJbRrjzcQL+Gwc2KxpEOxHnyA5GrOT9yBuZWGn3v3/TwOctySRb23E7JcxWmLkt0VewQ5
 FsOAseXA/YK+9FVqcVM8bmh7EssZxs/8zE3P7Z
X-Received: by 2002:a17:906:2c08:b0:a5c:eafb:5288 with SMTP id
 a640c23a62f3a-a62642e9bbbmr431354366b.31.1716636885706; 
 Sat, 25 May 2024 04:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7fPKZDp/MVdId72OJeLxvV6HE42v/Sn/U3l+BFTLyY+fZCtj5BZ3sDS5SNNc3i0OavMZ0Ng==
X-Received: by 2002:a17:906:2c08:b0:a5c:eafb:5288 with SMTP id
 a640c23a62f3a-a62642e9bbbmr431353066b.31.1716636885191; 
 Sat, 25 May 2024 04:34:45 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817b15sm245047266b.40.2024.05.25.04.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] migration: remove unnecessary zlib dependency
Date: Sat, 25 May 2024 13:33:32 +0200
Message-ID: <20240525113332.1404158-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



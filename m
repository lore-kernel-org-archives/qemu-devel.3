Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53864D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1o30-0004ia-QX; Fri, 18 Oct 2024 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1o2y-0004i9-0M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1o2w-0001MT-Kg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXY4HeNtNCoNwBLNYYC6dOuG7QKVObv/0K7b9ch69dQ=;
 b=h6+YDu0+ygQFk8NFnWnz7V3A5IwjiSJeJL1xD3rbE31TVmAH32VIKNarwVgia6mFVJGnZL
 5xCXZmTw3O29nK+wxUqYwWP4k1dLQBxwYvuRUPyfCbsypwsrRB5Twj5Doi2MdGRTC2lNsX
 8I5jVbrtRuFT5JTQoKYNdZ90Yocnb8g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-CBsPzoSwOW6-ZmjPYOQMWQ-1; Fri, 18 Oct 2024 10:33:40 -0400
X-MC-Unique: CBsPzoSwOW6-ZmjPYOQMWQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d52ccc50eso1083207f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262019; x=1729866819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wXY4HeNtNCoNwBLNYYC6dOuG7QKVObv/0K7b9ch69dQ=;
 b=wjN8g19M008j7pcEVq15lz8suXwElbJP7DW5z4W5iSTZ4c/LJicoaIqo3A6DTDmd5J
 ddysILLnKdNYOnMjZ/ppiB6Dm5WTPic+2uPkj7FTPVq9xV8oR0vT8flnm2YgPKgd1utH
 xL0Q+lz05kri/KtP7SdbHomG6OcFW/1hnhkBC/+3MKN3Nh2DVj4iuPc+tlw64t2LNY3N
 GropLufz/lG3jzXznnWx7D4S8w6y9D69Ptm2U7aIk8UzgKAJzO5wxbopLCWAhfT8zIlg
 LH72xycI5sypN6mITyoNwAivwyh52qFl+9bmrT6Jz2duRwGKel8YYJ0jUHXXHGwobIHU
 diaw==
X-Gm-Message-State: AOJu0Yy3KP5QB8u767pKjtRzjASttxqIM93lUA8NlkjhYp+pwO+Z4c0P
 S3YZi1QXUoOH/HoJM1ExGpwhpoMsKzkvW9+qkJaCmld8HzEgMBxCnXmeFGQVhAr+m53cetmEDCA
 kCTsR1oriOt7Lj3j/iKHyvoB2Dr7dRE/JoNWJ6HDwbt8GhrhoxeOa7ytfvBPnWSYFbP38Iq4dI2
 2xsOwA3ZsTwor2L8JfJmv3fbdMEyVieBZqK9sjjI0=
X-Received: by 2002:adf:e703:0:b0:37d:5496:290c with SMTP id
 ffacd0b85a97d-37eab729a12mr1709039f8f.7.1729262018633; 
 Fri, 18 Oct 2024 07:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2/lsAcfsKhF4s+5KwGs3b7axOmwmzxPjI9zxjmTGu66PbmDcsuYQORNANmHateNnuL/BmdA==
X-Received: by 2002:adf:e703:0:b0:37d:5496:290c with SMTP id
 ffacd0b85a97d-37eab729a12mr1709017f8f.7.1729262018070; 
 Fri, 18 Oct 2024 07:33:38 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160e44445sm25479925e9.36.2024.10.18.07.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:33:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] stubs: remove stubs/qdev.c
Date: Fri, 18 Oct 2024 16:33:33 +0200
Message-ID: <20241018143334.949045-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

qapi_event_send_device_deleted is always included (together
with the rest of QAPI) in libqemuutil.a, so it is unnecessary
to include a stub for it.

This avoids a duplicate symbol in libqemuutil.a, which in
principle could result in missing events on the monitor.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/qdev.c      | 22 ----------------------
 stubs/meson.build |  1 -
 2 files changed, 23 deletions(-)
 delete mode 100644 stubs/qdev.c

diff --git a/stubs/qdev.c b/stubs/qdev.c
deleted file mode 100644
index 7e957b3e524..00000000000
--- a/stubs/qdev.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * QOM stubs
- *
- * Copyright (c) 2021 Red Hat, Inc.
- *
- * Author:
- *   Philippe Mathieu-Daudé <philmd@redhat.com>
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/qapi-events-qdev.h"
-
-void qapi_event_send_device_deleted(const char *device,
-                                    const char *path)
-{
-    /* Nothing to do. */
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 772a3e817df..64b7263dde2 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,7 +55,6 @@ endif
 if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
-  stub_ss.add(files('qdev.c'))
 endif
 
 if have_system
-- 
2.46.2



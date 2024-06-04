Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE73C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUhP-0006G7-OS; Tue, 04 Jun 2024 09:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEUhP-0006Fe-3m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sEUhN-0006jF-L7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pp691IpB1NZf075oTcVuBj9U4ExLmOj+fJ5FCO2R0yk=;
 b=T20QfRsKp695zRGZf5Plire6XK63xixONH7ZloG+SJtwWJyaB26o6wxcXh7q+cms4aTOUg
 NPhapkQ8TvQSUL8rBSDnB+NLkQOzJiAmK8FgPUxPxH4cSd73Om3uV6DGkwmYhiIkfjhMJ6
 1ZAA6x+Tf3lgrXnGi6NUhBEJtO65hOM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-kqGb5N_XPeGUGF7IKo9J9g-1; Tue, 04 Jun 2024 09:59:35 -0400
X-MC-Unique: kqGb5N_XPeGUGF7IKo9J9g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e95a1fae88so44741891fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509573; x=1718114373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pp691IpB1NZf075oTcVuBj9U4ExLmOj+fJ5FCO2R0yk=;
 b=grGa+WPGU12qPXhJ6Pop2UJVcF4p6kmDUYvzWC+e5y5NShZL8jVTiUr5jvJMXma2r/
 KC9GjR3APOAGgjCMOxmS0NDt6nsnxbKgE0D8lNKximw6tnvY7rvj7gju21sRKENv6b3V
 /dPYk18cUPbmIUlulnlNnStPH8YP7p4hLvQWliX0ttfJZktntNvBnpksSCAssHGi86NR
 AIrfPKBsBv7EdLeGQU63zFTv9zoP7rlsKNJeWwS2L7Kfqj1vCJxx9YSzZUojdMndpX87
 nhP8KGn9XfbDXKRWSegrCGqhXot8G0DIZOKxG96fErVAeMamS5se/+uxq3Ugle+j3kAA
 Bn5A==
X-Gm-Message-State: AOJu0Yx7oiqANThC3zIYGb6D3rV3M0STWWCO6NfEmJWtjTEnKLQPDm7f
 mExyfwgXdNlFgoMoTikMUf37Tcu/VWw+X9m1tWOJh6Dz5K7cXZMeNOgJ65H+MrDaPWZ+60DjjNY
 KchQ/3+lZmRPdaC0lqv70hyOoG9vBOKJxmSa0EW0jBvyK1qaCoJGFqEr2RgI8lL9JEe+oLS/g4N
 nnxA6od7A0zaDJzTeczAWOF9gaAWbhuAg2An35
X-Received: by 2002:a2e:9c0f:0:b0:2de:cc70:2552 with SMTP id
 38308e7fff4ca-2ea950c80a7mr82498031fa.10.1717509573600; 
 Tue, 04 Jun 2024 06:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE945ScHyZG+oe9M/Px99v4OVCfwQ1Q/v0qLdS8Wr8sqJV1AsnSIc6E4JPhnan5scQlalVmhQ==
X-Received: by 2002:a2e:9c0f:0:b0:2de:cc70:2552 with SMTP id
 38308e7fff4ca-2ea950c80a7mr82497801fa.10.1717509573122; 
 Tue, 04 Jun 2024 06:59:33 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-171.retail.telecomitalia.it.
 [82.53.134.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838acdsm157331155e9.4.2024.06.04.06.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 06:59:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] qapi/qom: make some QOM properties depend on the build
 settings
Date: Tue,  4 Jun 2024 15:59:31 +0200
Message-ID: <20240604135931.311709-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some QOM properties are associated with ObjectTypes that already
depend on CONFIG_* switches. So to avoid generating dead code,
let's also make the definition of those properties dependent on
the corresponding CONFIG_*.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 qapi/qom.json | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..ae93313a60 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -222,7 +222,8 @@
 ##
 { 'struct': 'CanHostSocketcanProperties',
   'data': { 'if': 'str',
-            'canbus': 'str' } }
+            'canbus': 'str' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @ColoCompareProperties:
@@ -305,7 +306,8 @@
 ##
 { 'struct': 'CryptodevVhostUserProperties',
   'base': 'CryptodevBackendProperties',
-  'data': { 'chardev': 'str' } }
+  'data': { 'chardev': 'str' },
+  'if': 'CONFIG_VHOST_CRYPTO' }
 
 ##
 # @DBusVMStateProperties:
@@ -514,7 +516,8 @@
   'data': { 'evdev': 'str',
             '*grab_all': 'bool',
             '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' } }
+            '*grab-toggle': 'GrabToggleKeys' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @EventLoopBaseProperties:
@@ -719,7 +722,8 @@
   'base': 'MemoryBackendProperties',
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
-            '*seal': 'bool' } }
+            '*seal': 'bool' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @MemoryBackendEpcProperties:
@@ -736,7 +740,8 @@
 ##
 { 'struct': 'MemoryBackendEpcProperties',
   'base': 'MemoryBackendProperties',
-  'data': {} }
+  'data': {},
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @PrManagerHelperProperties:
@@ -749,7 +754,8 @@
 # Since: 2.11
 ##
 { 'struct': 'PrManagerHelperProperties',
-  'data': { 'path': 'str' } }
+  'data': { 'path': 'str' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @QtestProperties:
@@ -872,7 +878,8 @@
 ##
 { 'struct': 'RngRandomProperties',
   'base': 'RngProperties',
-  'data': { '*filename': 'str' } }
+  'data': { '*filename': 'str' },
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @SevGuestProperties:
-- 
2.45.1



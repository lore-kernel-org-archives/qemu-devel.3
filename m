Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBECD59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k69-0006qm-6E; Wed, 06 Nov 2024 12:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k68-0006qT-63
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k66-0006o1-Ho
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rlUeG+QWms4BLnJx0BEuLrNSeba/8KNkIA72Ae2aYDA=;
 b=XnipdLXU0SQwdC4PUULy5IKZMjPACGPuqzgVm+k8o6pviaEtcF5JYzLIZ+uJwLBnBN96FS
 edPdpTziqjEZci9bMMHVUKpTBXWOX6zFvh96+eyUtCGeX03//WM1VNzl62/Wk0MIjAeN4Z
 Bc7+F9IzNLac5MIZ6RIm05qJkzJDdJc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-la_HeON8OBynPzz1TuowCw-1; Wed, 06 Nov 2024 12:45:36 -0500
X-MC-Unique: la_HeON8OBynPzz1TuowCw-1
X-Mimecast-MFC-AGG-ID: la_HeON8OBynPzz1TuowCw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so631f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915134; x=1731519934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlUeG+QWms4BLnJx0BEuLrNSeba/8KNkIA72Ae2aYDA=;
 b=bueGM7R8bmw7luq0ssC8NItLPB+EPq6lz3tpiTiN6PvuavP671intVEEB1doJcxK1w
 m89keR8c+N6ho8xJJR4P2FBdoaH0F7MLak0n/0blK/Elt+sMJ9Pwx4I6CqCuBq5dA3ib
 iZzxPKqU5lqejGg43c81BF8xN/osCiEPWCTz/IrVnSuft/C1LG6+Lwv40aX4/kkrwiIA
 vgg1yYw8Ow1jpDM+oGLpcozrIvpeNsl4Gbl4Q9i+bgfnfWBCgjOqAzHan/edhm93X8aX
 kax3Fe02OSGsmul5+Popjm2XIrYIGb3YriGzeuv7MNXaS1CHP3slWScO02LjzAD2wX3i
 hmsA==
X-Gm-Message-State: AOJu0Yx5kiDhpZdf3os44Zuvw+azzqG8ANKRT0rvdzUMcVchTgWwVb4d
 iiMJMvEb6hqQX3Tvi8M36wYBefuhPQBV5gmcds184WMlp3Q6i9mMamqbLTfHcXdx2F4YTyV5xjt
 k4yFu+7+6ZUfoZVMdLKrUXsBC9W8EShFPoJv5hyEuon7gzTwgRu0e7jqgTsyg+KgsgorNdPu1Am
 HtatqPeS0wWmCN2SntkXBUlE2k5VY0Jrk/dF7Mtfk=
X-Received: by 2002:a05:6000:2c5:b0:37e:c4e3:f130 with SMTP id
 ffacd0b85a97d-381be907327mr22058101f8f.41.1730915134526; 
 Wed, 06 Nov 2024 09:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/p7enbh7p/H6xprYB5SZHdGYEnnmVg2PBozvtCEouPd/XVo56g7EbSX1MJU9t7RJWT3Fskg==
X-Received: by 2002:a05:6000:2c5:b0:37e:c4e3:f130 with SMTP id
 ffacd0b85a97d-381be907327mr22058029f8f.41.1730915133065; 
 Wed, 06 Nov 2024 09:45:33 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35c0sm32970935e9.16.2024.11.06.09.45.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:45:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: add meson_version to all subprojects
Date: Wed,  6 Nov 2024 18:45:31 +0100
Message-ID: <20241106174531.558197-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Otherwise, newer releases of meson complain.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build         | 1 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build               | 1 +
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build          | 1 +
 subprojects/packagefiles/either-1-rs/meson.build                | 1 +
 subprojects/packagefiles/itertools-0.11-rs/meson.build          | 1 +
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build      | 1 +
 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build | 1 +
 subprojects/packagefiles/proc-macro2-1-rs/meson.build           | 1 +
 subprojects/packagefiles/quote-1-rs/meson.build                 | 1 +
 subprojects/packagefiles/syn-2-rs/meson.build                   | 1 +
 subprojects/packagefiles/unicode-ident-1-rs/meson.build         | 1 +
 11 files changed, 11 insertions(+)

diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 34a189cbaec..cff3f62ce74 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('arbitrary-int-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.2.7',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index a6ed4a8f0cd..e69bac91b40 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -1,6 +1,7 @@
 project(
   'bilge-0.2-rs',
   'rust',
+  meson_version: '>=1.5.0',
   version : '0.2.0',
   license : 'MIT or Apache-2.0',
 )
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 80243c7024d..f8f3486fc08 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -1,4 +1,5 @@
 project('bilge-impl-0.2-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index a5842eb3a6a..608e64e31fc 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('either-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 13d2d27019d..30982a4ee76 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -1,4 +1,5 @@
 project('itertools-0.11-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '0.11.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 38ea7b89d39..ae27a696862 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro-error-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.4',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index d900c54cfd1..3281b264333 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro-error-attr-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 818ec59336b..288323eaba8 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('proc-macro2-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.84',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index d36609bd3c8..7f7792569b9 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('quote-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a53335f3092..bb3c15539be 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,4 +1,5 @@
 project('syn-2-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '2.0.66',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 54f23768545..9d76ebbd1ad 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -1,4 +1,5 @@
 project('unicode-ident-1-rs', 'rust',
+  meson_version: '>=1.5.0',
   version: '1.0.12',
   license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
   default_options: [])
-- 
2.47.0



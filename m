Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD049CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYAo-0001HE-6w; Fri, 19 Sep 2025 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYAl-0001EO-1H
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYAf-0000cd-5f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758277008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y5GP56yjZeCIgLt2bAyfjRtzxcpyDB7z2z5+NzL9a2U=;
 b=TxzJ5KL7T4pMpLgpBrPPmGibWpxBzkCy4lnFEDuXT6LLT3ow+3j5iajvjEAI/8sgwQTYwY
 rD5DOeF1AJJ0hR1z+AdMlqUQBFgOBUSEQAhttRTVG29MUxkDKKvovubaFehEXuH4HjdyJk
 BnMx3byvSWHML7ITlompGZpwhMIYqH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-9abkduCpOlWDYXUzXj0alw-1; Fri,
 19 Sep 2025 06:16:47 -0400
X-MC-Unique: 9abkduCpOlWDYXUzXj0alw-1
X-Mimecast-MFC-AGG-ID: 9abkduCpOlWDYXUzXj0alw_1758277006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C4D0180035C; Fri, 19 Sep 2025 10:16:46 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3B921955F21; Fri, 19 Sep 2025 10:16:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: build: remove "protocol: rust: from doctests
Date: Fri, 19 Sep 2025 12:16:42 +0200
Message-ID: <20250919101642.121190-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is added already by rust.doctest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/meson.build       | 1 -
 rust/common/meson.build    | 1 -
 rust/migration/meson.build | 1 -
 rust/qom/meson.build       | 1 -
 rust/util/meson.build      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 2e0d8a88ed3..305d7111897 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -46,6 +46,5 @@ bql_rs = declare_dependency(link_with: [_bql_rs],
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-bql-rs-doctests',
      _bql_rs,
-     protocol: 'rust',
      dependencies: bql_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 7fcfa87d362..89dc11b594c 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -34,6 +34,5 @@ rust.test('rust-common-tests', _common_rs,
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-common-doctests',
      _common_rs,
-     protocol: 'rust',
      dependencies: common_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 26e4c98bcf7..3843b364c69 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -49,6 +49,5 @@ migration_rs = declare_dependency(link_with: [_migration_rs],
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-migration-rs-doctests',
      _migration_rs,
-     protocol: 'rust',
      dependencies: migration_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 3b60d2be0bd..d7622a9e0b1 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -38,6 +38,5 @@ qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qo
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-qom-rs-doctests',
      _qom_rs,
-     protocol: 'rust',
      dependencies: qom_rs,
      suite: ['doc', 'rust'])
diff --git a/rust/util/meson.build b/rust/util/meson.build
index ba6213bf3b8..eb101495870 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -60,7 +60,6 @@ rust.test('rust-util-tests', _util_rs,
 # in a separate suite that is run by the "build" CI jobs rather than "check".
 rust.doctest('rust-util-rs-doctests',
      _util_rs,
-     protocol: 'rust',
      dependencies: util_rs,
      suite: ['doc', 'rust']
 )
-- 
2.51.0



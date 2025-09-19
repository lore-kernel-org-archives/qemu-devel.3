Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485FCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWbZ-0002uW-Mh; Fri, 19 Sep 2025 04:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzWbW-0002rS-9Z
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzWbT-00020J-GK
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758270984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u2ujm1VawI3tEQj8Jm53WYSDc86i34iyikdx2/JKeC4=;
 b=bAeg+uaSRXhqrtj9X/0l2cJIHAUUhnXmNPOLLGa2NTbDDjx0i8snDXB8Q05Pvt6O8m8Pkv
 Q8PZLKZhnnUcJdQH9LO4IhsdV16gs7DEA/34st3tNBo4bsGWt8EU7r4qqpuYLnd9DSSblq
 b5uz9DjZ4VIv/1O9Q2KCo0vUKXd6mV0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-RF-ybB5DMY6_XFUMvCDXSg-1; Fri,
 19 Sep 2025 04:36:22 -0400
X-MC-Unique: RF-ybB5DMY6_XFUMvCDXSg-1
X-Mimecast-MFC-AGG-ID: RF-ybB5DMY6_XFUMvCDXSg_1758270981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02FBE1800285; Fri, 19 Sep 2025 08:36:21 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84A2C1800452; Fri, 19 Sep 2025 08:36:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: build: add back common and util tests
Date: Fri, 19 Sep 2025 10:36:17 +0200
Message-ID: <20250919083617.86582-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These were dropped by mistake when extracting the crates.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/common/meson.build | 3 +++
 rust/util/meson.build   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/rust/common/meson.build b/rust/common/meson.build
index b805e0faf57..07d073182ed 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -24,6 +24,9 @@ _common_rs = static_library(
 
 common_rs = declare_dependency(link_with: [_common_rs])
 
+rust.test('rust-common-tests', _common_rs,
+          suite: ['unit', 'rust'])
+
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
 # in a separate suite that is run by the "build" CI jobs rather than "check".
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 87a893673d2..96330504459 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -44,6 +44,10 @@ _util_rs = static_library(
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
 
+rust.test('rust-util-tests', _util_rs,
+          dependencies: [qemuutil, qom],
+          suite: ['unit', 'rust'])
+
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
 # in a separate suite that is run by the "build" CI jobs rather than "check".
-- 
2.51.0



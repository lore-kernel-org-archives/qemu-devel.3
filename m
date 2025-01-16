Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F37EE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 06:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJek-0008Qk-Tu; Thu, 16 Jan 2025 01:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJei-0008QX-Pn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 01:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYJeg-0002nv-Bv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 01:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737010020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dh/Ygc/kux32lmUUMpnUsyeUW82PwL+vrGbb1S173Bg=;
 b=P66edAZlP6wOsFz8aq6i+h0Lmvsgwy7eXeEjncREKjvjdQ/1juRSJ+KMzlM2KrE3KpXczh
 FJY578js7qaTwSA/fdhIoXjwCaA5cKwWxjjRWqjhtA6qERM6rq/k5dlLemDWKugRB9XsRp
 AO0mNu+r2hTecteHDMNiqZu0/7N0EV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-LceABmv2Mqi8z00QN4Kf3Q-1; Thu,
 16 Jan 2025 01:46:52 -0500
X-MC-Unique: LceABmv2Mqi8z00QN4Kf3Q-1
X-Mimecast-MFC-AGG-ID: LceABmv2Mqi8z00QN4Kf3Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74906195604F; Thu, 16 Jan 2025 06:46:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.129])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70AE119560AA; Thu, 16 Jan 2025 06:46:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] docs/about: Change notes on x86 machine type deprecation into
 a general one
Date: Thu, 16 Jan 2025 07:46:44 +0100
Message-ID: <20250116064644.65670-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We now have a general note about versioned machine types getting
deprecated and removed at the beginning of the deprecated.rst file,
so we should also have a general note about this in removed-features.rst
(which will also apply to versioned non-x86 machine types) instead of
listing individual old machine types in the document.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  7 -------
 docs/about/removed-features.rst | 11 +++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7b42d6eecc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These old machine types are quite neglected nowadays and thus might have
-various pitfalls with regards to live migration. Use a newer machine type
-instead.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e..156c0c253c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
 System emulator machines
 ------------------------
 
+Note: Versioned machine types that have been introduced in a QEMU version
+that has initially been released more than 6 years before are considered
+obsolete and will be removed without further notice in this document.
+Please use newer machine types instead.
+
 ``s390-virtio`` (removed in 2.6)
 ''''''''''''''''''''''''''''''''
 
@@ -1006,12 +1011,6 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.3`` (removed in 4.0 up to 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-These machine types were very old and likely could not be used for live
-migration from old QEMU versions anymore. Use a newer machine type instead.
-
 Raspberry Pi ``raspi2`` and ``raspi3`` machines (removed in 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.47.1



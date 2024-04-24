Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C5AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXGe-00080P-Pm; Wed, 24 Apr 2024 03:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXGd-00080B-87
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXGb-0008PV-LT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713944528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RFcDNZ+J/CwZV0COXOAvkhliajwVRsTUgbNi4McdkJc=;
 b=dntDaqgXXgGRdKMFKOZnBEPD2OUJ6Ap95I2ycB9FF97MoU/XueOXlOkxSLioMwoW3sVxsh
 AogP2uqL8y4xcPX4VAu71nmKBwgFgsh8J+73boFjr9q1B0Ui8CDLDuivM3F6Q6mtDoRC//
 O0bTdIOzkpaDMrn3pMfvrDFE+Os7dI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-RVeFQ5LQMQS7KGEZf6vn-g-1; Wed,
 24 Apr 2024 03:42:05 -0400
X-MC-Unique: RVeFQ5LQMQS7KGEZf6vn-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B4D81C0C64D;
 Wed, 24 Apr 2024 07:42:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0688E40C5C2;
 Wed, 24 Apr 2024 07:42:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] .gitlab-ci.d/cirrus.yml: Fix the NetBSD and OpenBSD Cirrus-CI
 KVM jobs
Date: Wed, 24 Apr 2024 09:42:02 +0200
Message-ID: <20240424074202.245646-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Pulling the "master" libvirt-ci containers does not work anymore,
so we have to switch to the "latest" instead. See also:
https://gitlab.com/libvirt/libvirt/-/commit/5d591421220c850aa64a640
https://gitlab.com/libvirt/libvirt-ci/-/commit/6e3c5ccac77714be70c0

The effects were dormant for a year as the old ':master' tags were
not removed until some weeks ago.

The other Cirrus-CI jobs were already fixed in commit 1d2f2b35bc86b7a1
("gitlab-ci/cirrus: switch from 'master' to 'latest'"), but apparently
nobody noticed the KVM jobs so far that need to be triggered manually.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 4671f069c3..8b45f72910 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -95,7 +95,7 @@ aarch64-macos-14-base-build:
 .cirrus_kvm_job:
   extends: .base_job_template
   stage: build
-  image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
+  image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:latest
   needs: []
   timeout: 80m
   script:
-- 
2.44.0



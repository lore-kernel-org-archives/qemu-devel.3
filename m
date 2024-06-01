Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E3C27C51
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 07:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoO-00048C-EM; Sat, 01 Jun 2024 03:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoN-00047g-CJ
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoK-00004s-M1
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MvPE2VRkK5KY0qXvMyedQtVmP4U6ZinVb8cAbFbnhVc=;
 b=fuxmM5pEEQBl8eHisILoQTIfypubtis2CwaWIjK6mHtXJzdTqYg/vALQYv2uu8xIMxU/yN
 g9wygrjPG7LhKDZQMMIeiLCyqXitEdi/9wvBZ2aZi9K/kdECBr8yLX2Yxb7QJ2yeIG7XFZ
 2QVtC0sFiDz6pVUe5IEnjeBBMfkC3r4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-X94B2KoxN8qXESkTz4ByWQ-1; Sat, 01 Jun 2024 03:05:45 -0400
X-MC-Unique: X94B2KoxN8qXESkTz4ByWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53DF185A58C;
 Sat,  1 Jun 2024 07:05:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78429208C6F2;
 Sat,  1 Jun 2024 07:05:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/5] tests: Update Fedora and Alpine containers via lcitool
Date: Sat,  1 Jun 2024 09:05:38 +0200
Message-ID: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

According to QEMU's support policy, Fedora 38 and Alpine 3.18 are not
supported anymore, so let's bump the containers to a newer version.

Both, Alpine 3.20 and Fedora 40 ship with Python 3.12 that breaks our
old version of Avocado since the "imp" module has been removed there.
To work around this problem, Fedora fortunately still ships a separate
"python3-zombi-imp" package that we can install. And with regards to
Alpine, we only upgrade to 3.19 that is still using Python 3.11.

Another problem are improvements in the undefined-behavior sanitizer
of the latest versions of Clang that we use in the "clang-system"
Fedora container: We now need to compile with -fno-sanitize=function
there until all spots in the source code have been fixed (and that
might take while since many of the issues are not trivial).

Thomas Huth (5):
  tests/lcitool: Delete obsolete centos-stream-8.yml file
  tests/lcitool: Bump to latest libvirt-ci and update Fedora and Alpine
    version
  .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function in the
    clang-system job
  tests/lcitool: Install mingw-w64-tools for the Windows cross-builds
  tests/docker/dockerfiles: Run lcitool-refresh to update Fedora and
    Alpine

 .gitlab-ci.d/buildtest.yml                         | 1 +
 tests/docker/dockerfiles/alpine.docker             | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 6 ++++--
 tests/docker/dockerfiles/fedora.docker             | 5 +++--
 tests/lcitool/libvirt-ci                           | 2 +-
 tests/lcitool/projects/qemu-win-installer.yml      | 1 +
 tests/lcitool/projects/qemu.yml                    | 1 +
 tests/lcitool/refresh                              | 6 +++---
 tests/lcitool/targets/centos-stream-8.yml          | 3 ---
 9 files changed, 16 insertions(+), 13 deletions(-)
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml

-- 
2.45.1



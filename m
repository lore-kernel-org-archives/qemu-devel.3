Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C97C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Spt-0004T6-KI; Mon, 13 May 2024 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Sps-0004Sw-CW
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Spp-0008Nt-NT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715595788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QhkApyrq3tWVN8zYUMmpTFrq0o5X7joHQyE+TLBXdkw=;
 b=SUjIIYtRdwlQT+KRheNj5N/cmM/0IbLZrob8OQ0WXZ7UaCBMbnpnqdrQF2jLCV+9iPyDhO
 hCJpqfOPB0jYE/a+zuKf6h48DV40CuFyzV7F4SW2g5DZPAVgnVN5o9ox1I1jPfz+xi7Cgz
 tlxG9UvwAaQ2QIaHy8FLdvMwrCwQGs0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Uf38fKPzOyy53skQph1k4Q-1; Mon, 13 May 2024 06:23:05 -0400
X-MC-Unique: Uf38fKPzOyy53skQph1k4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 308AE800994;
 Mon, 13 May 2024 10:23:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0680740C6CB6;
 Mon, 13 May 2024 10:23:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/4] tests: Remove xfsprogs and g++ from the dockerfiles
Date: Mon, 13 May 2024 12:22:48 +0200
Message-ID: <20240513102252.48884-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The xfsprogs package is not necessary anymore since commit a5730b8bd3
and we don't need g++ in any of the containers (except for the mingw
cross compiler container which can be handled differently), so this
patch series simplifies the dockerfiles a little bit accordingly.

Philippe Mathieu-Daudé (1):
  tests/lcitool: Remove 'xfsprogs' from QEMU

Thomas Huth (3):
  tests/lcitool: Remove g++ from the containers (except for the MinGW
    one)
  tests/lcitool/projects/qemu.yml: Sort entries alphabetically again
  tests/docker/dockerfiles: Update container files with
    "lcitool-refresh"

 tests/docker/dockerfiles/alpine.docker        |  4 ----
 tests/docker/dockerfiles/centos9.docker       |  4 ----
 .../dockerfiles/debian-amd64-cross.docker     |  4 ----
 .../dockerfiles/debian-arm64-cross.docker     |  4 ----
 .../dockerfiles/debian-armel-cross.docker     |  4 ----
 .../dockerfiles/debian-armhf-cross.docker     |  4 ----
 .../dockerfiles/debian-i686-cross.docker      |  4 ----
 .../dockerfiles/debian-mips64el-cross.docker  |  4 ----
 .../dockerfiles/debian-mipsel-cross.docker    |  4 ----
 .../dockerfiles/debian-ppc64el-cross.docker   |  4 ----
 .../dockerfiles/debian-s390x-cross.docker     |  4 ----
 tests/docker/dockerfiles/debian.docker        |  4 ----
 .../dockerfiles/fedora-win64-cross.docker     |  8 +++++---
 tests/docker/dockerfiles/fedora.docker        |  4 ----
 tests/docker/dockerfiles/opensuse-leap.docker |  4 ----
 tests/docker/dockerfiles/ubuntu2204.docker    |  4 ----
 tests/lcitool/projects/qemu.yml               | 20 +++++++++----------
 tests/lcitool/refresh                         | 10 ++++++++--
 18 files changed, 22 insertions(+), 76 deletions(-)

-- 
2.45.0



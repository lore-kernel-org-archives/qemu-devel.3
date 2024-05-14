Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95479C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rcy-0005A5-O5; Tue, 14 May 2024 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rcv-00059J-7k
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rct-0005DA-2Q
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BhZviWR8swUyZh1VWtzS6YVsWR3o/hYYrBgfLNRvAqY=;
 b=DDkSPk041DVtM004SYyGVBRa2hfu6/uzMqTQE2Puda/pxrEPCFSZzTd1/nmfv/Y8/O/BFz
 e4u1A6iU+lQ8WLhJiTrL0oCs5wVnu36JpU9TmCymuRCExyUOCssNkkGThi/eyABY1SQDkI
 olsk6MoBcSdhG53YLD6/6/XvGeE2avo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-vCxYF4SJPUqwvmCMRUSNhw-1; Tue,
 14 May 2024 08:51:21 -0400
X-MC-Unique: vCxYF4SJPUqwvmCMRUSNhw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94817380009F;
 Tue, 14 May 2024 12:51:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D216F400057;
 Tue, 14 May 2024 12:51:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/11] gitlab CI fix and glib update
Date: Tue, 14 May 2024 14:51:08 +0200
Message-ID: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

The following changes since commit 9360070196789cc8b9404b2efaf319384e64b107:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-12 13:41:26 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-05-14

for you to fetch changes up to da79537e0c8cef007d30298343d05acb0ba8b427:

  util/uri: Remove the old URI parsing code (2024-05-14 12:46:46 +0200)

----------------------------------------------------------------
* Fix the "tsan-build" CI job on the shared gitlab CI runners
* Bump minimum glib version and use URI code from the newer glib
* Fix error message from "configure" when C compiler is not working

----------------------------------------------------------------
Daniel P. Berrangé (3):
      dockerfiles: add 'MAKE' env variable to remaining containers
      gitlab: use $MAKE instead of 'make'
      gitlab: use 'setarch -R' to workaround tsan bug

Thomas Huth (8):
      configure: Fix error message when C compiler is not working
      Bump minimum glib version to v2.66
      Remove glib compatibility code that is not required anymore
      block/gluster: Use URI parsing code from glib
      block/nbd: Use URI parsing code from glib
      block/nfs: Use URI parsing code from glib
      block/ssh: Use URI parsing code from glib
      util/uri: Remove the old URI parsing code

 configure                                          |   11 +-
 meson.build                                        |   16 +-
 include/glib-compat.h                              |   27 +-
 include/qemu/uri.h                                 |   99 --
 block/gluster.c                                    |   69 +-
 block/nbd.c                                        |   76 +-
 block/nfs.c                                        |  110 +-
 block/ssh.c                                        |   75 +-
 qga/commands-posix-ssh.c                           |   12 +-
 util/error-report.c                                |   10 -
 util/uri.c                                         | 1466 --------------------
 .gitlab-ci.d/buildtest-template.yml                |    6 +-
 .gitlab-ci.d/buildtest.yml                         |    3 +
 .../dockerfiles/debian-all-test-cross.docker       |    1 +
 .../docker/dockerfiles/debian-hexagon-cross.docker |    1 +
 .../dockerfiles/debian-legacy-test-cross.docker    |    1 +
 .../dockerfiles/debian-loongarch-cross.docker      |    1 +
 .../docker/dockerfiles/debian-tricore-cross.docker |    1 +
 .../docker/dockerfiles/debian-xtensa-cross.docker  |    1 +
 tests/docker/dockerfiles/fedora-cris-cross.docker  |    1 +
 util/meson.build                                   |    2 +-
 21 files changed, 194 insertions(+), 1795 deletions(-)
 delete mode 100644 include/qemu/uri.h
 delete mode 100644 util/uri.c



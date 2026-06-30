Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89866C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaAv-0002WF-CM; Tue, 30 Jun 2026 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaAu-0002Vn-1L
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaAs-0008Mn-9n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NhQ8JCEOOGrBylgGAjTsddQaanukvRoM8+HXjFsm398=;
 b=D4BICnpUHhTXZf08FvpmxOm7tkdDtsFQn3giNmjZuYCDyEXik1e5kgtDobSy9SDDRxvRPa
 pGnyGxYLjkMkuCXWIIPJ6/ZsIhM04selfudTtbf1DXOhvAYBfh7Laxv3HRaT4zcPBFkZR4
 /EOaoiOeTDlbA55cOFeIFC38gv+gs+I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-tFL_AtheMPqM04xHbI0qsA-1; Tue,
 30 Jun 2026 11:14:54 -0400
X-MC-Unique: tFL_AtheMPqM04xHbI0qsA-1
X-Mimecast-MFC-AGG-ID: tFL_AtheMPqM04xHbI0qsA_1782832492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88F6E197731D
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:14:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B2B5180067F; Tue, 30 Jun 2026 15:14:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 0/8] Dump patches for 2026-06-30
Message-Id: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
Date: Tue, 30 Jun 2026 19:13:15 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SGSZXmcQLC+1Y6c5wVHyKfvItC/Scqb8phnH8dgxkrA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91m9wqNt6pWBQznP0KhmZ7WkRreYyYWkcr91
 lRbWpHXGZCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZgAKCRDa6OEJdZac
 5avREACTCJVXc4OShrRyITr0HPzyv/ykfydhbfH+nUilPTcw4+KyUz/Xda+tnq4Gai/JmLEcQFf
 pJ4GuFn+Rcq/z76B2IiPnqrBHmNOxrT8rGwyHJx7g89a7bu3Kp0ycQdFN+tfctGLosXAS/UFX+D
 5/0kv+YzR8EepQ7Nlgliy28BEdTldIegz0Mw7/OzMpPQFXx+RQe26bmGJpfbXxzyVi9wHbrWHCp
 kQPJ/o8stYsSIhjkdxfjKpMZ4PDAPghzam/7OCTSeqS0jJK+6YhS3oMUYMHpTrZYuc6z5n1fON8
 PNZ6epkCANqFgI1de7YDr08QT6R8slXz0NSmsuenRe825IRb+Yxbad8o4GI0uhbENBeplbfIjqe
 jIHA1lMp0jnR0ZQJrgSaG3qhL4OMM9VqaZYsdCVmoPCJ49iqj0pidrTNUDzKY/f+uDy1u29gNy/
 aHTN34Ern+95J+MIY88zb6zXGhpoHBB1bK3bJ8BBaDpoxt4cyXvgCE20AAu49VSzVx5lJ4JH11o
 q5Ug4JuwHekKO5ztSDceGM8Ukob4xzCDco0epaq3bucBfjpk3gN6LwQOawfOiaWqkdCtpXVzL4F
 8lE4akrcVBW5jUMMfzerbe4dGouxMva302UJuZKGPe5gD5zNFoqQCi/lVCvnQmuHRfHC8hBQaN6
 dNe4GVoH/Xf7W1g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/dump-pr-v1

for you to fetch changes up to 89f7c15e628147edd1cae5214827c8175e8fabd1:

  dump: fix misleading VMCOREINFO phys_base parse error (2026-06-30 19:12:59 +0400)

----------------------------------------------------------------
Dump patches for 2026-06-30

To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

----------------------------------------------------------------
Denis V. Lunev (7):
      migration: add migration_guest_ram_loading() helper
      dump: refuse dump-guest-memory while guest RAM is being migrated
      system/cpus: refuse memsave/pmemsave while guest RAM is being migrated
      dump: make win_dump_available() check vmcoreinfo for a Windows dump header
      tests/qtest: add dump-guest-memory test
      tests/qtest/dump: reject win-dmp without vmcoreinfo
      tests/qtest/dump: cover win-dmp availability via vmcoreinfo

yujun (1):
      dump: fix misleading VMCOREINFO phys_base parse error

 MAINTAINERS              |   1 +
 include/migration/misc.h |   3 +
 dump/dump.c              |   8 +-
 dump/win_dump-x86.c      |  49 ++++++-
 migration/migration.c    |   6 +
 system/cpus.c            |  11 ++
 tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build  |   1 +
 8 files changed, 402 insertions(+), 8 deletions(-)
 create mode 100644 tests/qtest/dump-test.c



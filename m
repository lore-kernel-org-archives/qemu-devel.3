Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431F6CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Ox-0001bA-Cg; Mon, 01 Sep 2025 08:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OV-0001QF-25
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3OG-0006Cd-TO
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=Tfowod14ryO9nL8WLb2S9gtUh8xv0yEip1ESB4Cqy6w=;
 b=L2k3obQ/eTOOk/Ve86i5BuoZxIPF1j/HlEeiCt7REiz9P6g+nRukCzKhHMNVhixYtqbt+S
 eGsceEGg8WlPK3nCCFLhBhVEmLvcvhHpFEFk+po/i+1pTnVi73yLNk+Om7bxu4UhBNvnHR
 odo56dXPIBLr+ADeit4dQMA4/DjwaFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-8vD39B5APWKr3dVUrGtRpg-1; Mon,
 01 Sep 2025 08:11:55 -0400
X-MC-Unique: 8vD39B5APWKr3dVUrGtRpg-1
X-Mimecast-MFC-AGG-ID: 8vD39B5APWKr3dVUrGtRpg_1756728714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D6E9180034F; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1115A180044F; Mon,  1 Sep 2025 12:11:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6023C21E6A27; Mon, 01 Sep 2025 14:11:51 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:11:51 +0200
Resent-Message-ID: <87zfbe2wzc.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:53:00 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D46F21E6A27; Mon, 01 Sep 2025 13:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/5] Testing patches for 2025-09-01
Date: Mon,  1 Sep 2025 13:52:55 +0200
Message-ID: <20250901115300.2541937-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 91589bcd9fee0e66b241d04e5f37cd4f218187a2:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-08-31 09:08:09 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-tests-2025-09-01

for you to fetch changes up to c9a1ea9c52e6462ad5c7814f3abd65baa69dc4ce:

  Revert "tests/qtest: use qos_printf instead of g_test_message" (2025-09-01 13:44:28 +0200)

----------------------------------------------------------------
Testing patches for 2025-09-01

----------------------------------------------------------------
Markus Armbruster (5):
      qtest/qom-test: Shallow testing of qom-list / qom-get
      qtest/qom-test: Traverse entire QOM tree
      qtest/qom-test: Don't bother to execute QMP command quit
      MAINTAINERS: Cover tests/qtest/qom-test.c
      Revert "tests/qtest: use qos_printf instead of g_test_message"

 MAINTAINERS                   |  1 +
 tests/qtest/qom-test.c        |  8 ++------
 tests/qtest/qos-test.c        |  5 -----
 tests/qtest/vhost-user-test.c | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 25 deletions(-)

-- 
2.49.0




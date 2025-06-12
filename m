Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B0AC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPidK-0006bA-MI; Thu, 12 Jun 2025 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uPidJ-0006ZF-5E
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uPidF-0004h8-Vd
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749737416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Egb4YeUhJAWOersscHOMQ4gzQrgMUi07QI6Ax5eucf8=;
 b=G8Jp/++7eLnTug/Jx35W12xOfYE8sov8LeGtPctH7k5jpg1X56a3koHqHyxSHnG5tGzqIy
 M7+VmIYsZvnkUNuC+O3+3YAAd6AmNIbAzKN53p2i1G1l1Oz2HGL+JBtEj/9+4cn77bEQm+
 ShMX0GRVy3dOctzkNLR2ucU91QyTQ/s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-fNCZ7fnpOEu3ldBOSIWOsw-1; Thu,
 12 Jun 2025 10:09:04 -0400
X-MC-Unique: fNCZ7fnpOEu3ldBOSIWOsw-1
X-Mimecast-MFC-AGG-ID: fNCZ7fnpOEu3ldBOSIWOsw_1749737343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0533C180AE03; Thu, 12 Jun 2025 14:09:03 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.218])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3187918003FC; Thu, 12 Jun 2025 14:09:00 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/2] QGA patches for 2025-06-12
Date: Thu, 12 Jun 2025 17:08:55 +0300
Message-ID: <20250612140857.47286-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit d9ce74873a6a5a7c504379857461e4ae64fcf0cd:

  Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu into staging (2025-06-11 11:39:53 -0400)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-06-12

for you to fetch changes up to 1ebbc8b774d8b44697740b108ad060612828b58f:

  qga: Add tests for guest-get-load command (2025-06-12 17:02:05 +0300)

----------------------------------------------------------------
qga-pull-2025-06-12

----------------------------------------------------------------
Konstantin Kostiuk (2):
      qga-win: implement a 'guest-get-load' command
      qga: Add tests for guest-get-load command

 qga/commands-win32.c   | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
 qga/guest-agent-core.h |  10 ++++
 qga/main.c             |  39 +++++++++++++
 qga/meson.build        |   2 +-
 qga/qapi-schema.json   |   9 ++-
 tests/unit/test-qga.c  |  17 ++++++
 6 files changed, 222 insertions(+), 3 deletions(-)

--
2.48.1



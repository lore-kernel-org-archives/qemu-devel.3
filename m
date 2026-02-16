Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E188FE7BD87
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvrr-0005x0-7l; Mon, 16 Feb 2026 05:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrj-0005wP-RY
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrf-0006hF-R5
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AGqEMblOZ5pxWsF/2pfVgh2S4OKj8FzR+Hnbi3USkvo=;
 b=YjUAhHysCC2xJ/Fvjjz43P5ntKGSnmhQHg8NRMw62QZ/mcHnrrCx2XNsLDpAE0MKvw90bF
 SI6GGQ0bt4DW3Sc8NBSkhXeKHZX/gdK8+FmRy6mckqovi211KKhZEdYw4L0t/V8eyLehGo
 vX9shC0ZjF1TqPN336acVPF1DOgrl3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-aIDmgVU_NXiWykumy9ncCw-1; Mon,
 16 Feb 2026 05:29:56 -0500
X-MC-Unique: aIDmgVU_NXiWykumy9ncCw-1
X-Mimecast-MFC-AGG-ID: aIDmgVU_NXiWykumy9ncCw_1771237795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A3DE1956060; Mon, 16 Feb 2026 10:29:55 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 302201800465; Mon, 16 Feb 2026 10:29:53 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/5] QGA misc fixes and improvements (2026-02-16)
Date: Mon, 16 Feb 2026 12:29:46 +0200
Message-ID: <20260216102951.150381-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-02-16

for you to fetch changes up to 33c26efbfede4c8e2198aee5da574cf7f060df22:

  qga: Fix VSS provider GetSnapshotProperties return value (2026-02-16 12:03:53 +0200)

----------------------------------------------------------------
qga-pull-2026-02-16

----------------------------------------------------------------
Elizabeth Ashurov (3):
      qga: implement guest-network-get-route for Windows
      qga: Move CoInitialize/CoInitializeSecurity to main process thread
      qga: Fix VSS provider GetSnapshotProperties return value

Nguyen Dinh Phi (2):
      qga/vss-win32: Fix ConvertStringToBSTR redefinition with newer MinGW
      util: Move qemu_ftruncate64 from block/file-win32.c to oslib-win32.c

 block/file-win32.c          |  32 ---------
 meson.build                 |  12 ++++
 qga/commands-win32.c        | 172 ++++++++++++++++++++++++++++++++++++++++++++
 qga/main.c                  |  42 +++++++++++
 qga/qapi-schema.json        |  12 ++--
 qga/vss-win32/install.cpp   |   2 +
 qga/vss-win32/provider.cpp  |   2 +-
 qga/vss-win32/requester.cpp |  13 ----
 util/oslib-win32.c          |  34 +++++++++
 9 files changed, 269 insertions(+), 52 deletions(-)

--
2.52.0



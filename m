Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F77D132C8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xLA-00016S-4x; Mon, 04 Nov 2024 08:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xL8-00015r-Cc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t7xL5-0002n8-8f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B8Dw6WD4ZXWPRO3JPmWJZCuQOehqdJF1aNoHmCKQnx8=;
 b=ByJIkRT6zVXz0jsBA6J+1YY0fCDoux4F3m3K7Uj33EHUpVNTk8fpdfr0wi7uC0IBSahm1N
 25S6k0I0WrAbq1o4hf821T08GSNUwWJeb0U2Qxib9clHF0YmeFgh/nG78qDtaRrZx/xyTd
 ekj8U5vm+7TO7P1d9WH3PT+/fuIKaLA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-pI-jF7-xMmSNoJv9CAhcKA-1; Mon,
 04 Nov 2024 08:41:45 -0500
X-MC-Unique: pI-jF7-xMmSNoJv9CAhcKA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77EC41955F3B; Mon,  4 Nov 2024 13:41:44 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8637F1956086; Mon,  4 Nov 2024 13:41:42 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/3] Misc QEMU Guest Agent patches for 2024-11-04
Date: Mon,  4 Nov 2024 15:41:36 +0200
Message-ID: <20241104134139.225514-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit c94bee4cd6693c1c65ba43bb8970cf909dec378b:

  Merge tag 'for-upstream-i386' of https://gitlab.com/bonzini/qemu into staging (2024-11-02 16:21:38 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-11-4

for you to fetch changes up to 9cfe110d9fc0be88178770a85dc6170eecdf6be1:

  qemu-ga: Fix a SIGSEGV in ga_run_command() helper (2024-11-04 14:16:47 +0200)

----------------------------------------------------------------
qga-pull-2024-11-4

----------------------------------------------------------------
Pierrick Bouvier (2):
      qga: fix -Wsometimes-uninitialized windows warning
      qga: fix missing static and prototypes windows warnings

Sunil Nimmagadda (1):
      qemu-ga: Fix a SIGSEGV in ga_run_command() helper

 qga/commands-posix.c        | 2 +-
 qga/commands-windows-ssh.c  | 2 +-
 qga/vss-win32/install.cpp   | 6 +++++-
 qga/vss-win32/provider.cpp  | 5 ++++-
 qga/vss-win32/requester.cpp | 8 ++++----
 5 files changed, 15 insertions(+), 8 deletions(-)

--
2.47.0



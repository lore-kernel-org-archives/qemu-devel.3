Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6817C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24d6-0000pH-IC; Wed, 01 May 2024 03:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d4-0000om-6V
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d2-0003XH-Gf
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WXyfoq26iQt1g739ECDCB3sdt3Y/kkrf7Mmm3vlXJFw=;
 b=cMQbXdt1rcwB3ou/7qNTSEK0ovx3qSEd31k1AGSdrkeyt6EYVbUTZXV1u0AEwjsESaxIbm
 CCvz4L+V0hd99R08bsguFGzKEDhDeXifran/a2hd6tdAlqW5625KVNxwjI4280y7E2GK+I
 HtZ7jSE8hmuigUxIgjbSSp14xZjzYYA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-U1mgNVUVN8e8-sBo2S5GQw-1; Wed,
 01 May 2024 03:43:43 -0400
X-MC-Unique: U1mgNVUVN8e8-sBo2S5GQw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6114C3C02526;
 Wed,  1 May 2024 07:43:43 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD71640BAA2;
 Wed,  1 May 2024 07:43:41 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] QGA misc changes for 2024-05-01
Date: Wed,  1 May 2024 10:43:31 +0300
Message-ID: <20240501074340.19641-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

The following changes since commit 9c6c079bc6723da8061ccfb44361d67b1dd785dd:

  Merge tag 'pull-target-arm-20240430' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-04-30 09:58:54 -0700)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-05-01

for you to fetch changes up to 6b9296ba7a9cf7adb157c51c124ca522d2180739:

  qga: Implement SSH commands for Windows (2024-05-01 10:35:45 +0300)

----------------------------------------------------------------
qga-pull-2024-05-01

----------------------------------------------------------------
Andrey Drobyshev (7):
      qga: guest-get-fsinfo: add optional 'total-bytes-privileged' field
      qga: introduce ga_run_command() helper for guest cmd execution
      qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
      qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
      qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
      qga/commands-posix: don't do fork()/exec() when suspending via sysfs
      qga/commands-posix: qmp_guest_set_user_password: use ga_run_command helper

aidaleuc (2):
      qga: Refactor common SSH functions
      qga: Implement SSH commands for Windows

 qga/commands-common-ssh.c  |  50 ++++
 qga/commands-common-ssh.h  |  10 +
 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-posix.c       | 404 ++++++++++++-------------
 qga/commands-win32.c       |   1 +
 qga/commands-windows-ssh.c | 712 +++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   8 +-
 qga/qapi-schema.json       |  24 +-
 9 files changed, 999 insertions(+), 283 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h


--
2.44.0



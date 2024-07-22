Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5321C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn3X-0008U0-KG; Mon, 22 Jul 2024 03:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3K-00080d-C5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3H-0006Pi-D5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ykk7iIq+KY4VeSUgr8jyYiCAo5JpAtf6T9ad3v1JWeM=;
 b=VbNx7wF9MoHm5MPhqRv8ukx8u0/4qTfaCDYyjZuTeUtsbRJod+/I7ps7bkr1LojKzGftL/
 iPIRjmxvcy7RvRwxlk8FezcMEQuUZvOee7zwhmycrcd/P5saEUjow5y9Eec/Fau3iONnjA
 w+uEp0AwjE1Q5O7RM0+zyq7GiepbxnU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-PrYmIzANPGWTgKHOPJ-28w-1; Mon,
 22 Jul 2024 03:01:28 -0400
X-MC-Unique: PrYmIzANPGWTgKHOPJ-28w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DB1A1954128; Mon, 22 Jul 2024 07:01:27 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FEA2195605A; Mon, 22 Jul 2024 07:01:24 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/25] Misc QEMU-GA patches 2024-07-22
Date: Mon, 22 Jul 2024 10:00:57 +0300
Message-ID: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 23fa74974d8c96bc95cbecc0d4e2d90f984939f6:

  Merge tag 'pull-target-arm-20240718' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-19 07:02:17 +1000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-07-22

for you to fetch changes up to 24d12dfc5abb3b4ac2506f22c3fd0cda40a6977d:

  qga/linux: Add new api 'guest-network-get-route' (2024-07-22 09:51:12 +0300)

----------------------------------------------------------------
qga-pull-2024-07-22

----------------------------------------------------------------
Daniel P. Berrangé (22):
      qga: drop blocking of guest-get-memory-block-size command
      qga: move linux vcpu command impls to commands-linux.c
      qga: move linux suspend command impls to commands-linux.c
      qga: move linux fs/disk command impls to commands-linux.c
      qga: move linux disk/cpu stats command impls to commands-linux.c
      qga: move linux memory block command impls to commands-linux.c
      qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
      qga: conditionalize schema for commands unsupported on Windows
      qga: conditionalize schema for commands unsupported on non-Linux POSIX
      qga: conditionalize schema for commands requiring getifaddrs
      qga: conditionalize schema for commands requiring linux/win32
      qga: conditionalize schema for commands only supported on Windows
      qga: conditionalize schema for commands requiring fsfreeze
      qga: conditionalize schema for commands requiring fstrim
      qga: conditionalize schema for commands requiring libudev
      qga: conditionalize schema for commands requiring utmpx
      qga: conditionalize schema for commands not supported on other UNIX
      qga: don't disable fsfreeze commands if vss_init fails
      qga: move declare of QGAConfig struct to top of file
      qga: remove pointless 'blockrpcs_key' variable
      qga: allow configuration file path via the cli
      qga: centralize logic for disabling/enabling commands

Dehan Meng (1):
      qga/linux: Add new api 'guest-network-get-route'

Thomas Lamprecht (1):
      guest-agent: document allow-rpcs in config file section

Zhao Liu (1):
      qga/commands-posix: Make ga_wait_child() return boolean

 docs/interop/qemu-ga.rst |   20 +
 meson.build              |   16 +
 qga/commands-bsd.c       |   24 -
 qga/commands-common.h    |    9 -
 qga/commands-linux.c     | 1938 +++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c     | 2383 ++++------------------------------------------
 qga/commands-win32.c     |   78 +-
 qga/main.c               |  224 ++---
 qga/qapi-schema.json     |  226 ++++-
 9 files changed, 2452 insertions(+), 2466 deletions(-)

--
2.45.2



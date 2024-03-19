Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038F8C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfxk-00012j-WB; Tue, 19 Mar 2024 16:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxj-00012a-Mt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfxh-0007WO-Uj
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ufPr2ImucRQLayZWcqnZxJmlRarFbCkY0Xq/mhDhkek=;
 b=Fvuoe6lk5QASt8XI8jvmGEFppfByqCkfHVc+KhIyRxBU/XbAj3Etlchbho6U2ySTGdfFtz
 jspo0d5Hl24XXkbmDWP1K32NDSuYCIU52+PpP+xWCZYTYcqbxFrFgbrP2yG5TEKffbgoOe
 k4mkup+fJ3VsGkWUWS+yPqVOq/NV3Ks=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308--1H-hH32NzGse3z5Fk5FsA-1; Tue,
 19 Mar 2024 16:21:27 -0400
X-MC-Unique: -1H-hH32NzGse3z5Fk5FsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4687528043E4
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:21:27 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16BA110F53;
 Tue, 19 Mar 2024 20:21:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/8] Misc fixes patches
Date: Tue, 19 Mar 2024 20:21:13 +0000
Message-ID: <20240319202121.233130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:

  Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to c3b1aa1c1ae66e0174704072b1fb7d10d6e4a4b7:

  crypto: report which ciphers are being skipped during tests (2024-03-19 20:17:12 +0000)

----------------------------------------------------------------
 * Use EPERM for seccomp filter instead of killing QEMU when
   an attempt to spawn child process is made
 * Reduce priority of POLLHUP handling for socket chardevs
   to increase likelihood of pending data being processed
 * Fix chardev I/O main loop integration when TLS is enabled
 * Fix broken crypto test suite when distro disables
   SM4 algorithm
 * Improve diagnosis of failed crypto tests

----------------------------------------------------------------

Daniel P. Berrangé (8):
  seccomp: report EPERM instead of killing process for spawn set
  chardev: lower priority of the HUP GSource in socket chardev
  Revert "chardev/char-socket: Fix TLS io channels sending too much data
    to the backend"
  Revert "chardev: use a child source for qio input source"
  crypto: factor out conversion of QAPI to gcrypt constants
  crypto: query gcrypt for cipher availability
  crypto: use error_abort for unexpected failures
  crypto: report which ciphers are being skipped during tests

 chardev/char-io.c               |  56 +++++++++++++--
 chardev/char-socket.c           |  22 +++++-
 crypto/cipher-gcrypt.c.inc      | 121 +++++++++++++++++---------------
 system/qemu-seccomp.c           |  10 +--
 tests/unit/test-crypto-cipher.c |   7 +-
 5 files changed, 145 insertions(+), 71 deletions(-)

-- 
2.43.0



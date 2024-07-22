Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE2C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzIv-00018S-IQ; Mon, 22 Jul 2024 16:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIs-00017N-3h
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIo-00026z-SY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9JsaUgLSl5fogxysDiOAgpHhg7qEM39samc8Xtse6i8=;
 b=Zp2x6qnHQMR6qmKvZfgWyHCiy6rthiZ+GDiGao++KK6orY/OewIzLibv2DrS31NVhsqgc5
 aB6o7pGKGIJOaugCLVT+UHxTdsm9WYTgeKB/2gytzrD8vkfTAMtGeuF2nR4XYw9Ve2t1/t
 +jTxUTfz0MXDGqvY4Wiy29G47nCuw3s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-Bnf6N5ueMSeq6wMvIIYFcg-1; Mon,
 22 Jul 2024 16:06:24 -0400
X-MC-Unique: Bnf6N5ueMSeq6wMvIIYFcg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E0751955D57; Mon, 22 Jul 2024 20:06:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5780E1955D44; Mon, 22 Jul 2024 20:06:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/8] Ui patches
Date: Tue, 23 Jul 2024 00:06:10 +0400
Message-ID: <20240722200619.135163-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 903cc9e1173e0778caa50871e8275c898770c690:

  chardev/char-win-stdio.c: restore old console mode (2024-07-22 22:25:46 +0400)

----------------------------------------------------------------
UI-related for 9.1

----------------------------------------------------------------

Gerd Hoffmann (1):
  vnc: increase max display size

Marc-André Lureau (5):
  virtio-gpu-gl: declare dependency on ui-opengl
  ui: add more tracing for dbus
  ui/vdagent: improve vdagent_fe_open() trace
  ui/vdagent: notify clipboard peers of serial reset
  ui/vdagent: send caps on fe_open

Phil Dennis-Jordan (1):
  Cursor: 8 -> 1 bit alpha downsampling improvement

songziming (1):
  chardev/char-win-stdio.c: restore old console mode

 ui/vnc.h                   |  4 ++--
 audio/dbusaudio.c          |  2 +-
 chardev/char-win-stdio.c   |  5 +++++
 hw/display/virtio-gpu-gl.c |  1 +
 ui/clipboard.c             |  2 ++
 ui/cursor.c                |  2 +-
 ui/dbus-clipboard.c        |  4 ++++
 ui/vdagent.c               | 11 ++++++++---
 audio/trace-events         |  2 +-
 ui/trace-events            |  5 ++++-
 10 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.45.2.827.g557ae147e6



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42893C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiS3-0001Mr-Bc; Wed, 05 Mar 2025 01:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiRx-0001Kj-FU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiRv-0001g3-CU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oGMCfQz/0mCo85sR01CH4Yt3ZyufGTuoD5p8+seVIfw=;
 b=aKN389NL3J9ZViIPodsoi0rNcW3Yz5S+Tbm/1ucpaq92W473Y6mbbDW9w+97mkpg8KADAc
 FoaQI8Lb1yy8teIjVa647R9EwMHiuNvuCgPxiZwb8P/uL6+0Ld9QY5w4xRFNRVl8o7hxhD
 1fcYzF/wyhdobYcfHC6LrTyWnMWG/2c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-wncyklFuN7q5Zz5BRB6GbQ-1; Wed,
 05 Mar 2025 01:41:41 -0500
X-MC-Unique: wncyklFuN7q5Zz5BRB6GbQ-1
X-Mimecast-MFC-AGG-ID: wncyklFuN7q5Zz5BRB6GbQ_1741156900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69FF0180087D
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 06:41:40 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A10A11800255; Wed,  5 Mar 2025 06:41:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/6] Ui patches
Date: Wed,  5 Mar 2025 10:41:26 +0400
Message-ID: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to 46f83c898a6658921fed57f98af6d505ab78a6e4:

  chardev: use remoteAddr if the chardev is client (2025-03-05 09:38:09 +0400)

----------------------------------------------------------------
UI-related for 10.0

----------------------------------------------------------------

Haoqian He (1):
  chardev: use remoteAddr if the chardev is client

Roman Penyaev (5):
  ui/console-vc: introduce parsing of the 'ESC ( <ch>' sequence
  ui/console-vc: report to the application instead of screen rendering
  ui/console-vc: report cursor position in the screen not in the scroll
    buffer
  ui/console-vc: add support for cursor DECSC and DECRC commands
  ui/console-vc: implement DCH (delete) and ICH (insert) commands

 chardev/char-socket.c |  10 ++-
 ui/console-vc.c       | 154 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 149 insertions(+), 15 deletions(-)

-- 
2.47.0



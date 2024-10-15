Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F43CFC278
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dI0-00072R-Dw; Tue, 15 Oct 2024 04:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHx-000728-Jj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHn-00088n-IE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F7Jj2N8z8asY0nu6RFtsrgMBmQbeukLqYgfv1WnLY5w=;
 b=ema37rcCDRJk+TB0uAx5o7iV662aSg9Inx80qD26++UXhlJ4Yg/rKuXzPcpPkPES7c+h1l
 XnoEqG1i+xQUR9ymGuI8WN3GUd022CmiiETzuqzGoFJg19FKIfBD1uIR8fThOSV2PWz/pP
 pdEGEYJbXYMnsaPqMoMblFvyAqw4Fxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-xLdWdal9OImbP7IzKQ6EQw-1; Tue,
 15 Oct 2024 04:52:01 -0400
X-MC-Unique: xLdWdal9OImbP7IzKQ6EQw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 073A81955D57; Tue, 15 Oct 2024 08:51:55 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 115FC1956056; Tue, 15 Oct 2024 08:51:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/8] Chr patches
Date: Tue, 15 Oct 2024 12:51:42 +0400
Message-ID: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit aa54f5be44be786636a5d51cc1612ad208a24849:

  tests: update lcitool to fix freebsd py311-yaml rename (2024-10-14 15:54:24 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request

for you to fetch changes up to 95806c7bee232e995ffd963a6fea0a34fbabc937:

  tests/unit/test-char: implement a few mux remove test cases (2024-10-15 12:48:53 +0400)

----------------------------------------------------------------
chardev patch queue

----------------------------------------------------------------

Roman Penyaev (8):
  chardev/char: fix qemu_chr_is_busy() check
  chardev/chardev-internal: remove unused `max_size` struct member
  chardev/mux: use bool type for `linestart` and `term_got_escape`
  chardev/mux: convert size members to unsigned int
  chardev/mux: introduce `mux_chr_attach_frontend() call
  chardev/mux: switch mux frontends management to bitset
  chardev/mux: implement detach of frontends from mux
  tests/unit/test-char: implement a few mux remove test cases

 chardev/chardev-internal.h | 16 ++++---
 include/chardev/char-fe.h  |  2 +-
 chardev/char-fe.c          | 13 ++----
 chardev/char-mux.c         | 90 ++++++++++++++++++++++++++++----------
 chardev/char.c             |  2 +-
 tests/unit/test-char.c     | 24 +++++++++-
 6 files changed, 105 insertions(+), 42 deletions(-)

-- 
2.47.0



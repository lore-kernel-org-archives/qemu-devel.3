Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF40BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENLG-0004QT-Pr; Wed, 07 Oct 2026 04:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0z-00032X-Uw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEK0w-0006AD-Al
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791350178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kT8F2fGfFxlXhfHrYGr6AnWa20i3WHKa6RDdSHTYwb8=;
 b=V2u4vyuibnBdcvLe8uiMBBgQOM/0mPMr6QiNSAzbmgc57p6ANgma2N97n7KpwOQ1zHkjDT
 DjwaHDPoc9R6OkKjIcX/nSeK3q3bt7C8AUfz9ju7CHeqYBcnRmMET9wr4axGboMRbaHlDL
 UQ8WLE5Qz0fGd1NbHcoF5UsHj01cD/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-xtCp0C_HOky77-smeXugcg-1; Tue,
 06 Oct 2026 04:34:54 -0400
X-MC-Unique: xtCp0C_HOky77-smeXugcg-1
X-Mimecast-MFC-AGG-ID: xtCp0C_HOky77-smeXugcg_1791275693
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70BC41955D7F
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 08:34:53 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3B951800361; Tue,  6 Oct 2026 08:34:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/4] Misc fixes patches
Date: Tue,  6 Oct 2026 09:34:47 +0100
Message-ID: <20261006083451.956881-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:

  Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to f33fb19cab412ffbc19e3b7914a320ae1d73709c:

  seccomp: fix blocking of setns/execveat/unshare (2026-10-06 09:17:43 +0100)

----------------------------------------------------------------
Merge USB, I/O and seccomp fixes

* Fix seccomp to use errno action for setns/execveat/unshare
  instead of killing the thread
* Improve TLS performance and avoid test suite timeouts by
  corking TLS writes to increase packet size
* Fix websocket server unbounded read of client data
  CVE-2026-101291
* Avoid use-after-free in MTP device during object delete

----------------------------------------------------------------

Daniel P. Berrangé (3):
  io: prevent unbounded read of websocket data from client
  io: cork TLS writes to avoid small TLS records
  seccomp: fix blocking of setns/execveat/unshare

Tommaso Califano (1):
  hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration

 crypto/tlssession.c         | 45 +++++++++++++++++++
 hw/usb/dev-mtp.c            |  4 +-
 include/crypto/tlssession.h | 25 +++++++++++
 include/io/channel-tls.h    |  1 +
 io/channel-tls.c            | 87 ++++++++++++++++++++++++++++++++++---
 io/channel-websock.c        |  4 +-
 system/qemu-seccomp.c       | 15 +++++--
 7 files changed, 169 insertions(+), 12 deletions(-)

-- 
2.55.0



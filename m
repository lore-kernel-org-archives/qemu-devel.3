Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE0CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeU3-0000xk-Ia; Fri, 16 Oct 2026 05:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTm-0000wH-QS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeTk-0007Jm-GX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21jebgw3izErZYoj/S8SfWSjmUl+CGGyuYmPdy1IDLs=;
 b=W/ApjSDK7lUIY//qXYxt2M8skI7iZobo1DkLsbM27fMhW5xYB+vBaLvm7Vw+zPl90Iqnka
 /fpDA3g4bS/C1vj9Qfd+MrkyZ8cHs/Z9SgGq3QVJFpQmmlgH3159jSBK4kXTp875EckZqK
 PAQG8SoHLac4KLFMRwQfwt5rihLjC80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-W4zb0J4UNheQymE7KMLABQ-1; Fri,
 16 Oct 2026 09:43:52 +0000
X-MC-Unique: W4zb0J4UNheQymE7KMLABQ-1
X-Mimecast-MFC-AGG-ID: W4zb0J4UNheQymE7KMLABQ_1792143831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 573DF1955EA6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:43:51 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E5663000735; Fri, 16 Oct 2026 09:43:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/8] Misc fixes patches
Date: Fri, 16 Oct 2026 10:43:40 +0100
Message-ID: <20261016094348.2616374-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit d5b5083cb783c447001e862c2b525e59f48ad78c:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-15 11:53:41 +0200)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 87e403247d318a6b782d3ffe20e1442197d032fe:

  Revert "crypto: implement workaround for GNUTLS thread safety problems" (2026-10-15 16:52:01 +0100)

----------------------------------------------------------------
* Really fix blocking of setns/execveat/unshare in seccomp
* Fail fast in qtest when QEMU terminates before a connection
  is established
* Deprecate use of instance properties in QOM to encourage greater
  use of class properties in new code
* Drop obsolete, disabled & broken migration workaround for gnutls
  thread safety bug

----------------------------------------------------------------

Daniel P. Berrangé (8):
  seccomp: really fix blocking of setns/execveat/unshare
  seccomp: drop redundant match for clone() flags == 0
  qtest: fail fast when QEMU terminates early
  qom: deprecate use of instance level properties
  Revert "migration: activate TLS thread safety workaround"
  Revert "io: add support for activating TLS thread safety workaround"
  Revert "crypto: add tracing & warning about GNUTLS countermeasures"
  Revert "crypto: implement workaround for GNUTLS thread safety
    problems"

 crypto/tlssession.c         | 103 ++----------------------------------
 crypto/trace-events         |   1 -
 include/crypto/tlssession.h |  14 -----
 include/io/channel.h        |   1 -
 include/qom/object.h        |  27 ++++++++--
 io/channel-tls.c            |   5 --
 meson.build                 |   9 ----
 migration/tls.c             |   9 ----
 system/qemu-seccomp.c       |  15 ++----
 tests/qtest/libqtest.c      |  45 ++++++++++------
 10 files changed, 58 insertions(+), 171 deletions(-)

-- 
2.56.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F7DC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RGj-0007xP-DW; Tue, 15 Sep 2026 07:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGg-0007x8-Rk
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6RGf-0001mE-6L
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789471443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ajmv3idkFrIkGEnYfGFoP5WuDJUNS00hgWmwblGc+AU=;
 b=OlxP6krgVxERJyC3WA/93PkGaH8WsBFq/4Kh6+xmYWxrgZbrhVNjo6RIzgtJ8cnF3P2PJG
 bzdkliTpFqWpr3nHvDYwDTW8LRSXo03Ymo0KCkaq3+8XLDpWBGNkno9pfRtvfg84doRI3Z
 40yAq49f0qDfxDMFsdYOkZ2L0H/wUJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-b3i62HNxPr6rKVLGlEV9NQ-1; Tue,
 15 Sep 2026 07:24:01 -0400
X-MC-Unique: b3i62HNxPr6rKVLGlEV9NQ-1
X-Mimecast-MFC-AGG-ID: b3i62HNxPr6rKVLGlEV9NQ_1789471441
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE1AD1869D9C; Tue, 15 Sep 2026 11:24:00 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.49.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59E9F1956045; Tue, 15 Sep 2026 11:23:59 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 00/19] Misc fixes for QEMU Guest Agent (2026-09-15)
Date: Tue, 15 Sep 2026 14:23:18 +0300
Message-ID: <20260915112337.43307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:

  Merge tag 'ui-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-09-15

for you to fetch changes up to 839bc113fb5e2aea3fd0d68a929725f76cd6a9b1:

  qga/vss-win32: log to file during COM+ registration (2026-09-15 14:09:40 +0300)

----------------------------------------------------------------
qga-pull-2026-09-15

----------------------------------------------------------------
Kostiantyn Kostiuk (1):
      qga: Change effective user/group ID in guest-ssh-* commands

Marc-André Lureau (17):
      qga/installer: preserve VssOption registry value across upgrades
      qga/vss-win32: fix race condition in COM Release() methods
      qga/vss-win32: pass valid SERVICE_STATUS to ControlService
      qga/vss-win32: explicit NULL/zero initialization
      qga/vss-win32: free bstrWriterName in outer writer loop
      qga/vss-win32: pass character count instead of byte count to volume APIs
      qga/vss-win32: allow pceltFetched==NULL in IEnumObject::Next
      qga/vss-win32: return an interface pointer for IID_IUnknown
      qga/vss-win32: use GetLastError() after FindFirstVolumeW failure
      qga/vss-win32: guard CloseServiceHandle calls against NULL handles
      qga/vss-win32: avoid CRT calls in DllMain debug logging
      qga/vss-win32: evaluate err_set() macro argument only once
      qga/vss-win32: report QueryStatus return value on failure
      qga/vss-win32: check GetLastError() after FindNextVolumeW failure
      qga/vss-win32: initialize *num_vols at start of requester_freeze
      qga/vss-win32: restrict access to freeze/thaw synchronisation events
      qga/vss-win32: log to file during COM+ registration

Roman Bogorodskiy (1):
      qga: implement 'guest-get-fsinfo' for FreeBSD

 qga/commands-bsd.c          | 53 +++++++++++++++++++++++++++-
 qga/commands-common.h       |  1 +
 qga/commands-posix-ssh.c    | 71 +++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c        |  3 ++
 qga/installer/qemu-ga.wxs   | 19 ++++++++--
 qga/qapi-schema.json        | 12 +++----
 qga/vss-win32/install.cpp   | 31 ++++++++++++++---
 qga/vss-win32/provider.cpp  | 17 +++++----
 qga/vss-win32/requester.cpp | 85 +++++++++++++++++++++++++++++++++++++--------
 9 files changed, 257 insertions(+), 35 deletions(-)


--
2.55.0



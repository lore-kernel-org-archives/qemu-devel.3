Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E21E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsecs-0000Os-A9; Wed, 18 Feb 2026 05:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vseco-0000Nw-6p
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vsecm-0005an-4R
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 05:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771409858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lg5FA2JQLWlSZ4H6+50PJYINC2+hef16WtTlpZ9+D+w=;
 b=Odn4GcJG3Xy7XwDU2LHkurPBN7RZj0gHiU56IkB3H1JH03bG/N4XQowv+VL5rZkOzm8+sN
 Q0KzTEEfv5Lr8+mWNZ9nynUw25J4nk7GeGczlgHHzpjHrHiR+qfo+WrMTPu/OP91lBOGVk
 dFfBTLuld6hXbvnw7uGbRoWFhDK9184=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-ZJvMrG3bOn-G9KYXlCjUnQ-1; Wed,
 18 Feb 2026 05:17:34 -0500
X-MC-Unique: ZJvMrG3bOn-G9KYXlCjUnQ-1
X-Mimecast-MFC-AGG-ID: ZJvMrG3bOn-G9KYXlCjUnQ_1771409853
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CB63195605C; Wed, 18 Feb 2026 10:17:33 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2999A30001A5; Wed, 18 Feb 2026 10:17:31 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 0/3] QGA misc fixes and improvements (2026-02-16)
Date: Wed, 18 Feb 2026 12:17:26 +0200
Message-ID: <20260218101729.92630-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-02-16-2

for you to fetch changes up to 374f4676788ca1f1c5a33670efeafff4ce936f79:

  qga: Fix VSS provider GetSnapshotProperties return value (2026-02-18 11:27:57 +0200)

----------------------------------------------------------------
qga-pull-2026-02-16-2

v2: Rebased

----------------------------------------------------------------
Elizabeth Ashurov (3):
      qga: implement guest-network-get-route for Windows
      qga: Move CoInitialize/CoInitializeSecurity to main process thread
      qga: Fix VSS provider GetSnapshotProperties return value

 qga/commands-win32.c        | 172 ++++++++++++++++++++++++++++++++++++++++++++
 qga/main.c                  |  42 +++++++++++
 qga/qapi-schema.json        |  11 +--
 qga/vss-win32/provider.cpp  |   2 +-
 qga/vss-win32/requester.cpp |  13 ----
 5 files changed, 221 insertions(+), 19 deletions(-)

--
2.52.0



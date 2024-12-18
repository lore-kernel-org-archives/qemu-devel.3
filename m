Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E2DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsmv-0001ar-On; Wed, 18 Dec 2024 07:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmI-0001VH-EX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsmB-00065f-1v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w7S8gCXCaZDXrchATTVtEFwvhZ+Xm+BDYGwPiPYysSk=;
 b=Cc6nB2PiTim5654jUfvv58U7hGTW9oN4zUjo9tfVnuhnPKkkcsVu8060KcUjnRfMfsMGbz
 uYWQELuQkPYcKnWMxRjfPpMFSBDaiZU6JgPum4YgbdgwMb97IwFh0urfYvL44mxqT/xvm+
 DDwZFEuinGunDGWNuzRVv9EDnAV6Hv4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-eyS53BhTOaiaJTCpdjoRCw-1; Wed,
 18 Dec 2024 07:03:27 -0500
X-MC-Unique: eyS53BhTOaiaJTCpdjoRCw-1
X-Mimecast-MFC-AGG-ID: eyS53BhTOaiaJTCpdjoRCw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 299B81955F41; Wed, 18 Dec 2024 12:03:26 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F3A930044C1; Wed, 18 Dec 2024 12:03:24 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Misc QGA patches for 2024-12-18
Date: Wed, 18 Dec 2024 14:03:18 +0200
Message-ID: <20241218120321.34998-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:

  Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-12-18

for you to fetch changes up to 2657a92b5479c8705b128ed1e55feb8960ed498a:

  qga: Don't access global variable in run_agent_once() (2024-12-18 13:46:16 +0200)

----------------------------------------------------------------
qga-pull-2024-12-18

----------------------------------------------------------------
Dehan Meng (1):
      qemu-ga-win: Fix a typo error

Jean-Louis Dupond (1):
      qga: skip bind mounts in fs list

Michal Privoznik (1):
      qga: Don't access global variable in run_agent_once()

 qga/commands-linux.c | 25 +++++++++++++++++++++++++
 qga/commands-win32.c |  2 +-
 qga/main.c           |  2 +-
 3 files changed, 27 insertions(+), 2 deletions(-)

--
2.47.1



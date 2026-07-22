Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF21C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXSZ-0007gW-VE; Wed, 22 Jul 2026 09:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSU-0007em-UD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSR-0006sW-TK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784728677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BMtkz3dwgulQR+MIZqYUHzDaso+9cR/J6ZqFdeCXVGI=;
 b=Jk93EaseNnyuAXU8w6F784qcZ/LWsEg2GcUFgoFnFbqJJT0qTJRUqxS9mwoQNB+NfGyyL+
 M2v+qeLZQAmdqgG/0eKq20EStrL0RIu2SMZmH1lZed51X8bDK1QS+ZErX/1jgZkZvLtEAd
 +g6qQ4Qgzam0FbcQj+CgqYvYOPNK6Y4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-wwe29QV0MNGIejUMzuUHog-1; Wed,
 22 Jul 2026 09:57:55 -0400
X-MC-Unique: wwe29QV0MNGIejUMzuUHog-1
X-Mimecast-MFC-AGG-ID: wwe29QV0MNGIejUMzuUHog_1784728674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4262F195FDE8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:57:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA3841800623; Wed, 22 Jul 2026 13:57:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 521491825489; Wed, 22 Jul 2026 15:57:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/6] Firmware 20260722 patches
Date: Wed, 22 Jul 2026 15:57:44 +0200
Message-ID: <20260722135752.1264244-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The following changes since commit cbd42e2b75b23953a9bdb073c8531518b1bd6163:

  Update version for v11.1.0-rc1 release (2026-07-21 13:18:25 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260722-pull-request

for you to fetch changes up to bd9b3c50f458ce24fee084916cf0eba58bd9a33b:

  hw/uefi: make SetupMode read-only (2026-07-22 15:22:40 +0200)

----------------------------------------------------------------
hw/uefi: security fix collection

----------------------------------------------------------------

Gerd Hoffmann (6):
  hw/uefi: add sanity check
  hw/uefi: remove debug function
  hw/uefi: check lower limit for signature list size
  hw/uefi: account variable policy entries against storage size
  hw/uefi: add post_load checks
  hw/uefi: make SetupMode read-only

 hw/uefi/var-service-auth.c    |  7 ++++
 hw/uefi/var-service-core.c    | 14 +++++++-
 hw/uefi/var-service-json.c    |  5 +++
 hw/uefi/var-service-policy.c  | 68 ++++++++++++++++-------------------
 hw/uefi/var-service-siglist.c |  3 ++
 hw/uefi/var-service-vars.c    | 19 ++++++++++
 6 files changed, 78 insertions(+), 38 deletions(-)

-- 
2.55.0



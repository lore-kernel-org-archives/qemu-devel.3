Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94505C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullp5-0002FO-0v; Tue, 12 Aug 2025 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullp2-0002EX-1S
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullou-0004vh-KX
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754992878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DL6yzzs0REsZ96GXUgN5d7qFwvuNp7z9/3qhV55tmDg=;
 b=arA3+OQox3qAD5kxpQ8hQN7OZeeJ33i6NGtwg/M2V1rq0wGVsqP/sTuOTZCkWFokege3rf
 glvEKJ8C1euQkkygiUtach99DFu4mkBJb32735Iigdj5E/gqEuCG9fq3ElWu0iZgMnRo3B
 3qufTM1US3U6z72tga8jxlwBMeMSmYA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-4nFIaMFxM12_crCZ2Iz3ww-1; Tue,
 12 Aug 2025 06:01:17 -0400
X-MC-Unique: 4nFIaMFxM12_crCZ2Iz3ww-1
X-Mimecast-MFC-AGG-ID: 4nFIaMFxM12_crCZ2Iz3ww_1754992874
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C03C1956089
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:01:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C582330001A1; Tue, 12 Aug 2025 10:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 39F8218000B2; Tue, 12 Aug 2025 12:01:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/4] Uefi 20250812 patches
Date: Tue, 12 Aug 2025 12:01:06 +0200
Message-ID: <20250812100111.1520917-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 624d7463043c120facfab2b54985fcfb679d5379:

  Merge tag 'pull-nvme-20250811' of https://gitlab.com/birkelund/qemu into staging (2025-08-11 12:57:55 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/uefi-20250812-pull-request

for you to fetch changes up to 040237436f423253f3397547aa78d449394dfbca:

  hw/uefi: open json file in binary mode (2025-08-12 08:03:16 +0200)

----------------------------------------------------------------
hw/uefi: last-minute bug fixes for the uefi variable store [for 10.1]

----------------------------------------------------------------

Gerd Hoffmann (3):
  hw/uefi: return success for notifications
  hw/uefi: check access for first variable
  hw/uefi: open json file in binary mode

Mauro Matteo Cascella (1):
  hw/uefi: clear uefi-vars buffer in uefi_vars_write callback

 hw/uefi/var-service-core.c | 4 ++--
 hw/uefi/var-service-json.c | 2 +-
 hw/uefi/var-service-vars.c | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33F6D11707
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTDu-0001Om-OA; Tue, 02 Dec 2025 11:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQTDV-0001IY-1S
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQTDR-0004j6-Nw
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764692819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qh1W3aoF36kAbxT8BtCU3jJMg8lG6NhprtDyEC42MzY=;
 b=OL64v5AS9hsKjQXi/henIFQbcBy1/Y0aHuRUdE/jQAN+u8eoFBFYK++ouXTILC7aO4p14p
 EEr+3t74kDlQaiXHg2hbW6q2sidfkFamSJzJekTujJ76uZiZ8+hBKcCtUAjTf3iT8IW5TP
 RV56hCh16Qj2tq6p6PzclRzYMF54GBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-9HaBNUl-MbuFPxNCJk1rdw-1; Tue,
 02 Dec 2025 11:26:55 -0500
X-MC-Unique: 9HaBNUl-MbuFPxNCJk1rdw-1
X-Mimecast-MFC-AGG-ID: 9HaBNUl-MbuFPxNCJk1rdw_1764692813
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5AE01955F03; Tue,  2 Dec 2025 16:26:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.249])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38F1E3001E83; Tue,  2 Dec 2025 16:26:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/1] Block layer patches
Date: Tue,  2 Dec 2025 17:26:44 +0100
Message-ID: <20251202162645.182909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 66ec38b6fa593afcc26a2dfb5d1f9871dd15f527:

  Merge tag 'pull-target-arm-20251201' of https://gitlab.com/pm215/qemu into staging (2025-12-01 12:08:52 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d94ea1a10bdfb99c5822e64a5b6ee3e352719326:

  file-posix: Handle suspended dm-multipath better for SG_IO (2025-12-02 16:51:47 +0100)

----------------------------------------------------------------
Block layer patches

- SCSI passthrough: Fix errors on temporarily suspended dm-multipath

----------------------------------------------------------------
Kevin Wolf (1):
      file-posix: Handle suspended dm-multipath better for SG_IO

 block/file-posix.c | 56 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 22 deletions(-)



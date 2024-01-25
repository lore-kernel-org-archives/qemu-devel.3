Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B63BC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 08:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvOO-0003Xz-H6; Thu, 25 Jan 2024 03:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rSvOH-0003XV-3Z
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rSvOF-00025W-Jr
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706172434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R7RQcAZsws9ojasCXKv6znhRl+JeHjjwggM5cdp1qwk=;
 b=OSAE3FYlGA1wgSu5EZsq3LCn7rLNE41uILSamIzP5WPh60hcM9KBAWvVH0l3sWfKS78rIZ
 5jyF+FiCvSBM5vDCwieKGZ546FqsoWh21l3E8iW3NItgmp+MsYpV0A4olSa/crY1uqr9dM
 O8WFoLBWG0JDGNQ/tyUDDyhLljEJl0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-0EoZzf3xNXuCFuwRa19v_w-1; Thu, 25 Jan 2024 03:47:12 -0500
X-MC-Unique: 0EoZzf3xNXuCFuwRa19v_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCA2D85A5B6;
 Thu, 25 Jan 2024 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6E5F1121313;
 Thu, 25 Jan 2024 08:47:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/1] Net patches
Date: Thu, 25 Jan 2024 16:47:03 +0800
Message-ID: <20240125084704.19301-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 4a4efae44f19528589204581e9e2fab69c5d39aa:

  Merge tag 'pull-hex-20240121' of https://github.com/quic/qemu into staging (2024-01-23 13:40:45 +0000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git net-pull-request

for you to fetch changes up to 2220e8189fb94068dbad333228659fbac819abb0:

  virtio-net: correctly copy vnet header when flushing TX (2024-01-25 14:58:00 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Jason Wang (1):
      virtio-net: correctly copy vnet header when flushing TX

 hw/net/virtio-net.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)



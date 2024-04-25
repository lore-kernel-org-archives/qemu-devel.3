Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F25C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 21:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s06ul-0000j3-3Y; Thu, 25 Apr 2024 17:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s06uY-0000Xz-19
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s06uQ-0004VH-SA
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 17:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714081536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S09hMLPCWaH1TC501DwThp79RvZIU7kUwkYAGjVQdtI=;
 b=Pi3g10Y2WdGwMe/Yl7wz+SXtFRo5wZEDCprPXLzTqB87OuohWyDBGnD5v6u4PL8+ANo7ql
 lQRDJP1NAhn1Lk693y55WRS5tjofXeLu9zpRfkK8JXj0AATvpUFTYJi3tcX3YNWzrFWFDq
 4B7+jSxTI6ibApHCPWb1P7IsdPa1ORk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-uDC_xcAwMWmQ1eB1pkrjhQ-1; Thu, 25 Apr 2024 17:44:30 -0400
X-MC-Unique: uDC_xcAwMWmQ1eB1pkrjhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B011281B561;
 Thu, 25 Apr 2024 21:44:29 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 181B9EC680;
 Thu, 25 Apr 2024 21:44:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: [PULL 0/2] NBD patches for 2024-04-25
Date: Thu, 25 Apr 2024 16:43:43 -0500
Message-ID: <20240425214425.571652-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:

  Merge tag 'pull-tcg-20240424' of https://gitlab.com/rth7680/qemu into staging (2024-04-24 15:51:49 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-04-25

for you to fetch changes up to 4fa333e08dd96395a99ea8dd9e4c73a29dd23344:

  nbd/server: Mark negotiation functions as coroutine_fn (2024-04-25 12:59:19 -0500)

----------------------------------------------------------------
NBD patches for 2024-04-25

- Avoid calling poll() within coroutine

----------------------------------------------------------------
Eric Blake (1):
      nbd/server: Mark negotiation functions as coroutine_fn

Zhu Yangyang (1):
      nbd/server: do not poll within a coroutine context

 nbd/nbd-internal.h |  10 -----
 nbd/client.c       |  28 ++++++++++--
 nbd/common.c       |  11 -----
 nbd/server.c       | 128 +++++++++++++++++++++++++++++++++--------------------
 4 files changed, 105 insertions(+), 72 deletions(-)

-- 
2.44.0



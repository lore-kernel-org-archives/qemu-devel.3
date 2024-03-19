Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63784C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma64-0004P8-Pm; Tue, 19 Mar 2024 10:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma64-0004P0-6b
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma62-0008N5-Ik
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+MyJV01TPbOVh+Z+5doXHBhA/AcQghAwHkKKDsrkAY4=;
 b=d1dgxf+Zw5gpDqZV/vtQCQI+5YKIHGidkmMi/c3EhqJ4unrmVuN4rnJLWz1Usif2oqzRk/
 dsBxWyQSLPR8Rl0WsLigam5zQBT/EXJFcxNUhcTH9biEhDgZ/D74DSUseC8ZTJe7hnik7l
 t8+Qa417EuPZK2fZy44hWWoKnXIHQwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329--3yEGyHpMceCj1lEbnXJPw-1; Tue, 19 Mar 2024 10:05:39 -0400
X-MC-Unique: -3yEGyHpMceCj1lEbnXJPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF1FC185A783
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:05:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CBC73C54;
 Tue, 19 Mar 2024 14:05:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/3] for-9.0 queue
Date: Tue, 19 Mar 2024 15:05:13 +0100
Message-ID: <20240319140516.392542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 4511400fb78e72d4d9916ed60e04f4e99e594f65:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2024-03-18 17:16:08 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-for-9.0-20240319

for you to fetch changes up to a7538ca0791880b6aeb2cc4cc8c00305e2d975f8:

  aspeed/smc: Only wire flash devices at reset (2024-03-19 11:58:15 +0100)

----------------------------------------------------------------
aspeed, pnv, vfio queue:

* user device fixes for Aspeed and PowerNV machines
* coverity fix for iommufd

----------------------------------------------------------------
Cédric Le Goater (3):
      vfio/iommufd: Fix memory leak
      ppc/pnv: I2C controller is not user creatable
      aspeed/smc: Only wire flash devices at reset

 include/hw/block/flash.h  |  2 ++
 hw/arm/xlnx-versal-virt.c |  3 ++-
 hw/block/m25p80.c         |  1 -
 hw/ppc/pnv_i2c.c          |  3 +++
 hw/ssi/aspeed_smc.c       |  9 +++++++++
 hw/vfio/iommufd.c         | 19 ++++++++-----------
 6 files changed, 24 insertions(+), 13 deletions(-)



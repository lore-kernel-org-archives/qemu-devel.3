Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C91C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugMzs-0000ce-CL; Mon, 28 Jul 2025 08:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugMO8-0003xN-Ri
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugMO4-000441-Aa
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753703482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZFvv36m5p1+mBAa7Tl86a2mpTfnUUEZMSbO4mFzJU5Q=;
 b=QvNrJrePZ4qJ7koMxL5+d9E9DKzZdnqZs3U8zbS1eKkVFZnRncrxw8Adr+BAGt92QDGcHu
 6oJSLZ1PUH0nmS+h6E5ikehtQIouAl6zXIvw4J5YMsNP2MDChqFxGIKEB+5rGltFEXKSrS
 Dy/6qogTqlr1jTWJ4sUEmsLIVBbveNc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-nQm0lFO3OAqXvyiP2i5wzQ-1; Mon,
 28 Jul 2025 07:51:20 -0400
X-MC-Unique: nQm0lFO3OAqXvyiP2i5wzQ-1
X-Mimecast-MFC-AGG-ID: nQm0lFO3OAqXvyiP2i5wzQ_1753703479
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DCA019560B2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:51:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5507D1800B6B
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:51:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F50B21E6A27; Mon, 28 Jul 2025 13:51:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/4] QGA documentation patches for 2025-07-28
Date: Mon, 28 Jul 2025 13:51:12 +0200
Message-ID: <20250728115116.2938867-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit c017386f28c03a03b8f14444f8671d3d8f7180fe:

  Merge tag 'pull-target-arm-20250725' of https://gitlab.com/pm215/qemu into staging (2025-07-25 08:24:52 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qga-2025-07-28

for you to fetch changes up to 62e1fa22f5734d1325e3b75cdc59f02c16339330:

  qga: Add cross-references (2025-07-28 13:45:21 +0200)

----------------------------------------------------------------
QGA documentation patches for 2025-07-28

----------------------------------------------------------------
Markus Armbruster (4):
      qga: Fix guest-network-get-route return value documentation
      qga: Remove trivial "Returns:" sections
      qga: Rephrase return docs to avoid type name
      qga: Add cross-references

 qga/qapi-schema.json | 109 ++++++++++++++++++++-------------------------------
 1 file changed, 42 insertions(+), 67 deletions(-)

-- 
2.49.0



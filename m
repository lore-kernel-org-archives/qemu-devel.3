Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1EEC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWBTo-0002pQ-7c; Sat, 03 Feb 2024 03:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTn-0002om-4O
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTi-0007Ia-LJ
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706949262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2pvQVSjlqEcq0RCsXD6/VctXYZTXdYXv3U84pAlQMOA=;
 b=cDSuvOoH48znGznybex+iyr07cQi4LJ7EbkAqF5p3W/d8euecy9+NwtM/R0NlDqCmsOIb3
 FW/easTRAQitFWrRVsVu+ju0/8YMEc3jGTCoT0GJ4of86StcXWJR8blxxi+86pAN1l5y0W
 bkU1QpFa+JzLFL/Wj30MG8IpJA24RTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-BiIIir58OECIibddthcnuw-1; Sat, 03 Feb 2024 03:34:17 -0500
X-MC-Unique: BiIIir58OECIibddthcnuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 428BF83106C;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A3051121306;
 Sat,  3 Feb 2024 08:34:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED4EB21E66CD; Sat,  3 Feb 2024 09:34:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/5] QAPI patches patches for 2024-02-03
Date: Sat,  3 Feb 2024 09:34:10 +0100
Message-ID: <20240203083415.2937003-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 29b008927ef6e3fbb70e6607b25d3fcae26a5190:

  Merge tag 'pull-nic-config-2-20240202' of git://git.infradead.org/users/dwmw2/qemu into staging (2024-02-02 16:47:36 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-03

for you to fetch changes up to 3424ed6caf9759eb57405d965537fd5f3d70026b:

  qga/qapi-schema: Move command description right after command name (2024-02-03 09:20:33 +0100)

----------------------------------------------------------------
QAPI patches patches for 2024-02-03

----------------------------------------------------------------
Markus Armbruster (5):
      qapi: Drop redundant documentation of inherited members
      qapi: Drop redundant documentation of conditional
      qapi: Elide "Potential additional modes" from generated docs
      qga: Move type description right after type name
      qga/qapi-schema: Move command description right after command name

 qapi/block-core.json   |  6 ++----
 qapi/block-export.json | 11 ++++++-----
 qapi/introspect.json   |  2 --
 qapi/misc-target.json  |  2 --
 qga/qapi-schema.json   | 18 +++++++++---------
 5 files changed, 17 insertions(+), 22 deletions(-)

-- 
2.43.0



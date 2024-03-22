Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34EBC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaD-0002v9-LA; Fri, 22 Mar 2024 10:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaC-0002up-7D
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaA-0003XD-D9
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ZzgKh7lbHrK/2chbp08P1rMS09VevJ1ZZMNvjesXiQ=;
 b=ZcSf3fTtjUueaVmeSkCp9lQ7edfls3VJSllbw0ETVqe+UxVdL2f+2r88RdSNCJVDQ9uu2z
 +uP2U7/fB/glU42xyp9ym41pnig8RFX+ZBIxD8MjaKjhxUGMcVBqSQ1xvia0+YBfDSiji6
 FPlzvTt0noKquZRr+JDHcipOgH3s1TA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-q3bVP7wvPQaZYjasfGmZeQ-1; Fri, 22 Mar 2024 10:09:16 -0400
X-MC-Unique: q3bVP7wvPQaZYjasfGmZeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9C21185A786;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA3DB200AD5B;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFC8921E680D; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 00/12] qapi: Fairly trivial documentation work
Date: Fri, 22 Mar 2024 15:08:58 +0100
Message-ID: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster (12):
  qapi: Drop stray Arguments: line from qmp_capabilities docs
  qapi: Expand a few awkward abbreviations in documentation
  qapi: Tidy up block-latency-histogram-set documentation some more
  qapi: Tidy up indentation of add_client's example
  qapi: Fix argument markup in drive-mirror documentation
  qapi: Fix typo in request-ebpf documentation
  qapi: Fix abbreviation punctuation in doc comments
  qapi: Start sentences with a capital letter, end them with a period
  qapi: Don't repeat member type in its documentation text
  qapi: Refill doc comments to conform to current conventions
  qapi: Correct documentation indentation and whitespace
  qga/qapi-schema: Refill doc comments to conform to current conventions

 qapi/block-core.json     |  46 +++++------
 qapi/block.json          |  14 ++--
 qapi/control.json        |   2 -
 qapi/crypto.json         |  12 +--
 qapi/cxl.json            |   4 +-
 qapi/dump.json           |  18 ++---
 qapi/ebpf.json           |  14 ++--
 qapi/machine-target.json |  22 +++---
 qapi/machine.json        |  18 ++---
 qapi/migration.json      | 162 +++++++++++++++++++--------------------
 qapi/misc.json           |   8 +-
 qapi/net.json            |  27 ++++---
 qapi/qom.json            |  38 ++++-----
 qapi/replay.json         |   4 +-
 qapi/run-state.json      |  19 ++---
 qapi/sockets.json        |   3 +-
 qapi/ui.json             |  16 ++--
 qapi/virtio.json         |  20 +++--
 qga/qapi-schema.json     |  29 ++++---
 19 files changed, 240 insertions(+), 236 deletions(-)

-- 
2.44.0



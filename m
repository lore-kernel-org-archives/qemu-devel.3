Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2E2606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MjgrEZfq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzP0-0007cx-1x; Mon, 16 Nov 2026 11:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xSzOk-0007Xw-3G
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xSzOh-0002bw-Er
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794845853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y9eom8DMxyorn0LFddbw8bdN6fUInUgH83sjtyM6WjY=;
 b=MjgrEZfqrxPNmx3yMqn2oHqNKwTAbvjIlnMHfahArXlJMyKZIncvf/CRwYWFgfN/QPJX0E
 RtRvyQSWypuJ9Qac8aKGyZICmrB03E6TJ6qYhU0UsWJxxcXY5zE0ozj/x77CrCeX27ECAb
 0UDfIJ7OQ1+tzHvRAy6+JGI1Gh0eJJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-S4z_nOrFN7yzi0Ma2e-rXQ-1; Mon,
 16 Nov 2026 11:16:24 -0500
X-MC-Unique: S4z_nOrFN7yzi0Ma2e-rXQ-1
X-Mimecast-MFC-AGG-ID: S4z_nOrFN7yzi0Ma2e-rXQ_1794845784
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA0A218004F9; Mon, 16 Nov 2026 16:16:23 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB9D410; Mon, 16 Nov 2026 16:16:20 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, dholler@redhat.com,
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com,
 kramdoss@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v3 0/2] qga: Add Windows driver information commands
Date: Mon, 16 Nov 2026 18:16:06 +0200
Message-ID: <20261116161608.1145725-1-eashurov@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces two new QGA commands for Windows:
* guest-get-driver-packages: retrieve out-of-box driver packages from the
  Windows Driver Store.
* guest-get-driver-services: retrieve registered driver services and
  their metadata from the Service Control Manager and driver binaries.

Changes in v3:
Convert the NT path prefix (\??\) to the Win32 prefix (\\?\)
instead of removing it, to preserve volume GUID paths.
Patch 1 remains unchanged.

Elizabeth Ashurov (2):
  qga: Add guest-get-driver-packages command for Windows
  qga: Add guest-get-driver-services command for Windows

 qga/commands-win32.c | 656 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   5 +-
 qga/qapi-schema.json |  89 ++++++
 3 files changed, 748 insertions(+), 2 deletions(-)

-- 
2.55.0



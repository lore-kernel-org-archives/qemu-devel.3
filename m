Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8462606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JE5hqbgT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4pZ-0000yB-OR; Wed, 28 Oct 2026 10:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pS-0000vW-5w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pP-000585-6Q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793198434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HvVIqEl3MfAcPhJSqx/mrF+17u6MIIPJcP22VIdAn4o=;
 b=JE5hqbgTmPsA7W42we5JBh2bSo7P/QtPmLYMo+PS2Cm/4HJdh1QoP+u8gx8IaP1K2GKxUT
 75LoKfqDJ9A9Qjh/89bZZBhBBloaUGupnkIBLCBZRX4ePvhwHfruH8vnzUC8DAT94yGyBh
 MdEatvwICa9FH6Axb86GBG2avP/b/bk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-c-PrkD3mPgiYnCItvdjDXg-1; Wed,
 28 Oct 2026 10:40:32 -0400
X-MC-Unique: c-PrkD3mPgiYnCItvdjDXg-1
X-Mimecast-MFC-AGG-ID: c-PrkD3mPgiYnCItvdjDXg_1793198432
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D848B1800358
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 987BA1800495
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D562221E6A04; Wed, 28 Oct 2026 15:40:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	berrange@redhat.com
Subject: [PATCH 0/4] qapi: Minor doc and markup fixes
Date: Wed, 28 Oct 2026 15:40:19 +0100
Message-ID: <20261028144028.771869-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

PATCH 3+4 conflict with "[PATCH 0/8] qapi: last minute
improvements/changes to -compat insecure-types" Daniel just posted.
I'm posting anyway to get some eyes on this.  I can take care of the
conflicts.

Markus Armbruster (4):
  qapi/acpi-hest: Fix markup of heading
  qapi: Fix inaccurate comment on pragma member-name-exceptions
  qapi/compat: Fix inaccurate CompatPolicy introduction
  qapi/compat: Fix "only syntactic aspects of QMP" note

 qapi/acpi-hest.json |  3 ++-
 qapi/compat.json    | 17 +++++++++--------
 qapi/pragma.json    |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.55.0



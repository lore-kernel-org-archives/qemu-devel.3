Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C094C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueslB-0007xO-Rw; Thu, 24 Jul 2025 06:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uesl5-0007s9-Rq
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uesl2-000436-NV
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753351259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=8jMKgtAJCCH0P2cU5dJ6J+Cc+xt7j8AfZXNiI1pX2i8=;
 b=Rct1M3X1asTTz3VastU45UOw3Wci8FNmEFclU+jWeJ7xTRJSyC1zrsADivZnYI4TaaOUtq
 Oy0a6JnA1o/G8zhPWF6O7BLB2ts+jGGuq2hzS5zkeRVeBQql+OWiAjhP3Dsqj++KsjJH0R
 1U4Gu2SREZAMLwo2GQ09Gf5RzpIMIjU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-t5QFC_f7NWaR22hACFtLvA-1; Thu,
 24 Jul 2025 06:00:58 -0400
X-MC-Unique: t5QFC_f7NWaR22hACFtLvA-1
X-Mimecast-MFC-AGG-ID: t5QFC_f7NWaR22hACFtLvA_1753351257
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FD6D18009C9; Thu, 24 Jul 2025 10:00:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CE7B1966666; Thu, 24 Jul 2025 10:00:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8504B21E6A27; Thu, 24 Jul 2025 12:00:54 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 24 Jul 2025 12:00:54 +0200
Resent-Message-ID: <874iv1oqll.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Thu Jul 24 11:17:42 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59E4121E6A27; Thu, 24 Jul 2025 11:17:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	eblake@redhat.com,
	philmd@linaro.org
Subject: [PATCH 0/2] qapi: Fixes related to change of doc heading markup
Date: Thu, 24 Jul 2025 11:17:40 +0200
Message-ID: <20250724091742.1950167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster (2):
  qapi/accelerator: Fix markup of heading
  tests/qapi-schema: Bury dead test case doc-non-first-section

 qapi/accelerator.json                        | 4 +++-
 tests/qapi-schema/doc-non-first-section.err  | 1 -
 tests/qapi-schema/doc-non-first-section.json | 6 ------
 tests/qapi-schema/doc-non-first-section.out  | 0
 4 files changed, 3 insertions(+), 8 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-non-first-section.err
 delete mode 100644 tests/qapi-schema/doc-non-first-section.json
 delete mode 100644 tests/qapi-schema/doc-non-first-section.out

-- 
2.49.0




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98388C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwk-00063M-DS; Fri, 04 Apr 2025 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwK-0005qk-Q3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwH-0005q9-38
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OcY7IHT/xYZEmsySGTXSoAki5AlfCSck5k8x4DeNMWg=;
 b=ffN+QnF5wuqcsFINdTtAjncVebsbtsEGrR0D4tePDTLwugcdrSZ3yA+XhhucAZMJ/LoUDK
 n/pRbd8leCPuIbB9ONQbNUR0YKXmvL+yOvfAk+pXGrE7mZ5HlkWXgnjsv+cy+sKwP0R4cv
 GdRPQhGLMmIHg9W3g/LWlWLw6+f0DOI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-gUahpjXWNU2zTtCY6zsqHg-1; Fri,
 04 Apr 2025 08:14:19 -0400
X-MC-Unique: gUahpjXWNU2zTtCY6zsqHg-1
X-Mimecast-MFC-AGG-ID: gUahpjXWNU2zTtCY6zsqHg_1743768858
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28A12180AF6A; Fri,  4 Apr 2025 12:14:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B7773001D0E; Fri,  4 Apr 2025 12:14:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 625E921E66C5; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 00/11] qapi: Documentation improvements
Date: Fri,  4 Apr 2025 14:14:02 +0200
Message-ID: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Markus Armbruster (11):
  docs/devel/qapi-code-gen: Tidy up whitespace
  qapi/rocker: Tidy up query-rocker-of-dpa-flows example
  docs/interop: Delete "QEMU Guest Agent Protocol Reference" TOC
  docs/interop: Sanitize QMP reference manuals TOC
  docs/devel/qapi-code-gen: Improve the part on qmp-example directive
  docs/sphinx/qmp_lexer: Generalize elision syntax
  docs/sphinx/qmp_lexer: Highlight elisions like comments, not prompts
  qapi/qapi-schema: Update introduction for example notation
  qapi/qapi-schema: Address the introduction's bit rot
  storage-daemon/qapi/qapi-schema: Add a proper introduction
  qga/qapi-schema: Add a proper introduction

 docs/devel/qapi-code-gen.rst                 | 53 ++++++++++++--------
 docs/interop/qemu-ga-ref.rst                 |  3 --
 docs/interop/qemu-qmp-ref.rst                |  2 +-
 docs/interop/qemu-storage-daemon-qmp-ref.rst |  2 +-
 docs/sphinx/qmp_lexer.py                     |  2 +-
 qapi/qapi-schema.json                        | 31 ++++--------
 qapi/rocker.json                             |  2 +-
 qga/qapi-schema.json                         | 20 ++++++--
 storage-daemon/qapi/qapi-schema.json         | 22 ++++++--
 tests/qapi-schema/doc-good.json              |  2 +-
 tests/qapi-schema/doc-good.out               |  2 +-
 tests/qapi-schema/doc-good.txt               |  2 +-
 12 files changed, 83 insertions(+), 60 deletions(-)

-- 
2.48.1



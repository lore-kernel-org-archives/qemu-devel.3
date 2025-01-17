Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B95BC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlfb-0003e3-He; Fri, 17 Jan 2025 07:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfZ-0003cp-MF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfV-0008Jw-6k
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737117702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zqA0/tzBXBWXlol5oY7bJYF1LgWl/FDDRalGGG/kocY=;
 b=SngGLP2SW2qBWE3hqTltKo/SGIVHdj5xb601L64MQCe3aIm/15X/MyN/v6hU0t99KL/3B9
 Yb/Gb7VFDnOU4gCRKkBlH+hr4wW2lrCMvoDiOLITjN9FgLnoNN0zNXey5KUoXOCYL+B0dl
 gPV8dm053XCv5iOjaBakYiTsp/ce0yo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-CaEQeBw3NFew71-9SwfzDw-1; Fri,
 17 Jan 2025 07:41:40 -0500
X-MC-Unique: CaEQeBw3NFew71-9SwfzDw-1
X-Mimecast-MFC-AGG-ID: CaEQeBw3NFew71-9SwfzDw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E535195608A
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 12:41:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20E9519560BF; Fri, 17 Jan 2025 12:41:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/3] scripts: mandate use of SPDX-License-Identifier tags
 in new files
Date: Fri, 17 Jan 2025 12:41:33 +0000
Message-ID: <20250117124136.3389778-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

One of the items raised at the QEMU maintainers meeting at KVM Forum
2024 was adoption of SPDX-License-Identifier for licensing of newly
contributed source files, for which there were no dissenting voices.

Thus, this series proposes a way to put this into action by extending
checkpatch.pl to mandate SPDX-License-Identifier in all new files.

Furthermore, anytime it sees SPDX-License-Identifier in any patch,
whether a new file or pre-existing, it validates the declared license
name. If it is not one of the commonly used QEMU licenses (the GPL
variants, MIT, & a few BSD variants), it will report an error. To
encourage sticking with GPL-2.0-or-later by default, it will issue
a warning even if it is one of the common licenses, encouraging
the contributor to double check their choice. This will reduce
accidental license proliferation.

Finally, I've seen a few other random SPDX tags such as:

  * SPDX-FileCopyrightText  - replacing "Copyright ..."
  * SPDX-FileContributor - replacing "Authors: ..."
  * SPDX-URL - a link to the link license text
  * SPDX-sourceInfo - arbitrary free form text about the file

These may or may not be worth considering in QEMU, but this series
discourages their usage by raising an error in checkpatch for now.

If we feel we want to adopt any of these, I think it should be
through a concious decision applied universally. Inconsistent &
adhoc usage of other SPDX tags by a subset of contributors feels
like it doesn't seem to give a clear win, and could even be a
net loss through making practices inconsistent across the code.

Changed in v3:

 * Add missing accepted license LGPL-2.1-only
 * Drop LGPL-2.0-only & LGPL-2.0-or-later as acceptable
 * Fix typo in commit message

Changed in v2:

 * Tweaks to the commit messages
 * Expand the message warning about non GPL-2.0-or-later
   usage, to request an explanation in the commit message
   for the unusual choice.

Daniel P. Berrangé (3):
  scripts: mandate that new files have SPDX-License-Identifier
  scripts: validate SPDX license choices
  scripts: forbid use of arbitrary SPDX tags besides license identifiers

 scripts/checkpatch.pl | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

-- 
2.47.1



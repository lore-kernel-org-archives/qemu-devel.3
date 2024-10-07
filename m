Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AAFCFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpvq-00059J-LU; Mon, 07 Oct 2024 11:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvo-00057W-49
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvm-0002XZ-Kr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728315953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2GIhDAGWfiPEsvR6ggSFh18imegXIDY8BI2xGQqsnA0=;
 b=aKwcxRu8UZ857TV0NI+oDMazOH+q90CXAQhf4PNpB6cUXKgA3A2XHda8f49HZTkhWHAn2/
 MYOjgE7RibA98b+dNsprUfxCZD7j35Nh+jCO9SLpa3RMPG/RqsydmjMMSy5icXMjcrLGzk
 SwRrZfZEXdplFj5+KIxXBLF+E/wnFQ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-CzVsJzqOMqOvKlXBJpHZww-1; Mon,
 07 Oct 2024 11:45:51 -0400
X-MC-Unique: CzVsJzqOMqOvKlXBJpHZww-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E05D91943CE5
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 15:45:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C623300019E; Mon,  7 Oct 2024 15:45:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3] scripts: mandate use of SPDX-License-Identifier tags in
 new files
Date: Mon,  7 Oct 2024 16:45:45 +0100
Message-ID: <20241007154548.1144961-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thus, to bring the proposal to the wider community, here is a series
illustrating a way to put the decision into action by extending
checkpatch.pl to mandate SPDX-License-Identifier in all new files.

Furthermore, anytime it sees SPDX-License-Identifier in any patch,
whether a new file or pre-existing, it validates the declared license
name. If it is not one of the commonly used QEMU licenses (the GPL
variants, MIT, & a few BSD variants), it will report an error. To
encourage sticking with GPL-2.0-or-later by default, it will issue
a warning even if it is one of the common licenses, encouraging
the contributor to double check their choice. This should reduce
(usually accidental) license proliferation in QEMU code.

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

Daniel P. Berrangé (3):
  scripts: mandate that new files have SPDX-License-Identifier
  scripts: validate SPDX license choices
  scripts: forbid use of arbitrary SPDX tags besides license identifiers

 scripts/checkpatch.pl | 104 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

-- 
2.46.0



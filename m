Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1580FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Uh-0002a5-1b; Mon, 19 May 2025 12:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Uc-0002O9-9Q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3UX-0005i9-Qt
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747672648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7FeZnuB33iyx3EDgN8piZNmkL+0fhRU411IdfUaVdbM=;
 b=Tmy6mXiObdz/44J+/K+mnkAghAMIpLHQhX8ac5KeUaww3V8ADBOLUpuVLWfoe4nUq7ZV+T
 CvXwMYxqjuFVNf8sRfRukiuefL0px9xonaNgr9p9Lr6kW2PDLsDhMg3w2nOrweMXpbSPha
 cufD/qaFFrG90JiofUuPqbpagOpUyaQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-d2Dmj32dOOipducKQ8WxvA-1; Mon,
 19 May 2025 12:37:27 -0400
X-MC-Unique: d2Dmj32dOOipducKQ8WxvA-1
X-Mimecast-MFC-AGG-ID: d2Dmj32dOOipducKQ8WxvA_1747672646
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2259119560AE; Mon, 19 May 2025 16:37:26 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11D7B19560A3; Mon, 19 May 2025 16:37:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 0/9] scripts/checkpatch: fix SPDX-License-Identifier
 detection
Date: Mon, 19 May 2025 17:37:12 +0100
Message-ID: <20250519163721.347322-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This is hugely expanded an update of

  https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg02040.html

In that series, Peter suggested creating standalone methods to act
as hooks to call when detecting the start/end of a file in a diff.

This implements that idea and adapts a number of existing checks
to use the new hooks.

Changed in v4:

 - Pull our boilerplate match regex to separate variable
 - Mention that SPDX is sufficient when reporting redundant
   boilerplate
 - Tweak commit message to explain indent changes better

Changed in v3:

 - Add check for redundent license boilerplate text
 - Fix check for Makefile names

Daniel P. Berrangé (9):
  Revert "scripts: mandate that new files have SPDX-License-Identifier"
  scripts/checkpatch.pl: fix various indentation mistakes
  scripts/checkpatch: introduce tracking of file start/end
  scripts/checkpatch: use new hook for ACPI test data check
  scripts/checkpatch: use new hook for file permissions check
  scripts/checkpatch: expand pattern for matching makefiles
  scripts/checkpatch: use new hook for MAINTAINERS update check
  scripts/checkpatch: reimplement mandate for SPDX-License-Identifier
  scripts/checkpatch: reject license boilerplate on new files

 scripts/checkpatch.pl | 388 +++++++++++++++++++++++++++---------------
 1 file changed, 250 insertions(+), 138 deletions(-)

-- 
2.49.0



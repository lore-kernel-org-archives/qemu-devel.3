Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 14:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFZ7r-0002R0-S3; Thu, 15 May 2025 09:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ7m-0002Qd-VG
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ7k-0007p3-DA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747317584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pGPenc3PoLncbMafMqkAXik5mj+RrLiJtYGXmRS0hQ=;
 b=baqOF6+6BpnPFIpSRY5Gh9xQAQkg5RsKMXvOiLimClyIUqjB3rl1gY+kawUlFY4dztzDy+
 FKeHKeJRyiURTXTzJlVZM0mZd0jqia0+cLHVGK1eHMWXehA6I2JSTWjklREfHbS9DQVGED
 CHwe2o0RsJYJZr8blUioVy+b0CVuD70=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-MJh__O-8O6m2WRx7q2d5Cg-1; Thu,
 15 May 2025 09:59:41 -0400
X-MC-Unique: MJh__O-8O6m2WRx7q2d5Cg-1
X-Mimecast-MFC-AGG-ID: MJh__O-8O6m2WRx7q2d5Cg_1747317580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 573191800258; Thu, 15 May 2025 13:59:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A915B30075D4; Thu, 15 May 2025 13:59:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/9] scripts/checkpatch: fix SPDX-License-Identifier
 detection
Date: Thu, 15 May 2025 14:59:27 +0100
Message-ID: <20250515135936.86760-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

This is hugely expanded an update of

  https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg02040.html

In that series, Peter suggested creating standalone methods to act
as hooks to call when detecting the start/end of a file in a diff.

This implements that idea and adapts a number of existing checks
to use the new hooks.

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

 scripts/checkpatch.pl | 381 +++++++++++++++++++++++++++---------------
 1 file changed, 243 insertions(+), 138 deletions(-)

-- 
2.49.0



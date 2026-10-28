Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36999606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q5qLcbYl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3pi-00054o-4E; Wed, 28 Oct 2026 09:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pB-0004vS-QB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pA-0007gQ-AY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4dWjrFUd2+/WELROQ+6kdOfjzPxjopEZEGlU/z4PG7Q=;
 b=Q5qLcbYlhSztAYzuvKmiP9tnR8W7rUC8YLofNOVJ4o5utawOQ87Go/IEC0D8lBD6WKaTB/
 NStFLx/kGjqRVRxMXjM2/8kagDo8afRJQms7ncGMlSjZqDk5l1cJEQYwIi9PsWwLkqmU/Y
 gPo/trJb22aIybtjzml3iz9K/JqIBX4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-ubeoqhsLNmW3XxwKBq30qA-1; Wed,
 28 Oct 2026 09:36:07 -0400
X-MC-Unique: ubeoqhsLNmW3XxwKBq30qA-1
X-Mimecast-MFC-AGG-ID: ubeoqhsLNmW3XxwKBq30qA_1793194566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F43D1955E99
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:06 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CB6A30002CD; Wed, 28 Oct 2026 13:36:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/8] qapi: last minute improvements/changes to -compat
 insecure-types
Date: Wed, 28 Oct 2026 13:35:55 +0000
Message-ID: <20261028133603.1893289-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This addresses various points raised by Markus about the current
impl/design, that would need to be addressed before this is
included in the release.

NB, the 'warn' option will repeatedly warn on every violation
which can be somewhat unpleasant. Figuring out a mechanism to
make it a one-time warning is an exercise for the future, given
limited time before release.

Daniel P. Berrangé (8):
  qapi: make 'CompatPolicy' the first arg in compat_policy_input_ok
  qapi: add 'warn' option to CompatPolicyInput
  qapi: rename 'insecure-types' to 'insecure-input'
  qapi: drop CompatPolicySecurity and use CompatPolicyInput
  qapi: rename compat_policy_check_security method
  qapi: reverse arg order in compat_policy_security_ok
  qemu-options: document -compat insecure-input parameter
  qapi: print a message before aborting for -compat violations

 docs/system/security.rst     |  2 +-
 include/qapi/compat-policy.h | 12 ++++-----
 qapi/compat.json             | 24 ++++-------------
 qapi/qapi-util.c             | 52 ++++++++++++++++--------------------
 qapi/qapi-visit-core.c       |  4 +--
 qapi/qmp-dispatch.c          |  2 +-
 qapi/qobject-input-visitor.c |  2 +-
 qemu-options.hx              | 34 +++++++++++++++++++----
 qom/object.c                 |  8 +++---
 9 files changed, 72 insertions(+), 68 deletions(-)

-- 
2.56.0



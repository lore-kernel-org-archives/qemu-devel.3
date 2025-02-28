Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA10C282D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to2Y6-00067n-EE; Fri, 28 Feb 2025 10:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1to2Xt-0005yh-Og
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1to2Xq-00057M-De
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740757496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KySs70GMDI/Rt5c3qccSkjgRWo+insfht8yyqmJP2sc=;
 b=Ufpqf0bdHC5kpfOHuQgBiq/gHCvW7XjSSHQAz2Kgdbt2aMw31n9M3b/tKGBaBXhwMQHcNY
 oH1ve78QMku3Zhyf00NOqjKe5mW0cilNfLsQhjTWk5cn9mdzZu6CmfeqywU8cI9OObgTYN
 2KWSWUcHv9ZOHWIYERTxAB9bmIOpDqU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-V6S_06syOwS2j5vBzjWYcg-1; Fri,
 28 Feb 2025 10:44:54 -0500
X-MC-Unique: V6S_06syOwS2j5vBzjWYcg-1
X-Mimecast-MFC-AGG-ID: V6S_06syOwS2j5vBzjWYcg_1740757494
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7D181800360
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 15:44:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B7E519560B9; Fri, 28 Feb 2025 15:44:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/3] SPDX checkpatch
Date: Fri, 28 Feb 2025 15:44:47 +0000
Message-ID: <20250228154450.3185564-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/spdx-check-pull-request

for you to fetch changes up to 6b7521818b26134726b3494cd06f04e30659ce2c:

  scripts: forbid use of arbitrary SPDX tags besides license identifiers (2025-02-28 15:37:36 +0000)

----------------------------------------------------------------

* Mandate use of SPDX-License-Identifier in new files
* Validate SPDX license choices
* Forbid other SPDX tags

----------------------------------------------------------------

Daniel P. Berrangé (3):
  scripts: mandate that new files have SPDX-License-Identifier
  scripts: validate SPDX license choices
  scripts: forbid use of arbitrary SPDX tags besides license identifiers

 scripts/checkpatch.pl | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

-- 
2.48.1



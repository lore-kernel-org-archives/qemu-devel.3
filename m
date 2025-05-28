Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2397C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFk7-00062S-Fb; Wed, 28 May 2025 08:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFjm-0005yR-Od
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKFjj-0004GN-9U
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748434698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPqPScJpRADVrCh0IYtsJQtzDsimtpA4yZoxgpiqffo=;
 b=CgWAEuasM1iyVOt9WzZYcVTnir8yXyx2KNEdT4lmgYYg7SlSa5febYlw46quVpzWREtcU0
 /XZTakB/DPxLIDDd5EbwBsC8W0AYV2sk39aI3x40sqReJ5m6IODLPFEUOaFNKYEJkTG1Hm
 rI8YrDQZcqbQ7Ps7b8qQfde19VTSNcg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-uyM3uCQAMOWE0LTUCCDljA-1; Wed,
 28 May 2025 08:18:17 -0400
X-MC-Unique: uyM3uCQAMOWE0LTUCCDljA-1
X-Mimecast-MFC-AGG-ID: uyM3uCQAMOWE0LTUCCDljA_1748434696
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D061318002A5
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:18:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C7C919560B0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 12:18:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9BCE21E66C5; Wed, 28 May 2025 14:11:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/4] Miscellaneous patches for 2025-05-28
Date: Wed, 28 May 2025 14:11:39 +0200
Message-ID: <20250528121143.2208075-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:

  Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-misc-2025-05-28

for you to fetch changes up to 662b85aae131e7cb8dd8b03c9e44a95bc87573ca:

  docs/about/removed-features: Move removal notes to tidy up order (2025-05-28 06:53:59 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2025-05-28

----------------------------------------------------------------
Markus Armbruster (4):
      docs/about: Belatedly document tightening of QMP device_add checking
      qapi/migration: Deprecate migrate argument @detach
      docs/about/deprecated: Move deprecation notes to tidy up order
      docs/about/removed-features: Move removal notes to tidy up order

 docs/about/deprecated.rst       | 47 ++++++++++++----------------
 docs/about/removed-features.rst | 69 +++++++++++++++++++++++------------------
 qapi/migration.json             | 18 +++++------
 3 files changed, 67 insertions(+), 67 deletions(-)

-- 
2.48.1



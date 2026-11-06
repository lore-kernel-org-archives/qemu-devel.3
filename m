Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D57606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QWttZQV7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPInq-0005E8-Un; Fri, 06 Nov 2026 07:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInR-00057t-Ac
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInP-0006TX-Hw
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KlJJ8iL4sGfz54JgqZ4BCOK2qdhsM3bYuOYlPJFiG68=;
 b=QWttZQV7UuiGIoyt5hX4xTrr81eFqpoHqG3msfzS4lHq89G2LgL9Vwogmndqi9xB4Bcqyd
 qbFoERfexNp+2j3lqZ6mDe3baT8P6oAiganR9hFMiWrEMmd/To1U2JSjS76giKf2Idwlkc
 YSrHBSyqm6t25etkDNU/lgS/6OsR5UM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-Ex-iB4NxNZ2T_c97-uRJhw-1; Fri,
 06 Nov 2026 07:11:47 -0500
X-MC-Unique: Ex-iB4NxNZ2T_c97-uRJhw-1
X-Mimecast-MFC-AGG-ID: Ex-iB4NxNZ2T_c97-uRJhw_1793967106
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0DB19560BC; Fri,  6 Nov 2026 12:11:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFCE018001DA; Fri,  6 Nov 2026 12:11:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63B5521E6A04; Fri, 06 Nov 2026 13:11:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/6] QAPI patches for 2026-11-06
Date: Fri,  6 Nov 2026 13:11:37 +0100
Message-ID: <20261106121143.3771978-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:

  Merge tag 'pull-loongarch-20261105' of https://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-06

for you to fetch changes up to 6955264d5821b453d3e68472009fe445b55e6311:

  qom: Convert child and link properties to QAPI-aware registration (2026-11-06 12:56:26 +0100)

----------------------------------------------------------------
QAPI patches for 2026-11-06

----------------------------------------------------------------
Markus Armbruster (6):
      qapi: Consistently use x.y with since
      target/riscv: Fix up PropertyInfo to set @qapi_type
      hw/gpio/pca9552: Fix @type of pca9552 property led<N>
      hw: Fix up PropertyInfo to set @qapi_type
      qom: Convert alias properties to QAPI-aware registration
      qom: Convert child and link properties to QAPI-aware registration

 docs/devel/qapi-code-gen.rst |  4 ++--
 docs/interop/firmware.json   |  4 ++--
 qapi/accelerator.json        |  6 +++---
 qapi/crypto.json             |  2 +-
 hw/gpio/pca9552.c            |  5 +++--
 hw/gpio/pca9554.c            |  5 +++--
 qom/object.c                 | 13 +++++++------
 target/riscv/cpu.c           |  1 +
 8 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.55.0



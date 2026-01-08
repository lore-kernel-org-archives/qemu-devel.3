Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3564CF6A88
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlrC-0004J3-IQ; Thu, 08 Jan 2026 03:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlrA-0004G7-QP
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdlr9-0008FQ-7z
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767862738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pbCrlB6KzzH/oxiAqKfZSBIBlAc1EbsWUTKn3xr9dyY=;
 b=GFeTmHpcG+viso2ds6Mvcb09CYzhj06aIY9PUO+fpBYPXRzO6n3yUJqhHoUMB1Zg1SyG82
 IDirQJQWErERvQvVTj6Pscj0JUTH5cGN8dyVzbYUwYeM0s5B2k2HI73SQd4EscrVbv/15a
 bk4tTLphsDnUBWtBQ9wonrCWE9ZDiG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-q088Id1BPRSzAe1NLdiyqA-1; Thu,
 08 Jan 2026 03:58:54 -0500
X-MC-Unique: q088Id1BPRSzAe1NLdiyqA-1
X-Mimecast-MFC-AGG-ID: q088Id1BPRSzAe1NLdiyqA_1767862733
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68C6A1956095; Thu,  8 Jan 2026 08:58:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F232819560A2; Thu,  8 Jan 2026 08:58:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7617521E6937; Thu, 08 Jan 2026 09:58:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/4] MAINTAINERS patches for 2026-01-08
Date: Thu,  8 Jan 2026 09:58:46 +0100
Message-ID: <20260108085850.1790958-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 63a88166ab160d7d92da60b7fcb562c127e51862:

  Merge tag 'pull-request-2026-01-07' of https://gitlab.com/thuth/qemu into staging (2026-01-08 07:24:44 +1100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2026-01-08

for you to fetch changes up to bfb8ab8370c6cbbb74fc55b4587ca83c71e623f6:

  MAINTAINERS: Add MAX78000FTHR section as orphan (2026-01-08 09:53:09 +0100)

----------------------------------------------------------------
MAINTAINERS patches for 2026-01-08

----------------------------------------------------------------
Markus Armbruster (4):
      MAINTAINERS: Fix coverage of tests/functional/acpi-bits/
      MAINTAINERS: Fix coverage of meson.build in tests/functional
      MAINTAINERS: Add EEPROM 93xx section
      MAINTAINERS: Add MAX78000FTHR section as orphan

 MAINTAINERS | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.52.0



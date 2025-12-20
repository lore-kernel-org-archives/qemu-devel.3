Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26993D68BD5
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 06:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXCwv-0004h4-F9; Sun, 21 Dec 2025 01:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vXCwu-0004gE-4s
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:29:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vXCwr-000113-Vi
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766298585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=chUsOwvk0ihFMM33DT8Fr3unSvz5VMUkGOF4Y0nAI0Q=;
 b=fG5CI8wwpVB2EM+dqkz5VoZrCzn7ECC5oCp2g32k4aPhxl0sJcgK7RfVBkIH+vttk5UCvm
 aVXixC7bzZ2zwW+83j5+AfyeFMZlh1wHCW/l3ydEOIl4f0TgZZBGHjan8JnUDlqQK3Iu7Y
 H803LAvCWFwaKL6+tL2vkog7JE/GWEo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-4f-5HjjIMLycj-aBQzlKgA-1; Sun,
 21 Dec 2025 01:29:43 -0500
X-MC-Unique: 4f-5HjjIMLycj-aBQzlKgA-1
X-Mimecast-MFC-AGG-ID: 4f-5HjjIMLycj-aBQzlKgA_1766298582
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B4971800451; Sun, 21 Dec 2025 06:29:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D302180045B; Sun, 21 Dec 2025 06:29:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8881321E6A27; Sun, 21 Dec 2025 07:29:39 +0100 (CET)
Resent-To: alex.bennee@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 21 Dec 2025 07:29:39 +0100
Resent-Message-ID: <87ldiwxs8c.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Sat Dec 20 18:33:36 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4478421E6A27; Sat, 20 Dec 2025 18:33:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 0/4] MAINTAINERS: A few fixes and additions
Date: Sat, 20 Dec 2025 18:33:32 +0100
Message-ID: <20251220173336.3781377-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

v2:
* PATCH 4: Correct S: and delete M: [Alex]

Markus Armbruster (4):
  MAINTAINERS: Fix coverage of tests/functional/acpi-bits/
  MAINTAINERS: Fix coverage of meson.build in tests/functional
  MAINTAINERS: Add EEPROM 93xx section
  MAINTAINERS: Add MAX78000FTHR section as orphan

 MAINTAINERS | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.49.0




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961E9F54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54jj-0000z7-Cl; Tue, 24 Mar 2026 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jh-0000yR-Dw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w54jf-0004ix-6q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774370163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yGydu4nMgVJeb3bAVfUGWBcC+T0P5KkkBH5WwswGozM=;
 b=XxLalvRVVol5Bt0vk4/cnUgQXLudhltY8Z44/qOVirench9sn7nErIXBdOwwZsU4tS6c97
 F7WyXgYKBsOsmxky8E6p78xD1FtAI0An7c4vbgftffd75IRsPl6kzns6GpqZUV6To8IETz
 NniF/hMS4p7j+2TDLEafefa6JyPIoOg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-VTqHlPR0NTilJRMfMSEeVg-1; Tue,
 24 Mar 2026 12:36:01 -0400
X-MC-Unique: VTqHlPR0NTilJRMfMSEeVg-1
X-Mimecast-MFC-AGG-ID: VTqHlPR0NTilJRMfMSEeVg_1774370160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 438C5195608E; Tue, 24 Mar 2026 16:36:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CA301800107; Tue, 24 Mar 2026 16:35:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/4] Silence some pylint warnings in
 tests/functional/qemu_test/
Date: Tue, 24 Mar 2026 17:35:37 +0100
Message-ID: <20260324163543.55503-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While we already check the target folders in the functional testing
framework with pylint, the folder with the core classes of the
functional testing framework is not clean for pylint yet.
Here are some patches to tackle the warnings in three of the files at
least.

Thomas Huth (4):
  tests/functional/qemu_test: Silence warnings from pylint in
    tesseract.py
  tests/functional/qemu_test: Silence (most) warnings from pylint in
    asset.py
  tests/functional/qemu_test: Split huge fetch() function in asset.py
  tests/functional/qemu_test: Silence warnings from pylint in config.py

 tests/functional/qemu_test/asset.py     | 94 ++++++++++++++++---------
 tests/functional/qemu_test/config.py    | 11 +--
 tests/functional/qemu_test/tesseract.py | 11 ++-
 3 files changed, 76 insertions(+), 40 deletions(-)

-- 
2.53.0



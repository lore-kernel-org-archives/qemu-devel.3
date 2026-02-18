Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5DBE9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdYD-0005kg-KJ; Wed, 18 Feb 2026 04:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY3-0005d5-5z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vsdY1-0002bD-9A
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hD5+15fZNrYR33UJM4bVqZGnvSNEe8DnFkthFcqU2o8=;
 b=TLiHVe4IT3oPOf9MqZLPYj2+1DJSeVfc4e8Mg/oqd1sDwrsJv1dCmk6qJLR/pEIfN6ZpUl
 4oQBak5KN+MmBo4wZqCZhzP6iYN6zMgJgrbZsa2eZ5zCAqALLqQvjlucBEAxfAjAPDwJ60
 kD5w1Jifs7uQvyXYGoLUUAhXXvXb0XY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-Ykld6_8lOjS2NJIxjgpjLg-1; Wed,
 18 Feb 2026 04:08:39 -0500
X-MC-Unique: Ykld6_8lOjS2NJIxjgpjLg-1
X-Mimecast-MFC-AGG-ID: Ykld6_8lOjS2NJIxjgpjLg_1771405718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2530B195DE50; Wed, 18 Feb 2026 09:08:38 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.45.226.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C1ED1956095; Wed, 18 Feb 2026 09:08:37 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 7C3A968B171; Wed, 18 Feb 2026 09:59:45 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 0/2] Firmware 20260218 patches
Date: Wed, 18 Feb 2026 09:59:43 +0100
Message-ID: <20260218085945.1050788-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260218-pull-request

for you to fetch changes up to e8dcd2a0c2d663963408f2d642de864feac8ca0d:

  docs/interop/firmware: Add 'uefi-vars' member for FirmwareMappingMemory (2026-02-17 16:03:06 +0100)

----------------------------------------------------------------
- firmware json spec update
- igvm update

----------------------------------------------------------------

Andrea Bolognani (1):
  docs/interop/firmware: Add 'uefi-vars' member for
    FirmwareMappingMemory

Oliver Steffen (1):
  igvm: Add NULL checks for igvm_get_buffer()

 backends/igvm.c            | 37 ++++++++++++++++++++++++++------
 docs/interop/firmware.json | 43 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.53.0



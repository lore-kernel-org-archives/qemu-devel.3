Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323BDCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWaI-0001WC-9z; Wed, 22 Oct 2025 07:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWaG-0001V5-7n
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBWa4-0005bW-Gt
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761130835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kAKuflBqUYmyA+AkX8SRsP7ELTc42PIJsG9RcMYxBWw=;
 b=TpqauyPzfMO3DgtxcUoESTClZ3YJDihudIimuDQswe05WU2Xz0UIC+PxqW/CtZeVIMpEOr
 OStaIlNd81SYCVhkkixvF2GGWRxjV04Ev5S3Jo3yTpGYm16sUbP47fZAL4JT2e2HZtGmkA
 LcAzxI2eTlWf6M0ELfAlaPbjF0SfvWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-qXTvFC6PMWCkY7GswhDYLg-1; Wed,
 22 Oct 2025 07:00:33 -0400
X-MC-Unique: qXTvFC6PMWCkY7GswhDYLg-1
X-Mimecast-MFC-AGG-ID: qXTvFC6PMWCkY7GswhDYLg_1761130831
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C98180035A; Wed, 22 Oct 2025 11:00:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7415519541B2; Wed, 22 Oct 2025 11:00:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F044518000B5; Wed, 22 Oct 2025 13:00:27 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 0/3] Uefi 20251022 patches
Date: Wed, 22 Oct 2025 13:00:24 +0200
Message-ID: <20251022110027.441780-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:

  Merge tag 'pull-request-2025-10-21' of https://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/uefi-20251022-pull-request

for you to fetch changes up to c6c6d854447a7821288e01857d0f7fb28b82cf44:

  hw/uefi/ovmf-log: add maxsize parameter (2025-10-22 11:32:07 +0200)

----------------------------------------------------------------
uefi: add firmware log monitor commands

----------------------------------------------------------------

Gerd Hoffmann (3):
  hw/uefi: add query-firmware-log monitor command
  hw/uefi: add 'info firmware-log' hmp monitor command.
  hw/uefi/ovmf-log: add maxsize parameter

 include/monitor/hmp.h      |   1 +
 hw/uefi/ovmf-log.c         | 286 +++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |   2 +
 hmp-commands-info.hx       |  13 ++
 hw/uefi/meson.build        |   2 +-
 qapi/machine.json          |  29 ++++
 6 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/ovmf-log.c

-- 
2.51.0



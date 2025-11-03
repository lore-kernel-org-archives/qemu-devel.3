Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE5CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFq8v-0007s9-2c; Mon, 03 Nov 2025 03:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vFq8p-0007qh-Mk
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vFq8l-0000GG-4m
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762159329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TyStEZPLmg6F72iywec6ZjheY0HhP9nV9N6r+9L7x4k=;
 b=PYVD1vglDeMBuYHBMAYsRDBEyLDHn5ZXq1embTM4ZKgov5Q8/hS1jEFbrsw0VFaATh1nx9
 EyzM4dF0PDMYj+3RufUqlSHFKokmwelPqLDfO5yoIuY89bEVKjyoaWP0MEusMMA5epKOU+
 tngKpczwzcsP03rBQYJ5FpKZFBsOLR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-dnX4DN3RP3qxq7a95-Mhag-1; Mon,
 03 Nov 2025 03:42:05 -0500
X-MC-Unique: dnX4DN3RP3qxq7a95-Mhag-1
X-Mimecast-MFC-AGG-ID: dnX4DN3RP3qxq7a95-Mhag_1762159324
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 977731800D8F; Mon,  3 Nov 2025 08:42:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F25FA1955BE3; Mon,  3 Nov 2025 08:42:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6B2CF1800080; Mon, 03 Nov 2025 09:42:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 0/5] Igvm 20251103  patches
Date: Mon,  3 Nov 2025 09:41:55 +0100
Message-ID: <20251103084201.45417-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:

  Merge tag 'pull-target-arm-20251031' of https://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/igvm-20251103--pull-request

for you to fetch changes up to 541e7a2d987cf74bc1931bdd99d64b27bc9f335b:

  igvm: add MAINTAINERS entry (2025-11-03 07:38:53 +0100)

----------------------------------------------------------------
igvm: improve native mode (non-confidential guest) supportY

----------------------------------------------------------------

Gerd Hoffmann (5):
  igvm: move igvm.h file to include/system
  igvm: fix off by one bug in memmap entry count checking
  igvm: add support for igvm memory map parameter in native mode
  igvm: add support for initial register state load in native mode
  igvm: add MAINTAINERS entry

 {backends => include/system}/igvm.h |   7 ++
 target/i386/cpu.h                   |   3 +
 backends/igvm-cfg.c                 |   2 +-
 backends/igvm.c                     |  50 ++++----
 stubs/igvm.c                        |  26 ++++
 target/i386/cpu.c                   |   6 +
 target/i386/igvm.c                  | 180 ++++++++++++++++++++++++++++
 MAINTAINERS                         |  11 ++
 stubs/meson.build                   |   1 +
 target/i386/meson.build             |   3 +
 10 files changed, 267 insertions(+), 22 deletions(-)
 rename {backends => include/system}/igvm.h (64%)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

-- 
2.51.1



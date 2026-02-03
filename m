Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A738E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8P-0007iv-SE; Tue, 03 Feb 2026 07:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8L-0007iY-Rt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8K-0007dD-AX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bFjviVtmw6NWuLZl3ZBtVFIP3Sa4bI9e7dDb/4YTwPA=;
 b=Nq71/2hBW1jXmcyxLHw7zdJM+gHIe8lMMqMKwTwBccmBMsDGXkv/fVuAK1CWGYW53q1Dus
 sRJcVuxS17vfJQVI/6WWJlZ/JiI6nmDHg6xiAzUHkCLDxYNviOdStHNG805vUoZLBsFlDY
 MrkRVMCNfodym9Th/ttla+brjAIgz4k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-wr43I31XPZqqblyDc1RP4g-1; Tue,
 03 Feb 2026 07:03:47 -0500
X-MC-Unique: wr43I31XPZqqblyDc1RP4g-1
X-Mimecast-MFC-AGG-ID: wr43I31XPZqqblyDc1RP4g_1770120226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A6BD1955F34; Tue,  3 Feb 2026 12:03:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CF2318002A6; Tue,  3 Feb 2026 12:03:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6714818003AA; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 00/17] Firmware 20260203 patches
Date: Tue,  3 Feb 2026 13:03:25 +0100
Message-ID: <20260203120343.656961-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:

  Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260203-pull-request

for you to fetch changes up to dea1f68a5cd338b338e34f2df5ecb2e35a9d8681:

  igvm: Fill MADT IGVM parameter field on x86_64 (2026-02-03 08:32:33 +0100)

----------------------------------------------------------------
firmware updates for 11.0
- igvm: rework reset handling.
- igvm: add MADT parameter support.
- uefi: variable store fixes.

----------------------------------------------------------------

Gerd Hoffmann (7):
  hw/uefi: skip time check for append-write updates.
  hw/uefi: fix size negotiation
  igvm: reorganize headers
  igvm: make igvm-cfg object resettable
  igvm: move file load to complete callback
  igvm: add trace points for igvm file loading and processing
  igvm: move igvm file processing to reset callbacks

Jim MacArthur (1):
  docs/system/igvm.rst: Update external links

Oliver Steffen (9):
  hw/acpi: Make acpi_checksum() public
  hw/acpi: Make BIOS linker optional
  hw/acpi: Add standalone function to build MADT
  igvm: Move structs to internal header
  igvm: Add common function for finding parameter entries
  igvm: Refactor qigvm_parameter_insert
  igvm: Pass machine state to IGVM file processing
  igvm: Only build stubs if igvm is enabled
  igvm: Fill MADT IGVM parameter field on x86_64

 hw/i386/acpi-build.h           |   2 +
 include/hw/acpi/acpi.h         |   3 +
 include/qemu/typedefs.h        |   1 +
 include/system/igvm-cfg.h      |  15 +-
 include/system/igvm-internal.h |  82 ++++++++++
 include/system/igvm.h          |   7 +-
 backends/igvm-cfg.c            |  64 +++++++-
 backends/igvm.c                | 266 ++++++++++++++++-----------------
 hw/acpi/aml-build.c            |  12 +-
 hw/acpi/core.c                 |   5 +-
 hw/i386/acpi-build.c           |   9 ++
 hw/i386/pc_piix.c              |  10 --
 hw/i386/pc_q35.c               |  10 --
 hw/uefi/var-service-vars.c     |   5 +-
 stubs/igvm.c                   |   6 +
 target/i386/igvm.c             |  32 ++++
 target/i386/sev.c              |   3 +-
 backends/trace-events          |   7 +
 docs/system/igvm.rst           |   6 +-
 stubs/meson.build              |   4 +-
 20 files changed, 361 insertions(+), 188 deletions(-)
 create mode 100644 include/system/igvm-internal.h

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21357CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvm-0000qV-NO; Wed, 10 Jun 2026 04:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvk-0000q4-Qt
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvi-0000YJ-0M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EmOla4KiI538HADJ9t7W6jLmhkJVFcxbfadj/cOMyJg=;
 b=h9Wv1YiwWa+6QgpDZpgNE7MbgGxA1ZU/UezLRcixo5yNvUyLZf2Eklt28PJrryXk1nIeqm
 L3Il1uutoB8+lvqa/RY42BxNACiaDO+JGrQWHv/AWhIgiVQdu3cLm4Pr6U1K7mdevNFrS2
 PIminsmUpW2dlHSoWpCN7l80TkI2UoU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528--kphx9wWOVOtVt_UncBv-A-1; Wed,
 10 Jun 2026 04:04:51 -0400
X-MC-Unique: -kphx9wWOVOtVt_UncBv-A-1
X-Mimecast-MFC-AGG-ID: -kphx9wWOVOtVt_UncBv-A_1781078690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F88F1805C37
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:04:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ADC0180058F
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:04:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 908BA21E6A01; Wed, 10 Jun 2026 10:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/42] MAINTAINERS patches for 2026-06-10
Date: Wed, 10 Jun 2026 10:04:05 +0200
Message-ID: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d1506:

  Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/qemu into staging (2026-06-09 14:00:28 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2026-06-10

for you to fetch changes up to 7e8af1f2860c20d1d576b08b8629a4986eb0f72f:

  MAINTAINERS: Fix F: in "Rust build system integration" (2026-06-10 10:00:01 +0200)

----------------------------------------------------------------
MAINTAINERS patches for 2026-06-10

----------------------------------------------------------------
Markus Armbruster (38):
      MAINTAINERS: Improve another "Overall" section headline
      MAINTAINERS: Delete trailing colons in section headlines
      MAINTAINERS: Drop stale F: from "Guest CPU cores (TCG)"
      MAINTAINERS: Drop stale F: in "SPARC TCG CPUs"
      MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
      MAINTAINERS: Fix F: in "Overall CPUs other accelerators"
      MAINTAINERS: Drop stale F: from "virtio"
      MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
      MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
      MAINTAINERS: Fix F: in "Darwin (macOS, iOS)"
      MAINTAINERS: Fix F: in "WebAssembly"
      MAINTAINERS: Fix F: in "Allwinner-a10"
      MAINTAINERS: Fix F: in "Raspberry Pi"
      MAINTAINERS: Drop bad F: from "Xilinx Zynq"
      MAINTAINERS: Drop stale F: from "New World (mac99)"
      MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
      MAINTAINERS: Fix F: typo in "sam460ex"
      MAINTAINERS: Fix F: typo in "ACPI/HEST/GHES/ARM processor CPER"
      MAINTAINERS: Fix F: in "SSI"
      MAINTAINERS: Fix F: in "vhost"
      MAINTAINERS: Fix F: in "virtio-input"
      MAINTAINERS: Fix bad / stale F: in "virtio-user-rng"
      MAINTAINERS: Fix F: in "vhost-user-stubs"
      MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
      MAINTAINERS: Fix F: typo in "pcf8574"
      MAINTAINERS: Drop stale F: from "Block I/O path"
      MAINTAINERS: Fix F: typo in "Dump"
      MAINTAINERS: Drop stale F: from "Human Monitor (HMP)"
      MAINTAINERS: Fix F: in "QDev"
      MAINTAINERS: Fix F: in "QMP"
      MAINTAINERS: Fix F: typo in "I3C"
      MAINTAINERS: Drop stale F: from "EDK2 Firmware"
      MAINTAINERS: Drop stale F: from "TCI TCG target"
      MAINTAINERS: Drop stale F: from "Linux io_uring"
      MAINTAINERS: Fix F: in "VFIO-USER"
      MAINTAINERS: Fix F: in "Build and test automation"
      MAINTAINERS: Drop stale F: from "Sphinx documentation configuration ..."
      MAINTAINERS: Fix F: in "Rust build system integration"

Philippe Mathieu-Daudé (3):
      MAINTAINERS: Correct scripts/coverity-model.c path
      MAINTAINERS: Fix RISCV related paths
      MAINTAINERS: Fix hexagon-linux-user.mak path

Yuri Benditovich (1):
      MAINTAINERS: update ebpf reviewers

 MAINTAINERS | 84 ++++++++++++++++++++++---------------------------------------
 1 file changed, 30 insertions(+), 54 deletions(-)

-- 
2.54.0



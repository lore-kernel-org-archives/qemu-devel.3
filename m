Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE78CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyPd-0007np-GJ; Thu, 21 May 2026 04:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPC-0007bt-Vb
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPA-0006r5-Ik
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VxT3rvJjwmxx/55QY3a9XGPJdlojQBDQYFHoeyuMWUo=;
 b=dpj64gQq5VQzsf5470tHqJZy6Ake+3SGycoh43vAQVTeLE3ZeH9+Qij1Lny4giQgtay/22
 tM8Fu5nY0UZRIh/yNg2tedpUxc1YcR564MRtcTRAMCH8gq65k9eyrSmTcIUk3T2B4wFKaD
 ATlNP2XlJqeoqbdlloPlh08oaEkCRSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-G9nt9ZjtOkCF1CborwskcA-1; Thu,
 21 May 2026 04:05:15 -0400
X-MC-Unique: G9nt9ZjtOkCF1CborwskcA-1
X-Mimecast-MFC-AGG-ID: G9nt9ZjtOkCF1CborwskcA_1779350714
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED1018005B3; Thu, 21 May 2026 08:05:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A3391681; Thu, 21 May 2026 08:05:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAB9D21E6A01; Thu, 21 May 2026 10:05:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH 00/39] MAINTAINERS: Fix F: lines
Date: Thu, 21 May 2026 10:04:32 +0200
Message-ID: <20260521080511.999266-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Quite a few F: lines don't match any files.  The quick & dirty check

    $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null

finds about fifty.

Philippe Mathieu-Daudé recently posted a few fixes:

  MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
  MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
  MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
  MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
  MAINTAINERS: Cover python.docker with Python library section
  MAINTAINERS: Fix s390x storage key/attribute device paths
  MAINTAINERS: Fix tcg/s390x/ path
  MAINTAINERS: Correct scripts/coverity-model.c path
  MAINTAINERS: Fix hexagon-linux-user.mak path

These are in

   Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
   Date: Mon, 18 May 2026 12:22:15 +0200
   Message-ID: <20260518102222.80735-1-philmd@linaro.org>

   Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
   Date: Tue, 19 May 2026 19:12:36 +0200
   Message-ID: <20260519171240.97420-1-philmd@linaro.org>


   Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
   Date: Tue, 19 May 2026 19:19:26 +0200
   Message-ID: <20260519171926.98099-1-philmd@linaro.org>

   Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
   Date: Wed, 20 May 2026 14:39:47 +0200
   Message-ID: <20260520123947.12711-1-philmd@linaro.org>

This series takes care of the remainder, except for one discussed
below.  It applies cleanly with and without Philippe's patches.

The exception is the last line in

    Python scripts
    M: John Snow <jsnow@redhat.com>
    M: Cleber Rosa <crosa@redhat.com>
    S: Odd Fixes
    F: scripts/*.py
    F: tests/*.py

Both F: are actually wrong here: they match only in the scripts/ and
tests/ not further down.  Left for another day.

Markus Armbruster (39):
  MAINTAINERS: Improve another "Overall" section headline
  MAINTAINERS: Delete trailing colons in section headlines
  MAINTAINERS: Drop stale F: from "Guest CPU cores (TCG)"
  MAINTAINERS: Drop stale F: in "RISC-V TCG CPUs"
  MAINTAINERS: Drop stale F: in "SPARC TCG CPUs"
  MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
  MAINTAINERS: Drop stale F: from "Overall CPUs other accelerators"
  MAINTAINERS: Drop stale F: from "virtio"
  MAINTAINERS: Fix F: in "Apple Silicon HVF CPUs"
  MAINTAINERS: Drop bad F: in "X86 Xen CPUs"
  MAINTAINERS: Fix F: in "WebAssembly"
  MAINTAINERS: Fix F: in "Allwinner-a10"
  MAINTAINERS: Fix F: in "Raspberry Pi"
  MAINTAINERS: Drop bad F: from "Xilinx Zynq"
  MAINTAINERS: Drop stale F: from "New World (mac99)"
  MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
  MAINTAINERS: Fix F: typo in "sam460ex"
  MAINTAINERS: Fix F: in "SiFive Machines"
  MAINTAINERS: Fix F: typo in "ACPI/HEST/GHES/ARM processor CPER"
  MAINTAINERS: Fix F: in "SSI"
  MAINTAINERS: Fix F: in "vhost"
  MAINTAINERS: Fix F: in "virtio-input"
  MAINTAINERS: Fix bad / stale F: in "virtio-rng"
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
  MAINTAINERS: Drop stale F: from "Sphinx documentation configuration
    ..."
  MAINTAINERS: Fix F: in "Rust build system integration"

 MAINTAINERS | 73 ++++++++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

-- 
2.54.0



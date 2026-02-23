Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A97EA4FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSc-0004SD-7u; Mon, 23 Feb 2026 06:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSU-0004P8-9e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:38 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSR-0004qy-1K
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EEB60600C4;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8F3C2BC86;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=Dc9nDtbKtoVHv3MCne+90lvG06huZuBCP6DTX5S7L8s=;
 h=From:To:Cc:Subject:Date:From;
 b=TmiXkGK8rSry6XKF3cIAV8KalQ8iXlOui0HwPgaRMWV7YCDlXVl/LcraL5A2zqTpH
 JJQ+NG7f248IQ2/WZXI9SeTyl8XLYl0x6gCMrUonX13SZ/mBskRLcpoXEKkujvc0/V
 x53e6dmbD9oKE6SjDUR4Kjq9KLJ2a1L7WZTFUVlWpj7AG5ME9RvnWwBDh0IfATJ/Xb
 FXnIrr6O8SVFYEmyFy3BTkql8W8MeCX2jUzj8KM5gEA4SpNGbeIurZ7tfFKgThg5e3
 rnbVzS4tLHpYJFbgBHyt9syx9sex/flmWfEfbWUuwz21is1ZqZIrB/OcfGk4HwhFdR
 O1FmvmsZsfz6A==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSN-00000007JnW-3FaK; Mon, 23 Feb 2026 12:50:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 00/14] Add more commands to scripts/ghes_inject.py
Date: Mon, 23 Feb 2026 12:50:16 +0100
Message-ID: <cover.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that we have the basic stuff merged on QEMU, add more
commands to scripts/ghes_inject.py. After this patch, this
tool will support the following commands:

    arm                 Inject an ARM processor error CPER, compatible with
                        UEFI 2.9A Errata.
    pcie-bus            Inject a PCIe bus error CPER
    fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
    raw-error (raw)     Inject CPER records from previously recorded ones.

Where arm is a pre-existing one.

The pcie-bus command injects a PCIe bus error - currently not supported
on Linux (GUID: c5753963-3b84-4095-bf78-eddad3f9c9dd).

The fuzzy-test command allows injecting one or more CPER records
for all GUID types supported on UEFI 2.11, with its contents being
either zero or random, and with the payload size that can also be
random.

The raw-error command allow reproducing a CPER from a text file.
It is helpful in conjunction with fuzzy-test to re-test the OSPM
after some fixes.

Besides the commands, a new helper logic was added at
scripts/ghes_decode.py: when the tool is called with the
--debug command line argument, it will translate the injected
record, allowing to compare what it was injected with what
the OSPM/userspace tools would interpret.

The first 6 patches on this series improve the qmp_helper
logic to support the new functionality.

The next 6 patches add the extra functionality to ghes_inject.

The final patch improves its help message when called without
a command.

---

v3:
  - Replaced the deprecated SPDX 3.0 "gpl-2.0" which is identical
    to "gpl-2.0-only" with "gpl-2.0-or-later", following the same
    license as the other libraries that are part of ghes_inject.py;

  - Did some long line cleanups at qmp_helper.py.

  - No functional changes.

v2:
  - the bus error injection is for PCI/PCI-X, not PCIe, so
    the command was renamed;
  - added notes that not all CXL types may occur in practice;
  - removed a field from common_fields at DecodeGhesEntry
    decode class and make it more robust;
  - some cleanups at patch description.

Mauro Carvalho Chehab (14):
  scripts/qmp_helper: add a return code to send_cper
  scripts/qmp_helper: add missing CXL UEFI GUID
  scripts/qmp_helper: add support for FRU Memory Poison
  scripts/qmp_helper: make send_cper() more generic
  scripts/qmp_helper: fix raw_data logic
  scripts/qmp_helper: add support for a timeout logic
  scripts/qmp_helper: avoid long lines when possible
  scripts/ghes_inject: add a logic to decode CPER
  scripts/ghes_inject: exit 1 if command was not sent
  scripts/ghes_inject: add a handler for PCIe bus error
  scripts/ghes_inject: add support for fuzzy logic testing
  scripts/ghes_inject: add a raw error inject command
  scripts/ghes_inject: print help if no command specified
  scripts/ghes_inject: improve help message

 MAINTAINERS                    |    4 +
 scripts/arm_processor_error.py |    8 +-
 scripts/fuzzy_error.py         |  208 ++++++
 scripts/ghes_decode.py         | 1155 ++++++++++++++++++++++++++++++++
 scripts/ghes_inject.py         |   30 +-
 scripts/pcie_bus_error.py      |  148 ++++
 scripts/qmp_helper.py          |  166 ++++-
 scripts/raw_error.py           |  175 +++++
 8 files changed, 1854 insertions(+), 40 deletions(-)
 create mode 100644 scripts/fuzzy_error.py
 create mode 100644 scripts/ghes_decode.py
 create mode 100644 scripts/pcie_bus_error.py
 create mode 100644 scripts/raw_error.py

-- 
2.53.0



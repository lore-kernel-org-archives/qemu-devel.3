Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05870C44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWLP-00032h-5l; Wed, 21 Jan 2026 06:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLH-0002tr-AJ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:43 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLB-0007n0-Qb
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1623B43931;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D874AC116D0;
 Wed, 21 Jan 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768994724;
 bh=2Xj1OzkAzgadkEUNPDq0LOaUKIACUfqk48/8/NZHtfk=;
 h=From:To:Cc:Subject:Date:From;
 b=ZaIdBAH0Mum01UrOvUlltrVt0HgTMNBgN9jufMu4kSB3739wVwFiAM/WPA71S19Pr
 1hVThW1RNexXEMQF7Gx3HlPGpTpnQQD6G53DoaYvK+WtKk/IeZXDL1aFMiQzMnLrSJ
 yaCNuImCR4gfKnrVlPA3GiNgeMkV2GCz2j54aubzEcNjyg66x6gJyQs1JGUJdv3ANl
 Nk0hwYdrukydpX/B1PgPC5lm6e4RozpH3fB8fY8zCcsPEK85TdqVjlnELnoyJLt/ku
 CM7SbReM+slInmimM264+IZKQ9Kvi0/uuKGCHeC/FkBUXjxN/pO4JL7L2g0WXmXzx/
 CAKIREZxYrFPg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWKw-00000003gJH-46jj; Wed, 21 Jan 2026 12:25:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/13] Add more commands to scripts/ghes_inject.py
Date: Wed, 21 Jan 2026 12:25:08 +0100
Message-ID: <cover.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Mauro Carvalho Chehab (13):
  scripts/qmp_helper: add a return code to send_cper
  scripts/qmp_helper: add missing CXL UEFI GUID
  scripts/qmp_helper: add support for FRU Memory Poison
  scripts/qmp_helper: make send_cper() more generic
  scripts/qmp_helper: fix raw_data logic
  scripts/qmp_helper: add support for a timeout logic
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
 scripts/qmp_helper.py          |  159 ++++-
 scripts/raw_error.py           |  175 +++++
 8 files changed, 1849 insertions(+), 38 deletions(-)
 create mode 100644 scripts/fuzzy_error.py
 create mode 100644 scripts/ghes_decode.py
 create mode 100644 scripts/pcie_bus_error.py
 create mode 100644 scripts/raw_error.py

-- 
2.52.0



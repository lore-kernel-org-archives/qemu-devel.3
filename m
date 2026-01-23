Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F84D74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKA-0007PJ-4Q; Fri, 23 Jan 2026 08:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK9-0007Ov-1I
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:41 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK7-0004bh-Da
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36BA060010;
 Fri, 23 Jan 2026 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB53C4CEF1;
 Fri, 23 Jan 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175337;
 bh=/QTJBwJFIqx8dlTl4RKHZe6lxJrK/rKn2HSvXepbKwo=;
 h=From:To:Cc:Subject:Date:From;
 b=ZxaKHkXDLPzTp+PYlI/fcOn6UhAQIK4W13CMqvm16R1VK2AQS9DDUm5u3gWH+Gc9i
 8QzfIwOUvADa7D8tJruGx93OhzJh0TEtNCbFDJpHxKY5G49M7cleqtwRXCeSebT2Ry
 YSJI/MHfPWOt57YryA4Pjo0iu164bRTQzopq+pBA1CjQAu6MRCDHmi508lD5hOxYe7
 jfMe/ZdkPOYAUDvp+Ym42vuC4wFMMMEond2w6wH0zQ59majfAnv/oo8KA0gGO3p8Ed
 kKY1m04UPV+Cd1WjVi1Sy0XnJEqVZQ2YVEgAENUfU+39wiYEybfK8ffH8ll+6NCyoO
 OsjqFeOy4AQJg==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK3-000000063JV-3Qqz; Fri, 23 Jan 2026 14:35:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 00/13] Add more commands to scripts/ghes_inject.py
Date: Fri, 23 Jan 2026 14:35:14 +0100
Message-ID: <cover.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v2:
  - the bus error injection is for PCI/PCI-X, not PCIe, so
    the command was renamed;
  - added notes that not all CXL types may occur in practice;
  - removed a field from common_fields at DecodeGhesEntry
    decode class and make it more robust;
  - some cleanups at patch description.

Mauro Carvalho Chehab (13):
  scripts/qmp_helper: add a return code to send_cper
  scripts/qmp_helper: add missing CXL UEFI GUID
  scripts/qmp_helper: add support for FRU Memory Poison
  scripts/qmp_helper: make send_cper() more generic
  scripts/qmp_helper: fix raw_data logic
  scripts/qmp_helper: add support for a timeout logic
  scripts/ghes_inject: add a logic to decode CPER
  scripts/ghes_inject: exit 1 if command was not sent
  scripts/ghes_inject: add a handler for PCI/PCI-X bus error
  scripts/ghes_inject: add support for fuzzy logic testing
  scripts/ghes_inject: add a raw error inject command
  scripts/ghes_inject: print help if no command specified
  scripts/ghes_inject: improve help message

 MAINTAINERS                    |    4 +
 scripts/arm_processor_error.py |    8 +-
 scripts/fuzzy_error.py         |  208 ++++++
 scripts/ghes_decode.py         | 1158 ++++++++++++++++++++++++++++++++
 scripts/ghes_inject.py         |   30 +-
 scripts/pci_bus_error.py       |  148 ++++
 scripts/qmp_helper.py          |  164 ++++-
 scripts/raw_error.py           |  175 +++++
 8 files changed, 1857 insertions(+), 38 deletions(-)
 create mode 100644 scripts/fuzzy_error.py
 create mode 100644 scripts/ghes_decode.py
 create mode 100644 scripts/pci_bus_error.py
 create mode 100644 scripts/raw_error.py

-- 
2.52.0



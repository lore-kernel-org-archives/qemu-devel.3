Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C834606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfUsxrQB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfg-00038P-HC; Sun, 08 Nov 2026 03:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfe-00037S-24
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:38 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000vc-GJ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21C094393E;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A461F008A2;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=jqtc6dWPG+X6bSMwHL3WZei+Bh3vfV/0G4uFhiM0qmA=;
 h=From:To:Cc:Subject:Date;
 b=kfUsxrQB7BYFWTQ78EAIUFgEMqa9KeEa509Fk0J9JcFdhqCt15C9R1RVbGWZIJtZz
 d4Q2alvyR2I5quVW+Zysoxu1lKVV7OGZwxZ/TxGAZQvRha0pnYs9nz8hbckOTFDsE+
 vgBPdbcRKdWpdDSeu6qeGSTfIYKtJhrNgKznDg5tpNt+RjXpwHb0PmuL9Xmkk6TgYD
 6XlSTXVbFoxV5unN2oHtS/CcmQTd0i4l9TCJ19kdb/iunxrYR0vz8YOiXEI+djD6BN
 Rm1UCiFFFYrd5df4H58F0f5m29GGwZoHoJpIWVwgtN5p5m7ovo6vbRXpDJ6GV/+69+
 tydWQmRW5kifg==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uid-0hsP; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/13] Improve scripts/ghes_inject.py
Date: Sun,  8 Nov 2026 09:54:13 +0100
Message-ID: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

This series improves ghes_inject script, adding support for several
different types of GHES records:

- PCI bus error;
- Raw error inject;
- Fuzzy logic injects;
- CPER decoding for error injections.

They extend the current scope which only supported ARM Processor
errors.

Regards,
Mauro

Mauro Carvalho Chehab (13):
  scripts/qmp_helper: add a return code to send_cper
  scripts/qmp_helper: add missing CXL UEFI GUID
  scripts/qmp_helper: add support for FRU Memory Poison
  scripts/qmp_helper: make send_cper() more generic
  scripts/qmp_helper: fix raw_data logic
  scripts/ghes_inject: add a logic to decode CPER
  scripts/ghes_inject: exit 1 if command was not sent
  scripts/ghes_inject: add a handler for PCI/PCI-X bus error
  scripts/ghes_inject: add support for fuzzy logic testing
  scripts/ghes_inject: add a raw error inject command
  scripts/ghes_inject: print help if no command specified
  scripts/ghes_inject: improve help message
  scripts/ghes_inject: improve the retry attempt logic

 MAINTAINERS                    |    4 +
 scripts/arm_processor_error.py |    8 +-
 scripts/fuzzy_error.py         |  208 ++++++
 scripts/ghes_decode.py         | 1158 ++++++++++++++++++++++++++++++++
 scripts/ghes_inject.py         |   30 +-
 scripts/pci_bus_error.py       |  153 +++++
 scripts/qmp_helper.py          |  201 ++++--
 scripts/raw_error.py           |  175 +++++
 8 files changed, 1883 insertions(+), 54 deletions(-)
 create mode 100644 scripts/fuzzy_error.py
 create mode 100644 scripts/ghes_decode.py
 create mode 100644 scripts/pci_bus_error.py
 create mode 100644 scripts/raw_error.py

-- 
2.56.0



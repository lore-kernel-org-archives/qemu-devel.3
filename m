Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A71C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weX19-0002TP-Ud; Tue, 30 Jun 2026 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1weX18-0002SG-9u
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:52:42 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1weX13-0001L7-0A
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:52:40 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 8488F24002A
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 13:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782820351; bh=X5EHGMU4tcodBdF+eJin3vWWXf+63m8xVIuEbu2aV0w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=cjJOHxpW+OY/EyvBJJZDoeY4jTDyRL0YClc3zVs0ElSOu536GobYIA1i0feI4ov8j
 /tpRp13a2U5MKPSQT4nnw8CT/N1g75brSpCITYPyI7c/66xjWRFdA+5/l9LCPAcp2m
 14WU5+ABCEN0fVq21t/Mzoyjyp5xg0Ap4Agt7Yh1eXAys3uJ2XvUTQq4BHKc3hLxsK
 vV0jXgSdQgkHpDSIQuykFB65gxNQAiStI4KUbaWpl+2NJee7LKJxXE6JgbqcFlzlXr
 SerRJf7U4FTG5LIiNPB2XRb0M5OtfoASpr+cCm53rtNAkT+1dp2oed0fg+56iBalpD
 Av3t08kA70SDg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gqM2j17bjz6v0F;
 Tue, 30 Jun 2026 13:52:29 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Klaus Jensen <its@irrelevant.dk>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 0/2] hw/nvme: add monitor commands for inspecting state
Date: Tue, 30 Jun 2026 11:52:30 +0000
Message-ID: <cover.1782819251.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add two HMP commands for inspecting emulated NVMe controllers from
the QEMU monitor without attaching gdb to the QEMU process:

  - 'info nvme'        - per-controller summary (PCI, identify
                         fields, CC/CSTS/AQA, queue counts)
  - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
                         (size, head/tail, PRP1, doorbell offset,
                         phase tag)

Useful for verifying queue setup, doorbell rings, AERs held in the
admin SQ and similar driver/controller interaction details from a
running QEMU monitor.

Changes in v4:
  - Drop the v3 attempt to gate the new commands with
    'if': 'CONFIG_NVME_PCI'.  CONFIG_NVME_PCI is a device symbol and
    is poisoned in common code, so the generated qapi-introspect.c
    failed to build (reported by Klaus Jensen).  Instead the x-query
    commands stay unconditional and hw/nvme/monitor-stub.c provides
    qmp_x_query_nvme[_queues]() stubs, built when CONFIG_NVME_PCI is
    not set, so targets without NVMe (e.g. riscv64-softmmu) link.

Changes in v3:
  - hw/nvme/meson.build: keep the source file list alphabetically
    sorted (Markus).

Changes in v2:
  - hw/nvme/meson.build: add the missing trailing newline (Markus).
  - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
    Armbruster on both patches.

v3: https://lore.kernel.org/qemu-devel/20260626112116.7621-1-mateusz.nowicki@posteo.net/
v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/
v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/

Mateusz Nowicki (2):
  hw/nvme: add 'info nvme' HMP command
  hw/nvme: add 'info nvme-queues' HMP command

 hmp-commands-info.hx   |  28 +++++++++
 hw/nvme/meson.build    |   4 +-
 hw/nvme/monitor-stub.c |  21 +++++++
 hw/nvme/monitor.c      | 139 +++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json      |  34 ++++++++++
 5 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor-stub.c
 create mode 100644 hw/nvme/monitor.c

-- 
2.53.0



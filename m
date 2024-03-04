Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31924C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8ju-0006KW-N3; Mon, 04 Mar 2024 08:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jr-0006Jb-5E
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:19 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rh8jk-0002JP-M2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:52:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 616F560ADF;
 Mon,  4 Mar 2024 16:52:05 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b709::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jpeXWn4Id0U0-YWHJJc2C; Mon, 04 Mar 2024 16:52:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709560324;
 bh=HPAloJJHbOIzCEgCk9XqLx89JkmzLxC5iwi8MRVssv4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=C4R8/rxldBkkPF8/QDju1YhAEcCTc7ZTASyg95rcyRG9CuJJDSURcEfatAXgHcyQ0
 cdecIqUAQjLjVURFMcv8glWF9rG6hwrJcU+lcKyykmdXTVKy+HweBtax2vE7UZoKvV
 nGzUGBu8zTbfvp9PC4eB0n01dSHqX2XA4ZLlveZQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com
Subject: [PULL 0/4] machine development tool
Date: Mon,  4 Mar 2024 16:51:41 +0300
Message-Id: <20240304135145.154860-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:

  Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)

are available in the Git repository at:

  https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-04

for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:

  scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)

----------------------------------------------------------------
Please note. This is the first pull request from me.
My public GPG key is available here
https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4

----------------------------------------------------------------
scripts: add a new script for machine development

----------------------------------------------------------------

Maksim Davydov (4):
  qom: add default value
  qmp: add dump machine type compatibility properties
  python/qemu/machine: add method to retrieve QEMUMachine::binary field
  scripts: add script to compare compatibility properties

 MAINTAINERS                      |   5 +
 hw/core/machine-qmp-cmds.c       |  23 +-
 python/qemu/machine/machine.py   |   5 +
 qapi/machine.json                |  69 ++++-
 qom/qom-qmp-cmds.c               |   1 +
 scripts/compare-machine-types.py | 486 +++++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.c      |   2 +-
 7 files changed, 586 insertions(+), 5 deletions(-)
 create mode 100755 scripts/compare-machine-types.py

-- 
2.34.1



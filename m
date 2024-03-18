Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE69C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKeW-0000n7-TC; Mon, 18 Mar 2024 17:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeU-0000mN-D5
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:14 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeR-0004ov-Kt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5a2f:0:640:431a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 226AE60B26;
 Tue, 19 Mar 2024 00:36:07 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b660::1:2d])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pZLCWv3IeqM0-oYaQbtTk; Tue, 19 Mar 2024 00:36:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710797766;
 bh=9PFLpKH8I4rJBuW5iMgRqYdFBDgbIiD6df1cxhllUaM=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=cpyP2MeBe7Eos6tAV/yNcXB4qK/MFMcbrxyPlLKpkCpSMColhd4Hj6eXmtRc9BBYk
 1DWmFRz3TZSDHeO2TuAQlS0/sIfP7w5L9MC8WjLO3EoY3uA2UyY+UC51UGYOPB6tw7
 bh4xdrVIlOx5vVps+8GFjXLOlv3Xh10Syd2yfmiE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PULL v2 0/4] machine development tool
Date: Tue, 19 Mar 2024 00:35:46 +0300
Message-Id: <20240318213550.155573-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:

  Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)

are available in the Git repository at:

  https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-19

for you to fetch changes up to e12b89f71ba5b93877b6a3adc379a6369d0c9bab:

  scripts: add script to compare compatibility properties (2024-03-19 00:13:54 +0300)

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
 qapi/machine.json                |  67 ++++-
 qom/qom-qmp-cmds.c               |   1 +
 scripts/compare-machine-types.py | 486 +++++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.c      |   2 +-
 7 files changed, 585 insertions(+), 4 deletions(-)
 create mode 100755 scripts/compare-machine-types.py

-- 
2.34.1



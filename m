Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBC7C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBAl-0004Ta-2R; Thu, 22 Feb 2024 10:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rdBAi-0004SX-Vg
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:39:40 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rdBAe-0002T3-Tu
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:39:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1E47960D79;
 Thu, 22 Feb 2024 18:39:30 +0300 (MSK)
Received: from davydov-max-nux.yandex.net (unknown
 [2a02:6b8:8f:4:b109:a1eb:adad:8bd8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CdVQ8Q0i7a60-Tn1ToHNX; Thu, 22 Feb 2024 18:39:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708616369;
 bh=crMFHT4qx5UXAAV9U85pJhvgu+dNeQPaN6oP5JBPgpQ=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=oc3Kq+H/Nq5whL5FZtUJcWWKahOn2alnedZFdlypHlsH+2D6oZTGzysiWQzzqflSW
 MUXZqVOwU7DV3Bm7bjuDGwI07t+VqR1+oMp7rT4O0n2wwALez9qxDDOKOiFBIpW16J
 PSzSLnq94oc/HRSeWuFOSPjDv8tXJL7ofvlbZy0g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 jsnow@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, den@virtuozzo.com
Subject: [PATCH v9 0/4] compare machine type compat_props
Date: Thu, 22 Feb 2024 18:39:08 +0300
Message-Id: <20240222153912.646053-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This script can be used to choose the best machine type in the
appropriate cases. Also we have to check compat_props of the old MT
after changes to be sure that they haven't broken old the MT. For
example, pc_compat_3_1 of pc-q35-3.1 has Icelake-Client which was
removed.

v9 -> v8:
* qapi minor fixes

v8 -> v7:
* rebase
* fix encoding

v7 -> v6:
* minor fixes

v6 -> v5:
* add ability to compare different QEMU binaries
* replace abstract drivers by its implementations
* improve human-readable format
* code refactoring

v5 -> v4:
* minor fixes

v4 -> v3:
* increase read buffer limit to limit value in libvirt
* add caching of qmp requests to speed up the script 

v3 -> v2:
* simplify adding new methods for getting QEMU default values
* add typing
* change concept from fixed dictionaries to classes

v2 -> v1:
* fix script code style and descriptions
* reorder patches
 
v1 -> previous iteration:
* new default value print concept
* QEMU python library is used to collect qmp data
* remove auxiliary patches (that was used to fix `->get` sematics)
* print compat_props in the correct order
* delete `absract` field to reduce output JSON size

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



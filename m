Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851D4CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 04:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr8ql-0002fq-0x; Mon, 01 Apr 2024 00:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rr8qM-0002eM-N7
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 00:00:26 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rr8q9-0007ae-Md
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 00:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711944009; x=1743480009;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UPbS45mogVLEXtZ3PUKm6iw6UXebWwJjKMFN8xW0AN4=;
 b=GTsisjvFA6/irlzAbaC6d1HfUbLXeQXn8lFub9KkbBEpnlbJZq/5PQJk
 paOE/I7716Mq9RRGCBiPQHjcZ/94a3RC0roXNyWyH2Ag1j5C2JMBOCgkf
 u/Tyc7zlWE21Y2jf1ac+4gcgAqGlFCOCYFFbN7H/hUxQC2upvrb/AIYhE
 9gUAa85zhDXZLBr+XOaZGBkNsuvyAQ5cimes4xIZUYhcj4Z5to6KDiMBr
 s74dQUDQ9dM5LE6hUxObfG5Rur/WhvgHWHG4hHvXaSSrD4jtd4Rh4V/ll
 pGqyJNg5WXkOj9Ez5KvBJw4ikpEnH2p9h+qCFoAgdlEW7uXdf/wy2Mjf5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="141802960"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; d="scan'208";a="141802960"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 13:00:00 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 28CDFE48CF
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 12:59:58 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C4AACF7C5
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 12:59:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DED9F200930B9
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 12:59:56 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 05F9C1A0002;
 Mon,  1 Apr 2024 11:59:55 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCH] migration, docs: mark RDMA migration as deprecated
Date: Mon,  1 Apr 2024 11:59:47 +0800
Message-ID: <20240401035947.3310834-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.004
X-TMASE-Result: 10-2.147000-10.000000
X-TMASE-MatchedRID: nPi4oHBtXK9lJTodqNqEzjyjd/AizytB70GLyvzOg0wtorPLNYrwZM0r
 4EQd5HFn3Rq1qtW57uOqJrxm+7M28o+z55hhQLxaPPov5T+l6PFR09VBMijhEhHfiujuTbed9td
 qeh2SlxRvu+EAUOCx08XqdQXvlcuhJeC1ekK9qa5g/IrbTV5uGwmWvXEqQTm5wLkNMQzGl5B+Kr
 WCPbERP9oUzlM8Yt0I/bMSKH98KOqk+AYa0R5ReKqHmm/V4M/P9fvWztwgm5O15eNIExieadlvG
 szx4amtAYnGHLN6aWagh7qZ/QUBXybhFR0gzhzWB7AFWMPZIMa6hgVvSdGKo9M4cBkOddRuaeKm
 PS8s02ihrwhaqCksE1+24nCsUSFNjaPj0W1qn0TGVuWouVipcgDl94+zTL1mGkQeUniLxex/maq
 3/fkyB8fEPCN1K/qy9DCRDnSxNvB5OGkTPbk5DYimVzY9z+7t9XpBY66dX2JlJfJbtLV/SBLxyJ
 E4sOe8rslobISoT4SXgJhkGsJwzltjCyRSdIOA4k4JpZi7wBM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Except for RDMA migration, other parts of the RDMA subsystem have been
removed since 9.1.

Due to the lack of unit tests and CI tests for RDMA migration, int the
past developing cycles, a few fatal errors were introduced and broke the
RDMA migration, and these issues[1][2] were not fixed until some time later.

Modern network cards (TCP/IP) can also provide high bandwidth
(similar to RDMA) to handle the large amount of data generated during
migration.

Issue a warning to inform the end users of the RDMA migration status.

[1] https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
[2] https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com

CC: Peter Xu <peterx@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@linaro.org>
CC: Fabiano Rosas <farosas@suse.de>
CC: Thomas Huth <thuth@redhat.com>
CC: Daniel P. Berrangé <berrange@redhat.com>
CC: Yu Zhang <yu.zhang@ionos.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 docs/about/deprecated.rst | 15 +++++++++++++++
 migration/migration.c     |  1 +
 2 files changed, 16 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..fe70a7009e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -529,3 +529,18 @@ Compression method fails too much.  Too many races.  We are going to
 remove it if nobody fixes it.  For starters, migration-test
 compression tests are disabled because they fail randomly.  If you need
 compression, use multifd compression methods.
+
+RDMA migration (since 9.1)
+''''''''''''''''''''''''''''''''''
+
+The QEMU project intends to remove the whole RDMA subsystem from the
+code base in a future release without replacement unless somebody steps
+up and improves the situation. So far, except for RDMA migration, other
+parts of the RDMA subsystem have been removed since 9.1.
+
+Due to the lack of unit tests and CI tests for RDMA migration, in the past
+developing cycles, a few fatal errors were introduced and broke the RDMA
+migration, and these issues were not fixed until some time later.
+
+Modern network cards (TCP/IP) can also provide high bandwidth (similar to RDMA)
+to handle the large amount of data generated during migration.
diff --git a/migration/migration.c b/migration/migration.c
index 9fe8fd2afd..807d66bbba 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -563,6 +563,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
             qapi_free_InetSocketAddress(isock);
             return false;
         }
+        warn_report("RDMA migration is deprecated and will be removed in a future release");
         addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
     } else if (strstart(uri, "tcp:", NULL) ||
                 strstart(uri, "unix:", NULL) ||
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C03DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roj1C-0002bx-Cp; Mon, 25 Mar 2024 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1roj12-0002Vz-KO; Mon, 25 Mar 2024 08:01:26 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1roj0x-0006WU-Lv; Mon, 25 Mar 2024 08:01:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:400c:0:640:9907:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 91E6A609BD;
 Mon, 25 Mar 2024 15:01:09 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b406::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id u0Je2116L8c0-sE3xbQeS; Mon, 25 Mar 2024 15:01:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711368069;
 bh=mwcfUB5yQzkilgfEFaFishST8TR/k+1le1OVWeTNkNg=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=xrIzxLvsrwiphimEFV/1/DI1tb/f3Ds27H8SPo0YZiMADiylLMwdoWRJQwqg6g6u7
 vQy0Vkjylq+qbwPpJm81kzlYIR39t7XHJmWN9mXBiCqTXWFtyVVzOynzR36sfvNk5+
 vvkblzYLLi9gh8NtwD3XQt0UAqFVaTJYD47tpETU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH] qapi/block-core: improve Qcow2OverlapCheckFlags documentation
Date: Mon, 25 Mar 2024 15:00:54 +0300
Message-Id: <20240325120054.2693236-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Most of fields have no description at all. Let's fix that. Still, no
reason to place here more detailed descriptions of what these
structures are, as we have public Qcow2 format specification.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/block-core.json | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1874f880a8..b9fb994a66 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3403,14 +3403,31 @@
 # @Qcow2OverlapCheckFlags:
 #
 # Structure of flags for each metadata structure.  Setting a field to
-# 'true' makes qemu guard that structure against unintended
-# overwriting.  The default value is chosen according to the template
-# given.
+# 'true' makes qemu guard that Qcow2 format structure against
+# unintended overwriting.  See Qcow2 format specification for detailed
+# information on these structures.  The default value is chosen
+# according to the template given.
 #
 # @template: Specifies a template mode which can be adjusted using the
 #     other flags, defaults to 'cached'
 #
-# @bitmap-directory: since 3.0
+# @main-header: Qcow2 format header
+#
+# @active-l1: Qcow2 active L1 table
+#
+# @active-l2: Qcow2 active L2 table
+#
+# @refcount-table: Qcow2 refcount table
+#
+# @refcount-block: Qcow2 refcount blocks
+#
+# @snapshot-table: Qcow2 snapshot table
+#
+# @inactive-l1: Qcow2 inactive L1 tables
+#
+# @inactive-l2: Qcow2 inactive L2 tables
+#
+# @bitmap-directory: Qcow2 bitmap directory (since 3.0)
 #
 # Since: 2.9
 ##
-- 
2.34.1



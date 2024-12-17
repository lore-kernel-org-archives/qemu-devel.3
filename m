Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C6DE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYn0-00022l-HB; Tue, 17 Dec 2024 09:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1900011634@pku.edu.cn>)
 id 1tNYhE-0000OA-Me; Tue, 17 Dec 2024 09:37:12 -0500
Received: from mx16.pku.edu.cn ([162.105.129.179] helo=pku.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <1900011634@pku.edu.cn>)
 id 1tNYh7-00061w-6J; Tue, 17 Dec 2024 09:37:12 -0500
Received: from pku.edu.cn (unknown [10.7.217.246])
 by mtasvr (Coremail) with SMTP id _____7DwdzGBjGFnee4RAA--.3371S3;
 Tue, 17 Dec 2024 22:36:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=arPODaSXgi
 vVhuH8/UL0foLKwZv7ZXqUP1yBPikTolI=; b=HmpWkrHrYYbO5phWTK85dIkkjA
 TeHD+ewX5F1HCIIQVb//mLkfB4/xts2UhdXxEs7cgMySW7/Ew4a9qL7P3BDcpl2x
 ZkSI1PQdk/Aeps25MPvTT/y8TA3bBiXNv+rNjVdkTU/5tAGKMe2FrLqB09B7lWYu
 sVLoIhKbdZiRMivAA=
Received: from localhost.localdomain (unknown [10.7.217.246])
 by front02 (Coremail) with SMTP id 54FpogAXJKWAjGFnVSxIAA--.4445S2;
 Tue, 17 Dec 2024 22:36:48 +0800 (CST)
From: ckf104 <1900011634@pku.edu.cn>
To: qemu-trivial@nongnu.org
Cc: ckf104 <1900011634@pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] contrib/plugins/bbv.c: Start bb index from 1
Date: Tue, 17 Dec 2024 22:24:15 +0800
Message-Id: <20241217142413.148978-1-1900011634@pku.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAXJKWAjGFnVSxIAA--.4445S2
X-CM-SenderInfo: istqijqrtsiko6sn3hxhgxhubq/1tbiAwEOEWdgbPERCgAFsZ
X-CM-DELIVERINFO: =?B?Hn0nEKaAH6dYjNjDbLdWX9VB7tvCgFsWh6gq2SLela0U3wZu5GTe0OKCMDL6rypGpz
 qJlKNnGD0k5JE1EzxpQyIhfppD2kv5l0QpMK9HIo+3hhve9QiyMXRPLYtgHjlI/hiwFJMU
 nF2q22G7ZL26fWzEX773JPR/O6MHo6a/0AEr5ld0/PTB4dnK6yWm2Y9BQMI/UA==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=162.105.129.179;
 envelope-from=1900011634@pku.edu.cn; helo=pku.edu.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Dec 2024 09:43:06 -0500
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

Standard simpoint tool reqeusts that index of basic block index starts from 1.

Signed-off-by: ckf104 <1900011634@pku.edu.cn>
---
 contrib/plugins/bbv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index a5256517dd..b9da6f815e 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -109,7 +109,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         bb = g_new(Bb, 1);
         bb->vaddr = vaddr;
         bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
-        bb->index = g_hash_table_size(bbs);
+        bb->index = g_hash_table_size(bbs) + 1;
         g_hash_table_replace(bbs, &bb->vaddr, bb);
     }
     g_rw_lock_writer_unlock(&bbs_lock);
-- 
2.34.1



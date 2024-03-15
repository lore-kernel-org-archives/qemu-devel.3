Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751ABC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5Cq-0001rM-Rz; Fri, 15 Mar 2024 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rl5Cn-0001r2-8A
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:54:29 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rl5Ck-0002ll-Pg
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:54:29 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHz7PeKPRl1Yq1Bg--.24203S2;
 Fri, 15 Mar 2024 18:54:22 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwBHuUHUKPRlaIwAAA--.853S4;
 Fri, 15 Mar 2024 18:54:16 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chenbaozi@phytium.com.cn,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Fri, 15 Mar 2024 18:53:36 +0800
Message-Id: <20240315105336.464156-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
References: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHuUHUKPRlaIwAAA--.853S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsFBgAAs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7KryrZw4xuFWfKr1DAr4rAFb_yoW8uw1UpF
 W3uryIkr4kXa1a9wsxAas0g3y3Zay0grW3urWUt3s3G34avF98XF1fJ3yjyFsIkFyrXF1x
 Arn8Zr45GayjgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

The dev_dbg info for Clear Event Records mailbox command would report
the handle of the next record to clear not the current one.

This was because the index 'i' had incremented before printing the
current handle value.

This fix also adjusts the index variable name from 'i' to 'clear_cnt'
which can be easier for developers to distinguish and understand.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/core/mbox.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..3ca2845ae6aa 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -881,7 +881,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	struct cxl_mbox_cmd mbox_cmd;
 	u16 cnt;
 	int rc = 0;
-	int i;
+	int clear_cnt;
 
 	/* Payload size may limit the max handles */
 	if (pl_size > mds->payload_size) {
@@ -908,28 +908,29 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	 * Clear Event Records uses u8 for the handle cnt while Get Event
 	 * Record can return up to 0xffff records.
 	 */
-	i = 0;
+	clear_cnt = 0;
 	for (cnt = 0; cnt < total; cnt++) {
 		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
 		struct cxl_event_generic *gen = &raw->event.generic;
 
-		payload->handles[i++] = gen->hdr.handle;
+		payload->handles[clear_cnt] = gen->hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
-			le16_to_cpu(payload->handles[i]));
+			le16_to_cpu(payload->handles[clear_cnt]));
 
-		if (i == max_handles) {
-			payload->nr_recs = i;
+		clear_cnt++;
+		if (clear_cnt == max_handles) {
+			payload->nr_recs = clear_cnt;
 			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 			if (rc)
 				goto free_pl;
-			i = 0;
+			clear_cnt = 0;
 		}
 	}
 
 	/* Clear what is left if any */
-	if (i) {
-		payload->nr_recs = i;
-		mbox_cmd.size_in = struct_size(payload, handles, i);
+	if (clear_cnt) {
+		payload->nr_recs = clear_cnt;
+		mbox_cmd.size_in = struct_size(payload, handles, clear_cnt);
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc)
 			goto free_pl;
-- 
2.34.1



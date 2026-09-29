Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7214CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBR04-0003wn-2W; Tue, 29 Sep 2026 02:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>) id 1xBQzz-0003we-Hf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:07:31 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <malike@kylinos.cn>) id 1xBQzv-0005cT-PH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:07:31 -0400
X-UUID: fff68982bbcb11f19a56ed5b684f684d-20260929
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED
 SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
 DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
 GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:62d6d7c2-94dc-4305-a428-c43061d90f1b, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:62d6d7c2-94dc-4305-a428-c43061d90f1b, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:b434288b2c717f9d9f62a9505fbe32dc,
 BulkI
 D:2609291407102SHSV5HJ,BulkQuantity:0,SF:19|66|72|78|102|127|136|850|865|8
 98,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:
 nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
 RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fff68982bbcb11f19a56ed5b684f684d-20260929
X-User: malike@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <malike@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1551843066; Tue, 29 Sep 2026 14:07:07 +0800
From: malike <malike@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	kkostiuk@redhat.com,
	malike <malike@kylinos.cn>
Subject: [PATCH] contrib/systemd: use BindsTo in qemu-guest-agent.service
Date: Tue, 29 Sep 2026 14:06:53 +0800
Message-Id: <20260929060653.445985-1-malike@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=malike@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The qemu-guest-agent systemd unit uses the old BindTo= directive
name. systemd renamed BindTo= to BindsTo=, so use the current
directive name here.

systemd commit 7f2cdda committed on Jul 14, 2012:
unit: rename BindTo= to BindsTo=

Fixes: 2ba60ec17518 ("contrib: add systemd unit files")
Signed-off-by: malike <malike@kylinos.cn>
---
 contrib/systemd/qemu-guest-agent.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/qemu-guest-agent.service
index 51cd7b37ff..59f7ecb1b8 100644
--- a/contrib/systemd/qemu-guest-agent.service
+++ b/contrib/systemd/qemu-guest-agent.service
@@ -1,6 +1,6 @@
 [Unit]
 Description=QEMU Guest Agent
-BindTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
+BindsTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
 After=dev-virtio\x2dports-org.qemu.guest_agent.0.device
 
 [Service]
-- 
2.25.1



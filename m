Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F107610F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKb-0004IO-Tt; Wed, 08 Apr 2026 15:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wAYJa-0000cH-2v
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:50 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wAJPw-0001Hd-Dx
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 23:17:27 -0400
X-UUID: 713b188032f911f1aa26b74ffac11d73-20260408
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CHARSET
 HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD
 HR_DATE_ZONE, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
 HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_CHARSET, HR_TO_CHARSET_NUM
 HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED
 DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SPF_NOPASS
 DKIM_NOPASS, DMARC_NOPASS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:965af201-8381-493d-a269-d613d47d5272, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12, REQID:965af201-8381-493d-a269-d613d47d5272, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-15
X-CID-META: VersionHash:e7bac3a, CLOUDID:145b4d5716a1a27405f1412b8b892d8a,
 BulkI
 D:260408111718OAURA2JV,BulkQuantity:0,Recheck:0,SF:10|66|78|102|123|127|85
 0|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
 S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
 ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 713b188032f911f1aa26b74ffac11d73-20260408
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 401683017; Wed, 08 Apr 2026 11:17:15 +0800
From: zhaoguohan@kylinos.cn
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] ui/spice-app: detect runtime directory creation failures
Date: Wed,  8 Apr 2026 11:16:44 +0800
Message-ID: <20260408031644.640765-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

spice_app_display_early_init() creates the per-VM runtime directory
with g_mkdir_with_parents() before setting up the Spice socket. The
code checks for "< -1", but g_mkdir_with_parents() returns -1 on
failure, so the error path is never taken.

This lets spice-app continue after a directory creation failure and
defers the problem to later setup steps.

Check for "< 0" instead so the failure is reported immediately and
spice-app exits before using an invalid runtime directory.

Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice client")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 ui/spice-app.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 9e55f2737159..0df7325e6792 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -151,7 +151,7 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     if (qemu_name) {
         app_dir = g_build_filename(g_get_user_runtime_dir(),
                                    "qemu", qemu_name, NULL);
-        if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
+        if (g_mkdir_with_parents(app_dir, S_IRWXU) < 0) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));
             exit(1);
-- 
2.43.0



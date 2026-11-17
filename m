Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B426606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nelOpxkE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKS5-0002wi-5A; Tue, 17 Nov 2026 09:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xTKRd-0002uu-P9
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:46:14 -0500
Received: from mail-pi2-x09.google.com ([2607:f8b0:4864:3a::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xTKRa-0007wi-7J
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:46:01 -0500
Received: by mail-pi2-x09.google.com with SMTP id
 41be03b00d2f7-cdd769c49dbso2290147a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794926756; x=1795531556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EDSurTbj8NuiS/VBIFZZBRq/3uZ+Ad6RYdcMEGiHyTE=;
 b=nelOpxkE5wJ5ps7+NBYTaxq59Ehgl2xFjsNlPxFBSaNMxyOrCo1FKd18gz6Fxk0dFp
 0iFaG46cNb7T/d9iGT84COEt63aQ5YT9CvyIcWskWSLzyOUFMMUnma7+XgCkUaxeCGp8
 6I0vqxMS9qNdBI0N718VvqrTPYbTGLHax/4aa9sMLduyCFUN2NgrlDLyV44HhS5TyFvR
 TNyNNtUTOz/X9eiIlc5/YeLN1G+TmxUMHlQDYJ7Bpeeb7mu7MnUi/cTNvLHbGOm48zCB
 B+eWH5oqT6Visuuowssqg2uvsWD8CVdbJ9CyHhh9wqDGVtRYMxNVrmn1lAyTXqCyvY1d
 p2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926756; x=1795531556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EDSurTbj8NuiS/VBIFZZBRq/3uZ+Ad6RYdcMEGiHyTE=;
 b=Xsg0tq1UW/9BHSIkg5BmJyGuza+jz1cvP/MnPSsT9wtYUKDsB7teNLnxoMkHRlnv90
 ofmGaZKLaICpwFm2g4poKgOXW0niAxDB8vsmaPoXMlV9Bv1jRSLiYyhzLEV9znItlbNh
 IOtsc45/Em8cNjbM4x0r4henrzHJ88GLHovNl8dXzkBA8AxA8y3O0ije995M+aswGwuj
 Y+uM6n1NFHAgjp3/mjyX62of8XQ+yXvrhBTsevOLTKX8AQ1SEQGJZp7nUPf+8X0wB5Y8
 EmTMfG/jOSzPRaMAckyYDnlFuxEJk06Q2MVAkoKxCZXbnOfPTZx51im7/gy5+/YSgBvY
 KZSw==
X-Gm-Message-State: APuU4Z9Sk1I2c8di+D02UF3g2I2/V/3gNFf1AkLSscp7dQHVg20hBP37
 tSDQ5JFrlhh5mEhRuOwUmH0/baqSzl92nGl1B3WA3unNGdYX5A9L75OgbGKi9X2/Tbs6Lg==
X-Gm-Gg: AYBFou1Hnsa+lamBqlDg6icOtrjk/yAsHpIrQ2b5K6YVdYQw1kM3TaLrzCL7wmXk/VM
 sMNScRQo1PTZ2MurUofR1G058CruARdBudD4L82TPN+0kQok7vkYS/DYJ7vJX52nEdoZliZ4kIN
 KdXqA/KtyxX7HCKbH5A2MhuG7yvhtq7jT+Ec/V8lPJlp439Hj34R3facSJLTu/9ebjFCxWbrrue
 hUI2py24t2zgkE4JTHA5MaT9j4cb5wrf8xbo7r2Vbi9Z9Gf9luNr76vyEcvG+6VT62NX2mCVD/k
 ehVbrAa1jTRBq2Ci9UV2Vv19wGfQ2p2dofLIGfudS61j70Gq1yqapZOlO6TRXXe3RmFMDcDmyKD
 n2r2rRTup9CYCWpis48jl3GGNIaPHRJIcXaC1/hRLdrrn4ZdLmeXBYvvMJlvMSrjUY+3an8DYdD
 D120YcJXgkuDt0mUVT7XNwBtP6NHOGKulGzrgeEFxvNBN+VYc7OOtfyBdx/FgxgU/ZxDuK/6CS1
 NabAF+rfIePkICEBcFSXpV8FrHvqPjqkS3SfdeZNY23rsboWhxqlqwaKhiwa5AWAuBgXyVvwwgp
 cR7cUZmdLqQicU9GO8qN+b92S+M=
X-Received: by 2002:a05:6a21:168d:b0:3eb:a7ca:4d70 with SMTP id
 adf61e73a8af0-3f7a8bd850amr13693876637.58.1794926756113; 
 Tue, 17 Nov 2026 06:45:56 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde150b8efcsm1244776a12.2.2026.11.17.06.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:45:55 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 niming <niming@sangfor.com.cn>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 1/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Tue, 17 Nov 2026 22:45:48 +0800
Message-ID: <20261117144548.3252867-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117144548.3252867-1-zhuwei@sangfor.com.cn>
References: <20261117144548.3252867-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::9;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhuwei <zhuwei@sangfor.com.cn>

hmp_info_block_jobs() uses 'list' both as the head of the BlockJobInfoList
returned by qmp_query_block_jobs() and as the iterator of the while loop.
Once the loop finishes, 'list' is NULL, so the call to
qapi_free_BlockJobInfoList(list) at the end of the function frees nothing
and the whole list returned by qmp_query_block_jobs() is leaked.

Keep the head of the list in a separate variable and free that one after
the loop, so the entire list is released as intended.

Fixes: 2bcad73c4b9b ("monitor/hmp: move hmp_info_block* to block-hmp-cmds.c")
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 block/monitor/block-hmp-cmds.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7bae4d425c..d3f404146a 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
 
 void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
 {
-    BlockJobInfoList *list;
+    BlockJobInfoList *list, *head;
 
     list = qmp_query_block_jobs(&error_abort);
 
@@ -769,6 +769,9 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
+    /* Keep the head: list is NULL once the loop below is done */
+    head = list;
+
     while (list) {
         if (list->value->type == JOB_TYPE_STREAM) {
             monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
@@ -791,7 +794,7 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
         list = list->next;
     }
 
-    qapi_free_BlockJobInfoList(list);
+    qapi_free_BlockJobInfoList(head);
 }
 
 void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
-- 
2.56.0



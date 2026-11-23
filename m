Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE30606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IaUtECKs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQzO-0006pv-LN; Mon, 23 Nov 2026 05:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVQzM-0006p8-13
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:09:32 -0500
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVQzJ-000693-Vg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:09:31 -0500
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-3b10718b387so1690042a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795428568; x=1796033368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UYLF+YDoe+D/lmggnE8is2pCOVG/LGO2lnEmdN+zB0w=;
 b=IaUtECKsBhwLoCKlE3bkIkpp3YEWruX4DwksGrNtz94mBPgx/XOIOiEErx/cbuw7iH
 95Hl696qqcO7648eycIEj5mXrGRD90DMnEKKxgptyugzr8WUNTIc5kmUVJqH9qgYPZlp
 0yx7YJfjRChaik8mWqqBapEprELojHi8Es33+7Qy3fToUhFhWAgxOD3cdqjUfARQ0cc+
 jGBkd4kmhzrvzMNt7D+aAp7oFw2TJu02zYkzggc8ndM8bhvgkGvgUj/1Lmmh9PzzT4Zy
 WeXs+erjKCBeHH9d/tj76wyewzrwt0csWKoqxxAS0q6hb5n7ZM88W1cssLdo+LL/xQ08
 MG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795428568; x=1796033368;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UYLF+YDoe+D/lmggnE8is2pCOVG/LGO2lnEmdN+zB0w=;
 b=aKmzoMUF3kUDbNqEtpgfjUehSFVqiop+Q6JZFyiu3xdtdtISYKDaCvWBlBqJ028Egt
 q7GglTLAhPvP1HNpeq7wMDLaWg+TgVnBwutOMJnyZa11YgaDHZGWCu3G/XsbzkNbz/Bm
 x7GlyD2aKpMYP7kLshTGYTUbcFkVG20QTuqh6PLUiWTPgLG+PgjBP1oBA+RE3dPfr2Pv
 h12dQQag3cy7C6MOidRRDtvLxgdm1WX+xmRxTlJGEUTd2njJ/1pSaSfZGC/su5aMYtMp
 wWSyu2HerNzohX7a301j9v3zXpB68SywL4tZhy6zPb90gHr0dgSg8p4U/zvnR+dB7LFW
 /QFg==
X-Gm-Message-State: APuU4Z/1IBGB8QSc1ETP2horMe1h7gUAoZYPzh9qt1W5M9XdGdHw1Qop
 r8MDhqAWdlv9YWJ1XHDHD6NR8o1PKwokVo9UnNgRTu4fpdphpkNis9ppcw4ryfxxGEA=
X-Gm-Gg: AZFdTZe7HMKprj9xvJjU8oPyhSEvDJYC2xVv3LWGNMK41ccTBZSVWSrxeT5FqzvUO5J
 1mpuB4+9zL67Mj0qByACMkl0ibH1ysbozJ34W7SXPu7EYNJ8z5/+ddjMUtUg3aZJ5dMwnTMo8C+
 uvMTRlF/fty4Sa2R0pAOHHOYQGAAvj1XlYKpoS7XxKaAkeTukK14ouGJNO9m+bCofrxnt73LYE9
 J3JjmNzR8vGi1Op42jwdxjuM6x7fdbtuNkmf0pqFqjHECMngyp66w3Of5Ln1iI/++7r5WiIbSVG
 QS3N/7jrfB8uZCZ9KAppoBQaOH383IkeogpvFZ74qIsOBtEEqJQ7Bwc73GO+AqL0M7FlNns7Ixz
 5hGRxV28WzB0qh2IoHRacKDxLX7lxvv2LqwpA5n4GIVyDuijcjH5BFhPzBSENAI4mPgMhuuCBvl
 8XijTDtcEtCTDbCQb5EmbKaZqhHQ665swRWC0w+ONl8RdE8q1YjMPlGd+qiwabTh1P8y4WwkIKu
 b+qdCyXNI3yoLhF/HhimMyBXxz+M1LlDO0PU8Tvr2ftCTzuy8fCywCV4ck/M3tzMw14gZpblIFx
 WU6dERFQr9Mf0xkgXyEzbBm/Ea4=
X-Received: by 2002:a17:90a:e70c:b0:3a8:6045:5a19 with SMTP id
 98e67ed59e1d1-3b41cafcc05mr10406137a91.37.1795428568341; 
 Mon, 23 Nov 2026 02:09:28 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b48b41928esm6198164a91.9.2026.11.23.02.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 02:09:28 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v3 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Mon, 23 Nov 2026 18:08:49 +0800
Message-ID: <20261123100920.2966172-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123100920.2966172-1-zhuwei@sangfor.com.cn>
References: <20261123100920.2966172-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=zachwade.k@gmail.com; helo=mail-pj2-x04.google.com
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

Fixes: fb5458cd10a1 ("qmp: add query-block-jobs")
Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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



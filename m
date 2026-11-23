Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4B606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E2T7old2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVU1s-00066m-IY; Mon, 23 Nov 2026 08:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVU1d-00065i-Hd
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:24:08 -0500
Received: from mail-pi2-x07.google.com ([2607:f8b0:4864:3a::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xVU1X-0002iX-2Q
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:24:01 -0500
Received: by mail-pi2-x07.google.com with SMTP id
 41be03b00d2f7-cd66d7e32baso834276a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795440237; x=1796045037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e/qmFMO49WMYSF6ilK2RdGnyySpu9NYqRsXlb3GqRt8=;
 b=E2T7old28h6UsXQpE6LT1zlsg3aV4pK+x91Ka3v8Oion2iJdItm33nR0GIBY/YtTnD
 CZjAwy+NXB35WK4U6DEv6pbjvybAHEegoLFPKtCYdgFRPt7YXHK+rXa8VBfCNbUO3jMX
 5DAnqaPOuWUtmDRb1uEqua/4S8ZJAQZcIvvi6JKRSHIHjAXs6fbxGEml3yu+xXvL/XKi
 JHWsvY5jK6Z/f6WRLVZ0btkOUAyGU4hL6DTc31c9etg2/kWmquRXeL8sKWPkIuNL5wLq
 KveRHksSdGLp+QUUzg+CP7AOtk2AmIeebf2H4x9PYsVuZjtuPv0BajGN/HEjWYLotZug
 6DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440237; x=1796045037;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/qmFMO49WMYSF6ilK2RdGnyySpu9NYqRsXlb3GqRt8=;
 b=R0XB5gnDeEUBIl9C6PpX/FgcDISyCrImZRXa6X8HuF0oxPvvMDdi8kX3UPdWTbhC7C
 VFx13GT+ogPuHSSzclTFuKHYiO+AcdG3650TnCPEjICiDks9MSPpwplTfoW1dqUVF2QL
 PuiSmaWL//q0oqCwcNeB6UajqqC9Eu5z+CSL11Fj6eYHACstpj8g/K9iKHJps0/WGdJp
 tJIWXUvKU4vlrKNQGAa8ZHYSMSaQFaZxaz+Kx86JOkrxbhtFJtDVcFy7N3rqv+FfnbON
 itB1HsoLrr/tpdarYhIt20UJBAl2VWFSPNGK/xeCzdp7a5B1xnRnElaZIIFoTsJfEuMk
 YQAw==
X-Gm-Message-State: APuU4Z/e5KmRGFDyT047AEn0ePVhyAwztvflR1lABquri5S/iJr1y7B9
 HPKU3kv0wji5wr4UYGIKOQzPJJnNL5TG+dsCRa3/q4Y0KPBsBWer86sj58x00b4Xh8Emgdeu1jU
 =
X-Gm-Gg: AZFdTZezKomU1PxJdNHiZFmzYqLT5gAQftoVRR411YzQvFBNg29ka9lEbHud6nW+2KI
 1ZuGrcAhtpC8sPBMLfr/eEQLOJcBF5sLko+9SfQw/y3+p4BDC0iF2EtDJsQa3APvqqCPmkggd0w
 dm2Tw4mpbFvaCkdCYu09d1zBE/HyaFLhIz5f5TxBfIBVRTC+JYdGH6PkTvYFkBJfq68cmR/onI6
 ns3wvXBQDcv6RHIZ5j6oaqCICMus4lh5ZfPxxUDwKDq4ysm6WHYwGDqI0vV9NNi2RUvDNjvYfHn
 skeaFcsca4N3jmLjfRYYoF27wJDvFR5qfnEraaBnhD82C1PWBoz0BXdx27AbM3eH064jSl4M1L1
 Lak44Pjk8urQHFHyiqg0KHA0U4NBKln8REqS19e9jzE3bXIRhyXwn36ENE//zCqwwHX5Ea1zYsK
 1df0bkM4aPhKY7ffrad15iYLXZxx690YVzSq5uz8reIv6BU+vIHyc4ZwQXQf20crzD999CZU3dw
 u466txG7hyZsBX7/fgkmZ9TBx7Qg3hC3jes5NS9Ad8mphWnNLv39bl05kEtE93GK2D3pWgoE6fw
 7M6L3Sclv0trHQXMkwodHT6b9Yw=
X-Received: by 2002:a05:6a00:852:b0:89f:7ed5:865c with SMTP id
 d2e1a72fcca58-8c87bacc478mr8849659b3a.9.1795440236992; 
 Mon, 23 Nov 2026 05:23:56 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f83dsm5588710b3a.39.2026.11.23.05.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:23:56 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>,
 zhuwei <zhuwei@sangfor.com.cn>, "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH v4 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
Date: Mon, 23 Nov 2026 21:23:42 +0800
Message-ID: <20261123132344.3154080-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123132344.3154080-1-zhuwei@sangfor.com.cn>
References: <20261123132344.3154080-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::7;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x07.google.com
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

Fixes: 93bb1315250d ("hmp: fix memory leak at hmp_info_block_jobs()")
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



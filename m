Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D1DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pR-0001ob-HF; Wed, 19 Jun 2024 18:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pP-0001o1-Lu
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pN-0008Ow-TK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzpRVcMoHJuiYGTTUkqQjk7ezIIqhok8HbPaC8esF3E=;
 b=HvDInXYTLWztisybI8zz5i1YEDj644Qnpu4ECPNRJOCtHjJ9iuN5AzwmBGFix4D/C2YXxH
 OOfv0UDDU3T1DSQJdmye0rNjXwWpZfM2vPI7OdzE/4alI+vLYWnLN78PNq4J8qVjdCxFK5
 vqBxkYu/sNHG6YP/tn88QfgvN7Onv0k=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-7jnWWpaeOF6p8SZ5l4fc2A-1; Wed, 19 Jun 2024 18:30:51 -0400
X-MC-Unique: 7jnWWpaeOF6p8SZ5l4fc2A-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e02b7b50986so66517276.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836250; x=1719441050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzpRVcMoHJuiYGTTUkqQjk7ezIIqhok8HbPaC8esF3E=;
 b=XkXFgIFBTQ/WDm1NqWsTAW3w20B5fGyWL4H6aalBCNWyiaRsHt0dk/Yr+lAl8Y/qvB
 TR1WcQsJ/4js+4+r00tOKAOCF3SVika92Rm0D8xmnCSp3YRmywp0IHWWmnozSCMCK5Vd
 XNPQDCIDK0QWC/sE0BCQqecRLn2xRxXlE9chn5PkoricNZi0Flfv8RrY+RcmtU0lX23U
 v8MlTqWBy2u62RVzC6afqHJG8jQdiCtYeBpsaLuofllC0nF0t0GcrBXA2M2yJVU7RirQ
 Hb9rF2KVnxXtaG5U+XAjUgu821zmv8bX0m64HkqA7NLRyorHFVb4Hq4nHQFTHJ3K16tE
 Wdxw==
X-Gm-Message-State: AOJu0YweuQ2qKSaLQj6qhSx9k0aGtDfbdQytMznbJ8iMKfjyc8eBEZ4T
 zG8j23Xl6xD1d4sqEDO9Ms6rK4l8qOZdNPdEwT5nMJYTncIro5En5s6l+Wgo6Kl/Xg43x4Bxnb+
 u/t9x5bgBDIpD2CnVwtB/aN/8JBt2vGzoJxkcLYPRg9YZ/z+yOKMzb2n/QzOAyp95IYhGK5dsZf
 IlfeJ2AtIuzWA8nC88jRTF0DBRhScf2glR1Q==
X-Received: by 2002:a25:3f43:0:b0:e02:bde3:3166 with SMTP id
 3f1490d57ef6-e02be0ff8a9mr3433840276.1.1718836250253; 
 Wed, 19 Jun 2024 15:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPmuZ2JgL8GTCtKHRrcd2UupkF1MbvDm18LmonsoRHozY3zHM9LUssJE69o3nQEdKaFC0TeA==
X-Received: by 2002:a25:3f43:0:b0:e02:bde3:3166 with SMTP id
 3f1490d57ef6-e02be0ff8a9mr3433814276.1.1718836249677; 
 Wed, 19 Jun 2024 15:30:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:30:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 01/11] migration/multifd: Avoid the final FLUSH in
 complete()
Date: Wed, 19 Jun 2024 18:30:36 -0400
Message-ID: <20240619223046.1798968-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We always do the flush when finishing one round of scan, and during
complete() phase we should scan one more round making sure no dirty page
existed.  In that case we shouldn't need one explicit FLUSH at the end of
complete(), as when reaching there all pages should have been flushed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ceea586b06..edec1a2d07 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3300,10 +3300,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
-        !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     return qemu_fflush(f);
 }
-- 
2.45.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1785DC54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaJ-0002Ez-Ch; Sun, 17 Mar 2024 16:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaG-0002DY-VH
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaE-0002bG-RP
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UIjggYcWeZ8GItTuth3oRveQdzD9M6dVWkAHyLU+XM=;
 b=d3b5z17tVdSvPHHmGRN7heLrIKSbMsygZci4WkVNoJqurA3FroGv30YAAj0lrTCBd8Ex5Q
 fe4mQFUz3jXiaw0ogACJdHOiNUePe5gJBgvgnvaindrgmG2uH7Nr9BiPw6KHFAmHHkIws7
 7mYkrNL/2M6vG324hsrEydLyyUf7P88=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-voq1F1fUNzqoZV9uFOWyqw-1; Sun, 17 Mar 2024 16:58:16 -0400
X-MC-Unique: voq1F1fUNzqoZV9uFOWyqw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430c76df729so3705261cf.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709096; x=1711313896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UIjggYcWeZ8GItTuth3oRveQdzD9M6dVWkAHyLU+XM=;
 b=K4t5wlVReupjS95hhGP4kopxM2ql8+Nee63sAZPdsOO/nk7/zoR+8gBI2cPh58Q6Qa
 IMzbCSQAL+mEHYi06A4FzYMkBl6zDQVTAjzAoLMnONSKNj9VkB5GQABUsYD9YIBSsmcb
 PMHu+wzWVKgSK+JeSbYw8ssrJdWyPjgqzLKSxQ7f06ksOIsky5N+aNqXFT6Gor1Zc8zZ
 MSlo0MXEGutLJWmNna1IUSqNWdOipcKfJw69/DiL33X0pFLBjZsiU9kTZWqcDg03wEi2
 YuBcw8NBN7vBwZIHMy66foHEjQSxEUloGJvx0tmsujFzlq6SK6EvV/PHVosZZH0wy7NW
 ndRA==
X-Gm-Message-State: AOJu0YwvhfGqvbpaBZOGxqT77A7VBwEXP+siGhR1l1tjj7yddJQHaPvJ
 zaiRoc+6xPL3PjdVKolKAcTXNAM3PWo0/9HQEkDO2XM8FB3Lq3U2yzlP3z4BmgppxUv21Dzu7Jg
 7tcg9/wilfPvUJiDBu24HqZq5nMOxRGJi6We+pP5MpmoqMgg4r56RhVPscVm7h7m9+Evz74M5PK
 eRcEj8WKGkPJqrCOn+0tUQPgxTx/uKrHxFOg==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr8883382qvb.6.1710709095852; 
 Sun, 17 Mar 2024 13:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG6717Cl6wCmud2Cm8fiETPePyBDz6w5iAjimAta3jxtXtl1MNb5bacdFVyBemJ+3R08bnQA==
X-Received: by 2002:a05:6214:2c0a:b0:691:ca1:ce8a with SMTP id
 qq10-20020a0562142c0a00b006910ca1ce8amr8883361qvb.6.1710709095312; 
 Sun, 17 Mar 2024 13:58:15 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:14 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 06/10] migration: Skip only empty block devices
Date: Sun, 17 Mar 2024 16:57:59 -0400
Message-ID: <20240317205803.361163-7-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The block .save_setup() handler calls a helper routine
init_blk_migration() which builds a list of block devices to take into
account for migration. When one device is found to be empty (sectors
== 0), the loop exits and all the remaining devices are ignored. This
is a regression introduced when bdrv_iterate() was removed.

Change that by skipping only empty devices.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Link: https://lore.kernel.org/r/20240312120431.550054-1-clg@redhat.com
[peterx: fix "Suggested-by:"]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 8c6ebafacc..2b9054889a 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -402,7 +402,10 @@ static int init_blk_migration(QEMUFile *f)
         }
 
         sectors = bdrv_nb_sectors(bs);
-        if (sectors <= 0) {
+        if (sectors == 0) {
+            continue;
+        }
+        if (sectors < 0) {
             ret = sectors;
             bdrv_next_cleanup(&it);
             goto out;
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B612BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNI1-0001TF-0o; Wed, 27 Aug 2025 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNHc-0000wR-AM
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNHV-00073c-LF
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJAr3TebO8J8PikwvNWprOvIsh2tZfg1cE20LO3lM7Y=;
 b=h2KUKO079Wa1O8FbS7mkZCfqp+GeIeEALZR9YyZ96JrMjdEeZ0VsOAt42yxtlwfonTjH/u
 MdjZ5eXFnaSWbKDxf/XzsVpbmx8h2s+L+u9y/I6cq+2xgPohWHjY3JjknDNY78k6Cfb2nW
 XCQOOSmDhwLywpuanXoICaKhssDIJkU=
Received: from mail-yx1-f72.google.com (74.125.224.72 [74.125.224.72]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-2UFGrEGRPECKYoBnm9IgFw-1; Wed,
 27 Aug 2025 16:59:56 -0400
X-MC-Unique: 2UFGrEGRPECKYoBnm9IgFw-1
X-Mimecast-MFC-AGG-ID: 2UFGrEGRPECKYoBnm9IgFw_1756328396
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-5f3562a16fbso437951d50.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328396; x=1756933196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJAr3TebO8J8PikwvNWprOvIsh2tZfg1cE20LO3lM7Y=;
 b=s98lyjl8oNZ3gMCUb5zi16iz3k7r7T7e5ijc0TfvF80EO5ypehLB1FeLKxLacZu0Bf
 CBwlp5TTybgZ8Zq22QQMBl3IO+nvO+iXs8MKNWTnuLp7xJ5/KARt7coR27btoyp2TzK4
 3XspVAL3kIdGg/mYnX3PaGwa8C1iT+M+IyjznQX5kS9Qsf52iPtzrw1G6FER+4IJ/cQE
 hoeOTEvhjqOt1sTW8h5MEf+wpDnMd+GUAYpalFLSrTVvjmakmxczQ6yZNIZAoxyDx2lh
 oeCqYc4AJi3EpR9AdT37ngY9mAkEicWmUCjzICSTUYoGmdgIfSd9p1BGdoWRueELOZXZ
 ycNA==
X-Gm-Message-State: AOJu0Yz2/cy7Pxj75KjOgi1JRnlhE6yLms2VwTG2EvW7xPL18UOyCA2R
 D9nd4ltqxqzLBJIcrA9+0Ra8mVdwNXwx8FrmroXocNHu0kq/ARQfIjiks4KPS6jdZak3qWgObWq
 U4RmfsEjydQRfPDaXwfxNv0YPpW4+4UjJTTsAsPtdJub/j/0VkG4R2ry+xj5Y5xpP2tdrH7M9Up
 BKGmkOk1Dq6/uJmFNeenOdudOkm+aUPsYxOEVjBw==
X-Gm-Gg: ASbGnctESYGDC+gCqAd0yiUWJDjhCDx8LVCPwaLm2ijZG5HrBmdSjnKUrgChjHKPa1R
 MeR4buM3eoBDD5+Lk0xhTCSZzArPkwJw5C+Xhz2gm3QQSwp/Wf1c9vbPbXlW9M8b59b5QPS50lA
 UqdVPrC+CVche3OpIH7RAN0pAORF5ERqE7NT6t855z26lH4K87dX0yEjka5HwzfFPBPpjFrTqQa
 2vD2nCFL9kp5ruDOb/B1+22tBlLPoGgY8VP0b3ibm0jRSoyAH7Ix0CMpwWcAPipnmZvkuG5SQ3A
 o75iqOTWUerU1TsRk3C3mWiy2+r27OIU4DgUbcd/uK6BJAHXa50WZKdlmH2IMaW9OlbFcaJrWwX
 9F8UkqD8hGoXDvlLiwAQ=
X-Received: by 2002:a05:6902:1145:b0:e95:3636:fec7 with SMTP id
 3f1490d57ef6-e953637041bmr14362446276.3.1756328395872; 
 Wed, 27 Aug 2025 13:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWuQxOKR+8wJOK0/TNbn7hTa6ZZbpCFF+H/RmQjalGCt0MH0LE5+RvkPGQaBYReAhzsoSjYA==
X-Received: by 2002:a05:6902:1145:b0:e95:3636:fec7 with SMTP id
 3f1490d57ef6-e953637041bmr14362396276.3.1756328395326; 
 Wed, 27 Aug 2025 13:59:55 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Lidong Chen <jemmy858585@gmail.com>
Subject: [PATCH RFC 2/9] migration/rdma: Fix wrong context in
 qio_channel_rdma_shutdown()
Date: Wed, 27 Aug 2025 16:59:41 -0400
Message-ID: <20250827205949.364606-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The rdmaout should be a cache of rioc->rdmaout, not rioc->rdmain.

Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Lidong Chen <jemmy858585@gmail.com>
Fixes: 54db882f07 ("migration: implement the shutdown for RDMA QIOChannel")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2d839fce6c..e6837184c8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2986,7 +2986,7 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     RCU_READ_LOCK_GUARD();
 
     rdmain = qatomic_rcu_read(&rioc->rdmain);
-    rdmaout = qatomic_rcu_read(&rioc->rdmain);
+    rdmaout = qatomic_rcu_read(&rioc->rdmaout);
 
     switch (how) {
     case QIO_CHANNEL_SHUTDOWN_READ:
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27591C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXP-0000cL-QG; Fri, 22 Mar 2024 12:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXL-0000bV-92
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnhXI-0000l8-4y
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711124064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9o8qzy6L7mwSEPINx1G7qpKCDuh+yBwE7mJu/Ztnqvk=;
 b=WeLXKko/accZgI42V/iziScogYh5P/PcSfEZqlN2oGhF/vIENbAK+eNdxcO5LdI9ikuTls
 GNnXghrpFX8Wwbpgqj9drFjLzE30S9aiauqkKCGDqEFpC4A/xrAm3ZieWWV5pxEoISkdRL
 8fyQouZj20cRh0yudgtaidbllukSFh0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-uiWowjy1OoWn1FpjQ5FSRA-1; Fri, 22 Mar 2024 12:14:23 -0400
X-MC-Unique: uiWowjy1OoWn1FpjQ5FSRA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-69120b349c9so5357616d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124062; x=1711728862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9o8qzy6L7mwSEPINx1G7qpKCDuh+yBwE7mJu/Ztnqvk=;
 b=mV6I3oFP2+ugjd2OLAgxRHE6I0OhTdyuWYF4iu3pGgyt+g8xlZxokl0vquEkzLs/mx
 UVNB8Vr2QqWx3xupjaAA1qntrLVYGEAft/ayg/KnbirjlwnLtmzcdNhtTq7YAlyFnzRp
 xwt59EUZSZcxq21YaNYr7ESrGuh+YcCYCtCLMFhe8hDmiAGQ2jnQ7qWySLHe9DSCIdzP
 82Oj2vlaFWo2nazeE9MXip/xrOOhqOK8nJxyhaQLeXCOODISD5eBwwMgdGcQi0knYkLA
 Z843c913JRcPUi8o3YYTlDPE4rlsxt0N69tNzVOPnRkXhDbTmJj/jgYH9e8zequN7Nh0
 mv0Q==
X-Gm-Message-State: AOJu0YxMXypJKTFzUogWPlYZHULH4ZEtelwTLx9LgYFknSneeNAYdR3T
 HinTSAW4mPYj00SuFu+rR+3xsWS5dHo9hBVgdoq1XFprZuWIaxnmyZ9hr3kqrcffQ7Jd9tLecDb
 9+UTbN7wmTMiqZH75wuxCsNyRvgADGEQvore7V+DX7q3YiV87uS2JOncGK/kYUzHU2B/HCdjrLj
 S5n5anLnmMUV0cC4LvnAmXD2ZXVOVHBQuVhw==
X-Received: by 2002:a05:6214:5991:b0:690:cdd5:ea47 with SMTP id
 qp17-20020a056214599100b00690cdd5ea47mr2611173qvb.4.1711124062143; 
 Fri, 22 Mar 2024 09:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAQsVQqHWuYmOH382S3+7bJqvTSCyBm0+br+Avs+Coz2F4enGf4SOn0x7zlc0x2UzEbvVqsw==
X-Received: by 2002:a05:6214:5991:b0:690:cdd5:ea47 with SMTP id
 qp17-20020a056214599100b00690cdd5ea47mr2611143qvb.4.1711124061591; 
 Fri, 22 Mar 2024 09:14:21 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05621420e600b006904c34d5basm1202708qvk.64.2024.03.22.09.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 09:14:21 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PULL 3/3] migration/multifd: Fix clearing of mapped-ram zero pages
Date: Fri, 22 Mar 2024 12:14:17 -0400
Message-ID: <20240322161417.759586-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322161417.759586-1-peterx@redhat.com>
References: <20240322161417.759586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

When the zero page detection is done in the multifd threads, we need
to iterate the second part of the pages->offset array and clear the
file bitmap for each zero page. The piece of code we merged to do that
is wrong.

The reason this has passed all the tests is because the bitmap is
initialized with zeroes already, so clearing the bits only really has
an effect during live migration and when a data page goes from having
data to no data.

Fixes: 303e6f54f9 ("migration/multifd: Implement zero page transmission on the multifd thread.")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240321201242.6009-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index d2f0238f70..2802afe79d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -111,7 +111,6 @@ void multifd_send_channel_created(void)
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
-    uint32_t zero_num = p->pages->num - p->pages->normal_num;
 
     assert(pages->block);
 
@@ -119,7 +118,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
 
-    for (int i = p->pages->num; i < zero_num; i++) {
+    for (int i = p->pages->normal_num; i < p->pages->num; i++) {
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
     }
 }
-- 
2.44.0



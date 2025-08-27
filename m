Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14E9CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFy-0006rx-R5; Wed, 27 Aug 2025 17:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFd-0006iw-Da
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFX-0006fI-G5
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgqJPN7aMT2upZfDjHff1MVnZ1qbYFY8iDyxM8FtLrk=;
 b=fFQ97OlF865J7pr9tEGHl/J78mmwCL/tghQJYgGxsRLszYutK/yTzyShiD3ISMfNtsV0Q4
 xK7sy4n7SDtBgynE/LALdgrdL9W81rePgT7YnaGVk/2AGYXa9sg5sCYta5mJru69w1IO2u
 13d6sn26oLPuHVT8WD3oA94YIQIaxQs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-nnNDcbpJMj21VLrImjL7qQ-1; Wed, 27 Aug 2025 16:59:58 -0400
X-MC-Unique: nnNDcbpJMj21VLrImjL7qQ-1
X-Mimecast-MFC-AGG-ID: nnNDcbpJMj21VLrImjL7qQ_1756328398
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e96dc0032cfso287171276.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328397; x=1756933197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgqJPN7aMT2upZfDjHff1MVnZ1qbYFY8iDyxM8FtLrk=;
 b=YvuHlCOWOy+4M7ocsAo0Hnqid601isQeM+2hH3nBFh7FkrVwXm5yZ2lhI53ZuEvBW4
 Al6RDJ/xjkfuOviUBxedwITvgadNbtlKorxWXbIJ+l74eu34D5vE/3NPuHada6I/lYS8
 U0VCZXp5vHqFVVHYSUDYKX1QZwSGRBEv4/ts0WGtIqxaSHqqaxOL4vgDAPHf5NLlXCn1
 gXA9daeZVev/gaf/jSiXsZZstM3GOcNrEne5Ei3GTc5YPJXdVe7LFWz1f85xWPGh+DYS
 I7wXrP3WogPsM1monLg7qwVxz3YDm9cSnMb76JYs/PJ/pBOyQlTzb0s2CPnEzeWZc5tS
 U/FQ==
X-Gm-Message-State: AOJu0Yxz3dl6+WA9u76wtM+/O6CTXVaqJYHzn/1D81mCjJYtY8W6oLW5
 Twq86J/kkXT8g2XhsCe+DEcrpHnqOg0M/TkrH7p7PRb+K8jBI1LaajhPZYgicRZ5bA1xkWRu/Qb
 t+ps/VwiyF20VJ93sYPfQvAbTIfVOrqSbQWAJw68JBzadharn0W0zEAhSrRs1Bd9wAHIZSEw9Ml
 QBrqQ2TUhNKL06UxqVF31PH7EB9jQ5V0JMe6JuIA==
X-Gm-Gg: ASbGncvZAg787DiPw692KVAJUcUam31bRWq9A1dd3seHkux3uDhS6yFj6ZdfC4DtHZL
 9hWFzufuCOnE6yj+CGBv+/pVFmgHkluWqUlACcOxfElyX1xzm83j1WxPNu44hcWozbnia7DqqgA
 5R+wOLGIjrv/hLpSss3gK0nX4AJ6MIYbYTm9RSZbAeYSxITWv/cZRSjGh9G/u86TLonJhNCuB7O
 lyXM/xupdH9aOJ6NLhmMVluKMRRN3PgwAxYqOOFkrdtiAYGZ5HF+xHoHAEIA6+H+BPsXWYobdwM
 LELZHKSY+V2Zb4BjFKGmIJu653LjobPR1g0sByfxd2xWCBgJNYepzt+NO1qchDpfI6J5oxh9nca
 nCY54VJ9Qa8/OEpL2xWE=
X-Received: by 2002:a05:6902:c04:b0:e96:e4ad:6b2b with SMTP id
 3f1490d57ef6-e96e4ad9cadmr7536444276.48.1756328397474; 
 Wed, 27 Aug 2025 13:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAr5CipU6Ky6rmqgAJt5iinXKwsMuOhPMhYGFj7Cf2kJ2Rz/3H5ko4FTMYm8S+KpzZV6e39g==
X-Received: by 2002:a05:6902:c04:b0:e96:e4ad:6b2b with SMTP id
 3f1490d57ef6-e96e4ad9cadmr7536390276.48.1756328396987; 
 Wed, 27 Aug 2025 13:59:56 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:56 -0700 (PDT)
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
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 3/9] migration/rdma: Allow qemu_rdma_wait_comp_channel
 work with thread
Date: Wed, 27 Aug 2025 16:59:42 -0400
Message-ID: <20250827205949.364606-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's almost there, except that currently it relies on a global flag showing
that it's in incoming migration.

Change it to detect coroutine instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e6837184c8..ed4e20b988 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1357,7 +1357,8 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
      * so don't yield unless we know we're running inside of a coroutine.
      */
     if (rdma->migration_started_on_destination &&
-        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
+        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE &&
+        qemu_in_coroutine()) {
         yield_until_fd_readable(comp_channel->fd);
     } else {
         /* This is the source side, we're in a separate thread
-- 
2.50.1



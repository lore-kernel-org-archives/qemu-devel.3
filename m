Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A513AC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mZa-000421-JZ; Thu, 10 Sep 2026 17:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLK-0002tK-Uy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLC-0000bR-DB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=LZgkFQCSAiNYqTNZaGZVR9FfsQ6bTfa6unY65DTJS9rvpREVwh6fuc3HQMxZAnqzPzMgLp
 8W1US8CHICH7gFNZBe3KWV7m2SQsZGDZYOgcIHUPvmN9R1jQibzB6crkVTztAigEIuZNUc
 8AfbNu0WkneKfY6ng9uTIO16Ty9u1kY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-xlzQ-l6NO5as3QDCYvy9LA-1; Thu, 10 Sep 2026 16:12:40 -0400
X-MC-Unique: xlzQ-l6NO5as3QDCYvy9LA-1
X-Mimecast-MFC-AGG-ID: xlzQ-l6NO5as3QDCYvy9LA_1789071159
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so1654275e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071159; x=1789675959; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=Q7EcygWAzG7zAc6+yWoeSyyd01u9ayunTBboNj1mI7JO87YTiTgzmYchgh5dOxR+eW
 ufFh0ZNCxJDqbYgWXjCbc8rmhTvYuyjv/Z0pqxwk90Wu/dM7csCIfZGI8dz0P2atj7/i
 Rir1vdS5erzSxf1wOvo+Vhyjm/icPosW6Zk0x/RIBPGszjzzkEVPNyYH+vojagQUcCac
 KdbYqO8fCt8yAkSEZtypA8d/dcqZQgMrZo5FnIlgjgPd0z24ob2THHoKW086PTjObj59
 cMOL8iJk5I1Icj7lThgnMX11w66okXmPsBua+0qU1CfYRmFoQHAWh7mH3aQ1oi49Pxfx
 GlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071159; x=1789675959;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=beU7FjgyA0BsZQfNfNmJBUW0kDGthpqeSLUuh7lD0jw=;
 b=AHgVsszplaNWewfZw7XotTJ9bvknxG3LnMh1wn+qf8vJ1Oz6G1mavWOmycUSLQzezG
 dMmoDrrihtXJhP26A2z8Gbx+C4ag6fBMq8OM/nPSv1CHB3sKuzRV2bY1XQYu6lRTIMnn
 YI5xiSXquWyXlLpQHZb8vMT0hpgvBX8MK6BKvKM4z4z/coKsdNuaTz9wJsCfHfJ01qw0
 cfChE5GrgGgaSkuoQuzu5U4tsXrcOc7bu03e1VjNwKH+YGlbdRsPC1EWDKEYL0qIHoH3
 ecZrQsfyFN3eYJf5ImEKFuJmGZNT6ZW4Y8qyZ41MejKFm3T6DPgvRSaqWgCfumrKGgsR
 WLrw==
X-Gm-Message-State: AFuF++l2r++ho+Ak8zbbQPjakz/woo0qOqsUQAA//sNj7BBlC5z313EI
 Z1W2DkmiPnlO2xtZS4TysbrXILzskEnmH8eAi5gVVuxDsCyY7O1kgjOjMVCmZn7d0MH6PaEez3O
 aRTeX/IcAWH6ly6zDeB/xTCjE12uv+kxsna2U1Gl6ZKEX2RIkqhjezfihs1IXzCUgIwKaGj8PrK
 7NGZ5IQhJLMWRvGvQY/uNA2phEM0frrSLCMA==
X-Gm-Gg: AYBFou2yeerQ+CVmcTxPxammlcySlupNN+i4mylQlGosNeocdXGyzPP1sFr+upcr07h
 j5Fyw7rFIo+FfrJ8ytTTo1DPxr1h8bjJ9wWr1XBbwpxxDDCB/vmW1TkrHeaQFJcnROc4AkxgNnQ
 CsZ14fifCDRkN3HBvhTJE3Yz7pCnEppmInDmsI6fcMXC6NIYh5gLLeDEPtq3WN7cszakM3C/8I1
 1OAZDzbRa4pAArd1IQO2xzIFDhCJOghGJWWj7RWDWspygBe3KJlQTCvWZMTRpWNQ+rpFmL4kpoS
 Sjb1sFDw1W0X8zq6TPHjUQpbdJUYFU3EVbIg8qjjdS4oxBQI7kiwYUSDoCS9I9oEMgMWZbVOVdW
 10MfOXlnWqLuQZpDonNGwdss=
X-Received: by 2002:a05:600c:8a1b:20b0:49d:17d8:abec with SMTP id
 5b1f17b1804b1-49e619c1912mr5591815e9.21.1789071159353; 
 Thu, 10 Sep 2026 13:12:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8a1b:20b0:49d:17d8:abec with SMTP id
 5b1f17b1804b1-49e619c1912mr5591515e9.21.1789071158796; 
 Thu, 10 Sep 2026 13:12:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60abab54sm18710765e9.5.2026.09.10.13.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:36 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 29/90] migration/fd: add errp parameter to migration_fd_valid()
Message-ID: <023a51dfc227a6d59eb99ab972726d4137505abd.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Let migration_fd_valid() report the error itself, instead of
duplicating the error message in both callers. This also prepares
for adding one more check (with a different error message) to the
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-12-vsementsov@yandex-team.ru>
---
 migration/fd.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 02b39b150e..78a27caca2 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -37,16 +37,14 @@ static bool fd_is_pipe(int fd)
     return S_ISFIFO(statbuf.st_mode);
 }
 
-static bool migration_fd_valid(int fd)
+static bool migration_fd_valid(int fd, Error **errp)
 {
-    if (fd_is_socket(fd)) {
-        return true;
-    }
-
-    if (fd_is_pipe(fd)) {
+    if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
 
+    error_setg(errp, "fd: migration to a file is not supported."
+               " Use file: instead.");
     return false;
 }
 
@@ -59,9 +57,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
         goto out;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         goto out;
     }
@@ -95,9 +91,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
         return;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         return;
     }
-- 
MST



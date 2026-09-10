Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A15FC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4n57-0003Sr-PW; Thu, 10 Sep 2026 18:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWk-0006am-3x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWQ-0004kk-1I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=X/HtS/AQyyzJwtVRAtRTcvfrDIjIvGYtuKrmKIz4JfheJ1IldBRBhTVWRklUvprI677j6R
 C9QFtLNllfyRMkcKOcQWrkNP4/HCRZXAg99XiriuQ9AQ79uCiE7/KQqwFslXoRlbJhcATB
 10LFAuYWZSEqVYNSJQyNooZYsPHOijo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-jZp30QDMMTSHE0lQG60yrw-1; Thu, 10 Sep 2026 16:12:45 -0400
X-MC-Unique: jZp30QDMMTSHE0lQG60yrw-1
X-Mimecast-MFC-AGG-ID: jZp30QDMMTSHE0lQG60yrw_1789071164
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499913d1a79so1355315e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071164; x=1789675964; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=Dkkx06a70myCN1odLpX5mlyDmel2m0nmOqJqsLyvcNs/NHZcSXJ9GM9VLrSxGA5E/k
 KmlOo4kpVeZlziEYp4+bw9ed9rRN/il9qKX4y+Phpi31DA1Ct04usDhGcB2R1RL7AzEu
 w1dg5SrvYy8hu7Lapg2yNn8qUHfKJEyrzUz97/BtWd+MgYzut57Q5GlnPcm+2JOM7Nn+
 /sSjAAmjWfceCU+LrgShtqJL3bRwdw5e70A2RoChSKSNaiSKw0G8QMQBCXe8n0iw+5Gs
 p+CbRBB8qRgWOIIOuwQVuazZ5yliDJFc6tOTRzmePcaG+Lq3d+YJh1HbC0hZx+Kbkbwz
 SB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071164; x=1789675964;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=VKz01MU4koeRixndeeA08su6MiBJKRQ6vI+/U/G6PLXch6gwem6LGjRS/suZSjgzoV
 wz58+z+ysOTcKhHSNwnFrn1f2lnyRclFv3yEOkZ7kK6r96Xz36Lb1Z83MW7i/id7oArO
 foAjplso+GOoKJ9rpht5bEReAhmtxciGZ6V8EC/HkCphAfkT7eKguio1z8VXnhD1nM1J
 J868a4t38wLTbDXN55YgY8G2lqqp5wj/ZxBmR/3X0ifFWklR47Ov2GkKACKUinAohEjn
 N8Q659NDqsmUDnJwzL2KxHdZf74xOcOtvVIyy63gqusbM7V3dNrUZjGsPafYEqaFb/+F
 KSNA==
X-Gm-Message-State: AFuF++lSTYlC3PQbwAPWzTdzL4pPW+/SORehJPE89963Uuajj+mMpNH2
 /JyRboyv1Tm/+E23IvGMNC9qY9ODMfWMHmNY5Wg8/eBFSDlSEjMW/pRJCpdSImAU6qYuPn8BnNw
 Pnu7fegvGevQ9sm8fbExh/V1k7zgGLYPZcnQQTdZW8hHS1kmnE1a96+Xswi26DD+Dg4LPwBHVl9
 yx+SWgmEgUkSy6VQYmAwyZngaBNqyEvFwNag==
X-Gm-Gg: AYBFou2y6iJq3KU7M936RwBQ5bABeMNThoZDQH9cWAucinWRtbiFTKqleYMOqm1B1fk
 AcKdnqd2qQtvbvvQmsuxI2aGpAmd2h/STcrh+78g1W7PSOYp/tMV/Bx48US9uFv/OOmfOfsWTSZ
 PXj+gOilRJRAwwl+PZgyV4h/lTmrJBFH/o+gsfWomGFszQT8XxZJs7AdapJp0dSVQ06AP0vsm8c
 ysQyZO/mZQUAKM94WT4J4biNNxQ8hP7ZBt89Q3m8vAbUkz9wy7LgDYK9sbRTCG5XoMMIeylQpsY
 7KGBxQmHJiLh7uJckG9cCZXLpXmHaN2k9NI5mn6pm+ySGUnsE2Dz8lFwZfm99dx/Xeq1rYy1glx
 XbvjIX2JFB3TJKoUEKnjgqPc=
X-Received: by 2002:a05:600c:6289:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49e619a0973mr11354635e9.8.1789071164002; 
 Thu, 10 Sep 2026 13:12:44 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49e619a0973mr11353955e9.8.1789071163419; 
 Thu, 10 Sep 2026 13:12:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a803c5sm5170365e9.1.2026.09.10.13.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:40 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 30/90] migration: check that transfer is UNIX socket when
 "local" set
Message-ID: <b05948038e1116419ec2fdcdb4dd2336fdacc5d3.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As documented, for "local", the migration channel must be direct UNIX
socket connection from source to target (except for CPR_EXEC mode). We
can't check for it being "direct", but let's at least check that we deal
with UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-13-vsementsov@yandex-team.ru>
---
 migration/fd.c        | 14 ++++++++++++++
 migration/migration.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/migration/fd.c b/migration/fd.c
index 78a27caca2..4a891e814a 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,6 +39,20 @@ static bool fd_is_pipe(int fd)
 
 static bool migration_fd_valid(int fd, Error **errp)
 {
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC) {
+        struct sockaddr_storage ss;
+        socklen_t sslen = sizeof(ss);
+
+        if (getsockname(fd, (struct sockaddr *)&ss, &sslen) < 0 ||
+            ss.ss_family != AF_UNIX) {
+            error_setg(errp,
+                       "local migration requires a UNIX domain socket channel");
+            return false;
+        }
+
+        return true;
+    }
+
     if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
diff --git a/migration/migration.c b/migration/migration.c
index b413d28622..d8418e4582 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -260,6 +260,19 @@ migration_capabilities_and_transport_compatible(MigrationAddress *addr,
                                        errp);
     }
 
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
+        (addr->transport != MIGRATION_ADDRESS_TYPE_SOCKET ||
+         (addr->u.socket.type != SOCKET_ADDRESS_TYPE_UNIX &&
+          addr->u.socket.type != SOCKET_ADDRESS_TYPE_FD))) {
+        /*
+         * For SOCKET_ADDRESS_TYPE_FD we do check the fd itself later
+         * in migration_fd_valid().
+         */
+        error_setg(errp,
+                   "local migration requires a UNIX domain socket channel");
+        return false;
+    }
+
     return true;
 }
 
-- 
MST



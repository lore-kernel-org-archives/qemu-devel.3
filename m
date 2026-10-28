Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6NzdCtL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tbqIs5gV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Et-0005LR-37; Wed, 28 Oct 2026 13:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EG-0004t4-F3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EE-0003SF-9V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scERlBQRLOvtNtDPbyp49V+fJ8lLZEU18q0HUngLu2s=;
 b=J6NzdCtLxNOlZ4GUPT3KUB0OYMn6jgn8qJAelQJ+Zmjltu7+l9RPf14GQ2wK+a8CNSS8Dt
 2SJJiSXHrUB447b9QO5reTlvx21dQjZuphqLKcEXAF5zhuafYJyO6tMmok3fCWWsreOIcp
 CJdlQhCmw3SdcXYjDToFuniGHhDQ/pE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-gycBN5asNwWyJpigKHdyBQ-1; Wed, 28 Oct 2026 13:14:18 -0400
X-MC-Unique: gycBN5asNwWyJpigKHdyBQ-1
X-Mimecast-MFC-AGG-ID: gycBN5asNwWyJpigKHdyBQ_1793207657
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso8909425e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207657; x=1793812457; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=scERlBQRLOvtNtDPbyp49V+fJ8lLZEU18q0HUngLu2s=;
 b=tbqIs5gVLoyehoQZj/dbCyMNUVAFcpA8ikyb0+rW724R99juQM2MIw/OyWOtF+AZN+
 3Q9Wjv8BrGjcVB1uBDAC9QLjaWW19OvDp33QmvFdDQn9rFZ810NtjjJDYltxzqD9H1JP
 VCzu9lUqSavoO25zFe5jufxXgN2bH/rptn2TTaX1uxNjaq3V1WcVjTd2PBapic6TVyB6
 EAY2bl2ozAuQcJzXnDcslpGe7/muRGXXa8ogzinv7MXtYVTJBxdfrnlw86ZEH9pj9iRd
 3YKsCmsWLGTpYsNElODQf2hhpLHlv3QVEjaQMQEXQOGtYQTMc5WBQbJ/kTzeHcpWgOV8
 kT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207657; x=1793812457;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=scERlBQRLOvtNtDPbyp49V+fJ8lLZEU18q0HUngLu2s=;
 b=Rt2NelpijoDAUM9UTLB7Lszd5/SVfNKKBJIjsyYR+aSdpyrcCTwUai+jFFNTtl+2WA
 iV0qNxXRzGNfx/TO1nqL7iTEKvYSxx10X5Lt1JeuPZ+b7I/UV/I88OwpMd4poBuJC0+y
 rqBRHTvxtPfm/egFpUgqYJ8mMD4mce5hjsv1IsyPsekDYhV7wGnc98Rd/zhxYL8JCQbh
 oqdlviS6ddeJx8qmWPbHgpca+FFoHUWTX5bgADMU21GP8CsMVIk8Aqp6IdLax/ttUtRP
 y5koIQ8hBF9wb2fzzRLyydNsVBAhRBMEGaF/GMRZrRGFbA9HrOLTOfANRU2fZauZkjyO
 elTg==
X-Gm-Message-State: AFq9FYI5BdhxPzcGcCGsZlIKzfHHL0+mdFIzd3iYx0wZlUwOI55/Rkru
 Pds0REfoPCpFbgfryKN8yZ5KdWfs9vIh5LHnrN7PjehaSSopZ5G9QrKnqw98Is96nE+BqaJ9/gP
 20eHwgJC7PmZvtGiq13gutesnFXtXUtWRFcEwnnl87zljSUxP0SvRS2PKjea0p5VA3fJoov4/cF
 YFble9BFVs+Xm+rWj1HomWK0QJnxix+tr0XQ==
X-Gm-Gg: AYBFou2p7O/SdzBTSX8P4zB4d8htMMO/hZ1y6eYa+ojhXKB94UwZYcbMhroag7qoIu7
 gBUHSG/p7QWF6bx8Q8YI7fY012r+XRvlcJ/bGjx5gsNKXeO/R/dK32gSPZL2Z84zDn/FJmTSRM3
 ZtaqX0SPkVDhAdyyVvEjf+1AwEy9lD77BQRVayIlDmVwAJYz9O3MHmtospfFTzHF2lW6BbHH+AL
 lcVJ1RESezvzqQds1kMySF2oAzQDOVr1+h6X3rnQLLD28HoX5UTD5mYVa02zi7bAl9c+8LNmQMv
 44CWdYP239sFV658N3u4Q5XqkF526iyZhearqHqboloeC0eHaI8o29v0Pt75RzUdAFdEvDhRwl+
 Lh7S/OJpl5JJ+c4nVQlS+DVEe/hHU8fJtqwFfkQ0q
X-Received: by 2002:a05:600c:699b:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4a9677ca40bmr86491245e9.19.1793207657073; 
 Wed, 28 Oct 2026 10:14:17 -0700 (PDT)
X-Received: by 2002:a05:600c:699b:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4a9677ca40bmr86489995e9.19.1793207656369; 
 Wed, 28 Oct 2026 10:14:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm5019015e9.3.2026.10.28.10.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:15 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 08/78] net/tap: net_init_tap_one(): fix failure path
Message-ID: <c7dbedd5a02bb667f9f143a32097ec77e9051aa8.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We should "goto failed" here, to delete net client, same
as for previous failure path in the function.

Fixes: 69036a855492 ("net/tap: move vhost initialization to tap_setup_vhost()")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260914175351.393680-6-vsementsov@yandex-team.ru>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 9f829f49c1..acccabca56 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -996,7 +996,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     s->vhostfd = vhostfd;
     s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
     if (!tap_setup_vhost(s, errp)) {
-        return false;
+        goto failed;
     }
 
     return true;
-- 
MST



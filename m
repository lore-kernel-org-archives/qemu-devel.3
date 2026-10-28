Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB234606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bw2oFUDc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=syJQODnB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Ev-0005Pl-DS; Wed, 28 Oct 2026 13:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7ER-0004xx-UT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EQ-0003Tl-BE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2mQ0z1PLdIp05u+scVwbljXVY5+1F2WL94gH9senLY=;
 b=Bw2oFUDczW2eQoaPtKiGtqfWMZFGMgc2C7iU3rgnu+tFhPHhPtA+D/7p3AT04m3ss5qyxV
 rD4RuaXdgXrbdPwHVqfJ0XPTrleB2d/k056w+AEeGakwgbrtN3BYIEpXPMmQTJNz/ZyviQ
 ePgrlt/u0K5eHLeraXBTqPK1sDMTi3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-yJxuFYbWOtyHninNdI-UWg-1; Wed, 28 Oct 2026 13:14:32 -0400
X-MC-Unique: yJxuFYbWOtyHninNdI-UWg-1
X-Mimecast-MFC-AGG-ID: yJxuFYbWOtyHninNdI-UWg_1793207671
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1e489f97fso12309825e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207671; x=1793812471; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c2mQ0z1PLdIp05u+scVwbljXVY5+1F2WL94gH9senLY=;
 b=syJQODnBmYxSJMSROKpYcXFVy7lb5qOHnegnuGadtxKftKmxhwBgKaRD3MGRh4GcAt
 W8AYwhlL1tZp7s9RrIrG5YKFmHMdj+b1kT46USciwtFVL4I6UmhJ0JbbMSrLDpta5HAX
 Wtg/RFKpqPJZ16TBLx9kNBzKxgQ9Hq2BD6CR5zZ38yKjzHPb329wJJg6cNnkSaiQWD7v
 nXG7dNiMX+qoXzoWEx+S1eFWIRgmig97MWTworf0rOXmnkVSDwsJLAC0OJoXikaIwXAm
 DOPSXVcnBUKjhVNltNpovta00oF15adnyTqDwpNookHPfr3Gg2YMKhqbN7T/Tu8ADie8
 ECUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207671; x=1793812471;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c2mQ0z1PLdIp05u+scVwbljXVY5+1F2WL94gH9senLY=;
 b=cnCJEqwQ9lT1acJFegWXS3WhHiO3y7eUlmJVGh11RLzyFO+AsZD8qQpf3fPb5/BjmU
 kbk4ujfDaJDXnu0ougjFgm/bWYeT67P0le7Ve759qNufGP/ycgePiIxK3Z+SheLeBVBB
 MhPuuWwGKcQnlYsvS+6AUlHeQeDn2v6jPZCQvWCKq9NcNHyim8X5MWPvrXsu3iBz4OGr
 omT8I8HQahXXkNdVjqENKSvetrp1b85qfRyGOJjYSwscNxG49bjQALjmaY64hSAsaIQN
 HdLcU/BNRItsGfRWHTKNmPZxSaVhCuIbUHgmYrFrEHAmps7u82K00ze/YTAxnHB/Kbp0
 Jgiw==
X-Gm-Message-State: AFq9FYId5fS8Mp0EddVx8LRUaAeo7bvSs+DQi0TkIBXyyHKs5ThigHBU
 0UXejhQvDDaF1juqG+Epw0n4ki8EMYF6jJtUCQi97/oPju/Rol+6Nj8p1n0n1FarhXAZUYxx5q7
 usDsjRK2qfo/Ign2L/UYyFLolV+Mcvu9bT3JEmdF+/M7//YgJYNu0+cntDF9O92FgJaQdkx2z4u
 Huj5s8athJlcsPV7Lay1CB97plEE3yf0/DCg==
X-Gm-Gg: AYBFou0epXwLyoMku/Bn5NqKnVJhnMLkBJhkKU5un+RsJtZvj7GEG/tQZ2B46IjIZkN
 pzOH4BXOPGJL2PiiJ/Q8BjzfBdFHgEtaq4NoEpAHxJNMIojqUjm7Ri4vWc9Z8X3mvNSsrn2gGZk
 9NCPsggwNi2F+UTr+PKfMi5W+NJTNARgE4nXagTRIf0sZ/kq54K6fDMJjV8tRwwBelaNEWjwZvu
 Ll445ZeyG36ufRtkhIyV87HCVCIRxnpikZNsQmwZAglqIuM8JyTL18UVznN6RFUiR9/fwTiufXO
 CXdQWGsj1aLbWZzj+YV/u1Ob4P3Mzojv8iQxA8gUBRvk7uqow0Fu2psMbn4RAjDJg/wWX5CcO34
 GElzUFyRKMJbZwsju2E6mzxB4xDsIANhkOARd1GVr
X-Received: by 2002:a05:600c:4592:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4a966f209efmr67974445e9.21.1793207670805; 
 Wed, 28 Oct 2026 10:14:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4a966f209efmr67973275e9.21.1793207670032; 
 Wed, 28 Oct 2026 10:14:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa820492cesm5457745e9.13.2026.10.28.10.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:29 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 13/78] migration: forbid snapshots under Xen
Message-ID: <416567d0efd86e52e1e959905721b6a14706fe9d.1793207602.git.mst@redhat.com>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-4-36c38bd15ffc@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114..0b7f393492 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));
-- 
MST



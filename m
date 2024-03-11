Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngG-0000AG-0R; Mon, 11 Mar 2024 17:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngE-00009q-Kn
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngB-0003xS-UX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw41KY+8uC9noF71Dt+JCbXCA+1c3J79mVTzi6ld/Go=;
 b=CJyPON0hZCSgAmRV7F8B2Andq4uIizRkRY83HEa96TUOJlztCKO1eb9QUSXzJrtvHZnYq+
 fZocGElDoIMyMit12Xvu2iB3oGzU9QnNipNaPSpvgbuzB/9PVzjkO59/KBM+shCi+r9T4d
 8lS6f0yC0d2hOWmUL+xbfB9ctKq0QFo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-XnCpQiNFNgeJGX9n1SoPJg-1; Mon, 11 Mar 2024 17:59:30 -0400
X-MC-Unique: XnCpQiNFNgeJGX9n1SoPJg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42f30752eb4so14718431cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194369; x=1710799169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jw41KY+8uC9noF71Dt+JCbXCA+1c3J79mVTzi6ld/Go=;
 b=ZlkbBvQvBJp7rjP8fJhe5Y0i5Pg9LMpbJv8YEus3363XgoCQDjq7AIZBWnyNAubaDc
 jhvmswv7RgMnT4346NdV5L/nwnZqj5Obal6uj5np8pIExq9He7xoYDIjwFJxKXKpfObp
 EC2BHZgAoYuHMiueBRlZOIqr+1tv62EEfZVWEI+akoggsBF9awOA4+VZWaZR4HKSbA2f
 bFHt84jIWgw+fqjTv7MbfHvu5FUHcLTd/SqSey2VpspWqSg/yhYbP0mDf8s/2IbesW3U
 Nj8Dp1b744hTlpUAfWjG1JU1fXQfW8jq/xVGgZDiLajIM/4AHBTwI8StVwRX5GDZiGYo
 FPwQ==
X-Gm-Message-State: AOJu0YyS7E6cDVunPEEVj+53EEeAwSF0kHPNW5zMAkyNFpk3OtFv8lpu
 npYsBgvpGocV6oChfc2gruD44ugbuvw0ckER51n1tq0pdwQwGGLJsinpgk/Y0wtt0CgWVaj7J24
 WqVbCxzIAS2xP/ofSgUI682/yThvRdcoOxDqZeKvklrSzmNdMkfh8BO7Ji+q1XHUOKX7JMBhqUe
 i72lPohgYrAK1dowqh5epvBJs79dQ/+UwwUQ==
X-Received: by 2002:a05:622a:1aa6:b0:42e:f7aa:834f with SMTP id
 s38-20020a05622a1aa600b0042ef7aa834fmr9939863qtc.0.1710194369278; 
 Mon, 11 Mar 2024 14:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFck49NC9NEODTXKIL/BjC6AljEr9ux2q/N4yBgMcaansN8+EXXhmxyU28U6E4f87DDuvogeQ==
X-Received: by 2002:a05:622a:1aa6:b0:42e:f7aa:834f with SMTP id
 s38-20020a05622a1aa600b0042ef7aa834fmr9939842qtc.0.1710194368788; 
 Mon, 11 Mar 2024 14:59:28 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:28 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 01/34] migration: Don't serialize devices in
 qemu_savevm_state_iterate()
Date: Mon, 11 Mar 2024 17:58:52 -0400
Message-ID: <20240311215925.40618-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

From: Avihai Horon <avihaih@nvidia.com>

Commit 90697be8896c ("live migration: Serialize vmstate saving in stage
2") introduced device serialization in qemu_savevm_state_iterate(). The
rationale behind it was to first complete migration of slower changing
block devices and only then migrate the RAM, to avoid sending fast
changing RAM pages over and over.

This commit was added a long time ago, and while it was useful back
then, it is not the case anymore:
1. Block migration is deprecated, see commit 66db46ca83b8 ("migration:
   Deprecate block migration").
2. Today there are other iterative devices besides RAM and block, such
   as VFIO, which are registered for migration after RAM. With current
   serialization behavior, a fast changing device can block other
   devices from sending their data, which may prevent migration from
   converging in some cases.

The issue described in item 2 was observed in several VFIO migration
scenarios with switchover-ack capability enabled, where some workload on
the VM prevented RAM from ever reaching a hard zero, thus blocking VFIO
initial pre-copy data from being sent. Hence, destination could not ack
switchover and migration could not converge.

Fix that by not serializing iterative devices in
qemu_savevm_state_iterate().

Note that this still doesn't fully prevent device starvation. As
correctly pointed out by Peter [1], a fast changing device might
constantly consume all allocated bandwidth and block the following
devices. However, this scenario is more likely to happen only if
max-bandwidth is low.

[1] https://lore.kernel.org/qemu-devel/Zd6iw9dBhW6wKNxx@x1n/

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240304105339.20713-2-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index dc1fb9c0d3..e84b26e1c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1390,7 +1390,8 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 {
     SaveStateEntry *se;
-    int ret = 1;
+    bool all_finished = true;
+    int ret;
 
     trace_savevm_state_iterate();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1431,16 +1432,12 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
                          "%d(%s): %d",
                          se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
-        }
-        if (ret <= 0) {
-            /* Do not proceed to the next vmstate before this one reported
-               completion of the current stage. This serializes the migration
-               and reduces the probability that a faster changing state is
-               synchronized over and over again. */
-            break;
+            return ret;
+        } else if (!ret) {
+            all_finished = false;
         }
     }
-    return ret;
+    return all_finished;
 }
 
 static bool should_send_vmdesc(void)
-- 
2.44.0



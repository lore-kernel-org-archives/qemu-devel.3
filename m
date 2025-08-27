Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC80CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNIW-0002ms-IK; Wed, 27 Aug 2025 17:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNIT-0002Qi-J6
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNIR-00079N-RL
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4BC263GXH0zaGK8Pbl+OQ+YsY3HK/MeO9mZ0YwB/IA=;
 b=APXf5tvAlo9tUqbAh01xeJZFoRHxlbwABS5jDILwc8eqId2JnFujwKGdrMGoDKiwD5hyAx
 NFhIDwyvnA+tdoL3eIxNJP1p3HxI3CuWN1uhOHvTOz1asq1j92GrSE+i2OXsVDHIkAW6th
 HIk9yfK4V6LXG9ibmwIHbpdDklHmVXU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-b_PqM8UaPI-aa0wsOcnoqA-1; Wed, 27 Aug 2025 16:59:54 -0400
X-MC-Unique: b_PqM8UaPI-aa0wsOcnoqA-1
X-Mimecast-MFC-AGG-ID: b_PqM8UaPI-aa0wsOcnoqA_1756328394
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e950984545fso286913276.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328394; x=1756933194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4BC263GXH0zaGK8Pbl+OQ+YsY3HK/MeO9mZ0YwB/IA=;
 b=fvdMxYl/+YhJmiRcPa/Xn800KiFxwbwf3ATc6q1JNsDjwOg6WSDXLI5Wcjkz18q3UO
 w1/UI5jat6N92OGykwamKl0YdZouFoK/rBmCXASv1RzY5XszA/WIS9SAgkM/moi5pCYz
 mqckBYk2dyveeAVtfAQ439J6JaPpILmvHYwLR0Sz0BTJbxQkxJAQwcEdnlS5TTZCb5w5
 u3bbYQ7EZTtoirFp23sngcIEwETcN4FD1ntf+D/xYxXUfT5Z9f0NnQmDhtuGSQU+bwmT
 F+hwcHmIJ7idq7V2jg5aLsJIy1shTj4SahqfbaaXKSD31T9GVzznuSi5pt7yKMaJPHER
 WJ1A==
X-Gm-Message-State: AOJu0YwcnrATHShj9FsygqSQqiVdLhHXWiQsXv/fGRNkLReTg551PmWT
 o0DiKb8pgq8NERrJKLASGR9Wzf0f5ysaeywzDdrL9swxgxJ9+tevuUk7ggASWuyVrnSozFOn9mq
 2HoGkjBJAw+rHYNRbPoWx7V3KsxAnL5+dGkN9JhguCWFSNGbcG2YjxkufJfXED2lYBPE7HEG583
 fcwfRv1mSmE5Ku4zXBBqJLba5yL3BZ9x4CJnOkdg==
X-Gm-Gg: ASbGncswB6q2S0+j8NWZqRl9Vm0ve0jVffQbyTZSR46z4hWo+DFEEkiFOSHrD7+Htrl
 Mb+wtAcKhgVmTWcc49iRoH2noz8Yyc3CWm2cuoM6qfS6o8p+JfN+JdtBIfCirAZhpAP/2t6pULJ
 v8JJxq09AjfKu2uX+ntdIqm9uE8n1Wni1SgyufYDUYTPHA18HuF5KnU77bNLxK+2F0TKSJoR+wY
 grkn3Pf+aT6EtWVThrdNozlZWKuick7we/b+Y3jAx9whfih6sYg6xcjhb1m8G0c1TnB0hXKf7zO
 gIBnRv9Bii4LSTQ6tdngAAwkTq+vgq2MzZfo/AsgXERfJm3RppNyxuGClbdkCBCA5h4J1WKTsu0
 cSpXOrwZnHgorEMQvA2w=
X-Received: by 2002:a05:6902:1243:b0:e96:c325:9775 with SMTP id
 3f1490d57ef6-e96c3262d5amr13385987276.48.1756328394090; 
 Wed, 27 Aug 2025 13:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIgpJsamo7OoZBWxMJDrXBYPl0qpshQX7BvBfgYY4kZlgP8SwZiqltR8WgNxKmKaUkBwgBiw==
X-Received: by 2002:a05:6902:1243:b0:e96:c325:9775 with SMTP id
 3f1490d57ef6-e96c3262d5amr13385943276.48.1756328393631; 
 Wed, 27 Aug 2025 13:59:53 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:53 -0700 (PDT)
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH RFC 1/9] migration/vfio: Remove BQL implication in
 vfio_multifd_switchover_start()
Date: Wed, 27 Aug 2025 16:59:40 -0400
Message-ID: <20250827205949.364606-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

We may switch to a BQL-free loadvm model.  Be prepared with it.

Cc: Cédric Le Goater <clg@redhat.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration-multifd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e4785031a7..8dc8444f0d 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -763,16 +763,21 @@ int vfio_multifd_switchover_start(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
     VFIOMultifd *multifd = migration->multifd;
+    bool bql_is_locked = bql_locked();
 
     assert(multifd);
 
     /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
-    bql_unlock();
+    if (bql_is_locked) {
+        bql_unlock();
+    }
     WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
         assert(!multifd->load_bufs_thread_running);
         multifd->load_bufs_thread_running = true;
     }
-    bql_lock();
+    if (bql_is_locked) {
+        bql_lock();
+    }
 
     qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
 
-- 
2.50.1



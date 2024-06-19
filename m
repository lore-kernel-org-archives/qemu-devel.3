Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5DAC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 22:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK3pi-0001sY-LQ; Wed, 19 Jun 2024 18:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pf-0001rn-Gw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sK3pe-0008Qb-4E
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 18:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718836269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWa9Q1e98UsIyOBWNw6j1ml8M+NDcRsBv6tl/URKA74=;
 b=ZClBiMsOoEFbE6PeoLbewVJiFeKWHQkYMwZWBoNIikvSYuCarviyR0sh1uAA+U46bamzDp
 heBqLZKXBJx6MHna3d43/eKQAhqrHTo2pnysCnRcYZQoM+wBSOkUsoycX7Seeb5DFo9rho
 l/7wi5gQj5gX8bJ6CK7/MeNBnearPCA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-EDp9Q_2VMbmBGo0wxYFOTA-1; Wed, 19 Jun 2024 18:31:07 -0400
X-MC-Unique: EDp9Q_2VMbmBGo0wxYFOTA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b4da351183so910036d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 15:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718836266; x=1719441066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWa9Q1e98UsIyOBWNw6j1ml8M+NDcRsBv6tl/URKA74=;
 b=aynQGjNKJOdYWU+zbwxtR+ASDoZqAk1X1DyAJVBv3ZRP6ID+9bzNgl9ZYxSrP8ZPGZ
 M76gtbH8AAt/odcoPiTZIAlu4yRf1/KTJ+1JUkHm4OXURako921PTKtYf2Y3FklulBZ1
 v96jOkWm7dl6pkJs8j0gMVzVR5mNWSvU8INozZyeOaOxxyvv7kGn7WWygbCyqIvY3CAJ
 yJiekgdOSwbB/3BTxWpzVzdPXtadGHuy2g9R/F3ZpB7bN6ntLOPaNNIXfsMqTJ7DgjmH
 JjZ3oeOtpI9OTs/XqUfgf62/nl9+P9uZtcTgIDnucgIv5+yiGw538sVR1NPN7Ivw6S3W
 b4Eg==
X-Gm-Message-State: AOJu0YyWTPKh0krLaczZSnzBw8JeLsXYT9BRfYCK3si9e8y14j0YpR3I
 D3FuSMr2qHA5c9uB4JZQ9lv1win7XSc6iJ0LLLoWTNdJr8WxBGGjkERUI/lr4XNd28iS3qOq7Tt
 UHmSZ2eSW4lAXA1RWzf5sortgzW8mN29i8Pxay8Gwki9MgtLaOXttr/82MnkSMJddPPTTFwrWMi
 eR1LT55kKdUbTPltpRiUV7fh7NKxrOGv8sJA==
X-Received: by 2002:a05:6214:2242:b0:6b2:bf2e:b273 with SMTP id
 6a1803df08f44-6b501ec378dmr39903816d6.3.1718836266488; 
 Wed, 19 Jun 2024 15:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkaFqAN1Rk+ovLrV0J0Zetg/t5k5YaCUTgLletS4O0OYdRDuBqtOeu4RaDZvhpFkVErl6jiw==
X-Received: by 2002:a05:6214:2242:b0:6b2:bf2e:b273 with SMTP id
 6a1803df08f44-6b501ec378dmr39903506d6.3.1718836265908; 
 Wed, 19 Jun 2024 15:31:05 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c466bfsm80844256d6.68.2024.06.19.15.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 15:31:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bdas@redhat.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Eric Blake <eblake@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 08/11] tests/migration-tests: Always enable migration events
Date: Wed, 19 Jun 2024 18:30:43 -0400
Message-ID: <20240619223046.1798968-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619223046.1798968-1-peterx@redhat.com>
References: <20240619223046.1798968-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Libvirt should always enable it, so it'll be nice qtest also cover that for
all tests on both sides.  migrate_incoming_qmp() used to enable it only on
dst, now we enable them on both, as we'll start to sanity check events even
on the src QEMU.

We'll need to leave the one in migrate_incoming_qmp(), because
virtio-net-failover test uses that one only, and it relies on the events to
work.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 1 +
 tests/qtest/migration-test.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0ac49ceb54..2ca4425d71 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -258,6 +258,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
+    /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
 
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 640713bfd5..c015e801ac 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -851,6 +851,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(*from, "events", true);
+    migrate_set_capability(*to, "events", true);
+
     return 0;
 }
 
-- 
2.45.0



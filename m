Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91BBCCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTn-0002tX-0g; Wed, 22 Oct 2025 15:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTf-0002sv-Ry
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTd-0001XO-Cw
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEZkhyoFmaVmDzC4IYCUW4XvW8OD8L6dAS9sarlyY8A=;
 b=Z+cenydxgVKLPZWGA56LHOo3WgFVXdDzYpXrhDOcEp7T56PNbBxectmQeIM4W7OB//LHGj
 X10yBt+XHOX5Ajt8Qm1rkLLpH1NAkrCr+skzUu/EfLi5KMc1KtHZk2SzXLVYsk8HUhqW3K
 Mo2DxaFRsonB5FyRdVfet504PlKdyhY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-6KnhmGIHNYme-L0CzaxcVw-1; Wed, 22 Oct 2025 15:26:26 -0400
X-MC-Unique: 6KnhmGIHNYme-L0CzaxcVw-1
X-Mimecast-MFC-AGG-ID: 6KnhmGIHNYme-L0CzaxcVw_1761161186
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8a73256easo47324441cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161186; x=1761765986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEZkhyoFmaVmDzC4IYCUW4XvW8OD8L6dAS9sarlyY8A=;
 b=qyb8guPxHcZJcUxX3mmm5mV6wPxCeo/KPUX/9wN4Cs6/lOyIIr3a4UFz7/MlPLon72
 AMn1QV0F0T+BbiZB9AQqxMj+x3TrLt4QjNjI3zG449RmCJenWRBbx5hJHOy8mrpLemr6
 lze8C1dtGGGoocMX0p9JQilpJgjM3PtY9lzgQcBUxIRt2woBJYAirJvx2RTxPqiQFpVd
 B0uw6H6+SzydEYjrLrO8bErqXu639q2BANJxpfVqjaH5TefkEcetyZALYUoBL0NyydzD
 60ssFvpQ1zlTR5GjeAC3HkIZB8X07LpUw+16Hf331IVnnisa8NtJ0UVCsYqN3HH4M99e
 ypPg==
X-Gm-Message-State: AOJu0YyIv4kuesKmQM7B6PjEyiFMB/6R5kmoZ5XncSlhxqdr82SUxPzk
 X62UO5EYaUDz3L3p9VCie6ukUxFyZxWtmYe+8Ca/unWPwT8uPgfpCWAC5yjaiRz1n9+qm9t5tnr
 mzSQVuC49wfmLUYujujmJDRgOL25JdwxtfRp0Z69F+NJwbLo7A2iLDTKJExzXlOFpKnu0mALwGj
 +2OpwKOcFRziQL8GEhsAKIlcu+9BBRzGL7ZgVj9Q==
X-Gm-Gg: ASbGncvXAZ9VHmiPJuFbwtNdeSTFdHzh6Mhq2Hpk5jSMR5WaHlNtWvm6ZLWYP2fqHTK
 atIIeQUIowgyn89BwZkP+CTSeQ5rLttRdK6jGnTOuepPsucom3niwPuAcN5E3jvs3RTlvk9sHnI
 slf52snzs6tX91bOCkNSRow39xcqrT53nJm31XtOF9SQa8qHz5uR5kZK5L+Pzt0dGux6KnrinCw
 6NcUbq3cPD6C2wbODyztM5Uyg+/I8V4OqSqyoPFxPS4ArWEVK0LXbZU2a+FhG5H7QJJABNYjYlW
 IprjwmLs7rAXtCVxlCfRl88Dy2t6RUGsLzwMAewwI/1Nqd9PdhGYDRhB9D1g1plS
X-Received: by 2002:ac8:7fc8:0:b0:4b3:4fa9:4cd2 with SMTP id
 d75a77b69052e-4eb7331fff9mr69350061cf.33.1761161185834; 
 Wed, 22 Oct 2025 12:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8kQu6hhKmMWi+k3MxYkOzl1GpTzwGguJhzriIZxs7mUS/Ndio7/tWDGOt/FIXdcCcVRHyVA==
X-Received: by 2002:ac8:7fc8:0:b0:4b3:4fa9:4cd2 with SMTP id
 d75a77b69052e-4eb7331fff9mr69349511cf.33.1761161185234; 
 Wed, 22 Oct 2025 12:26:25 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 06/13] migration: Introduce WITH_BQL_HELD() /
 WITH_BQL_RELEASED()
Date: Wed, 22 Oct 2025 15:26:05 -0400
Message-ID: <20251022192612.2737648-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce the helpers to conditionally take or release BQL for a process.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..e1c5029110 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -20,6 +20,7 @@
 #include "qobject/json-writer.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "io/channel.h"
 #include "io/channel-buffer.h"
 #include "net/announce.h"
@@ -42,6 +43,100 @@
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
 
+struct WithBqlHeldAuto;
+typedef struct WithBqlHeldAuto WithBqlHeldAuto;
+
+static inline WithBqlHeldAuto *
+with_bql_held_auto_lock(bool bql_held, const char *file, int line)
+{
+    assert(bql_held == bql_locked());
+    if (!bql_held) {
+        bql_lock_impl(file, line);
+        return (WithBqlHeldAuto *)1;
+    }
+    return (WithBqlHeldAuto *)2;
+}
+
+static inline void
+with_bql_held_auto_unlock(WithBqlHeldAuto *v)
+{
+    assert(bql_locked());
+    if (v == (WithBqlHeldAuto *)1) {
+        bql_unlock();
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(WithBqlHeldAuto, with_bql_held_auto_unlock);
+
+#define  _WITH_BQL_HELD(bql_held, var)                              \
+    for (g_autoptr(WithBqlHeldAuto) var =                           \
+             with_bql_held_auto_lock(bql_held, __FILE__, __LINE__); \
+         var;                                                       \
+         with_bql_held_auto_unlock(var), var = NULL)
+
+/**
+ * WITH_BQL_HELD(): Run a block of code, making sure BQL is held
+ * @bql_held: Whether BQL is already held
+ *
+ * Example use case:
+ *
+ * WITH_BQL_HELD(bql_held) {
+ *     // BQL is guaranteed to be held within this block.
+ *     // If bql_held==false, bql will be released when the block finishes.
+ * }
+ */
+#define  WITH_BQL_HELD(bql_held)                                    \
+    _WITH_BQL_HELD(bql_held, glue(with_bql_held_var, __COUNTER__))
+
+struct WithBqlReleaseAuto;
+typedef struct WithBqlReleaseAuto WithBqlReleaseAuto;
+
+static inline WithBqlReleaseAuto *
+with_bql_release_auto_unlock(bool bql_held)
+{
+    assert(bql_held == bql_locked());
+    if (bql_held) {
+        bql_unlock();
+        return (WithBqlReleaseAuto *)1;
+    }
+    return (WithBqlReleaseAuto *)2;
+}
+
+static inline void
+with_bql_release_auto_lock(WithBqlReleaseAuto *v)
+{
+    assert(!bql_locked());
+    if (v == (WithBqlReleaseAuto *)1) {
+        /*
+         * NOTE: cleanup function cannot take more than 1 argument.  Keep
+         * it simple here by not passing __FILE__/__LINE__ from the caller.
+         */
+        bql_lock_impl(__FILE__, __LINE__);
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(WithBqlReleaseAuto, with_bql_release_auto_lock);
+
+#define  _WITH_BQL_RELEASED(bql_held, var)              \
+    for (g_autoptr(WithBqlReleaseAuto) var =            \
+             with_bql_release_auto_unlock(bql_held);    \
+         var;                                           \
+         with_bql_release_auto_lock(var), var = NULL)
+
+/**
+ * WITH_BQL_RELEASED(): Run a block of code, making sure BQL is release
+ * @bql_held: Whether BQL is already held
+ *
+ * Example use case:
+ *
+ * WITH_BQL_RELEASE(bql_held) {
+ *     // BQL is guaranteed to be release within this block.
+ *     // If bql_held==true, bql will be re-taken when the block finishes.
+ * }
+ */
+#define  WITH_BQL_RELEASED(bql_held)                                    \
+    _WITH_BQL_RELEASED(bql_held, glue(with_bql_release_var, __COUNTER__))
+
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
 
-- 
2.50.1



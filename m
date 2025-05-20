Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CC0C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRq-00006O-Du; Tue, 20 May 2025 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRg-0008Rf-3p
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRe-00015a-9o
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq0T0MzaIFV/IMvPshoRJq+5dempSPF70k6hbdmc2b8=;
 b=V5a9mY62RASYbMVjPWmNIjZJ5dFkp0bvtGvFBYhtf8HWOqlKsrkEDWhn7rObAdZldv7JWw
 q4w2ycprvTWU0wPrlqKewteWjbHVJGDLhpK80QGnctH+7M7xQKmCCo/vah49X3+aT3JD6h
 5+s/v1ghnADi+AC6xxQohUS9IiKwvYk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-vMoPtvSTNsW76_rBieD57Q-1; Tue, 20 May 2025 13:08:00 -0400
X-MC-Unique: vMoPtvSTNsW76_rBieD57Q-1
X-Mimecast-MFC-AGG-ID: vMoPtvSTNsW76_rBieD57Q_1747760879
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5cd0f8961so1222278085a.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760878; x=1748365678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rq0T0MzaIFV/IMvPshoRJq+5dempSPF70k6hbdmc2b8=;
 b=D8IHj9VrzyExzDsPmPqmf0qBYR2Oc5UbX3xB1S70dA+me5ZoMqaK9GaFwlmPTRo9Ic
 l0nZ0VXIpGX0gB78nPB+ERIVisSqFF/FojimzVLQUQFSoG9PdG5nKmq3McM8RX8K+2+F
 dnJsoZ37h6HlcAVw8eWky5gW/ClPsTUDRpiTa1thItUBlGxidjiJx81EmMzv3nprVvYh
 HCBgFmFXP3CHasrajSHRCWow583u+bP7my/lxGEpv0S6mNKaaHOZmoXX8fqcma1tetaw
 2lMUmv1CwCI0YAxsuSWZmhZrszrIMgKivEdJ9F8YsezkDks3Gr0AvjWDXkk+oBCwX5D5
 4zMw==
X-Gm-Message-State: AOJu0Yy4nNQs80vTRR0SewKLLXP5PiTv2oyjY+MlGRzE7Qb0f1zvZuZQ
 sRKeB9vE5L5EYUVJB25M46FWzBADlIRbmAC8nZrl4riidN4JRCRDncdxtOOHCNWxf3+Dafc9x28
 rlYulFPn0oT0B8dMRET5LAt9HiC0gA9YUny9KwW4/Um4Q7n7aWxqXktTsqOwnSCTCYIYFhOgZU3
 0hm2SXYk/rgGNP6O6/gwF+tPSHvDdPIdRsvkv4RA==
X-Gm-Gg: ASbGnctT01Kp4tipDfuxIBzswoY1BhnhtAC3lqR7ypJeU+Fi1MdNmshUJ0OyAyauYRg
 hZgeXmNZFmajRYdPwSKS9eKjw8hIOOgJaXyU4cpHo8s+CfejmRr1vKQmB7g0lKaJRaFJb8hUb/x
 oPcbTiul70meD7PLN+iSj76fib7bjpJT/meNyzPyB90w42o2LxwSF8J3T4bvX9Zb79OdANuuaks
 ooBe/5+TbbovNOsH4QqaTxwKmbHg20diFtAVYdGIGcD6U0/dOEgVwygKKCPKSYmrhztvS33li2q
X-Received: by 2002:a05:620a:d8d:b0:7ca:c9cb:ac1 with SMTP id
 af79cd13be357-7cd4671895bmr3050488285a.4.1747760878098; 
 Tue, 20 May 2025 10:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YVVQBo/XHo3OTYsL7tLkltlROFlAi7O3RiahparSKlJO6T2zAjyw/SWzcNVvBBdhyF2wFw==
X-Received: by 2002:a05:620a:d8d:b0:7ca:c9cb:ac1 with SMTP id
 af79cd13be357-7cd4671895bmr3050482385a.4.1747760877501; 
 Tue, 20 May 2025 10:07:57 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 02/12] qtest/migration/rdma: Enforce RLIMIT_MEMLOCK >= 128MB
 requirement
Date: Tue, 20 May 2025 13:07:41 -0400
Message-ID: <20250520170751.786787-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Ensure successful migration over RDMA by verifying that RLIMIT_MEMLOCK is
set to at least 128MB. This allocation is necessary due to the requirement
to pin significant portions of guest memory, typically exceeding 100MB
in this test, while the remainder is transmitted as compressed zero pages.

Otherwise, it will fail with:
stderr:
qemu-system-x86_64: cannot get rkey
qemu-system-x86_64: error while loading state section id 2(ram)
qemu-system-x86_64: load of migration failed: Operation not permitted
qemu-system-x86_64: rdma migration: recv polling control error!
qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -1
qemu-system-x86_64: Channel error: Operation not permitted

Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/20250509014211.1272640-1-lizhijian@fujitsu.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 87b0a7e8ef..5be1cd5742 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -101,6 +101,35 @@ static void test_precopy_unix_dirty_ring(void)
 
 #ifdef CONFIG_RDMA
 
+#include <sys/resource.h>
+
+/*
+ * During migration over RDMA, it will try to pin portions of guest memory,
+ * typically exceeding 100MB in this test, while the remainder will be
+ * transmitted as compressed zero pages.
+ *
+ * REQUIRED_MEMLOCK_SZ indicates the minimal mlock size in the current context.
+ */
+#define REQUIRED_MEMLOCK_SZ (128 << 20) /* 128MB */
+
+/* check 'ulimit -l' */
+static bool mlock_check(void)
+{
+    uid_t uid;
+    struct rlimit rlim;
+
+    uid = getuid();
+    if (uid == 0) {
+        return true;
+    }
+
+    if (getrlimit(RLIMIT_MEMLOCK, &rlim) != 0) {
+        return false;
+    }
+
+    return rlim.rlim_cur >= REQUIRED_MEMLOCK_SZ;
+}
+
 #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
 static int new_rdma_link(char *buffer)
 {
@@ -136,6 +165,11 @@ static void test_precopy_rdma_plain(void)
 {
     char buffer[128] = {};
 
+    if (!mlock_check()) {
+        g_test_skip("'ulimit -l' is too small, require >=128M");
+        return;
+    }
+
     if (new_rdma_link(buffer)) {
         g_test_skip("No rdma link available\n"
                     "# To enable the test:\n"
-- 
2.49.0



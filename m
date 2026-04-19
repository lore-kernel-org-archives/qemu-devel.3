Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E0EA7198
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 11:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEPw1-0006gR-5M; Sun, 19 Apr 2026 07:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wEPvr-0006f9-GW
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 07:03:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wEPvo-0004yq-Uw
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 07:03:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso8823615ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776596595; x=1777201395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8V6NT2glw/+GQHYipF/OBuuyIZO/jJlJfWL/hU7am8=;
 b=Ckxnd7PAmGdVfoE0GbRQIBElPYttWrkCo+1AodrsXOVzN08T2/7wZ8duL3xCRHpShb
 x6N3HWFGoGITgcO6CXILMNByeoUFDEANpeoivkDbWahahUKN1oQdJp7ofX8q+K8h7zhM
 e87yoFBYj8R/fcDoRKaHQEJa7ueSpruqJRw4EeHcUsxwl+M1pewCKZ+00dxY59rCOPR0
 SOyEpVP1v261wbkIz15nmGRFE0qf5WSZLG8Xiw8ZvW4iwFOSIaM55IU7Z/ai346ACw+B
 rmk0u2OE1deXVVZrkXiEbLQRTmDoQdqOTS2xzty2NuCJV2YY1jjxBFWRgweaM0QIrlob
 o3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776596595; x=1777201395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8V6NT2glw/+GQHYipF/OBuuyIZO/jJlJfWL/hU7am8=;
 b=PVdfKzb6KmrpSjZNPuXRuJBpH4TgrTjrhVkrvgJPxkuc/edWawPXc8Mz55HW8LvGgL
 ZGkAJV1CaAPPZJ4FDod4Cig1DPQdxpMzr9IjOyL5DfxPMrJTy4X+bVjlmR0G8e8QyXeS
 FRg1g86yNkk6p3hqNp3SeGGjUSBDHLGmvXY6k4G6vSpLl19xlNeUvneiAMGC8naJs0Q/
 V2Z3qRMTxrlTTR7A/6YLqNdLm7rexRo/znC7I4OOuwBxdzFrp9rRfqdxuVL715ww1Zvf
 wRtJdTH2WKQEo1tVVchxsbHKKZnsJv1hgoHbit2iq7fI1SPacreDfh2mH/7VXEKwq6aP
 nn6A==
X-Gm-Message-State: AOJu0YxXwcBIoVU4Wd5rdVpCzK2gpYpYvgmKZucVUYtTM2LDp6I84pid
 hvNd1m8v1/XnELVV50ZeBfz46kJmv8+wHlhvGrzSdWzgkAybMpdec1oe98OeBkxa
X-Gm-Gg: AeBDieucKHpWbUPwtH2gCOBR27FVx94bq7PAB+gVreP0LNiK55yxptcHtF8f60Yr604
 qCTedIyecZwDEeIvt+AySPqhBASoHwug5/XpgOLDapOpZeALfCV+vSIJwf7B6ccbb+jdvCqkfod
 hcdRTQIF/Brfs7jo8zTsOQtfVKiLfsLhvdw/nKSMDxAodQuyZrHJTdtzDoyCghT3oKvTX1tKTgn
 u7By7hH5/0qyfCKZaQDH3K0MDlH7joVbGmZW55oXUIvwPNwqTOZJwZMxvyrgsZkF1KoFwGcYgSP
 IwTKkCbxLK4uCAGJeCNv7nN1/zsuYvR7nbfkSxmss4JaqXhzxkAT4yC8YedgzY81wj0hD3I+Jy6
 VGKwiUKj2DCh1fW5ObqTbaruty7pj9M/NLQQ9txyzU32kEEM3GlW+6BcPm0htB9AUVoyOJOaQ1S
 Mzdj3BS/Q1Xp2eOtkjpNnRDjoKqrLrR7jJydXHqISwEW/4jO9M5ZbLTkgFWV4ghwMqsjcs
X-Received: by 2002:a17:902:f652:b0:2b0:beb4:3bb with SMTP id
 d9443c01a7336-2b5f9e7f300mr97170915ad.10.1776596594922; 
 Sun, 19 Apr 2026 04:03:14 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa30134sm73517525ad.30.2026.04.19.04.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 04:03:14 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest/migration: fix fd leak in ufd_version_check
Date: Sun, 19 Apr 2026 18:03:04 +0700
Message-ID: <20260419110304.8661-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

ufd_version_check() opens a userfaultfd via uffd_open() but never closes
it on any path where the open succeeded: the UFFDIO_API failure path,
the missing-ioctls path, and the success path all returned without
calling close(ufd).

Convert to a goto-out pattern consistent with uffd_open() used in
util/userfaultfd.c and migration/postcopy-ram.c, ensuring the fd is
always closed before returning.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 tests/qtest/migration/migration-util.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 2648ad7f61..db66d8b24f 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -343,6 +343,7 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
 {
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
+    bool ret = false;
 
     int ufd = uffd_open(O_CLOEXEC);
 
@@ -355,7 +356,7 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
     api_struct.features = 0;
     if (ioctl(ufd, UFFDIO_API, &api_struct)) {
         g_test_message("Skipping test: UFFDIO_API failed");
-        return false;
+        goto release_ufd;
     }
 
     if (uffd_feature_thread_id) {
@@ -366,10 +367,13 @@ bool ufd_version_check(bool *uffd_feature_thread_id)
                   1ULL << _UFFDIO_UNREGISTER);
     if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
         g_test_message("Skipping test: Missing userfault feature");
-        return false;
+        goto release_ufd;
     }
 
-    return true;
+    ret = true;
+release_ufd:
+    close(ufd);
+    return ret;
 }
 #else
 bool ufd_version_check(bool *uffd_feature_thread_id)
-- 
2.43.0



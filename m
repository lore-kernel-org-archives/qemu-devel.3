Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFFECF3941
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHXc-0006gm-13; Thu, 19 Sep 2024 09:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHXU-0006JE-97
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:49:45 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHXR-0006Mq-P3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=WpHNe7TXr6HaQLeHukME84FM+iJR/rwtrGszqmqqelg=; b=D/FvDNOIihSCBkgc
 24gXXwSu23d7IUR7FeSAiKLEPrrfSeogTd4CiyfhurCkKcZ2+D3+HmbosO8BXrKtzfJH9ulNY2O/Z
 d026odqINELDLDh0wl2J1Rt6pnWs5/tmTXwcqEWHCLE+46PrpjvrZP7i4JGlEdKWJzkhML1VqekUq
 UmeP6gkbrq8Hmkfku910AtSDRnMam0XkGpFd+p9DRPqh+WC73X7qRgG9oTK49T615Tt65/AjQlGAi
 yYRXr9UxW23GJrZrhXi1DXLUmf1J0LC7yiG5rM3wrSe4ojaACFrGzM+9k2SK6DbW9hsFgCw82kr2i
 A+CFMNqAkxvvFuO0bg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHXM-006QOJ-03;
 Thu, 19 Sep 2024 13:49:36 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 7/7] util/userfaultfd: Remove unused uffd_poll_events
Date: Thu, 19 Sep 2024 14:46:26 +0100
Message-ID: <20240919134626.166183-8-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

uffd_poll_events has been unused since it was added; it's also
just a wrapper around a plain old poll call, so doesn't add anything.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/userfaultfd.h |  1 -
 util/userfaultfd.c         | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/qemu/userfaultfd.h b/include/qemu/userfaultfd.h
index 18a4314212..a1979308d7 100644
--- a/include/qemu/userfaultfd.h
+++ b/include/qemu/userfaultfd.h
@@ -39,7 +39,6 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
 int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake);
 int uffd_wakeup(int uffd_fd, void *addr, uint64_t length);
 int uffd_read_events(int uffd_fd, struct uffd_msg *msgs, int count);
-bool uffd_poll_events(int uffd_fd, int tmo);
 
 #endif /* CONFIG_LINUX */
 
diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index 518d5c3586..2396104f23 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -358,31 +358,3 @@ int uffd_read_events(int uffd_fd, struct uffd_msg *msgs, int count)
 
     return (int) (res / sizeof(struct uffd_msg));
 }
-
-/**
- * uffd_poll_events: poll UFFD file descriptor for read
- *
- * Returns true if events are available for read, false otherwise
- *
- * @uffd_fd: UFFD file descriptor
- * @tmo: timeout value
- */
-bool uffd_poll_events(int uffd_fd, int tmo)
-{
-    int res;
-    struct pollfd poll_fd = { .fd = uffd_fd, .events = POLLIN, .revents = 0 };
-
-    do {
-        res = poll(&poll_fd, 1, tmo);
-    } while (res < 0 && errno == EINTR);
-
-    if (res == 0) {
-        return false;
-    }
-    if (res < 0) {
-        error_report("uffd_poll_events() failed: errno=%i", errno);
-        return false;
-    }
-
-    return (poll_fd.revents & POLLIN) != 0;
-}
-- 
2.46.1



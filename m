Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0093C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1BpH-0007IT-Pb; Mon, 31 Aug 2026 19:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SS-0000g9-2w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SP-0004oM-3h
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so38287915e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788211339; x=1788816139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ENmYRrI7kULhz8hcx6PjQC48ovvVVI5t0LJpUviRTck=;
 b=VIvYMH+SXJe9+rQdE9dTwqEQbrGXLTAduOG9bR3gm659O0V6lvSGMEDAqtpQ3WAxSg
 m8Ne8+H5Dw3jkvsZXOQlR4Q+PQdNVsPHnvb3KHAxcpR1HdEY9uU1VCMzLbevKRUjQBgr
 1AXUW3GfjkaU+zln0C+B40L/B3IN9fFVjAhmzgTbtaH8QQC15I1lt4dH7Xk6xj6Nn+z3
 SluIbUHAktZTahkXwUBDR6KyHiBxocdmTEwAUW+ssST9+gouJ8zZrb08JehCTBlzDmOu
 p/8iCxqUvPklhfZI0EHYMEUj4kwaGSWtZzNfJL0ictn3VqnJScLbg+tw1BPgzLnBeIiF
 IhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788211339; x=1788816139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ENmYRrI7kULhz8hcx6PjQC48ovvVVI5t0LJpUviRTck=;
 b=jdo5ztPse+lAsZgUOoZIt1mHqisayaS9kgGMo9EFBsAc0gtgTeCEEHbhqEcDez8nLE
 0NVttGlrfYA9gOeY7JrBSVucs088Z8L6xMKnTSMEWNOszVuf8TCRSar8Lj8mBm163li+
 XN6mBB1Xwps3+H57f5wRi194Di3Nz1DZormNj6G2rn1a6lr3wcRfjf/wQCVBLWijR7Fy
 SezxGQVvaM/VlljfKjgB82ukIPpcWFUIIOo/a8jUaOCJTpJcfclchlaYYkptPsgEsbd8
 7zKy25x1zJM/V72ryWVZOMbPP7rDA/FD6VXjgewc6Kx+3AJgAg4NUge2pvwMm35mkgyn
 3oCg==
X-Gm-Message-State: AFuF++k/IDTSC55T1XnAXNoLOoEDyl2OlK4n4U41zxs7SmIvwe5+p6CN
 w0zBYPeiRxrEYN6NMbiUO3MrBmvJUbog/N77x5fNFDUNUGcQnZqy99cUkdPElTHiXKQDWw==
X-Gm-Gg: AR+sD10MpWVMaCt9rA5+Z8K7nmnhTEY9a0k8ACVmKVh69sy0D68LdS8L4ReYWlNhInB
 VZNLNwnfljI0/xHVdhQzPt9cBBhmbGIYogo5HvC+6hjlRuD1iU1U6re4FPY5KF5kqzvh2L3PUv/
 y0y80U+DgF34miEd/pz2jEt3bWrhmqXCv0eDt1gGnd8F3hBMA78Ic44Qg5qx/Gtu0mxz5NIMsze
 n3neGqfw1doPzi2TuRuFIPw5ILPg7IMgJRgd4A7iUgbSUMO9C3sOqJ3ZHzWT4cy95ug0z6FZiUq
 0/8tz9YcVptjc2dJPAjqwM8Ycs5xa3IcaLHvdLsxoG33req/nxLtv1O5nSIBeDX5k+IqwDh4AwD
 UthTQMuFxdLDT4sETE1NWS+ImGAz1ndnj7uoFWL5HYviIHc0tV6UwLVbMdhhhvwn4tGGWXQqhQL
 ElpbK678RZvxpzDzKAs4QhxWN8i0D8jIrKd7+Hi2dVlNRNiRXqaKcpXFuW+l2doL/+k6jVYHmFh
 BtsfUD20NGTsqViS697mET9LtZ41zrawAFw1VaZWqjjp7pJCqM=
X-Received: by 2002:a05:600c:258:b0:499:b65d:124f with SMTP id
 5b1f17b1804b1-49cdc435da7mr50466065e9.11.1788211339218; 
 Mon, 31 Aug 2026 14:22:19 -0700 (PDT)
Received: from sima-pc.tail8094aa.ts.net
 (CBL217-132-71-241.bb.netvision.net.il. [217.132.71.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10148sm18749815e9.5.2026.08.31.14.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 14:22:18 -0700 (PDT)
From: Roi Klevansky <roiklevansky@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Roi Klevansky <roiklevansky@gmail.com>
Subject: [PATCH 2/2] tests/tcg: add linux-user test for madvise returning
 ENOMEM
Date: Tue,  1 Sep 2026 00:20:40 +0300
Message-ID: <20260831212040.1833650-3-roiklevansky@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831212040.1833650-1-roiklevansky@gmail.com>
References: <20260831212040.1833650-1-roiklevansky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=roiklevansky@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Aug 2026 19:54:06 -0400
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

Add tests for madvise() under linux-user with partially and fully
unmapped address ranges, making sure it returns ENOMEM, just like
the kernel does.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4382
Signed-off-by: Roi Klevansky <roiklevansky@gmail.com>
---
 tests/tcg/multiarch/linux/linux-madvise.c | 43 +++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiarch/linux/linux-madvise.c
index 539fb3b772..b7a52abb6c 100644
--- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <unistd.h>
@@ -63,10 +64,52 @@ static void test_file(void)
     assert(ret == 0);
 }
 
+static void test_mapped_and_unmapped(void)
+{
+    int pagesize = getpagesize();
+    void *page;
+    int ret;
+
+    page = mmap(NULL, pagesize, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+    assert(page != MAP_FAILED);
+
+    ret = madvise(page, pagesize, MADV_NORMAL);
+    assert(ret == 0);
+
+    ret = munmap(page, pagesize);
+    assert(ret == 0);
+
+    ret = madvise(page, pagesize, MADV_NORMAL);
+    assert(ret == -1);
+    assert(errno == ENOMEM);
+}
+
+static void test_partially_unmapped_enomem(void)
+{
+    int pagesize = getpagesize();
+    void *page;
+    int ret;
+
+    page = mmap(NULL, 3 * pagesize, PROT_READ,
+                MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+    assert(page != MAP_FAILED);
+    ret = munmap((char *)page + pagesize, pagesize);
+    assert(ret == 0);
+
+    ret = madvise(page, 3 * pagesize, MADV_NORMAL);
+    assert(ret == -1);
+    assert(errno == ENOMEM);
+
+    ret = munmap(page, 3 * pagesize);
+    assert(ret == 0);
+}
+
 int main(void)
 {
     test_anonymous();
     test_file();
+    test_mapped_and_unmapped();
+    test_partially_unmapped_enomem();
 
     return EXIT_SUCCESS;
 }
-- 
2.55.0



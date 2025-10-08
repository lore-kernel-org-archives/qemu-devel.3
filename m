Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF866CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 19:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Zht-0005oI-R9; Wed, 08 Oct 2025 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WLnmaAcKCrMgTobWXfZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--navidem.bounces.google.com>)
 id 1v6Zhp-0005ny-S8
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:20:10 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WLnmaAcKCrMgTobWXfZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--navidem.bounces.google.com>)
 id 1v6Zhf-0001MF-S6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 15:20:09 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-b5527f0d39bso257458a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759951192; x=1760555992; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O8O3afMVZXVyFe70rQkGtJF/Bf4bStnjJZKXq1lmjXs=;
 b=jaEOVmp30eu4XTCPFatUKAcxzh6tvvO5AstSwDYA6X4Y7h2K4YIdBsJbORrBRsTHNv
 rARrhm8yVPhEETj3eXZ07aUqBJ5V8fxRUeC3t9PWSzKA3Rgp/sZUlF8Bv7iGyESKKZxe
 OZ/wh7mk7hikGm5k9QsuuvwDr2IDLNlTXuFpOSsdjF4gPW7Ahrdm29AiQ0jvaz31QZvc
 qz8sqrksldHYWqxyUqkWycil6JA0FBC6FlxWPtQWprBtULB2gZM5+crKBjm1rE4vu4qt
 LZga5nOo7x7QdxjCuUpGTd6O+Mk6l6bvGdNPsqq2bAhcA0GOz13iH4G1W+p71b1kjtkF
 d8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759951192; x=1760555992;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O8O3afMVZXVyFe70rQkGtJF/Bf4bStnjJZKXq1lmjXs=;
 b=m2hr51oDgi+TYacYRzUu/btMDSlw/TpEBNdjsMRDFyMvABmhmC/N1wKu+K36qjmIEN
 lLkVZ5yGCS8pVao21RRCXH6b70/nxiYSFeY7zyIrXxdEFCOo1LsEcyL2viR0tINGTFYJ
 5u2gMJvWAhxKW+5NHqTKnv3QLvHbAtQOz2fyW/ZsVT4XtjbkkNEcl0uk0ExABQDJyecV
 qJ4XhZ8MXp4JtvLopsjz7koB5jTHVhqDn1+5GUQ1o3bPWiWYxdbrOTCX1XCkxyTmQRXj
 5vDbtyuRmovQbQsUQ8BsI3SpX4cdXkJ2PzNKE2sspPxzaWLY7Ra1GIrqwZplK8tQRD88
 2pqw==
X-Gm-Message-State: AOJu0Yw1zBc+ziuDV3vlF/hKgLC+DSmm4yMcnh1FGMbSbZqLBPNLSDQq
 c4/aau2r+lce/hu5S16LVD69FD6MPld9RDo/sY6z7/Wd9RjqJJE9W9xc7ATj9iPd5OZcrR/1hdt
 JTw1V1BttgwqGGOpxqz9QlhTuOmGHTCDhr/SAff49dOQ2KGdBjzmM22UkFsqIdIUJ+L4B3hCLz/
 7PQZKJzSMaqLvGecHdf/2/4HQyxbgjL9giSRrVVRIj
X-Google-Smtp-Source: AGHT+IEM04NST8bPa1ysokYLjSjKTNv1HhzIWeWWyo0rIaTdLYomGtSM58xKXjM2DVNuRU/TO3gsQy83ibzb
X-Received: from pjbse11.prod.google.com ([2002:a17:90b:518b:b0:33b:51fe:1a92])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ac8:b0:26f:f489:bba6
 with SMTP id d9443c01a7336-290272f5913mr56174125ad.50.1759951192040; Wed, 08
 Oct 2025 12:19:52 -0700 (PDT)
Date: Wed,  8 Oct 2025 19:19:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008191936.3069950-1-navidem@google.com>
Subject: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org
Cc: navidem@google.com, zsm@google.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3WLnmaAcKCrMgTobWXfZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--navidem.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The qpci_iomap() function fails with a fatal g_assert(addr) if it
probes a PCI BAR that has a size of zero. This is expected behavior
for certain devices, like the Q35 PCI Host Bridge, which have valid but
unimplemented BARs.
This assertion blocks the creation of fuzz targets for complex machine
types that include these devices.
Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
zero-sized BAR is now handled gracefully by returning an empty BAR
struct, allowing fuzzing to proceed. The original assertion is kept for
all other builds to maintain strict checking for qtest and production
environments.

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/libqos/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b992..df9e2a3993 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
         addr &= PCI_BASE_ADDRESS_MEM_MASK;
     }
 
+#ifdef CONFIG_FUZZ
+    /*
+     * During fuzzing runs, an unimplemented BAR (addr=0) is not a fatal
+     * error. This occurs when probing devices like the Q35 host bridge. We
+     * return gracefully to allow fuzzing to continue. In non-fuzzing builds,
+     * we retain the original g_assert() to catch unexpected behavior.
+     */
+    if (!addr) {
+        if (sizeptr) {
+            *sizeptr = 0;
+        }
+        memset(&bar, 0, sizeof(bar));
+        return bar;
+    }
+#endif
+
     g_assert(addr); /* Must have *some* size bits */
 
     size = 1U << ctz32(addr);
-- 
2.51.0.710.ga91ca5db03-goog



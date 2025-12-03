Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3D0D12D5F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQmhb-0005zi-3j; Wed, 03 Dec 2025 08:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1vQmhZ-0005w8-G1; Wed, 03 Dec 2025 08:15:25 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1vQmhX-0001MK-LX; Wed, 03 Dec 2025 08:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=pBE9nwi6TppjSeUttbju5Apd99/M9N3r+cNvcFRlW5k=; b=U4pETs9AkiJVVa7Q
 IQv7+PDpN3be4tM4AtZ9Xg2gpqL7X7PSxt/fqogVmAU/TJILQC/XVZ8PKAHQCkDhQtCXwAXS6LFJ5
 1j2KA3ZteRkaoZ/HNU/VmmyJ7Ny7YYSGkgugIkHDN95X3GFkB8h6LHUPo/9s7pgCpk3yWD7hgPeY2
 L2mmlYKc5DnYQWKmeK1FJrpmAy3Nhw4WoOTpsrkAk8WQP6+Y1Y1KSfkVJ+v+/97p9eHSyTgtGd7u4
 MRRUGUtD/ACo6miEgzj+1C2YkRKc7DNv+ZLY68IlP9T52pQKK/iuGh+QOrk7hVsm/n0Fwvvr46N5a
 9gCwVKlr8pmlKoHSyw==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vQmhS-00000007qGj-0KZf;
 Wed, 03 Dec 2025 13:15:18 +0000
From: dave@treblig.org
To: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 thuth@redhat.com, pbonzini@redhat.com
Cc: jak@jak-linux.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] qemu-options.hx: Document -M as -machine alias
Date: Wed,  3 Dec 2025 13:15:11 +0000
Message-ID: <20251203131511.153460-1-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
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

-M is used heavily in documentation and scripts, but isn't actually
documented anywhere.
Document it as equivalent to -machine.

Reported-by: Julian Andres Klode <jak@jak-linux.org>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 qemu-options.hx | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..ec92723f10 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
+    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
     "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
     QEMU_ARCH_ALL)
 SRST
@@ -179,6 +180,9 @@ SRST
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 
+    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
+        Define an SGX EPC section.
+
     ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
         Define cache properties for SMP system.
 
@@ -208,12 +212,10 @@ SRST
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
-    QEMU_ARCH_ALL)
-
+    "-M              as -machine\n", QEMU_ARCH_ALL)
 SRST
-``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
-    Define an SGX EPC section.
+``-M``
+    as -machine.
 ERST
 
 DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
-- 
2.52.0



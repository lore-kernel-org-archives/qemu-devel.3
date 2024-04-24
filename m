Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C080C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXW3-0004g4-PI; Wed, 24 Apr 2024 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXW2-0004fp-4E
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXW0-00030P-GU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2iAu8HzYT+FAFE9n/n90HoZwkaTyvUARONMZ1TtD5o=;
 b=Jg+NSYaRUNP0jDKKBRTcxVjdZB7S7z2ksP6tKiAsjdkSMOYof/19t1BJQ7tFmHeqw0Iepi
 HSTgUlDiLfg5pzwLBWhWsM+fxq0wLo+yIT0S4MrnncvtiypQp59JIm8BZBKGikSf8qi1vf
 6k9Co0Q3o1XJQHsJHllrftIG0I3RfF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9nze1rbMM0iVwRo4J2TQgQ-1; Wed, 24 Apr 2024 03:57:59 -0400
X-MC-Unique: 9nze1rbMM0iVwRo4J2TQgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0781D18065B3;
 Wed, 24 Apr 2024 07:57:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22CCD3543A;
 Wed, 24 Apr 2024 07:57:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/17] docs: i386: pc: Update maximum CPU numbers for PC Q35
Date: Wed, 24 Apr 2024 09:57:21 +0200
Message-ID: <20240424075735.248041-4-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
the supported CPUs for PC Q35 machine.

Update maximum CPU numbers for PC Q35 in the document.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/target-i386-desc.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 5ebbcda9db..319e540573 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
 -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
    hub.
 
-SMP is supported with up to 255 CPUs.
+SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
 
 QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
 VGA BIOS.
-- 
2.44.0



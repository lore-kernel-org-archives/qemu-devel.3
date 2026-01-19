Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E8DCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm9C-0003kk-I0; Mon, 19 Jan 2026 05:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8x-0003e7-73
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8t-0005h3-IK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBBybsE9SCqKthoFWiOhdo4yAZz4bEiTSJRfjKa+50Q=;
 b=S0/IjCvg2jB/z3e6a95Kotss8vXVO6WwAD1v1ACxkgWx3QgIg0BdO9AS5sFodV0Tx9WL8n
 jjwr7WXCm/Wiz0mFPji5B2BdKqsl9WMt0x2MBpGexoPD4SAy4xx/MxhV8ImgY+JS68kiAg
 bEMBfNzVVos/ED/S5i5HdKNKTUFwNbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-mBTHQOa7NEODLL43llTRUg-1; Mon,
 19 Jan 2026 05:05:43 -0500
X-MC-Unique: mBTHQOa7NEODLL43llTRUg-1
X-Mimecast-MFC-AGG-ID: mBTHQOa7NEODLL43llTRUg_1768817142
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C391977310
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C18630001A8
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 799CC21E692F; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] scripts/clean-header-guards: Update exclusions
Date: Mon, 19 Jan 2026 11:05:33 +0100
Message-ID: <20260119100537.463312-2-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Exclude ebpf/rss.bpf.skeleton.h, because it's generated from
tools/ebpf/rss.bpf.c.

Exclude include/hw/xen/interface/, because these headers were imported
from Xen.

Exclude tests/tracetool/, because these headers are tracetool
reference output.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/clean-header-guards.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/clean-header-guards.pl b/scripts/clean-header-guards.pl
index a7fd8dc99f..06ecff55af 100755
--- a/scripts/clean-header-guards.pl
+++ b/scripts/clean-header-guards.pl
@@ -32,8 +32,9 @@ use warnings;
 use Getopt::Std;
 
 # Stuff we don't want to clean because we import it into our tree:
-my $exclude = qr,^(include/standard-headers/|linux-headers/
-    |pc-bios/|tests/tcg/|tests/multiboot/),x;
+my $exclude = qr,^(ebpf/rss.bpf\.skeleton\.h$|include/standard-headers/
+    |include/hw/xen/interface/|linux-headers/|pc-bios/|tests/tcg/
+    |tests/multiboot/|tests/tracetool/),x;
 # Stuff that is expected to fail the preprocessing test:
 my $exclude_cpp = qr,^include/libdecnumber/decNumberLocal.h,;
 
-- 
2.52.0



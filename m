Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66220CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDvu-0000xQ-94; Wed, 10 Jun 2026 04:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvr-0000to-4t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wXDvn-0000a1-RN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781078699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWE2nyb+C8G/FE6PTAS3ec7qSrpBu6hTUMnuaWUCrN4=;
 b=FgooitFoxM602yAbxvcfdpaOxjyELRxxQXV8IyrmHQ5tr4FGfrkhFGxTQZZD0ABX6WTZOd
 Rb4YdEaBl+j3aOtw4YsuD2h8CFi2a2wMu0lDNw5RqLbFotxiNysiLxA1EB/YQbBJ0rJwq/
 sU9i4Og/BCZOouFs9aAtmmec62AqSAg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-BiGkoJmJOkmkjDrpmuUbOQ-1; Wed,
 10 Jun 2026 04:04:54 -0400
X-MC-Unique: BiGkoJmJOkmkjDrpmuUbOQ-1
X-Mimecast-MFC-AGG-ID: BiGkoJmJOkmkjDrpmuUbOQ_1781078693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2A251955F44; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A018195410A; Wed, 10 Jun 2026 08:04:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2F6121E6A25; Wed, 10 Jun 2026 10:04:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 09/42] MAINTAINERS: Drop stale F: from "Overall KVM CPUs"
Date: Wed, 10 Jun 2026 10:04:14 +0200
Message-ID: <20260610080447.1156502-10-armbru@redhat.com>
In-Reply-To: <20260610080447.1156502-1-armbru@redhat.com>
References: <20260610080447.1156502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We neglected to update MAINTAINERS when we moved the only file out of
include/hw/kvm/.  Its new location is covered by "X86 TCG CPUs".  Drop
the stale line.

Fixes: a09ef8ff0a (hw/i386: Rename 'hw/kvm/clock.h' -> 'hw/i386/kvm/clock.h', 2023-06-20)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260603064032.3733394-6-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04eb81298c..14ac72abd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -471,7 +471,6 @@ S: Supported
 F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
-F: include/hw/kvm/
 F: include/system/kvm*.h
 F: scripts/kvm/kvm_flightrecorder
 
-- 
2.54.0



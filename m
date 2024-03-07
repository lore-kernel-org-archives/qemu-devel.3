Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21FBC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHmz-0000yr-5j; Thu, 07 Mar 2024 12:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmY-0000jb-E7
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmV-000434-03
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ulU3moi76qwMOXwAumLT0gT7G9rAMBvSR0pQNGnTWZw=;
 b=INhXPkptBB8RTYknMMBxD6oqNMiagBMstJLM1kJiHn5zCcfsLi8B2/4UcbZbI4t6NCG3Fm
 QVv6Vo4Vi5yEfzvdcf79l5cyrTOIngxGcdvlaVdg5U6RA3yOq7E7riOj8l973ZClx+EMpp
 l75Zasrki2RieVwYJ2ydM2KwqvRf1JY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-gPRTnUy5OKqDhXYeG_o9qQ-1; Thu, 07 Mar 2024 12:43:43 -0500
X-MC-Unique: gPRTnUy5OKqDhXYeG_o9qQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B36ED8007A3;
 Thu,  7 Mar 2024 17:43:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70B53492BDC;
 Thu,  7 Mar 2024 17:43:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] target/sparc/cpu: Improve the CPU help text
Date: Thu,  7 Mar 2024 18:43:32 +0100
Message-ID: <20240307174334.130407-4-thuth@redhat.com>
In-Reply-To: <20240307174334.130407-1-thuth@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove the unnecessary "Sparc" at the beginning of the line and
put the chip information into parentheses so that it is clearer
which part of the line have to be passed to "-cpu" to specify a
different CPU.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2141
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/sparc/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae30cded22..6650248ffe 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -576,9 +576,10 @@ void sparc_cpu_list(void)
 {
     unsigned int i;
 
+    qemu_printf("Available CPU types:\n");
     for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
-        qemu_printf("Sparc %16s IU " TARGET_FMT_lx
-                    " FPU %08x MMU %08x NWINS %d ",
+        qemu_printf(" %-20s (IU " TARGET_FMT_lx
+                    " FPU %08x MMU %08x NWINS %d) ",
                     sparc_defs[i].name,
                     sparc_defs[i].iu_version,
                     sparc_defs[i].fpu_version,
-- 
2.44.0



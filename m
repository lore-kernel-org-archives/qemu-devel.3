Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3701C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHEW-0000Vb-D8; Mon, 18 Mar 2024 13:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHEU-0000U9-Pm
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHET-00078C-Eh
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710784628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlmCn9L0BVplQdOy/vjL33uKo/SSaW9NaQF26dxzgn8=;
 b=FzUvHHL1rEY7mYbYnKnd91o+yJoojRoRjZ41Z/Pbhf9tNvQ1Fqd3kuY9YSzfT/v+puwWzr
 jCsQmxHrCNFIEsNSluHnl061gtlA4l1VORs+XhVuMQ/6yn1JaaBGYmW5NZer78HUlfOHNI
 pPX7c5n3KtF40XWG29O9ZFv4QtMOlHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-ygQnxjG0Nfu5fF6jDceHAA-1; Mon,
 18 Mar 2024 13:57:07 -0400
X-MC-Unique: ygQnxjG0Nfu5fF6jDceHAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C582929AC036;
 Mon, 18 Mar 2024 17:57:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0D222166B32;
 Mon, 18 Mar 2024 17:57:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] target/sparc/cpu: Improve the CPU help text
Date: Mon, 18 Mar 2024 18:56:54 +0100
Message-ID: <20240318175655.756084-4-thuth@redhat.com>
In-Reply-To: <20240318175655.756084-1-thuth@redhat.com>
References: <20240318175655.756084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

Message-ID: <20240307174334.130407-4-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/sparc/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dc9ead21fc..e820f50acf 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -574,9 +574,10 @@ void sparc_cpu_list(void)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670ECD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rur2z-0006jr-En; Thu, 11 Apr 2024 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur2x-0006jj-Th
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rur2v-000335-FH
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712828920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gywRNX+aKWVuwSdGbyoeWVGIjrJ39JGDTzeWj2Aewg8=;
 b=gDMrqkYGgOxccG0VYBobPNHxmdQwHiLqq3qD9ClbtoEC/ht63sAnibagB2Y4DHGRyxjOUA
 bwDxDrKr/3HXZODb0bY5HSqknAdRACirWjpj8EUxSy6nvBqIGh6vQg41W5O1CepiOvGSsi
 xNacYZpjoXsOIstsYOezdTXiMVHLIZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-_tO3crPmMVqotTaEyPjdUA-1; Thu, 11 Apr 2024 05:48:36 -0400
X-MC-Unique: _tO3crPmMVqotTaEyPjdUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B5E80171B;
 Thu, 11 Apr 2024 09:48:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43C54C27EAE;
 Thu, 11 Apr 2024 09:48:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50FBD18009A6; Thu, 11 Apr 2024 11:48:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/5] vl: fix qemu_validate_options() indention
Date: Thu, 11 Apr 2024 11:48:25 +0200
Message-ID: <20240411094830.1337658-2-kraxel@redhat.com>
In-Reply-To: <20240411094830.1337658-1-kraxel@redhat.com>
References: <20240411094830.1337658-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 system/vl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index c64422298245..0c6201c5bdc5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2411,15 +2411,15 @@ static void qemu_validate_options(const QDict *machine_opts)
     const char *kernel_cmdline = qdict_get_try_str(machine_opts, "append");
 
     if (kernel_filename == NULL) {
-         if (kernel_cmdline != NULL) {
-              error_report("-append only allowed with -kernel option");
-              exit(1);
-          }
+        if (kernel_cmdline != NULL) {
+            error_report("-append only allowed with -kernel option");
+            exit(1);
+        }
 
-          if (initrd_filename != NULL) {
-              error_report("-initrd only allowed with -kernel option");
-              exit(1);
-          }
+        if (initrd_filename != NULL) {
+            error_report("-initrd only allowed with -kernel option");
+            exit(1);
+        }
     }
 
     if (loadvm && incoming) {
-- 
2.44.0



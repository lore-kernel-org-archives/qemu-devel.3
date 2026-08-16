Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1BC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIS-0008MG-0e; Sun, 16 Aug 2026 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIM-0008K6-F9
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgII-0007El-Qc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGi09MNmySOgH4WHAvnetZBypHn4P+kRuWbKiz64GwI=;
 b=OlihJaSVVg2M9almatui3iWsutGOoz1oEmClZiPnqiahSjt9/jDpi7gq4U4qZ2lVGXXHtU
 pB00BaawtzsUBdYTelSSC1k077DpHiDBM7knaZe75dki5XXz45BWaStgCGkT+zwstlLB/B
 1nIUBfa1p09PsJxW5UY/TNQMOkmxBj4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-3pxQa0u9OdaGqKc-NVbUPg-1; Sun,
 16 Aug 2026 15:13:06 -0400
X-MC-Unique: 3pxQa0u9OdaGqKc-NVbUPg-1
X-Mimecast-MFC-AGG-ID: 3pxQa0u9OdaGqKc-NVbUPg_1786907585
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BF011800471; Sun, 16 Aug 2026 19:13:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E5681956041; Sun, 16 Aug 2026 19:13:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:29 +0400
Subject: [PATCH v3 02/49] hmp: remove 'vcpu' argument from trace-event help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-2-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tuapEdWlbge9nQ8zXoXUzq/8HC5xbWVmFJeX4uAItoY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguvUS/JPw1iF1nkig4RNlO341jPEpFUwskyR
 rD9JL1Cgo6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILrwAKCRDa6OEJdZac
 5VcBD/40MD+s7tV8Dgv9THlhfq5nt3n8Hb1sOPtL34xRKhk8p6w1vnPLE7XYbzRJzFAzZoQqeOq
 JbZVrBlxXebzyq68HERCuGcMWM0iYY8pNCGIVaNlifNhAJ1+fT1j9DGFBE2kpHbPjrIJWjUJQ6X
 50gjQlGZBPna4l2qwOBW984TGD2hAIg3zsN8ek3GvjWszECuSpkPJYLJTPSIwWSkfXcTgt5XIof
 tMatkXK7h2fEOU23JGbT9dS27gjd1BzqEG+T8Hjj4AC+lNqlJPoJ21iYkPnYrIvhiK9rvxf/Bdo
 y4FWOgc4hWu7EhDdz7kRC3ZoPfgNUs1P6ern4yUYCBqHYNS3ekz3hwO6RO8MUd8x77+gx63RCEO
 E4CcbNqQ/0PO5K2Z/Q4LOFiypo0BE+QjfhrOCv77zofEbym6MKFyH+YQm+qFaH1oJPicOIbySGb
 aZ6i1LqOP9Ienqw+RWYfWvTycF3UaFa6Am2GsLe0SfK/yBqh2M7Vwc0qdSY4vSzBXkAv4OOfE+p
 frTOSTn4dsnx8IqJHcWBh+r9Zfci1aXD9dw0Ziop108XOswO4SY92aosW5EQuptRD2ufWpHcPZ/
 iF09EFrcW43v9URSV3mPwSqrLDOVjfqGQUmxlnb5MMhrXsJ5IVMYLIc8Q6MaGY9DLmwNCl43gDJ
 rEYnT91Rm959WaA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Fixes: 89aafcf2a793 ("trace: remove code that depends on setting vcpu")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands-info.hx | 6 +++---
 hmp-commands.hx      | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c21d..2695ff04ffce 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -587,10 +587,10 @@ ERST
 
     {
         .name       = "trace-events",
-        .args_type  = "name:s?,vcpu:i?",
-        .params     = "[name] [vcpu]",
+        .args_type  = "name:s?",
+        .params     = "[name]",
         .help       = "show available trace-events & their state "
-                      "(name: event name pattern; vcpu: vCPU to query, default is any)",
+                      "(name: event name pattern)",
         .cmd = hmp_info_trace_events,
         .command_completion = info_trace_events_completion,
     },
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 43ff220b5feb..ea4a1db78f18 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -299,10 +299,9 @@ ERST
 
     {
         .name       = "trace-event",
-        .args_type  = "name:s,option:b,vcpu:i?",
-        .params     = "name on|off [vcpu]",
-        .help       = "changes status of a specific trace event "
-                      "(vcpu: vCPU to set, default is all)",
+        .args_type  = "name:s,option:b",
+        .params     = "name on|off",
+        .help       = "changes status of a specific trace event",
         .cmd = hmp_trace_event,
         .command_completion = trace_event_completion,
     },

-- 
2.55.0.543.g5ebe2ebe4ea8



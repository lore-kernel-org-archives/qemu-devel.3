Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53FACDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUH-00075G-PL; Thu, 25 Jun 2026 17:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUG-000756-NQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUF-0003IL-7E
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6V2yhuPz4/MMobnQleMLN8MR601RDdJGRR+/jNhYv4=;
 b=C3JjswEWbP2pcaXDphsr0/tbYbDbTokC01oR0XJYlEOHIJXOABjBqvpxxHthmKkEDk0wDz
 v+k/yKz9NCLYXHg9KRLXCcWNBCB9KW7+PVKDVSiDd4NB5MTD4HEqQsuXZBu6ke7+2YJMJd
 J6Axf3/kckvsCPi9MU48ZE7PhtfpP3I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-O9uP5e5uN6GllBALVIT58A-1; Thu,
 25 Jun 2026 17:19:47 -0400
X-MC-Unique: O9uP5e5uN6GllBALVIT58A-1
X-Mimecast-MFC-AGG-ID: O9uP5e5uN6GllBALVIT58A_1782422386
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3180A1955DA3; Thu, 25 Jun 2026 21:19:46 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A506F414; Thu, 25 Jun 2026 21:19:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:03 +0400
Subject: [PATCH v2 02/39] hmp: remove 'vcpu' argument from trace-event help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-2-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4/VTl0XRiKNS2h2lRzLT/8mJB7AwUmWzwykGNJG/70k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcO5xqUyq47qhCo7KEVhGTUJWnsqBkkWTtV
 feQlyB5KNWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5Z5/D/4myA5Rje8n5zfrX2MLjyJD7KugFf9XzmRlGhQumV4/8Wk06LnCHwuBJZYu6PT50njfrKB
 GKpCTRGdhDLlBDAYIfndLEEnFipQrxUNQllM6QuQtd1fVzp9ezNXK6nFUhuNv4Lwdq4un+wSAD9
 2A8zq6uGPEBbXA3SV6qGGfDkk4F090uAltfIzhAW47vg+0ElFRFpLO1HL5ZN5PGClJ3KJY2iZOq
 Gee3ihKvHByU1LCOA2fw6qxvheDBfyBB6DphzpYP1b7fdrBtYmmdouYJVEkZe6r8PUy2IzmUtNo
 s9EjuxWDexuYThd1M5maaTzrVyZrKri5UDqlVrqzxdoTR0STC3Oi3FlB0OPyZ+DHB2+1PBv9sFw
 /tH+1cl4DaQXBwOx6I/3q9n9i+qdE5qEdiLQKX1roJlfjgEanMyMpZJgIQgCRiyJb1dQAIuCef/
 57ysgEE6Wq+tm8R3opsFfFuFS1JRwXXppzmvcCrBYHY4ho6honow+orIS4RVqON/hmX5+568JKi
 PHs9dKPWO0SmiyKL0UIXFGRxj+xpyXMky6EVD/6i51pg6/0T+Q2DYP+mnIni8K+77KYl6FO29fs
 ndC8VReF7gIFnW4CgkjS8wPx/vCaom7KGJQiaCWi6NvNrozFw3ZcMKJMEU0OVl0TfyYCsUpHXjW
 sxSrgGuud5P6Daw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Fixes: 89aafcf2a793 ("trace: remove code that depends on setting vcpu")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hmp-commands-info.hx | 6 +++---
 hmp-commands.hx      | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c21..2695ff04ffc 100644
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
index 7ae2468a3d9..2b658bbbf28 100644
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
2.54.0



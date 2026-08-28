Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53411C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03P8-0004r7-1d; Fri, 28 Aug 2026 16:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P4-0004ZL-0k
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P2-0007za-6E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nPTopix6d5kW8UuI4pehCE3kYuo9r6YvCWI9U0lNcc=;
 b=ax90URNkz3FlOnEYKEK6rEWbaS/SSuZR6JfiAKtA1E6B+rAWLOBdMZA+8420QSNzj/YOF0
 PDBsYJtTIe94NqkECNQ1S9ykjQ6duIpyNP5IrLX0atFG9CzBvWeM0zOgmCjbuLQMMo24i1
 trzXWkZzFO3V2VMwFCzbLv5y/n2QUeA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-17mO-0pNObm9LJVZVVTrPw-1; Fri,
 28 Aug 2026 16:42:13 -0400
X-MC-Unique: 17mO-0pNObm9LJVZVVTrPw-1
X-Mimecast-MFC-AGG-ID: 17mO-0pNObm9LJVZVVTrPw_1787949732
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F49518C0FBD; Fri, 28 Aug 2026 20:42:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86C9F1955F0D; Fri, 28 Aug 2026 20:42:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:42 +0400
Subject: [GIT PULL 03/50] hmp: remove 'vcpu' argument from trace-event help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-3-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cESNmYJbGu1w48oPJkUcdj5xdrhS7MFa4BAqq2pmWUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKT29+ZuhMXnKM7AvhSwML0VvK0czU6v6hTu
 +Z35L/PyVCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5V9PD/9vCq9X5EPQqWH1WcSrAvRvClL+9bzTFZR+jsuufpvOo64xnvxwK1y5FFnIFMaf56G4YgC
 SOjOG8ELQ2Cj0gTti2JieJMZkQ3JJMckiAPzwSTo4tN1Pr2JP1Gk986pVhNxB6dgJrvugQ/WBMS
 BjrgId+G3A22fkZn0wipe2gNgwl3hilsz1mTZFHO7r7dLpLIZukTqUrVom7wHlx0rrbxX8opf7B
 xfs6+hSo0xiM8ANjGwrINWCtxsoq/Kx+5dXiSts9MRVDi0pGIZuyzgQ7Nj+WXCv/Hj48ROuWT03
 8gBcsprmbW39w2PqKxUzvCWrOJ0vBIhAybH2Zse5RXuwALnYKoBXJDLXuaSeLgLvejF+C/bcUBq
 I21iyOrC8t0oUP3+8pbYnB0FY+Zq3vOz8EuDnua7YhpbaZMRCJNKHgQix7ahx6CyjBcYdVpuNcs
 lRSJTTz9wDwKdpLzhGHPmVPl4eqMlRFzkDbdkQOkgyeQdSHspSYEo9vyL+gOWNlcmiZxMOcwdfB
 ag159mmAUgj0oHbTwVYF7cSIeqAdHTzlEjqgvgKeW3ZUxtpyAye34EiGN38TG7OzmNbTzgJxQy7
 T7NjV86Y72V/0LAY46jqYB/kte2qJlXGMmHePu07C14pos4t1vmUTYoqfMhz6zErq+i5sKS+mMa
 IDoOq0hBodHNHhA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260828-qemu-no-hmp-v5-3-9227de146347@redhat.com>
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



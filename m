Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239B1CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXB-0004Fl-Ax; Thu, 15 Oct 2026 07:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX7-00040D-OL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX6-00049Y-9Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRRYIQzBm9AdCh/M/BnHxN2UdPWPfu66Z4pmlnKzGGo=;
 b=VmlhWiWyxMBKRdtTjDTuozB7EoDTn2fUZZUt6MAJNKqE3KLrBer9Ij+XO0/5Dc3pWbvHv9
 f1XKDIJv2S99v0qkUXdoYR+iQeG8Ni0rFmtftlZ476VuAxOmFu8b54CwI6mAIDGqIn6viQ
 zNT9cP6Zu4mHW2rkPSjv3z27dk1dl3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ccjKyR8EOKetrAYyUe5dRQ-1; Thu,
 15 Oct 2026 11:21:55 +0000
X-MC-Unique: ccjKyR8EOKetrAYyUe5dRQ-1
X-Mimecast-MFC-AGG-ID: ccjKyR8EOKetrAYyUe5dRQ_1792063313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCCB21955F17; Thu, 15 Oct 2026 11:21:53 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52AA51800677; Thu, 15 Oct 2026 11:21:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 16/21] monitor: remove obsolete/redundant exports
Date: Thu, 15 Oct 2026 12:20:39 +0100
Message-ID: <20261015112044.1999748-17-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

qmp_send_response is only used within qmp.c so can be static
and monitor_data_destroy_qmp no longer exists.

Fixes: b723eeb815 (monitor: move monitor_data_(init|destroy) into QOM init/finalize)
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h | 2 --
 monitor/qmp.c              | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d0..dfdb8fb8caa 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -122,8 +122,6 @@ void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
 
-void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
-void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750..ccb39a48d4c 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -80,6 +80,7 @@ static MonitorQMP *qmp_dispatcher_current_mon;
 OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
 
 static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
+static void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 
 static void monitor_qmp_finalize(Object *obj)
 {
@@ -242,7 +243,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 
 }
 
-void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
+static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
 {
     const QObject *data = QOBJECT(rsp);
     GString *json;
-- 
2.56.0



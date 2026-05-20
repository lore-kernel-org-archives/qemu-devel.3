Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057E8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoo4-0006sN-7q; Wed, 20 May 2026 17:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoo3-0006sF-9i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoo1-000452-Tv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nT4X+Ax/crkv5jiDNFsYV7uISWRVrL55cv0JyHkZgg=;
 b=Y+0y0ak+IMoHO8e4d/b743HVc7syY5xj8zw+DAs9Hj7uPX35auDcLBBvJYqcFnXa8emaJV
 CYajlXHc8Z3HXcRPV1HBb2Uc3DP7w4LRsplMD4QIz3WwRNJ6AVjKRG/wkcU+60dt1uCN7O
 qqaQMoshgTe8fZ4hvyKsHZRXpXH/mCc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-IW2NaNIDPSyiS6H6cz76aw-1; Wed,
 20 May 2026 17:50:19 -0400
X-MC-Unique: IW2NaNIDPSyiS6H6cz76aw-1
X-Mimecast-MFC-AGG-ID: IW2NaNIDPSyiS6H6cz76aw_1779313818
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B611A180034E
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:18 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61C9130001A2; Wed, 20 May 2026 21:50:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:03 +0400
Subject: [PATCH 02/40] hmp: remove 'vcpu' argument from trace-event help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-2-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DmuatJwycw5b+Kgbt0UY/vBtUV9Z7+jspuiV6gjgjV4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCTQCjmTRZs61XOVowhBTHS8Gv1gBdRu3y4
 JRqm34Yw12JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5eycEACD7bvMP7+nYsCK89kME0Y/rqOpnCEvv4THRcYFprqWHt991FhTVXETa1dgv+dSO8gKJPg
 l+3ubINCO16HcirBB0Ffvo52DGhugf3EkPkDs2I93x/xAV51XQxVZnhQHy+MU3cDgOp3sJIlTJd
 8KEg/LEdzkd/39IuTwCBr5cZ+OnPw1s7g0ggftex7z8gPmPeHYV+WZ8LQglOywe5pcgN0b2ErT+
 h/Z4EyxQehY4a6eJapF6/Ug875dD4jMYDA5VsulWvHLQyzyBdMyhrwU2OX4TAUc/K9bHKvZCs2O
 UE8ix8mcBNVTNqJVQWs+VNQ4vYIKKU1KpPzCUX86dm957obr3XYx3zz/H8jG2g3C0DVtVSoTKKE
 R3K1jOzwL/Kpp72NyWCRV/qE8QOXAJOR8h4YE3/kT88wa7U/hkk88ofCWlUNuBfV0OaofIVpf57
 gDDbEU9jxRhRqMdzCboRm8N6OfPX7ANnJ8wNUoEyrfYC8yaJGeY23au91uUXpI5x8W3JUEIPh8U
 VJjOFux4/46BNLCVM8QYI/jOEPngsBNjuJXykcmyYoTMsEBIMzbMAgGlIngrVYGIlu64XyYE6kZ
 j2xtiaCGGQ9J3fojqp4H647uZyGQ8uotBswDB31BqVgFoCU3X6sWdA9x1UlMIDRbpGz8wPhfNHL
 vH/d+mHRIQ8ZRkQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index c3a1a95c5fb..750a2f42a80 100644
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



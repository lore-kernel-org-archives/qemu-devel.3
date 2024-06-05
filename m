Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7FBC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Bm-0002mh-9X; Wed, 05 Jun 2024 19:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bl-0002fZ-B2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bj-0005xc-O0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgYXT9TqVXX9/BRZFmbWBgRNk9wpbHrKyLXkpZBaJss=;
 b=VqTR4Xs6oE5iHuDABmn2/BjUNETIh10UWLCmvHaPMNn3RB9mPL8hSssJzoVUudTUqOvcEu
 KYnjPrG83T1eqw6uaDYMZYwbkeGstuhIpqTdE4hYQY3YeTxE1ioe3duGx+xuZJq8vF70mj
 M/ObOb7N767nBdL96tM6X70cVwT4MfI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-BUjRHvrkP-CR60Y7VvTODw-1; Wed, 05 Jun 2024 19:37:02 -0400
X-MC-Unique: BUjRHvrkP-CR60Y7VvTODw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dca0dc826so240591f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630620; x=1718235420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgYXT9TqVXX9/BRZFmbWBgRNk9wpbHrKyLXkpZBaJss=;
 b=RzGPy/wlILB7/YTuWgz6U41OjtTLRzYFhV38klpwj8AwvC8RhpYiQPVAzIxvMBvphr
 0CjwtljwfDlYCj/cBgGrD/RttgoW1Ie9wlHS61fVHZDBjvySSnewLonaTKvhfU1tleQv
 aYJReLdu0M3fupqlnA4rzwYq6kvPaP7gTdAGlwDaJfIUROmiMwTC6qV+5npSSaPb7rLR
 qlUvWpXp7JipBEUd1DGIbW+JRfrcgQpMCG0fwj+T9utWnQ6DhWJaJ66BOQXooXi9I9ln
 xEKx9pkEH1cfbfr2dSxGOYD8j9FFnrFtc2MJE1dmGih31yr+P4FuiHqE+CtiN9cSq7f2
 0nEA==
X-Gm-Message-State: AOJu0YwkbzqHmHykyoLfo3ivSmD311zvQSyG+N8QDLMNKmv65vA0BQFp
 AcM/0x7yq2DoHYpbR3VuEBLYw+K090grtFnUb/W0HozgZRB9+OgWioux1Y/fJtIYM0esUED9ACO
 bLQzUqxW2/yE9IxJ/nIF9wCLYip5fe4hj6aVLv9gSnEuiZycfihlSvcEdbmozWZ48NU6Y92kXfH
 asTeZTfKeNgdl+WpnHHW/wwtnrwAvVtA==
X-Received: by 2002:a5d:64c4:0:b0:354:f7a4:7862 with SMTP id
 ffacd0b85a97d-35e883383bamr3125921f8f.19.1717630620303; 
 Wed, 05 Jun 2024 16:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTn7lpYkgyQDTjc4R8v7mottzHj4Tj5yDZvbrsiaRQLlK1AuJmylfDT93c/JbXxLtTg0iWrQ==
X-Received: by 2002:a5d:64c4:0:b0:354:f7a4:7862 with SMTP id
 ffacd0b85a97d-35e883383bamr3125907f8f.19.1717630619852; 
 Wed, 05 Jun 2024 16:36:59 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80582016sm7121466b.20.2024.06.05.16.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:36:59 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:36:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v3 37/41] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
 shutdown signal
Message-ID: <7572581002c9b8a74b4c4cf4f775652321068e56.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Emit a QMP event on receiving a PVPANIC_SHUTDOWN event. Even though a typical
SHUTDOWN event will be sent, it will be indistinguishable from a shutdown
originating from other cases (e.g. KVM exit due to KVM_SYSTEM_EVENT_SHUTDOWN)
that also issue the guest-shutdown cause.
A management layer application can detect the new GUEST_PVSHUTDOWN event to
determine if the guest is using the pvpanic interface to request shutdowns.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Message-Id: <20240527-pvpanic-shutdown-v8-6-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/run-state.json | 14 ++++++++++++++
 system/runstate.c   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index f8773f23b2..5ac0fec852 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -462,6 +462,20 @@
 { 'event': 'GUEST_CRASHLOADED',
   'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
 
+##
+# @GUEST_PVSHUTDOWN:
+#
+# Emitted when guest submits a shutdown request via pvpanic interface
+#
+# Since: 9.1
+#
+# Example:
+#
+#     <- { "event": "GUEST_PVSHUTDOWN",
+#          "timestamp": { "seconds": 1648245259, "microseconds": 893771 } }
+##
+{ 'event': 'GUEST_PVSHUTDOWN' }
+
 ##
 # @GuestPanicAction:
 #
diff --git a/system/runstate.c b/system/runstate.c
index 83055f3278..c149b1ab4b 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -587,6 +587,7 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
-- 
MST



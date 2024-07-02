Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA332C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwx-0003vM-7k; Tue, 02 Jul 2024 16:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwf-00023r-Sk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwa-0008Uj-ND
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhLUD4bgFXykNLby5YqUbG3vAr/0cDl4XOSKHnOq4eQ=;
 b=ZX5LaYF3GDYz8/tMM202q9hwcZ/s7aKpjB+u98lTs28jkIL7ONBFioQaacKeyeo1Q/KUdq
 2aSw1kDop0upMSOrigR+9JowQV4TiA4Jg3xVvGGTLIPL/6DDH3fiNFgZtP4SglKLObCd6p
 BgE4sftGwCKxB9V/5qLMDSqWpThlM6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-x4tXvbeqOVSEr-e6t2Zf8Q-1; Tue, 02 Jul 2024 16:17:38 -0400
X-MC-Unique: x4tXvbeqOVSEr-e6t2Zf8Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4256b7702a5so25779035e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951454; x=1720556254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhLUD4bgFXykNLby5YqUbG3vAr/0cDl4XOSKHnOq4eQ=;
 b=Cs6Kqq3ASQuqGVen1HOPWwdEZXWbwqn1LzFoPekxjJicWzt2u/bb4Ei8orHndyZJtt
 4B3T1R+exmfZn3ioJNeh4tF1KnvOXwUXvRKUEJnDDJ2fw4WBVg4NWCaeWMZ05of0C+XE
 3H+/nqM6q10A1wM4c7l2cyKNFOLfIS//dE9N+OAFm2MPaF/qy57zemdn8Ryz07cZc/zi
 o15BsBs1vusMRoP6wibRvDnDYHPXjEISgOOQVm+RG3oTG708ghIMd6tdQA+ZHFv1lnhx
 wFVlmaT+DAWvYytMeIGB1rnA+kUVj/QYaDI1lSrNJPmgY9g/GVSdjjbWYs8bhU1UUf/p
 YXqA==
X-Gm-Message-State: AOJu0Yzw13wgy+2C+LIpF0h3PThBAzfffnfgDSqlcdSg3efTfIX8y+L2
 DHVsajQzNiPfHfdWPgwdayLQxeA2e2oJ4PYXMIU5WvS4JjWPtmgsk2P+St8/DpyH6RnunEUgzxJ
 axwpIjLyN6fM9Jgiq3iQaYO0fXW420HZveRG9f28/BbiAP0DvkuJ3iDrrEV+5CcM48jQrxEuC6M
 TPbImHjBUudpa08EJ+b/K6w7HC256JIQ==
X-Received: by 2002:a05:600c:1c9f:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-4257984ca62mr84147995e9.4.1719951454005; 
 Tue, 02 Jul 2024 13:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjWVqDUYiuFMy3/AjUlK3hu5rfG9+l3cyyTun2CR6PBoqsEbbQ3Yxk9bt4VmoCy7daRtOv8Q==
X-Received: by 2002:a05:600c:1c9f:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-4257984ca62mr84147745e9.4.1719951453484; 
 Tue, 02 Jul 2024 13:17:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257bc89832sm139171645e9.42.2024.07.02.13.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:32 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 34/88] pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic
 shutdown signal
Message-ID: <8db1f7be788b23f8eca189fe4546298ed387e9cb.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index fc49fd3e61..c833316f6d 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -586,6 +586,7 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
-- 
MST



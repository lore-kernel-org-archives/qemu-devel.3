Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSFw-0002L4-Pp; Mon, 14 Jul 2025 19:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFt-00023N-AX
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSFr-0005NL-FO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJuqhChPRmOX5xRXsCyEYU8+IpMhen8QYBWBgrWseb8=;
 b=CfwezSMjq9t7neOiT1LrO3G3K+mJadIGM3EvdOVcYzQKKWD7345O6W+YkoIWtKQx41oXaY
 NBVDECu5zobHeQx2jxImi32ELrBcA3fKp8DbEFTkBUZUjplXeracowE1rhPi3f2Yqpu3QJ
 dFNQZ0I3CGcODw9dPS0gMTDkwunc5Ms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-wufOlXSNPWeMpxNn2lG5Rw-1; Mon, 14 Jul 2025 19:06:37 -0400
X-MC-Unique: wufOlXSNPWeMpxNn2lG5Rw-1
X-Mimecast-MFC-AGG-ID: wufOlXSNPWeMpxNn2lG5Rw_1752534396
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so2162776f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534396; x=1753139196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJuqhChPRmOX5xRXsCyEYU8+IpMhen8QYBWBgrWseb8=;
 b=Jftl4E9cVCkX45vX6SsL8J9L4P8uneKFL9Hlq0mTamIZchovFwabjfefy9t4VempVV
 vu8SylR5Oz4z2hTl7is7EJNf4iCKr/TPG1N4hJmei2Wnu3TtBhL9GxZvC204w1zPQuBe
 cfpxsfmTGcFW0EsmAhw6wPW806DpIY89EjGeWjTz5lZPLOBe9fuaSZ3/T5465DaHViDp
 2mSqNlUpeXmY4VPy3JtQW6XCd9Ti1J9Y9xyNzNpBtYhH4Ir987AOToSDowaHBqm4ZKjF
 SdgtJb++myAUqVAmlA6we7uucxINCpuiuqD7tFj3V4+JlxC+aFPaiKjt9fULP7B4EGWT
 UD6A==
X-Gm-Message-State: AOJu0Yyk/yCkbB1B4SFI9oSVQTxz59uiBLWKG+QB4ohsJnr/Q0Y/2crj
 6rw7wN6YwOUyCZkPIE1AvB7ooOpVeHr0EbRTb5JFrkosNpkGg/pzaDzkKtAJEUlobAp7Y58QeSo
 +014kGmWBH0aXmr1jqde0eqAQjHRPHf+lB06wzTZs8RbJZZ76TVKmLJqUfqKvCwJqMX5fQF1Ryr
 J7A66l9p5oyZMbCBfyoYFWBVXlSfumvfSAbA==
X-Gm-Gg: ASbGncttq0Ookd6jTZC081JjHMMwLFb89z1kYIIhIV4VAqOVqdSrhwX3vvQ9HV+lnZj
 KKD1rgvtx1McrqAnsPGei/+lYpIOGhid1/VWpgOuy4UuigYdIPy2Wtcb8wyDHkryx5jX+NTviQS
 1S1nfllkTLdIX1Jw77pV3pIQnuQ9UYp/mmxhfanBR1JO2FSOc+INkGnpn5ptC3pODQclqxzKEBt
 pQKEDf6sadOazarVTtL86V2XhV0gLhyne5PJLCsKjj/cd7piYFBmxkYiogyqYMHQxm6EeijcVoB
 pSlPqC06mYZOKPFAtLpu7GmXnvsqZ97+
X-Received: by 2002:a5d:60ca:0:b0:3a5:2a24:fbf5 with SMTP id
 ffacd0b85a97d-3b60a15700amr197361f8f.18.1752534395907; 
 Mon, 14 Jul 2025 16:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQOFl1MFDKvX4Qy4Ii82y2NGJiGxSDTtb+K+1NBFlF1rTvbUllIyCQwqQhRNN+ot736otvDw==
X-Received: by 2002:a5d:60ca:0:b0:3a5:2a24:fbf5 with SMTP id
 ffacd0b85a97d-3b60a15700amr197347f8f.18.1752534395475; 
 Mon, 14 Jul 2025 16:06:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e135sm13638629f8f.72.2025.07.14.16.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:35 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/97] softmmu/runstate: add a way to detect force shutdowns
Message-ID: <260f826cf8f2fe54f3cf4de541d761cf616e15ea.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

This can be useful for devices that might take too long to shut down
gracefully, but may have a way to shutdown quickly otherwise if needed
or explicitly requested by a force shutdown.

For now we only consider SIGTERM or the QMP quit() command a force
shutdown, since those bypass the guest entirely and are equivalent to
pulling the power plug.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Message-Id: <20250609212547.2859224-2-d-tatianin@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/runstate.h |  1 +
 system/runstate.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a517..b406a3960e 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -107,6 +107,7 @@ void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
 bool qemu_vmstop_requested(RunState *r);
 ShutdownCause qemu_shutdown_requested_get(void);
+bool qemu_force_shutdown_requested(void);
 ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
diff --git a/system/runstate.c b/system/runstate.c
index 38900c935a..e18eb8cb0c 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -437,6 +437,7 @@ static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_exit_code = EXIT_SUCCESS;
 static int shutdown_signal;
+static bool force_shutdown;
 static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
@@ -457,6 +458,11 @@ ShutdownCause qemu_shutdown_requested_get(void)
     return shutdown_requested;
 }
 
+bool qemu_force_shutdown_requested(void)
+{
+    return force_shutdown;
+}
+
 ShutdownCause qemu_reset_requested_get(void)
 {
     return reset_requested;
@@ -805,6 +811,7 @@ void qemu_system_killed(int signal, pid_t pid)
      * we are in a signal handler.
      */
     shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
+    force_shutdown = true;
     qemu_notify_event();
 }
 
@@ -820,6 +827,9 @@ void qemu_system_shutdown_request(ShutdownCause reason)
     trace_qemu_system_shutdown_request(reason);
     replay_shutdown_request(reason);
     shutdown_requested = reason;
+    if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT) {
+        force_shutdown = true;
+    }
     qemu_notify_event();
 }
 
-- 
MST



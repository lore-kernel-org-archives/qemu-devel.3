Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0CDC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRf-0005zA-NE; Mon, 23 Jun 2025 16:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRe-0005yE-4Z
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRc-0003UY-H7
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNWaOvix6j1L9tvmAvEpaUfwzb48imC5jSimySunfZg=;
 b=JRAGU6VrVZTBXRNmMouO0+DuPSrNRc8ssJjk51NcyDQYp0Hu5WZvswP81EAeM5CC/7qvHf
 z6HJx91YLZM5QVDrT4ojaU6OlE+wJHdLXRJznRpUXBRYbQq7ZU/s3w2PDyRzo8Vzn733VK
 pHHp5pcHJQfwH4gAknRsPY+9Uc1K/LI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-7zBEaCfuO9WZiMXfxrjazQ-1; Mon, 23 Jun 2025 16:07:05 -0400
X-MC-Unique: 7zBEaCfuO9WZiMXfxrjazQ-1
X-Mimecast-MFC-AGG-ID: 7zBEaCfuO9WZiMXfxrjazQ_1750709225
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb0e344e3eso40878026d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709224; x=1751314024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNWaOvix6j1L9tvmAvEpaUfwzb48imC5jSimySunfZg=;
 b=oLIUthQ7CK0pVBZZfAqI2Bsw7ZNw1mo0qZKKt1IJoDmDSGLbiFOGE/aMDDf8jWe7J1
 b+oP5lgPK+Xfqz7MUkO9zmuHYzf151v9Ly5uWtn/gMwmcWcFyDKClmJrz/vVwtZA4xhZ
 0exYLysOAnDxq5/WX38oN5KQdvBHKXeSPJNCY/XC1Y87CxyvdgR2IS/bsxhg/f4Ob2/n
 yzS7KMzfSGnxOsBQuYl9mI/dMrCNVRrONmR2orItbWMHq96RdPwWncd09kaBCcBpYAZ0
 vLUOp3yrOaNbTcs3jYtGowkmn5tS3q7WiyQf5ss2EjCNDIN/wGKXzEpmcqZLBNO1RJyV
 xaLw==
X-Gm-Message-State: AOJu0YzV7bNTY573FrK/DUgeLH05JyHtPQkQFJ2/MDus3B4rcV0LHp8r
 FTvgoEJbZm5ZFANNNi2iN+nlDFnXjpyQ9qkcDurt8/JPK9q9EAb3RADw0RVSfsFDieSpl23f+YH
 zZf5Ej8/lkX21dqKlj0fXb46xzcwD1BGd2RF/N5s60551Dqbs9rjPsZXmyLbQ23GhxUS+8jc1Oi
 W8T4M6yBnbCd57GyVxUYfKl0ySoC8KWAEVWAYngQ==
X-Gm-Gg: ASbGncvz4G/nBjKrPsPt0jDArM1vlccaGLKJeREr8+40s1aAJYSktuLIGl5cFG264PB
 GjEiKbxo1XOH3hNxq8qij7jGl1jFkfheL+546q+ax0ityNjbUnm6/qNofwjxl9UFsbJliIhXasr
 CvigBMburXuOWnp+hRvVrNSugIWXgCBvKEhe6vPwWyS+BWzsHL7oHZ0wVqdKP/mdaHdF8ko5Dma
 1QWxkb+LgPgkSLu4iLG5FedXUMXltevlocY7P8SnU8MxY0d8DIvT3Xpnuf0JKkXqcSMdQn7HiDd
 WTJgwfy1YYc=
X-Received: by 2002:a05:6214:e8c:b0:6e4:2f7f:d0bb with SMTP id
 6a1803df08f44-6fd0a46a4c4mr233970206d6.4.1750709224553; 
 Mon, 23 Jun 2025 13:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv2pBGphPlBx8e2SR5g7JEOIHzLeXyVV49tws6HAcqgMeKMzI2v5EJ9TAQE8dWf1boLZzWNQ==
X-Received: by 2002:a05:6214:e8c:b0:6e4:2f7f:d0bb with SMTP id
 6a1803df08f44-6fd0a46a4c4mr233969556d6.4.1750709223838; 
 Mon, 23 Jun 2025 13:07:03 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/11] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Date: Mon, 23 Jun 2025 16:06:48 -0400
Message-ID: <20250623200656.1882674-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

If a virtual machine is paused for an extended period time, for example,
due to an incoming migration, there are also no changes on the screen.
VNC in such case increases the display update interval by
VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
to VNC_REFRESH_INTERVAL_MAX (3000 ms).

When the machine resumes, it can then take up to 3 seconds for the first
display update. Furthermore, the update interval is then halved with
each display update with changes on the screen. If there are moving
elements on the screen, such as a video, this can be perceived as
freezing and stuttering for few seconds before the movement is smooth
again.

This patch resolves this issue, by adding a listener to VM state changes
and changing the update interval when the VM state changes to RUNNING.
The update_displaychangelistener() function updates the internal timer,
and the display is refreshed immediately if the timer is expired.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250521151616.3951178-1-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 ui/vnc.h |  2 ++
 ui/vnc.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/ui/vnc.h b/ui/vnc.h
index 02613aa63a..b3e07269bb 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -185,6 +185,8 @@ struct VncDisplay
 #endif
 
     AudioState *audio_state;
+
+    VMChangeStateEntry *vmstate_handler_entry;
 };
 
 typedef struct VncTight {
diff --git a/ui/vnc.c b/ui/vnc.c
index d095cd7da3..e9c30aad62 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3385,6 +3385,16 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = vnc_dpy_cursor_define,
 };
 
+static void vmstate_change_handler(void *opaque, bool running, RunState state)
+{
+    VncDisplay *vd = opaque;
+
+    if (state != RUN_STATE_RUNNING) {
+        return;
+    }
+    update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
+}
+
 void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
@@ -3421,6 +3431,8 @@ void vnc_display_init(const char *id, Error **errp)
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
+    vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
+        &vmstate_change_handler, vd);
 }
 
 
-- 
2.49.0



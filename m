Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3633606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1rIKfx8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=siizHUR/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYvd-0000KL-GH; Thu, 12 Nov 2026 12:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvW-0000Cu-RM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvV-0001aA-4b
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxcmNl25CjGsVM19IsP9D3aNHAsPVuRi0VAmFsXy51U=;
 b=E1rIKfx8qlOniDw6JVStW9xO6aM/V5WHc4pfEk05Kzv7O+GfVtQnqpPJlPbg7x+pKvXdXc
 22MYpPslb2VxAX+ZO34q3wFZcBV264LCu4YxVNJwH6qIHiihYfeAn1Jhcks1P3UPTkl3MU
 nezPKuK4pGO2wz2DSEotCNmW9ohjrdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-iozrRHH6MsGxWxD6dCAgbQ-1; Thu, 12 Nov 2026 12:49:30 -0500
X-MC-Unique: iozrRHH6MsGxWxD6dCAgbQ-1
X-Mimecast-MFC-AGG-ID: iozrRHH6MsGxWxD6dCAgbQ_1794505769
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a35e1d2dddso521435e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505769; x=1795110569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JxcmNl25CjGsVM19IsP9D3aNHAsPVuRi0VAmFsXy51U=;
 b=siizHUR/AAoTyEXr9mcMXoycsN+6PyTngxUTwAgzNnHAmUguhkV2o3cFizpTwpdZ3h
 k910pkIvgzQdDvUjK61iyw+Ci8R5UErccbcEuziZ+MBJwAQ27zrIUW6VCXAh0oUvVIM7
 BbaR0yIotEhQz6Veb8gq1cs1taRwBapuNJeoZhad1TnVf/3bSN7UoEDsH1xU0AhzscH5
 31KlqozNcw7HMqN4DGoRJv2D/iKCdQ79s+nJGA2jOqdJ0YXyMdzSc/Da7GNNmjRby74V
 GwzHFJUGHpfrxqN5O+PWdWelsIkUwYRuxquf1zuxkF82gPMu8Wdd2TSMGx8aY2bZcyPY
 hDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505769; x=1795110569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JxcmNl25CjGsVM19IsP9D3aNHAsPVuRi0VAmFsXy51U=;
 b=bLkcR7icsaJhqymlweMKZyDZYOWsZRGAWfU4kh1vmGmTy4wzl49f/xp1sLOZ8iboIj
 M/YXPkCGza2yxLgbzIThl1/AF+2xqalBirfnAhROaeuN/eoJjnKlgD+qOBPTvfhAurIr
 lOFrZ7XHHefX9u2CYnBV9J9ACFTX2vi2lus2j4iBFAW0wVXAgQXm35+wIZo/PWLKk8eo
 JgSNIfmqMsYkbmG5ju089tHp+qV4ZReXjs7UNwva41yZBCb2JUkbuT+b+RbuVs5cXxgt
 XVrMcL0wC3TEKJQ/4o/Q9El8BX3L1MF2kRkihado4mFvvPdHRBWnaqXBctbLu4kQ/T16
 WDUQ==
X-Gm-Message-State: APuU4Z9rkF+7/fcI18qwr7Xr8iZPGqOkJDLHhp+aHn6+EHFyYtxuRI3Y
 25QCYxd/s+yHYBACza0nOrEov9xUsk85oPVr3ZGShsrl6ZanQdwInVQMxv/ZlUBmLkUGZ8PGxP+
 Vl2wjewrAyZbX9zPA5DGmzQsFKUfmNIyI+30JGKlZKJBvLdaw731MwJq0YbxHiv7z89iWMo1OsT
 lLiZeP9mCNKdtEE+tPN6xK2Sg6Uqq+RY6KkOULpPLMGA==
X-Gm-Gg: AYBFou1n190zXoeZPrFlnI1huqT/BQt0BZyWJJ8rcxap+uxII3Rkr8zvzDZnx8iXrCm
 AMXx6/QE+WE+oPTi2fNUFnwfsQaopAaOwQHRs/sTr2PZTSBcF9ZKJc3aBtDSW2TaBJWhzeaN8Lh
 aDctPquufDl0d7q/IC6m/HcjVtQtS4zbHDxzydroUbinhwrWC/hrFmwBmRiyqjj4IF8TeKctP/p
 IB/SX1w0AA3THkE+WOkujkUAf2VIN8fSabzUmhr5rQq4C2Rh6Ii5V1RDua7yWB1StnOHA+Xphui
 7fI0nx/xiWpIMUbLJ7Fhia+60V9q6o785gG5QHvTj3dASRmRXHBFxwfzNwYpqrLNjR3EXG563ca
 sRBnaO+CnF65tkqDSu3ueVLsiiAXimZCXBjHIdWEbcdInWQ==
X-Received: by 2002:a05:600c:46d2:b0:4ba:73f:ef5 with SMTP id
 5b1f17b1804b1-4ba093b1bcfmr116646155e9.34.1794505769077; 
 Thu, 12 Nov 2026 09:49:29 -0800 (PST)
X-Received: by 2002:a05:600c:46d2:b0:4ba:73f:ef5 with SMTP id
 5b1f17b1804b1-4ba093b1bcfmr116645745e9.34.1794505768651; 
 Thu, 12 Nov 2026 09:49:28 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba09536ebfsm144820625e9.5.2026.11.12.09.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:27 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/9] hw/usb/dev-mtp: Reset pending write state on cancel,
 reset and error
Date: Thu, 12 Nov 2026 18:48:59 +0100
Message-ID: <20261112174907.158825-3-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pending state (s->dataset.filename, s->data_out, s->write_pending)
was only partially released when a transaction was canceled, the session
closed, the device reset, or the write failed. This left dangling
pointers and leaked memory.

Free and clear these fields consistently on all those paths, and route
the early error in usb_mtp_write_data() through the common cleanup.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index bc5a6f0891..1c14770a9c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1236,6 +1236,13 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
     }
 }
 
+static void usb_mtp_reset_pending_write(MTPState *s) {
+    g_free(s->dataset.filename);
+    s->dataset.filename = NULL;
+    s->write_pending = false;
+    s->dataset.size = 0;
+}
+
 static void usb_mtp_command(MTPState *s, MTPControl *c)
 {
     MTPData *data_in = NULL;
@@ -1282,6 +1289,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         trace_usb_mtp_op_close_session(s->dev.addr);
         s->session = 0;
         s->next_handle = 0;
+        usb_mtp_reset_pending_write(s);
         usb_mtp_file_monitor_cleanup(s);
         usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
         assert(QTAILQ_EMPTY(&s->objects));
@@ -1504,6 +1512,7 @@ static void usb_mtp_handle_reset(USBDevice *dev)
     s->data_out = NULL;
     g_free(s->result);
     s->result = NULL;
+    usb_mtp_reset_pending_write(s);
 }
 
 static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
@@ -1522,9 +1531,7 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
             usb_mtp_data_free(s->data_in);
             s->data_in = NULL;
             if (s->write_pending) {
-                g_free(s->dataset.filename);
-                s->write_pending = false;
-                s->dataset.size = 0;
+                usb_mtp_reset_pending_write(s);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
@@ -1614,7 +1621,7 @@ static void usb_mtp_write_data(MTPState *s, uint32_t handle)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-            return;
+            goto close;
         }
 
         if (s->dataset.filename) {
@@ -1691,10 +1698,10 @@ close:
         close(d->fd);
         d->fd = -1;
     }
-    g_free(s->dataset.filename);
-    s->dataset.size = 0;
+    usb_mtp_data_free(s->data_out);
+    s->data_out = NULL;
+    usb_mtp_reset_pending_write(s);
     g_free(path);
-    s->write_pending = false;
 }
 
 static void usb_mtp_write_metadata(MTPState *s)
@@ -1740,6 +1747,7 @@ static void usb_mtp_write_metadata(MTPState *s)
         next_handle = o->handle;
     }
 
+    g_free(s->dataset.filename);
     s->dataset.filename = filename;
     s->dataset.format = dataset->format;
     s->dataset.size = dataset->size;
-- 
2.56.0



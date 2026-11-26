Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31517606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMEAhL/c;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=V99coDCn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWbkC-00022d-Bm; Thu, 26 Nov 2026 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjf-0001tr-DQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xWbjd-0003gz-Ca
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795708207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7X8DmuaAaSBPLh08yOUGAdQg4W5MQP09BqHowNDgzk=;
 b=XMEAhL/cumbChaOz7UYBMeec7mYkhHsJzbPPvn2WtrJBYAjXofLXxwDkbae8LhiEadBUSH
 T1btVYUdeQeqPJTJh1GTQ2OnXb3QoHmKb1U/nxsalgCw5oVuwZMYY5HkTfHZIUoAiqta3R
 6yWz5ExkXIB/aHElxXHgzkwyRW4N7x0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-IqeyMsEyNICRdxQfZMjFxg-1; Thu, 26 Nov 2026 15:50:05 +0000
X-MC-Unique: IqeyMsEyNICRdxQfZMjFxg-1
X-Mimecast-MFC-AGG-ID: IqeyMsEyNICRdxQfZMjFxg_1795708205
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-49337a224a8so4384930f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795708204; x=1796313004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H7X8DmuaAaSBPLh08yOUGAdQg4W5MQP09BqHowNDgzk=;
 b=V99coDCn5HJP2UFECnUNiggGQMPhHUaBadEVj+ZKnn51vf0KrP8MtG2kPQcq2hOoId
 KmRyCH4+L2xNaWtDbPWAXW8vNhDrndy93gniBlGlkop31c3beavMbcfVmXq/InkHKlOc
 WbLpurREDQuiw5sJnXmxNK6pDO3KgEZ6AahQ/RJhNgu2HT4gE9Cky7y9EtjSmIsPu9Fz
 LnnTE/M3L0G9JbRm8tsMzNOAc1y5FjOl1F1SKyX1LP/tUK+uFmGb9DCVe+7C8fWB2LPw
 YobIhNm7FJuFikZSnt6ewk0OmiGHzDOnI/rDGcbViKoSpj3xf1xXev9sbCT84OvdjK1d
 8upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708204; x=1796313004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7X8DmuaAaSBPLh08yOUGAdQg4W5MQP09BqHowNDgzk=;
 b=JatBU8j1MixD/JZm58kxBr/eXoztVVcQGJtaK/WqC3cOhE0ZhNpKr1GJIFLaK700vO
 IacDsHjXXzQV5wv0IdjCAYrDC8Cd/xAinKNXdFUmk9ATlCO3VxF44K3sddzI+gmwfsK5
 zb+ZPtbmjmBwSxIL4ZLzWzYsEG/UhqBHU5AMSbYBQLHbPEkgIBaUiN0ngK0HxeoWj5PY
 4CPx5k4YBDwHTWcUEfgGkfPYvKZrUBMmRfVM6q2sDe1hZlnbpx2Iab/Ym2u9b6BUJ0IF
 UkMH68+fhEsaaaz2SQCWdYWnrxxG5nwZNFZPPfEoKl2uPtHMWedxnyMUOm/NBE8s/j0Q
 vH6g==
X-Gm-Message-State: APuU4Z/KLEh7YkUbnswL8NC0IuDBVutQOf6HOQQJ69zYo5kmweN3wHI1
 OlMqdGoPPst9W7xAoltaf9NSAfKrIBHEkF/j+jnyHqs1fmi2T8ZVYWVy+af+E1ASTqHZ7cv5yCs
 toSSPHKoL9k8TIM3L9/LxMfQNVvoiY/R7Jzqwj+PeWjVHfbkUaNRCdmJT4F9JWotsJtTXtW3CGO
 +HasikN4LleHL5aRYs07f54IZIk6gr9uKNV2selDRNniCu
X-Gm-Gg: AZFdTZdLVPxFOiziLTaPbN5JIVZ6Ufeucdz/Zpcovp1s/czGczegwhnxBC0hwVHMh5C
 acOCEX4PZ/SiVy1FPpP/t6TGWUvu0nPZBkpdy+j7yVcHsRKHh8z+Ov1aZ5Ej0c1SXRXVBqkMtIe
 RJwz3mRYX4GPWuQZc/SGgS+DzrhYDTU+/NkoBELJP+fADUMbypIov/jXub66KgI7EoKfz6oDOoj
 LDduqHOfYkAhMpEmTij6+WF06vdHBWuuq9cLBEqpFkDpGjoqhkqutWmoo5dt8W6pKIUtlx3ujNj
 K2FBFofPFc6XIrtZnfk33LNm8iFh+Iq3d9oPxps2KsQcHa0Lqz7m3GPTTbLcEv47+CdkXuISFiP
 rUHsSNXlTFVt+RkYj2YMgSvR73wI954pYboFeqZDDYooeDpdHSlyFxYL+Ph1omGxzYVY=
X-Received: by 2002:a05:6000:2283:b0:4af:e519:cccc with SMTP id
 ffacd0b85a97d-4b546663d5bmr24457268f8f.12.1795708204597; 
 Thu, 26 Nov 2026 07:50:04 -0800 (PST)
X-Received: by 2002:a05:6000:2283:b0:4af:e519:cccc with SMTP id
 ffacd0b85a97d-4b546663d5bmr24457229f8f.12.1795708204146; 
 Thu, 26 Nov 2026 07:50:04 -0800 (PST)
Received: from tcalifan-p1g8.redhat.corp ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm42551779f8f.2.2026.11.26.07.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:50:03 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Junjie Cao <junjie.cao@linux.dev>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/6] hw/usb/dev-mtp: Reset pending write state on cancel,
 reset and error
Date: Thu, 26 Nov 2026 16:49:53 +0100
Message-ID: <20261126154959.81769-2-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126154959.81769-1-tcalifano@redhat.com>
References: <20261126154959.81769-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/usb/dev-mtp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index a8b89c938b..f52de4065b 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1236,6 +1236,16 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
     }
 }
 
+static void usb_mtp_reset_pending_write(MTPState *s)
+{
+    g_free(s->dataset.filename);
+    s->dataset.filename = NULL;
+    s->dataset.size = 0;
+    s->dataset.format = 0;
+    s->dataset.parent_handle = 0;
+    s->write_pending = false;
+}
+
 static void usb_mtp_command(MTPState *s, MTPControl *c)
 {
     MTPData *data_in = NULL;
@@ -1282,6 +1292,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         trace_usb_mtp_op_close_session(s->dev.addr);
         s->session = 0;
         s->next_handle = 0;
+        usb_mtp_reset_pending_write(s);
         usb_mtp_file_monitor_cleanup(s);
         usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
         assert(QTAILQ_EMPTY(&s->objects));
@@ -1509,6 +1520,7 @@ static void usb_mtp_handle_reset(USBDevice *dev)
     s->data_out = NULL;
     g_free(s->result);
     s->result = NULL;
+    usb_mtp_reset_pending_write(s);
 }
 
 static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
@@ -1531,9 +1543,7 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
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
@@ -1623,7 +1633,7 @@ static void usb_mtp_write_data(MTPState *s, uint32_t handle)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-            return;
+            goto close;
         }
 
         if (s->dataset.filename) {
@@ -1700,10 +1710,10 @@ close:
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
@@ -1749,6 +1759,7 @@ static void usb_mtp_write_metadata(MTPState *s)
         next_handle = o->handle;
     }
 
+    g_free(s->dataset.filename);
     s->dataset.filename = filename;
     s->dataset.format = dataset->format;
     s->dataset.size = dataset->size;
-- 
2.56.1



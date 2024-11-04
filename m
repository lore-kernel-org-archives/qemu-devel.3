Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B221ED1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84I4-0006nt-J9; Mon, 04 Nov 2024 16:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hv-0006YW-HL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ht-0005MC-5d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKx+QtBgnHz0OyJq6q4H6pfoKPX66b+QZJ7P1OEJWPY=;
 b=MtWlWX4iu/3XKL0bAeA2yu1+h5FduiZ5ZfnMdiCJeDL/glOTwqOcBPq1zibyR49YzHILP3
 w5I3nUP95XgsBYoRXWO7p2DGKsazTnNElOK6Rr0xiEoUu5n2d8oZ24gFOjeejasfEXML8D
 rbSY+kAChtEnPydghRBGGqpgQTSBBp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-6vjIJknQNlWcZzSxLB-gfA-1; Mon, 04 Nov 2024 16:06:59 -0500
X-MC-Unique: 6vjIJknQNlWcZzSxLB-gfA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso32330055e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754417; x=1731359217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKx+QtBgnHz0OyJq6q4H6pfoKPX66b+QZJ7P1OEJWPY=;
 b=rsWAyiMdApHlVexcQGdyL2Q7DaxNyAzb8s4dClDLg88o4cYkeNdjazVAMMhgs3ai6l
 6XC1ZuiuCQhckhFE3DD3AgTxjvH1B1ET+krisDbUn9kx9rkZuVjtWQGtdZ+E7oyIob4/
 pSY9Wq75SBs4rwW4YnV0AjY6dqVcV5qoL6I43lHAM8uvzEfjWf/G4LH4axjc76ZuGrfY
 8CL5lOEbBXbMRuNl+7P43cZl1H2q2QJVKimGI5Ma2XOf7lRWHb5nZP7n7ShDh9UgYytX
 FDUIWB/WaK887nNc7YB1jl5Ee8YNnI6QsUdZ5HZk2EWkkPjAPf/ubsoFfrUxICsmctNy
 qrrQ==
X-Gm-Message-State: AOJu0YwFGHiY2VlcBd6Pjz86Wza1cKZY0JvKHhoUj8dTgsYrwtrmimeQ
 fcy4c5PrJnAilX4aitX0lkLINV4Dvn2YwMsaQ24/N38eNkXMOtQO+7xqUsJfWBwHUQenBGOYVh7
 hy8DSu+AmIgyARDMvr+SpCd7gKtik8PIhlrSpepy0WCdY9GMIzEFL3JfF7tmmM15VgEe266CUkn
 EaDekN1ib23y2u0tEUC/4N5A7WExMAXg==
X-Received: by 2002:a05:600c:5118:b0:42c:b995:2100 with SMTP id
 5b1f17b1804b1-4319ac75a0amr264089825e9.6.1730754416812; 
 Mon, 04 Nov 2024 13:06:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiJ78GSFD1NgzrIu6ZZZThr5+pnODIS/NHUCick+vzR2yssTzlaoRt5wOIJUuosC4DLGOCpg==
X-Received: by 2002:a05:600c:5118:b0:42c:b995:2100 with SMTP id
 5b1f17b1804b1-4319ac75a0amr264089485e9.6.1730754416331; 
 Mon, 04 Nov 2024 13:06:56 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983b7sm162601115e9.43.2024.11.04.13.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:55 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 21/65] qdev-monitor: add option to report GenericError from
 find_device_state
Message-ID: <9e4cc917e0be9c757d834a0e40c66def1fed5adc.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Here we just prepare for the following patch, making possible to report
GenericError as recommended.

This patch doesn't aim to prevent further use of DeviceNotFound by
future interfaces:

 - find_device_state() is used in blk_by_qdev_id() and qmp_get_blk()
   functions, which may lead to spread of DeviceNotFound anyway
 - also, nothing prevent simply copy-pasting find_device_state() calls
   with false argument

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Message-Id: <20240920094936.450987-2-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 system/qdev-monitor.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..6671137a91 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -885,13 +885,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+/*
+ * Note that creating new APIs using error classes other than GenericError is
+ * not recommended. Set use_generic_error=true for new interfaces.
+ */
+static DeviceState *find_device_state(const char *id, bool use_generic_error,
+                                      Error **errp)
 {
     Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
     DeviceState *dev;
 
     if (!obj) {
-        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+        error_set(errp,
+                  (use_generic_error ?
+                   ERROR_CLASS_GENERIC_ERROR : ERROR_CLASS_DEVICE_NOT_FOUND),
                   "Device '%s' not found", id);
         return NULL;
     }
@@ -956,7 +963,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    DeviceState *dev = find_device_state(id, false, errp);
     if (dev != NULL) {
         if (dev->pending_deleted_event &&
             (dev->pending_deleted_expires_ms == 0 ||
@@ -1076,7 +1083,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
 
     GLOBAL_STATE_CODE();
 
-    dev = find_device_state(id, errp);
+    dev = find_device_state(id, false, errp);
     if (dev == NULL) {
         return NULL;
     }
-- 
MST



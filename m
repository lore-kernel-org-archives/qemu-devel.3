Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6B6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnI-0002Mx-QD; Tue, 23 Apr 2024 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmk-0001bY-Jb
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmi-0006DH-Ln
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5r7Q48EGZq0nmpybZG7E24HfIaIjOOcrTLd7aRJaLk=;
 b=GPYAaJaRIUTLyaKm+fMF/mQbX5yZFyEYW5m2+J4fRyIIv5tf8uLcmYQeqY+BKrLbQOcgN6
 Vof3RSCcRfx1Bh2aqZyY/9BZ1M9fje+dFa+wfgUKoCiGFijBFLS/ncSRSnkj9h/Pwnz39R
 uLMmv2d6iiPJHMiaOU0YuPTd9wHTsKU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-KXEPuyuFNwSvHoqd3l6u7Q-1; Tue, 23 Apr 2024 18:38:42 -0400
X-MC-Unique: KXEPuyuFNwSvHoqd3l6u7Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a05ab06d96so15361336d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911922; x=1714516722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5r7Q48EGZq0nmpybZG7E24HfIaIjOOcrTLd7aRJaLk=;
 b=W6ATF2VCVb/HKiIZD9fA4pmLWvuQj9B0TrdIGasX5lENuEJJ7Bw2SXIKYZSbhyqDTs
 fmTk7Wetdy2YtiezAowrpQVDXyrtahgr7OsxXc39S18Uwug6A+SEHbbs1WPKeAuV48Rq
 b0VTClVzKupEwcGofUH+OgJF+wrOQmEyCFiGzlC+KjwEW1KvmyC/nS3lJc+8EIiXarHD
 yE6Yd7Rc3PCZf7Y2wDK6ThUlKDu7UslruAetDEuOlhVYk7gfuFBGzEoDi60SpptHPSMs
 2SV7XNDhR91h+hutqMMZIoMnwrp4a8oD+sqeBA36ToYi5sLNXDmK9x+Q6Phl/3uhUyUN
 o5IQ==
X-Gm-Message-State: AOJu0Yz43J4//Uwl7VJSecV+uMl2heqcQcvFcRaeoPOLhM4ExEUoRkrY
 iQjtzlA7fLreVkosPmIwDAH3jX28j+5PGRAc1goL+lpLXe7WhN9m7wpLwkJov/DSkjH/tHpJdEj
 RSJ5MU9znq4CXUQIfSTUXKiml+jpA/PucSjXuWG/ANHvrpvfR10gl4VGpMLzPHRcOKibAzUDJkf
 Q0299Ha1JCm+/NuFpaeFFzPSH3dxI+JckJuw==
X-Received: by 2002:a05:620a:3d09:b0:790:8bbb:dd5f with SMTP id
 tq9-20020a05620a3d0900b007908bbbdd5fmr702577qkn.3.1713911921754; 
 Tue, 23 Apr 2024 15:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRtjRDW3iFjHN9Mpuwwzp+wew8ocd2C4OcPgGX0AN+u82lFJtLa9Xv7Derx5JO6xSmP6cMw==
X-Received: by 2002:a05:620a:3d09:b0:790:8bbb:dd5f with SMTP id
 tq9-20020a05620a3d0900b007908bbbdd5fmr702551qkn.3.1713911920936; 
 Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/26] migration: Add Error** argument to ram_state_init()
Date: Tue, 23 Apr 2024 18:38:08 -0400
Message-ID: <20240423223813.3237060-22-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Since the return value not exploited, follow the recommendations of
qapi/error.h and change it to a bool

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320064911.545001-13-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index bade3e9281..26ce11a337 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2780,13 +2780,13 @@ err_out:
     return -ENOMEM;
 }
 
-static int ram_state_init(RAMState **rsp)
+static bool ram_state_init(RAMState **rsp, Error **errp)
 {
     *rsp = g_try_new0(RAMState, 1);
 
     if (!*rsp) {
-        error_report("%s: Init ramstate fail", __func__);
-        return -1;
+        error_setg(errp, "%s: Init ramstate fail", __func__);
+        return false;
     }
 
     qemu_mutex_init(&(*rsp)->bitmap_mutex);
@@ -2802,7 +2802,7 @@ static int ram_state_init(RAMState **rsp)
     (*rsp)->migration_dirty_pages = (*rsp)->ram_bytes_total >> TARGET_PAGE_BITS;
     ram_state_reset(*rsp);
 
-    return 0;
+    return true;
 }
 
 static void ram_list_init_bitmaps(void)
@@ -2897,7 +2897,10 @@ out_unlock:
 
 static int ram_init_all(RAMState **rsp)
 {
-    if (ram_state_init(rsp)) {
+    Error *local_err = NULL;
+
+    if (!ram_state_init(rsp, &local_err)) {
+        error_report_err(local_err);
         return -1;
     }
 
@@ -3624,7 +3627,11 @@ void ram_handle_zero(void *host, uint64_t size)
 
 static void colo_init_ram_state(void)
 {
-    ram_state_init(&ram_state);
+    Error *local_err = NULL;
+
+    if (!ram_state_init(&ram_state, &local_err)) {
+        error_report_err(local_err);
+    }
 }
 
 /*
-- 
2.44.0



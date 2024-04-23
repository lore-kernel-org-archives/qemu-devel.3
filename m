Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5F8C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnD-00024Q-Gp; Tue, 23 Apr 2024 18:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOme-0001U3-UZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOma-000670-TT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCwGJ6Bu1YcEaYmeSeORMq4mMXrUShBq88eyBpSclzM=;
 b=UHBB5+sHuvFViwXbyYtlxtYKG6Euy96iOFNzf886ejLyiPIpvxRXD/FB3nTrs6R5HlL56E
 9SFgXF7sgv1nHlT6cwHSeaNXW4jIxPfeGc7BGILUJRfmDI405VuOh0KMPvpnSNVmaFS5Sh
 /37VsVAJdnYgA7C1V58scDuvNc55+HA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1iVpcqE2NsSvbuJDt9mEww-1; Tue, 23 Apr 2024 18:38:34 -0400
X-MC-Unique: 1iVpcqE2NsSvbuJDt9mEww-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a06dad74faso13872876d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911913; x=1714516713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCwGJ6Bu1YcEaYmeSeORMq4mMXrUShBq88eyBpSclzM=;
 b=vvGRZVIIPCkY45l9eTA4gfK2VxDypZa9rvv0gaYY54TFa71X+D0qMaNIBrWfia6d7Q
 IA+wlU2yBy6es6YPd21Iquf/wFSwTnEGCLDUCEpSl9/CI98x1HMpOe1zK+wGtidhK82E
 copjB/JBtbNN0yi2oqq01GyEz84E3zxC+d2T4nctvZIM2PY/6dFDvVTr2giUzXzmedHt
 eVeKVV0KSCluCsIlMFGvGSeoScLH/nSGDV9s82qZeEdFiEgHX6bCEhFeJXMLJUFbDVnc
 ExMF0DLkhw6uzsfvtOBioK3lBT40cD6cWeW72O6l/8oEgGz0t50+tKXhcWTIzuGE94FT
 qUTQ==
X-Gm-Message-State: AOJu0YzDBE7UIlAYYv6ddDO2Y8A3rtPpL1T5h9QqaiNzsOZSA2TwQrKx
 K4s9nJgOC9IBX3ARjWLjLJJuJ9nxWERy8cNi64px8M2JIgUFLlbJXo8cDGtfeFpAbHABLuMPhrO
 XVpW4EQqlZDc2BnenF6f4VG3ehfqwydLF/EoMNJCcYhli7Qr3GNFgWgNa6GchuRlLayT6IfcmIu
 Mx/2QDhbORf61RNTCt7Y+as1svq41K68AbDg==
X-Received: by 2002:a05:620a:3914:b0:790:86bd:f445 with SMTP id
 qr20-20020a05620a391400b0079086bdf445mr958695qkn.2.1713911913167; 
 Tue, 23 Apr 2024 15:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+1WYgONOoRh0i/zaOdsArzOY35EPB07lxWwKfNbbGWyg7F5eOEXHTvIWHxlr724MeQ+nYQA==
X-Received: by 2002:a05:620a:3914:b0:790:86bd:f445 with SMTP id
 qr20-20020a05620a391400b0079086bdf445mr958661qkn.2.1713911912265; 
 Tue, 23 Apr 2024 15:38:32 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/26] migration: Always report an error in ram_save_setup()
Date: Tue, 23 Apr 2024 18:38:00 -0400
Message-ID: <20240423223813.3237060-14-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: Cédric Le Goater <clg@redhat.com>

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
ram_save_setup() sets a new error.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-5-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8deb84984f..44d7073730 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3074,12 +3074,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
+        error_report("%s: failed to start compress threads", __func__);
         return -1;
     }
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
+            error_report("%s: failed to setup RAM for migration", __func__);
             compress_threads_save_cleanup();
             return -1;
         }
@@ -3116,12 +3118,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
+        error_report("%s: failed to start RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
+        error_report("%s: failed to stop RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
@@ -3138,6 +3142,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
+        error_report("%s: multifd synchronization failed", __func__);
         return ret;
     }
 
@@ -3147,7 +3152,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
-    return qemu_fflush(f);
+    ret = qemu_fflush(f);
+    if (ret < 0) {
+        error_report("%s failed : %s", __func__, strerror(-ret));
+    }
+    return ret;
 }
 
 static void ram_save_file_bmap(QEMUFile *f)
-- 
2.44.0



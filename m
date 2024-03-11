Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBABCC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngO-0000GG-19; Mon, 11 Mar 2024 17:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngM-0000FF-JU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngL-0003yn-0U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fy9ven1kWN6KIHr7K9n1SATScv4YMRbuKCUFVtbSpwk=;
 b=UDRLLCI7nhQait1osffc1rclHkoSO7MZKtydZ4+APIukodC2t6y4KCjateQr/RvwE96knN
 E/O6UrFIWQcYK++PXW4Qi+iYJ7VMx+m4u7yuBCER7h9u2xDNQSTBCYDGj/FkNvWGvHtriV
 NVbVkCdJuvzDSkMRVBOAhi7xoThEkKw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-GXyH86IANMe3JBxfUUEzmA-1; Mon, 11 Mar 2024 17:59:36 -0400
X-MC-Unique: GXyH86IANMe3JBxfUUEzmA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690d3f5af86so4505126d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194376; x=1710799176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fy9ven1kWN6KIHr7K9n1SATScv4YMRbuKCUFVtbSpwk=;
 b=kDkdi9MsX6Lvyx0yqAkMLU60RldBKVEdzHoRIIKIupmPgh5yiQjccGeIqay+6Ihbv/
 O9hQGA0IYGa3Rd6kCzmdco0ivReC7lK+eKfuuGUMWoWZsbDcSrhPhEl1qyzIVYFA0MQZ
 p13E7cfxVYdGPFLyn/UbcYALvAx4ygnK0jsp1nuE2aePI37ul3D+RE7QWuNwwSoRAi0s
 nLWCn6BxVksdydZDslHbSuZB4VX8toUfXa3S7/3qGrntH141G2nFtvwEG1wp6p+uu8/Q
 VGVwh53pk5PKj4WAlbcG5a1SiW2ltWT8jwqFm6iGsJTzj8hBp2ixdDopmOwHznZ2TiMz
 5cuw==
X-Gm-Message-State: AOJu0YwlJUBGNxDdS1qYYZ71C8HwUT+Ct/HEEsmYTM86uKfmINdOaOuJ
 0AIGUEc1QJ/ol7mUqECiltBJ4ctfgJxPR1eabDYuHaamxRkOnkCv2E/tvR/cDfPFaI3Gbk/pmPQ
 jxF4Ra5xuYENYkro7Acd8/vRZQin6NWVgUg35XQrYZXR7iqUjeZbZyBReNuTgna56Tp8Gnxe9ad
 7mRjQoGupj/dnjtEl1GmykzeHbwoiRRfbTlw==
X-Received: by 2002:a0c:e141:0:b0:690:a71a:d381 with SMTP id
 c1-20020a0ce141000000b00690a71ad381mr7862214qvl.6.1710194376148; 
 Mon, 11 Mar 2024 14:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJtZGA5BfIepUNIgay/2QytymBVXHAVshBpDfYFXh4F3Q1HqzsO/DJv6DO8nosaVPXVmuDdA==
X-Received: by 2002:a0c:e141:0:b0:690:a71a:d381 with SMTP id
 c1-20020a0ce141000000b00690a71ad381mr7862192qvl.6.1710194375797; 
 Mon, 11 Mar 2024 14:59:35 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:35 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/34] migration: Remove SaveStateHandler and LoadStateHandler
 typedefs
Date: Mon, 11 Mar 2024 17:58:57 -0400
Message-ID: <20240311215925.40618-7-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cédric Le Goater <clg@redhat.com>

They are only used once.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240304122844.1888308-8-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h | 4 ++--
 include/qemu/typedefs.h      | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9ab1f79512..2e6a7d766e 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -18,7 +18,7 @@
 
 typedef struct SaveVMHandlers {
     /* This runs inside the BQL.  */
-    SaveStateHandler *save_state;
+    void (*save_state)(QEMUFile *f, void *opaque);
 
     /*
      * save_prepare is called early, even before migration starts, and can be
@@ -71,7 +71,7 @@ typedef struct SaveVMHandlers {
     /* This calculate the exact remaining data to transfer */
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
-    LoadStateHandler *load_state;
+    int (*load_state)(QEMUFile *f, void *opaque, int version_id);
     int (*load_setup)(QEMUFile *f, void *opaque);
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index a028dba4d0..50c277cf0b 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -151,8 +151,6 @@ typedef struct IRQState *qemu_irq;
 /*
  * Function types
  */
-typedef void SaveStateHandler(QEMUFile *f, void *opaque);
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 
 #endif /* QEMU_TYPEDEFS_H */
-- 
2.44.0



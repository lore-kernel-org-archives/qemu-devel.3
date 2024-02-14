Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD17C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFQ-0005gz-OG; Wed, 14 Feb 2024 06:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEl-0004JE-8J
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEj-0007FY-Cm
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ny9ujC/q8Uoo9V1VXsX5vJYsw7EaDLr3xTeRBTEHjis=;
 b=GAj8Yx7i2rOBXX8LrhA6zcmw4aLKSqCngindw/HAw7/zxK3VtfryOuIoX+KPN+6D3LqGm6
 zHxxRHwG077GxMw1eR1+UHvVRpBYlCwQnQlWTDJyrhW3JtMaantpDhqhEdxBqTr/c/FyKj
 QvRz+9kqCxdImGh6dp9nDk1q71cmB50=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-NdPGabwQN2uSuwmIDfQ60Q-1; Wed, 14 Feb 2024 06:15:31 -0500
X-MC-Unique: NdPGabwQN2uSuwmIDfQ60Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso403759766b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909329; x=1708514129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ny9ujC/q8Uoo9V1VXsX5vJYsw7EaDLr3xTeRBTEHjis=;
 b=WpFxN63NTneTiYZ6u70pUZffslnkjwYrDA4cWKtcIb7DZGBoH4s6lsSsXrqGaO6Zko
 JiBBE3ZvbAf3zV6KtBY8YoPe/6SbJS6qsu2sYq5RjJX2bbr7BquLmSTDkTtcA3lsh8Nq
 EAJfHO0+8PSdw4Mw0BSpsi7YS+Y6mF0KA6lpacC4N6W/+QPAdRZekKYGcXJN7y/g1Fvf
 aPixpAZsJHaB5jkRsm7SmWdMvHyUbdAwo7bWcDj3jLFYskM2d1Zt2Fvk8XPKfKC7HNvc
 SfQNgR6GG0Gg9Ib5CK7NAf2TgXNY38jpj8Q4yhig7FlbcAmDnpfleDwusXbnxb+b1u6l
 2hSg==
X-Gm-Message-State: AOJu0YwG07rkJCiXlDaBjIYkxE2q/vFOxvsla3G+YyMWh89IXDBoDYM9
 9ypjg+1wiB8+t92OWnwQeooB8ZmEd9K6D3oQroFSmmQKseKJ2kKOf0hjWQtN3tOkUxie08zupUv
 ObcIc+LIK266+4EdEZvcgcj8vDZO00gPGiEqoDuJJeFL9hhoV00J3LueXQd/l47BwL8057DO9I2
 B1RPIGiFNN4/DJnl+r8ZcFFKHfHiqySw==
X-Received: by 2002:a17:906:b7c4:b0:a3c:11a0:8d10 with SMTP id
 fy4-20020a170906b7c400b00a3c11a08d10mr1682393ejb.3.1707909329399; 
 Wed, 14 Feb 2024 03:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbHOQkf1nKWKnALpSek5ac4lF2Ksm3qtzz7OVRyTMTV94rSMtOpkxPhaPMdCN0wP9mnm0T0Q==
X-Received: by 2002:a17:906:b7c4:b0:a3c:11a0:8d10 with SMTP id
 fy4-20020a170906b7c400b00a3c11a08d10mr1682378ejb.3.1707909329060; 
 Wed, 14 Feb 2024 03:15:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVuI4MvfH9478Gs+zR4LA/EvNdOYlJiH2pVjomgC419sSLx4kvBa9Dq3Xho4e+Bcg2VCr11ehLVHbbxgPRpUMdWWB9671RqzXkAPgQE+WDpy3dO0/VLF4N5+PX09D94Vhx166InFtbQLdWz/3y97M+ARrc=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 ca23-20020a170906a3d700b00a3caccb8f66sm2209113ejb.44.2024.02.14.03.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:28 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 41/60] hw/cxl/mbox: Remove dead code
Message-ID: <7031ee540b7e25a8f38d7b855ed99c7c5f68200d.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Davidlohr Bueso <dave@stgolabs.net>

Two functions were reported to have dead code, remove the bogus
branches altogether, as well as a misplaced qemu_log call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6eff56fb1b..dc42850767 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
 
     cxl_dev_disable_media(&ct3d->cxl_dstate);
 
-    if (secs > 2) {
-        /* sanitize when done */
-        return CXL_MBOX_BG_STARTED;
-    } else {
-        __do_sanitization(ct3d);
-        cxl_dev_enable_media(&ct3d->cxl_dstate);
-
-        return CXL_MBOX_SUCCESS;
-    }
+    /* sanitize when done */
+    return CXL_MBOX_BG_STARTED;
 }
 
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
@@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
-        if (ret == CXL_MBOX_SUCCESS) {
-            switch (cci->bg.opcode) {
-            case 0x4400: /* sanitize */
-            {
-                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        switch (cci->bg.opcode) {
+        case 0x4400: /* sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
 
-                __do_sanitization(ct3d);
-                cxl_dev_enable_media(&ct3d->cxl_dstate);
-            }
-            break;
-            case 0x4304: /* TODO: scan media */
-                break;
-            default:
-                __builtin_unreachable();
-                break;
-            }
+            __do_sanitization(ct3d);
+            cxl_dev_enable_media(&ct3d->cxl_dstate);
+        }
+        break;
+        case 0x4304: /* TODO: scan media */
+            break;
+        default:
+            __builtin_unreachable();
+            break;
         }
-
-        qemu_log("Background command %04xh finished: %s\n",
-                 cci->bg.opcode,
-                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
     } else {
         /* estimate only */
         cci->bg.complete_pct = 100 * now / total_time;
-- 
MST



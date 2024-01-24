Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B75C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXu8-00039Z-Qp; Wed, 24 Jan 2024 02:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXu6-00039G-W7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:35 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXu5-00034x-IC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso255017f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082151; x=1706686951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOMcngLxDGJkByS9gEJEYPbL5+4ZqnQIMdvGkNbM490=;
 b=tfIAk8jUxJ+9qxE3YU0jZNpY0cFh9QX2v9oaiJQktevljvWdFxN6s/bg7maF60jvwZ
 Kpxuee6/OOYgoONLuer3HOq3pRkRZm0hxy8SsoLnL2AqYKZT8lcKW3xNie6VRMe4ywlw
 qeF6VZR/7QpyXvbLsYvq16KoJ1fsAj5b4vDnf/J4b68iR9HU7kAsJ+kJgd42UrSkFz6K
 r3YPs51de7mIw4LWSVqaBl0t/LolSz1j7bpVjEe1qiKDOEnqSLvVkl9lDm6T6JraGBxD
 BwRVJu9mBPqtwic25Om0C9PfzemhTbP7LtJ2zHfYoJLi9zLQTY8zhODJ88YBzRcYsPIR
 4EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082151; x=1706686951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOMcngLxDGJkByS9gEJEYPbL5+4ZqnQIMdvGkNbM490=;
 b=iREqsJuuFkC4G3WxK0DtA64Z0lIeTkpGk4Kj3aPRmpBnn6xF7GTbbFT25U24zeYWR8
 IbEdiMZXnTUKrhCBoM/NJ5GexelAmQ45YTxI6WP0XrTIN7S++GSaHDUHD3bTe0JNC/9T
 L+YMXDuSmkGTsj5PoN6FHQWKkBR5GCc987qVYr/coEKosZYdYl1UxCeU2cfGD9Ls6n5O
 gknj0w7DjFIZpXtvA7GB0L7KMFOc4u3/1WhS2b2jAq9wGN4ZuaHCAuPatWNQuaB1JZgV
 ulSd0k+m4PlJDffZGsDuyKoZ9dqaQDZcwYAQ+ylry1DCEqfqrLhR76pVCr4TOqKfxkU5
 Lb9g==
X-Gm-Message-State: AOJu0YxxYgdmO+WW732qNzIkp8N0+XDr3R4xIYWrj8n61TtGSdRVARCE
 U0FwgCbJINjqwvYCjqCFnZBQUQbVDYWSEVc/IBq8nw/jXBIdXtu6fn4vzEw6Et9Kuk0rClOkm1e
 S
X-Google-Smtp-Source: AGHT+IGllL7xwRJu4k3cTkOFtPQhDOtZ7+FXJEZ/64J94LuhTEdjWOWhvbVqjt8Mw/puimu8l3cruA==
X-Received: by 2002:a7b:c4d3:0:b0:40e:52fd:7341 with SMTP id
 g19-20020a7bc4d3000000b0040e52fd7341mr383336wmk.141.1706082151723; 
 Tue, 23 Jan 2024 23:42:31 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c1d8300b0040ec7f229b3sm43731wms.34.2024.01.23.23.42.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/scsi/virtio-scsi: Use RCU_READ macro
Date: Wed, 24 Jan 2024 08:41:59 +0100
Message-ID: <20240124074201.8239-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124074201.8239-1-philmd@linaro.org>
References: <20240124074201.8239-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Replace the manual rcu_read_(un)lock calls by the
WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
"docs/style: call out the use of GUARD macros").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/virtio-scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 690aceec45..998227404a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -343,14 +343,14 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
         target = req->req.tmf.lun[1];
         qatomic_inc(&s->resetting);
 
-        rcu_read_lock();
-        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
-            SCSIDevice *d1 = SCSI_DEVICE(kid->child);
-            if (d1->channel == 0 && d1->id == target) {
-                device_cold_reset(&d1->qdev);
+        WITH_RCU_READ_LOCK_GUARD() {
+            QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
+                SCSIDevice *d1 = SCSI_DEVICE(kid->child);
+                if (d1->channel == 0 && d1->id == target) {
+                    device_cold_reset(&d1->qdev);
+                }
             }
         }
-        rcu_read_unlock();
 
         qatomic_dec(&s->resetting);
         break;
-- 
2.41.0



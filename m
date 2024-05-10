Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6503C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Not-0001mG-9R; Fri, 10 May 2024 06:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nor-0001kY-EX
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:41 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nop-0001WK-JK
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:41 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e271acb015so23950521fa.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338177; x=1715942977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TpUZ8CKDgQBKN9dqD4YnU9Z+7ud1E8NXp6jYp8jowk=;
 b=Q6MxdewPyisYACr1va8rpSIDpuEv6nM3bDu7i7DMnUd5upAfNt5VbIXgYJk4a3+Jl0
 t9cjgVJfTEb+R1iomIWH6vyBq9dloT3QJfVgjsD12zr74eEhwFBBPYQAKsO8DZkDjexj
 Q5BWLk6wYOOgR6yZwdywmtCHJy0LPyl4ggmY1abCycpyuDS/axJS37P23obVpoC9WC0B
 DUY3xfE0o2zGZU+vkrKZhoU8+8A+qyLaOsc+krxLnbWf9H5tIwuztd/gDTasOmdGRU6/
 bWpwuLX4Inx3qb9gdNtCoLyXUVIIU3aroFJOJy7n9W9R6ivXd5VjnUDs7ZqbVafi+10v
 IBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338177; x=1715942977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TpUZ8CKDgQBKN9dqD4YnU9Z+7ud1E8NXp6jYp8jowk=;
 b=Rt5VvdeC+WhD4F9bGxw8/Lr0UErqHQrdTI/vYQMOCR1v/a958XTtVMAWRCENYKVIeE
 X5SV7QtFGJWi4g1sIEOKUUGx3p3WvBOrH3Ng2pLT8Qjpvpjyy0UV9lpFLFdsd+7wFpaq
 eAiuujP6ydrxsfGZvpoK1kzaPvdY/tjfVvwTMX5myAt6WgQ98JPLWDVXPdXbez+9o+Ih
 jaYtYyoOpoYAPM7ayTB4fzJmx2E7OruS58H96GxOygGOPlacKrLA4dgrC9v7oPqFI2oa
 QUOWvu5Q56xJzdp/2RdO4Pq25HBQDrkQNNgAu1q6+pcIPE73xrvry/X0VhKiUG8PkIy7
 wfpQ==
X-Gm-Message-State: AOJu0YwUk1vHtCrNIimLQCytzQMjbQz1QNCcGkjGrdD8myD2vL0PCaZ4
 YjbXLpyP3KpoM55lyP//9pwsBHx069CWTawrqVdniEM/4plDSDotDewOxkgAwNEwTUZeWE0rtnv
 N
X-Google-Smtp-Source: AGHT+IF8RYJPL89SDGvqPQidQK0KvxqcH+BiwQtlAacHw890jlHQhQtuBmxCLpPl4I/7qfyZFdFshA==
X-Received: by 2002:a2e:93cf:0:b0:2e4:9606:6b86 with SMTP id
 38308e7fff4ca-2e51fd42c6dmr14616001fa.8.1715338176994; 
 Fri, 10 May 2024 03:49:36 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe004eae9sm42086695e9.1.2024.05.10.03.49.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/xen: Make XenDevOps structures const
Date: Fri, 10 May 2024 12:49:05 +0200
Message-ID: <20240510104908.76908-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Keep XenDevOps structures in .rodata.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 8 ++++----
 hw/9pfs/xen-9p-backend.c            | 2 +-
 hw/display/xenfb.c                  | 4 ++--
 hw/usb/xen-usb.c                    | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 2b2e43c7e7..cfa43a984a 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -67,13 +67,13 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
 }
 
 /* actual backend drivers */
-extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
-extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
+extern const struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
+extern const struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
 #ifdef CONFIG_VIRTFS
-extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */
+extern const struct XenDevOps xen_9pfs_ops;         /* xen-9p-backend.c  */
 #endif
 #ifdef CONFIG_USB_LIBUSB
-extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
+extern const struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
 #endif
 
 /* configuration (aka xenbus setup) */
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 4aa9c8c736..b1780eb819 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -513,7 +513,7 @@ static void xen_9pfs_alloc(struct XenLegacyDevice *xendev)
     xenstore_write_be_int(xendev, "max-ring-page-order", MAX_RING_ORDER);
 }
 
-struct XenDevOps xen_9pfs_ops = {
+const struct XenDevOps xen_9pfs_ops = {
     .size       = sizeof(Xen9pfsDev),
     .flags      = DEVOPS_FLAG_NEED_GNTDEV,
     .alloc      = xen_9pfs_alloc,
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index b2130a0d70..dd83d0f5a5 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -972,7 +972,7 @@ static void fb_event(struct XenLegacyDevice *xendev)
 
 /* -------------------------------------------------------------------- */
 
-struct XenDevOps xen_kbdmouse_ops = {
+const struct XenDevOps xen_kbdmouse_ops = {
     .size       = sizeof(struct XenInput),
     .init       = input_init,
     .initialise = input_initialise,
@@ -981,7 +981,7 @@ struct XenDevOps xen_kbdmouse_ops = {
     .event      = input_event,
 };
 
-struct XenDevOps xen_framebuffer_ops = {
+const struct XenDevOps xen_framebuffer_ops = {
     .size       = sizeof(struct XenFB),
     .init       = fb_init,
     .initialise = fb_initialise,
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 09ec326aea..95a901e81f 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -1083,7 +1083,7 @@ static void usbback_event(struct XenLegacyDevice *xendev)
     qemu_bh_schedule(usbif->bh);
 }
 
-struct XenDevOps xen_usb_ops = {
+const struct XenDevOps xen_usb_ops = {
     .size            = sizeof(struct usbback_info),
     .flags           = DEVOPS_FLAG_NEED_GNTDEV,
     .init            = usbback_init,
@@ -1102,7 +1102,7 @@ static int usbback_not_supported(void)
     return -EINVAL;
 }
 
-struct XenDevOps xen_usb_ops = {
+const struct XenDevOps xen_usb_ops = {
     .backend_register = usbback_not_supported,
 };
 
-- 
2.41.0



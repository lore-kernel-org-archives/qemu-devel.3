Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5805FC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nom-0001da-Sz; Fri, 10 May 2024 06:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Noj-0001Zy-GN
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Noh-0001Vf-Q9
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:49:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04e2so9604645e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338169; x=1715942969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLydyXWVq+dvuttt9ieifXl3jWWZU+LQZOiqeB7g+WE=;
 b=i6RSJQh65O6XC6dxR/GxkbxNFFPmqg6wVsXvGt+3NT/2UWZy0u4DeIkmq59Paj0A10
 uVEdZk5nzEQnUMzFOAKEjbksjIFzld79cJp4nufbxKSkcugC9QWq5OoNken9Xqo5O/6c
 mw8f7ZQpZ3XvMWlnIk6O/rXuLK18QNIoSuvjamqoyuzSUdAr7FwwXeC2xeSAOxXOFqbS
 rmKLsP2anpZq9zYXEuBAxCdqVfrvPdPxzxig4IOfPdl8yj5VP6JSTbl/hb28MycH1axc
 TAKmYaaGqawnbasrAA9tX5mRnSlMV5AH3nuhO6alslrFBLm3WVuwU6BKY0VOcWl8HfeY
 3Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338169; x=1715942969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLydyXWVq+dvuttt9ieifXl3jWWZU+LQZOiqeB7g+WE=;
 b=eZHp6BMWGavgLa84tkdCeUuUnxaD4VgIXVpe2d5OKhBoUdl4Ri2jL+Vdrzt9ujDA51
 R+smakX50PLy9ZOMdkLTHeLpkwbqDI7KQVP9uL8hhKgon6KTG/7tbb7dKpKGPqk9CWoW
 /bbX57VwPCOUQD8HtzqNeR2EGpStYbKp6yGFznX734Gm5/v/cDjUtNfUvT4ld+elKova
 pvOtPD1AF6I1CEyIWd3NVPhNvTBsnFt4sfBwfCuUuyxzFl1SUcbOLEkqi1lZO89rdQ1R
 C8QKOzsHlUI4HGpcZMh739irHsL/s3/pC10DX9fsDeAMRj2ejB7hDPuSgW95PzklrDj3
 an2Q==
X-Gm-Message-State: AOJu0YxAfbIKADHaKx5TlsBgoMbhU9ydQmFLxJdVk/W/L+oxuDnkXfXw
 SirysyALqCR6oXRVm2opNF8VXruuycbNMP5K6ABG7x8cHhcuTNwZ7OGAUrv5qV2HDvTJMQ3tN+2
 Z
X-Google-Smtp-Source: AGHT+IHGIbDdIaTxFsBrR2IWNVmIfQPPJ+675dXTXWbJ7moWgoCOFX7c+yR+LoYYFbbyaZxuWDMrRA==
X-Received: by 2002:a05:600c:3b26:b0:419:f241:633c with SMTP id
 5b1f17b1804b1-41feaa2f3b9mr18911745e9.4.1715338169611; 
 Fri, 10 May 2024 03:49:29 -0700 (PDT)
Received: from m1x-phil.lan (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce2580sm58674215e9.18.2024.05.10.03.49.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 May 2024 03:49:29 -0700 (PDT)
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
Subject: [PATCH v2 3/7] hw/xen: Constify xenstore_be::XenDevOps
Date: Fri, 10 May 2024 12:49:04 +0200
Message-ID: <20240510104908.76908-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
References: <20240510104908.76908-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

XenDevOps @ops is not updated, mark it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 2 +-
 hw/xen/xen-legacy-backend.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index eb22633caa..2b2e43c7e7 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -40,7 +40,7 @@ void xen_be_check_state(struct XenLegacyDevice *xendev);
 
 /* xen backend driver bits */
 void xen_be_init(void);
-int xen_be_register(const char *type, struct XenDevOps *ops);
+int xen_be_register(const char *type, const struct XenDevOps *ops);
 int xen_be_set_state(struct XenLegacyDevice *xendev, enum xenbus_state state);
 int xen_be_bind_evtchn(struct XenLegacyDevice *xendev);
 void xen_be_set_max_grant_refs(struct XenLegacyDevice *xendev,
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 35f2b57560..4dc3a561cf 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -520,7 +520,7 @@ void xen_be_check_state(struct XenLegacyDevice *xendev)
 struct xenstore_be {
     const char *type;
     int dom;
-    struct XenDevOps *ops;
+    const struct XenDevOps *ops;
 };
 
 static void xenstore_update_be(void *opaque, const char *watch)
@@ -557,7 +557,7 @@ static void xenstore_update_be(void *opaque, const char *watch)
     }
 }
 
-static int xenstore_scan(const char *type, int dom, struct XenDevOps *ops)
+static int xenstore_scan(const char *type, int dom, const struct XenDevOps *ops)
 {
     struct XenLegacyDevice *xendev;
     char path[XEN_BUFSIZE];
@@ -632,7 +632,7 @@ void xen_be_init(void)
 #endif
 }
 
-int xen_be_register(const char *type, struct XenDevOps *ops)
+int xen_be_register(const char *type, const struct XenDevOps *ops)
 {
     char path[50];
     int rc;
-- 
2.41.0



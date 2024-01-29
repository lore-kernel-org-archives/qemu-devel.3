Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7F0C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTq5-0000Kq-J4; Mon, 29 Jan 2024 10:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTq2-0000JM-UN
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTq1-0005D2-96
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e80046246so15775795e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706543179; x=1707147979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zRxwzBg1JPAeksvDXKolStU0KP7INqkx8/kV22Vx3g=;
 b=OhOcobVvRsl/loBwTy6LuldPMX0Pp/3xDtYXMQTBKUF81/uSkocsdj208daJzRSP+/
 noXAxMThzN1EvlGALsOngUJ3U6BgtcsbIc34zyMhomQXdbERouf+wB+RAqf7xyyJnkSk
 pM3m+tufJC8PsBXUzl/uukkFphu+g480y0O3+kQcDWjwRrHCchUwbszeWyo/pUH5QVHv
 92vWl9qpRalhU6Sk4kYQc32Zp+mAuhWbZgieDVwvtJykVAJU/PFpVJLd5W0fECvw+Fou
 tXcryPkT8ff8ahF1hnPe8jPkP2IFvxAxhVBa7nzy4jxS2c9CEctEM7VkcfNC7LE72kZa
 4KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543179; x=1707147979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zRxwzBg1JPAeksvDXKolStU0KP7INqkx8/kV22Vx3g=;
 b=Km7cuKyi56ZXRq1C6pcVx5qKiax9Q0KNl0nG8GsNSDEjrzNGwGGmJvV9A0LS5TTdsB
 zltiKC46YFDKb9eef0M8HRWFnCCsZxGx1neQVL19p28ssdjq39PrdPmfCrv+fCsOqc9c
 V1MZsti5g/GLwcwzDHXiI7SGL5xS/QvFZo+v5VSddNRZnucouO7dvNoGPtCXbGYC7Cbi
 Ldh2gaKtJsUL5g/twOl0jWfHjGbXGlAbJy0kcYesyKKAaG7KMHqS21rF0fyRzk05LypL
 Y9N25jRqbEKes4nzugDGogVhspGgBTDw0J2Mue1BATPa5Tk5MpBkfWkOtwYvdSd012q3
 JxZA==
X-Gm-Message-State: AOJu0Yxbspq8NHt73XnEJu+gm+gvwDfQp5ztC18848gEnQzGlw/x3MoW
 gAaRCayb4RFt7j2YYufJ6N3N+UXm7h6wOxvBk+s8sxz3C5qfoPnKazWCN83mNx0Eni3uD8Z6/kJ
 JWsM=
X-Google-Smtp-Source: AGHT+IHOS9K957M7773lIW9B1ZTmACZrKo0G+OXpIoINScUUN0p/8FQhRyYy+EcpKvKnicFl+KJ9NQ==
X-Received: by 2002:a05:600c:4e92:b0:40e:b27c:9cc3 with SMTP id
 f18-20020a05600c4e9200b0040eb27c9cc3mr5783457wmq.0.1706543178978; 
 Mon, 29 Jan 2024 07:46:18 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600016cf00b0033aedfc5581sm2852608wrf.32.2024.01.29.07.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:46:18 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 1/3] hw/display/virtio-gpu.c: use reset_bh class method
Date: Mon, 29 Jan 2024 17:45:23 +0200
Message-Id: <5893fb45d1a3f770fbb5dcea0c541eb92e386c4a.1706542958.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

While the VirtioGPU type has a reset_bh field to specify a reset
callback, it's never used. virtio_gpu_reset() calls the general
virtio_gpu_reset_bh() function for all devices that inherit from
VirtioGPU.

While no devices override reset_bh at the moment, a device reset might
require special logic for implementations in the future.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f8a675eb30..2b73ae585b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1515,7 +1515,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
             qemu_cond_wait_bql(&g->reset_cond);
         }
     } else {
-        virtio_gpu_reset_bh(g);
+        aio_bh_call(g->reset_bh);
     }
 
     while (!QTAILQ_EMPTY(&g->cmdq)) {
-- 
γαῖα πυρί μιχθήτω



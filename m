Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B03AC48286
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpal-0000nK-5N; Tue, 30 Jan 2024 10:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpaj-0000mj-DD
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpah-0008GK-J9
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so16773185e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626797; x=1707231597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zRxwzBg1JPAeksvDXKolStU0KP7INqkx8/kV22Vx3g=;
 b=LrGTOGEd6vYoxjdpcUAmrTOJ3oz88iDpRr8CnntZlNd11NN2KvxnC4qWKWzlis8NDE
 LrvZpEmCrQwqGexJGmR3Eq9wtdtXCaIuadFnZwHzVN5wvMQfEp8nwUoRa17fS8UZ+9Yc
 K5v9XERcUaZoLOaU5csQ7Elp7yNBev+gncq9TZUcjjdl7faiixzYJ2kYzIBULQUf8BNL
 +xtRHOJKwCPiSumR0aedViKu/ClbUprUd/K0OqcOT4UM8tKCmIXHEd5XvobGoJIgTdMV
 6BkGptOagm8XrRjN/1yODa9/7gGfbj+qrAA4AeimUiMYl5vF0lB2/X1SOw24TtJVitQ5
 sSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626797; x=1707231597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zRxwzBg1JPAeksvDXKolStU0KP7INqkx8/kV22Vx3g=;
 b=JBJIW7+l0eyxp6TZ+c+Ku0J4Wg0icImaRYN2REcPJWeluoy8kseEwkKB2kO4AExfpO
 Kpv9aKh4gljp41TR69gmklMNoZydyk0DEyqxZ5JMXlPEPzYw23uZ4RfzCxS+ds+oB5mb
 ERqpb39KQ0VZFdUdCL6HaOA2DkyCU7qHAB+NojrLiSlSsFcn6vugvuTKcly167z/Aaio
 H94HJhEFnmW9z3Kjz5B5u25vAJNrj8+Cah2SvHRANqFMgAv5GErmL+U4f2RIgWM/XARR
 82hBvdKKpkevuBWpS5iPoHqQz7u3ttP5BdLlwoK9/R8P3XfLcjI1FsrsMvk4ibMB37z8
 TOPw==
X-Gm-Message-State: AOJu0Yy7cgfkyCTZttNnBIPyjsuTZCqy72Rg7+X0/7O2ik0PdRAEZ+Sl
 h3+5yvQbEwcYV2DAcw1gqK7Q6K8sPdeadJVrqIJHjv97xkWTlAXdxu+XwEerDBuWUR0n9vv4Zco
 /UoQ=
X-Google-Smtp-Source: AGHT+IGEntHLwr3UyB+ordx9X5bXLEWpQOfPw0oq4o+YZ5M4uPsmPNdluo68E1gW6wLPK6dScFjwmQ==
X-Received: by 2002:a05:600c:3151:b0:40f:afd6:b266 with SMTP id
 h17-20020a05600c315100b0040fafd6b266mr625053wmo.18.1706626797413; 
 Tue, 30 Jan 2024 06:59:57 -0800 (PST)
Received: from localhost.localdomain (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b0040ec6d7420csm17078648wmb.14.2024.01.30.06.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:59:57 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 1/3] hw/display/virtio-gpu.c: use reset_bh class method
Date: Tue, 30 Jan 2024 16:59:19 +0200
Message-Id: <87fb4fa72ce5b341a6f957513a00dcb79fd5997f.1706626470.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
References: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
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



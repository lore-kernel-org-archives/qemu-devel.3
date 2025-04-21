Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58453C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 12:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6q6P-0003IH-HM; Mon, 21 Apr 2025 08:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5e-00038y-DF
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u6q5a-0002Rv-RZ
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 08:17:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so2562695a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745237849; x=1745842649;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h5SWbPOSj3NpGG3m/zqqFXdgXnCCZaeQWYiosjCG7JM=;
 b=PX7aZmAdYoECqU4zFbUFNVzR0QRrVXaOJZlt9Vk57Q0GgFAIPV69HVRir6UxB3M4zq
 pEMX0BkkQo5mIJKLVlmX/O+wYxaAcj2bRV8as6DX7j3g4Q8Mb1FExqnuSC4T0fn2T1+J
 Ez216uUoz6vYrwAk0JEg1UkBHIoeAoaL/6LBYQC8JYqsK/1kI20/DT/z52rSfru0eH5j
 3Xpq1a8yoLa5dSWk6mhj58Cq8jsEQxQp7YPfDx+DTs9dYwOkLZuwXF06/+OyPt1WDsY1
 sqCBpQ+7EFwfZqCODX0fYnjzJaqxvEIZ/ltFWog3ZbkEi2hOlIZPAmBBXDXhUyGfaE2e
 q+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745237849; x=1745842649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5SWbPOSj3NpGG3m/zqqFXdgXnCCZaeQWYiosjCG7JM=;
 b=pe/wSUqkki9R12LaQLQxM/PisPgv0B94vuFrD3MxRls1mnECPh4sCxBn9xZ+5ttD5g
 4Cy5znKqJegCC2xzxxUwrgPsWgIIZtfJQKT1OVm5MYrULaqrsjZsqUTvmOXW8rsdaGmb
 UW9/4P4a4ZNK0RScaefloyd14WbBlNG1obXdfUq+bj8VYG0hTcbKRBaOHWP3babc2AJR
 Jq5qJ4ejWnQX/mIrP9x0nJf3okiRdro89EaRbwJHQ7v5rsn3xtorpvXLX/0fbLMxw2Od
 hM6GgH3h7/RaqhDW2yuSV+wVaull/bFjMv28mSOOpAEl4WU/ha5dNHzYO+a4biu6Jr6X
 MGug==
X-Gm-Message-State: AOJu0Yx2BI5xSi5+WvZBn0jpvNoaeQ36BbatTdsNyi8R2nlcdf1+/qP3
 dOD6WpO3Z8XuY+57u3OXFrLgZ8czcLuwn6B9lByo0FC8zgX+WOY2pIPE7LHpxIA=
X-Gm-Gg: ASbGncuO4qzG3nVqOnWd325Ms/CuAziLLMFWQ2w5gFWi6C6q53fNfyG4flnhn8uhRqN
 yOPw3Qv2iOWEzbR33S36stq0JbqnaI0Lxi3usi8yRacYnU3ULM7lmLbJfdfpwvtE5TD6gGIPfm7
 oP5qj5/sN677h42LDS+JTLI1AmLNLYcejrum/73tB6xWYdzaHs0YOlyOCITeayaRoW2e4mBakhr
 HSuOIudQycG0KNeGHQE8g4XHR4IIwvgiXEaz8KCXrsKyO/FaU5KD9ACzhanVcFQvJpEPyGk5oQL
 p84cEx18TB12wAXw7k+623fJHAbAbU1nUeUeN9R80F7PeI8=
X-Google-Smtp-Source: AGHT+IFqpFK+lg2fNHO0zFDY+S1zWnl4QZd7xyF+I0E8kUpim1XUmjP3UUSVanF08cQAEmRsH9Sk9Q==
X-Received: by 2002:a17:90b:3d06:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-3087bbb6b01mr15857948a91.30.1745237849251; 
 Mon, 21 Apr 2025 05:17:29 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3087dee87f8sm6426722a91.4.2025.04.21.05.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 05:17:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 21 Apr 2025 21:17:20 +0900
Subject: [PATCH v2 1/2] virtio: Call set_features during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-reset-v2-1-e4c1ead88ea1@daynix.com>
References: <20250421-reset-v2-0-e4c1ead88ea1@daynix.com>
In-Reply-To: <20250421-reset-v2-0-e4c1ead88ea1@daynix.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

virtio-net expects set_features() will be called when the feature set
used by the guest changes to update the number of virtqueues but it is
not called during reset, which will clear all features, leaving the
queues added for VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS. Not only these
extra queues are visible to the guest, they will cause segmentation
fault during migration.

Call set_features() during reset to remove those queues for virtio-net
as we call set_status(). It will also prevent similar bugs for
virtio-net and other devices in the future.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Buglink: https://issues.redhat.com/browse/RHEL-73842
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3744..755260981efd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2316,6 +2316,8 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
+static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val);
+
 void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -2346,7 +2348,7 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    vdev->guest_features = 0;
+    virtio_set_features_nocheck(vdev, 0);
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;

-- 
2.49.0



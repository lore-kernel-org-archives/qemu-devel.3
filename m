Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E530CFEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z2Y-0001BA-LX; Tue, 17 Mar 2026 14:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2W-000198-Fz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:13 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2V-0002tB-5G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:12 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so595105eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773771669; x=1774376469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MzRVprj61Gyv11VqdvdVphNrBFaUcy37KCZX6QpUas=;
 b=hq+XcBb2uLGD8fOVHzmgy1ly4FD1TwlBaf2WA7Z7WE8F/NUYyWv4LqHfpJR4SNwkuA
 bFmD7jbmoEiHsyHwrgZNr5NApohTEC3Pd0s10vEAtkNmTvLiuHTTwFgEvxLTHcBQ/45Z
 1O6mTOsgDhcl7FfSHTUHj1fOzqP5ZrDz3CRbn2d+UdKyM3OkK/e4375++9oeyJWIu7bN
 I38WaUmL1jEOvhHqIcEqsVYFRzg7dWjuFnZKdYHCedznvlH8OIF9jZFcC5xpA26DylPF
 evaS0t29kCr4Ma1a4yqEo+SlY81I2K34flnfBmkwq2PTFnsXxqh5qUMf6+HkwBOiUHIx
 6E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773771669; x=1774376469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MzRVprj61Gyv11VqdvdVphNrBFaUcy37KCZX6QpUas=;
 b=IefCCkoWvm5u2tT/nZAZqxlMUfPIoi0EucL1ewV8oHe2TT+lfBrpVC2qvSpucwpEM5
 IOF77Zma6Mj9fYyP97iIH3jga1283ZyWmmillDn3Db3WfwjhBgrDzAJ3Nmxerrc3NV6U
 rT7zorurAQxfxpm6G0xe5xH6Qz1N8Dtswcs7cxgXiwiwVuW1IuORV9LvfpDlcDVkqxOh
 yEDWRgrsAe5k2UJ0ofIq7TM1iYc8svADMJREBqWpXaG9wz1Y+ymy1fG0+HYCN7HyP8IM
 LR1nQWVuP9hImV1YJqXwVPWMSiqtYrabx0BIOCDUYjczN+4r/1WyK5gMVWtMQXOblhoY
 r6nw==
X-Gm-Message-State: AOJu0Yy5ERzCW2d5essNGgawRmqbDucZ4IZhvxVq3ZaAQA+87brupXwn
 OahBTHhjTpnTCyvYgDZws7liY9P9yua8Z5iFZEHrnpzIExboe9jk6IDC8ZEJoL+S
X-Gm-Gg: ATEYQzw9i+jDzfXxAUmoiFFz1A0pp7N3ZM6n7nUAx5Fu9tEJXzPSXGQqX0b0R0tzOrz
 U35PZMdiieRKKeo0igTWNSX2zhDr3tOlGXI0sl/Az130B4MAtgnj6HZQPTwguymzcL0bdC9t2+1
 bM2nGTrGONSetOzbsvc2Yn1usGb6uRp3Ln3Eguv980ruYaiYtGsT1z1Xzk2Ard0X/9wdoPYtx+6
 htuZ12+ZhsZ9kC7CGgSqnOoIpRC/ajFHyumHPGsZyJEmy+xIxA743AvNLS0ahyHGaZ+xaflsF32
 pAs49NtsydTPq38Ey244R5mjxUZSDO54Otlwc5balsG63iqYR3EZF+q/6FBP3idQMMroDQkU8L8
 wl/oxHI7E9JhBNgugs6YEg7ZKKrtFQg6V2O1zBgTaAnH6hBg4lBMkeo8yr926QgHBXiOMt8r4aE
 7w5zL0EwDAq/bstwSWRAVhBSzYJbXw0DkCkM2NwRT9yRi3kOQD5pmf
X-Received: by 2002:a05:7300:1496:b0:2be:142f:d499 with SMTP id
 5a478bee46e88-2c0e50206damr253935eec.16.1773771668840; 
 Tue, 17 Mar 2026 11:21:08 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a53fcsm457367eec.24.2026.03.17.11.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 11:21:08 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, visitorckw@gmail.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 4/4] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Tue, 17 Mar 2026 15:20:49 -0300
Message-ID: <20260317182049.33848-5-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317182049.33848-1-lucaaamaral@gmail.com>
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Set blob_alignment to the host page size so the guest kernel can
align blob BAR offsets accordingly, avoiding alignment mismatches
with the VMM's memory mapping API (e.g., hv_vm_map on macOS).

Guest-side kernel support (drm_mm alignment) is pending upstream
Linux merge.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/virtio-gpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index de7a86a7..44ae5034 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1532,6 +1532,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    /*
+     * TODO: guest-side F_BLOB_ALIGNMENT support pending upstream Linux merge
+     * (Sergio Lopez's patches, Nov 2025). Until merged, the guest won't
+     * negotiate this feature. The host advertises it per OASIS virtio spec.
+     */
+    g->parent_obj.virtio_config.blob_alignment =
+        cpu_to_le32(qemu_real_host_page_size());
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
-- 
2.52.0



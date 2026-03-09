Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B81BFCA19C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu3-0003Ly-3w; Mon, 09 Mar 2026 18:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTx-0000wp-Lv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:45 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTw-0002FT-8T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:45 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so10445468eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092983; x=1773697783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRy630b/C64TmInOG+Y7NIlU7vA0v8fJC7yC/ESuVdk=;
 b=YvlN6qs0SDfPVLCJEIqgzUYCdU3hJgrUpbAxH/Ubeoubp9QdZIDoVJs7opOD20K4nR
 /5umZ1Ak7Lfm0HYynL9svjZzWQo8NjaBxXzB1ruPLKgUHsfW2/tzZHHqO8gneQk7SJEr
 qMTpOnxR2D6fDVbP3069xOBqWgbkVYBKk4EfauhTae+dvvjhyL5Fbat0IAHu6FzcYM5J
 jnsRSpDLe9qr4qWcmnCNNK3hMdmNTUQsFQEGvZJ77shqNjPEqrDHShT0kun1ym70UZN7
 fjG+8QiQEMSjQieQUrWxKDJ3BZGLf6HFAs0CCiBy5SWg8g5xl1JztYKvvZvBZkgRUMhd
 l/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092983; x=1773697783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aRy630b/C64TmInOG+Y7NIlU7vA0v8fJC7yC/ESuVdk=;
 b=fuhFAvVvBEkMeNDjyPoTf45M2C08wXJADGHPM+ar1aEIJ+QvyKSaWPpe8PmzgLA9JW
 T+SuCMcrgyu/2eZCT6s1/5U2NwK/tgRljBMpQYUCRCWvHLMFyk5fmFXye/ESMjgwGQOL
 unGGx4iVPfxb2iPqEC/p8E2oeBbcBEC2gX2OgQz1BkbY+Bzi7EQLjO7zoX0TAGHW1grK
 vBjSx8csMRfuPw+4r9JdOSFiS/amwV48RTsHiK22oifADJvZ/ITtIMNqdb0dPIadLqTt
 Suea6M4ODCM6SmiAngxHCLSvnEl7sLYULs2FvqsitSVab4OeIdvGKvPKEdCG+f+a6zn6
 oUSg==
X-Gm-Message-State: AOJu0YzEQseUfqRB96QEI9Noj81oUaA18zoFXnRjsrp7qCgkxqm2R5KD
 U85PQMm0HW2aKQgIRWajgkfk6tOHBygTR0lYFhyai1cquTXvhtVzbqHhOertu5/i
X-Gm-Gg: ATEYQzzuzXXPlBTnev4Jx7nVexvsvUgtnRDNsbpk34SrVKe4MkaRN7xS6iGsnywnSWr
 t0lrJA22WVLPtenKYKZHFCSEGCibEsrG6IHm9WwGuaMKtOBuzclMNj1EwrOdKyJvfuyrHk9nCPH
 LAFd0mewLXqSOW1p/x9bFWcGjl6KSPPnszjEHcnW6Sq8fEwLlrQJWAHZ7+nJ8V9rRH4JCf10NEN
 IQbQ8VeRf4Xpnu47o5Rd2QIu0OtASH6Rv7XY7Vtv6VOlYlJ21s+qS3hTi5/N+/cKMbHYZ34uWdS
 kiG8Rq4j/MzsxNVZ7SLc1pDuhSRTHvkIRC8gZMGlJVWbommGDZmKj5KJW8dkclUdo+A7qAFt9me
 o5fYtfOyXlAqIvEN1AaqFotT4PfEr/EOfLDIWzgf25GgPDG0Bf70jR+J9z6Q8VNp0wlWsQguwKV
 mWZdlUzx8B42cHq/+w4tCZdyPCKFEsCJgKUrEmnvTkVDyBq8L7TogJIcJcxXl0Kwel5biMDQ==
X-Received: by 2002:a05:7300:6da2:b0:2ba:8018:cc62 with SMTP id
 5a478bee46e88-2be4e0abd99mr5516246eec.38.1773092982586; 
 Mon, 09 Mar 2026 14:49:42 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f96f25bsm10519495eec.28.2026.03.09.14.49.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:42 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 3/3] virtio-gpu: advertise and populate blob alignment
Date: Mon,  9 Mar 2026 18:49:30 -0300
Message-ID: <20260309214930.92616-4-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214930.92616-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

Set blob_alignment in the device configuration to the host page size
so the guest kernel can align blob BAR offsets accordingly, avoiding
alignment mismatches with the VMM's memory mapping API (e.g.,
hv_vm_map on macOS).

Uses VIRTIO_GPU_F_BLOB_ALIGNMENT defined in the preceding header
patch, and advertised via the feature bit in get_features.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/virtio-gpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 643e91c..15e8be0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1517,6 +1517,13 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    /*
+     * Advertise blob alignment so the guest kernel can align BAR offsets.
+     * Guest-side F_BLOB_ALIGNMENT support pending upstream Linux merge.
+     */
+    g->parent_obj.virtio_config.blob_alignment =
+        cpu_to_le32(qemu_real_host_page_size());
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
-- 
2.52.0



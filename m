Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D481FCA191
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu2-0003Lg-6z; Mon, 09 Mar 2026 18:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTt-0000wR-2y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:41 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTr-0002F1-Jl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:40 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2be06c02f66so6730740eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092978; x=1773697778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfgq0MtHKeMNXSCkoTP/2cVolEkmyv7Uf/M+1C5FJpA=;
 b=R/8jk6rb9dws9rZZKjaqrd3yORAuC9aiEyi586ExD/25PfovOy1thI2bjEoTdnLtxU
 QtMXs7gtxUhyjCyipykSsxDt8hOsiUd/fTwfTmr+C0aKlTRZJIpB4pafO0Za1e2WcXi7
 aCFpaWR7CGFNkL5Y9HlWhxIY7pNOr1Uc8jqdmUTgMzaAJhwdTTn2Y9HAJBF1GaRk4nnZ
 6ULHqTmGIpBwkS9XadYc+Wm3zXvRm5pKnFL0Asi8AXfXZbSXOPtykLSIDmXjZyl0osxo
 pHsRs84SHTmNPBZeHWGi1mmBOksVDfn6aiIhIq0RKeM7pEu3+skdokXRDjDSX0sk0lo5
 7QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092978; x=1773697778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfgq0MtHKeMNXSCkoTP/2cVolEkmyv7Uf/M+1C5FJpA=;
 b=oE0iizn0rebKCwfjPk2T+29BYW0ABFuBkmTHJ6RXG7SuVaLIHuk05fIxQsJMXyN270
 v6+2jS9ChUG81CDSdXxysqOmferB4nGvwAC/HmwgGmy8WWjf6Z9NWa+IUpgHnKeYfOAL
 QZOyh7CuadpLHy3/ntTK7qil9e7/CSRoKWksDRIgE6UoGzL/vDwyNQTl7/6+/LwCb/iP
 PzkjgRrx6lhW09xyXxjMwHGg2GsntC6HRUCS/uGQSd7DpAqGDAxse4nF79ynb1E/ZXYk
 L12CwWE/BXnuuVF3tTNUQ+bNjraH1AI5RfrpfuoZiurG5ebV+7lNgwXmEVSNUh4BIPxS
 uyCw==
X-Gm-Message-State: AOJu0Yx/OQc2wDbQ2HcM6wtsUlHnfO9TFkgBy01HHuswBkfEI+FmLkpw
 1jrlVgMqmLB0HG5gbfXhcW4TlUWdhg56F+HvvPNMzWljYF6VuJrRKsWrrxJ9xkvk
X-Gm-Gg: ATEYQzzU72CQBMkq4HAxKIdJKwJHcnMgJNznVBd7Pi1GNkMXFjkCGXzWIxR96tNPCX0
 VJACo/UWVdDil2j4wA0ubdzrScEe+Rt+qOldMN5+V35V5rZAF6omG4yJi3LafwjuXQgScZSEqZV
 l6jj7EQmUYVQ7SRkE+hhAdqymPrpn1wtKS1qllcQLvnNXapqPVTGdDCHnUIsFly/vWUzoQurKVY
 qtPPm+eEzcGLtwD5PBAcfS5ktqzXzRd6cwwJCr+sij4z7rj/wxxQuLNHfihFtsJbbMYO5pvIowW
 vWlFQFady9jfyg+y1L1U2uIFlwOVMBRbi66TFjz5xamPo6gv7SGk0IHC0E1qQAo6j0pIl4BWA7J
 gEgfSyO2RdfyzPejRZ0zBI3IIpvay7hGh9GPbRGP6NZEiJAotD4aMX4bKXinarMaZHIIW2qY3xK
 +NadJ59mAbUpKbWOplifzqKIGotIiS/lvz4mQr/ahvzVP2ZIs5mAOKvvhtkl8Vq005lq4P9A==
X-Received: by 2002:a05:7301:1004:b0:2be:142f:d48a with SMTP id
 5a478bee46e88-2be4e092254mr4713193eec.27.1773092977817; 
 Mon, 09 Mar 2026 14:49:37 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f96f25bsm10519495eec.28.2026.03.09.14.49.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:37 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 1/3] include/standard-headers: add VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Mon,  9 Mar 2026 18:49:28 -0300
Message-ID: <20260309214930.92616-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214930.92616-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132d.google.com
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

Define VIRTIO_GPU_F_BLOB_ALIGNMENT (feature bit 5) per the OASIS
virtio specification and add the blob_alignment field to struct
virtio_gpu_config.

This allows the host to communicate its memory alignment requirement
to the guest via the device configuration space.

Header-only change, no functional impact.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 include/standard-headers/linux/virtio_gpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f0..252704e 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -64,6 +64,11 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * VIRTIO_GPU_F_BLOB_ALIGNMENT: device advertises blob_alignment
+ * in virtio_gpu_config (OASIS virtio-spec feature bit 5)
+ */
+#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -365,6 +370,7 @@ struct virtio_gpu_config {
 	uint32_t events_clear;
 	uint32_t num_scanouts;
 	uint32_t num_capsets;
+	uint32_t blob_alignment;
 };
 
 /* simple formats for fbcon/X use */
-- 
2.52.0



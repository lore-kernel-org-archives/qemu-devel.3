Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0C9FED9FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YYi-0005jv-SA; Tue, 17 Mar 2026 13:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXw-00051K-FA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:38 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2YXv-0007AA-66
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:49:36 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso145363eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773769773; x=1774374573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MzRVprj61Gyv11VqdvdVphNrBFaUcy37KCZX6QpUas=;
 b=i7B5wQ3KU2T3Y3YFx/bvTaVtG6kjTHYgprJHTquQuynMis0JeRf9Hxg2plSrBVP0Mk
 U4bKmUdron1GUHE2EQ0RZ0SG7zPLkV4YIcgZhvESv/9oyr2LYhldBQljHjF5MUR4xxOI
 4nfXMRS9N75rpE+DqcpQaZg9KEfOzCskq5lSCIj5hkMBtg4BYiKss/cDBerXrhgYVNxM
 1RKle0qgxo86AoMOkgNOphA0KX2mpM5MTVlwMHRihUk2Rtnjg0lZZ7sndTXA2jpHjvIY
 QHjV/4J5S8VHfWvgMpzCkOl6hMFC6F0ERugjiE8ELjD8+VzlYmEPeGEB93VYeN20LnU5
 yOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769773; x=1774374573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MzRVprj61Gyv11VqdvdVphNrBFaUcy37KCZX6QpUas=;
 b=BvYkeaCQlxT19+ZbY8Rjv6HJpQfIq1G1QkDb/eVE7xoBgrARcfmHoeuTQFjUFIa6Px
 WMOz6W45qkwOOutcceTnV+ghiTG/UG5iwQixLhG796c19kWn4XUxuag/InZ/2wklX63J
 j++r+O7jdSpMLF805mjc27V3rtJx+o40ub0IEtRSHmwQuZ85lUxYx/qTujtOQUz1wxY9
 uJI+EBwJ1hT44V1eneIU2y0SXax9CW8RMxpEcK1cMize5w0f0Pykp2EvMgkkG2Kc8Bc6
 NT6GImtPwe7vumZNekviL6UJkX+RB4K6YeqN0rvGZVer01Vnk6Ul7PJpXgensth3bg6c
 OekQ==
X-Gm-Message-State: AOJu0YwLxCWcCdp7cUYGUHZ+SP3kTnr+NziuD/FMHfjrX3ZfixypEQK4
 TYwHSgrLppfS5vtx9eesK/t779Gz8VfO/mhYhMdo/IxnZoQUPdaUqHsiLnYHoeJv
X-Gm-Gg: ATEYQzxJV1izAc137BCQii8GMYFlQjNn/SMRXvERyw3weS9U+VzNP9pimc3dQZrgTNn
 vSRp6Th0BNSmGDPBPqihqLwqaceqPfL+R2cqEZlA+JGDDU6wfgEx2LD2imMBTuGUsbnNNRmUWD9
 W41QOuXPQBiQY1+EcPY+pMTeo7C0mhjk5/QuN0VHseMj0SBRjsWLyghJ8HxREfZKSxklnsgAKZv
 UHJGt5OWF1wxTF4ewzL2cn5jCqp+zdxd0IIwhnld2h6JI5pZTpe2wquwomxEaZgclWGOMsmwF1l
 m6DVetxsQg2vx4k0fRJJicF+6Cr/czVUvL5uWkb/VWvCaVlN6qgi3uyfCdj8hL3a63C2niPxkX1
 a7KbKE4/ddaCRBJgH1KB3atw1J6Sgs9mHV8Kg50jFk7Zy286Gp648Nu+myQWp8+9foZwG/CmmIh
 LzkEBEYPq8AaJxGZ6BjMPXUtPVbI1a+oJGL2O/PFhvNNCwxep/YAzP
X-Received: by 2002:a05:7300:7fa8:b0:2c0:ca48:3107 with SMTP id
 5a478bee46e88-2c0d5248965mr1601952eec.15.1773769773222; 
 Tue, 17 Mar 2026 10:49:33 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e536896csm282115eec.3.2026.03.17.10.49.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 10:49:33 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v4 4/4] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Tue, 17 Mar 2026 14:49:15 -0300
Message-ID: <20260317174915.31829-5-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317174915.31829-1-lucaaamaral@gmail.com>
References: <20260317174915.31829-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1335.google.com
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



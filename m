Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C6C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASo-0000Z1-LC; Sun, 22 Feb 2026 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASm-0000It-Jp
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASk-00072A-Au
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKkPVQcUkW331rdfnbO03ZD7znaM0qOM81kMUIFvtcA=;
 b=iUr1kcJ6V/NCM/Ojk1/88ySMdyPnrHl/YEoD3evFhOQtd4JLNlaLdbSmbdKvRwDwG4Kyeo
 HrBx/shw1JcKv4jic71S3S0ZwF2dOVU5W57h4Sc2Jkkr9kv0pAZzbUAQvAjL0uFClRg845
 gmiyAFr1CDB+EnWJ2Iew0J9JKgTOWus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-I4xSJUO3NmOe0VNpmagAOQ-1; Sun, 22 Feb 2026 09:29:32 -0500
X-MC-Unique: I4xSJUO3NmOe0VNpmagAOQ-1
X-Mimecast-MFC-AGG-ID: I4xSJUO3NmOe0VNpmagAOQ_1771770571
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so38834705e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770571; x=1772375371; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKkPVQcUkW331rdfnbO03ZD7znaM0qOM81kMUIFvtcA=;
 b=IX8rIribQt4qN3BuwcXUMIawjPk5wIOf7tP4ZEFm1Px/DjFD2MqED5Ligtpfe6nThq
 oyWv1sLdo3pC7rm9DE0+sxfOwH3+dhSjM3LHje6/vnK/LYc0juIGr7gkfEJzLmclYQMU
 ANz3uELgEZa6csKnxUZUjNDUSPLi1lXO+d1LP2xelRitl91eGH6A+00TeG+WLLFNwP8l
 obr/JkbXGBJgeAg1NiF3Z90Rrj2qZfstYBob3EaifqlIJU6isPWJOVEe2Q3rDWe1N9F7
 hm44flYtPiZDr4kiodRTcDKNnr8hdHFfR3xIpl8nJh5KVibOMKXDxrFz3TBzbvGcDIMn
 AF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770571; x=1772375371;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKkPVQcUkW331rdfnbO03ZD7znaM0qOM81kMUIFvtcA=;
 b=JyaIbK4CzOmsIexcXFsxzCtZ8Wtc8JVVLwdsxIRlzE1vHpzzNQpy4givfMU0S7UK8D
 vPGS6EozhL3Ib14lAR48a8ADSeeZ7KOMceU2cGhtbhdy/5XN2oDIlXcymX3sg2ybGITp
 7bmZEn+eK/EpsI6hCHW52xWa9IZafCal7JcaJgJo+RDIwXNmn2egfZSemKzbrGDB4qON
 cNLBq0LAWBurcwBijhx3EVaY1UWQyRroy1lr7v6k5PTqgUrf2ibHMe3RbkuDwkXHLdbR
 3xIkWwKrC692Z7WtkEQPj7P5j8KKkki4atrRXa1aPJRNKMuRmCL7yz94VWlsBV+5+uzR
 u4yQ==
X-Gm-Message-State: AOJu0YzFBMSAPhJj+IUsaMo7eoym0u76ORNxRd2OQH4h2fhKY26483Iw
 N6J1+5ByZpyK/yKc98nyJeCoTOv/GM9GrRFxo9F2PHQFV4KzFgWbve6a+fPOF8lWP8R79WSi4Mt
 LajTAau1j0NlHX04kqpWXe60f/B/uI7ao9t0EcsAcVlZtiDyMcuPOx2EnEic2had50ug+Vy2Jrb
 0+vIHW10jAY2bq9BPpwhM36kWu4i0WBJJk9w==
X-Gm-Gg: AZuq6aKtu+frS6hIzXoBSNc4o94b9KiNX+eG9vSuUHEN52PWK3YhHF68Gv03P8bavxp
 G5kff+Orc+0m5DHD7CvH3XiFjGeDf3zxMW/nhT6t1hKE0A0JY+rW5ElJhb7MX94Eu+ydYc3vSNl
 dwkarQ2TYAG+LqQnM8fqx6f8eIXQQi8hz/isIC0V8ojZ4ECmOfifaPz8GtWBUhxPzju/FaZoo/x
 Ka/Dd7Ivq7OrPxF6YlOQymdjp1aL3TbzEybGd6jZFPakq1OKEtwSYm0t4vbaWaJWOQDVedQXfus
 euWFs2MkeE8JXPDPdM9RjcHsCApkPdwAhmDQatCBQa3WbYjR70uzZdqTwl8b4h5p4PxoNv6qzdO
 s49RZ0+v1VK/7pEh2JKB3tH+DaJLJ+f3d2VweevLxK8ps4w==
X-Received: by 2002:a05:600c:3b11:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483a95b5a72mr99732165e9.7.1771770570811; 
 Sun, 22 Feb 2026 06:29:30 -0800 (PST)
X-Received: by 2002:a05:600c:3b11:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483a95b5a72mr99731805e9.7.1771770570290; 
 Sun, 22 Feb 2026 06:29:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b66932sm134821565e9.1.2026.02.22.06.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:29 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org, =?utf-8?B?572X6ZOt5rqQ?= <myluo24@m.fudan.edu.cn>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 30/33] virtio-snd: handle 5.14.6.2 for PCM_INFO properly
Message-ID: <61679d7dcfa2dffc8fb115aa19b09e0e7cf5ea5c.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The section 5.14.6.2 of the VIRTIO spec says:

  5.14.6.2 Driver Requirements: Item Information Request

  - The driver MUST NOT set start_id and count such that start_id +
    count is greater than the total number of particular items that is
    indicated in the device configuration space.

  - The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
    count * size bytes for the response.

While we performed some check for the second requirement, it failed to
check for integer overflow.

Add also a check for the first requirement, which should limit exposure
to any overflow, since realistically the number of streams will be low
enough in value such that overflow is improbable.

Cc: qemu-stable@nongnu.org
Reported-by: 罗铭源 <myluo24@m.fudan.edu.cn>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-3-207c4f7200a2@linaro.org>
---
 hw/audio/virtio-snd.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 232179a04a..ae8bfbca43 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -156,7 +156,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
 static void virtio_snd_handle_pcm_info(VirtIOSound *s,
                                        virtio_snd_ctrl_command *cmd)
 {
-    uint32_t stream_id, start_id, count, size;
+    uint32_t stream_id, start_id, count, size, tmp;
     virtio_snd_pcm_info val;
     virtio_snd_query_info req;
     VirtIOSoundPCMStream *stream = NULL;
@@ -179,11 +179,34 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
     count = le32_to_cpu(req.count);
     size = le32_to_cpu(req.size);
 
-    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
-        sizeof(virtio_snd_hdr) + size * count) {
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST NOT set start_id and count such that start_id + count
+     * is greater than the total number of particular items that is indicated
+     * in the device configuration space."
+     */
+    if (start_id > s->snd_conf.streams
+        || !g_uint_checked_add(&tmp, start_id, count)
+        || start_id + count > s->snd_conf.streams) {
+        error_report("pcm info: start_id + count is greater than the total "
+                     "number of streams, got: start_id = %u, count = %u",
+                     start_id, count);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    /*
+     * 5.14.6.2 Driver Requirements: Item Information Request
+     * "The driver MUST provide a buffer of sizeof(struct virtio_snd_hdr) +
+     * count * size bytes for the response."
+     */
+    if (!g_uint_checked_mul(&tmp, size, count)
+        || !g_uint_checked_add(&tmp, tmp, sizeof(virtio_snd_hdr))
+        || iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
+           sizeof(virtio_snd_hdr) + size * count) {
         error_report("pcm info: buffer too small, got: %zu, needed: %zu",
                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
-                sizeof(virtio_snd_pcm_info));
+                sizeof(virtio_snd_pcm_info) * count);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
-- 
MST



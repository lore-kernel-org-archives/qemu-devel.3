Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A5606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rBa2jEc1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDE-0003N3-0r; Mon, 02 Nov 2026 08:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCu-0003BV-JH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCs-0002Gz-CW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:16 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1752297f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626572; x=1794231372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mmVw4PAREacnk1QlTtQFO6RVNDIuzIxLpYdIX1G7VyY=;
 b=rBa2jEc1p76ydQiw9nIvNM8HsQn1VdKqBpdDy45bkGJFeN6gRGtTyWQXvVoRwzWG2x
 gW3Ey1mRFS4SEtWfWRRWLQ7iGNX/0XBDb8lOkzbp2xs/ayvHLdnwIET1ESoO6hh/PfYm
 ft4u2exYQCGvl6zfrjaGNSN76atw8dvnbAJf+GghyBZ6+1LmJ9T4aIa9LdzSnSeqRkwE
 jUxn+Ebk+zulYvLjT3O1Sz439ma+Utj/N6psPJJANQESxgIZGLz6QLwGwgd6mFWi3kAL
 FWEd8un/GTQ1M/crOUT0z8HHXx00+8mBhjwN5gCtOkrmw3YbqY9B8w1EpCqXgWIYf54D
 c7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626572; x=1794231372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mmVw4PAREacnk1QlTtQFO6RVNDIuzIxLpYdIX1G7VyY=;
 b=A9oTKu9q2yQN7eE7ecSqBh8NZYCXbPyIzVHGeZa6empe1lB2PEMfCeUneUnKOwP8pd
 UV/oInZeEnw/tzQItP/3DPGzX09bXIgV0wxXOkGoRfAA0j8to8NZb57wtzq9DBXaFPp8
 qocCk+C+ZQuezFnadHdsbnHs0G4U7o3v4j0zjbq77re4YAVT/JdqSLJGSa0xY/vE4wSy
 M1+JkygSwTfoMR4CTep/ZyoxTSKCALLBm9ArWDivEx5CoYATfvyqi0CVzcnfQOT8VbrV
 JZwybnnxXe6LcYGqcUR94k+iPDEMVTvySQSTDeDMyFEkJ6GCSdz065A9OJYoKw52+azj
 2hsw==
X-Gm-Message-State: APuU4Z9O10VSHYr5pmdkdCHpfUgXriQaSCE2fBwu91reu01D+DxtIHyr
 zcYSEbbIky0R7WJngz4As07gJ9qV2mNOfQaQHPSG93n0PDvJ4tguAGxwLCsPTjEJ1drjqn9Oz0m
 WRShRuvI=
X-Gm-Gg: AYBFou22s3Mfu3bhY/XcCny6n452apkX1QPw+O0dz3NfUDszUOwM12Elh51zaCVGkfE
 ew/6uLxDHNC6pU0CTBNEqVCl7uJF0+2OajTEqQnTilfFXaQ8lohTeMyx1okbpdSMcX1h/Lw3NSz
 ul/ysE6JveZMv2Ijs5ZWJ1rq3h+gAhUp3iPuKf9/GgDxqDfleieKn/fCna49or5JertEGmASEoj
 pcAp89bR7IGld7hyeXdkr7HyKJ7/p7Cxr3qOtBbcFeDXD7BHd/Mm0m7GzGcHf/MisM0IN6JaKkN
 fEInRR6HyqkUPJ8X8FTpEFw8hUAjs34SHSOUh+6Lob5mKd42Hmur/Wr0tkHggWAYRRSN4fSzUxH
 0Oet4RsYbAg57/zC151GIVtM9iaffR3pEM2xB4w1CTW0YR7s4nBZneUqmKaFqG84X7OBnCrz2II
 de/8KXYA6DmFD8GxXOZE+MzlylR+6aZBNwCiE5RKUaOR+Z9RV4TcuMufRu/Umxixaxtfia8T1qq
 PqNEL3HKuujkawyl4Z8v4g6vxS1CrCQIYeFZ3HxNYYmt9xmyTKV9ADqUU0ewjWqaJQHoubCS1Bb
 eQLgI5O69wlNxTBwIrx1IYYy9pVp1PzLQwZLveEPn73ZUTTbzF63uAX1rDNBLnbNaWoZqwNGvbi
 /5+6eSIO09H5aBIo3hZ7loJYgLN0TxZ/YBQ==
X-Received: by 2002:a05:6000:2407:b0:48c:54c0:4cf3 with SMTP id
 ffacd0b85a97d-48e6e2ffc51mr23758017f8f.28.1793626571837; 
 Mon, 02 Nov 2026 05:36:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/47] hw/dma/xlnx_dpdma: Don't allow DMA off end of host
 buffers
Date: Mon,  2 Nov 2026 13:35:19 +0000
Message-ID: <20261102133547.1375701-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xlnx_dpdma DMA engine allows the guest to do DMA to host buffers
for audio and graphics data.  These buffers are set up by the xlnx_dp
device, which calls xlnx_dpdma_set_host_data_location() to tell the
DMA engine where they are.  However, this API doesn't provide any way
to say how big the host buffers are, and the DMA engine does not
check whether the guest is trying to write off the end of the buffer.

Add a length argument to xlnx_dpdma_set_host_data_location(), and
bounds check the guest's DMA writes against it.  The DPDMA ISR has
bits for each channel for "descriptor payload is too large", so we
report such overflows there.

Cc: qemu-stable@nongnu.org
Fixes: d3c6369a96a8 ("introduce xlnx-dpdma")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4134
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20261025110857.1973128-1-peter.maydell@linaro.org
---
 include/hw/dma/xlnx_dpdma.h |  5 +++--
 hw/display/xlnx_dp.c        | 30 ++++++++++++++++++++++++------
 hw/dma/xlnx_dpdma.c         | 13 ++++++++++++-
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 7cf67aef6e1..0fc24e23ad3 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -38,6 +38,7 @@ struct XlnxDPDMAState {
     MemoryRegion iomem;
     uint32_t registers[XLNX_DPDMA_REG_ARRAY_SIZE];
     uint8_t *data[6];
+    uint64_t datalen[6];
     bool operation_finished[6];
     qemu_irq irq;
 };
@@ -69,10 +70,10 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
  * @s The DPDMA state.
  * @channel The channel associated to the pointer.
  * @p The buffer where to store the data.
+ * @len: The length of the buffer in bytes.
  */
-/* XXX: add a maximum size arg and send an interrupt in case of overflow. */
 void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
-                                       void *p);
+                                       void *p, uint64_t len);
 
 /*
  * xlnx_dpdma_trigger_vsync_irq: Trigger a VSYNC IRQ when the display is
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index d6b4e7bba61..ad6c4952065 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -333,9 +333,11 @@ static inline void xlnx_dp_audio_activate(XlnxDPState *s)
                    & DP_TX_AUD_CTRL) != 0);
     audio_be_set_active_out(s->audio_be, s->amixer_output_stream, activated);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(0),
-                                      &s->audio_buffer_0);
+                                      &s->audio_buffer_0,
+                                      sizeof(s->audio_buffer_0));
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(1),
-                                      &s->audio_buffer_1);
+                                      &s->audio_buffer_1,
+                                      sizeof(s->audio_buffer_1));
 }
 
 static inline void xlnx_dp_audio_mix_buffer(XlnxDPState *s)
@@ -566,6 +568,18 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
     s->core_registers[DP_INTERRUPT_SIGNAL_STATE] |= 0x04;
 }
 
+/*
+ * Return the size of the surface in bytes. Pixman doesn't provide
+ * a helper function/accessor for this, so we must calculate it
+ * from the stride and height. Note that a pixman stride can
+ * potentially be negative, hence the abs().
+ */
+static inline uint64_t surface_data_size(DisplaySurface *s)
+{
+    /* Can't overflow because stride and height are both int */
+    return (uint64_t)abs(surface_stride(s)) * surface_height(s);
+}
+
 static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
@@ -580,7 +594,8 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);
         xlnx_dpdma_set_host_data_location(dma, DP_GRAPHIC_DMA_CHANNEL,
-                                          surface_data(surface));
+                                          surface_data(surface),
+                                          surface_data_size(surface));
     }
 }
 
@@ -644,9 +659,11 @@ static void xlnx_dp_recreate_surface(XlnxDPState *s)
         }
 
         xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
-                                            surface_data(s->g_plane.surface));
+                                          surface_data(s->g_plane.surface),
+                                          surface_data_size(s->g_plane.surface));
         xlnx_dpdma_set_host_data_location(s->dpdma, DP_VIDEO_DMA_CHANNEL,
-                                            surface_data(s->v_plane.surface));
+                                          surface_data(s->v_plane.surface),
+                                          surface_data_size(s->v_plane.surface));
     }
 }
 
@@ -1396,7 +1413,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     s->console = qemu_graphic_console_create(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
-                                      surface_data(surface));
+                                      surface_data(surface),
+                                      surface_data_size(surface));
 
     as.freq = 44100;
     as.nchannels = 2;
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 32f56036a4c..9d8e7593698 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -589,6 +589,7 @@ static void xlnx_dpdma_reset(DeviceState *dev)
 
     for (i = 0; i < 6; i++) {
         s->data[i] = NULL;
+        s->datalen[i] = 0;
         s->operation_finished[i] = true;
     }
 }
@@ -760,6 +761,14 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             int64_t transfer_len = xlnx_dpdma_desc_get_transfer_size(&desc);
             uint32_t line_size = xlnx_dpdma_desc_get_line_size(&desc);
             uint32_t line_stride = xlnx_dpdma_desc_get_line_stride(&desc);
+
+            if (transfer_len > s->datalen[channel]) {
+                s->registers[DPDMA_ISR] |= ((1 << 18) << channel);
+                xlnx_dpdma_update_irq(s);
+                DPRINTF("Descriptor payload too large..\n");
+                goto update_descriptor;
+            }
+
             if (xlnx_dpdma_desc_is_contiguous(&desc)) {
                 source_addr[0] = xlnx_dpdma_desc_get_source_address(&desc, 0);
                 while (transfer_len != 0) {
@@ -809,6 +818,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             }
         }
 
+    update_descriptor:
         if (xlnx_dpdma_desc_update_enabled(&desc)) {
             /* The descriptor need to be updated when it's completed. */
             DPRINTF("update the descriptor with the done flag set.\n");
@@ -831,7 +841,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
 }
 
 void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
-                                         void *p)
+                                       void *p, uint64_t len)
 {
     if (!s) {
         qemu_log_mask(LOG_UNIMP, "DPDMA client not attached to valid DPDMA"
@@ -841,6 +851,7 @@ void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
 
     assert(channel <= 5);
     s->data[channel] = p;
+    s->datalen[channel] = len;
 }
 
 void xlnx_dpdma_trigger_vsync_irq(XlnxDPDMAState *s)
-- 
2.43.0



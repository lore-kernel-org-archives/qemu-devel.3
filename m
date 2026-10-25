Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF42606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AmTDQ4dQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKw6A-0004Io-PM; Sun, 25 Oct 2026 07:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKw64-0004Hm-4t
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 07:09:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKw62-0006qp-2I
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 07:09:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so2742205e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792926539; x=1793531339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WoMlfAVsgxjLbhMp/I+SWkPFRmU2OtMZl8vdn0WvOuw=;
 b=AmTDQ4dQze1xlmIVaNeAG9mhs2dcw8XYhvsi9agh5s5cJaVVpLj9ooKoP+PjaBThll
 plB/6MbJa88Hgb5vyng4IitgKsguh1W5jqQoanPmcUsJf8/wcdYmbO+Z5Qfu/bari/cE
 zPmCrpSFIdLS20ho5ttgWbYu01uRCrblEep+r9IbdwCS1YTZJmRDn6lAmvyI7o/VlT0C
 HEL8ci17OuusrPL0dxHEhHEosIk193/YQxv+HdVNjSGh3vQAQ0IfVQn0xA+tSIaZZotA
 welW7ebaekv0aYUCL3KLIYvP3yHStwz8VnAOHevQrQM+TNzFTZ3Fase802+w+/Kj77gu
 MQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792926539; x=1793531339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WoMlfAVsgxjLbhMp/I+SWkPFRmU2OtMZl8vdn0WvOuw=;
 b=M1JXrM3hKuBJGn4sf/ZgoSfQsJ3KMc4HdwwB8LL+FoW3pxWtKTvGRgbHHaHxjxlR6i
 9BJXIDnEv/8th0wiekwka+TnWab8z+rWfaeyJz5U5pykzlo4iW4BGuPrH8c8sa+BKIes
 2bfKc6XeV8+Z8KiVXdmkxAOY921CW7cyG8OpTInYBWdEYhZyhRWBI0QnmC+6g09ZrD41
 i40PtoxpZO72RWDYUsOaRTTWEJk/XE8lpvVTEnixGgtYbjHYqY3gmyllGcZgL1oK42fi
 iD4T+REOGeaMG/sdW1xsWvXyWBadAAlEpmkWplqlPUleIw6YvaqatbGFIPbkENRkopgt
 uMgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXUQZuQ71KRBVRf4OZdzU4XeSXcLtTMUkzPV9DGnMsSjN6Meeuyw0aGrXztk2ptyc9vSWFYsoTqfyE@nongnu.org
X-Gm-Message-State: AFq9FYJsHvTZqzs2oKEdTKkRl/F7CIHQKLI3M6gBgQi6KH0LMlxDzdtL
 VFkyh8SKG0UxPzKTONnqMGAqqjQzhHvWwXENTxK6fM35qEku5Kn92f0rlMoXl3nYKRk=
X-Gm-Gg: AYBFou2qFqvKFfjPwYJssDHzVv5f58gV1M5ak/qQcm8owG13FqiOE3WTE6RjiLBghTH
 vqkkXWFE96UjLx68nYtjuY0Po4DC5jS1R1HFmIQiSYniPRLtfRd3E8RnGfo8G09X3H6+knzHDdj
 vJuSRAZQSLWNjnfWWe+AgjToOEedsZujITYQ9N1wPvIUkVyi/xsddMwWR19+fCUIUqe/sIlCe08
 WTkuosIUXWpnw3LfmF1OjmcJesdfIAs/B5DD0O01OWlhBCKoivCFB5S9JxkA4Gwj7ATglI1JIxX
 Milzj7iWhY8MVmDwxdQUBFNRWO8thaoy0W/WBf7DuhFmpiz5vQndd1Dc2CIzt0LNwlAwt6EJveu
 g0GJkNfPHF/gmkuYf6+2fxfln8TmX7wRVxXygDkdpfgj9IlvJ+liCqiO3pxnQ4LfQ6K5Dy1vrmK
 w6LLxM7PjTnBlDkSc6hOB/sxwYj+TCcdnMecIOmG3+EnEaEtXFpIVJMpYeoqwuc0niapVDAdomg
 mR3Ow19K1N2NsIDSu1Ob9vDbul204E5SD5Pid/1SA8Y7EKIxMnCjMKaxnoA/Ohc3zTXNQc9NDNJ
 PEGZ7BPZ9TMNh6/FW/jRAyal6rRq5iL02OdTr4oBZOGkQ0KKKpF6g+xCfOkR
X-Received: by 2002:a05:600c:8b86:b0:4a1:dfaf:f43e with SMTP id
 5b1f17b1804b1-4a35ac38af8mr64839175e9.1.1792926539452; 
 Sun, 25 Oct 2026 04:08:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm210762515e9.0.2026.10.25.04.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 04:08:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH] hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
Date: Sun, 25 Oct 2026 11:08:57 +0000
Message-ID: <20261025110857.1973128-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
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
---
I couldn't see anywhere else in the tree that wants to use
surface_data_size(), so I've left it as a local function
(especially since we probably want to backport this fix).
We can move it to surface.h later if some other user appears.
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
index 98126ef320d..06594980292 100644
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



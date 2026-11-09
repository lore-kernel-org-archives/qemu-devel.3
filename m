Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0B606D83D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j/MqKl/f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0Y-0007Q8-BJ; Mon, 09 Nov 2026 09:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ06-0007A5-0U
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:37 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ04-0008A4-8T
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:33 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so560677f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233130; x=1794837930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sE8yVpqQAzfmCUET0N5Sgrduw4EonoQvrMHIyBYOkRM=;
 b=j/MqKl/f3nwltTNoCAtcl2W9fnTcTWxBwPeazgK34PBBcTlwo4BEFEZr5BEWs2aGpA
 Fyv4PhnAVvJtIxEl93Xxxt7dHz/vfdNkxm0cdkSZhkNWFpyDTfK+7KIC4Voe56/8atRL
 Exkuq6mM++53r1g37pIP9WAmt33F4+SclPOXSjDzVoLi4s2UFFIfTknTI1rttPFj5Vas
 udMyrvkBzENaorVNUogKcK7+xDyV7b1QfVYwS9xyZiFQyL4n4yamwRWZ+juhItKO3ZLG
 rFFX9f9xp9E+wxBqoscGHOjs/l9gPAqb+uZN3+UPeWblrU+tOyRrCam+fs+dZL3QGo9p
 nS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233130; x=1794837930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sE8yVpqQAzfmCUET0N5Sgrduw4EonoQvrMHIyBYOkRM=;
 b=kx6EUNpXs42kTkG7roWt3tRf49755Kqkk0rRVyfqjQfIx4N84TeDuEgyplss/8faPe
 Hxl+T5fEhVtbztrGRTGCwNPdx4l+qvQsLQmO8CCi0xNDzGQOj+YCn1GVGtNA2WJEyH/S
 1o5XUGPoWS4FgF8L+xdnCXLpX0rbsJZD4VjDR4zlv4lmUQfT6sDIsjcGINbrvnOGMQ5Y
 Ks5ZC7fi7HjCNfo2qSxpmsBr1e5lazBdfqfRToaO/uk5YL+JHUyTqSUkNxe7Qn8WFGPB
 5RJ3hiJjZUvlgWYgJ/KIdf/3JZlAVaNkD4k5BpBWFjdlEii4FC9HinkZHYgOEpGwJ2be
 btMA==
X-Gm-Message-State: APuU4Z9B53g85u1grOQDW3AmUZUVb0QvnaZj/a7qVdvvoKJ2Ys/aE1LB
 6YvX/Hjesuq3H8j4RYoaWZt4lmIvxYunS02qOpPa+zhiMAA5ACp3ID+hbF2NniF6kPKPHPI3MJ6
 cF2n/BQY=
X-Gm-Gg: AYBFou3uM8JSqoKunodSr94IVBzWZCcYVS6zlpml4Afz3xeq0jn9yOKAA8POUh28thC
 3iU+hDSiz9TBSvtko1gXzd13Tf8yJ3xhVSNl4fGWplBsrjQeDF0Tf7S8YT3Jl75YOlSFbBXNbKu
 wsAx992osut4IFjLiAULZ/jvEsCuhQIJLDncynogGLawi4ab2TWMnr0bQ4VcPz/YfC7K/ktTAwG
 DfYasuf8cyBC7Iyfc4pOqfq05uoMCCm0izlDVXCyDieaAAnJwh2IR0I6Wlly0HTuTr4Xe+hq7A3
 Z0P11NuhsgvCixlHO4g0WywZXkOvJyfZJBbSsj0BZAHwwTe6zenj9qQwD9loHDlZEf3ceVf3Vfw
 yvi3ZKc8dejl1PAqtbJ6ppRacM6S7UwDED1cMhSx2IZpmstb8+sx6RPfn4SmtAV6fUoDri64GY6
 iuTQA2oLtD/71MDr0R4uGlpMXqz8TM/FhBGdnGhttkISWDChegLWn72AxcNBxTBEN367npC9uiH
 kTYEnqfAFEGmiG+pumpB7rkgxJFNu3D0cnHaU1FOBVkJNkc7dIeT24gusPxeHP4QK9xewE57LmF
 SCm9VSrcFsck/P2GseqVQB+M0t54ryNG4bBOp9QrdsudzCxtb59Ih9jb7OcP2JsySQYFPbt54Oo
 jEEm4AoJVz2y7RSxwJdYUYNwNNYmXmCZx1vLLI2nZNPqjRPcMlzbI9Ec=
X-Received: by 2002:a05:6000:2211:b0:493:d5f0:4e4c with SMTP id
 ffacd0b85a97d-49582e90293mr7688652f8f.23.1794233130170; 
 Mon, 09 Nov 2026 06:05:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] hw/net/bcm2838_genet: fit the RX frame within the guest's
 buffer
Date: Mon,  9 Nov 2026 14:05:18 +0000
Message-ID: <20261109140523.240161-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

The RX path clamped the payload copied into each descriptor only
against the whole RING_BUF_SIZE register (whose upper half is the ring
size, not a buffer length) and against the size of the rx_packet
staging buffer. It did not account for the status block and 2 byte pad
that precede the payload, nor for the 4 byte CRC that is added to the
reported BUFLENGTH when CRC forwarding is enabled. The BUFLENGTH
written to the descriptor could therefore exceed the buffer the guest
supplied.

Clamp the payload to the guest's buffer size minus the status block,
pad and CRC. BUFLENGTH is then at most the buffer size, which is at
most MAX_FRAME_SIZE, so it fits its 12 bit field by construction.
(It cannot overflow today, because receive() drops frames larger than
MAX_PACKET_SIZE, but nothing in the descriptor code made that obvious.)

This also fixes a hang: with a buffer size of 0 the old code copied
zero bytes per iteration and never made progress through the frame.
Treat a buffer too small to hold any payload as a guest error and drop
the frame.

Resolves: Coverity CID 1690161
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 20261104140058.24068-1-marcelomanzo@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/bcm2838_genet.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 92d550cb630..0d61980a0cf 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -902,15 +902,24 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         uint8_t *frame_buf = dma_buf + frame_off;
 
         bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        const size_t crc_len = crc_fwd ? 4 : 0;
         size_t buflength;
         uint32_t prod_index;
 
-        if (l > ring->ring_buf_size) {
-            l = ring->ring_buf_size;
+        /*
+         * The buffer holds the status block, the 2 byte pad, the payload
+         * and (with CRC forwarding) the CRC. buf_size is at most
+         * MAX_FRAME_SIZE, so the BUFLENGTH computed below always fits
+         * its 12 bit field.
+         */
+        if (buf_size <= frame_off + crc_len) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: RX buffer size %zu too small\n",
+                          __func__, buf_size);
+            return -1;
         }
-        /* Never copy more than fits in rx_packet after the status block */
-        if (l > sizeof(s->rx_packet) - frame_off) {
-            l = sizeof(s->rx_packet) - frame_off;
+        if (l > buf_size - frame_off - crc_len) {
+            l = buf_size - frame_off - crc_len;
         }
 
         memcpy(frame_buf, buf + len, l);
@@ -921,10 +930,7 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                                          GENET_RDMA_LENGTH_STATUS,
                                          EOP, !!(len >= size));
 
-        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
-        if (crc_fwd) {
-            buflength += 4;
-        }
+        buflength = frame_off + l + crc_len;
 
         desc->length_status = FIELD_DP32(desc->length_status,
                                          GENET_RDMA_LENGTH_STATUS,
-- 
2.43.0



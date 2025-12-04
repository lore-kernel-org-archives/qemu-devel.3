Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2618FD1D89F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5ka-0001Xe-7H; Thu, 04 Dec 2025 04:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k3-00019W-1c
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:15 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5jy-0003Nk-FW
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:12 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-647a44f6dcaso866083a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840907; x=1765445707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2Eh0GOKOaei3jLJLhPOl4V4bK4+Eil0n0H9DTtEdt4=;
 b=NoyaK38g7NijisNn5NaWqYhx83V7QFdCkCBGJf9Ar0IpZO1e6rBOMG9p46MoLbU9LR
 Spezd/D5Obmaa6RPiCbDREm81RTkLxHttp6pD/1EqGqBlW2o2HtroVzkiNBGndc6d22i
 DH2qK5iMZ9eShEcg2j6secaS79aAwmoSBHgsbXjBThSsGLsmUvdmeZCHu8/YjMibVh/X
 yXYO5tj5h5aD9AimU7+BeSpBOdPIQ5PhjclWtMwswZOG+WIk+HefYUFIag24MgtkDaCq
 DyZ5hU/ubC/UfVTbDQEep6F7I8dpcEDiBhkIb/BRAXoJoMbTofgEqVJbcur++jRhQGie
 ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840907; x=1765445707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2Eh0GOKOaei3jLJLhPOl4V4bK4+Eil0n0H9DTtEdt4=;
 b=YiAMO8t55k56OMzg8PNSnTZOT6RhHmrvP6npVddWFNN4WSJhHMXiWqvtwyAcBiwEfw
 FgL8k5tsMBT+0OhxcTEvmuW1s8q7tjrTpBjK1AK6eiV45RjFNPQOWyatZPzbg5i9Vjf1
 GWDZYEXxtoV0o5KACQOg7zP1g+eRzvMYWsrwH0aiOT/DeFGOppzArtPpS6aNud+MIh8S
 uHPdK4BQwhIpMlGGjbqLFdYrn8fuqxbkb+L8SGtxh17xUvfOLkpJlpS4fPBkzEyp3awn
 biLxk8AKgH2uwJhh+bETfOyx05bHH48cR8V2pYXYVapzE1r0OXBFZf6yIgANy1BUIGTw
 y7ww==
X-Gm-Message-State: AOJu0YyUy0l3o27LtzZZjunfzJVXr3abqgHkzkBDpzCUWEq5qpoRX1hS
 N8pQdXW7ib78rOhHQ/bu51rS2qu9F/zeRURZ+u7+j2hCJggv4Qo+JJRUVJGjLOCV
X-Gm-Gg: ASbGncsAYBeLXwLKZD9WgEn7NhhH+Fdggjk9V6aZu8QALO82hLoiIUuHksaHvzu4NhS
 +tw7SrmIUSe3RRW1F0Uxn0zYoubMRguU/KSs7/LUQKN/GHi12ZtRHtbJ/jkDcNYW+HNGrIXO80e
 GmubNbU4u7CzMEh0MAgByNdxWn7Hi3tBxcq1Z/T9EciB1h3IHImsfLZ6J5NkQeF9xRp7tdf5JLy
 gkyb9lBFopnAOqqnZK22l1xm7ZEUp+ercd71NKU+tbgjLYGJAUAvYELpO87xjC5O/q8ZAQjQJo0
 7HTHiOJBPFjWFXl686MpOEUxLg89f+LyU5JN8e+mchr/L0iEP7UfUpCPnY1q+KeyinJtmpq7GCX
 ZbLqm3HHxISf6Ws6E5U3lvFATpjzgVpvrRvyg2ckIwD2YkjPwDw9ucK4COroSknHLI+4JbJZA5t
 D5x1OhP4+gYxdegMeeMYIVIqQTY/lsc/zss067dVSrlA==
X-Google-Smtp-Source: AGHT+IF13y7SN0Xslm4FgKr1E+BJcTBCa78t0jTJJ/ykK0Utu/E8iv3jeeP98vM7SkBC4ef8CkFPvQ==
X-Received: by 2002:a05:6402:2351:b0:645:c99e:5e50 with SMTP id
 4fb4d7f45d1cf-6479c4e710emr5278854a12.16.1764840906809; 
 Thu, 04 Dec 2025 01:35:06 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:06 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v5 03/15] hw/dma/zynq-devcfg: Handle bitstream loading via DMA
 to 0xffffffff
Date: Thu,  4 Dec 2025 10:34:50 +0100
Message-ID: <20251204093502.50582-4-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52a.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

A DMA transfer to destination address `0xffffffff` should trigger a
bitstream load via the PCAP interface. Currently, this case is not
intercepted, causing loaders to enter an infinite loop when polling
the status register.

This commit adds a check for `0xffffffff` as the destination address.
If detected, the relevant status register bits (`DMA_DONE`,
`DMA_P_DONE`, and `PCFG_DONE`) are set to indicate a successful
bitstream load. If the address is different, the DMA transfer proceeds
as usual. A successful load is indicated but nothing is actually
done. Guests relying on FPGA functions are still known to fail.

This feature is required for the integration of the Beckhoff
CX7200 model.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 8141d46033..2430d70bf7 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -247,7 +247,14 @@ static uint64_t r_lock_pre_write(RegisterInfo *reg, uint64_t val)
 static void r_dma_dst_len_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
-
+    if ((s->regs[R_DMA_DST_ADDR]) == 0xffffffff) {
+        DB_PRINT("bitstream loading detected\n");
+        s->regs[R_INT_STS] |= R_INT_STS_DMA_DONE_MASK |
+                                R_INT_STS_DMA_P_DONE_MASK |
+                                R_INT_STS_PCFG_DONE_MASK;
+        xlnx_zynq_devcfg_update_ixr(s);
+        return;
+    }
     s->dma_cmd_fifo[s->dma_cmd_fifo_num] = (XlnxZynqDevcfgDMACmd) {
             .src_addr = s->regs[R_DMA_SRC_ADDR] & ~0x3UL,
             .dest_addr = s->regs[R_DMA_DST_ADDR] & ~0x3UL,
-- 
2.47.3



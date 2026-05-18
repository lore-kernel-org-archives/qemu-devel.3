Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED123CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsUx-0000pK-BW; Mon, 18 May 2026 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUM-0000fv-A5
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUK-0000E8-4j
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-452169ae568so1158439f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089646; x=1779694446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2UZAwblmFCL8Lm8n5wVmaatXyzHPE9hb4BFthu5ZrY=;
 b=TYHUKti99vSoXzcaZsVgyh+BD/zCT71lMKm5P8un2CuSO5P6oTW9s0HQmcjcp/je+B
 h/39Yf02wN+jmChU093I8F6HPt5s2L/Ws+VWumjK3Jg5Ai0wKbaLZ58b9hZMjxRmdj34
 /nXfaZ2Eow5wvfz3qZ6g3S+mkT9wVTGfGKg94NPgJtl2yqMaGM5zfs8HZwSC0/wkz4he
 KkAyGotzpZMb8TPcG8InsEcxjbTDwJoDF6RZpL/b9lc8fdiFTakhEIwOx4MB4TcoqreH
 2cwf1NvLHIroCPdHE+wzLzJ8K0cVqO2dBe5lzvpdeUP7vMpD9A7BNzCUD/VL3yp3v9va
 UsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089646; x=1779694446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2UZAwblmFCL8Lm8n5wVmaatXyzHPE9hb4BFthu5ZrY=;
 b=cuUpuD+A+73YnMFjPNKoBH37sbK461o9Kf73FgxTHyyaCLnpGw5xBRer1il3t/K0Nx
 DWYVCkneqzKmhJJwoOEREvZwaDFPjQErP3f2xzaIwkxqzateYuP+d2DPPI6kJoZuhyrx
 T773Rfs9e81ho4c7Lw9nDBKA3e+ZpWK0MGKfIsYZNI8ipOTbn1uZsNREUg5BrZ143EKn
 1ep+RkugWuXGyNKTZJDSUlUYHrRXMOjD4kGj7+PJJH4YqT9NX3pirYhyl2RmdQ6Mmw7C
 Yxe8sJhfV1If1rxPuyRyEYGWR0xJYVCaNQYIu76LqKIIzg/uZYEImgv+9VpjIOidg60o
 KIzA==
X-Gm-Message-State: AOJu0Ywk9tX70Y5YkLS5ee8ZuFGB/32s/953QFT7SrxT0/5CMBA1xB94
 0XW1BqhNjU/VA/+KW1y92RHiyGoo4LC6xYe2alz2b/Uh7QBY/AZB+jokof4TX3V+
X-Gm-Gg: Acq92OFV8Vyri0sbvg3XbfkYehLs2XgUWmn2jrda+AlwUtiyprLI3fNbwuxfvmLFLVE
 nO74ld9ed4zbIkXApl6aPmihjUjAL/BHA36DJBUwePMaolQbl2EmUr8O2g11ekrD8CHMwltDusz
 x8gO0J2d95GZZCWRpnnnRa8YPDaEGIyDvhuBFhBRf3t4F27/Mw9cRGTrQ5kFvbboWljCqGY2f99
 vcJpMHtqmkXHo7WSa1BaoK+eWvp0gzLq9p1BugJ2oOZzx1eO0Fv8MdQ5bO3R1k2p30pRPpMZbY0
 VrFM7UdGCclqKK9HyINbkrlQiLTJSumvK1lI84XSgBMPXF3RgyLdtUMYBkyx2qkzSCjwHyxJEj9
 CQNwTO+PTW/RFOuKvEM3iIjurBOrGK9OhMS3Knc2vjOjUcLtHYY9ObnDNuUTlvMABndnAxyHz28
 4ckFJSMrhKclpQZ+nGR/ofeEjqQV+sXH5kq2TIW60UIecG4g==
X-Received: by 2002:adf:ef83:0:b0:45e:651c:47bb with SMTP id
 ffacd0b85a97d-45e651c4807mr12694222f8f.28.1779089646306; 
 Mon, 18 May 2026 00:34:06 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:05 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v7 03/16] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Mon, 18 May 2026 09:33:48 +0200
Message-ID: <20260518073401.11279-4-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

All register bits are clear on write by writing 1s to those bits, however
the register bits will only be cleared if the condition that sets the
interrupt flag is no longer true. Since we can assume that programming
is always done, the `PCFG_DONE` flag is always set to 1, so it will not
never be cleared.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index afe6ffd326..7370ab941f 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
 
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+
     xlnx_zynq_devcfg_update_ixr(s);
 }
 
-- 
2.47.3



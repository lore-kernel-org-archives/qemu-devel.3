Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89199CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRar-0005nG-Ee; Sun, 18 Oct 2026 10:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRap-0005mY-6j
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:31 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRam-0004zV-Na
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8a05b210703so222460b3a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792332627; x=1792937427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJ2vmhNG/CjE3MDSpCuzv+6F5+re1f9SXvYAgJYl+7Y=;
 b=J0Dq2QMg16mfIvb+KfdEgEGm5rHmhS0Md4pHomRIwprWY+DFtsqUO9mcUqogpiLBQn
 BO9aM9E96gOloGO9m9EdZdp6WX0raHZQRgP+rDoM25dm3+5uCENDIv95zYw9/AY+HYU6
 T4goKhwZi0t9s6kF8sOK6K1AxkW/2kFLSkwGwJUimpsWoKt0h1yY7cODfeC9ZtR65rRV
 1pR1umau/5VmlFkfU8tiGVhcMfNij+BD6GoAsg2OpPJIkcZrb6cArxjxwGnlN2M+jJTL
 N6dTBmoVhqZbdlkCrlYpiVyZ2C+BZ3kSbEgiWUiksf1V1k7WypNcoFTj2Uq/OhgNF8kT
 ioHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792332627; x=1792937427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QJ2vmhNG/CjE3MDSpCuzv+6F5+re1f9SXvYAgJYl+7Y=;
 b=kpePMTnGLrYmw6r4nEnb7KZMBLYFGL6lgztFxufI2a9V5Y6CfIIAFL0BuQEiAZjwR0
 OikO9fPZLsKH74fenp5uQRTsmGfWI0XAEctZCjoyXA6mjkc6O77IlpK7fDbzrveyKLKc
 cXae7AlSY2NVTPdFD8iHpDOhaZr9p+AHQi0wIee532YJYPQ1FE9tfZkUMyrNGva23xG6
 OCYRbkzp2rzvIEvod17aV2H41l0ZYUGj3DS5oPMn/RWYkhKDFqjMkmMG3YsGsWHS2XBc
 ChxGGE0VsdqOoFExREGjPUkF0c9IeA1WlPO4ZcoZpSwElRcM4FR7Ida1QNpUrNdue9JW
 8hFg==
X-Gm-Message-State: AFq9FYIlRuw5OHl4QK1/RZmYlHpPlZF6Bjbpx6bzzddrGfhMNKezPyOm
 zNL4FX1EUSIau3Ce3Y/cvcMSnCw9bW0P+D3oUMcVSNr5oXTi0ZYVAPKa5J936gk0
X-Gm-Gg: AYBFou3d3xrwn2zruB84ACxbRYmiFX3D6wEMf16dPYSGlw37AIvELYSgPBx9NdMEA62
 e0FyN31/TxI7GoZpaWo4i0Xnla3q7VsZP5+OT9cBJVazYK2y/f+ztwhu+7nKL/pBeFfTqKxzvxs
 lZYrY2e5JvbX1KasrY5wcvWk1edX4P2hkrzF4NrzPZFXUkt0EZ/Quk+9ZUv7dpUu3WeDZk7leD6
 lmJJEg70NLGWV4nkuAwz8hjbf917pwwTBtq3CanhKwU6EC1d1Noo3vGxOD9v7/Hbj+2KVjlTrNA
 OUXMZUw/woPOt7JX4NEQIm6oDKRy2bga3O8YHWfNPjPvt26KDaD6nrW/2X32cZYc+Y7qgIFdTfd
 77ZAkZ2sGkkXcoNrq9Mp7gDNfPj2mpzPdZ6Khrb16zkL9M6yDjWSHLOYorD+xAapvCmzX+esks/
 hIVUBnyVpfKDREICvmitROGg7q6uZFAuUqJrsli2eQEkDawcNOtqcyzLaODhcOewDlBR5EcKF9o
 KVAuBpF4GFcSWsy
X-Received: by 2002:a05:6a00:4c99:b0:87c:b126:8e4d with SMTP id
 d2e1a72fcca58-8a04aa2a824mr3534421b3a.3.1792332626931; 
 Sun, 18 Oct 2026 07:10:26 -0700 (PDT)
Received: from dt-VM.localdomain ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2949430b3a.32.2026.10.18.07.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:10:26 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/5] hw/misc: fix calculating input address overflow in
 k230_decomp_gzip
Date: Sun, 18 Oct 2026 22:10:03 +0800
Message-ID: <20261018141006.16398-3-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018141006.16398-1-dingtao0430@163.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pf1-x432.google.com
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

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685517

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index ac06cc1571..da4dc6f954 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -59,7 +59,7 @@ static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 
 static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
 {
-    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+    return (hwaddr) s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            K230_DECOMP_GZIP_SRAM_IN_BASE;
 }
 
-- 
2.43.0



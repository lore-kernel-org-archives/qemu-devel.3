Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0C606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sKwDrJrI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3ei-00077x-LC; Sun, 25 Oct 2026 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29C-0001AM-LW
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL296-0007rK-V9
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1955957f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949795; x=1793554595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RgiTHkc9c8syti7eZF+DEE4VABieA7WFxrhehFnEbO0=;
 b=sKwDrJrI7TlwsNeFvcCWIka8pZGblHtN+ZozwHyz0hrqccEvFR/qFF1IN1dpPKcyt3
 ECIJDhvFa42XNPB8ATFW6xav4c1jwYK9nkHikNHiGKLJIka0Q+Cxk68GqcQkzOYpub9+
 hs8SyQx6FcXWzY3RuFLjBSk4pYl5WFwDXBxIyV9WdoWYYNeoe8kIhZ5UofOrQKUeX3Bs
 hgHxzCr9FGakmw1nwXWAikk5NaHN5A3Mn6HCgANIiRk9TDlbJDKyJ2iiiG2rJiXPi4El
 eOcJqOBAIXjBjADq3u0Sqcd75Rf1G0E6V2aYT6V1eEGYuIlwZXh3nKPDfL8C9jxuQJDN
 B7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949795; x=1793554595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RgiTHkc9c8syti7eZF+DEE4VABieA7WFxrhehFnEbO0=;
 b=u+tlB3VMS4EL6Yr1WnhnW1ZQsqYTgdw92ohywQ1OqXP+Kwr2X0DzwTylR+NZTRScFg
 Ls86U1Ye7XcmHirGTCx4AZry8nwPHeGKrELAEJ5mB9XnRq54Cu4+C6MiEhnzeLxWvalO
 DIuJw8akFV1qXThttDglLgGF6JhZMhk054dKSO2d6tlbz61KfKEgwJ8tcJujavEJ4NbD
 PEayHKssFWW9Yq5HOxP/SUdtlvzrPHmL+fb7Ay2zJtv9StoHbINpcaL05tQK9mI+cHNt
 rThb8DLX7JWSa7BpA2mWl4XE/zaX30/c1hApWObdbVUVHBtshGW1j947g4UZujcYDIC7
 v46A==
X-Gm-Message-State: AFq9FYJZh4cZNtMLsowjgbF4ZSzv6fOohY0zyEExjAjqDWu9D85jmA5M
 nommKzCmJ+RntPNwpRyjBUKzorRkFc77vEI5sW3v5Nq5OSBQBY3wdDnYX5ob
X-Gm-Gg: AYBFou0z0lXtPlP8DE1R3FHWDOu7dVVKvk6yrCmG1di+e5rFmoD0SsIjP5LLVG8ibcg
 c/f8IxA81GELnxM/SUvYPMQ9P4xJg1GMCeyvqBg8zSJQeDZQstcKt08ZJkhhWk26BFMxsovuopv
 S+0Ff0gPPjZHm2hL9yihR82eKQasR2qDcE4CUbrJBZrCyL9pPMOZWsmlsIyksDOmqGpEnEdcf+7
 sDZNTdX6+FILaHsoqYcOAfLLC+wGQOarS1s/opgaCqvMl1pUebRpZDOcApssQ5I/EQVv06AQ4UU
 5aBpibcwqC8FeJHbn/3M+VzX4VBh0vb70hHLhSN2BoDWGyMWHB5gqoi27mjBBA3aW0AbfH0hvO0
 c/DuQUo+YZsaFW8ef06yX3S8ixDC8aGsYRiVP5Q4DaI1mrnyBID/UBgoO9uWAeI1MGztKd0s7M5
 +azmKNoHJhq4aXH4aReUWQfll9nYKTtvb+9QLiF9XQArhqBGNZCBAHZRJKAxHTt33CdbUBFZHxf
 HI/sBKBszJQva4/EHC3eqzQbS7VQRenK8ahRw==
X-Received: by 2002:a5d:6f0d:0:b0:487:f37:7ec4 with SMTP id
 ffacd0b85a97d-48e3eb85059mr7592379f8f.24.1792949794662; 
 Sun, 25 Oct 2026 10:36:34 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:33 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 1/8] hw/display/ati: fix integer overflow in Rage128 2D blit
 bounds check
Date: Sun, 25 Oct 2026 17:36:18 +0000
Message-ID: <20261025173625.3372689-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 15:13:16 -0400
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VRAM bounds check in ati_2d_do_blt() computes
(dst.y + dst.height) * dst_stride using signed 32-bit arithmetic.
On Rage128, setup_2d_blt_ctx() multiplies dst_stride by bpp (up to
32), producing strides up to 524,256 bytes/row. With large
dst.y + dst.height values, the signed int multiplication overflows
to a negative value, causing the bounds check to evaluate false
when it should reject the operation.

The subsequent blit loop uses unsigned arithmetic for the same index
computation, producing large positive offsets that write past the
VRAM allocation into host process memory.

Fix by using uint64_t for the offset computation and comparing
against the VRAM size (offset-based) instead of doing pointer
arithmetic that can also overflow. Apply the same fix to the source
bounds check in the SRCCOPY path.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4646
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/ati_2d.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 7a4a115..b9933fe 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -156,6 +156,8 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
 {
     QemuRect vis_src, vis_dst;
     unsigned int x, y, i, j, bypp = ctx->bpp / 8;
+    uint64_t dst_end, src_end;
+    uint64_t dst_off = ctx->dst_bits - ctx->vga->vram_ptr;
     const uint8_t *vram_end = ctx->vga->vram_ptr + ctx->vga->vram_size;
 
     if (!ctx->bpp) {
@@ -166,9 +168,11 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return false;
     }
+    dst_end = dst_off + (uint64_t)ctx->dst.x * bypp +
+              (uint64_t)(ctx->dst.y + ctx->dst.height) * ctx->dst_stride;
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= vram_end - bypp || ctx->dst_bits + ctx->dst.x * bypp +
-        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= vram_end - bypp) {
+        dst_off >= ctx->vga->vram_size ||
+        dst_end >= ctx->vga->vram_size) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
@@ -205,9 +209,10 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
         }
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
-            ctx->src_bits >= vram_end - bypp ||
-            ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
-            ctx->src_stride >= vram_end - bypp)) {
+            ctx->src_bits >= vram_end - bypp || (uint64_t)(ctx->src_bits -
+            ctx->vga->vram_ptr) + (uint64_t)vis_src.x * bypp +
+            (uint64_t)(vis_src.y + vis_dst.height) * ctx->src_stride >=
+            ctx->vga->vram_size)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
-- 
2.53.0



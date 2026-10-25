Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF12606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PYtuGqwD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3ev-0007F7-Cf; Sun, 25 Oct 2026 15:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29M-0001Vq-Af
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29K-0007vA-G6
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so2133596f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949809; x=1793554609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDlhVrmFrGr+LQeBWw1XjdYQ3Aputztpbe8x+/SR4MY=;
 b=PYtuGqwDHru1k3UTVYpv7leOrmX2ZuJGyfJKgbm8w+JVQEDx4aOiBrmVZ81dByDCZM
 MSAD9GVejAXzsiEOV/x/iGOUcbg0BEm7H+8RtVZYi8LpS34UGTzDfHkyihYmJfDTOt1Z
 qi8Sg7hFsjQn1/WWa2BeMqb1q4ruIL/2HoOTDJ+0iCWFCg/E0AZ6M5CGWfq+7/LGrK7S
 j36PtF4EylCrm+oN+Qwy9pFXMJLegW7nmcbo09ktSJtOqG3RpGkzVmc4xl4DIqYWxZBj
 SdBxCIYHIyeM/5TGj0QUnevOiKqdh7ikseTVBUDulNATEeSTlevxExG8PlKqpcaXloqR
 wiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949809; x=1793554609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XDlhVrmFrGr+LQeBWw1XjdYQ3Aputztpbe8x+/SR4MY=;
 b=w9oxbYISoNrcpivcf4NQLS+L37U6MCgALhKlrgbzY91EYtk6wF/vsEMqT0ItOT4Iq+
 jaPvKoSrAd2lAPt1xFnR9KxmFs/3KIgbjiWk2wlFFFgMeIiDg4WAb37RAG23oZfbsGOg
 AHJj2Giq/ltMYP5lwETuXx5PoAt5iZFDcWSEk3kgTfPdy1TMCLhdnOz0idLZQfh5tRUG
 3ginhSU/HLyuqIsmXrXbSWGAS1/2wwDjxa86lMexeaUrnMDBI001uR50lNG1XQO9jkeI
 MQDtt72J2I/18+M5VZ3Uq19cgbUlY6MTLjUvtItDn2fA95mQVcCuyjz99VLyoHcHmKMW
 7TxA==
X-Gm-Message-State: AFq9FYJ02SfjbccwKt+/ARhrlviI5qumR8lKdjhUY7KLl6wOCO9N+WOc
 wKlPoM+5S8Zn4fybkW833rlgSK5m8IINIV9CDICRPJj175Vzptrp8V6he5gk
X-Gm-Gg: AYBFou3iiFEd++zbOO9kmJh8BpWPlL3FQ0JatF8Ay9TyqT7u0dNrx/iIc7DTuJSXxGd
 +0aa71DAQTd3Q4ytjbNDS4Lt1AHw30xjiM6Di1AC+WldqqMAEA+vRtbA2F7roD/6puEobwhAkwA
 cEZ92DQPJg9b3u0gwNWe5doEvZMZXoR8itShkrzTtjfwJlfkhDqtCHs0Zyel2mGCSquM/Zuoqhi
 tVfnKKndHn9tpxCWxHSqkymATQC89jacUOQfdB/skA84TjGRIQZVPWjdOeWTabivxPFM0V37s4O
 2peN3siBxbiOhxJ/H41sq1O2NYbcgEVP+dN7lfsd11ER9Eyz4RSckwbsN1Vv7kYwqoifdtyNw7x
 TJMxumBF4uTYee4R7NTNK37RjDyo+JFBOA1Gj/4kCBW/WWAkfLtzzekb0mmJyD4j/lZo4M2wg2c
 kfYGrXE/YWpKZ3OrgdB67IyXzANeBf1xHTG+8+Xc3ZxzDMzyAQ5DSSfaHZHI0DPR/mzPN9zJG2D
 OanPBjiL3bjCbyDcyFmvS+vq06RBeDE4xn93g==
X-Received: by 2002:adf:fe8f:0:b0:48c:67d6:a87a with SMTP id
 ffacd0b85a97d-48e3eb8bdbbmr6049198f8f.32.1792949808915; 
 Sun, 25 Oct 2026 10:36:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:47 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 6/8] hw/display/tcx: validate blit source address against VRAM
 size
Date: Sun, 25 Oct 2026 17:36:23 +0000
Message-ID: <20261025173625.3372689-7-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x430.google.com
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

The TCX blitter's source address (adsr) is extracted from the
guest-written MMIO value as a 24-bit field (max 16 MB) but never
validated against the VRAM allocation size. The standard TCX VRAM
is 1 MB with a total allocation of 9 MB. A guest can trigger a
blit with a source address up to 16 MB, causing memcpy() to read
up to 7 MB past the allocation.

The read data is copied into guest-visible VRAM, enabling host
memory disclosure. Reading unmapped memory causes SIGSEGV.

Both tcx_blit_writel() and tcx_rblit_writel() are affected. Add
validation for both source and destination addresses.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4651
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/tcx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 2c33a9c..69a2b0e 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -575,6 +575,10 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
         addr = (addr >> 3) & 0xfffff;
         adsr = val & 0xffffff;
         len = ((val >> 24) & 0x1f) + 1;
+        if (addr + len > s->vram_size ||
+            (adsr != 0xffffff && adsr + len > s->vram_size)) {
+            return;
+        }
         if (adsr == 0xffffff) {
             memset(&s->vram[addr], s->tmpblit, len);
             if (s->depth == 24) {
@@ -607,6 +611,10 @@ static void tcx_rblit_writel(void *opaque, hwaddr addr,
         addr = (addr >> 3) & 0xfffff;
         adsr = val & 0xffffff;
         len = ((val >> 24) & 0x1f) + 1;
+        if (addr + len > s->vram_size ||
+            (adsr != 0xffffff && adsr + len > s->vram_size)) {
+            return;
+        }
         if (adsr == 0xffffff) {
             memset(&s->vram[addr], s->tmpblit, len);
             if (s->depth == 24) {
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D51606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I0+n1Phr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3et-0007EZ-SU; Sun, 25 Oct 2026 15:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29G-0001KD-LG
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29D-0007sZ-Ip
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so483041f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949802; x=1793554602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lkd/Fq1QJgUccZh9Elmt6YOYwvqSq1YSQVG1XDS6sF4=;
 b=I0+n1PhrT8+XpMIKLT3xq0ieF+gtcNQcCdvWp/PliFCtKEP+YvXWD5kX1BhW2Yvu1z
 CsfYU3M2Xa6l5gJITAeFACi3YL8uQjKNMr78UZcikzNubr2PE/89ZAwYI8ugOqYUYwzP
 wWyxuEy4PmxoVfaAyjhrv70Z2W0slShEo8StiPr4vHsf4bAJfsSnZCqW1wI5o/G67x3Z
 kJC0DBt6sjdrZAv6677zLhPIKXDp5A0YjF3A0zsHl5EdH3KM+E0zX0HNr6zZ9Xq2g/53
 cP5C18jSv2MO3kRvdqPnD0Cjw07rBJekHH5L30USDjifIz7IazqIrUqB4srKFm4NH2/2
 u46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949802; x=1793554602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lkd/Fq1QJgUccZh9Elmt6YOYwvqSq1YSQVG1XDS6sF4=;
 b=G/GDRFmRR8lmVRZswqOpE+WP1FcqCWEm9gRTIRXd3jRFKwwMkMLwbNlI9StytLTtXP
 QdZfN01Bwhl72wglVpVHot9WengkEHjlSZgrly9Q94fXETrw2b6vUciksv7VTEkIi2B5
 bw7urrdXYwUB24x1yr1rMdI2FOCWEbpVe9ZbSyiazXuYN69wL9eSDv5EeSncW2A5mZ0f
 Xj9atkNy08JfiR2kopCKbnMJ2ZNwJIeY+Vq/e1/Bv2cV07wXIv3zwvnPjoL7uKMU0lS6
 B6ZOMqJgrNpBi+dCaTPRPYQ/am14vH9rWjQRt14Li2Nf7BHpH+1rjVQ5AUY3t2K+llYC
 Fnpw==
X-Gm-Message-State: AFq9FYJ2FTIiI6Ngnqp+iG/PFsV6ko5uKJiuoPDO+ZmwJO9WdtPkZGXe
 cRrfVBaPIXIfPznAkFsndQc6CcG5x3XhH5jw2ospfF2t/Pmtndh9ZlwJ83k+
X-Gm-Gg: AYBFou1THjmvSwh1yVbyM5dalCAKo6cJVOIxwvhaLkQgQHzeyIF5fbBIboOLBbXF2NZ
 ypjf1Ep71is9amt0nbT6srEj+Zbg7wf4kPGbseTjsyQ85OQEY7Yfq7aHiHi1Qtit4Fk92P/ykIO
 sbKVYaF0+LAcPhjvzKt9CzoxVzOgNhqNi1hB14kS1RBPI4hmpN5Oyq1NKFFF1flktPxVQP6SY91
 Iam5gdICJvqWnp7SjC+zvsWADrajEGn1RbqdyJ8KYhwOiT0M4V696a2qX7bJyoSGEGkBL2/OG3j
 O9DRw5EyljZNUoYOj+q5rJ3w3Gq6bjjfOpFWkKHjyS2iraM4by/goBVA9H9IAMgkWx6lKo42SBE
 t5Zvot1g3xU1x5bOoncR48Wf3KS4Kowy8c4FMMrvf5v+TjP+Tbpozoz8gkeXorB1I/ISBQs9jcu
 oizjxMsaAl72nyxE4RtMqF2YQFPPHVamcPSztsFIbAG5roFtmEICYE5x83T53h5SJb41nOEVzLu
 Q604VeonFeg1KboqW5tVUVesJL5JTtn0k1oeg==
X-Received: by 2002:a05:6000:184e:b0:48e:b32:9d1c with SMTP id
 ffacd0b85a97d-48e3eb780demr7260920f8f.19.1792949801675; 
 Sun, 25 Oct 2026 10:36:41 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 3/8] hw/display/g364fb: validate top_of_screen against VRAM
 size
Date: Sun, 25 Oct 2026 17:36:20 +0000
Message-ID: <20261025173625.3372689-4-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The G364 framebuffer allows a guest to set top_of_screen to any
32-bit value without validation against the VRAM size. The display
update function g364fb_draw_graphic8() computes its read pointer as
memory_region_get_ram_ptr() + top_of_screen, reading past the
allocated VRAM buffer when top_of_screen >= vram_size.

The developers flagged this exact issue with an inline XXX comment
("XXX: out of range in vram?") but never added the check.

Clamp top_of_screen to vram_size at the register write handler.
Also add a safety check in the draw function.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4648
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/g364fb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index af54f1f..77e6646 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -126,7 +126,10 @@ static void g364fb_draw_graphic8(G364State *s)
     }
 
     vram = memory_region_get_ram_ptr(&s->mem_vram) + s->top_of_screen;
-    /* XXX: out of range in vram? */
+    if (s->top_of_screen >= s->vram_size) {
+        return;
+    }
+
     data_display = dd = surface_data(surface);
     snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->vram_size,
                                                   DIRTY_MEMORY_VGA);
@@ -404,6 +407,9 @@ static void g364fb_ctrl_write(void *opaque,
             break;
         case REG_TOP:
             s->top_of_screen = val;
+            if (s->top_of_screen >= s->vram_size) {
+                s->top_of_screen = 0;
+            }
             g364fb_invalidate_display(s);
             break;
         case REG_DISPLAY:
-- 
2.53.0



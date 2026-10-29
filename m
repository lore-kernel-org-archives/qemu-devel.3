Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TOat7BGe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVbr-0007gS-GE; Thu, 29 Oct 2026 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMVbC-0007ay-Ra
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:15:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMVb9-0005Hw-EP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:15:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so23765625e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793301337; x=1793906137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OOR8UafeZCZoNLAGO+5s54/UmhxQAMi7zOQSXFFedD4=;
 b=TOat7BGeqW3vMkGsTi4J5kqwdIiU0RwKyQ61kKd6obMKk/LxkhRrB+ogQ/CU7409RE
 m3QG0wsNzWPcGJVEmajG2gE3d1tqxEwSteniAop0VJJGyzbZEC8GUPOjFZSOhoiEBd5G
 +qpmeARXL65wiGxk+JW94QvlTH73VJQ4crn1fME9nkdXaiHeYoBuwuOIzSu0GQDGRU3v
 FtuHg271wkUmF9vcd3FNtUjwvmy9y2jPryayncLar8QLy/3FQZ9ZUHtxP1sgtHn6YQ6J
 gfkxNe3ZRzJuMCz48g4IDGZPYMSK4jFXz7nghk0kOeEjv21ZArQBFxz7Rfsv2vZ2ccUp
 aBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793301337; x=1793906137;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OOR8UafeZCZoNLAGO+5s54/UmhxQAMi7zOQSXFFedD4=;
 b=pxzgSkiIDE/KDCi9RZ7IkRHqczTIf8JrYioxQRkuGMogebVrP1teiKdgKBNDYCgfrs
 BMwTF5Q1neOl9u5CRRGy6zUSPDepfPZfMKFVky5BgW+lKBnxn0DQTrhaDfgLRAzgYtF1
 866xLATBI+NtmlcAa9libaRmMgX1r4FY47lKoREm7ebEGgPTdaI1UaT8dEcdpAnh/ps9
 q+b0itvRRUZdDhLnyWuDsQeTBspjrtkuZ2wPHZMj8WsIq2GycqBSk2UX/2w10x/qFnlG
 nsLivJWYkuIEk1W6REApF7eOw2VhxL+VZYQFs1s7BtN58iszEDcB4UmLgVHolufYsj7I
 d59Q==
X-Gm-Message-State: AFq9FYLCOP9e1ofEsthza5+Vz+sBL9zgrekKVfIeJa9iJHvs1Q2Y8m7D
 ojKdOkmYyePdhQz2dl1yrTFQmnxhk5N6nasutkIbQRhkzwDLZxkHvsE=
X-Gm-Gg: AYBFou2r9sGdFWYfSPs9LyXrAvunQGczzpc1t404IQ5zEBfxWggPMDWAS+JzlUO/nH1
 fdqQVbUzrjtu2Cwi1PFwfZii8brqFkchtO8VsEtsXWxnWp43IaATYuaqoYtTGmc2L6fIqjwnJb0
 5nCTqkoyoUM2AWS4r6ktE47PYb1LBn7MM1eZUT6jZp48cK39AE7xhJke7qQHKzbZtlowaLw9Gjc
 p4eg6Ysht7ilr790PxroJZrtT+ZoCT3rFybDdS4SZaVYeCxdo48bSWfCEEv9No364zQDp7xHYc5
 R+BP14oe8J6reCN2N9gDE9KKFdHcapjgQpz48p1NuShamaAhLl9BIJE1L4mjl3M34KftnChpv+q
 VznZ3wfhhQe5MKEyKH8VNyI3C4mQ2iaE0YEcVD7MgtiHf7rDvnVcG1Jpc+fZIeD1pbZDK1LXwF0
 cDpe2w0JBFZSIQPill/6Jf1DujkuKEDlVTn8Y5QaVe2OZRm80eGHsihMVB4Pvuhn6pWHmjoHr+w
 tO1VciYqlj3ftSGW4Tfz2BDAz9HftoXkbSdMDalfT27pTqukqHnsw5HJki67YIcU3bLqAGTOg==
X-Received: by 2002:a05:600c:1c0f:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4abcc038122mr18563335e9.18.1793301337479; 
 Thu, 29 Oct 2026 12:15:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm82576845e9.8.2026.10.29.12.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:15:36 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <arikalo@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] hw/display/g364fb: validate display window against VRAM
 size
Date: Thu, 29 Oct 2026 19:15:35 +0000
Message-ID: <20261029191535.3849290-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=tristmd@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tristan Madani <tristan@talencesecurity.com>

The G364 framebuffer allows a guest to set top_of_screen to any
32-bit value without validation against the VRAM size. The display
update function g364fb_draw_graphic8() computes its read pointer as
memory_region_get_ram_ptr() + top_of_screen, reading past the
allocated VRAM buffer when top_of_screen exceeds vram_size.

The developers flagged this exact issue with an inline XXX comment
("XXX: out of range in vram?") but never added the check.

Validate the full display window (top_of_screen + width * height)
against vram_size in g364fb_draw_graphic8(), using 64-bit arithmetic
since all three values are guest-controlled 32-bit registers. This
covers changes to any of the three parameters regardless of the
order the guest programs them.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4648
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Validate full display window (top_of_screen + width * height),
  not just the base address, per Marc-André Lureau
- Use 64-bit arithmetic to prevent overflow of guest-controlled
  values
- Move validation to draw function where all three parameters
  are known, dropping the insufficient write-handler clamp

 hw/display/g364fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index af54f1f..cc5b31d 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -126,7 +126,11 @@ static void g364fb_draw_graphic8(G364State *s)
     }
 
     vram = memory_region_get_ram_ptr(&s->mem_vram) + s->top_of_screen;
-    /* XXX: out of range in vram? */
+    if ((uint64_t)s->top_of_screen +
+        (uint64_t)s->width * s->height > s->vram_size) {
+        return;
+    }
+
     data_display = dd = surface_data(surface);
     snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->vram_size,
                                                   DIRTY_MEMORY_VGA);
-- 
2.47.3



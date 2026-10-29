Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FC606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYYh0UJN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX0V-00080B-6v; Thu, 29 Oct 2026 16:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMX0T-0007zW-Om
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:45:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMX0R-0007Qu-I5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:45:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so43249f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793306749; x=1793911549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M6+u4r5nQjbzpMAUrFOmI4ctHtvRybClkKEDaakzJ/k=;
 b=OYYh0UJNsATYTeyE2lBI3YrQpa5obP+m0l+953ATMDK09d1fYGMWg/ixewD5fEtkqu
 kMnF0NTD+ZqXjv0zV4i8DwuzcbQZZCpSjfkbzJNqWFTHxAafaPFK+zqb7F/3t4C3ZU8q
 YzvVW50UndLI2ToLePLM1c9lJsmOC/u0uTXRC4nqrFE5Yj9KxaJaqRxBuwxBrnOmsSzh
 uRUkgAoim9Wp+rJArMqGehZXCj/74852Tqoa2amqu/0B+J7I1uTr256Rphwmnlwiz7DZ
 c+EfhgdFMBoojCiYiKYdTtaMs0U5C4pZ43BOSoq7PlDZxvtouLimw353vRY4afW9Jd3g
 ESHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793306749; x=1793911549;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M6+u4r5nQjbzpMAUrFOmI4ctHtvRybClkKEDaakzJ/k=;
 b=duBWPRt6IOF7Hqc3a87uuGHws3V/xS4/otvGg5Od97G/LUuO4YOxIyrMFHYrMse1H+
 arpwkMzz41oVFMUFutdj50+aMxsqKOYDsXc8PeWPVfMxdzBK4usjbT11WL5v4jFMJZ7s
 kSTp7lZvHizkZ2bmwSAqRTG1KoXa5uGAj6Z1y7AAuQ0lShDQ7j9Dce8waqTKEprDkTV+
 eCqh2MLKIeMcn7by1xm4TwO6KsLZy5ZaiWf/kGsm7VJuKAwGVh+waczs32eIHi62eeF+
 34Q0w7aRFmgmgtuOLxk11CNT6xfhxa+eD5g77rsXVLhF9btqAwc+fgRAJz5tsNVhgnob
 yoeA==
X-Gm-Message-State: AFq9FYKKwpndracCPOKpqNtO0lg2WGLIjPOQYO5Dr0nm0kijXydfJquw
 clW0f3VMtEMoMTcmyiC0cBNCX75eLrkIrPmeDSBCt3axh75OhBSSwww=
X-Gm-Gg: AYBFou0ZQ+vP1Aim+wWo+y9sUfpKfFgEGnvhmR4v62NXCncSa4Uo7GwVV30h9StBXEm
 EvHin/xB2m7KHobQ187pdTnUJxGZa7fHdeKkcE9bcjpdMyIzyYP6ZlJWwK7ZFT9/c4HUAa6zAI9
 akYQqIqqOqyQO5XAzhqu4bVnLHujFwuCpLhn49qi1FPnVW65kFH14oYh8YI4vilb/RQdon9T4Ak
 5KukUC91I9dnr3lMWHg0zRSLr6nZCjyiWJ5G6jEgS4K3bWZ0Yax3bc5qgGqmJn0R9Yn7CoozYc6
 UausrphAd98HIFypC40I9aUgoXwSei0swCS9q/zau47t29OdL6XhK+Qx6gIJbd2wORgLjly79CF
 LME9qo39Qm/cZifI85EARAEE46snYxWClgwdDQT5zvwzEgFLsN/P25jUZNDcZEglJsKecRvUziY
 UadABOKjCSWT2nmoa7azU3f9TgW6Sbe5oNXnS+io5485iJHImUQJnZzIujHGhoW4amSXPWMIFUB
 yFesGeRiprBrJrLFRu4uCm2QD0X6eWkNLmbLVjvFKZjKLTJ+YH11UnhwRTaHM3N3fxqVfy8Dw==
X-Received: by 2002:a5d:5f95:0:b0:48e:6c23:9895 with SMTP id
 ffacd0b85a97d-48e6e50b790mr1126747f8f.31.1793306748910; 
 Thu, 29 Oct 2026 13:45:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eba337fsm551608f8f.59.2026.10.29.13.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:45:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <arikalo@gmail.com>, qemu-ppc@nongnu.org,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] hw/display/sm501: validate framebuffer and cursor
 addresses against VRAM size
Date: Thu, 29 Oct 2026 20:45:45 +0000
Message-ID: <20261029204545.1248782-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=tristmd@gmail.com; helo=mail-wr1-x429.google.com
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

From: Tristan Madani <tristan@talencesecurity.com>

The SM501 display controller allows a guest to set the CRT/Panel
framebuffer base address and hardware cursor address to values that
can exceed the actual VRAM allocation via the 0x3FFFFF0 mask.

sm501_update_display() reads width * height * src_bpp bytes from the
framebuffer base without bounds checking. The hardware cursor path
reads 1024 bytes (64x64 at 2bpp) from its base address without
bounds checking. The 2D engine path already validates VRAM bounds
via sm501_rect_outside_vram(), but the display rendering path has
no equivalent check.

Add a full extent check in sm501_update_display() that validates
framebuffer_addr + width * height * src_bpp against the local memory
size using 64-bit arithmetic, and validate the cursor address plus
its fixed 1024-byte pattern size in get_hwc_address().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4649
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Validate full framebuffer extent (addr + width * height * bpp),
  not just the base address, per Marc-André Lureau
- Validate cursor address plus its 1024-byte pattern size,
  not just the base offset
- Use 64-bit arithmetic for framebuffer extent check
- Move framebuffer validation to sm501_update_display() where
  width, height, and bpp are all known
- Return NULL from get_hwc_address() on bounds failure instead
  of silently redirecting to address 0

 hw/display/sm501.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index cacb6c8..c1b13a0 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -630,7 +630,13 @@ static inline int is_hwc_enabled(SM501State *state, int crt)
 static inline uint8_t *get_hwc_address(SM501State *state, int crt)
 {
     uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
-    return state->local_mem + (addr & 0x03FFFFF0);
+    uint32_t offset = addr & 0x03FFFFF0;
+
+    if (offset + SM501_HWC_WIDTH * SM501_HWC_HEIGHT / 4
+        > get_local_mem_size(state)) {
+        return NULL;
+    }
+    return state->local_mem + offset;
 }
 
 /**
@@ -1815,6 +1821,9 @@ static bool sm501_update_display(void *opaque)
         /* choose cursor draw line function */
         draw_hwc_line = draw_hwc_line_32;
         hwc_src = get_hwc_address(s, crt);
+        if (!hwc_src) {
+            draw_hwc_line = NULL;
+        }
         c_x = get_hwc_x(s, crt);
         c_y = get_hwc_y(s, crt);
         get_hwc_palette(s, crt, hwc_palette);
@@ -1837,6 +1846,9 @@ static bool sm501_update_display(void *opaque)
 
     /* draw each line according to conditions */
     offset = get_fb_addr(s, crt);
+    if (offset + (uint64_t)width * height * src_bpp > get_local_mem_size(s)) {
+        return true;
+    }
     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
     for (y = 0; y < height; y++, offset += width * src_bpp) {
-- 
2.47.3



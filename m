Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE823606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ajUmrLiH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3ep-00079R-C3; Sun, 25 Oct 2026 15:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29H-0001PC-TU
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xL29F-0007tE-7M
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:36:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so16837555e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792949804; x=1793554604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BIp6gGM/K7KuZ7aiDnARnjxMxSArFmKK0RAQaA0vWNo=;
 b=ajUmrLiHy30G9Y87wEYCH38kETbXVsNeZ0ChZiN14d3liIuUVvn74XUHRrlI9pozSH
 FTQ3ZNK9DGO0MagwbB3hXoirU0GAjvDJqpaFCCYAm49Qc6ePlxzOYGiA1FoK719jClXA
 LCs4Y+9cOzMMDTbybR2sIT1KDHC25Pb/b7WiP4xY03i3uKfHlfJYRR2UefcwpIA13dDg
 c4E8GBDsEsJf8m+6DYMH35DFKCKulmLlbeI2LKfVTpRScYLOYKjLK78F0OodPx2yFcVc
 bGjsGse6PuoeLLorhgeMJR8/ljaiOqOBLb2BAARBOsf5qQwh8mBXmWDCZZBmHXM163Lc
 btOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792949804; x=1793554604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BIp6gGM/K7KuZ7aiDnARnjxMxSArFmKK0RAQaA0vWNo=;
 b=RMr0Xe8bj8wzxDyl6l7Pd/yNK0j0x2DADgXun3cWP1ZeshysBfckv/7NfK7zaDtG68
 ytbjV81ssEV/HfW2fWvs5C3ynFyUXAPogF7ePSUFJNXcUbJcOZMGxnc7Mw3eX5f/qiml
 zBYMM28BWARxR/pH6KnFXmEq5tN4qeQk57zNEhYoe93gtxxU1Av4uYlyTR2qWwJcFz1E
 PjYZRaQkPc1P+mDuS4I9EMwG6TmGbBfaQn+/l7FI500Iidqchbqsaet1bXYAuY4A7eIF
 CsBL2rPIUKrpW+v5v08FotGH1+uRHHqZNjVrqcy+Hl09jDRBdfA4VFj1T2uQ+IhJu1NW
 7n6Q==
X-Gm-Message-State: AFq9FYIM1obHvRqSq1vsARQYucvdbGFbtG7a+RoucGlPIcu2zFrHDyct
 Nj0+mz8c35Oq4cCaBejmP+zxDhtXIcqPMvfL9m+reEPwPQ7hpllzlIYE/c/r
X-Gm-Gg: AYBFou1mZoSAE4jcjiNvl43UE/uF4JluKYxxdrmd1kdf99xDUM531eK+MawwLFTLc76
 0jXvi0VebcPNUBnlZBBJeNR7t2Rp3by5rIxh8rt57P54L6NrNif+Trp03KiyiN4q3wOSz9zxWTk
 n1UFf2w0331ic09ArbWzQaKnRkisYCBBUqv4e6bbNW2JejXlgFHL8HmjsjXL/FC3DTXUPzgmfsd
 VnsYvrIaDimWxkgfQTQuqzvYvrkxRWBUTPuXoZIlUHGdC6+wd57ulDyVIyQWp0svzUdW1kcV2ne
 mnWjNMhAVDCn1zDah7XNlBX3mK1u2tFJFacSs3xKL97lwQRir9dwxqSgL6ClC8xomfNJ+//8sZ4
 JktW2Nkx8XY1HV9Q/diO1qTdMnOMr/FoD9zHwqhSCvmJ1hKBSeUb1bFFb33OKCU7um460m0gIF2
 Hb1nVNeHTXCoHYvALzQLSUfZLRbwX2tp2nE5c97bWkSeVEBzckd3Py2hNrMtldu8+rASrSOnufX
 LFq38TWUdgJjmc7Ed/os4b4k7zHjGiRrnBcouelCjVkok4CkEY0WrONdYM=
X-Received: by 2002:a05:600c:21a:b0:4a2:d6cf:86e4 with SMTP id
 5b1f17b1804b1-4a35ac92156mr62378695e9.10.1792949803647; 
 Sun, 25 Oct 2026 10:36:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm10886890f8f.42.2026.10.25.10.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:36:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org, hpoussin@reactos.org,
 arikalo@gmail.com, balaton@eik.bme.hu, qemu-ppc@nongnu.org, deller@gmx.de,
 pbonzini@redhat.com, fam@euphon.net, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, berrange@redhat.com
Subject: [PATCH 4/8] hw/display/sm501: validate framebuffer and cursor
 addresses
Date: Sun, 25 Oct 2026 17:36:21 +0000
Message-ID: <20261025173625.3372689-5-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025173625.3372689-1-tristan@talencesecurity.com>
References: <20261025173625.3372689-1-tristan@talencesecurity.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=tristmd@gmail.com; helo=mail-wm1-x333.google.com
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

The SM501 display controller allows a guest to set the CRT/Panel
framebuffer base address and hardware cursor address to values up
to ~64 MB via the 0x3FFFFF0 mask. With VRAM sizes as small as
2-8 MB, these addresses exceed the actual VRAM allocation.

sm501_update_display() reads pixel data from local_mem + fb_addr
without bounds checking, and the hardware cursor path reads cursor
pattern data from the same unvalidated address.

The 2D engine path already validates VRAM bounds via
sm501_rect_outside_vram(), but the display rendering path has no
equivalent check.

Add bounds validation in get_fb_addr() and get_hwc_address() to
clamp the returned address to within the local memory region.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4649
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 hw/display/sm501.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index cacb6c8..b8e686a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -592,7 +592,12 @@ static void set_new_local_mem_size_index(SM501State *s, uint32_t idx)
 
 static ram_addr_t get_fb_addr(SM501State *s, int crt)
 {
-    return (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr) & 0x3FFFFF0;
+    ram_addr_t addr = (crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr)
+                      & 0x3FFFFF0;
+    if (addr >= get_local_mem_size(s)) {
+        addr = 0;
+    }
+    return addr;
 }
 
 static inline int get_width(SM501State *s, int crt)
@@ -630,7 +635,12 @@ static inline int is_hwc_enabled(SM501State *state, int crt)
 static inline uint8_t *get_hwc_address(SM501State *state, int crt)
 {
     uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
-    return state->local_mem + (addr & 0x03FFFFF0);
+    uint32_t offset = addr & 0x03FFFFF0;
+
+    if (offset >= get_local_mem_size(state)) {
+        offset = 0;
+    }
+    return state->local_mem + offset;
 }
 
 /**
-- 
2.53.0



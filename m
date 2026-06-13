Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C35CD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQhs-0008Vx-5K; Sat, 13 Jun 2026 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wYQCK-0007SL-Li
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 11:23:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wYQCI-0002fz-VO
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 11:23:00 -0400
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36b7b7b7a80so1383917a91.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781364177; x=1781968977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mMXTU2ZXIuCA5mgFvk7PVjZZ7pXKY2stODnzkrc6ruc=;
 b=AbWHVOsT9gFE75utbZQk0o57Ydqjz20ORDGoO6bxaXfeCTeHy1bz/Zn/JdAT/6xBG3
 Jl1ym02keI9F4IcT1e2/JUoFe5lreQfgR1KQuZJcI6vB+m+7DwATrPbRqBNiDDqQVn0i
 pakMv9L5jY09+840OxfQxDO4P67wMuYBBaZHUWAmytVIzDu0GA3G4i1/Y/k17kGtzoB/
 7xXBsWwkHIFvFPWCZj8Sj+ZvH7bM+Ge/CoI8/Xqx9X5se4MJUdFl9YqvE3j3RSOPGlE0
 ZRFIgtsKxNU4P9bQqCk+87lfZT3jbLCwGAKE0nNg8qnRbN5RoP8FfW/Orsc9Iw/zpBIo
 BP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781364177; x=1781968977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMXTU2ZXIuCA5mgFvk7PVjZZ7pXKY2stODnzkrc6ruc=;
 b=qFfWlpMzgl8+06daNBPnsEffxrWFxPgNPFCqzewpO8f46poPUKMjBUZ2Lb6e2TRCdQ
 47UzOMhzzFZDyPfSEUrdBbNGwAurFXoDtQYGS1J1l2dPBhT6QoDORr5z1Fo5DsoRyjyn
 x1L3qlYMP02SIX4C6CDrj7ulY/2yU2Fv4D8Ii5Y2AU9fMhI93LiPq6WVAq2ZqdvPtpRc
 8JReKSfaalwVGJFOzEx6IV+tdd5vMbOROm4XU+A77Cm5fEEcHEtwus6WYE1zoOqtxBDg
 OAVxj8z/hCVDUjqVU3cBcqaYQ3XxpbiBjaRPF67h8IGaVE4PdXFIMv3NZcPeI3+m/NiS
 xAaQ==
X-Gm-Message-State: AOJu0YxvOl+4x4uiFnUOrq5X97wtK6pRMK59af7qL3rWX6ExE6CIUhfM
 I/I8STo2F/N2euP2LeAwmJapQlq7K13W0IjlijF669RNj+Nwahrf3w8xUy1Wq/if/ZE=
X-Gm-Gg: Acq92OEONl5oVUJ60ZuUGXejEgmELMpSfXjH/hBGSecqLw26vLbNXGiP1qi42Sw5R52
 IdvSBtPt+h8gXNU6ELc2vL1QyvPcuKLNKrFZrzxaMdjLB0jqdaZaDWfKkP//jGIszZS5vlcgZGV
 cjnJly7hnw96qqR4qjDHMgxuyJoOBjh8fw1LIXkOzeCdAyW72P3AhL/V5E4nB5BHUyPRFJwpOTs
 Twc2IFE4a0UlrBFrZ8eFv1/vBqJv8nskkgvSc+JHlX/x32ItJSTGEvnbPLAjpiVaQrx9780JQVp
 rvEG/Z1I0CTeoRqQKnpc5r5jSFTZb3WURbRp172uLohk203Fhi0i7z9JPk6r7ExeA7FzhvFSXZN
 T1TMLOTXF79jxEBUdP1ppiFeKcSP0R3O+hRzwg/W/cmQjMacmQY+FSV+Q8YOIx+OHsKvSNiW+xL
 aQXxlXF0tQEiVRvcF9OHlVNx5449kP8jRqPJ6wpLZos5zlRDiC4w==
X-Received: by 2002:a17:903:944:b0:2c0:af09:f3d4 with SMTP id
 d9443c01a7336-2c3fd9ebc4cmr64975115ad.27.1781364176814; 
 Sat, 13 Jun 2026 08:22:56 -0700 (PDT)
Received: from DESKTOP-O31H9PS.localdomain ([157.49.119.134])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm52643775ad.65.2026.06.13.08.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 08:22:56 -0700 (PDT)
From: valium007 <valium7171@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 valium007 <valium7171@gmail.com>
Subject: [PATCH] linux-user: Fix AT_PHDR when program headers are relocated
 into their own segment
Date: Sat, 13 Jun 2026 20:51:56 +0530
Message-ID: <20260613152156.41147-1-valium7171@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=valium7171@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 13 Jun 2026 11:55:34 -0400
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

When a binary is patched or relocated such that the program header table is
moved into a separate PT_LOAD segment (rather than sitting at the start of the
first loadable segment), QEMU's AT_PHDR auxv entry becomes incorrect. The
loader was computing AT_PHDR as load_addr + e_phoff, which assumes the headers
are mapped 1:1 from file offset 0. This breaks when the headers are elsewhere.

The Linux kernel instead locates the PT_LOAD segment that contains e_phoff,
then computes the in-memory address as p_vaddr + (e_phoff - p_offset). This
correctly handles relocated headers.

Fix by:
1. Add phdr_addr field to image_info to cache the resolved address.
2. Initialize to load_addr + e_phoff (fallback for headers outside any PT_LOAD).
3. In the PT_LOAD mapping loop, detect if the segment contains e_phoff and
   override with the segment-relative address.
4. Use info->phdr_addr for AT_PHDR instead of the incorrect formula.

Signed-off-by: valium007 <valium7171@gmail.com>
---
 linux-user/elfload.c | 21 ++++++++++++++++++++-
 linux-user/qemu.h    |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b05b8b0..8049c8a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     /* There must be exactly DLINFO_ITEMS entries here, or the assert
      * on info->auxv_len will trigger.
      */
-    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
+    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
     NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
@@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     info->data_offset = load_bias;
     info->load_addr = load_addr;
     info->entry = ehdr->e_entry + load_bias;
+    /*
+     * Fallback for AT_PHDR if the program headers do not fall within
+     * any PT_LOAD segment (see the loop below, which overrides this with
+     * the correct in-memory address when a containing segment is found).
+     */
+    info->phdr_addr = load_addr + ehdr->e_phoff;
     info->start_code = -1;
     info->end_code = 0;
     info->start_data = -1;
@@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
             vaddr_ef = vaddr + eppnt->p_filesz;
             vaddr_em = vaddr + eppnt->p_memsz;
 
+            /*
+             * If this segment contains the program headers, record their
+             * in-memory address for AT_PHDR. This matches the kernel, which
+             * locates the headers via the containing PT_LOAD rather than
+             * assuming load_addr + e_phoff (false when the phdrs are not
+             * mapped 1:1 from file offset 0, e.g. relocated into their own
+             * segment by a binary patcher).
+             */
+            if (eppnt->p_offset <= ehdr->e_phoff &&
+                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
+                info->phdr_addr = vaddr + (ehdr->e_phoff - eppnt->p_offset);
+            }
+
             /*
              * Some segments may be completely empty, with a non-zero p_memsz
              * but no backing file segment.
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 07fe801..2268493 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -26,6 +26,7 @@
 struct image_info {
         abi_ulong       load_bias;
         abi_ulong       load_addr;
+        abi_ulong       phdr_addr;
         abi_ulong       start_code;
         abi_ulong       end_code;
         abi_ulong       start_data;
-- 
2.54.0



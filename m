Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0546C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfL5-0007Ia-BC; Wed, 05 Aug 2026 13:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfL4-0007IK-1t
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:23:34 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfL2-0007Es-Jl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:23:33 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81e9f7491ffso18971307b3.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950611; x=1786555411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HU8SWdyc7YM0eOpNUyPRM6bfswg2Sg/ff1Lvi04BSak=;
 b=UGoLGAIn301s+31DihSvM9ghQv8QfmBFU4VwdtZa7dyDgoq4nGindQ3d25j68hy+2j
 7XnQrYDtnEVCG0uD6LPvfFGFNAL84hJ2d/o8pgpT4qLey2XyvkQlgAg/YtXeJkN7EPMi
 KYWH7z7yy8H/M6q4fta9IPZ2rAHl8EfNErN2gZuZum6kH4/x9wIXzZ1v8PJ0U+vbzZ7a
 dBZ0HvmijlsKnKf6BVuIH5WKdPAnpAFXtBfTPs6ReVRHpI9pyTZ1EvceJAnHPdRdH+fE
 88lwE3L0d8K09AxzoMroLWTDKutPeFL0chq4rVqbxK62C3eFxYp39oh/1RJwV6T30fg2
 bfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950611; x=1786555411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HU8SWdyc7YM0eOpNUyPRM6bfswg2Sg/ff1Lvi04BSak=;
 b=NsGh0UggGC8zXnG6faucYrIaT5i5ci4l/3QR8c+EYgmGZCVPHyLCL78R/QKg1lGtGO
 gYXfy7sezezDkxRJhKTpfZ9VJl8RLPKZ6hDwhQZOcPw+ZXorHtimskSGtBl+YMzmrsdq
 vemUyJWNO+0zjT/F9LMfqGehiePm+YDaSk7TeIJ6d1Jwef/OOIqxF+i1ESri6NLC5Sdx
 HZOBXGdwtRIvwq4JA5/Y58y9V46htJMCpI2Du89eRIUdmEWSwPSgkC05fQufbGihfn1R
 jqvYYpD/zcVoAHoAalIz6uHNwYOQYCrtrKE+covl3WnD2ZIbvpebC2jZ/928YfiTGlFE
 2Wsw==
X-Gm-Message-State: AOJu0Yy2Y+3sX2BR8OAFkwooB74O26f0gx1UcAr8fHsSpHWeNb0cTTtn
 EomNnkcdJQNSK5NP5LdxiIoQE+T8HR+7jnd0Af3DL7Pd3jbIIoDE2cbbiN+KqfvRPtQ=
X-Gm-Gg: AR+sD12RJN2Trl5h7B7wA+DNWhrYzu+eB4ajCLKELoeq6/MozbDUMY0EHpDYahxBuU+
 t/upHvT/51sFZvZzFVXiGddiijp6Dg3sADrxjwCyesDlrqtI5BV9yQdfxouZZcnAe+jNZqE1AA8
 EAVcLIJ4W3/D9ucdZFuJ+IGGvTRFDOIazOTw51vCbixygJTUksM/ZwHBTZrHzhil5F4AvfWistB
 /Gjxv+9+Z7ROJo/i0Vc2Xzf/FCrLqZXPfmh2RfPQt2YemYcZNUY5tFUkFaqnaJRrYqbvU71RZgB
 lxhkt4dDq3o0O8lONiiSvWSPL4U51JZXcF9FKToomIqJp9r/bN3PZz5LYcP6m+uutSCXz4Da+Ck
 hAhBEn7S5Sw014zZ0BKKvUe7BBvH1Vf5k9Jv/qqPE7SHOfDkrElwRioJN432coQRyLxZSFaIHFq
 5n64KJwjXpvDZ7BwgPXw2E+NlJBGXG17+cA8ASGDalQy2JXGpLTNm3yofpEEa7
X-Received: by 2002:a05:690c:6b0f:b0:81f:3800:606 with SMTP id
 00721157ae682-8202232314emr50594517b3.16.1785950611141; 
 Wed, 05 Aug 2026 10:23:31 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8201325f52asm23998417b3.19.2026.08.05.10.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:23:30 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/5] linux-user: support writing floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:23:29 -0400
Message-ID: <20260805172329.3121925-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Write an NT_FPREGSET note for targets that opt in: a target_elf.h that
defines HAVE_ELF_CORE_FPREGS and target_elf_fpregset_t, and supplies an
elf_core_copy_fpregs() beside the existing elf_core_copy_regs().

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Apologies -- this prerequisite patch was accidentally omitted from the
series I sent earlier today (Message-ID:
<20260805171507.3119442-1-mattst88@gmail.com>).  It should be applied
before patches 1-5 of that series.
 linux-user/elfload.c | 19 +++++++++++++++++++
 linux-user/loader.h  |  3 +++
 2 files changed, 22 insertions(+)

diff --git ./linux-user/elfload.c ./linux-user/elfload.c
index e7c56af8ed..88508deac5 100644
--- ./linux-user/elfload.c
+++ ./linux-user/elfload.c
@@ -1887,6 +1887,17 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
     bswap_phdr(phdr, 1);
 }
 
+#ifdef HAVE_ELF_CORE_FPREGS
+static void fill_fpregset_note(void *data, CPUState *cpu)
+{
+    /* Fill locally and copy: note memory is only aligned to 4. */
+    target_elf_fpregset_t fpregs = {};
+
+    elf_core_copy_fpregs(&fpregs, cpu_env(cpu));
+    memcpy(data, &fpregs, sizeof(fpregs));
+}
+#endif
+
 static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
 {
     /*
@@ -2166,6 +2177,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", ts->info->auxv_len);
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
+#ifdef HAVE_ELF_CORE_FPREGS
+    offset += size_note("CORE", sizeof(target_elf_fpregset_t)) * cpus;
+#endif
     note_size = offset - note_offset;
     data_offset = TARGET_PAGE_ALIGN(offset);
 
@@ -2222,6 +2236,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
             dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
                              sizeof(struct target_elf_prstatus));
             fill_prstatus_note(dptr, cpu_iter, cpu_iter == cpu ? signr : 0);
+#ifdef HAVE_ELF_CORE_FPREGS
+            dptr = fill_note(&hptr, NT_FPREGSET, "CORE",
+                             sizeof(target_elf_fpregset_t));
+            fill_fpregset_note(dptr, cpu_iter);
+#endif
         }
 
         if (dump_write(fd, header, data_offset) < 0) {
diff --git ./linux-user/loader.h ./linux-user/loader.h
index da9ad28db5..5ddd140276 100644
--- ./linux-user/loader.h
+++ ./linux-user/loader.h
@@ -109,6 +109,9 @@ bool init_guest_commpage(void);
 
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
+/* Only defined by a target whose target_elf.h sets HAVE_ELF_CORE_FPREGS. */
+struct target_elf_fpregset_t;
+void elf_core_copy_fpregs(struct target_elf_fpregset_t *, const CPUArchState *);
 
 typedef struct {
     const uint8_t *image;
-- 
2.54.0



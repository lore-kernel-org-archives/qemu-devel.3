Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C24CEBF7E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 07:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su5Gw-0007gp-BY; Fri, 27 Sep 2024 03:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3n1z2ZggKCnAOfRP+UWhUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ardb.bounces.google.com>)
 id 1su5Gp-0007eB-FV
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:20:07 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3n1z2ZggKCnAOfRP+UWhUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ardb.bounces.google.com>)
 id 1su5Gm-0002ps-OE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:20:07 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e22f0be237so34198537b3.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1727421599; x=1728026399; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OgGxdzkwhJAJ9NOcliVi3NgTrAWOMCFFcr8qpMg1A1c=;
 b=XVRWqBzAl6qtm+cenLEdnJvqxQvwRpSnrCLIu//mUaBj8zLl/OGQAfW3oOx6ZW0NyO
 OHl7rcYTdIb+ymHWjeC6W1az8P+yBkPellTuHO8CcnKqsrzawtSJdPZhcPe9fec3f0nO
 yE6ufUQFAq+y1yVCoxYiK75gOkipiQO2+4c+CMx5QLvbNH9lZzJztZEDB+FiubtsCIDV
 evrqSPA3mbRuGPzfRtPQkEvL2CBYyuZm0aMmnfmcfUMeElI/pYtk0iFgGn7YL2HuAjNJ
 tY9GRMSNIQ1cdew91feFDru0GzuGb0OKVscBcDTxuEWBJ8FcZWAPVOUqSdGGZS0qyc2q
 xhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727421599; x=1728026399;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OgGxdzkwhJAJ9NOcliVi3NgTrAWOMCFFcr8qpMg1A1c=;
 b=fIX6B8nWXiXTEICDpLIFTM2RzecZloovcmXQUSKmsoz+FplQenRe8g5N+FPp+eDCWv
 VUTsjB2gfpbvBCeu6F9lcyerZUxVnXQM7WyHBuxUmtY3BXeQNvbXZjpe7lZNt35d1+ak
 V5+RLwTlk3tQEp/Uh++bG9OEp+46tgAWvjbh1pzw+o7cNiaTuDF8peWtGVQ0DdZDEsmA
 K5nUrDIGQIO+hfAM9N6okaiWa+bcIlcP7hra+CPrJO3ge6PDV3oGMrzr3GC/twFTk7ev
 fULRgRmwYcaRJQqwBGU+5jb3FIU9udVCp8m9Qzh1N2wlTGjIHM3MeKTUMKibAkUMxHAk
 YYwQ==
X-Gm-Message-State: AOJu0YyIRm/5phDs0Tsz2vW1HK3Ki7P40aCGzQ0mv1NTwggiD8L5vhdU
 4nitEwvYiptpRLaBGXlPmTs9OZ5hk3E6afHPmQLC8ogCp/EyPDoay2ElpxtGZ2W63OLMP9cBkYu
 uVIHzeaEOmaqKM0LT91yBIiLhqHzLDgFgtPKtHXERZxxluzQLCQ43pyV0Y71ZEEPf16sq8wrj4B
 3QEy6rt3UvLKVQH9QT61AK
X-Google-Smtp-Source: AGHT+IHt5/itZDbIJJU5kYUykfmy2GrI+eHJFLYr01f3D/51Rl7ocNh3AA3MsbPuJXtLza8p7BgMSo3T
X-Received: from palermo.c.googlers.com
 ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:c83:b0:68d:52a1:bed with SMTP id
 00721157ae682-6e2474d2257mr710357b3.1.1727421599325; Fri, 27 Sep 2024
 00:19:59 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:19:50 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927071950.1458596-1-ardb+git@google.com>
Subject: [PATCH] hw/x86: Always treat the PVH entrypoint as a 32-bit field
From: Ard Biesheuvel <ardb+git@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3n1z2ZggKCnAOfRP+UWhUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--ardb.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ard Biesheuvel <ardb@kernel.org>

The PVH entrypoint is entered in 32-bit mode, and is documented as being
a 32-bit field. Linux happens to widen the field in the ELF note to 64
bits so treating it as a 64-bit field works for booting the kernel.

However, Xen documents the ELF note with the following example

  ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .long, xen_start32)

and uses .long in the code as well, and so reading more than 32 bits
here is risky. And dereferencing a size_t* in portable code is just
bizarre, so let's use a uint32_t specifically in all cases here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 hw/i386/x86-common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 992ea1f25e..5b1971c13b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -539,7 +539,7 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
  */
 static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
 {
-    size_t *elf_note_data_addr;
+    void *elf_note_data_addr;
 
     /* Check if ELF Note header passed in is valid */
     if (arg1 == NULL) {
@@ -555,8 +555,6 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
         elf_note_data_addr =
             ((void *)nhdr64) + nhdr_size64 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *elf_note_data_addr;
     } else {
         struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
         uint32_t nhdr_size32 = sizeof(struct elf32_note);
@@ -566,10 +564,10 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
         elf_note_data_addr =
             ((void *)nhdr32) + nhdr_size32 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
     }
 
+    pvh_start_addr = *(uint32_t *)elf_note_data_addr;
+
     return pvh_start_addr;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog



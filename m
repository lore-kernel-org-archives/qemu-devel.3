Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D08C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEV-0002fJ-ET; Fri, 21 Mar 2025 14:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEN-0002Nl-Bs
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEL-000732-6u
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARwQvT1yfemKSMVduMIcuJwWl7QM1d9mutRu5Jpdvbc=;
 b=ha3Acsru2kMEegsAo7IhiRlA4KsrkNdfjbQg2tscmW8LBsaIIeP+OeSRkZBgtJTOGm9h8R
 i9KuE0vuptrVYqJgXeAKtD+oDP0BykM+yAMSwsk4GxfeXlBjrus8mZj6q3lYdPnHAy/aC2
 anbRiwSasqtcJGiLVagQ/bCdEdtNmGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-agGpQ4-mOYa3yLLE6PuHtA-1; Fri, 21 Mar 2025 14:36:26 -0400
X-MC-Unique: agGpQ4-mOYa3yLLE6PuHtA-1
X-Mimecast-MFC-AGG-ID: agGpQ4-mOYa3yLLE6PuHtA_1742582185
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so16791975e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582184; x=1743186984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARwQvT1yfemKSMVduMIcuJwWl7QM1d9mutRu5Jpdvbc=;
 b=gESUC63ObrCJF68W+plpmEqVYMLFYW+dVgZZ8xma7Ac14cQjKYLFM+mQ1Swp+4zxwX
 NaCXLSPRW/l7ft3+uOYwuRgsdT/6Pj+QpU8INYmiLjLxijx35M8f8bfwmG8GsIxvyyue
 d1pmz+HYmgmof/8Ml86SGY7d6Z5OJGnHp5AO8i0uTB3ONLxB79bqz95en8JcU99JGw65
 BjOgUVp+fpsKgKilTtwchYeodwgExs6CYa0+aHykgqvztcSLRG3vCUf3GePdfSElvoHC
 zE2DTb6PqmS1e7FN7SsatgtRdOCOHoRpzesPtD74/lq0snRy3QiXqYHAK9KRy5kERBuP
 +7gA==
X-Gm-Message-State: AOJu0YzjTRJCblAUfG6IvMyeZw/6a7XIGMmzZrdekiMiTqGnRJRD+ojJ
 jtlG7GSP//ZjTZ3AwbmCWENTrU+qm5vmcl69NFb4ilPyMHtvseUOY1yNcMjHaTNyfB+/nHZN9iq
 e6QPYolgEVeEDv6+gC+Sd3NnIZ8cq1rh5TOH6v+W0KGLQPY5Bg8fcFy+1rqvCBW7gNCIAm0KCpM
 qtAnBbklJ+EUIWsZcIG1XDki/7W17BizMUr0do
X-Gm-Gg: ASbGncsLf5Cl3clRE4LEzDSAEABP/gWfGMxNxIYatF3VZDBDmwYluNZoAMVjQ0NpK33
 Q3AScxz68IBCjc5OJEaxy5EtDRM/wgIgKkxvMQqbCiRq43ko30eWyFq4d84o8tCheuH3DORm/NH
 nx3ReWFhwraVJw7nccxVZ8ox+jNnztMPlDi6VevON2Duwrz0DsDbMvdJoRG25BmUvUoFXWGup2H
 bbkide9/+RmReAhHM1Mw0y2vPhW/+N3EqAkzlZEf2dAD1vY45v4Fg2MXacJEhmKWGeCTtEbuerH
 LLkCLNHNMG4RGGC7WoXs
X-Received: by 2002:a05:600c:c07:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43d509e4640mr41408395e9.4.1742582184450; 
 Fri, 21 Mar 2025 11:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExia5UvrQSVHPoBcIrkOomqSQ8Oaj7AVZIKYatjFo3b3QqoM9Cc7MiWAl7ZAuq8sRs+//gsA==
X-Received: by 2002:a05:600c:c07:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43d509e4640mr41408115e9.4.1742582183861; 
 Fri, 21 Mar 2025 11:36:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3a10sm3012109f8f.28.2025.03.21.11.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/24] exec/cpu-all: remove BSWAP_NEEDED
Date: Fri, 21 Mar 2025 19:35:40 +0100
Message-ID: <20250321183556.155097-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This identifier is poisoned, so it can't be used from common code
anyway. We replace all occurrences with its definition directly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/r/20250320223002.2915728-2-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-all.h    | 12 ------------
 include/exec/poison.h     |  1 -
 linux-user/syscall_defs.h |  2 +-
 bsd-user/elfload.c        |  6 +++---
 linux-user/elfload.c      |  8 ++++----
 5 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8cd6c00cf89..47b14446b8f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,18 +26,6 @@
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
-/* some important defines:
- *
- * HOST_BIG_ENDIAN : whether the host cpu is big endian and
- * otherwise little endian.
- *
- * TARGET_BIG_ENDIAN : same for the target cpu
- */
-
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-#define BSWAP_NEEDED
-#endif
-
 /* Target-endianness CPU memory access functions. These fit into the
  * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
  */
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ed04b31083..2c151fd1e0c 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,7 +37,6 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
-#pragma GCC poison BSWAP_NEEDED
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 86d773add75..5d227599924 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -462,7 +462,7 @@ typedef struct {
     abi_ulong sig[TARGET_NSIG_WORDS];
 } target_sigset_t;
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static inline void tswap_sigset(target_sigset_t *d, const target_sigset_t *s)
 {
     int i;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 833fa3bd057..3bca0cc9ede 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -44,7 +44,7 @@ static inline void memcpy_fromfs(void *to, const void *from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);            /* Object file type */
@@ -111,7 +111,7 @@ static void bswap_note(struct elf_note *en)
     bswap32s(&en->n_type);
 }
 
-#else /* ! BSWAP_NEEDED */
+#else
 
 static void bswap_ehdr(struct elfhdr *ehdr) { }
 static void bswap_phdr(struct elf_phdr *phdr, int phnum) { }
@@ -119,7 +119,7 @@ static void bswap_shdr(struct elf_shdr *shdr, int shnum) { }
 static void bswap_sym(struct elf_sym *sym) { }
 static void bswap_note(struct elf_note *en) { }
 
-#endif /* ! BSWAP_NEEDED */
+#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 #include "elfcore.c"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8799e4ea27d..fa83d78667c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2121,7 +2121,7 @@ static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);            /* Object file type */
@@ -3143,7 +3143,7 @@ static bool parse_elf_properties(const ImageSource *src,
      * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
      * Swap most of them now, beyond the header and namesz.
      */
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
     for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
@@ -3999,7 +3999,7 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
     prstatus->pr_info.si_signo = tswap32(prstatus->pr_info.si_signo);
@@ -4038,7 +4038,7 @@ static void bswap_note(struct elf_note *en)
 static inline void bswap_prstatus(struct target_elf_prstatus *p) { }
 static inline void bswap_psinfo(struct target_elf_prpsinfo *p) {}
 static inline void bswap_note(struct elf_note *en) { }
-#endif /* BSWAP_NEEDED */
+#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 /*
  * Calculate file (dump) size of given memory region.
-- 
2.49.0



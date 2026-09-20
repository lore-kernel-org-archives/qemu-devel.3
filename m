Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDCC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zN-0006VM-T3; Sun, 20 Sep 2026 01:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zL-0006Ug-W4
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:20 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zK-0002DH-GD
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:19 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-804f7045f3eso715408a34.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881677; x=1790486477;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvfLAYzdUMc/aXqc2ufYB8ivtZNCa2xy/qKq82+4GXU=;
 b=GLQaTkksxGd59YmSbTkAGzdGhunFGW393cSpL26WcLvkQD98XkWQZtczS9emhOKaWn
 k0mwuliGEvzQZ0f/HYSr0d43fmtoCtp/he++lOg2LP/Yjb7Dg8+jYO+QBIp++XUHsd0S
 P4xNcuqhTdi3dICs9tw3DYvryvP8cunC65BNHRIxyIAYEPrFknNPIp+J1vfC2aprFNGL
 BwlS/NEYE9F8RRSRKFdMhBHI1xa0GcFbTs01dDoKCGb1is+7G7ldPz4asfZmIXSG1wlv
 +UDcmUvOSICa8AVBsq/8U/XGIrHvUdxU6K/sQJvQLKd6YM3+N072bwbgJa9SGLpcDcFj
 aj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881677; x=1790486477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvfLAYzdUMc/aXqc2ufYB8ivtZNCa2xy/qKq82+4GXU=;
 b=KlphFl4ueXKZkcCy+jPcEWNpW4m7F7//hQwMtyxxhXhUuEg5uYDf81EgAOf6D/3oTu
 T/AuBgFkNxEk7BBCQONWV+ToO7aN/z/75xrH+e6WL3wrLamE571Pb+rJSmgk0MK5YHKo
 MLDI6qMuBGW9gwFmU+GckYnXxh1SbsNo14hp8COEEplYVIkMvlIj1TbBFyRmH6OKlrML
 oEfqlj5i6nXjQB4a5R2SXDC7fzRwMltTz+QEFT9ngnT2EmxnFeJSGVz57HyG2xAIxa8q
 Ag8hBP73UrGc6ocK6xyqYDTLuHLrWNc6+Tt4Pi+HjZb1GRczE3brwY2ptwoF3ly/X+cI
 ByvQ==
X-Gm-Message-State: AFuF++nINIgRsqOs5ZXqnCB5spjfIkPMMS+SD7aaaIpxX5WLMGjrctBK
 P8WjffmMXGhJ9NKcUQUymj/qf+CaYq2Hc/VDBw/PLOG4TezX+MVPOFU5XXFlICNkIX6gytskmb4
 gC+p1GaQ=
X-Gm-Gg: AYBFou3VWeJLdyrmg049kMEI9VGQXNtZ2PIJE63O4cQOWzNywgKGP4YplquPaRJ5dm0
 tiph4Wq6pYPjfnMXnHVxcRhyiBfhFn0UG6HuoQ16xC54bNSgUqVwBHdXIMH3BhCOxwa9TR2Mx5N
 DR+t5wGCgqjv9L2LEHIwgU78oXslx80PBh9qT5rMP70zeOgs6iHoSrA2c0NbP65pKpECDSn+Pdy
 iIqpD3EpKRm1dLIrDjBbZAOxRxtCTJbCQa6OnmzpD1+onOTJovzcDlxorbtLP7JYuPJFHpRZQy2
 mfzDZwGEAfYSF6r/+pS3KykFr8ViX7//bY3vEaMvaVWXIj1yHVkHgeMjUQQHm0I2SRG8m/cuwbl
 LD6cwyDTYZ7wItxiQaGsZPbqG/GLBF/s00etm1ffj51SQsQvdu9olPkR/kcCA0CXq/dUrs0j8jV
 uWVpC1YKPNIjD2+cCThQyuFwcMBXKiLJc3NdRhGw8d/+4p3DaEI3TUmsXrlg==
X-Received: by 2002:a05:6820:222a:b0:6a3:8738:4106 with SMTP id
 006d021491bc7-6ca9aa43f4dmr7332830eaf.26.1789881677400; 
 Sat, 19 Sep 2026 22:21:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:16 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:49 -0600
Subject: [PATCH 13/14] bsd-user: Fix non-PIE binaries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-13-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Maksym Sobolyev <sobomax@sippysoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=aKi+hp8N0vkEWYbWo/tfDhqS0kcZ6HksKo0mGdxawro=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20xuqS7FFClJZHPmAvPW1orCoJ5tX9He3Pfb
 +LL2ZCew/eJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBQ0BAAjbUHdUNH6gAmKlHNMLvPs3t9LgmGK8/
 2S0PQTosWBObvpvLqqdblXcYtHO6JZeUJIqQfMEf0PVwhGbI1zBI9RokL16WUadOJI8TmVUZkE6
 2wPGQ0TPJAxxi1Rg7cPPRLk3qrY0ZbRVB3dDovX8EfTR1Cc4TGxqe+9WTV3U+tL1W/12ItugvDE
 uuoBY1H3QGiJMvpGdXv2qIpBmfyCzOBkDlHF6T24TFgNA7ZL0/FbzaIM54zjBzR6ubjGPiCdTh8
 7h21i8kje5KxNFq+pqt7Xb900gwj18//p/RstVPTUaEMo5eQ57MtJzctAjYKZCgUZiKkmAFXWbk
 vBVWX5f+NRMVNMOTuF2/asy6cgFxYzAVe50ZbYPrXYm8elUjerpgUiFpKf+7J6Sz5wQZ2XAB1o/
 K84xekWy9gieRWJysg2JeRmKhdUGwtphusjXWJUivEOgCR0D4a0gV6CBSVKMbT6/R6XOJEuPWTB
 PxaMpZ8JN0VeP2ZI0M3uZWzFPuCkkc5gLUz0P21ATuZj70wDvLk5oy2qKkdMdWdrHjS6vDU9u5R
 uTFhYNmj1CW8tDu8i9K8hr8nA0gowDj46+y5Syj8KxogNOQtcGoKySAbwI1kGf003KPU0Bu9Q7V
 nBY5sNiZqgn7fHYOAWtkJOGtxWCW4aQgml0jlQPNAQ3ogtAd0nWk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Maksym Sobolyev <sobomax@sippysoft.com>

When loading non-PIE binary (could be either static or dymanic),
make sure to set MAP_EXCL while mapping the program text. Otherwise
if qemu is also non-PIE it might be loaded at the very same
address, effectively self-destructing after mapping target binary
over its own text area.

It is not a problem for fully dynamic binaries loading, as in
that case the initial mapping is non-fixed, so the kernel would
pick some non-conflicting area for us.

 32625 qemu-x86_64 CALL  openat(AT_FDCWD,0x7fffffffe240,0<O_RDONLY>)
 32625 qemu-x86_64 NAMI  "/usr/bin/cc"
 32625 qemu-x86_64 RET   openat 3
[...]
 32625 qemu-x86_64 CALL  mmap(0x809222000,0x20001000,0x7<PROT_READ|PROT_WRITE|PROT_EXEC>,0x1012<MAP_PRIVATE|MAP_FIXED|MAP_ANON>,0xffffffff,0)
 32625 qemu-x86_64 RET   mmap 34512969728/0x809222000
 32625 qemu-x86_64 CALL  mprotect(0x809222000,0x1000,0<PROT_NONE>)
 32625 qemu-x86_64 RET   mprotect 0
 32625 qemu-x86_64 CALL  mmap(0,0x458,0x3<PROT_READ|PROT_WRITE>,0x1002<MAP_PRIVATE|MAP_ANON>,0xffffffff,0)
 32625 qemu-x86_64 RET   mmap 35049844736/0x829223000
 32625 qemu-x86_64 CALL  minherit(0x829223000,0x458,INHERIT_ZERO)
 32625 qemu-x86_64 RET   minherit 0
 32625 qemu-x86_64 CALL  getrandom(0x7fffffffde10,0x28,0)
 32625 qemu-x86_64 RET   getrandom 40/0x28
 32625 qemu-x86_64 CALL  mmap(0x200000,0x2053000,0x1<PROT_READ>,0x12<MAP_PRIVATE|MAP_FIXED>,0x3,0)
 32625 qemu-x86_64 RET   mmap 2097152/0x200000
 32625 qemu-x86_64 PSIG  SIGSEGV SIG_DFL code=SEGV_ACCERR
 32625 qemu-x86_64 RET   nanosleep -1 errno 4 Interrupted system call

Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/elfload.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 295dad4643..eaa8676f5a 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -561,12 +561,14 @@ load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
             elf_prot |= PROT_EXEC;
         }
 
+        int flags = MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
+        if (rbase == 0) {
+            flags |= MAP_EXCL;
+        }
         error = target_mmap(TARGET_ELF_PAGESTART(rbase + elf_ppnt->p_vaddr),
                             (elf_ppnt->p_filesz +
                              TARGET_ELF_PAGEOFFSET(elf_ppnt->p_vaddr)),
-                            elf_prot,
-                            (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
-                            fd,
+                            elf_prot, flags, fd,
                             (elf_ppnt->p_offset -
                              TARGET_ELF_PAGEOFFSET(elf_ppnt->p_vaddr)));
         if (error == -1) {

-- 
2.55.0



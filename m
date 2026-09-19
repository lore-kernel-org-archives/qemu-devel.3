Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3D0C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yF8-0002pk-73; Sat, 19 Sep 2026 12:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF5-0002pA-80
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:47 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF2-0008D4-Cm
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:46 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae6b2010so1006267eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836523; x=1790441323;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nK+zq+ryjrcPOcXasHwk3XYykW78/KjaOh+VoOvp9B8=;
 b=ShH4gMqt54s7tNX4kFFABoW36eOBmFclGAWgBz2JqRCW/sj56KYT5n0f/NByM+eF/D
 eFURWvvCXzQJ7nooAQ6RTCxR75q0mhOzcWm3DFzaLqdltx47L1jM+5BdrJiD8uFFd8Ze
 8Hyj31chFRgziMxm1bepJbt5JpRU/Y3nDyF3SynuwoP0vKWpgnir5S2VciDyZa9JQ98s
 hZDaio0+Ze5RkJg/gZwTY3f+pXbOb/s3lMfKApoFisvAOJiky7zyTIrhxpvwWgv+t78X
 ejRlveHcq/t416S11rDJJ+KiANhSF3T+K5+/n2XxzRaV27toRE20eqohKX9I8ySZ6TM+
 Vj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836523; x=1790441323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nK+zq+ryjrcPOcXasHwk3XYykW78/KjaOh+VoOvp9B8=;
 b=Jp5vPq9fEXcSXIC2gGMJ043hbdj3LbFxt1Qff7fe+Won6Kya2y5SGFNB51r4oJc4S0
 OcmSb9xXo8a0NfJmujRBrmpSsQrZyd/vem2ZnvgYWQaOXXbaSU4tuAhOCMStpnAyunxl
 JCK9AMb7skh+klcJxRFCTBQlcdKDLm7Uy9wChFjqI/jc6PZG8AkAfXqM57c/kydcZvHA
 gijIvZi3TMPkxGkFVQ+XFeWUY77LWk5S6xunW8HMRA6KobwqaM2CeliHYJo0LOAC5p6L
 Y1DspmYPHndmx5S7HcPzAU+cizwawiR87rl8TTx/dKL8nMFRjYhF386uY+VEc1WCj/77
 8/LQ==
X-Gm-Message-State: AFuF++nXNEtR94hs94Iki+6YRRKgiFyDmMrYTrSNSXMCfJBV460EhDKK
 ieHME511C/mwoLbu2RaO7DNFSSHBctW83902474jw9i5UVOBYjdSLz9YHCqAnNcSCVqP3R01m8P
 B0FkNDZo=
X-Gm-Gg: AYBFou2v8d4qaTZbZsGhRGERR+oBHtDA2aVQi11DPiCjGUKmgeRtvoAXNH56CACi2Vb
 KMrBNii0avtKQfJlmyUYb4XPQaKiijpENR3seUw70mLV1aESqqLqoh4OKDlqpxsLHYpN9VAoA8W
 ocJhDoV5dau1ZRf3WdKbeq6XsNpQvaCXfgAWYnghsZzg+DutusgeAv34rFdfpqm02NQEMUAyNgH
 4cmqH/qvCh/MQ1SxiovCoKc9Zkh0n2cSM5GF2ceeDLnQ//ptiPFIZWnOJ7CKy/YqCLAoWmUp4/3
 cOn9PLx7e31nfx1wCdpYfcrUoJX33z5xFE+GGYZYuHlqP5aPBmLS1T5maOUujXsYJl6weygJl0U
 0Wi7fLdcmePY5jmeMjeqGMn44hCe78Mg63sCTGxakSf8y/gzFxEesfG0jSeDVRg1RHSYlE7Ykuz
 X+Ma2AhLQ1CMZ8EB33z4ShQGwl1XCCJvpfU239PTWzUk4Lh9kFpgRk7Ni9r2w=
X-Received: by 2002:a05:6820:2915:b0:6b7:46fa:16af with SMTP id
 006d021491bc7-6ca9d14e709mr4835276eaf.68.1789836522937; 
 Sat, 19 Sep 2026 09:48:42 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/41] bsd-user: Remove mmap defines
Date: Sat, 19 Sep 2026 10:47:36 -0600
Message-ID: <20260919164810.70151-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::c; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

These defines are not used, remove them. They aren't in blitz anymore.
A future commit will cleanup several mmap issues, not least the obvious
mismatch in the flags here.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 7e70d6ad57..7646a52744 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,20 +121,6 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_MADV_DONTNEED            4       /* dont need these pages */
-
-#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
-                                                /* MAP_INHERIT */
-#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
-                                                /* MAP_NOEXTEND */
-#define TARGET_FREEBSD_MAP_STACK        0x0400  /* region grows down, like a */
-                                                /* stack */
-#define TARGET_FREEBSD_MAP_NOSYNC       0x0800  /* page to but do not sync */
-                                                /* underlying file */
-
-#define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
-
-/* XXX */
 #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
 
 /*
-- 
2.55.0



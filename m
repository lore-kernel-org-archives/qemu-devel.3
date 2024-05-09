Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE76C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55je-0002ih-Si; Thu, 09 May 2024 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55jR-0002hC-Ix
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55jH-0007sa-ER
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715268634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q7HFYbK/sg4zW5sOnGvTduVZOWAmSnH/uZzaSod9kEU=;
 b=LP3UIOlEqYT8cmcz4bqBNepfNb6DoePZz/Mo3e+V0bWwjdxzBzqrwLSbs4MeCmRKp17b/E
 Y6PCmS3mIY6TmOJC8JeFeZ6BF/BezWjK0lgqBQFdZuqsBG3KcmVx9tP4rvd6OthcoX77NP
 5cz4LiGNREl0pf/Wlilee0HHs4kgEG8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-2dCkahqFOx6VTwWKNZG98g-1; Thu, 09 May 2024 11:25:31 -0400
X-MC-Unique: 2dCkahqFOx6VTwWKNZG98g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso53776666b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268330; x=1715873130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q7HFYbK/sg4zW5sOnGvTduVZOWAmSnH/uZzaSod9kEU=;
 b=OrnmhSHBqLcwQdr1DNRVcTQkND4qwysXglEm72H5w1tDiAeebl31rpLr3FdS0mbSNg
 fWKKA/pZXoD/794Jl70xOB0olZd2/Z7tiidlIkzGemQ7jsziaDBGAw0M4gtd34ffeaf2
 YFQsXpTV1Q9iBksTnfkgMxyFy7OxjDicBUBg6QLrJEEAPqdqGDWapbc3kxJ3JqT03OLC
 BNpk/uO5xk+x9nL1+JMi1XJlkFVsK5d2YFLjLxQ8czjGs+T5sUFq/XXOvlv4Quj06dTy
 s8J2liVNkQt49IzeiEuOrWD65dPo0HDOHE9ebvwp/P+7hZaKSRXl9FhiUGfqp8aR9pTd
 2jIg==
X-Gm-Message-State: AOJu0YyFUDjOb4dlKgdYMuLzVBtYo+bFwxA3ARvKHFl3+ImVI+FQJQuI
 B7/2wX8Rjzqzb7yyqojHAUZOCIy5NBQiAYCfkGOK7jL+biZwYCHA0PjMlyV4jxdMdNo5AH85UFH
 CZFg2SeaVL7hYmjk4xH2Z6YC2F2lpKvyngF4Pp9e5i9ossUmpx9Tyg4mdk6a74qlEAd6S5Z6jpZ
 eNOIpFaZBFStoVue9duj0v+IzARru2ZaF61Cuh
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id
 a640c23a62f3a-a59fb94b8f0mr438799466b.23.1715268329816; 
 Thu, 09 May 2024 08:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi9HutHb9eeIkKh7F0R/L6Tx98PjJAOBvz6kRDVOFjfHik+mDCPHyJoA6qKVJ/T78eXP7qZg==
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id
 a640c23a62f3a-a59fb94b8f0mr438797466b.23.1715268329238; 
 Thu, 09 May 2024 08:25:29 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b177fcsm83427766b.202.2024.05.09.08.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:25:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: fix operand size for DATA16 REX.W POPCNT
Date: Thu,  9 May 2024 17:25:26 +0200
Message-ID: <20240509152526.141855-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the manual, 32-bit vs 64-bit is governed by REX.W
and REX ignores the 0x66 prefix.  This can be confirmed with this
program:

    #include <stdio.h>
    int main()
    {
       int x = 0x12340000;
       int y;
       asm("popcntl %1, %0" : "=r" (y) : "r" (x)); printf("%x\n", y);
       asm("mov $-1, %0; .byte 0x66; popcntl %1, %0" : "+r" (y) : "r" (x)); printf("%x\n", y);
       asm("mov $-1, %0; .byte 0x66; popcntq %q1, %q0" : "+r" (y) : "r" (x)); printf("%x\n", y);
    }

which prints 5/ffff0000/5 on real hardware and 5/ffff0000/ffff0000
on QEMU.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7d9f6b5c55b..5366dc32dd3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -411,16 +411,6 @@ static inline MemOp mo_stacksize(DisasContext *s)
     return CODE64(s) ? MO_64 : SS32(s) ? MO_32 : MO_16;
 }
 
-/* Select only size 64 else 32.  Used for SSE operand sizes.  */
-static inline MemOp mo_64_32(MemOp ot)
-{
-#ifdef TARGET_X86_64
-    return ot == MO_64 ? MO_64 : MO_32;
-#else
-    return MO_32;
-#endif
-}
-
 /* Select size 8 if lsb of B is clear, else OT.  Used for decoding
    byte vs word opcodes.  */
 static inline MemOp mo_b_d(int b, MemOp ot)
@@ -4545,12 +4535,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
-        if (s->prefix & PREFIX_DATA) {
-            ot = MO_16;
-        } else {
-            ot = mo_64_32(dflag);
-        }
-
+        ot = dflag;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
-- 
2.45.0



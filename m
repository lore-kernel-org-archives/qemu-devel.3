Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B129C25B74
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mM-00039Y-3K; Sun, 12 May 2024 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mK-00037p-Fx
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mI-0005iu-UI
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4SP0e59ZeDX5lkN+/W5vKvtoIw2mXuzTdWnwNY+pAw=;
 b=LYy0UQffsRJneHfjiyzARjMqK2FKM6SHEx9LMtCg11px+T98sCTWqdvIv4dBWzs1LmeDRa
 J++eCH8ZMr67AfSzMsFz4g4y9zS8yJCOYMvukksJjoM69oMpLJI8c8r+BgIfXnF0S7TI1P
 TytN9QpR3ybUKp5t7pUDLhHs0vkToxw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-smMwzhx7PnqaBouQ-KdQHQ-1; Sun, 12 May 2024 06:49:55 -0400
X-MC-Unique: smMwzhx7PnqaBouQ-KdQHQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51f98fc5a80so3031426e87.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715510993; x=1716115793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4SP0e59ZeDX5lkN+/W5vKvtoIw2mXuzTdWnwNY+pAw=;
 b=OmjNdiGPm9aRr5ju+I7VlWtk12bioUhsuG/GJ7zwlLz62TadtbAQzzuDRKPLuFSHFu
 BUmdEkSZpNLq2xy8wUTf+XDzSqz/XmHCWypttAmj69I6rgqhhvUfPxQhJNoxu2st4wdQ
 p5A8cRjlZgArC2DrNEKXjPP2w6nwLvla9VkTakj9ydrxCYrn2AAc4TM4ZutFiWK2RXUX
 IE1i1stI7a4wihWs5xDk5s5FiPSc6H19HMFcRTJJ1cJ04kldNrB6yzKyrxqUQTImc/Hk
 R+hQyszt0unWdT9QxZhGq0fWRGECt0zUK34vwl5h74SGo21UgS4PtJ2Dd0Ve4uU1KEv4
 lfCw==
X-Gm-Message-State: AOJu0YwQkxt6g/jZsk3e9ukFtmXj7Vy45MdHwxTaSHnJe+dDt0bmDM2V
 cp767jbxW+Mx3ubXlqQ14pIJwAjB8SXDHp5KIGnNG9ppX2CP1zehbiCn+dceyIsRrDsGKGQgz+h
 5TpjZgvAScsjjMhHtnyAJcjTWhG+yzWjshoTBkxTfSuSx+UY84HqXOt7mCxfuGkndzaWcVt2FA+
 PTULf3fYaWrH4eC0+fQVV33s+XEDXhCAgapsJJ
X-Received: by 2002:a05:6512:2386:b0:51b:bb0f:b43f with SMTP id
 2adb3069b0e04-5221057b55dmr6309704e87.43.1715510993014; 
 Sun, 12 May 2024 03:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo2iCmaI5g55zTfvBegiMZRV4L9hqyc4C1m5ZrO2BJsxuCZ7j+bY7Q7tJtp3w7adS8SVQgMg==
X-Received: by 2002:a05:6512:2386:b0:51b:bb0f:b43f with SMTP id
 2adb3069b0e04-5221057b55dmr6309688e87.43.1715510992387; 
 Sun, 12 May 2024 03:49:52 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574c122827bsm764151a12.78.2024.05.12.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:49:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/27] target/i386: fix operand size for DATA16 REX.W POPCNT
Date: Sun, 12 May 2024 12:49:20 +0200
Message-ID: <20240512104945.130198-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



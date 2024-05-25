Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AA6C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfM-0002TP-3Q; Sat, 25 May 2024 07:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfK-0002SL-S7
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfJ-00046n-3t
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgBhn5gAD6U95AlcziLtUsku3a2fWbySPlP3IcoaJdU=;
 b=MZ73ox0ZrE8KpJbHt3Xjuz7ZMGyAfzF2wIhogshVHB3uS14YB8Fzsx0dgww2U0ds+Loqo6
 uB3XPCMOao9j66iweGx8d6JWMH9e2Ec11gcJDyAyxt9Lksz1ijDOvEboRJpJ7hyYNgJ6LY
 eYV6E+nrt3uhnDylJ1sNuJu6mOJmN/c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-1CxE1bgjOr6FyyaYw38aSQ-1; Sat, 25 May 2024 07:34:09 -0400
X-MC-Unique: 1CxE1bgjOr6FyyaYw38aSQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-523b4b04fa2so2677157e87.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636847; x=1717241647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgBhn5gAD6U95AlcziLtUsku3a2fWbySPlP3IcoaJdU=;
 b=tjMmAHUA1ivyp0Vwr6DMS59oCcHvVkfqmEWaYC8mDqOXqEh4om2UNPYr8fwK90iIQw
 V87cxWwWQd/RGh1tRguG+4Pb4NpJpVYLl10sXfXbQx1yGbfa+8rJbfQ5o673AlE0CY8p
 CCjBQvAYnNHVzLIe+3jl8+go6B0QrlUrmxM5ubfer8h+QAdvRlIH54wlW4ltwELoXE+0
 BSXVh7G83xBs9b0tZmoMjjsTira6nAyuZysgks9VvR9T+MWqz59a0K3Wi1u6w24h0ZnU
 5J9mF2/a/WNpPlSbnRzc5m5HAk6w9raAzjIDCS1dxtzJeWlGv3wibD5cq231UvGCKTbS
 6j6w==
X-Gm-Message-State: AOJu0YwgdRZoycM1f6IvFn+qiAuzBti8S/ykk4e1SOi8UpTDBDrv/Qw8
 l/C+EJHuBGhHw+dpZ/iTJcWX4S2WVRU4lTY1vL8HXJGnZvuH265mMIcEJajrnSzWiQoUPRzUolS
 vzOBJraMR+/PbcAMGvCTEUkpAxyOrQBuFXg/9LE5ynECaNL1nLx9VT9bfiA89CLaP3IM+QhYFUP
 OBEJgXqdQRpyMAP1E/stQf5UaBEAVIprwtWv5t
X-Received: by 2002:a19:910a:0:b0:51f:2a80:a982 with SMTP id
 2adb3069b0e04-5296736bb70mr3180456e87.47.1716636847533; 
 Sat, 25 May 2024 04:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA4mFjkAsp2vwMuegTAgIsvQRL5K3wzViAmW8Bj69YjvrRFZ2Jem/bnNRlEO5a0rsTMfkIyw==
X-Received: by 2002:a19:910a:0:b0:51f:2a80:a982 with SMTP id
 2adb3069b0e04-5296736bb70mr3180447e87.47.1716636847066; 
 Sat, 25 May 2024 04:34:07 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda843fsm243874866b.220.2024.05.25.04.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/24] target/i386: avoid calling gen_eob_inhibit_irq before
 tb_stop
Date: Sat, 25 May 2024 13:33:18 +0200
Message-ID: <20240525113332.1404158-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

sti only has one exit, so it does not need to generate the
end-of-translation code inline.  It can be deferred to tb_stop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 -------------
 target/i386/tcg/emit.c.inc  |  4 +---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 06aaaa00b43..a7493b5ccfd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -564,19 +564,6 @@ static void gen_update_eip_cur(DisasContext *s)
     s->pc_save = s->base.pc_next;
 }
 
-static void gen_update_eip_next(DisasContext *s)
-{
-    assert(s->pc_save != -1);
-    if (tb_cflags(s->base.tb) & CF_PCREL) {
-        tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
-    } else if (CODE64(s)) {
-        tcg_gen_movi_tl(cpu_eip, s->pc);
-    } else {
-        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
-    }
-    s->pc_save = s->pc;
-}
-
 static int cur_insn_len(DisasContext *s)
 {
     return s->pc - s->base.pc_next;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e0ac21abe28..88bcb9699c3 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3475,9 +3475,7 @@ static void gen_STD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 static void gen_STI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_set_eflags(s, IF_MASK);
-    /* interruptions are enabled only the first insn after sti */
-    gen_update_eip_next(s);
-    gen_eob_inhibit_irq(s);
+    s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
 }
 
 static void gen_VAESKEYGEN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-- 
2.45.1



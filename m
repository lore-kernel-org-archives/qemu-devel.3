Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5586C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0f-00055f-D3; Fri, 24 May 2024 04:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0c-00054g-JZ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0b-0000PX-4c
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Br6UNVLB3xRS4K0FimCnEwOTUqULB678+ykTuEHd9fM=;
 b=FZU/bS68pIfS/BbL59QY3bRRtEOHWL7j73Qy7TM5HC5QQKQWj64NFYK65MzAGXhUCqCAS0
 7hR5zRcAZ0D6lyY8pYBPgS5oZzSRaxxRttdGzgvs3Ape3ktoPzt6qKR7A8vTFvDsjE9OE9
 M1sq2E0nT/uUlFy37AR398SAf27oM2Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-YHkBLedSOImK0rJhMm3S9A-1; Fri, 24 May 2024 04:10:34 -0400
X-MC-Unique: YHkBLedSOImK0rJhMm3S9A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6269ad800aso27581866b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538232; x=1717143032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br6UNVLB3xRS4K0FimCnEwOTUqULB678+ykTuEHd9fM=;
 b=l6exJlvDj8C7IhpOuMcWLXafAR6kcnTAZUfka4COsklAotom0h42uWQTxYyjsJ+8vs
 ZiMyBirdiBearmm8zo3NKE12/IbO5LX5ohvNu08lUNKoWGhYNksDXJiyHAQ69KOIgTYK
 FBvrPA9/xyfEwB1BkTeyWtg40BbHjd7RkyYabKoK6XLICfXe112c67TkfxYy5JlmQapZ
 DXLlP8kzZGFg+pdoksGDUXu7RRcC/POHrkr1AglEjQ6eGxbPcq0TNqjqGgdHvIb4PRyQ
 RorcqnxHTJfiXwcEHWsWfC/MiWZ6hY+3LKbHIST939eelndmY0N4P5rGNSPeRaZ2brz3
 cL3w==
X-Gm-Message-State: AOJu0YwkVLGbb3lp9ZY5SthSSaMDxXpdqSNRfaqh8NcQnjhP+7bNEfvr
 vyjPo8IC8wJK45je+GslQel343z3UUJ0Si++s+DFwrTZFQa93AJz70EfMc3ya2HE7TozGymACHD
 Xr0e62hhaL9bGqqLMZUsRcGYk20IMF1OBveQMz5nQC06TkeCEMLVWd0N851iz/LDO67qfM5dkPE
 3OY4mGQipYxPeLkTdgwZVOnw/kMkNYiPGlXGgT
X-Received: by 2002:a17:906:478c:b0:a59:d0be:dba4 with SMTP id
 a640c23a62f3a-a62641c2e07mr180444066b.13.1716538232356; 
 Fri, 24 May 2024 01:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ+Rd2AlsD38sd8fJKKklm8D1CVNI39r41Mz4JRJFcz9gdHbvuLGnCfjFGcvCihT23KqamUQ==
X-Received: by 2002:a17:906:478c:b0:a59:d0be:dba4 with SMTP id
 a640c23a62f3a-a62641c2e07mr180441766b.13.1716538231974; 
 Fri, 24 May 2024 01:10:31 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cd9fed2sm90000466b.187.2024.05.24.01.10.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] target/i386: avoid calling gen_eob_inhibit_irq before
 tb_stop
Date: Fri, 24 May 2024 10:10:08 +0200
Message-ID: <20240524081019.1141359-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 -------------
 target/i386/tcg/emit.c.inc  |  4 +---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 24e83c1af84..5dae890d2b6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -557,19 +557,6 @@ static void gen_update_eip_cur(DisasContext *s)
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
index c78e35b1e28..8e311b6d213 100644
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



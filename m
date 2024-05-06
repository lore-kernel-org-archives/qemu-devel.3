Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84031C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQf-0003Id-V8; Mon, 06 May 2024 04:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQW-00036N-3Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQU-0002Is-FK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmPwhJZl6YVmyUgCUNLukr2/mGeBC/IKP2/Al+DzqQs=;
 b=PxIv08oPLeaxgqobDRi9UHH9zECI56/kYQ51w16pX5tkK3kOQO9nGFY4lAhYLswxAr7xkL
 t2vBTC5RPuCgLX9QmSkuR/JmB8d5F5qewfItZ6Itj0yhhUmshZ81K1shPcOyItQAytk469
 RhOOorloezZWEjj9WsBQUqu4nfDhotE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-GgTnxCLSMAmxJZrqxIhTpA-1; Mon, 06 May 2024 04:10:20 -0400
X-MC-Unique: GgTnxCLSMAmxJZrqxIhTpA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dffe736so243633566b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983018; x=1715587818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JmPwhJZl6YVmyUgCUNLukr2/mGeBC/IKP2/Al+DzqQs=;
 b=drnxWrxQhfMeojaWKxB34GJ2R1ofvfIsoJ/SNf8lS8UcOSP1qD79hHnUtf1XFBdVAa
 nMAPp/8a4QUFYW5PCi0gRTD51sn5J6rpeYuHF0sKQbGPMKvSp3ReDLlcdjpV3DZ6pGme
 ksFkpVytZotqUxscWUxmX1JVmG06Qr5rc89bQFK/6lOgb45o44j7wcW9Z9KuBMzl9GmW
 zZkCZ0ayIgdHua+4V3juPVw8nPbzGZ4WxxMjFRwBEwo1AM4zzhLkL0LVH+hLEcspTq/t
 DLblJ2kL25qvaJp6RLchmIc6o6PnSLDolfNFBfsm58pqm5WsS1m2asZBRrqqdXpFoABy
 /Nlw==
X-Gm-Message-State: AOJu0YxHccs7C47uQGoguJ8O1lYMW41gODNI3PxuxOYyOVTubhPp3B72
 HlQJQ2iHLq4q7AUxK3hoyBi3NyLHTswZb7CmvsdNAyJF3gYB3replZqsGenesgnRR1X3BkDroWz
 pGslKFCqtNL8taZlMWgfH5dmA0XdomojKUw/q4JStVs6vUlPsMgodglFufuOoMzE6mOir1RnLkB
 yVOQqStkt3NvHzOZkOHRvdq0yfYlEF0aZveoo6
X-Received: by 2002:a17:907:728a:b0:a59:b17c:c9d2 with SMTP id
 dt10-20020a170907728a00b00a59b17cc9d2mr4369669ejc.12.1714983017844; 
 Mon, 06 May 2024 01:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpbxjPHEq7Q45qExuVM63j45ASuzO9nj5f6dRct9GLPsiRLOXbEZvbY+gGYosf5volDDVgOw==
X-Received: by 2002:a17:907:728a:b0:a59:b17c:c9d2 with SMTP id
 dt10-20020a170907728a00b00a59b17cc9d2mr4369660ejc.12.1714983017565; 
 Mon, 06 May 2024 01:10:17 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 gx10-20020a1709068a4a00b00a59ab31efbcsm2578698ejc.223.2024.05.06.01.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 06/25] target/i386: pull cc_op update to callers of
 gen_jmp_rel{, _csize}
Date: Mon,  6 May 2024 10:09:38 +0200
Message-ID: <20240506080957.10005-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

gen_update_cc_op must be called before control flow splits.  Doing it
in gen_jmp_rel{,_csize} may hide bugs, instead assert that cc_op is
clean---even if that means a few more calls to gen_update_cc_op().

With this new invariant, setting cc_op to CC_OP_DYNAMIC is unnecessary
since the caller should have done it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6b766f5dd3f..17bf85da0ce 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2852,6 +2852,8 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     target_ulong new_pc = s->pc + diff;
     target_ulong new_eip = new_pc - s->cs_base;
 
+    assert(!s->cc_op_dirty);
+
     /* In 64-bit mode, operand size is fixed at 64 bits. */
     if (!CODE64(s)) {
         if (ot == MO_16) {
@@ -2865,9 +2867,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     }
     new_eip &= mask;
 
-    gen_update_cc_op(s);
-    set_cc_op(s, CC_OP_DYNAMIC);
-
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
         /*
@@ -5145,6 +5144,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_push_v(s, eip_next_tl(s));
             gen_bnd_jmp(s);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
@@ -5168,6 +5168,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                         ? (int32_t)insn_get(env, s, MO_32)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_bnd_jmp(s);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
@@ -5188,6 +5189,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xeb: /* jmp Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
-- 
2.45.0



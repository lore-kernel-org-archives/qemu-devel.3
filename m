Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338CEC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfS-0002gO-Jw; Sat, 25 May 2024 07:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfR-0002c7-4u
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfO-000486-CH
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmao0q6LQviEK0BFtAjWWlLJmjAOM3Vqxn/I8hAl6HE=;
 b=PTJkCo3skG78V3xnGkbyVaLaAaN3edGCYuqqr83obzXQiwQdi6qf5Nn4cBHCeY6F9wBo4C
 70zCwolH/J49cWo+uTvP7q9OXu8BIgVIQRMZsPRbm+utAtkbyR7fSDpP0xFwj3OFU6IhfC
 4t6GdUm1P5yegXd8I1pN1aD4QPcXpSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-SwVb5jBHNvS4qNFXS2m_UA-1; Sat, 25 May 2024 07:34:23 -0400
X-MC-Unique: SwVb5jBHNvS4qNFXS2m_UA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a62684ef298so84186866b.3
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636861; x=1717241661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmao0q6LQviEK0BFtAjWWlLJmjAOM3Vqxn/I8hAl6HE=;
 b=IA8fxghFs5qvKR2+yTpabT98UrXWBAge3JSa/nUeX7DI/A2JwjOedKyh2t7rkViMco
 1B3iyVFHLfSYatpMifV9bs86PdGveGxsvhLnWtHLlFWSSocCk8e27VTuc3yp6slAerED
 7xhIGEsSiJ+kyLqccIP13Yn+/FJYmOVoYj3mbGG0/Y8WGKI7dsNQOuzYN9EjgiD+SkZd
 EHHAxF0YcjWJurB2a4QkX7i17SwM9p8q1YT6/JlB1xhbLqeXcTTDHBgE4lxJv4HZBxEH
 +4QzfqN+4Vg8avFq3jZnoqL3dQb89cwInqY2QRoC3um+S1/MFRfw4Q4aLlcbnaohjHGA
 vAig==
X-Gm-Message-State: AOJu0YygAiCs1I+tqfRVouECDZhxl3ZsIgSHZcUKcDXURUChJJy1QgAJ
 3LeI7r8x13cgfqMztgnRMxRak9bsw9RYMuj4cGpuoynV2lUqz5LrhXs3mZ4bckGRW9L8DURWH2f
 LcUferQN2YaieL39wpTDeJJXiBIbQ+OE2vF4zoD5GSJvHQjBJG4cjeMouxYMnqsozsMfrP8HvRM
 SeV1zjECaUd0uUDNBO+qfXDVkRczxYu09DwyI1
X-Received: by 2002:a17:906:e0d3:b0:a59:c3d0:5507 with SMTP id
 a640c23a62f3a-a62641e0007mr342267966b.26.1716636861009; 
 Sat, 25 May 2024 04:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDufGisi6e11h2/mVdeifjaAz7COTCLaWAes9rQzy3DGqdlV+GARCgW3ABBPAlFMkiMw8DyA==
X-Received: by 2002:a17:906:e0d3:b0:a59:c3d0:5507 with SMTP id
 a640c23a62f3a-a62641e0007mr342266766b.26.1716636860532; 
 Sat, 25 May 2024 04:34:20 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8e2b2sm245545666b.171.2024.05.25.04.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/24] target/i386: inline gen_add_A0_ds_seg
Date: Sat, 25 May 2024 13:33:23 +0200
Message-ID: <20240525113332.1404158-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

It is only used in MONITOR, where a direct call of gen_lea_v_seg
is simpler, and in XLAT.  Inline it in the latter.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 +--------
 target/i386/tcg/emit.c.inc  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index afbed87056a..2039ccf283a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1822,12 +1822,6 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
     gen_helper_bndck(tcg_env, s->tmp2_i32);
 }
 
-/* used for LEA and MOV AX, mem */
-static void gen_add_A0_ds_seg(DisasContext *s)
-{
-    gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
-}
-
 /* generate modrm load of memory or register. */
 static void gen_ld_modrm(CPUX86State *env, DisasContext *s, int modrm, MemOp ot)
 {
@@ -3674,8 +3668,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
-            tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
-            gen_add_A0_ds_seg(s);
+            gen_lea_v_seg(s, s->aflag, cpu_regs[R_EAX], R_DS, s->override);
             gen_helper_monitor(tcg_env, s->A0);
             break;
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 88bcb9699c3..01ad57629e4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4043,7 +4043,7 @@ static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* AL is already zero-extended into s->T0.  */
     tcg_gen_add_tl(s->A0, cpu_regs[R_EBX], s->T0);
-    gen_add_A0_ds_seg(s);
+    gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
     gen_op_ld_v(s, MO_8, s->T0, s->A0);
 }
 
-- 
2.45.1



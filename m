Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F47C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0q-0005QO-Nl; Fri, 24 May 2024 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0p-0005NE-Bd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0n-0000bY-Nv
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQcrqiJjxHNOISOcZ6yKLEOGsror00Tl7WLp+qhe8Mc=;
 b=SxFCfQJdBmBG9i44Mx8uieKPIwxpCckPHRFJmeMCWiQ2GkLIouxinxP+GVa8BXMYHNKAFJ
 va4s4JCyEzSUKo8jSno3Nkwp9VfbeltL+E/mVyz/jDgz2LtB3yiD0sXhgy4tDaiO0NLmTs
 /x4Hd7rHCKy6s0Hx7Of7K2IEu3t03wA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-wz-SpQ4gMnStJjE5PQZI8w-1; Fri, 24 May 2024 04:10:47 -0400
X-MC-Unique: wz-SpQ4gMnStJjE5PQZI8w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a626603837cso21205566b.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538245; x=1717143045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQcrqiJjxHNOISOcZ6yKLEOGsror00Tl7WLp+qhe8Mc=;
 b=FjeecHgubwciQQiYxJErIpcu07/4DkaWkuaC3qujI+NFU6IUXbFFVk09QUvFLmIAql
 KqDv9ieQdFPAaNXiI2X40Y3UNXWQfY14lVJutIclsmK7cyldA5QIPVSr6JsKYuXcM8t+
 jP2p0p+cf+IzjdUHsevt/nYxlQ5Od12xTPWUHBST4KARLuxAPDEPfy9LepUd5ZiVP61j
 W0FixfHYKyCXE406FbwGvoOxv5CTviT/Di1SHV1kRWEgMdc0BmePzfv/2jVmzY3QfpCa
 y87fvGOJv8ojSkCz8puR3j5pnyeLFbXxUPgn/EOcvmpFJWyi1qPG1n6N64KkIl09rNqU
 J+mg==
X-Gm-Message-State: AOJu0Yz+vmpPZj2V/WDMGExIC3cm0zcvNfdYF+KrVR/AVN8aQ+SshWK5
 h6SM5mMS6n592qTz/cK/vrVLzw57JSAO/R8k6xHKxQpqJyFB9VUcHDsecjnmiLZfRGZe69cHCxf
 Aq5oI7Z/xk/973Hd9do7KmlRxULK0pgTyn+zFipAlaauTSwsT9VRFHuR4MXP6SiFsH/x4YpnLJn
 oAVu/R4+E9tat4cAab3Xo3olaVmZUrbP5nvt2r
X-Received: by 2002:a17:906:3f87:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a626308f264mr105707966b.0.1716538245099; 
 Fri, 24 May 2024 01:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl6Mo9kEoWFJYUNEFWNkmK7Cxir1kVqoJzTXdZANBpcL4klgNht6BkzgNEzO5qaWoCZWansQ==
X-Received: by 2002:a17:906:3f87:b0:a59:b590:5d71 with SMTP id
 a640c23a62f3a-a626308f264mr105706466b.0.1716538244724; 
 Fri, 24 May 2024 01:10:44 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc4f465sm89556166b.120.2024.05.24.01.10.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] target/i386: inline gen_add_A0_ds_seg
Date: Fri, 24 May 2024 10:10:13 +0200
Message-ID: <20240524081019.1141359-11-pbonzini@redhat.com>
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

It is only used in MONITOR, where a direct call of gen_lea_v_seg
is simpler, and in XLAT.  Inline it in the latter.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 +--------
 target/i386/tcg/emit.c.inc  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d32b5b63f5c..8138da23b3d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1815,12 +1815,6 @@ static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
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
@@ -3663,8 +3657,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
-            tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
-            gen_add_A0_ds_seg(s);
+            gen_lea_v_seg(s, s->aflag, cpu_regs[R_EAX], R_DS, s->override);
             gen_helper_monitor(tcg_env, s->A0);
             break;
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 8e311b6d213..f293db01b5c 100644
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



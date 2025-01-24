Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFDCC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFT-0006cR-3R; Fri, 24 Jan 2025 04:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFR-0006aJ-Pt
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFQ-0003rL-4H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2/THGezMiwi4jd00Cw/rtHI0MwkPkicDfVIV0NnRNVM=;
 b=cKrHQxTjOxS7l5IMq43RpzyXixoXbgOyarYyjQM4L/KMkJOpi7kmun/YFWo3E2hb9J0DdW
 S0QYed/N7d+iRFgc6CwMHSoU8/k3zFq3e87fjkLjwj+cyxYhIUzS3BpaovfK5aUVgmGB+2
 LADI+Rw5ncZ5vGS7sUvtCT8RzdQlUOQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-0bgactGPOPG3-1s6oVbPTA-1; Fri, 24 Jan 2025 04:45:05 -0500
X-MC-Unique: 0bgactGPOPG3-1s6oVbPTA-1
X-Mimecast-MFC-AGG-ID: 0bgactGPOPG3-1s6oVbPTA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38639b4f19cso1281641f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711903; x=1738316703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/THGezMiwi4jd00Cw/rtHI0MwkPkicDfVIV0NnRNVM=;
 b=wBmc834/Y4GkNcIKgt+bct6a+BZXDf8bRn+RIRjwtHKQ0RThVbCrhOgowcK805EUbJ
 KaRU1l55fDi1/vT12O67xzr6LYVhs33wpgfiTRF9wYmGGswXwwJM5gDGCCGGz6tyDY0Z
 VWFr7IWWBTjbBfmhrujIjbsZD0iT7uxUZJaCsHj04e0/SF2GMJZcAu1WegTzNuCH5Zq+
 dCe4ay8zSxqsush055aTTbPK0B8qKUpUHeKvu2UqyT7hfG9IsDbVp8i+IdfuL9QHavSQ
 rKc/DT3ozUpdFMVZWzWKVaH47ALfnusL+kRkTc59+ey+9UNui52IdzmCx+SPsBtIDsK2
 j+iA==
X-Gm-Message-State: AOJu0YzjzMbcOkstouzE6vkQTRPizBMCc55Ld7ksuqsc22Pl2i2G4Y/J
 8zoICwTAamyyFrCmDlVWMdBfQ1yckYjPYQVAw7fvTl89QEYxVBrErn7W9i+KOMN0DA2tFwVcfzT
 20hZ840l5oM0QcC2NSmr3T/gnWUkSJ+TgIY3sJylZuyfAaiJxgIyozGTOGHuU0qr1ZHX/1EK+LI
 YAed08BAOuoAskyBgWeZ5Ryk7rqxaJ5v2itIZ4LVM=
X-Gm-Gg: ASbGncsCGC9ke7vZyyxT/4hn/QTafmI6S6fGVL2MZBSkuSfEV5BmlGHiCrwoyJK1SY0
 GMCukV5oj2nJgUKxL+DFyNDogrDxmEk+c8z6IwLd6Rm+9d/8wO97wOeMRUKd7hELQR3zlOpr62p
 4jGLTGR/I1SXvUbVrE4AhNJGgQ6IViou0lHdE9/qAs5LuNABxzRBHwQSHSlolnwtYylJetjgT5q
 gSeZNqJEVg4kIlyl2FnLsO2Y4T9/RwsT6izRbMMIzywr0SPS2gZ6r1eCGbf7yKqfn4jn6ytWg==
X-Received: by 2002:a05:6000:1786:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38bf57be11bmr30979858f8f.46.1737711903508; 
 Fri, 24 Jan 2025 01:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlSx1i36sHZuvyoOUw6cTHUCqalxbDDbcjrkFrQhixhiZ62bBgiLTe61yCM/3mfh/fzk0AbQ==
X-Received: by 2002:a05:6000:1786:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38bf57be11bmr30979819f8f.46.1737711903057; 
 Fri, 24 Jan 2025 01:45:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18867esm2130345f8f.43.2025.01.24.01.45.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/48] target/i386: make cc_op handling more explicit for
 repeated string instructions.
Date: Fri, 24 Jan 2025 10:44:03 +0100
Message-ID: <20250124094442.13207-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since the cost of gen_update_cc_op() must be paid anyway, it's easier
to place them manually and not rely on spilling that is buried under
multiple levels of function calls.  While at it, clarify the circumstances
in which the gen_update_cc_op() is needed, and why it is not for REPxx
SCAS and REPxx CMPS.

And since cc_op will have been spilled at the point of a fault, just
make the whole insn CC_OP_DYNAMIC.  Once repz_opt is reintroduced,
a fault could happen either before or after the first execution of
CMPS/SCAS, and CC_OP_DYNAMIC sidesteps the complicated matter of what
x86_restore_state_to_opc would do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241215090613.89588-9-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 141295742ae..8bc91c3de31 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1234,8 +1234,9 @@ static inline void gen_jcc(DisasContext *s, int b, TCGLabel *l1)
     CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     /*
-     * Note that this must be _after_ gen_prepare_cc, because it
-     * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
+     * Note that this must be _after_ gen_prepare_cc, because it can change
+     * the cc_op to CC_OP_EFLAGS (because it's CC_OP_DYNAMIC or because
+     * it's cheaper to just compute the flags)!
      */
     gen_update_cc_op(s);
     if (cc.use_reg2) {
@@ -1346,14 +1347,31 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
      */
     s->flags &= ~HF_RF_MASK;
 
+    /*
+     * For CMPS/SCAS, the CC_OP after a memory fault could come from either
+     * the previous instruction or the string instruction; but because we
+     * arrange to keep CC_OP up to date all the time, just mark the whole
+     * insn as CC_OP_DYNAMIC.
+     *
+     * It's not a problem to do this even for instructions that do not
+     * modify the flags, so do it unconditionally.
+     */
     gen_update_cc_op(s);
+    tcg_set_insn_start_param(s->base.insn_start, 1, CC_OP_DYNAMIC);
+
+    /* Any iteration at all?  */
     gen_op_jz_ecx(s, done);
 
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
+    gen_update_cc_op(s);
+
+    /* Leave if REP condition fails.  */
     if (is_repz_nz) {
         int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
-        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
+        gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
+        /* gen_prepare_eflags_z never changes cc_op.  */
+	assert(!s->cc_op_dirty);
     }
 
     /*
-- 
2.48.1



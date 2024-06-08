Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F0AC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXW-0000eX-Vf; Sat, 08 Jun 2024 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXV-0000dm-6W
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXS-0008Kx-Lg
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xY+RbuvzbbG2kS2m000BHs+SfoMj9YaEza3f/e/9iE=;
 b=HTAlS9L0u9omxBVCyXzO5fUBKN8zYel+hZkvmoKLhS9DgmYur0W4YC/yvUt0u0ixl5Nz8a
 SWVmA6lP0P/PeQ7/idqFpPBtdj7avPjok0TzExWv/N8AM5M9RvgyV8b5w1JWP7tYAe4LVy
 NLf9yzMAEVlT2t+ooCglK7St93msNQU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-F5f7PepIM-GJuntOG1vaEg-1; Sat, 08 Jun 2024 04:34:58 -0400
X-MC-Unique: F5f7PepIM-GJuntOG1vaEg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f0f7d6eaaso1507666b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835697; x=1718440497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xY+RbuvzbbG2kS2m000BHs+SfoMj9YaEza3f/e/9iE=;
 b=lKNDicPsjHIULCH0AQoUKrKVcQ6c8GFb9lARlWKPrDoqcsPFuteFxEEYARNe615VQM
 VSz1LKIaRi+900TC4UhJvuL8QWRA2fwf82uooDyF3kZPCSkDJA6MaRfsR6m08zbHdYWT
 Rnx0OLdG3eywrr2M6BQALuD/CrIAI4/Q+0aGWMmNYjXEOnjYqnZIJ7jUYkWqsGobG9dl
 sdmVMzBjhKdeSoEwiNSqHPZZhpnzS78k43nGC9HcPr/zoUJTRWjfZ39go6zfcCSjQr75
 UpGUwZmASI7TwBsR2xqNmCwgkdfOvjOFpUhvxy/jB+KXe1vBCmjx2v+oZZInL2hQjKpQ
 EwRg==
X-Gm-Message-State: AOJu0YwaXKqgMfPWXhsWhOBl6386lerCPu9U59Fi0xh2j60eS/JvRwiZ
 aDza+pXvJscgjoNIJqQ/scOjKvoNA7bcH+VtWLkZsE2PtRxwb4hpnqSgx85R57CLBwpvkSir7kw
 ZH9IGMu+NSDfZQNZ9T0RUvRQ2vi9kV7AAieDfQKj4xMUIaEFb9c/6bpFcxs5NjS5sE8yyKJd6Uk
 GQgCfW8LQ5wUz4lP1jnpNb6T+xEksXsSe1geke
X-Received: by 2002:a05:6402:4308:b0:57c:716b:a438 with SMTP id
 4fb4d7f45d1cf-57c716ba6c7mr342827a12.6.1717835696866; 
 Sat, 08 Jun 2024 01:34:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsYPk8sfF0GXUAL1DwL7Oh09wWrm6xsOFjwRnlGdiRJIw9sD1ew+2lsgYUvgc/q2TAkMiMIg==
X-Received: by 2002:a05:6402:4308:b0:57c:716b:a438 with SMTP id
 4fb4d7f45d1cf-57c716ba6c7mr342817a12.6.1717835696386; 
 Sat, 08 Jun 2024 01:34:56 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ca5e3sm3929749a12.25.2024.06.08.01.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 14/42] target/i386: fix SP when taking a memory fault during POP
Date: Sat,  8 Jun 2024 10:33:47 +0200
Message-ID: <20240608083415.2769160-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When OS/2 Warp configures its segment descriptors, many of them are configured with
the P flag clear to allow for a fault-on-demand implementation. In the case where
the stack value is POPped into the segment registers, the SP is incremented before
calling gen_helper_load_seg() to validate the segment descriptor:

IN:
0xffef2c0c:  66 07                    popl     %es

OP:
 ld_i32 loc9,env,$0xfffffffffffffff8
 sub_i32 loc9,loc9,$0x1
 brcond_i32 loc9,$0x0,lt,$L0
 st16_i32 loc9,env,$0xfffffffffffffff8
 st8_i32 $0x1,env,$0xfffffffffffffffc

 ---- 0000000000000c0c 0000000000000000
 ext16u_i64 loc0,rsp
 add_i64 loc0,loc0,ss_base
 ext32u_i64 loc0,loc0
 qemu_ld_a64_i64 loc0,loc0,noat+un+leul,5
 add_i64 loc3,rsp,$0x4
 deposit_i64 rsp,rsp,loc3,$0x0,$0x10
 extrl_i64_i32 loc5,loc0
 call load_seg,$0x0,$0,env,$0x0,loc5
 add_i64 rip,rip,$0x2
 ext16u_i64 rip,rip
 exit_tb $0x0
 set_label $L0
 exit_tb $0x7fff58000043

If helper_load_seg() generates a fault when validating the segment descriptor then as
the SP has already been incremented, the topmost word of the stack is overwritten by
the arguments pushed onto the stack by the CPU before taking the fault handler. As a
consequence things rapidly go wrong upon return from the fault handler due to the
corrupted stack.

Update the logic for the existing writeback condition so that a POP into the segment
registers also calls helper_load_seg() first before incrementing the SP, so that if a
fault occurs the SP remains unaltered.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
Message-ID: <20240606095319.229650-4-mark.cave-ayland@ilande.co.uk>
Fixes: cc1d28bdbe0 ("target/i386: move 00-5F opcodes to new decoder", 2024-05-07)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 6123235c000..4be3d9a6fba 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2578,7 +2578,7 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
 
-    if (op->has_ea) {
+    if (op->has_ea || op->unit == X86_OP_SEG) {
         /* NOTE: order is important for MMU exceptions */
         gen_writeback(s, decode, 0, s->T0);
     }
-- 
2.45.1



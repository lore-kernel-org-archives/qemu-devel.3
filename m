Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36849C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEVN-0002Ro-0B; Thu, 20 Jun 2024 05:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVI-0002Nr-Gi
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEVG-0005Uu-HH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vNRpvyeREGd2+Es2hiS7dffvsmxbIt4ClxNcgU2ADU=;
 b=NSaz37lXXS+qO+PROB4u7cxRBubrrjkF3HO1FLoTUrI9FOO8gZb9ze1EkiGxmb8ywOZpai
 bplooe14dt6L/NHX+Dhd2oCfgKGa6eKGZNt3GKdE/lCpceSHQ/uPD1t7YKVj4ZhynXDWBH
 FSErAKjrJc2wZTNxP+NdrL9OEnu+Trs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-fb6hg6TwOEa5LZJ0LCA5wQ-1; Thu, 20 Jun 2024 05:54:48 -0400
X-MC-Unique: fb6hg6TwOEa5LZJ0LCA5wQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so171271366b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877286; x=1719482086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vNRpvyeREGd2+Es2hiS7dffvsmxbIt4ClxNcgU2ADU=;
 b=jHosLTjZFNeqV3QtI78zKU2jL/nQE8sEDTYUHbv03wBv8zqtyE1r4H9Zz/5XsaWS/E
 19QJBEVE0TdOGUTPxsvfW1RNX/KaGPSZ3AHkth/qUHfPxqhJSKbEDWnBZBOMQ9XxMzFS
 ief/pjdQe+dDRHdBdDCq4sgYBEs/7/D8TpfBVUQCkSDeCkK022EUGolVPv9vWOOD10eF
 cbMM27LHm3/HrykhhZ3sHAsx2eRe3Yy+T8rshau9GoRzoAgYmVJAN5ejr4ndLEGLfFm2
 Vi1tmtzAhdFkVI51BGRFn4Npc2YNJRLK9TQ2AQllaIyD+9Wi3QNOilnZcb5M4GtZruox
 id9Q==
X-Gm-Message-State: AOJu0YzVDZCX/HeSDKw1SbChsYSsYU7SA6AcfMZOMIcPjktmUuWtUn9+
 l3Bpkrg3f6aqCN+LiqU0a3mUCLqb0VJpxYvzt5TzJqdY0GLY6sw12DqCx25Ib+hLhy0RsX5cCqv
 t9WPXYCqGBs36oTYLgmy2vHhNWrU2jFSTIVbVb8Gnfhb+GThFkYZX8Vd6mwv/j6XLH4VmIXFO91
 TBzwZ1dsGhyQUqgi2Hi9u8/9NjpGHHk15YfaFn
X-Received: by 2002:a17:906:ba84:b0:a6f:47c0:d8f2 with SMTP id
 a640c23a62f3a-a6fa430eeb9mr326710566b.17.1718877286567; 
 Thu, 20 Jun 2024 02:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENmVgcmb1wSDEp5PrylKItlNjOc8nB/OmezbgZ8+QbIRRfjYhWBBJwnhHa5lUI9FSCVapBew==
X-Received: by 2002:a17:906:ba84:b0:a6f:47c0:d8f2 with SMTP id
 a640c23a62f3a-a6fa430eeb9mr326709366b.17.1718877286158; 
 Thu, 20 Jun 2024 02:54:46 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed3690sm752612166b.128.2024.06.20.02.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 09/10] target/i386: assert that cc_op* and pc_save are
 preserved
Date: Thu, 20 Jun 2024 11:54:18 +0200
Message-ID: <20240620095419.386958-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620095419.386958-1-pbonzini@redhat.com>
References: <20240620095419.386958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Now all decoding has been done before any code generation.
There is no need anymore to save and restore cc_op* and
pc_save but, for the time being, assert that this is indeed
the case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 501a1ef9313..d11c5e1dc13 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3709,15 +3709,9 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     case 2:
         /* Restore state that may affect the next instruction. */
         dc->pc = dc->base.pc_next;
-        /*
-         * TODO: These save/restore can be removed after the table-based
-         * decoder is complete; we will be decoding the insn completely
-         * before any code generation that might affect these variables.
-         */
-        dc->cc_op_dirty = orig_cc_op_dirty;
-        dc->cc_op = orig_cc_op;
-        dc->pc_save = orig_pc_save;
-        /* END TODO */
+        assert(dc->cc_op_dirty == orig_cc_op_dirty);
+        assert(dc->cc_op == orig_cc_op);
+        assert(dc->pc_save == orig_pc_save);
         dc->base.num_insns--;
         tcg_remove_ops_after(dc->prev_insn_end);
         dc->base.insn_start = dc->prev_insn_start;
-- 
2.45.2



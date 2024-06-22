Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC5C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3W-0000Xk-LO; Sat, 22 Jun 2024 02:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu38-0000JE-Aa
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu36-0006Sb-PB
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vNRpvyeREGd2+Es2hiS7dffvsmxbIt4ClxNcgU2ADU=;
 b=JpnTIyzFzWRVXwgCw2l3MDNeJQf5XwQy9hHBza2DMIGHsQaxTS2TZhO/bvnPxA5GltshEM
 hXE98Cuf/sQDahktFW5ndgmKR4U1vMUs8xopVLMR/DRqZIZMj7PlcHxwO3eiECymxR0T2U
 9kGJKjAsBV1A+Eizl9L8mDlK40lSydw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-y7u-Dd76M-qB3uNLrg4fqw-1; Sat, 22 Jun 2024 02:16:29 -0400
X-MC-Unique: y7u-Dd76M-qB3uNLrg4fqw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ec4d8ceaafso12307481fa.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036987; x=1719641787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vNRpvyeREGd2+Es2hiS7dffvsmxbIt4ClxNcgU2ADU=;
 b=b/sybDdxMvvSYF70A+GpM1y0PBci/AkJcjD/w1BRjDTD+j1U6oN8Qxq3PpTZbHwD3i
 VKLgtEdFsi013NMfCDatdMXM2pU305jo1JEWvrBFglOayoxGGSkzKKM/zaP5piSmwukG
 yWV9Ekhb3Q1OclCY7RqbSNYVadIRU1kV6XGuV/dNkFoRmQN8WX8qFwtgXUSNwD4+dfaP
 pco3jQrj9LuqrWXYxlE0Zcot3jnWcDwn1jPvXLwXYnTzxHyv+QCrVwY3YucuA28kxmIa
 4gsWEC88r/4Q7s6O/cdtgiEt1DLHOyAx9HfdD59TRgVpHBkoM4XiKi7AdeVQjto3Ilc0
 oueg==
X-Gm-Message-State: AOJu0YxZW8Ir0aKteR6GdJWY88Km2jFU/g/TdTO8snqwaQusqZDKny58
 nFDU4MzMcU5ocmhRO48CCsvwo5obSROlRoUgXGoy3cNEg0DtLxV546OY02zl3XxjrR1kM+AkCua
 oAwJaqPoqSfOUT4kzGtC6ENDVowbFGJKg5mvnF/ftzImIsb4uNzElIAzNu+AmSDmU/V2HNknOcK
 SpyFQ2w8uGPA7TpdAJPkIy6t5OFJrKYhwohdOH
X-Received: by 2002:a2e:96cc:0:b0:2ec:557b:f895 with SMTP id
 38308e7fff4ca-2ec557bfab4mr5533061fa.31.1719036987589; 
 Fri, 21 Jun 2024 23:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6CNSDGL1xiQLRV3OZNnfNG1Laocq/PtTs6TJd4VMyG71n6LUmQDCTUzPFaFr7uymUUhKIDw==
X-Received: by 2002:a2e:96cc:0:b0:2ec:557b:f895 with SMTP id
 38308e7fff4ca-2ec557bfab4mr5532921fa.31.1719036987199; 
 Fri, 21 Jun 2024 23:16:27 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf560ad2sm158976166b.173.2024.06.21.23.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/23] target/i386: assert that cc_op* and pc_save are preserved
Date: Sat, 22 Jun 2024 08:15:45 +0200
Message-ID: <20240622061558.530543-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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



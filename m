Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF8CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3M-0000QR-TO; Sat, 22 Jun 2024 02:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu37-0000I8-5H
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu35-0006SG-HR
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edfgvS3ELSSOyELG7RxvO1gV2FBychxCHSiOtjvR6gU=;
 b=cSJUQrMaNhMTv7pE1eBNvaWWnnn1NmQwLZrkiIvhyGKUKc5VAycqhb5fvr148gxJOJNUvL
 lVhaKyk/x8n2jq7Ra0/Tl5dXBWWY52M3Q6EZWFUL0eRhknyvaphgezQrcT0ihypG4l49c2
 oa31o28RTcyiLwvuKaBCGu7NyDM4OLQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-NwuMkWk2NwWy6d0HXVcCWQ-1; Sat, 22 Jun 2024 02:16:27 -0400
X-MC-Unique: NwuMkWk2NwWy6d0HXVcCWQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec5674b5a4so1282011fa.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036984; x=1719641784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edfgvS3ELSSOyELG7RxvO1gV2FBychxCHSiOtjvR6gU=;
 b=rqwYkki983kY+l2VoqgTpnrPECh8ngXcfk7mPhunmdQesNi1oZbps3GP3ClbZmJBYX
 E9oFjZIkRm2zBJX+00gXps0KjLohjzoocG5qA34qspHjIu2lRPqg7gULF4MxbIGthVQy
 heLuUsoUDBQWEwyLVD39ohJC/rf+nlRu6L1JgMdlqKi9C0bmwYA7IBzFfmvSaeexcJos
 Oed3b1+0rpRZ7cEQEmf5Ene6567OmdlFzOEUgK92TAjMpay8vj1WaU24ZimueNXBPUkE
 Qwi/9iY4ULTTVy8cL9TylvhuieQ3EJvtdEtukfy9tg5qFYSpouZjqY2kj7XH+rBKiQfQ
 KMMw==
X-Gm-Message-State: AOJu0Yw7uypLkild7RECHXksmLqTsohqDmpzFG7uUMJl15BvIbKq+Rf5
 RTWaoDZOXJDqvlPbFIJ30UoWlRf7hykFz2SSp5gxqK5Dh6jMcwWSoo2DtYAeyitbA3aQudKVxyQ
 FVOGJEJWYH044Hb4cWPNnWuPHkYEiqAsrpMs2YxjWNtkEIA31FgQhKnq6R/GMEqwGUevUCOvSXO
 tsVo75zd9Nx8wYe7/9vj1311Tva6b+Gai0WGrW
X-Received: by 2002:a2e:828f:0:b0:2ec:49b5:50d5 with SMTP id
 38308e7fff4ca-2ec49b551bcmr42101491fa.41.1719036984529; 
 Fri, 21 Jun 2024 23:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIY1dG182lwf/narStAyLF9kFvaTUGxfqDdsxsXN2QLqbVlEureUOuXY+uDiQnEvNcbgXlLQ==
X-Received: by 2002:a2e:828f:0:b0:2ec:49b5:50d5 with SMTP id
 38308e7fff4ca-2ec49b551bcmr42101331fa.41.1719036984081; 
 Fri, 21 Jun 2024 23:16:24 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d305616dfsm1886041a12.79.2024.06.21.23.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/23] target/i386: list instructions still in translate.c
Date: Sat, 22 Jun 2024 08:15:44 +0200
Message-ID: <20240622061558.530543-11-pbonzini@redhat.com>
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

Group them so that it is easier to figure out which two-byte opcodes to
tackle together.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index fa51aadfcf2..f01a4f1f1fe 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -129,6 +129,37 @@
  *
  *    (^)  these are the two cases in which Intel and AMD disagree on the
  *         primary exception class
+ *
+ * Instructions still in translate.c
+ * ---------------------------------
+ * Generation of TCG opcodes for almost all instructions is in emit.c.inc;
+ * this file interprets the prefixes and opcode bytes down to individual
+ * instruction mnemonics.  There is only a handful of opcodes still using
+ * a switch statement to decode modrm bits 3-5 and prefixes after decoding
+ * is complete; these are relics of the older x86 decoder and their code
+ * generation is performed in translate.c.
+ *
+ * These unconverted opcodes also perform their own effective address
+ * generation using the gen_lea_modrm() function.
+ *
+ * There is nothing particularly complicated about them; simply, they don't
+ * need any nasty hacks in the decoder, and they shouldn't get in the way
+ * of the implementation of new x86 instructions, so they are left alone
+ * for the time being.
+ *
+ * x87:
+ * 0xD8 - 0xDF
+ *
+ * privileged/system:
+ * 0x0F 0x00               group 6 (SLDT, STR, LLDT, LTR, VERR, VERW)
+ * 0x0F 0x01               group 7 (SGDT, SIDT, LGDT, LIDT, SMSW, LMSW, INVLPG,
+ *                                  MONITOR, MWAIT, CLAC, STAC, XGETBV, XSETBV,
+ *                                  SWAPGS, RDTSCP)
+ * 0x0F 0xC7 (reg operand) group 9 (RDRAND, RDSEED, RDPID)
+ *
+ * MPX:
+ * 0x0F 0x1A               BNDLDX, BNDMOV, BNDCL, BNDCU
+ * 0x0F 0x1B               BNDSTX, BNDMOV, BNDMK, BNDCN
  */
 
 #define X86_OP_NONE { 0 },
-- 
2.45.2



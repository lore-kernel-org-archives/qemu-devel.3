Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AE8C25B79
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mW-0003E5-Ut; Sun, 12 May 2024 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mS-0003Bl-EF
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mR-0005lj-1h
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8iZLgFACevdnZM5syfkzgEYfCmu0MQtpbdIpOzga9E=;
 b=FTT38iGJ6UD1yetcUM0RtUw1gNMZQizdxbjzBTnL/3Rrb5Essey5Qmxb8TkLVMuwiqJNwT
 rcU6OGAbMxQHtoqyLVvHPZcb297HUqXQ/PJ1uhZOEaVj61nFlknOS/jUvDqeQBils1CAR5
 A4vfYjjPQr5wXb+ovKYa29nA3qEHtls=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-JGnjKaPDPZa1eycM3pSBIQ-1; Sun, 12 May 2024 06:49:59 -0400
X-MC-Unique: JGnjKaPDPZa1eycM3pSBIQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-51fa975896eso2948962e87.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715510996; x=1716115796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8iZLgFACevdnZM5syfkzgEYfCmu0MQtpbdIpOzga9E=;
 b=LRva/dMqlJb1KYxwhkbc5867xuFe1VI6TsNB1fNCrhFsZ7VMNAzkIBXAvwijhlCbBZ
 7W2sP5ECOMAjZV1EynBFumrnWCAZ9PQsN2cKA0WdpWLowqB+QPyHutuZsdgS0/W6qLic
 7F8HzBm4Vv7qJtxAK8Xj2NByuzUHTVtRW2GjQ5NAHGUVyaqtCTU//ZF9VGfynx4iXHmr
 Yd14Z0TI350v9JreMeJTWfgOF0QLKgLFoM3I9HYb1NMfNq7DqmGyZuzIhM8BeHPQWd+g
 JaBTnJAciG2pmc5cUt64RJD839+VW3jnlFTvVU5k3SQ8lFbyq/eBb48XeQmu8HqIMMFx
 QLfQ==
X-Gm-Message-State: AOJu0YwBPN8vVKWuRj/HMR8N14/4Xb+lmrQ7WZT+TmGnJ53cJx4Iv9Dd
 ctYHjoKlAC/FrO0H3fnDDjfcrKp5MfCBhYaQRijS/OOHQSrdkNQHSP21f4aIszsQpzt71hgjjKM
 /k5Fsd4zd3F/Tgv8M06dKLWFOOa2PvH6ML6BsY72bJ3PH0U246njKQypc3CDUUUPabIQRjCgzgC
 x0XLN8qwJ/4piOR0EFmbnajA4hNkTrN7tBjWdj
X-Received: by 2002:a05:6512:3d19:b0:51a:b110:3214 with SMTP id
 2adb3069b0e04-5221007029cmr5339917e87.49.1715510996127; 
 Sun, 12 May 2024 03:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyan34vmRDxS/QnHHjnbzPz7m4VR0UbRQFWFSdeSGybTC3Q1f8TpK25v1yrcMAGU7fW4zJqw==
X-Received: by 2002:a05:6512:3d19:b0:51a:b110:3214 with SMTP id
 2adb3069b0e04-5221007029cmr5339902e87.49.1715510995641; 
 Sun, 12 May 2024 03:49:55 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b177desm441858666b.207.2024.05.12.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:49:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/27] target/i386: rdpkru/wrpkru are no-prefix instructions
Date: Sun, 12 May 2024 12:49:21 +0200
Message-ID: <20240512104945.130198-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reject 0x66/0xf3/0xf2 in front of them.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5366dc32dd3..3da4fdf64cc 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3907,7 +3907,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 0xee: /* rdpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                             | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3915,7 +3916,8 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (prefixes & PREFIX_LOCK) {
+            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
+                             | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
-- 
2.45.0



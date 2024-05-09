Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB8FC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 15:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s55eR-0000Nf-Pa; Thu, 09 May 2024 11:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55eO-0000Md-97
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s55eL-0006Kv-FS
 for qemu-devel@nongnu.org; Thu, 09 May 2024 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715268336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pKut2pWgSGhJinmu6Lcbnl9A90cPMPvnbW9ja96pAdo=;
 b=GpJaktkgFlB6TeTFyVswA1idsYYYrMdSDBiIW6F81Z6Q6BqSgzYaYNaxSj7cuvY4CHhti3
 /eBMWZp4fcN5jTJpn9bTIFJEGqRm0Pqy1hUMywCT0AJa137nasbikAwfD6oEgiabjpV65L
 AldBobORZKuI99/iDpmI3LXWyngRHc4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-kTKwGN13PgGOpn1PIQyiCg-1; Thu, 09 May 2024 11:25:33 -0400
X-MC-Unique: kTKwGN13PgGOpn1PIQyiCg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c69844aaso61189066b.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 08:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268332; x=1715873132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKut2pWgSGhJinmu6Lcbnl9A90cPMPvnbW9ja96pAdo=;
 b=o1krJdcgChmxVgSSUDsPEIFGvo5xRC4YnHpMYFVM8Rqtfdp7jdAFpKtHskB6kEq+65
 5D1VSMIrSYLKw8433hKGjbFg5gr0rT9EDDUvEqX2KmpXrwwjumMCO2bFugc0v+TrHDOx
 2RsalsJ0CsLRDnhO05/gOWIpOEOJTRnKzV8RBUeqQdvbPiS2NHwfIaoorcD3oFOtdeLy
 0/eUb2LI9ViLSnqM50JaMnlDtMD1+PMYPkOmX5pjb2MI71GCgEgu2QVkXNxs1z5i3569
 RFPwdgf9qn8PQfipuNCNonR+L4a2FXHqTmlaeWLd4RMNSCUQOv8UuA86knBZxtqfEhkZ
 bcFQ==
X-Gm-Message-State: AOJu0YxLctDUJ/Z4uh6MP9pz34kStoZL+6JB8L5S0yKT9PC0w1BHlq4A
 4rDNY2Pm39hElaaZZt858miv4JaK1BjyzqptHK/MrFB9QPoKHZP5wmiXxCuPKFh2bH6n7UhOIfY
 ug1PTP1GL2kTrvJ+vb/svDrmOKNlfWCHaO2tIwlUKSPEEzj8Z0pCNz3zPjyJxrF6e5k4wV6TMRl
 YOTjdfhmyqmfclcxVH1iHn4x5qrzECBra8OeFg
X-Received: by 2002:a17:906:e297:b0:a59:cfab:50e with SMTP id
 a640c23a62f3a-a59fb94a3e5mr391251766b.16.1715268331785; 
 Thu, 09 May 2024 08:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFef+CYPtN4iaiHyri4VwwCdl6MezoujE+hHix04nWAd/3WMtkKZqBQSEE+Hj2QSZdgaOZ6gw==
X-Received: by 2002:a17:906:e297:b0:a59:cfab:50e with SMTP id
 a640c23a62f3a-a59fb94a3e5mr391250866b.16.1715268331358; 
 Thu, 09 May 2024 08:25:31 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0140dsm83625566b.151.2024.05.09.08.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:25:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: rdpkru/wrpkru are no-prefix instructions
Date: Thu,  9 May 2024 17:25:30 +0200
Message-ID: <20240509152530.141898-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8556CC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrff-0002BI-Cy; Sat, 08 Jun 2024 04:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrfd-00028Q-NB
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrfc-0001hL-3u
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qJBuQ9HZXGNf8JTO/g0NQ+CxbpXs5W1hSQD+PtrFIA=;
 b=BIO24zOXk1O4+LYu1cFD5omnClP+MH3QFRRhR9Qrx8zzjM0coR+kWHyoMJ1GLHfyTDFf89
 oyIxEtC24H90IJR/BcNrBoeMw8+UGDpVgddkEWROGzeUW9Ndz2mA/qfjdriwq8VvXqzs1E
 ifvRs20/VUI8waSpPuNgV5quYCy26vs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-j8tSaxubMjiOAI1KdZdmGw-1; Sat, 08 Jun 2024 04:42:45 -0400
X-MC-Unique: j8tSaxubMjiOAI1KdZdmGw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f0d8b466dso8390166b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836160; x=1718440960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qJBuQ9HZXGNf8JTO/g0NQ+CxbpXs5W1hSQD+PtrFIA=;
 b=WxIcNLjWlRyzCzjTK2EoV+h+Lp0MQDlGB3nDXjthci0G9UtPA6irkwWjGPCIQD1heo
 1YQRdNVaArTZp/E84Zn6UQHQjqy+wIoTheH7456gugVarOxdJLKJk/Uuj/ypLM7cL+tr
 mES8z1+wJ+l7ArvBg/jKdz0rpGHdq/eCAHXNBJMDRe4sQwosVXkSEDV4oeoc43pTZtR2
 6DKnzvTEXYNJ1DKAGMjNi7QviAf4NatLIoJuIpxKoM7x/0f4Go9JOnsA3IV94YxWtZBJ
 FlzTJtOnp5Pr/vb63yiBB16A7laQZedQeUlL4FfOZPmEYLoMNMt5zgHwPwcOzZj8e3oY
 2qIA==
X-Gm-Message-State: AOJu0YxzmZTfjb7yvDohpC4ld/tY2+fDBh2oqJlT0ZS6Fump5c4DIb4s
 Htbr23d7mlEq/HpXLD4NBH7okt9dySCsFwJKR6jotXl0nHYBmca/LAwnkzAgA7zgshTixsEK9aQ
 ZkTvWE0tJ7z2BoQI8GomxSO0289JKLFKvRPSh/n7wBOHgCmxXwx/HuQBtpWbISyfpIAWO6D6GBY
 HEYSLt0rvJ6lMWbd/TXZPDM5RDCJlUEJ5M1MRK
X-Received: by 2002:a50:9550:0:b0:57c:5bdd:178d with SMTP id
 4fb4d7f45d1cf-57c5bdd19acmr3061172a12.6.1717836159943; 
 Sat, 08 Jun 2024 01:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLIH0PdmDrQu7GMBeGfQYbTcjKXaoBUIsNl1AJk7gwZrfL/Aw3PZNkWkPRdOSgtXbmchuKdQ==
X-Received: by 2002:a50:9550:0:b0:57c:5bdd:178d with SMTP id
 4fb4d7f45d1cf-57c5bdd19acmr3061155a12.6.1717836159471; 
 Sat, 08 Jun 2024 01:42:39 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581cd9sm359603566b.16.2024.06.08.01.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/25] target/i386: do not check PREFIX_LOCK in old-style
 decoder
Date: Sat,  8 Jun 2024 10:41:12 +0200
Message-ID: <20240608084113.2770363-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

It is already checked before getting there.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 67f2e792166..ee5ef3ccbc6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2993,7 +2993,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 7: /* RDSEED, RDPID with f3 prefix */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
+                (s->prefix & PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
@@ -3013,7 +3013,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 6: /* RDRAND */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
@@ -3173,8 +3173,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd0: /* xgetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3184,8 +3183,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd1: /* xsetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
@@ -3352,8 +3350,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             gen_st_modrm(s, decode, ot);
             break;
         case 0xee: /* rdpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3361,8 +3358,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -3438,7 +3434,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3446,7 +3441,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3460,7 +3454,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3489,7 +3483,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndldx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -3525,7 +3518,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3553,7 +3545,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3565,7 +3556,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3592,7 +3583,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndstx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
-- 
2.45.1



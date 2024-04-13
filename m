Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF5AC04FF0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVrc-0001t2-Ao; Sat, 13 Apr 2024 01:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrb-0001ss-4l
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:43 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrY-0001dC-Mc
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:42 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5aa4204bacdso1222922eaf.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985819; x=1713590619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGlcb0FOsVrtW/loWoknwOL1pthHdADUVw02ahp2qOs=;
 b=eTxDeJKHK5jWg78ggzI05M8cZUleNlmYKPZbnzABr/wg6DQnb+Vke7uz/QsN2kJ0TC
 iQy9MtDiDf418EcWnvYwvOrYzFqavT4xkFSngc4k+tQBm6k2h8KTVW/2yE4l9UB3P2L3
 thgJiW2jjogV8i2kKwApWyiowcXaB9oGOuVlUfWsGkF4iqojcf/JMUxHC6I7zGCu3yRH
 iYtitqCS1gPKEzCatRFaoiaXNyrxwBJntgL+Xju+GdS9ph5kRYYc8HKQnGI37rYJXiqV
 gQROfFiohT8WheePZLRJvFt0VDeUuosha4V0UWX2g5Ig1eHAdyjtAFkHK6T+Nv//4JDy
 3aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985819; x=1713590619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGlcb0FOsVrtW/loWoknwOL1pthHdADUVw02ahp2qOs=;
 b=rJniLkQTeeOGS/2gatNTWVRDr2BnffZyshHZJCA8VStNOfYuDGevGz5+bT6TWwQlJ/
 ApIVuWHPN6x6eYSmX3f+LTQc2aM2UbAot6nwiQiA9jz2AvbO9k6ywzpaGWpfQXk0KxaO
 skMUNJLC/faaTVq5RxqZwCnu4U8HhsuidWDdkJ7K2bJihlH2Ouy8mzUUQjGKJYuf3R7X
 bGHxj2M1SYbe8xe8u+CJHKEhzqoPXa51JGeibZy+KTZUbYUCA7nWHQ6EBIraL7hBOpNv
 iC30HrlH6L0zx8jpzXpZJUi+ngHrpx01FdQZyPLcnav33WO4rfJL3K+t4FpCZd4e9CH9
 06Qg==
X-Gm-Message-State: AOJu0YwimAIk7gteuw37S51bvjsHj+U1mgbI3aCmHIrqfoy5hEPKrI/q
 /psna19wQJx5VVcSBlUoiIva+7reohj4GrYUTTx9cMiXzYwo9u9DqTen8uEHIqWi89S0izgOM7X
 X
X-Google-Smtp-Source: AGHT+IGsDrY2kGlKQi/BstwiTxQ/4+GN6O/ac97MDFf62SHf2vzU6HzFsCB/2F/sfojegCIPWopl5Q==
X-Received: by 2002:a05:6358:7c13:b0:181:6575:1b22 with SMTP id
 p19-20020a0563587c1300b0018165751b22mr4657754rwf.6.1712985819025; 
 Fri, 12 Apr 2024 22:23:39 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 3/6] disas/cris: Drop with_reg_prefix
Date: Fri, 12 Apr 2024 22:23:30 -0700
Message-Id: <20240413052333.688151-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
References: <20240413052333.688151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The *_without_reg_prefix functions are all commented out.
Remove them, remove all 'with_reg_prefix' parameters,
and remove all of the conditions that test them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 188 +++++++++------------------------------------------
 1 file changed, 32 insertions(+), 156 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 1cc8752104..27f71a8257 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1692,13 +1692,11 @@ format_dec (long number, char *outbuffer, size_t outsize, int signedp)
 static char *
 format_reg (struct cris_disasm_data *disdata,
             int regno,
-            char *outbuffer_start,
-            bfd_boolean with_reg_prefix)
+            char *outbuffer_start)
 {
   char *outbuffer = outbuffer_start;
 
-  if (with_reg_prefix)
-    *outbuffer++ = REGISTER_PREFIX_CHAR;
+  *outbuffer++ = REGISTER_PREFIX_CHAR;
 
   switch (regno)
     {
@@ -1726,14 +1724,12 @@ format_reg (struct cris_disasm_data *disdata,
 
 static char *
 format_sup_reg (unsigned int regno,
-                char *outbuffer_start,
-                bfd_boolean with_reg_prefix)
+                char *outbuffer_start)
 {
   char *outbuffer = outbuffer_start;
   int i;
 
-  if (with_reg_prefix)
-    *outbuffer++ = REGISTER_PREFIX_CHAR;
+  *outbuffer++ = REGISTER_PREFIX_CHAR;
 
   for (i = 0; cris_support_regs[i].name != NULL; i++)
     if (cris_support_regs[i].number == regno)
@@ -1845,8 +1841,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         it.  */
                      const struct cris_opcode *prefix_opcodep,
                      unsigned int prefix_insn,
-                     unsigned char *prefix_buffer,
-                     bfd_boolean with_reg_prefix)
+                     unsigned char *prefix_buffer)
 {
   /* Get a buffer of somewhat reasonable size where we store
      intermediate parts of the insn.  */
@@ -1908,12 +1903,11 @@ print_with_operands (const struct cris_opcode *opcodep,
     switch (*s)
       {
       case 'T':
-        tp = format_sup_reg ((insn >> 12) & 15, tp, with_reg_prefix);
+        tp = format_sup_reg ((insn >> 12) & 15, tp);
         break;
 
       case 'A':
-        if (with_reg_prefix)
-          *tp++ = REGISTER_PREFIX_CHAR;
+        *tp++ = REGISTER_PREFIX_CHAR;
         *tp++ = 'a';
         *tp++ = 'c';
         *tp++ = 'r';
@@ -1945,11 +1939,11 @@ print_with_operands (const struct cris_opcode *opcodep,
 
       case 'D':
       case 'r':
-        tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+        tp = format_reg (disdata, insn & 15, tp);
         break;
 
       case 'R':
-        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        tp = format_reg (disdata, (insn >> 12) & 15, tp);
         break;
 
       case 'n':
@@ -2132,7 +2126,7 @@ print_with_operands (const struct cris_opcode *opcodep,
               {
                 if (insn & 0x400)
                   {
-                    tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+                    tp = format_reg (disdata, insn & 15, tp);
                     *tp++ = '=';
                   }
 
@@ -2174,8 +2168,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         info->target2 = prefix_insn & 15;
 
                         *tp++ = '[';
-                        tp = format_reg (disdata, prefix_insn & 15, tp,
-                                         with_reg_prefix);
+                        tp = format_reg (disdata, prefix_insn & 15, tp);
                         if (prefix_insn & 0x400)
                           *tp++ = '+';
                         *tp++ = ']';
@@ -2191,8 +2184,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         number -= 256;
 
                       /* Output "reg+num" or, if num < 0, "reg-num".  */
-                      tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-                                       with_reg_prefix);
+                      tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
                       if (number >= 0)
                         *tp++ = '+';
                       tp = FORMAT_DEC (number, tp, 1);
@@ -2205,11 +2197,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 
                   case BIAP_OPCODE:
                     /* Output "r+R.m".  */
-                    tp = format_reg (disdata, prefix_insn & 15, tp,
-                                     with_reg_prefix);
+                    tp = format_reg (disdata, prefix_insn & 15, tp);
                     *tp++ = '+';
-                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-                                     with_reg_prefix);
+                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
                     *tp++ = '.';
                     *tp++ = mode_char[(prefix_insn >> 4) & 3];
 
@@ -2226,8 +2216,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                   case BDAP_INDIR_OPCODE:
                     /* Output "r+s.m", or, if "s" is [pc+], "r+s" or
                        "r-s".  */
-                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp,
-                                     with_reg_prefix);
+                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
 
                     if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
                       {
@@ -2297,8 +2286,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         /* Output "r+[R].m" or "r+[R+].m".  */
                         *tp++ = '+';
                         *tp++ = '[';
-                        tp = format_reg (disdata, prefix_insn & 15, tp,
-                                         with_reg_prefix);
+                        tp = format_reg (disdata, prefix_insn & 15, tp);
                         if (prefix_insn & 0x400)
                           *tp++ = '+';
                         *tp++ = ']';
@@ -2327,7 +2315,7 @@ print_with_operands (const struct cris_opcode *opcodep,
               }
             else
               {
-                tp = format_reg (disdata, insn & 15, tp, with_reg_prefix);
+                tp = format_reg (disdata, insn & 15, tp);
 
                 info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
                 info->target = insn & 15;
@@ -2340,7 +2328,7 @@ print_with_operands (const struct cris_opcode *opcodep,
         break;
 
       case 'x':
-        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        tp = format_reg (disdata, (insn >> 12) & 15, tp);
         *tp++ = '.';
         *tp++ = mode_char[(insn >> 4) & 3];
         break;
@@ -2414,7 +2402,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 
         tp = FORMAT_DEC (number, tp, 1);
         *tp++ = ',';
-        tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
+        tp = format_reg (disdata, (insn >> 12) & 15, tp);
       }
       break;
 
@@ -2436,8 +2424,7 @@ print_with_operands (const struct cris_opcode *opcodep,
           *tp++ = '?';
         else
           {
-            if (with_reg_prefix)
-              *tp++ = REGISTER_PREFIX_CHAR;
+            *tp++ = REGISTER_PREFIX_CHAR;
             strcpy (tp, sregp->name);
             tp += strlen (tp);
           }
@@ -2466,8 +2453,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 
 static int
 print_insn_cris_generic (bfd_vma memaddr,
-                         disassemble_info *info,
-                         bfd_boolean with_reg_prefix)
+                         disassemble_info *info)
 {
   int nbytes;
   unsigned int insn;
@@ -2587,7 +2573,7 @@ print_insn_cris_generic (bfd_vma memaddr,
                  to the operands.   */
               print_with_operands (matchedp, insn, bufp, addr, info,
                                    prefix_opcodep, prefix_insn,
-                                   prefix_buffer, with_reg_prefix);
+                                   prefix_buffer);
             }
         }
     }
@@ -2622,134 +2608,24 @@ print_insn_cris_generic (bfd_vma memaddr,
   return advance;
 }
 
-/* Disassemble, prefixing register names with `$'.  CRIS v0..v10.  */
-static int
-print_insn_cris_with_register_prefix (bfd_vma vma,
-                                      disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v0_v10);
-  return print_insn_cris_generic (vma, info, true);
-}
-/* Disassemble, prefixing register names with `$'.  CRIS v32.  */
-
-static int
-print_insn_crisv32_with_register_prefix (bfd_vma vma,
-                                         disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v32);
-  return print_insn_cris_generic (vma, info, true);
-}
-
-#if 0
-/* Disassemble, prefixing register names with `$'.
-   Common v10 and v32 subset.  */
-
-static int
-print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
-                                             disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_common_v10_v32);
-  return print_insn_cris_generic (vma, info, true);
-}
-
-/* Disassemble, no prefixes on register names.  CRIS v0..v10.  */
-
-static int
-print_insn_cris_without_register_prefix (bfd_vma vma,
-                                         disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v0_v10);
-  return print_insn_cris_generic (vma, info, false);
-}
-
-/* Disassemble, no prefixes on register names.  CRIS v32.  */
-
-static int
-print_insn_crisv32_without_register_prefix (bfd_vma vma,
-                                            disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v32);
-  return print_insn_cris_generic (vma, info, false);
-}
-
-/* Disassemble, no prefixes on register names.
-   Common v10 and v32 subset.  */
-
-static int
-print_insn_crisv10_v32_without_register_prefix (bfd_vma vma,
-                                                disassemble_info *info)
-{
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_common_v10_v32);
-  return print_insn_cris_generic (vma, info, false);
-}
-#endif
-
 int
 print_insn_crisv10 (bfd_vma vma,
                     disassemble_info *info)
 {
-  return print_insn_cris_with_register_prefix(vma, info);
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+                                   cris_dis_v0_v10);
+  return print_insn_cris_generic (vma, info);
 }
 
 int
 print_insn_crisv32 (bfd_vma vma,
                     disassemble_info *info)
 {
-  return print_insn_crisv32_with_register_prefix(vma, info);
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+                                   cris_dis_v32);
+  return print_insn_cris_generic (vma, info);
 }
-
-/* Return a disassembler-function that prints registers with a `$' prefix,
-   or one that prints registers without a prefix.
-   FIXME: We should improve the solution to avoid the multitude of
-   functions seen above.  */
-#if 0
-disassembler_ftype
-cris_get_disassembler (bfd *abfd)
-{
-  /* If there's no bfd in sight, we return what is valid as input in all
-     contexts if fed back to the assembler: disassembly *with* register
-     prefix.  Unfortunately this will be totally wrong for v32.  */
-  if (abfd == NULL)
-    return print_insn_cris_with_register_prefix;
-
-  if (bfd_get_symbol_leading_char (abfd) == 0)
-    {
-      if (bfd_get_mach (abfd) == bfd_mach_cris_v32)
-        return print_insn_crisv32_with_register_prefix;
-      if (bfd_get_mach (abfd) == bfd_mach_cris_v10_v32)
-        return print_insn_crisv10_v32_with_register_prefix;
-
-      /* We default to v10.  This may be specifically specified in the
-         bfd mach, but is also the default setting.  */
-      return print_insn_cris_with_register_prefix;
-    }
-
-  if (bfd_get_mach (abfd) == bfd_mach_cris_v32)
-    return print_insn_crisv32_without_register_prefix;
-  if (bfd_get_mach (abfd) == bfd_mach_cris_v10_v32)
-    return print_insn_crisv10_v32_without_register_prefix;
-  return print_insn_cris_without_register_prefix;
-}
-#endif
-/* Local variables:
-   eval: (c-set-style "gnu")
-   indent-tabs-mode: t
-   End:  */
-- 
2.34.1



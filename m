Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48901C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVre-0001u0-Ti; Sat, 13 Apr 2024 01:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrc-0001tF-O0
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:44 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrZ-0001dJ-Oy
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:44 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29e0229d6b5so1221372a91.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985820; x=1713590620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHXdGb2Ykd1dojWJmRnTDjJcr6qyUR/mTTLDcFT9woA=;
 b=PxT3eqVVdogAFSg8rpgi3tzyDcTomyOOSk5h/GiehWNZaD0JpAHI9VJVEhS58c8xb9
 oEFAEL/aBCalkJVazdUdNpH/XPtxpzuVccp/aT7BfnTpVxH9lxaQ+qNcwZFo8LQIXI2e
 xGICXDLvDvWQYv/VFSabKRkxOCAKP1gdVf3RA+S4WAFoIfN0z9U+qvg/H3z76cvWt5to
 mLcfP9RoNlpfD/ku7fJssQ8qNfAeIbpxRcetIHq2MXKhQCDWd790zSPyZVn2x2nh19xB
 jvPXmZK4rjzsTEcWRX8n7Is9XzEwYJTeswGUImc4JOSP4bWV+9PQUyv474caqDyOmMs6
 TJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985820; x=1713590620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHXdGb2Ykd1dojWJmRnTDjJcr6qyUR/mTTLDcFT9woA=;
 b=JefcyCtcc/yjI8vCDorji4bTJe0mdcywu3Iza2fk6D2j/d3GaejrlI5sIl1gSqy/LL
 TeD+6Lq+ecA3ltQL4oQM4doeFwypbz6BjagqocULgDtgq+vwUntfqoxj9KabfH9cLEuN
 wVFMjrP3mkuVeLaxCyN7BJxqasjzG1/my1+R1MyWe8J481aF/ldBHzWTYGOpfDpaKOBf
 z5dBjwHnUwy2aRQdEayUCRUNan1/qnYMP57XDf2eBH5ZYaqv2fLInq8jldIkEQZdV9o7
 QzxqitmdSM1KN1DJKJohGuts80e7Kj+RRDLMvj0j96nFLk07wD0UlD+gTNEhWuoFf6Mk
 ZzKQ==
X-Gm-Message-State: AOJu0Yxd2w7ZVrFUrQO7kklJrWoYIYpiR1evKVK8lpsCEEWRs+67i4HF
 dOJqXxqPeyjfJu2uuATqVb9/W6HgVbD7oTFdn4sCmGEGxOjscFOTNcW9zn1xf7607YjEjymAJoJ
 n
X-Google-Smtp-Source: AGHT+IEdBAA66AmgZVcjoP+lHDG4J9y+OxJcae/3VsemMM+MXTEmTNiIQ9cClVWNhlDqniVCjdMlZw==
X-Received: by 2002:a17:90a:db0a:b0:29b:c9ac:c563 with SMTP id
 g10-20020a17090adb0a00b0029bc9acc563mr3911941pjv.19.1712985819985; 
 Fri, 12 Apr 2024 22:23:39 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 4/6] disas/cris: Use GString in print_with_operands and
 subroutines
Date: Fri, 12 Apr 2024 22:23:31 -0700
Message-Id: <20240413052333.688151-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
References: <20240413052333.688151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Use GString in the core of the disassembler instead of buffering
the string locally.

Instead of info->print_address_func, use format_hex for addresses.
Printing a hex number is what print_address_func does, and using
format_hex properly truncates the 32-bit bit address.  E.g.

-0x00080988:  move.d 0xfffffffffeda49ff,$r4
+0x00080988:  move.d 0xfeda49ff,$r4

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 288 +++++++++++++++++----------------------------------
 1 file changed, 96 insertions(+), 192 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 27f71a8257..692cd4d163 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1663,85 +1663,74 @@ cris_constraint (const char *cs,
 
 /* Format number as hex with a leading "0x" into outbuffer.  */
 
-static char *
-format_hex (unsigned long number,
-            char *outbuffer)
+static void
+format_hex(unsigned long number, GString *str)
 {
   /* Truncate negative numbers on >32-bit hosts.  */
   number &= 0xffffffff;
 
-  sprintf (outbuffer, "0x%lx", number);
-
-  return outbuffer + strlen (outbuffer);
+  g_string_append_printf(str, "0x%lx", number);
 }
 
 /* Format number as decimal into outbuffer.  Parameter signedp says
    whether the number should be formatted as signed (!= 0) or
    unsigned (== 0).  */
 
-static char *
-format_dec (long number, char *outbuffer, size_t outsize, int signedp)
+static void
+format_dec(long number, GString *str, int signedp)
 {
-  snprintf (outbuffer, outsize, signedp ? "%ld" : "%lu", number);
-
-  return outbuffer + strlen (outbuffer);
+  if (signedp)
+    g_string_append_printf(str, "%ld", number);
+  else
+    g_string_append_printf(str, "%lu", number);
 }
 
 /* Format the name of the general register regno into outbuffer.  */
 
-static char *
-format_reg (struct cris_disasm_data *disdata,
-            int regno,
-            char *outbuffer_start)
+static void
+format_reg(struct cris_disasm_data *disdata, int regno, GString *str)
 {
-  char *outbuffer = outbuffer_start;
-
-  *outbuffer++ = REGISTER_PREFIX_CHAR;
+  g_string_append_c(str, REGISTER_PREFIX_CHAR);
 
   switch (regno)
     {
     case 15:
       /* For v32, there is no context in which we output PC.  */
       if (disdata->distype == cris_dis_v32)
-        strcpy (outbuffer, "acr");
+        g_string_append(str, "acr");
       else
-        strcpy (outbuffer, "pc");
+        g_string_append(str, "pc");
       break;
 
     case 14:
-      strcpy (outbuffer, "sp");
+      g_string_append(str, "sp");
       break;
 
     default:
-      sprintf (outbuffer, "r%d", regno);
+      g_string_append_printf(str, "r%d", regno);
       break;
     }
-
-  return outbuffer_start + strlen (outbuffer_start);
 }
 
 /* Format the name of a support register into outbuffer.  */
 
-static char *
-format_sup_reg (unsigned int regno,
-                char *outbuffer_start)
+static void
+format_sup_reg(unsigned int regno, GString *str)
 {
-  char *outbuffer = outbuffer_start;
   int i;
 
-  *outbuffer++ = REGISTER_PREFIX_CHAR;
+  g_string_append_c(str, REGISTER_PREFIX_CHAR);
 
   for (i = 0; cris_support_regs[i].name != NULL; i++)
     if (cris_support_regs[i].number == regno)
       {
-        sprintf (outbuffer, "%s", cris_support_regs[i].name);
-        return outbuffer_start + strlen (outbuffer_start);
+        g_string_append(str, cris_support_regs[i].name);
+        return;
       }
 
   /* There's supposed to be register names covering all numbers, though
      some may be generic names.  */
-  sprintf (outbuffer, "format_sup_reg-BUG");
-  return outbuffer_start + strlen (outbuffer_start);
+  g_string_append(str, "format_sup_reg-BUG");
 }
 
 /* Return the length of an instruction.  */
@@ -1797,8 +1786,8 @@ bytes_to_skip (unsigned int insn,
 
 /* Print condition code flags.  */
 
-static char *
-print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
+static void
+print_flags(struct cris_disasm_data *disdata, unsigned int insn, GString *str)
 {
   /* Use the v8 (Etrax 100) flag definitions for disassembly.
      The differences with v0 (Etrax 1..4) vs. Svinto are:
@@ -1815,17 +1804,9 @@ print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
 
   for (i = 0; i < 8; i++)
     if (flagbits & (1 << i))
-      *cp++ = fnames[i];
-
-  return cp;
+      g_string_append_c(str, fnames[i]);
 }
 
-#define FORMAT_DEC(number, tp, signedp)                      \
-    format_dec (number, tp, ({                                \
-            assert(tp >= temp && tp <= temp + sizeof(temp)); \
-            temp + sizeof(temp) - tp;                        \
-        }), signedp)
-
 /* Print out an insn with its operands, and update the info->insn_type
    fields.  The prefix_opcodep and the rest hold a prefix insn that is
    supposed to be output as an address mode.  */
@@ -1843,19 +1824,13 @@ print_with_operands (const struct cris_opcode *opcodep,
                      unsigned int prefix_insn,
                      unsigned char *prefix_buffer)
 {
-  /* Get a buffer of somewhat reasonable size where we store
-     intermediate parts of the insn.  */
-  char temp[sizeof (".d [$r13=$r12-2147483648],$r10") * 2];
-  char *tp = temp;
+  g_autoptr(GString) str = g_string_new(opcodep->name);
   static const char mode_char[] = "bwd?";
   const char *s;
   const char *cs;
   struct cris_disasm_data *disdata
     = (struct cris_disasm_data *) info->private_data;
 
-  /* Print out the name first thing we do.  */
-  (*info->fprintf_func) (info->stream, "%s", opcodep->name);
-
   cs = opcodep->args;
   s = cs;
 
@@ -1865,13 +1840,13 @@ print_with_operands (const struct cris_opcode *opcodep,
 
   if (*s == 'm' || *s == 'M' || *s == 'z')
     {
-      *tp++ = '.';
+      g_string_append_c(str, '.');
 
       /* Get the size-letter.  */
-      *tp++ = *s == 'M'
-        ? (insn & 0x8000 ? 'd'
-           : insn & 0x4000 ? 'w' : 'b')
-        : mode_char[(insn >> 4) & (*s == 'z' ? 1 : 3)];
+      if (*s == 'M')
+        g_string_append_c(str, insn & 0x8000 ? 'd' : insn & 0x4000 ? 'w' : 'b');
+      else
+        g_string_append_c(str, mode_char[(insn >> 4) & (*s == 'z' ? 1 : 3)]);
 
       /* Ignore the size and the space character that follows.  */
       s += 2;
@@ -1880,7 +1855,7 @@ print_with_operands (const struct cris_opcode *opcodep,
   /* Add a space if this isn't a long-branch, because for those will add
      the condition part of the name later.  */
   if (opcodep->match != (BRANCH_PC_LOW + BRANCH_INCR_HIGH * 256))
-    *tp++ = ' ';
+    g_string_append_c(str, ' ');
 
   /* Fill in the insn-type if deducible from the name (and there's no
      better way).  */
@@ -1903,20 +1878,18 @@ print_with_operands (const struct cris_opcode *opcodep,
     switch (*s)
       {
       case 'T':
-        tp = format_sup_reg ((insn >> 12) & 15, tp);
+        format_sup_reg((insn >> 12) & 15, str);
         break;
 
       case 'A':
-        *tp++ = REGISTER_PREFIX_CHAR;
-        *tp++ = 'a';
-        *tp++ = 'c';
-        *tp++ = 'r';
+        g_string_append_c(str, REGISTER_PREFIX_CHAR);
+        g_string_append(str, "acr");
         break;
 
       case '[':
       case ']':
       case ',':
-        *tp++ = *s;
+        g_string_append_c(str, *s);
         break;
 
       case '!':
@@ -1939,11 +1912,11 @@ print_with_operands (const struct cris_opcode *opcodep,
 
       case 'D':
       case 'r':
-        tp = format_reg (disdata, insn & 15, tp);
+        format_reg(disdata, insn & 15, str);
         break;
 
       case 'R':
-        tp = format_reg (disdata, (insn >> 12) & 15, tp);
+        format_reg(disdata, (insn >> 12) & 15, str);
         break;
 
       case 'n':
@@ -1953,13 +1926,7 @@ print_with_operands (const struct cris_opcode *opcodep,
             = (buffer[2] + buffer[3] * 256 + buffer[4] * 65536
                + buffer[5] * 0x1000000 + addr);
 
-          /* Finish off and output previous formatted bytes.  */
-          *tp = 0;
-          if (temp[0])
-            (*info->fprintf_func) (info->stream, "%s", temp);
-          tp = temp;
-
-          (*info->print_address_func) ((bfd_vma) number, info);
+          format_hex(number, str);
         }
         break;
 
@@ -1968,13 +1935,7 @@ print_with_operands (const struct cris_opcode *opcodep,
           /* Like n but the offset is bits <3:0> in the instruction.  */
           unsigned long number = (buffer[0] & 0xf) * 2 + addr;
 
-          /* Finish off and output previous formatted bytes.  */
-          *tp = 0;
-          if (temp[0])
-            (*info->fprintf_func) (info->stream, "%s", temp);
-          tp = temp;
-
-          (*info->print_address_func) ((bfd_vma) number, info);
+          format_hex(number, str);
         }
         break;
 
@@ -2045,43 +2006,16 @@ print_with_operands (const struct cris_opcode *opcodep,
                 break;
 
               default:
-                strcpy (tp, "bug");
-                tp += 3;
+                g_string_append(str, "bug");
                 number = 42;
               }
 
             if ((*cs == 'z' && (insn & 0x20))
                 || (opcodep->match == BDAP_QUICK_OPCODE
                     && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
-              tp = FORMAT_DEC (number, tp, signedp);
+              format_dec(number, str, signedp);
             else
-              {
-                unsigned int highbyte = (number >> 24) & 0xff;
-
-                /* Either output this as an address or as a number.  If it's
-                   a dword with the same high-byte as the address of the
-                   insn, assume it's an address, and also if it's a non-zero
-                   non-0xff high-byte.  If this is a jsr or a jump, then
-                   it's definitely an address.  */
-                if (nbytes == 4
-                    && (highbyte == ((addr >> 24) & 0xff)
-                        || (highbyte != 0 && highbyte != 0xff)
-                        || info->insn_type == dis_branch
-                        || info->insn_type == dis_jsr))
-                  {
-                    /* Finish off and output previous formatted bytes.  */
-                    *tp = 0;
-                    tp = temp;
-                    if (temp[0])
-                      (*info->fprintf_func) (info->stream, "%s", temp);
-
-                    (*info->print_address_func) ((bfd_vma) number, info);
-
-                    info->target = number;
-                  }
-                else
-                  tp = format_hex (number, tp);
-              }
+              format_hex(number, str);
           }
         else
           {
@@ -2116,7 +2050,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                 info->data_size = size;
               }
 
-            *tp++ = '[';
+            g_string_append_c(str, '[');
 
             if (prefix_opcodep
                 /* We don't match dip with a postincremented field
@@ -2126,8 +2060,8 @@ print_with_operands (const struct cris_opcode *opcodep,
               {
                 if (insn & 0x400)
                   {
-                    tp = format_reg (disdata, insn & 15, tp);
-                    *tp++ = '=';
+                    format_reg(disdata, insn & 15, str);
+                    g_string_append_c(str, '=');
                   }
 
 
@@ -2146,16 +2080,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                           + prefix_buffer[4] * 65536
                           + prefix_buffer[5] * 0x1000000;
 
-                        info->target = (bfd_vma) number;
-
-                        /* Finish off and output previous formatted
-                           data.  */
-                        *tp = 0;
-                        tp = temp;
-                        if (temp[0])
-                          (*info->fprintf_func) (info->stream, "%s", temp);
-
-                        (*info->print_address_func) ((bfd_vma) number, info);
+                        format_hex(number, str);
                       }
                     else
                       {
@@ -2167,11 +2092,11 @@ print_with_operands (const struct cris_opcode *opcodep,
 
                         info->target2 = prefix_insn & 15;
 
-                        *tp++ = '[';
-                        tp = format_reg (disdata, prefix_insn & 15, tp);
+                        g_string_append_c(str, '[');
+                        format_reg(disdata, prefix_insn & 15, str);
                         if (prefix_insn & 0x400)
-                          *tp++ = '+';
-                        *tp++ = ']';
+                          g_string_append_c(str, '+');
+                        g_string_append_c(str, ']');
                       }
                     break;
 
@@ -2184,10 +2109,10 @@ print_with_operands (const struct cris_opcode *opcodep,
                         number -= 256;
 
                       /* Output "reg+num" or, if num < 0, "reg-num".  */
-                      tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
+                      format_reg(disdata, (prefix_insn >> 12) & 15, str);
                       if (number >= 0)
-                        *tp++ = '+';
-                      tp = FORMAT_DEC (number, tp, 1);
+                        g_string_append_c(str, '+');
+                      format_dec(number, str, 1);
 
                       info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
                       info->target = (prefix_insn >> 12) & 15;
@@ -2197,16 +2122,15 @@ print_with_operands (const struct cris_opcode *opcodep,
 
                   case BIAP_OPCODE:
                     /* Output "r+R.m".  */
-                    tp = format_reg (disdata, prefix_insn & 15, tp);
-                    *tp++ = '+';
-                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
-                    *tp++ = '.';
-                    *tp++ = mode_char[(prefix_insn >> 4) & 3];
+                    format_reg(disdata, prefix_insn & 15, str);
+                    g_string_append_c(str, '+');
+                    format_reg(disdata, (prefix_insn >> 12) & 15, str);
+                    g_string_append_c(str, '.');
+                    g_string_append_c(str, mode_char[(prefix_insn >> 4) & 3]);
 
                     info->flags
                       |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
                           | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
-
                           | ((prefix_insn & 0x8000)
                              ? CRIS_DIS_FLAG_MEM_TARGET2_MULT4
                              : ((prefix_insn & 0x8000)
@@ -2214,9 +2138,8 @@ print_with_operands (const struct cris_opcode *opcodep,
                     break;
 
                   case BDAP_INDIR_OPCODE:
-                    /* Output "r+s.m", or, if "s" is [pc+], "r+s" or
-                       "r-s".  */
-                    tp = format_reg (disdata, (prefix_insn >> 12) & 15, tp);
+                    /* Output "r+s.m", or, if "s" is [pc+], "r+s" or "r-s". */
+                    format_reg(disdata, (prefix_insn >> 12) & 15, str);
 
                     if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
                       {
@@ -2253,8 +2176,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                             break;
 
                           default:
-                            strcpy (tp, "bug");
-                            tp += 3;
+                            g_string_append(str, "bug");
                             number = 42;
                           }
 
@@ -2265,39 +2187,32 @@ print_with_operands (const struct cris_opcode *opcodep,
                            address.  */
                         if (nbytes == 4)
                           {
-                            /* Finish off and output previous formatted
-                               bytes.  */
-                            *tp++ = '+';
-                            *tp = 0;
-                            tp = temp;
-                            (*info->fprintf_func) (info->stream, "%s", temp);
-
-                            (*info->print_address_func) ((bfd_vma) number, info);
+                            g_string_append_c(str, '+');
+                            format_hex(number, str);
                           }
                         else
                           {
                             if (number >= 0)
-                              *tp++ = '+';
-                            tp = FORMAT_DEC (number, tp, 1);
+                              g_string_append_c(str, '+');
+                            format_dec(number, str, 1);
                           }
                       }
                     else
                       {
                         /* Output "r+[R].m" or "r+[R+].m".  */
-                        *tp++ = '+';
-                        *tp++ = '[';
-                        tp = format_reg (disdata, prefix_insn & 15, tp);
+                        g_string_append_c(str, '+');
+                        g_string_append_c(str, '[');
+                        format_reg(disdata, prefix_insn & 15, str);
                         if (prefix_insn & 0x400)
-                          *tp++ = '+';
-                        *tp++ = ']';
-                        *tp++ = '.';
-                        *tp++ = mode_char[(prefix_insn >> 4) & 3];
+                          g_string_append_c(str, '+');
+                        g_string_append_c(str, ']');
+                        g_string_append_c(str, '.');
+                        g_string_append_c(str, mode_char[(prefix_insn >> 4) & 3]);
 
                         info->flags
                           |= (CRIS_DIS_FLAG_MEM_TARGET2_IS_REG
                               | CRIS_DIS_FLAG_MEM_TARGET2_MEM
                               | CRIS_DIS_FLAG_MEM_TARGET_IS_REG
-
                               | (((prefix_insn >> 4) == 2)
                                  ? 0
                                  : (((prefix_insn >> 4) & 3) == 1
@@ -2315,26 +2230,26 @@ print_with_operands (const struct cris_opcode *opcodep,
               }
             else
               {
-                tp = format_reg (disdata, insn & 15, tp);
+                format_reg(disdata, insn & 15, str);
 
                 info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
                 info->target = insn & 15;
 
                 if (insn & 0x400)
-                  *tp++ = '+';
+                  g_string_append_c(str, '+');
               }
-            *tp++ = ']';
+            g_string_append_c(str, ']');
           }
         break;
 
       case 'x':
-        tp = format_reg (disdata, (insn >> 12) & 15, tp);
-        *tp++ = '.';
-        *tp++ = mode_char[(insn >> 4) & 3];
+        format_reg(disdata, (insn >> 12) & 15, str);
+        g_string_append_c(str, '.');
+        g_string_append_c(str, mode_char[(insn >> 4) & 3]);
         break;
 
       case 'I':
-        tp = FORMAT_DEC (insn & 63, tp, 0);
+        format_dec(insn & 63, str, 0);
         break;
 
       case 'b':
@@ -2353,21 +2268,17 @@ print_with_operands (const struct cris_opcode *opcodep,
 
           info->target = (bfd_vma) where;
 
-          *tp = 0;
-          tp = temp;
-          (*info->fprintf_func) (info->stream, "%s%s ",
-                                 temp, cris_cc_strings[insn >> 12]);
-
-          (*info->print_address_func) ((bfd_vma) where, info);
+          g_string_append(str, cris_cc_strings[insn >> 12]);
+          format_hex(where, str);
         }
       break;
 
     case 'c':
-      tp = FORMAT_DEC (insn & 31, tp, 0);
+      format_dec(insn & 31, str, 0);
       break;
 
     case 'C':
-      tp = FORMAT_DEC (insn & 15, tp, 0);
+      format_dec(insn & 15, str, 0);
       break;
 
     case 'o':
@@ -2385,10 +2296,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 
         target = addr + ((disdata->distype == cris_dis_v32) ? 0 : 2) + offset;
         info->target = target;
-        *tp = 0;
-        tp = temp;
-        (*info->fprintf_func) (info->stream, "%s", temp);
-        (*info->print_address_func) (target, info);
+        format_hex(target, str);
       }
       break;
 
@@ -2400,18 +2308,18 @@ print_with_operands (const struct cris_opcode *opcodep,
         if (number > 127)
           number = number - 256;
 
-        tp = FORMAT_DEC (number, tp, 1);
-        *tp++ = ',';
-        tp = format_reg (disdata, (insn >> 12) & 15, tp);
+        format_dec(number, str, 1);
+        g_string_append_c(str, ',');
+        format_reg(disdata, (insn >> 12) & 15, str);
       }
       break;
 
     case 'f':
-      tp = print_flags (disdata, insn, tp);
+      print_flags(disdata, insn, str);
       break;
 
     case 'i':
-      tp = FORMAT_DEC ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
+      format_dec((insn & 32) ? (insn & 31) | ~31L : insn & 31, str, 1);
       break;
 
     case 'P':
@@ -2421,29 +2329,25 @@ print_with_operands (const struct cris_opcode *opcodep,
 
         if (sregp == NULL || sregp->name == NULL)
           /* Should have been caught as a non-match earlier.  */
-          *tp++ = '?';
+          g_string_append_c(str, '?');
         else
           {
-            *tp++ = REGISTER_PREFIX_CHAR;
-            strcpy (tp, sregp->name);
-            tp += strlen (tp);
+            g_string_append_c(str, REGISTER_PREFIX_CHAR);
+            g_string_append(str, sregp->name);
           }
       }
       break;
 
     default:
-      strcpy (tp, "???");
-      tp += 3;
+      g_string_append(str, "???");
     }
   }
 
-  *tp = 0;
-
   if (prefix_opcodep)
-    (*info->fprintf_func) (info->stream, " (OOPS unused prefix \"%s: %s\")",
+    (*info->fprintf_func) (info->stream, "(OOPS unused prefix \"%s: %s\") ",
                            prefix_opcodep->name, prefix_opcodep->args);
 
-  (*info->fprintf_func) (info->stream, "%s", temp);
+  (*info->fprintf_func) (info->stream, "%s", str->str);
 }
 
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F225C05024
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVre-0001tz-Rk; Sat, 13 Apr 2024 01:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrd-0001tb-As
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:45 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVra-0001dT-DB
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:45 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a526803fccso904135a91.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985821; x=1713590621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pF9Q6sT8QWcjaBZdy/z96I4yqBVj9yrUa4QsuaKPwaQ=;
 b=QPo3Khdj1My1L00CDFnB45MqqE0xgVk3NvX09InE+z9LkqmTsv6HvoEbVrQOPB4KHO
 SFvNU5TAB7RcE9/1WSsroyqfqxOsAuSEy6mTOrxzUIBpFmON18tL+ni5XdLXldIID5bA
 WgEvTlzZRVKfouKw+aicU30MgMOtbLFgwBuo69fGKyqRCL3N9CGRUPRs90W6WyrimtYI
 8xtj4YfCJ0Pd0v8mihQ4Qzf8ZzEYYWk1spm3bbd0K0od85gp/9NZSLyOFHOe/bMK1e+Z
 2I+ftX1fzJC9g6+8Z54s1doflodMgjgug5f5f0c5TgqdfsoDojDg/apCVsYCAb6fOy96
 YrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985821; x=1713590621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pF9Q6sT8QWcjaBZdy/z96I4yqBVj9yrUa4QsuaKPwaQ=;
 b=RL76l4QpFM9OXCeht7oYlAoqiZZJ2LOQoXXpHHg7AscZ6qHeJqnvsP1PK8hROdjbj7
 a7ldGbKploYjm3Vj2PnHeY2XRI9JYw0PENtGbThV0viQaVl3yBec6DgXEP5XeYA6RtUr
 P2mf2gF3OTvrqyzQygxO6BPEAv0gCRKM61FROSqf+ZjP+eyEEyGgan2zEKr4jqOKxuEy
 t239U9NF/Q6PJi5HRb5lSZ3vBXlBdzx/EqC5+qa8zJl4gZb/ltNbjSX2/q6Lp2HiIUlI
 O37Q7aY3xG/vUFMLld0kxlPOmH1JIDPAfbMI6+WlaBSKIdKd8pX0IS7MF2GR7abnwSvk
 yfQA==
X-Gm-Message-State: AOJu0YxpH+d3M1oUf1GGEkg4O08tJkLvRxxZBp/i+0G0GCMabPBzWSrc
 xcfZgc0g64mJZNSEonJpB4kJ5s2BYaWVIB4Of0NwRYlW0Jq+OVVRQF57UqSHXty75/iWAN5/WT6
 4
X-Google-Smtp-Source: AGHT+IGe8yiK9Wol7Ag8uXF3OOWu4DfxzeZBV900Fclb9ozPEx1Z1EHR2puPMDBwLJLjCXhtH3UN1Q==
X-Received: by 2002:a17:90b:46c8:b0:2a2:50ef:ece2 with SMTP id
 jx8-20020a17090b46c800b002a250efece2mr4154763pjb.17.1712985821014; 
 Fri, 12 Apr 2024 22:23:41 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 5/6] disas/cris: Remove struct cris_disasm_data
Date: Fri, 12 Apr 2024 22:23:32 -0700
Message-Id: <20240413052333.688151-6-richard.henderson@linaro.org>
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

As the structure contains one element, pass the element around
instead of the structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 187 +++++++++++++++++++++------------------------------
 1 file changed, 76 insertions(+), 111 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 692cd4d163..71c292188a 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1239,30 +1239,11 @@ cris_cc_strings[] =
 enum cris_disass_family
  { cris_dis_v0_v10, cris_dis_common_v10_v32, cris_dis_v32 };
 
-/* Stored in the disasm_info->private_data member.  */
-struct cris_disasm_data
-{
-  /* Whether this code is flagged as crisv32.  FIXME: Should be an enum
-     that includes "compatible".  */
-  enum cris_disass_family distype;
-};
-
-static int cris_constraint
-  (const char *, unsigned, unsigned, struct cris_disasm_data *);
-
-/* Parse disassembler options and store state in info.  FIXME: For the
-   time being, we abuse static variables.  */
-
-static void
-cris_parse_disassembler_options (struct cris_disasm_data *disdata,
-                                 char *disassembler_options,
-                                 enum cris_disass_family distype)
-{
-  disdata->distype = distype;
-}
+static int cris_constraint(const char *, unsigned, unsigned,
+                           enum cris_disass_family);
 
 static const struct cris_spec_reg *
-spec_reg_info (unsigned int sreg, enum cris_disass_family distype)
+spec_reg_info(unsigned int sreg, enum cris_disass_family distype)
 {
   int i;
 
@@ -1309,9 +1290,9 @@ number_of_bits (unsigned int val)
 /* Get an entry in the opcode-table.  */
 
 static const struct cris_opcode *
-get_opcode_entry (unsigned int insn,
-                  unsigned int prefix_insn,
-                  struct cris_disasm_data *disdata)
+get_opcode_entry(unsigned int insn,
+                 unsigned int prefix_insn,
+                 enum cris_disass_family distype)
 {
   /* For non-prefixed insns, we keep a table of pointers, indexed by the
      insn code.  Each entry is initialized when found to be NULL.  */
@@ -1349,7 +1330,7 @@ get_opcode_entry (unsigned int insn,
       const struct cris_opcode *popcodep
         = (opc_table[prefix_insn] != NULL
            ? opc_table[prefix_insn]
-           : get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata));
+           : get_opcode_entry(prefix_insn, NO_CRIS_PREFIX, distype));
 
       if (popcodep == NULL)
         return NULL;
@@ -1406,7 +1387,7 @@ get_opcode_entry (unsigned int insn,
         {
           int level_of_match;
 
-          if (disdata->distype == cris_dis_v32)
+          if (distype == cris_dis_v32)
             {
               switch (opcodep->applicable_version)
                 {
@@ -1469,10 +1450,8 @@ get_opcode_entry (unsigned int insn,
           if ((opcodep->match & insn) == opcodep->match
               && (opcodep->lose & insn) == 0
               && ((level_of_match
-                   = cris_constraint (opcodep->args,
-                                      insn,
-                                      prefix_insn,
-                                      disdata))
+                   = cris_constraint(opcodep->args, insn,
+                                     prefix_insn, distype))
                   >= 0)
               && ((level_of_match
                    += 2 * number_of_bits (opcodep->match
@@ -1509,10 +1488,10 @@ get_opcode_entry (unsigned int insn,
    indicating the confidence in the match (higher is better).  */
 
 static int
-cris_constraint (const char *cs,
-                 unsigned int insn,
-                 unsigned int prefix_insn,
-                 struct cris_disasm_data *disdata)
+cris_constraint(const char *cs,
+                unsigned int insn,
+                unsigned int prefix_insn,
+                enum cris_disass_family distype)
 {
   int retval = 0;
   int tmp;
@@ -1526,7 +1505,7 @@ cris_constraint (const char *cs,
         /* Do not recognize "pop" if there's a prefix and then only for
            v0..v10.  */
         if (prefix_insn != NO_CRIS_PREFIX
-            || disdata->distype != cris_dis_v0_v10)
+            || distype != cris_dis_v0_v10)
           return -1;
         break;
 
@@ -1569,7 +1548,7 @@ cris_constraint (const char *cs,
             if (insn & 0x400)
               {
                 const struct cris_opcode *prefix_opcodep
-                  = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
+                  = get_opcode_entry(prefix_insn, NO_CRIS_PREFIX, distype);
 
                 if (prefix_opcodep->match == DIP_OPCODE)
                   return -1;
@@ -1589,7 +1568,7 @@ cris_constraint (const char *cs,
           {
             /* Match the prefix insn to BDAPQ.  */
             const struct cris_opcode *prefix_opcodep
-              = get_opcode_entry (prefix_insn, NO_CRIS_PREFIX, disdata);
+              = get_opcode_entry(prefix_insn, NO_CRIS_PREFIX, distype);
 
             if (prefix_opcodep->match == BDAP_QUICK_OPCODE)
               {
@@ -1602,7 +1581,7 @@ cris_constraint (const char *cs,
                   {
                     unsigned int spec_reg = (insn >> 12) & 15;
                     const struct cris_spec_reg *sregp
-                      = spec_reg_info (spec_reg, disdata->distype);
+                      = spec_reg_info(spec_reg, distype);
 
                     /* For a special-register, the "prefix size" must
                        match the size of the register.  */
@@ -1631,7 +1610,7 @@ cris_constraint (const char *cs,
       case 'P':
         {
           const struct cris_spec_reg *sregp
-            = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+            = spec_reg_info((insn >> 12) & 15, distype);
 
           /* Since we match four bits, we will give a value of 4-1 = 3
              in a match.  If there is a corresponding exact match of a
@@ -1688,7 +1667,7 @@ format_dec(long number, GString *str, int signedp)
 /* Format the name of the general register regno into outbuffer.  */
 
 static void
-format_reg(struct cris_disasm_data *disdata, int regno, GString *str)
+format_reg(enum cris_disass_family distype, int regno, GString *str)
 {
   g_string_append_c(str, REGISTER_PREFIX_CHAR);
 
@@ -1696,7 +1675,7 @@ format_reg(struct cris_disasm_data *disdata, int regno, GString *str)
     {
     case 15:
       /* For v32, there is no context in which we output PC.  */
-      if (disdata->distype == cris_dis_v32)
+      if (distype == cris_dis_v32)
         g_string_append(str, "acr");
       else
         g_string_append(str, "pc");
@@ -1736,10 +1715,10 @@ format_sup_reg(unsigned int regno, GString *str)
 /* Return the length of an instruction.  */
 
 static unsigned
-bytes_to_skip (unsigned int insn,
-               const struct cris_opcode *matchedp,
-               enum cris_disass_family distype,
-               const struct cris_opcode *prefix_matchedp)
+bytes_to_skip(unsigned int insn,
+              const struct cris_opcode *matchedp,
+              enum cris_disass_family distype,
+              const struct cris_opcode *prefix_matchedp)
 {
   /* Each insn is a word plus "immediate" operands.  */
   unsigned to_skip = 2;
@@ -1760,7 +1739,7 @@ bytes_to_skip (unsigned int insn,
         else if (matchedp->imm_oprnd_size == SIZE_SPEC_REG)
           {
             const struct cris_spec_reg *sregp
-              = spec_reg_info ((insn >> 12) & 15, distype);
+              = spec_reg_info((insn >> 12) & 15, distype);
 
             /* FIXME: Improve error handling; should have been caught
                earlier.  */
@@ -1787,7 +1766,7 @@ bytes_to_skip (unsigned int insn,
 /* Print condition code flags.  */
 
 static void
-print_flags(struct cris_disasm_data *disdata, unsigned int insn, GString *str)
+print_flags(enum cris_disass_family distype, unsigned int insn, GString *str)
 {
   /* Use the v8 (Etrax 100) flag definitions for disassembly.
      The differences with v0 (Etrax 1..4) vs. Svinto are:
@@ -1796,8 +1775,7 @@ print_flags(struct cris_disasm_data *disdata, unsigned int insn, GString *str)
      FIXME: Emit v0..v3 flag names somehow.  */
   static const char v8_fnames[] = "cvznxibm";
   static const char v32_fnames[] = "cvznxiup";
-  const char *fnames
-    = disdata->distype == cris_dis_v32 ? v32_fnames : v8_fnames;
+  const char *fnames = distype == cris_dis_v32 ? v32_fnames : v8_fnames;
 
   unsigned char flagbits = (((insn >> 8) & 0xf0) | (insn & 15));
   int i;
@@ -1812,24 +1790,25 @@ print_flags(struct cris_disasm_data *disdata, unsigned int insn, GString *str)
    supposed to be output as an address mode.  */
 
 static void
-print_with_operands (const struct cris_opcode *opcodep,
-                     unsigned int insn,
-                     unsigned char *buffer,
-                     bfd_vma addr,
-                     disassemble_info *info,
-                     /* If a prefix insn was before this insn (and is supposed
-                        to be output as an address), here is a description of
-                        it.  */
-                     const struct cris_opcode *prefix_opcodep,
-                     unsigned int prefix_insn,
-                     unsigned char *prefix_buffer)
+print_with_operands(const struct cris_opcode *opcodep,
+                    unsigned int insn,
+                    unsigned char *buffer,
+                    bfd_vma addr,
+                    disassemble_info *info,
+                    /*
+                     * If a prefix insn was before this insn
+                     * (and is supposed to be output as an address),
+                     * here is a description of it.
+                     */
+                    const struct cris_opcode *prefix_opcodep,
+                    unsigned int prefix_insn,
+                    unsigned char *prefix_buffer,
+                    enum cris_disass_family distype)
 {
   g_autoptr(GString) str = g_string_new(opcodep->name);
   static const char mode_char[] = "bwd?";
   const char *s;
   const char *cs;
-  struct cris_disasm_data *disdata
-    = (struct cris_disasm_data *) info->private_data;
 
   cs = opcodep->args;
   s = cs;
@@ -1912,11 +1891,11 @@ print_with_operands (const struct cris_opcode *opcodep,
 
       case 'D':
       case 'r':
-        format_reg(disdata, insn & 15, str);
+        format_reg(distype, insn & 15, str);
         break;
 
       case 'R':
-        format_reg(disdata, (insn >> 12) & 15, str);
+        format_reg(distype, (insn >> 12) & 15, str);
         break;
 
       case 'n':
@@ -1960,7 +1939,7 @@ print_with_operands (const struct cris_opcode *opcodep,
             else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
               {
                 const struct cris_spec_reg *sregp
-                  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+                  = spec_reg_info((insn >> 12) & 15, distype);
 
                 /* A NULL return should have been as a non-match earlier,
                    so catch it as an internal error in the error-case
@@ -1972,7 +1951,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                   /* PC is always incremented by a multiple of two.
                      For CRISv32, immediates are always 4 bytes for
                      special registers.  */
-                  nbytes = disdata->distype == cris_dis_v32
+                  nbytes = distype == cris_dis_v32
                     ? 4 : (sregp->reg_size + 1) & ~1;
               }
             else
@@ -2035,7 +2014,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                 else if (opcodep->imm_oprnd_size == SIZE_SPEC_REG)
                   {
                     const struct cris_spec_reg *sregp
-                      = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+                      = spec_reg_info((insn >> 12) & 15, distype);
 
                     /* FIXME: Improve error handling; should have been caught
                        earlier.  */
@@ -2060,7 +2039,7 @@ print_with_operands (const struct cris_opcode *opcodep,
               {
                 if (insn & 0x400)
                   {
-                    format_reg(disdata, insn & 15, str);
+                    format_reg(distype, insn & 15, str);
                     g_string_append_c(str, '=');
                   }
 
@@ -2093,7 +2072,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         info->target2 = prefix_insn & 15;
 
                         g_string_append_c(str, '[');
-                        format_reg(disdata, prefix_insn & 15, str);
+                        format_reg(distype, prefix_insn & 15, str);
                         if (prefix_insn & 0x400)
                           g_string_append_c(str, '+');
                         g_string_append_c(str, ']');
@@ -2109,7 +2088,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         number -= 256;
 
                       /* Output "reg+num" or, if num < 0, "reg-num".  */
-                      format_reg(disdata, (prefix_insn >> 12) & 15, str);
+                      format_reg(distype, (prefix_insn >> 12) & 15, str);
                       if (number >= 0)
                         g_string_append_c(str, '+');
                       format_dec(number, str, 1);
@@ -2122,9 +2101,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 
                   case BIAP_OPCODE:
                     /* Output "r+R.m".  */
-                    format_reg(disdata, prefix_insn & 15, str);
+                    format_reg(distype, prefix_insn & 15, str);
                     g_string_append_c(str, '+');
-                    format_reg(disdata, (prefix_insn >> 12) & 15, str);
+                    format_reg(distype, (prefix_insn >> 12) & 15, str);
                     g_string_append_c(str, '.');
                     g_string_append_c(str, mode_char[(prefix_insn >> 4) & 3]);
 
@@ -2139,7 +2118,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 
                   case BDAP_INDIR_OPCODE:
                     /* Output "r+s.m", or, if "s" is [pc+], "r+s" or "r-s". */
-                    format_reg(disdata, (prefix_insn >> 12) & 15, str);
+                    format_reg(distype, (prefix_insn >> 12) & 15, str);
 
                     if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
                       {
@@ -2202,7 +2181,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                         /* Output "r+[R].m" or "r+[R+].m".  */
                         g_string_append_c(str, '+');
                         g_string_append_c(str, '[');
-                        format_reg(disdata, prefix_insn & 15, str);
+                        format_reg(distype, prefix_insn & 15, str);
                         if (prefix_insn & 0x400)
                           g_string_append_c(str, '+');
                         g_string_append_c(str, ']');
@@ -2230,7 +2209,7 @@ print_with_operands (const struct cris_opcode *opcodep,
               }
             else
               {
-                format_reg(disdata, insn & 15, str);
+                format_reg(distype, insn & 15, str);
 
                 info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
                 info->target = insn & 15;
@@ -2243,7 +2222,7 @@ print_with_operands (const struct cris_opcode *opcodep,
         break;
 
       case 'x':
-        format_reg(disdata, (insn >> 12) & 15, str);
+        format_reg(distype, (insn >> 12) & 15, str);
         g_string_append_c(str, '.');
         g_string_append_c(str, mode_char[(insn >> 4) & 3]);
         break;
@@ -2259,7 +2238,7 @@ print_with_operands (const struct cris_opcode *opcodep,
           if (where > 32767)
             where -= 65536;
 
-          where += addr + ((disdata->distype == cris_dis_v32) ? 0 : 4);
+          where += addr + ((distype == cris_dis_v32) ? 0 : 4);
 
           if (insn == BA_PC_INCR_OPCODE)
             info->insn_type = dis_branch;
@@ -2294,7 +2273,7 @@ print_with_operands (const struct cris_opcode *opcodep,
         else
           info->insn_type = dis_condbranch;
 
-        target = addr + ((disdata->distype == cris_dis_v32) ? 0 : 2) + offset;
+        target = addr + (distype == cris_dis_v32 ? 0 : 2) + offset;
         info->target = target;
         format_hex(target, str);
       }
@@ -2310,12 +2289,12 @@ print_with_operands (const struct cris_opcode *opcodep,
 
         format_dec(number, str, 1);
         g_string_append_c(str, ',');
-        format_reg(disdata, (insn >> 12) & 15, str);
+        format_reg(distype, (insn >> 12) & 15, str);
       }
       break;
 
     case 'f':
-      print_flags(disdata, insn, str);
+      print_flags(distype, insn, str);
       break;
 
     case 'i':
@@ -2325,7 +2304,7 @@ print_with_operands (const struct cris_opcode *opcodep,
     case 'P':
       {
         const struct cris_spec_reg *sregp
-          = spec_reg_info ((insn >> 12) & 15, disdata->distype);
+          = spec_reg_info((insn >> 12) & 15, distype);
 
         if (sregp == NULL || sregp->name == NULL)
           /* Should have been caught as a non-match earlier.  */
@@ -2356,15 +2335,14 @@ print_with_operands (const struct cris_opcode *opcodep,
    WITH_REG_PREFIX.  */
 
 static int
-print_insn_cris_generic (bfd_vma memaddr,
-                         disassemble_info *info)
+print_insn_cris_generic(bfd_vma memaddr,
+                        disassemble_info *info,
+                        enum cris_disass_family distype)
 {
   int nbytes;
   unsigned int insn;
   const struct cris_opcode *matchedp;
   int advance = 0;
-  struct cris_disasm_data *disdata
-    = (struct cris_disasm_data *) info->private_data;
 
   /* No instruction will be disassembled as longer than this number of
      bytes; stacked prefixes will not be expanded.  */
@@ -2416,7 +2394,7 @@ print_insn_cris_generic (bfd_vma memaddr,
              of a nuiscance that we will just output "bcc .+2" for it
              and signal it as a noninsn.  */
           (*info->fprintf_func) (info->stream,
-                                 disdata->distype == cris_dis_v32
+                                 distype == cris_dis_v32
                                  ? "bcc ." : "bcc .+2");
           info->insn_type = dis_noninsn;
           advance += 2;
@@ -2428,7 +2406,7 @@ print_insn_cris_generic (bfd_vma memaddr,
           unsigned int prefix_insn = insn;
           int prefix_size = 0;
 
-          matchedp = get_opcode_entry (insn, NO_CRIS_PREFIX, disdata);
+          matchedp = get_opcode_entry(insn, NO_CRIS_PREFIX, distype);
 
           /* Check if we're supposed to write out prefixes as address
              modes and if this was a prefix.  */
@@ -2436,12 +2414,11 @@ print_insn_cris_generic (bfd_vma memaddr,
             {
               /* If it's a prefix, put it into the prefix vars and get the
                  main insn.  */
-              prefix_size = bytes_to_skip (prefix_insn, matchedp,
-                                           disdata->distype, NULL);
+              prefix_size = bytes_to_skip(prefix_insn, matchedp, distype, NULL);
               prefix_opcodep = matchedp;
 
               insn = bufp[prefix_size] + bufp[prefix_size + 1] * 256;
-              matchedp = get_opcode_entry (insn, prefix_insn, disdata);
+              matchedp = get_opcode_entry(insn, prefix_insn, distype);
 
               if (matchedp != NULL)
                 {
@@ -2469,15 +2446,13 @@ print_insn_cris_generic (bfd_vma memaddr,
             }
           else
             {
-              advance
-                += bytes_to_skip (insn, matchedp, disdata->distype,
-                                  prefix_opcodep);
+              advance += bytes_to_skip(insn, matchedp, distype, prefix_opcodep);
 
               /* The info_type and assorted fields will be set according
                  to the operands.   */
-              print_with_operands (matchedp, insn, bufp, addr, info,
-                                   prefix_opcodep, prefix_insn,
-                                   prefix_buffer);
+              print_with_operands(matchedp, insn, bufp, addr, info,
+                                  prefix_opcodep, prefix_insn,
+                                  prefix_buffer, distype);
             }
         }
     }
@@ -2513,23 +2488,13 @@ print_insn_cris_generic (bfd_vma memaddr,
 }
 
 int
-print_insn_crisv10 (bfd_vma vma,
-                    disassemble_info *info)
+print_insn_crisv10(bfd_vma vma, disassemble_info *info)
 {
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v0_v10);
-  return print_insn_cris_generic (vma, info);
+  return print_insn_cris_generic(vma, info, cris_dis_v0_v10);
 }
 
 int
-print_insn_crisv32 (bfd_vma vma,
-                    disassemble_info *info)
+print_insn_crisv32(bfd_vma vma, disassemble_info *info)
 {
-  struct cris_disasm_data disdata;
-  info->private_data = &disdata;
-  cris_parse_disassembler_options (&disdata, info->disassembler_options,
-                                   cris_dis_v32);
-  return print_insn_cris_generic (vma, info);
+  return print_insn_cris_generic(vma, info, cris_dis_v32);
 }
-- 
2.34.1



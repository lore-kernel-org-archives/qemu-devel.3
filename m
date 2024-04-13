Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B050C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 05:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvVra-0001sd-Mq; Sat, 13 Apr 2024 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrZ-0001sF-8p
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:41 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvVrX-0001co-BB
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 01:23:40 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so947148eaf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 22:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712985818; x=1713590618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeAW3psO2a4Q9h7sQeQJixxfk9X81dmTMFMwdx2gcGw=;
 b=zfaZ/kBTLeex2K2c4ktcVBbA/r6HdFpyQrpOnxWtoUrH1pG/8RVZwmlmLwD6FyL+gz
 oYYgrAu+0/5/A5WBrMjukpZ9Wv/mK65pqEn1lTuULNFg+Wqyyhei8MtM8yYYWbyvkQzq
 hsgd4CQXYk8HvD2/muYgECEBtP7+O8TarK8pEPV6JmO0p37I8ZL0ukHenKoTrJAgpWAe
 gnGUV0ef/39aS9kiPjx7gdTA5TaBsHwEWdwGBhzLw1CQ/zqee5m4uKMYgGMJSw2mAe+L
 2B46cWuz2KHYkxImLAkMAKpCKPWGtDs5JjXbEaBYx7K6KmfrDe50GwibIEAjJIdYxp8G
 a0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712985818; x=1713590618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeAW3psO2a4Q9h7sQeQJixxfk9X81dmTMFMwdx2gcGw=;
 b=PV1dxWX99MIlS1BGO33UCDSgtjpDWxJLEz3BluSw8bMxR3J5TZPKCX9oyXiQRELEYg
 BqJJjPOruiiXfONq+mLQmvrZRM5xKzi1fISnFrc3WdgECkRkRv5XkfcLBLklp+uyOt3h
 GNWtbbbP+K61hnJBmwN/CHWMR4/R2vHh7/WFqgpu4dtwo1yjXouWKRMFZHOgDpxJFwgc
 SGQnXEL1emftS2OXndJnjeqOdRX6KsymjbdLDZyzyd5SJrT0ybHe0rEOD2wfdFRHAtc7
 oQi5yWMhPDS6/KDKetyWbdHQzLpnW6Vw8fqxaQ1VZ563yPYfU7rTPueTveDVw0n/m09c
 me4A==
X-Gm-Message-State: AOJu0Yw+t05E+QTAvUAOHFGJjuZHHjL70Mq5D62Wios5iw1cBKRxkggm
 ySxYKC/thQWvR/ToxiVTQxllTtdWXNiKEl5bY5d3cYfW4ThpHFCSZGvfApFxS+BmFNHJQqmFKNe
 Q
X-Google-Smtp-Source: AGHT+IEODxDNWy0TZn5Nfs0denrfv4djfpsZ1L/BaRBURW2aRTHgYLudnrTtuh8XYFN1goGlFSC0sQ==
X-Received: by 2002:a05:6359:4246:b0:183:ddb0:eb03 with SMTP id
 ko6-20020a056359424600b00183ddb0eb03mr6777500rwb.21.1712985818096; 
 Fri, 12 Apr 2024 22:23:38 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a17090abb9300b002a0544b81d6sm3564074pjr.35.2024.04.12.22.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 22:23:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 2/6] disas/cris: Remove TRACE_CASE and related code
Date: Fri, 12 Apr 2024 22:23:29 -0700
Message-Id: <20240413052333.688151-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
References: <20240413052333.688151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

The disassembler_options variable is never set within QEMU,
so this code is never enabled.  Remove it all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/cris.c | 114 ++-------------------------------------------------
 1 file changed, 3 insertions(+), 111 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index d62f9e3264..1cc8752104 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1236,58 +1236,17 @@ cris_cc_strings[] =
 /* Sometimes we prefix all registers with this character.  */
 #define REGISTER_PREFIX_CHAR '$'
 
-/* Whether or not to trace the following sequence:
-   sub* X,r%d
-   bound* Y,r%d
-   adds.w [pc+r%d.w],pc
-
-   This is the assembly form of a switch-statement in C.
-   The "sub is optional.  If there is none, then X will be zero.
-   X is the value of the first case,
-   Y is the number of cases (including default).
-
-   This results in case offsets printed on the form:
-    case N: -> case_address
-   where N is an estimation on the corresponding 'case' operand in C,
-   and case_address is where execution of that case continues after the
-   sequence presented above.
-
-   The old style of output was to print the offsets as instructions,
-   which made it hard to follow "case"-constructs in the disassembly,
-   and caused a lot of annoying warnings about undefined instructions.
-
-   FIXME: Make this optional later.  */
-#ifndef TRACE_CASE
-#define TRACE_CASE (disdata->trace_case)
-#endif
-
 enum cris_disass_family
  { cris_dis_v0_v10, cris_dis_common_v10_v32, cris_dis_v32 };
 
 /* Stored in the disasm_info->private_data member.  */
 struct cris_disasm_data
 {
-  /* Whether to print something less confusing if we find something
-     matching a switch-construct.  */
-  bfd_boolean trace_case;
-
   /* Whether this code is flagged as crisv32.  FIXME: Should be an enum
      that includes "compatible".  */
   enum cris_disass_family distype;
 };
 
-/* Value of first element in switch.  */
-static long case_offset = 0;
-
-/* How many more case-offsets to print.  */
-static long case_offset_counter = 0;
-
-/* Number of case offsets.  */
-static long no_of_case_offsets = 0;
-
-/* Candidate for next case_offset.  */
-static long last_immediate = 0;
-
 static int cris_constraint
   (const char *, unsigned, unsigned, struct cris_disasm_data *);
 
@@ -1299,11 +1258,6 @@ cris_parse_disassembler_options (struct cris_disasm_data *disdata,
                                  char *disassembler_options,
                                  enum cris_disass_family distype)
 {
-  /* Default true.  */
-  disdata->trace_case
-    = (disassembler_options == NULL
-       || (strcmp (disassembler_options, "nocase") != 0));
-
   disdata->distype = distype;
 }
 
@@ -1711,18 +1665,13 @@ cris_constraint (const char *cs,
 
 static char *
 format_hex (unsigned long number,
-            char *outbuffer,
-            struct cris_disasm_data *disdata)
+            char *outbuffer)
 {
   /* Truncate negative numbers on >32-bit hosts.  */
   number &= 0xffffffff;
 
   sprintf (outbuffer, "0x%lx", number);
 
-  /* Save this value for the "case" support.  */
-  if (TRACE_CASE)
-    last_immediate = number;
-
   return outbuffer + strlen (outbuffer);
 }
 
@@ -1733,7 +1682,6 @@ format_hex (unsigned long number,
 static char *
 format_dec (long number, char *outbuffer, size_t outsize, int signedp)
 {
-  last_immediate = number;
   snprintf (outbuffer, outsize, signedp ? "%ld" : "%lu", number);
 
   return outbuffer + strlen (outbuffer);
@@ -2138,7 +2086,7 @@ print_with_operands (const struct cris_opcode *opcodep,
                     info->target = number;
                   }
                 else
-                  tp = format_hex (number, tp, disdata);
+                  tp = format_hex (number, tp);
               }
           }
         else
@@ -2273,11 +2221,6 @@ print_with_operands (const struct cris_opcode *opcodep,
                              ? CRIS_DIS_FLAG_MEM_TARGET2_MULT4
                              : ((prefix_insn & 0x8000)
                                 ? CRIS_DIS_FLAG_MEM_TARGET2_MULT2 : 0)));
-
-                    /* Is it the casejump?  It's a "adds.w [pc+r%d.w],pc".  */
-                    if (insn == 0xf83f && (prefix_insn & ~0xf000) == 0x55f)
-                      /* Then start interpreting data as offsets.  */
-                      case_offset_counter = no_of_case_offsets;
                     break;
 
                   case BDAP_INDIR_OPCODE:
@@ -2514,31 +2457,6 @@ print_with_operands (const struct cris_opcode *opcodep,
                            prefix_opcodep->name, prefix_opcodep->args);
 
   (*info->fprintf_func) (info->stream, "%s", temp);
-
-  /* Get info for matching case-tables, if we don't have any active.
-     We assume that the last constant seen is used; either in the insn
-     itself or in a "move.d const,rN, sub.d rN,rM"-like sequence.  */
-  if (TRACE_CASE && case_offset_counter == 0)
-    {
-      if (CONST_STRNEQ (opcodep->name, "sub"))
-        case_offset = last_immediate;
-
-      /* It could also be an "add", if there are negative case-values.  */
-      else if (CONST_STRNEQ (opcodep->name, "add"))
-        /* The first case is the negated operand to the add.  */
-        case_offset = -last_immediate;
-
-      /* A bound insn will tell us the number of cases.  */
-      else if (CONST_STRNEQ (opcodep->name, "bound"))
-        no_of_case_offsets = last_immediate + 1;
-
-      /* A jump or jsr or branch breaks the chain of insns for a
-         case-table, so assume default first-case again.  */
-      else if (info->insn_type == dis_jsr
-               || info->insn_type == dis_branch
-               || info->insn_type == dis_condbranch)
-        case_offset = 0;
-    }
 }
 
 
@@ -2601,33 +2519,7 @@ print_insn_cris_generic (bfd_vma memaddr,
 
       insn = bufp[0] + bufp[1] * 256;
 
-      /* If we're in a case-table, don't disassemble the offsets.  */
-      if (TRACE_CASE && case_offset_counter != 0)
-        {
-          info->insn_type = dis_noninsn;
-          advance += 2;
-
-          /* If to print data as offsets, then shortcut here.  */
-          (*info->fprintf_func) (info->stream, "case %ld%s: -> ",
-                                 case_offset + no_of_case_offsets
-                                 - case_offset_counter,
-                                 case_offset_counter == 1 ? "/default" :
-                                 "");
-
-          (*info->print_address_func) ((bfd_vma)
-                                       ((short) (insn)
-                                        + (long) (addr
-                                                  - (no_of_case_offsets
-                                                     - case_offset_counter)
-                                                  * 2)), info);
-          case_offset_counter--;
-
-          /* The default case start (without a "sub" or "add") must be
-             zero.  */
-          if (case_offset_counter == 0)
-            case_offset = 0;
-        }
-      else if (insn == 0)
+      if (insn == 0)
         {
           /* We're often called to disassemble zeroes.  While this is a
              valid "bcc .+2" insn, it is also useless enough and enough
-- 
2.34.1



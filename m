Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C92C54E55
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehQ1-0001gW-KE; Mon, 26 Feb 2024 15:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehQ0-0001g9-0L
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:44 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPt-00080p-SI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:42 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c199237eaeso1896267b6e.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978656; x=1709583456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r8V+dWA3RVhS5vfjxAmsItqAa6Frdq+W5yFoj18eJ8=;
 b=KuyxHXqSF0tKC0XvdygtDxYYZ9+wqyODIBRQe00/rwNQc8ZAyANSq7iyHLwIVqbRXB
 fbFIxHbb5nPnLwEslVhhOPX0UrwXnzE0ZtWFLiammDOVgtTHNcnIpmOVDQkcniKlDY3x
 /sjEKMXK/tP8AGxqv7d7ZJA5wdrFtR+9EJRhlBW2q9RPYdq5heBErCaYWjoUSNiesrLI
 FWvRCGtcLA3xCVsTRKgYNbPlCEPyGNSs9NHq3kRyVKgRIZd0QHUFtl52DJRAwgFkZNR1
 klB6JQdTkfbAiZ6lvn+MVZMdUvGaRkZCzSCqdVsPp4qnO2k5h3qQYkRLyXGd3Qc2nlNi
 id1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978656; x=1709583456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5r8V+dWA3RVhS5vfjxAmsItqAa6Frdq+W5yFoj18eJ8=;
 b=mram3a9Ba0meDBh7HoAzNgM2GDMLdheiG0kXawyHhf3QprHmbR59E13VTsz0a2rrl/
 6sVzKanpqUm2a8xftGZPUJZjEH8kg+vZ31iyQoChp7Aal7b5pExt4a0vwBdsTsDKL0BF
 Ak0zsGt6H3ihQbRDorCpX1fDUq2oTtaucsYhi35/oUCvqxK2mjqJ37EDPmI5CI2UWXDH
 OCiKY3POP62Rp24EDHFCkw7ScmFhiAQYTNjdHMyrDdZxoyy8PNRs2Lz6GpkeXsMcI7vh
 JloMVfaubkKGyhciTU8pcWZGxFls0MxHaIOJ00yuhsXKr5fH4hEHYNJzPmZOOiBHjUzU
 8AvA==
X-Gm-Message-State: AOJu0YxtUyxaANuxnRAjPiE5frczxoKQo7jIyQ+9k682Ct6bDSFQvjPX
 PtHclMVuIXJiaq4/pzl8zzZv8yGcSOtVpa/GYr0zhLffLo2sEQhrZ+R6tDVDMpA=
X-Google-Smtp-Source: AGHT+IF3a893SMloMtD5gR4asIlbjvL5GwLKGfmH0MIPtNOfhCb1MnHkhP0sMvFBFA+wuNojQ0AqLQ==
X-Received: by 2002:a05:6808:15a9:b0:3c0:34ff:891f with SMTP id
 t41-20020a05680815a900b003c034ff891fmr217745oiw.57.1708978655785; 
 Mon, 26 Feb 2024 12:17:35 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:35 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 7/9] Hexagon (target/hexagon) Remove gen_op_regs.py
Date: Mon, 26 Feb 2024 13:17:20 -0700
Message-Id: <20240226201722.391879-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/README         |   1 -
 target/hexagon/gen_op_regs.py | 125 ----------------------------------
 target/hexagon/meson.build    |  14 +---
 3 files changed, 2 insertions(+), 138 deletions(-)
 delete mode 100755 target/hexagon/gen_op_regs.py

diff --git a/target/hexagon/README b/target/hexagon/README
index 746ebec378..065c05154d 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -43,7 +43,6 @@ target/hexagon/gen_semantics.c.  This step produces
 That file is consumed by the following python scripts to produce the indicated
 header files in <BUILD_DIR>/target/hexagon
         gen_opcodes_def.py              -> opcodes_def_generated.h.inc
-        gen_op_regs.py                  -> op_regs_generated.h.inc
         gen_printinsn.py                -> printinsn_generated.h.inc
         gen_op_attribs.py               -> op_attribs_generated.h.inc
         gen_helper_protos.py            -> helper_protos_generated.h.inc
diff --git a/target/hexagon/gen_op_regs.py b/target/hexagon/gen_op_regs.py
deleted file mode 100755
index 7b7b33895a..0000000000
--- a/target/hexagon/gen_op_regs.py
+++ /dev/null
@@ -1,125 +0,0 @@
-#!/usr/bin/env python3
-
-##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-import sys
-import re
-import string
-import hex_common
-
-
-##
-##     Generate the register and immediate operands for each instruction
-##
-def calculate_regid_reg(tag):
-    def letter_inc(x):
-        return chr(ord(x) + 1)
-
-    ordered_implregs = ["SP", "FP", "LR"]
-    srcdst_lett = "X"
-    src_lett = "S"
-    dst_lett = "D"
-    retstr = ""
-    mapdict = {}
-    for reg in ordered_implregs:
-        reg_rd = 0
-        reg_wr = 0
-        if ("A_IMPLICIT_WRITES_" + reg) in hex_common.attribdict[tag]:
-            reg_wr = 1
-        if reg_rd and reg_wr:
-            retstr += srcdst_lett
-            mapdict[srcdst_lett] = reg
-            srcdst_lett = letter_inc(srcdst_lett)
-        elif reg_rd:
-            retstr += src_lett
-            mapdict[src_lett] = reg
-            src_lett = letter_inc(src_lett)
-        elif reg_wr:
-            retstr += dst_lett
-            mapdict[dst_lett] = reg
-            dst_lett = letter_inc(dst_lett)
-    return retstr, mapdict
-
-
-def calculate_regid_letters(tag):
-    retstr, mapdict = calculate_regid_reg(tag)
-    return retstr
-
-
-def strip_reg_prefix(x):
-    y = x.replace("UREG.", "")
-    y = y.replace("MREG.", "")
-    return y.replace("GREG.", "")
-
-
-def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.init_registers()
-    tagregs = hex_common.get_tagregs(full=True)
-    tagimms = hex_common.get_tagimms()
-
-    with open(sys.argv[3], "w") as f:
-        for tag in hex_common.tags:
-            regs = tagregs[tag]
-            rregs = []
-            wregs = []
-            regids = ""
-            for regtype, regid, _, numregs in regs:
-                reg = hex_common.get_register(tag, regtype, regid)
-                if reg.is_read():
-                    if regid[0] not in regids:
-                        regids += regid[0]
-                    rregs.append(regtype + regid + numregs)
-                if reg.is_written():
-                    wregs.append(regtype + regid + numregs)
-                    if regid[0] not in regids:
-                        regids += regid[0]
-            for attrib in hex_common.attribdict[tag]:
-                if hex_common.attribinfo[attrib]["rreg"]:
-                    rregs.append(strip_reg_prefix(attribinfo[attrib]["rreg"]))
-                if hex_common.attribinfo[attrib]["wreg"]:
-                    wregs.append(strip_reg_prefix(attribinfo[attrib]["wreg"]))
-            regids += calculate_regid_letters(tag)
-            f.write(
-                f'REGINFO({tag},"{regids}",\t/*RD:*/\t"{",".join(rregs)}",'
-                f'\t/*WR:*/\t"{",".join(wregs)}")\n'
-            )
-
-        for tag in hex_common.tags:
-            imms = tagimms[tag]
-            f.write(f"IMMINFO({tag}")
-            if not imms:
-                f.write(""",'u',0,0,'U',0,0""")
-            for sign, size, shamt in imms:
-                if sign == "r":
-                    sign = "s"
-                if not shamt:
-                    shamt = "0"
-                f.write(f""",'{sign}',{size},{shamt}""")
-            if len(imms) == 1:
-                if sign.isupper():
-                    myu = "u"
-                else:
-                    myu = "U"
-                f.write(f""",'{myu}',0,0""")
-            f.write(")\n")
-
-
-if __name__ == "__main__":
-    main()
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index fb480afc03..b3a0944d3b 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -1,5 +1,5 @@
 ##
-##  Copyright(c) 2020-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2020-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -45,7 +45,6 @@ hexagon_ss.add(semantics_generated)
 #     shortcode_generated.h.inc
 #     tcg_func_table_generated.c.inc
 #     printinsn_generated.h.inc
-#     op_regs_generated.h.inc
 #     op_attribs_generated.h.inc
 #     opcodes_def_generated.h.inc
 #
@@ -76,15 +75,6 @@ printinsn_generated = custom_target(
 )
 hexagon_ss.add(printinsn_generated)
 
-op_regs_generated = custom_target(
-    'op_regs_generated.h.inc',
-    output: 'op_regs_generated.h.inc',
-    depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_op_regs.py'), semantics_generated, attribs_def, '@OUTPUT@'],
-)
-hexagon_ss.add(op_regs_generated)
-
 op_attribs_generated = custom_target(
     'op_attribs_generated.h.inc',
     output: 'op_attribs_generated.h.inc',
@@ -110,7 +100,7 @@ hexagon_ss.add(opcodes_def_generated)
 #
 gen_dectree_import = executable(
     'gen_dectree_import',
-    'gen_dectree_import.c', opcodes_def_generated, op_regs_generated,
+    'gen_dectree_import.c', opcodes_def_generated,
     native: true, build_by_default: false)
 
 iset_py = custom_target(
-- 
2.34.1



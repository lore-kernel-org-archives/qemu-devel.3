Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehQ0-0001gB-5L; Mon, 26 Feb 2024 15:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPx-0001ew-CN
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:41 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPv-000811-BM
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:41 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bb9b28acb4so2482133b6e.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978657; x=1709583457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kAEgIdBp6Ue1btIM+Uj1VoaSgxC8giYiH5Kmbwpsfk=;
 b=X0jRWafIfmHCQy4wudzjJon6cdZ6nMaQbT1QBUZZgd/HS7aQVqMxAnaZ9zfX2Xg6H7
 MfZcBIDvdzJ5EftWNnjSnZztVddg4pV7IP173ZSITblHUgBatjIQKvgjIUukSfvmI/Bk
 fTleKwOBfn0SfxwKD54nUp+8dld/e5BT7VCOjzx1Sj8lHyk/EOM9CS2AgpRoc0JAAmAV
 gwteBUL9qc03wezJZJIg/o4q93bePKk5kr4FedaMkelDKEfbMO4rpoTUQwN+NONdNT+L
 xImQwap2zxirupCI+RV0SbBDS5QW3vb3T9e5YYK+3oETyDe3NeAmmUdxlcJD+J7B1nj7
 WEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978657; x=1709583457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kAEgIdBp6Ue1btIM+Uj1VoaSgxC8giYiH5Kmbwpsfk=;
 b=DxZ1sFYZ8u65K/PE/6mz4SrIeZbSR57LQgN19xto6qV3/ivkiJjGFc9azhJgpWgUnd
 tuS4tEBV2MN5nFJUt6owfEQkqTbKIccpWTWaq1BNJHh6TaL2dwagdofYV82+fCMGJV93
 9KLiF4PXiv/9lOBKujqbWDqhrMhA/VmO3fPyeiz3zY3cKnAhTziRRHwaQx2TjjfP+oq4
 W+xJLyuScc3v6mc/w+jgo+OngQfRTYTUcV0TvN5wzb5PGi+hbQyO+OVl/rTaiTh7qWOn
 YyHT0N92YVMqokjrEQM/Y04vvttpdyaxhpR6iXdfDAGIZa4gmsHf3WCW+Ct26uHK0EwP
 6gig==
X-Gm-Message-State: AOJu0YwoPP/m6H741kyuwJNDf2v6E453rYlokMT4MGadG6p1krYgdsrA
 jhrJ87ju+PaoPBHMgVK+rk1L2/fCUhwPrWIrHhYTWcebWGpCTzU/SqXq6vZBNxI=
X-Google-Smtp-Source: AGHT+IGIC2MNmJJaHD7E3Ew6yvs00WWSjxluTznzDrPZxeqVIlr8drzbSNVdgyUEFxxpJFCgShyqBw==
X-Received: by 2002:a05:6808:2189:b0:3bf:fdb2:ca5b with SMTP id
 be9-20020a056808218900b003bffdb2ca5bmr223210oib.3.1708978657341; 
 Mon, 26 Feb 2024 12:17:37 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:36 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 8/9] Hexagon (target/hexagon) Remove gen_shortcode.py
Date: Mon, 26 Feb 2024 13:17:21 -0700
Message-Id: <20240226201722.391879-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This data structure is not used

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/opcodes.c        |  7 ----
 target/hexagon/README           |  1 -
 target/hexagon/gen_shortcode.py | 63 ---------------------------------
 target/hexagon/meson.build      | 10 ------
 4 files changed, 81 deletions(-)
 delete mode 100755 target/hexagon/gen_shortcode.py

diff --git a/target/hexagon/opcodes.c b/target/hexagon/opcodes.c
index 02ae9cf787..c8bde2f9e9 100644
--- a/target/hexagon/opcodes.c
+++ b/target/hexagon/opcodes.c
@@ -37,13 +37,6 @@ const char * const opcode_names[] = {
 };
 
 
-const char * const opcode_short_semantics[] = {
-#define DEF_SHORTCODE(TAG, SHORTCODE)              [TAG] = #SHORTCODE,
-#include "shortcode_generated.h.inc"
-#undef DEF_SHORTCODE
-    NULL
-};
-
 DECLARE_BITMAP(opcode_attribs[XX_LAST_OPCODE], A_ZZ_LASTATTRIB);
 
 static void init_attribs(int tag, ...)
diff --git a/target/hexagon/README b/target/hexagon/README
index 065c05154d..65b4fcc0fa 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -46,7 +46,6 @@ header files in <BUILD_DIR>/target/hexagon
         gen_printinsn.py                -> printinsn_generated.h.inc
         gen_op_attribs.py               -> op_attribs_generated.h.inc
         gen_helper_protos.py            -> helper_protos_generated.h.inc
-        gen_shortcode.py                -> shortcode_generated.h.inc
         gen_tcg_funcs.py                -> tcg_funcs_generated.c.inc
         gen_tcg_func_table.py           -> tcg_func_table_generated.c.inc
         gen_helper_funcs.py             -> helper_funcs_generated.c.inc
diff --git a/target/hexagon/gen_shortcode.py b/target/hexagon/gen_shortcode.py
deleted file mode 100755
index deb94446c4..0000000000
--- a/target/hexagon/gen_shortcode.py
+++ /dev/null
@@ -1,63 +0,0 @@
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
-def gen_shortcode(f, tag):
-    f.write(f"DEF_SHORTCODE({tag}, {hex_common.semdict[tag]})\n")
-
-
-def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.calculate_attribs()
-    tagregs = hex_common.get_tagregs()
-    tagimms = hex_common.get_tagimms()
-
-    with open(sys.argv[3], "w") as f:
-        f.write("#ifndef DEF_SHORTCODE\n")
-        f.write("#define DEF_SHORTCODE(TAG,SHORTCODE)    /* Nothing */\n")
-        f.write("#endif\n")
-
-        for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
-                continue
-            if tag == "Y6_diag1":
-                continue
-
-            gen_shortcode(f, tag)
-
-        f.write("#undef DEF_SHORTCODE\n")
-
-
-if __name__ == "__main__":
-    main()
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index b3a0944d3b..988e7489ba 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -42,21 +42,11 @@ hexagon_ss.add(semantics_generated)
 #
 # Step 2
 # We use Python scripts to generate the following files
-#     shortcode_generated.h.inc
 #     tcg_func_table_generated.c.inc
 #     printinsn_generated.h.inc
 #     op_attribs_generated.h.inc
 #     opcodes_def_generated.h.inc
 #
-shortcode_generated = custom_target(
-    'shortcode_generated.h.inc',
-    output: 'shortcode_generated.h.inc',
-    depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_shortcode.py'), semantics_generated, attribs_def, '@OUTPUT@'],
-)
-hexagon_ss.add(shortcode_generated)
-
 tcg_func_table_generated = custom_target(
     'tcg_func_table_generated.c.inc',
     output: 'tcg_func_table_generated.c.inc',
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA714C54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4MG-0001Us-47; Wed, 06 Mar 2024 22:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4ME-0001Ue-Ts
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:46 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4MB-0005lR-Gl
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:46 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7c83fb0fa01so15914239f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781822; x=1710386622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mZF31pVOsPdanhM75ZSyb+FCM6gHs0R2hRgmZ/lF6E=;
 b=RBG5bhX/XA1TVkZc0noXV29i1RNH1tiVgYEwpxdZ/c9QXmUG5+w2Wf5A5Oyc+bEI2m
 z7VPcGMLoCPjFFCwKVHLjXKLtLqGsPz/hCeBBK+BghgxGi/vMxXy3k9SWv/LwfkzGZ/V
 aEzQR37+N+jryawcRpha2uVFo/GGSI91gK3s7EUT+kxHru1qR5v5l0IwTWftiXacZ+0w
 DMm/BOowogU2uwM1y2CFTgmPB1BbRUbGd4FQbzE6tC2F37MS/xzPw3US3MHGSyJmHSAL
 q/IL/H3EUEqIFI22sOrjH6FWnIByZppFBc7AjyXeZDjgO//hy5GVq4FZ/WFhlgjm0dTS
 GKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781822; x=1710386622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mZF31pVOsPdanhM75ZSyb+FCM6gHs0R2hRgmZ/lF6E=;
 b=j8MOOmn8x8gAMAow/W4e/UAZqZVaF4/z564MSLewEoQPFfk7BUzpqm+YDHXtUh/x1U
 NRfvrHjm5cS7L/BpeGKU+29wmHPCtM5YYthk1L1394gEbI/qRgLR32uaA6+GcZuxOnNj
 zNr/zTHVlVPiFRBJEKRsyP7wyEMReesfpUCY+TxaMKvYGbkvoswBTgCwWHHUNBs/DfUj
 t2/ZXqjcsAMPPrR/FnlqGpPig/oHtl6AzWhEAlj+xVFde6hh5m6A9ntMe6zEzSi9i9R9
 4RdDSKShOp2vmR78Uvto5e2SKVqtBaa9J6YsvKJUgvldVehIEPBTrL4e5JRjIusScalM
 44qA==
X-Gm-Message-State: AOJu0YwaQMonkypItwHG3mNssVkEFs8eK40REAb4yIwqEGRu8gJZQrSH
 9EtONVKJP77b459vXxIIMNQ5Erk/Kxn9xrqZGUYsJqjnvt5ZNejiL/tsWnyJ7Ns=
X-Google-Smtp-Source: AGHT+IG5Uvp6TK1WMriFXsCmn/81LHkatybrIYhzmbTUwWCSm7kr2s9/FC686CPPSl8Hkr0WbvBvoA==
X-Received: by 2002:a6b:e204:0:b0:7c8:7d11:9d99 with SMTP id
 z4-20020a6be204000000b007c87d119d99mr2859496ioc.19.1709781821966; 
 Wed, 06 Mar 2024 19:23:41 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:40 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 9/9] Hexagon (target/hexagon) Remove
 hex_common.read_attribs_file
Date: Wed,  6 Mar 2024 20:23:27 -0700
Message-Id: <20240307032327.4799-10-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd31.google.com
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

The attribinfo data structure is not used
Adjust the command-line arguments to the python scripts
Add hex_common.read_common_files for TCG/helper generation scripts

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_analyze_funcs.py     | 21 ++-------------
 target/hexagon/gen_helper_funcs.py      | 21 ++-------------
 target/hexagon/gen_helper_protos.py     | 21 ++-------------
 target/hexagon/gen_idef_parser_funcs.py |  5 ++--
 target/hexagon/gen_op_attribs.py        |  5 ++--
 target/hexagon/gen_opcodes_def.py       |  4 +--
 target/hexagon/gen_printinsn.py         |  5 ++--
 target/hexagon/gen_tcg_func_table.py    |  5 ++--
 target/hexagon/gen_tcg_funcs.py         | 21 ++-------------
 target/hexagon/hex_common.py            | 35 +++++++++++++++----------
 target/hexagon/meson.build              | 31 +++++++++++-----------
 11 files changed, 54 insertions(+), 120 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index a9af666cef..b73b4e2349 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -67,24 +67,7 @@ def gen_analyze_func(f, tag, regs, imms):
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.read_overrides_file(sys.argv[3])
-    hex_common.read_overrides_file(sys.argv[4])
-    ## Whether or not idef-parser is enabled is
-    ## determined by the number of arguments to
-    ## this script:
-    ##
-    ##   5 args. -> not enabled,
-    ##   6 args. -> idef-parser enabled.
-    ##
-    ## The 6:th arg. then holds a list of the successfully
-    ## parsed instructions.
-    is_idef_parser_enabled = len(sys.argv) > 6
-    if is_idef_parser_enabled:
-        hex_common.read_idef_parser_enabled_file(sys.argv[5])
-    hex_common.calculate_attribs()
-    hex_common.init_registers()
+    hex_common.read_common_files()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index 9cc3d69c49..e9685bff2f 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -102,24 +102,7 @@ def gen_helper_function(f, tag, tagregs, tagimms):
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.read_overrides_file(sys.argv[3])
-    hex_common.read_overrides_file(sys.argv[4])
-    ## Whether or not idef-parser is enabled is
-    ## determined by the number of arguments to
-    ## this script:
-    ##
-    ##   5 args. -> not enabled,
-    ##   6 args. -> idef-parser enabled.
-    ##
-    ## The 6:th arg. then holds a list of the successfully
-    ## parsed instructions.
-    is_idef_parser_enabled = len(sys.argv) > 6
-    if is_idef_parser_enabled:
-        hex_common.read_idef_parser_enabled_file(sys.argv[5])
-    hex_common.calculate_attribs()
-    hex_common.init_registers()
+    hex_common.read_common_files()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index c82b0f54e4..4cc72a1581 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -44,24 +44,7 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.read_overrides_file(sys.argv[3])
-    hex_common.read_overrides_file(sys.argv[4])
-    ## Whether or not idef-parser is enabled is
-    ## determined by the number of arguments to
-    ## this script:
-    ##
-    ##   5 args. -> not enabled,
-    ##   6 args. -> idef-parser enabled.
-    ##
-    ## The 6:th arg. then holds a list of the successfully
-    ## parsed instructions.
-    is_idef_parser_enabled = len(sys.argv) > 6
-    if is_idef_parser_enabled:
-        hex_common.read_idef_parser_enabled_file(sys.argv[5])
-    hex_common.calculate_attribs()
-    hex_common.init_registers()
+    hex_common.read_common_files()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 550a48cb7b..eb494abba8 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 rev.ng Labs Srl. All Rights Reserved.
+##  Copyright(c) 2019-2024 rev.ng Labs Srl. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -44,13 +44,12 @@
 ##
 def main():
     hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
     hex_common.calculate_attribs()
     hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    with open(sys.argv[3], "w") as f:
+    with open(sys.argv[-1], "w") as f:
         f.write('#include "macros.inc"\n\n')
 
         for tag in hex_common.tags:
diff --git a/target/hexagon/gen_op_attribs.py b/target/hexagon/gen_op_attribs.py
index 41074b8573..99448220da 100755
--- a/target/hexagon/gen_op_attribs.py
+++ b/target/hexagon/gen_op_attribs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -25,13 +25,12 @@
 
 def main():
     hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
     hex_common.calculate_attribs()
 
     ##
     ##     Generate all the attributes associated with each instruction
     ##
-    with open(sys.argv[3], "w") as f:
+    with open(sys.argv[-1], "w") as f:
         for tag in hex_common.tags:
             f.write(
                 f"OP_ATTRIB({tag},ATTRIBS("
diff --git a/target/hexagon/gen_opcodes_def.py b/target/hexagon/gen_opcodes_def.py
index cddd868fe3..536f0eb68a 100755
--- a/target/hexagon/gen_opcodes_def.py
+++ b/target/hexagon/gen_opcodes_def.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -29,7 +29,7 @@ def main():
     ##
     ##     Generate a list of all the opcodes
     ##
-    with open(sys.argv[3], "w") as f:
+    with open(sys.argv[-1], "w") as f:
         for tag in hex_common.tags:
             f.write(f"OPCODE({tag}),\n")
 
diff --git a/target/hexagon/gen_printinsn.py b/target/hexagon/gen_printinsn.py
index e570bd7c6a..8bf4d0985c 100755
--- a/target/hexagon/gen_printinsn.py
+++ b/target/hexagon/gen_printinsn.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -97,11 +97,10 @@ def spacify(s):
 
 def main():
     hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
 
     immext_casere = re.compile(r"IMMEXT\(([A-Za-z])")
 
-    with open(sys.argv[3], "w") as f:
+    with open(sys.argv[-1], "w") as f:
         for tag in hex_common.tags:
             if not hex_common.behdict[tag]:
                 continue
diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
index f998ef0992..978ac1819b 100755
--- a/target/hexagon/gen_tcg_func_table.py
+++ b/target/hexagon/gen_tcg_func_table.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -25,12 +25,11 @@
 
 def main():
     hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
     hex_common.calculate_attribs()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
-    with open(sys.argv[3], "w") as f:
+    with open(sys.argv[-1], "w") as f:
         f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
         f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
 
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 3d8e3cb6a2..05aa0a7855 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -108,24 +108,7 @@ def gen_def_tcg_func(f, tag, tagregs, tagimms):
 
 
 def main():
-    hex_common.read_semantics_file(sys.argv[1])
-    hex_common.read_attribs_file(sys.argv[2])
-    hex_common.read_overrides_file(sys.argv[3])
-    hex_common.read_overrides_file(sys.argv[4])
-    hex_common.calculate_attribs()
-    hex_common.init_registers()
-    ## Whether or not idef-parser is enabled is
-    ## determined by the number of arguments to
-    ## this script:
-    ##
-    ##   5 args. -> not enabled,
-    ##   6 args. -> idef-parser enabled.
-    ##
-    ## The 6:th arg. then holds a list of the successfully
-    ## parsed instructions.
-    is_idef_parser_enabled = len(sys.argv) > 6
-    if is_idef_parser_enabled:
-        hex_common.read_idef_parser_enabled_file(sys.argv[5])
+    is_idef_parser_enabled = hex_common.read_common_files()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 4bacef223f..43ca78b489 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -26,7 +26,6 @@
 semdict = {}  # tag -> semantics
 attribdict = {}  # tag -> attributes
 macros = {}  # macro -> macro information...
-attribinfo = {}  # Register information and misc
 registers = {}  # register -> register functions
 new_registers = {}
 tags = []  # list of all tags
@@ -257,19 +256,6 @@ def read_semantics_file(name):
                 eval_line = ""
 
 
-def read_attribs_file(name):
-    attribre = re.compile(
-        r"DEF_ATTRIB\(([A-Za-z0-9_]+), ([^,]*), "
-        + r'"([A-Za-z0-9_\.]*)", "([A-Za-z0-9_\.]*)"\)'
-    )
-    for line in open(name, "rt").readlines():
-        if not attribre.match(line):
-            continue
-        (attrib_base, descr, rreg, wreg) = attribre.findall(line)[0]
-        attrib_base = "A_" + attrib_base
-        attribinfo[attrib_base] = {"rreg": rreg, "wreg": wreg, "descr": descr}
-
-
 def read_overrides_file(name):
     overridere = re.compile(r"#define fGEN_TCG_([A-Za-z0-9_]+)\(.*")
     for line in open(name, "rt").readlines():
@@ -1143,3 +1129,24 @@ def helper_args(tag, regs, imms):
             "uint32_t part1"
         ))
     return args
+
+
+def read_common_files():
+    read_semantics_file(sys.argv[1])
+    read_overrides_file(sys.argv[2])
+    read_overrides_file(sys.argv[3])
+    ## Whether or not idef-parser is enabled is
+    ## determined by the number of arguments to
+    ## this script:
+    ##
+    ##   4 args. -> not enabled,
+    ##   5 args. -> idef-parser enabled.
+    ##
+    ## The 5:th arg. then holds a list of the successfully
+    ## parsed instructions.
+    is_idef_parser_enabled = len(sys.argv) > 5
+    if is_idef_parser_enabled:
+        read_idef_parser_enabled_file(sys.argv[4])
+    calculate_attribs()
+    init_registers()
+    return is_idef_parser_enabled
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 988e7489ba..b0b253aa6b 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -18,7 +18,6 @@
 hexagon_ss = ss.source_set()
 
 hex_common_py = 'hex_common.py'
-attribs_def = meson.current_source_dir() / 'attribs_def.h.inc'
 gen_tcg_h = meson.current_source_dir() / 'gen_tcg.h'
 gen_tcg_hvx_h = meson.current_source_dir() / 'gen_tcg_hvx.h'
 idef_parser_dir = meson.current_source_dir() / 'idef-parser'
@@ -51,8 +50,8 @@ tcg_func_table_generated = custom_target(
     'tcg_func_table_generated.c.inc',
     output: 'tcg_func_table_generated.c.inc',
     depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_tcg_func_table.py'), semantics_generated, attribs_def, '@OUTPUT@'],
+    depend_files: [hex_common_py],
+    command: [python, files('gen_tcg_func_table.py'), semantics_generated, '@OUTPUT@'],
 )
 hexagon_ss.add(tcg_func_table_generated)
 
@@ -60,8 +59,8 @@ printinsn_generated = custom_target(
     'printinsn_generated.h.inc',
     output: 'printinsn_generated.h.inc',
     depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_printinsn.py'), semantics_generated, attribs_def, '@OUTPUT@'],
+    depend_files: [hex_common_py],
+    command: [python, files('gen_printinsn.py'), semantics_generated, '@OUTPUT@'],
 )
 hexagon_ss.add(printinsn_generated)
 
@@ -69,8 +68,8 @@ op_attribs_generated = custom_target(
     'op_attribs_generated.h.inc',
     output: 'op_attribs_generated.h.inc',
     depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_op_attribs.py'), semantics_generated, attribs_def, '@OUTPUT@'],
+    depend_files: [hex_common_py],
+    command: [python, files('gen_op_attribs.py'), semantics_generated, '@OUTPUT@'],
 )
 hexagon_ss.add(op_attribs_generated)
 
@@ -78,8 +77,8 @@ opcodes_def_generated = custom_target(
     'opcodes_def_generated.h.inc',
     output: 'opcodes_def_generated.h.inc',
     depends: [semantics_generated],
-    depend_files: [hex_common_py, attribs_def],
-    command: [python, files('gen_opcodes_def.py'), semantics_generated, attribs_def, '@OUTPUT@'],
+    depend_files: [hex_common_py],
+    command: [python, files('gen_opcodes_def.py'), semantics_generated, '@OUTPUT@'],
 )
 hexagon_ss.add(opcodes_def_generated)
 
@@ -278,7 +277,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         output: 'idef_parser_input.h.inc',
         depends: [semantics_generated],
         depend_files: [hex_common_py],
-        command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, attribs_def, '@OUTPUT@'],
+        command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'],
     )
 
     preprocessed_idef_parser_input_generated = custom_target(
@@ -347,12 +346,12 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
     helper_dep = [semantics_generated, idef_generated_tcg_c, idef_generated_tcg]
-    helper_in = [semantics_generated, attribs_def, gen_tcg_h, gen_tcg_hvx_h, idef_generated_list]
+    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, idef_generated_list]
 else
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
     helper_dep = [semantics_generated]
-    helper_in = [semantics_generated, attribs_def, gen_tcg_h, gen_tcg_hvx_h]
+    helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h]
 endif
 
 #
@@ -366,7 +365,7 @@ helper_protos_generated = custom_target(
     'helper_protos_generated.h.inc',
     output: 'helper_protos_generated.h.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, attribs_def, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
     command: [python, files('gen_helper_protos.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_protos_generated)
@@ -375,7 +374,7 @@ helper_funcs_generated = custom_target(
     'helper_funcs_generated.c.inc',
     output: 'helper_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, attribs_def, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
     command: [python, files('gen_helper_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(helper_funcs_generated)
@@ -384,7 +383,7 @@ tcg_funcs_generated = custom_target(
     'tcg_funcs_generated.c.inc',
     output: 'tcg_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, attribs_def, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
     command: [python, files('gen_tcg_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(tcg_funcs_generated)
@@ -393,7 +392,7 @@ analyze_funcs_generated = custom_target(
     'analyze_funcs_generated.c.inc',
     output: 'analyze_funcs_generated.c.inc',
     depends: helper_dep,
-    depend_files: [hex_common_py, attribs_def, gen_tcg_h, gen_tcg_hvx_h],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h],
     command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(analyze_funcs_generated)
-- 
2.34.1



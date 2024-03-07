Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D797C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4ME-0001UO-CU; Wed, 06 Mar 2024 22:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4MC-0001Tm-Uf
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:45 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4MA-0005lD-7X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:44 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7c8773a9599so15585139f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781820; x=1710386620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kAEgIdBp6Ue1btIM+Uj1VoaSgxC8giYiH5Kmbwpsfk=;
 b=cyPfGzXavmN2LsqNm0HomWcTyPazEM18FEX3+uzVXVLiAMpHgRJYxwTGZwhBvdCvqz
 JB7fl+I2JgyVDcTVVgKh17vdMH9LwZKcK3FVJ+q6C+qqY0rne72A+NsvooPEj/9+UFAq
 OUeqcw+R2cCgzizITNoWQfbBexK5xgTNEMmk6qs2XZh4TEHOTGFL/b2A9InpVy3wsal2
 /ZIKVmO9j6Y728tz+TnYjqSc+/ArvhFedUTdHtqlcqzgCc11ZMzQPvv/B5gQg4p/Dkjj
 MBgzjo59xRl6hOrrvUEHPj0inzBzm4GGQc1Ww9tVM9TuO0rKBkyuHVHUnzQzauqe94Rh
 tJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781820; x=1710386620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kAEgIdBp6Ue1btIM+Uj1VoaSgxC8giYiH5Kmbwpsfk=;
 b=N+BpgopYudfWy4NGqaIep2FvHb5d4F+OivEIL7cCkDX/0u4cE2VnaX8bK0gTW96vGn
 PibgRRrlLBmEJMukdRNI7pTO+n4Yi12k9hzC8mc4YqbqD/hgbzo/TVm/eLVGn3tqTP5c
 lJqhMEa0uQuFGCMSPGZ/ldSZdqO5YC5q4w7YyAMZPqfx4wyQ5xHpR2GNZ/A3xhjGUFzP
 jJqlCZaBi7hxdAflAG3sz+u2CZqtl18PHZq7JMxispEhcNACXxONbADHN7OSFFfYsYGL
 qaw1xLHDp/Oe970xiGvOsLxqBnaZaulV0mzBMD+sNPR6R4uxGeniQ9omwok3336g3tXf
 KHqw==
X-Gm-Message-State: AOJu0YwEbobrs+BrA7FufhBHD6Yp4Bf7aF5ENlnpvh++/oB6v5BZvB49
 VrLOoxDRXi9oYHVv0iTmWbMM+dHp37R2Dt/rP5F2upMqBdzSUkuSbjP1wd0tmgQ=
X-Google-Smtp-Source: AGHT+IHIT2T4ZZKYpTAA7Wdp5OaYrH7yq6hRAa/ziZwQR33SvCttjkGp5NpYH2MCxrsEj+9vKsk9Zg==
X-Received: by 2002:a5e:a50e:0:b0:7c8:3c53:1e42 with SMTP id
 14-20020a5ea50e000000b007c83c531e42mr14403007iog.14.1709781820258; 
 Wed, 06 Mar 2024 19:23:40 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:39 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 8/9] Hexagon (target/hexagon) Remove gen_shortcode.py
Date: Wed,  6 Mar 2024 20:23:26 -0700
Message-Id: <20240307032327.4799-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2b.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8349EC5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M4-0001RN-9r; Wed, 06 Mar 2024 22:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M1-0001Qr-V5
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:33 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M0-0005c8-Ax
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:33 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36423c819a3so1809915ab.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781809; x=1710386609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqnUCuCSdDMIgj1DvwZoKDRiPtvGWOCbYHnFk7Blm6w=;
 b=NyKgTQgjKRPv4SzU/1c98GqMKVXxMdDhSE47OG15rjOlTOvRHDw9F2toA9KDkaBeZ5
 cXVu9Ce1TEto1F1JmlKrsmRpUCP3s7PYznpsGtmdEZhdP4PZpI1hlwUqTvqJKxR4027h
 xN7zVHjrxcRn7d5DzGFX0bMqGdc6ijambN6ZecdmcxXIjQm0imId1dKh96t43rV40drH
 ZtStR5TBXCgE0N2KZ7kfeobbd8jqnwrpifjGFbw1amOoWlrZIUrY701CLTjvcw/CllBa
 xpSGXsCClaZfjeI0zsn4lmdhH3H4KmdkWfNK/B/IgYhP7LEaMwFf2Mxl4wti3bY11yUJ
 W7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781809; x=1710386609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pqnUCuCSdDMIgj1DvwZoKDRiPtvGWOCbYHnFk7Blm6w=;
 b=SA2ysQ9ZMBz5zGDbwDyGQKTrpe7uZn4TLpQVMq7dXbhLKrlsLpJMwCaUc8u5JBK8GM
 1ySogba2EhVFapIWeCbdPqLZCS6chLnk5iy4a1qyMuwnDmXHW2p8CZ0jCT8HKVDwTAp+
 0LYJd7TBTJoYtS5UsaJlEOmpuXzMQBvtTz2l5Tc3szKhLV17fzUb9tgtVh/8cZiZ1CVn
 WxdFbDBXZpqCOOxWsRws0rxcji//EsjyP1iTpCKvoPbS5kn8/h1g+F+kZ+i68bd1B9EQ
 nMvZZ7W4LTdRBKw1eAxwQNRGf4Av/6us6NtLm64wJdWjokZFRkDL4jKdPKOx/mFb0WI+
 hB8w==
X-Gm-Message-State: AOJu0Yydro3tOxTcQ5Tytr66XPtukO1uNBEPE0xUxjviaGno0JVHKZF9
 LUJVFPnUpR7tGRP/4YNuBcAsb9G6/26sdCb3+GIdna+gXH1gJjWotT3qp9U+5HI=
X-Google-Smtp-Source: AGHT+IEfQUZWY1mZLM55QShSG2zd5hz8BXW149gcSIOe5+8P+pCSYTcwa5Udh95au0si92PKCEw1SA==
X-Received: by 2002:a05:6e02:1d16:b0:365:1b67:205f with SMTP id
 i22-20020a056e021d1600b003651b67205fmr21970537ila.13.1709781809646; 
 Wed, 06 Mar 2024 19:23:29 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:29 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/9] Clean up .new decode and scripts
Date: Wed,  6 Mar 2024 20:23:18 -0700
Message-Id: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x136.google.com
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

During .new decode, there are several places where strchr is used.
We remove these by generating the values that are needed.

Once we have generated the proper values, we no longer need
op_regs_generated.h.inc.  We remove the script that generates it as
well as the code in meson.build

We also remove the script and meson.build code that creates
shortcode_generated.h.inc.  The data structure that includes it is
not used.

We remove hex_common.read_attribs_file.  The Python data structures built
during this step are not used.

**** Changes in v2 ****
Address feedback from Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Mark Philippe's Reviewed-by on patch 01
Update example comment in gen_trans_funcs.py



Taylor Simpson (9):
  Hexagon (target/hexagon) Add is_old/is_new to Register class
  Hexagon (target/hexagon) Mark new_read_idx in trans functions
  Hexagon (target/hexagon) Mark dest_idx in trans functions
  Hexagon (target/hexagon) Mark has_pred_dest in trans functions
  Hexagon (tests/tcg/hexagon) Test HVX .new read from high half of pair
  Hexagon (target/hexagon) Remove uses of op_regs_generated.h.inc
  Hexagon (target/hexagon) Remove gen_op_regs.py
  Hexagon (target/hexagon) Remove gen_shortcode.py
  Hexagon (target/hexagon) Remove hex_common.read_attribs_file

 target/hexagon/insn.h                   |   5 +-
 target/hexagon/opcodes.h                |   4 -
 target/hexagon/decode.c                 |  50 ++--------
 target/hexagon/mmvec/decode_ext_mmvec.c |  30 ++----
 target/hexagon/opcodes.c                |  35 -------
 tests/tcg/hexagon/hvx_misc.c            |  16 ++-
 target/hexagon/README                   |   2 -
 target/hexagon/gen_analyze_funcs.py     |  21 +---
 target/hexagon/gen_helper_funcs.py      |  21 +---
 target/hexagon/gen_helper_protos.py     |  21 +---
 target/hexagon/gen_idef_parser_funcs.py |   5 +-
 target/hexagon/gen_op_attribs.py        |   5 +-
 target/hexagon/gen_op_regs.py           | 125 ------------------------
 target/hexagon/gen_opcodes_def.py       |   4 +-
 target/hexagon/gen_printinsn.py         |   5 +-
 target/hexagon/gen_shortcode.py         |  63 ------------
 target/hexagon/gen_tcg_func_table.py    |   5 +-
 target/hexagon/gen_tcg_funcs.py         |  21 +---
 target/hexagon/gen_trans_funcs.py       |  26 ++++-
 target/hexagon/hex_common.py            |  49 +++++++---
 target/hexagon/meson.build              |  55 ++++-------
 21 files changed, 122 insertions(+), 446 deletions(-)
 delete mode 100755 target/hexagon/gen_op_regs.py
 delete mode 100755 target/hexagon/gen_shortcode.py

-- 
2.34.1



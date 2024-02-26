Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFFAC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPy-0001fY-Ji; Mon, 26 Feb 2024 15:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPx-0001ev-Az
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:41 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPm-0007z9-BV
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:41 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c1abce4f48so136765b6e.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978645; x=1709583445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BTmBTQ+EHW10p+hpTeijt3KXD0xzovjUdDQWJ7+Iu00=;
 b=BSBmlafu6v2inqrDlbiz3QWPyG7EXrponnbelWUT1J5nuQg+xeocZSv7OsR8nxqXv9
 h+W47CLhyIPId8zV4Vkxi/MxBLPBq4sj3u4oEN96+jN9WyhWS+lu+wNaFiT8RhHTb1wK
 7CWob9fM85trI5I+p25LJLNL4sN7sH5rI24+WBliuW925Hqenpntwnl8/D4AD8OfVzeE
 w91zN8hZj+agjo2bx9zHrlfvC+rzagL35voQbflAQUo9PEem9kgdt0fuP6iFkhOxZI45
 jyq9Tve9HAYeIaWsbZyEzieg6sE/ygGW0gUThMlXTftHlqxtw/VclPWJ5W7/uo5vcJJ6
 bhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978645; x=1709583445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BTmBTQ+EHW10p+hpTeijt3KXD0xzovjUdDQWJ7+Iu00=;
 b=F0hmfdwaeAVBFLkwFDgvQ+8WlWkwwt1onME6ebyYRVEjRH2nMYdNkIt4u/5cwV5MjV
 87P9a90ddDWNjnFIOmzOobd33REERTEbn2ZcKJR8/9XSI/LEine2TTgffgQ9xNkkaJQ8
 q9yqB7iRHfj9c5+59oO1MOlqDJ0fCRNvy03OyswGxcJ7cibeYgNFZwBWvrcy4DxdnaTe
 JrHdK0mDNnV6K4i8TwUZt+JwDjJjUa8GUMlLc9v3W72sVKU086450nuZ+8BIupagmCa7
 +UPhcBTFZ21BEFom32Z7BTbO74GrSZ96nA/jT6Mx9OTuKHN8gDyFsNUq9/2HA1qjnuMW
 yN/g==
X-Gm-Message-State: AOJu0YzrmPnANsunTfOxU57gzBoMMHKOutRXA9zaXhiJR5xJI3udND47
 MoN11UK0pFbkkDW5e8ImcXM+u7iTqyAU6qg9sbssSxb2WGinmIS5G0GNraJ8znE=
X-Google-Smtp-Source: AGHT+IEUgKfMSS+H2MeFgb4qWBwerrklMvKnomdohggHH1wLk65cAuGQ0yn/A0ijawCi064VT8nRYQ==
X-Received: by 2002:a05:6808:1a07:b0:3c1:a9cc:10c with SMTP id
 bk7-20020a0568081a0700b003c1a9cc010cmr295428oib.7.1708978645362; 
 Mon, 26 Feb 2024 12:17:25 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:24 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 0/9] Hexagon (target/hexagon) Clean up .new decode and scripts
Date: Mon, 26 Feb 2024 13:17:13 -0700
Message-Id: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 target/hexagon/gen_trans_funcs.py       |  23 ++++-
 target/hexagon/hex_common.py            |  49 +++++++---
 target/hexagon/meson.build              |  55 ++++-------
 21 files changed, 119 insertions(+), 446 deletions(-)
 delete mode 100755 target/hexagon/gen_op_regs.py
 delete mode 100755 target/hexagon/gen_shortcode.py

-- 
2.34.1



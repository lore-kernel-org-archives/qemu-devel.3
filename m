Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49B8C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZb-0003sO-6h; Mon, 14 Sep 2026 17:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZY-0003s8-QX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:45 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZX-00019A-77
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:44 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c13f2685f2so1729828b6e.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422642; x=1790027442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5qoWrVh9PaWRXN2iGxOt6A0xLg67v1Mi9xFTn+VBJLw=;
 b=jVg4eixTJ1VjpymLAExqRk881L7LX7h1VSRt0A0heADb0z2tNQiFcVhFA+iX3d/MxV
 Gw+3xGEFHOc0r0I6coPDYawbgdY/dRx/zee764hYoeKyEeZrJn8I0L8ezr4tBC1KpDJo
 vJakeMZY80XIAqeqFl1Ip7k3b9V6BPwtg/bA7/h2CFrE1ApJRVRKPoVKphUyohYFuMjX
 h/I6NlR34LXKXOx+MnDMv40CAygQ0Q7AF2sCDF7r3/gOmqVyklVrbhHJic0k2VyX3wBL
 YVHaBoN289gRCRpSXrNuC63EWsDaCpoXGmAGFut3sa2rAxUaM/v2IiiUzVN9zsyxtQff
 MM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422642; x=1790027442;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5qoWrVh9PaWRXN2iGxOt6A0xLg67v1Mi9xFTn+VBJLw=;
 b=mqLkqJ2j3mOXCc7ZqBzbkMYOtBeAXnqpsB5SvLWpoe66k2X+YjNjm6wFPQH8X/6BhS
 72Fw2ZuPgoRhp7LE5U/AE2LHX2L6nKiIPGaqIXu9NNxqL9tEDAgTiamOr+BWCXfntr39
 93mYDqaU2aK5RZjk+TpzNR2q44ZRj7SUKf1J5Yol9q71vD+WEjf2hZXuSM0KV3+90ds1
 9iacq4bXW7lqk6zhdf5Xwa2hxDjnP/5cIdiE6x/wda03MZ0hR7ScI9ij3JB3fawjJ/MA
 ez7Xspgvy5ArXLeuwDil3kHHT6Jm3HTP0ChblSPRQW/7vwP8nzJXLBiEHWqwOAJ84/7U
 Fkkg==
X-Gm-Message-State: AFuF++kkHSEPrPtx6QmIOF1M9gLySHVWnWf4C6oUKMRn386YJiwgnx8z
 O4C0RhYOnYF0hFfnlegpigRGxLMH0GrCepgIileQBVNdXo6jfHfeFM5uEJHRMDOp
X-Gm-Gg: AYBFou1LkqZrNUnpzF23ogzM2WRVFs3VLeMfETpGRnbzA0GLD06zfAdHj1mI4lV8zl1
 JSyhlL2C8RttK04y1ZDBUoi9lX+zYsm361fOTK/jpXzz8xdyN/2xVNMVcUHvJm/mn4U+e2GuzgJ
 IsbIV664JFbOTj6sODSA1kr92r0HhlLBJSGLMsO/LSfUslnuo4rsPpSYlLii+tNzdoiCatj/J/Y
 ZPPDwwV6wn3jj9M10c5aEOgF7tkYGY8Ztdwh8V3VATgLncX2EbET+6hlLdMC26sZtu8tA+9nroK
 YIlTCDY1nSMSnTniy+pOkrqTfM+/GsWebize6rB1YXBpiboasE6oiQZGWSLvnLhMrvHwgqLZ/lm
 PJ54r/0XigJSt+LYwDCWRwDW+n8RQ6jCTwRYrBSFe8ycpA4DpzBdn8R6OOHXC9FJoMK11LUxiTP
 G1nmTfmO3nTJgv+g62cZWkm06N2kNEjavUB6rHjOEPpn+lQaNlEEbR4Hiji2UNjCwFiXE9P6ded
 +SIXCLm7/ZG7P4yOP+Hherur06IU/0fhYq7HpPHVmaNZSGXWH1pIAbMVdrwmWbE
X-Received: by 2002:a05:6808:1385:b0:4c5:e178:2a4e with SMTP id
 5614622812f47-4c7b57a0147mr3262485b6e.20.1789422641732; 
 Mon, 14 Sep 2026 14:50:41 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:40 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 00/10] Hexagon (target/hexagon) Check for multiwrites in
 analyze_packet
Date: Mon, 14 Sep 2026 15:50:26 -0600
Message-ID: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, we check for register multiwrites during packet decode. The
downside of this approach is that it only checks a single destination
register for each instruction.  During analyze_packet, we can check
for more than one write per instruction.  Further, we can check for
different types of registers.  This series adds checks for HVX
v-registers and q-registers.

Note that multiple writes to a predicate register are allowed on Hexagon.

Changes in v2
- Rebase against latest sources, including Hexagon system mode
- Add checks for multiple writes to system registers

Changes in v3
- Address feedback from Brian Cain <brian.cain@oss.qualcomm.com>
    Fix check-functional failures
    Typo in commit comment
- Address feedback from Marco Liebel <marco.liebel@oss.qualcomm.com>
    Add test for mixed predicated/unconditional writes to vreg


Taylor Simpson (10):
  Hexagon (target/hexagon) Move code out of gen_start_packet
  Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for multi-destination
    instructions
  Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
  Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
  Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
  Hexagon (target/hexagon) Check for greg multiwrite in analyze_packet
  Hexagon (target/hexagon) Check for sreg multiwrite in analyze_packet
  Hexagon (target/hexagon) Remove old way of detecting register
    multiwrites

 target/hexagon/insn.h               |   4 -
 target/hexagon/translate.h          |  47 +++++++--
 target/hexagon/decode.c             |  54 ----------
 target/hexagon/translate.c          |  90 +++++++++++++----
 tests/tcg/hexagon/multiple-writes.c | 149 ++++++++++++++++++++++++++++
 target/hexagon/gen_trans_funcs.py   |  10 --
 tests/tcg/hexagon/meson.build       |   2 +-
 7 files changed, 261 insertions(+), 95 deletions(-)

-- 
2.43.0



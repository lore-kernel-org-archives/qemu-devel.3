Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A78F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxn-0006iV-LV; Thu, 23 Apr 2026 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxi-0006NK-He
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxd-0004AC-R7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so52258415e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938824; x=1777543624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLBCcZ8K/Ysb8sT0yNS5AE+QJk2X/0RqNtFrI+U0hgU=;
 b=KxA/YAZXxBwsD/HtKmDe49wGP74GYoW5nwAIzqPrweI40cVXNCtxY3KUrK3XArltPX
 0O9C4MV9GO+bMZSMTCRuG0HaiVONA8eM8v4Zkliu4qkOVc4tc0lcZtfwYF9GY2m0iNe3
 RenT5AvF5gDd0CzzS93NM/0ZInbiMXI0x9LnWMtchdNxIPO5gv4nv1a87lLxVSudbzCy
 Ht/Qc1krOq+ULJ48WsS9eMFs7eEnSeaH43geSyJyRJzTu8jIS6xhdO5fDwheltR7y0LM
 HotlhabDh+rYVBLJ7On4Cl+SwfLRNJVjTTE3OHgBfkw34dDijnhxVzmh4Zo/Ut2qL+Sw
 GqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938824; x=1777543624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLBCcZ8K/Ysb8sT0yNS5AE+QJk2X/0RqNtFrI+U0hgU=;
 b=q4bazeYsggQEwgZmB6dRa1ghWXb6pa/QqKFA3EQvesXYyBnriujfmjtFc6ijTH62pN
 IchyU66yjwRvJqC4XBQCzjnGRgHRfqzPz99BSn9ZdPY9Ek7/4BHnh8yasYKf3Qi+gSAQ
 MswaLQZWmgVTWsuj1FwfoEEFimLhOmnD/FIDaDA853Pv3uD04a2JDOKN2YvPO75eDc7V
 aXR3iPK5OSJBjzVaQ2PF7iWREuDMKf0Ty2hxxSu+uVh0z2KyA+5p6XektcdJWw3cNM6e
 qb7bW/eEZk1KqeLFMhYJXezV1FGpVCYK0xF1Il1R5vyvGdtxW2Z1RDdB5Ih8k+Pl1S0O
 Spgg==
X-Gm-Message-State: AOJu0YzztfnXK/QpVT78iHhNZFD1Hb8PTpOozT64nSEX8mdup3mJNX3q
 V43ZaPLRVskN3kJ5C+GDn1kKL2OfnnIric49oePD1XBCMSRHLnqiRs9Fe+97i+8gBLS2QHTX254
 lTseAjv0=
X-Gm-Gg: AeBDievdCa6pPUA/cEa2r6Vlr67HO1yke1187K4nyB+L17Wb84uktfcvLxWttQ+2wpD
 JtlrbmSAdmz+7npgHtk1h/H526OhU7JHWatO0QDI7zJZCjjHfs7o+AgLRgzLUyohJAlW20w0Ixf
 D8aYPncQMgAqPSTXZ+NCWJRYRQUh1sYMlBKz978/eY34rJrxGdmDjjwul9UFuOTpfalnZHRlwMF
 zCdG1hiu1lKJyZFqU1tCWNN1ZdjsLPWxPGmRAtKvWzcx0JAyimJM2ZIza4M1FNXm1GvaHYwAxoi
 xHJPTKMF0I0un17O7H1KQ037vHIEQF9gAYaydzDyHJxZUQm+lXKVGRuL8SI9Pcqj1uzTKBX5WLg
 Voh13XzbBg3fftVOtOdLaCo590NeqSewQyaA7ljCVBBVEN18j3+UruxCXZIsiqzrPUtCG2t2R1Y
 EBXJtgOwCT5EbL6Q7Arw5NJTn80yik/6LvfeI3553KPiGiQsqeGEOFnRw9GhYWyiGhug0a9GJra
 HlR+Ulu2ec=
X-Received: by 2002:a05:600c:5295:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-488fb77d12dmr373606065e9.16.1776938823695; 
 Thu, 23 Apr 2026 03:07:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm477734345e9.11.2026.04.23.03.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/microblaze: Compile cpu.c as common unit
Date: Thu, 23 Apr 2026 12:06:10 +0200
Message-ID: <20260423100612.27278-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In order do build cpu.c as a common unit we simply need
to use the common version of "accel/tcg/cpu-ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.c       | 2 +-
 target/microblaze/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 639f46b525e..04d31536888 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "hw/core/qdev-properties.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "exec/gdbstub.h"
 #include "exec/translation-block.h"
 #include "fpu/softfloat-helpers.h"
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index add3e6ca9f9..2ce50f35397 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -2,6 +2,7 @@ gen = decodetree.process('insns.decode')
 
 microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
+  'cpu.c',
   'gdbstub.c',
   'helper.c',
   'op_helper.c',
@@ -10,7 +11,6 @@ microblaze_common_ss.add(files(
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
-  'cpu.c',
   'translate.c',
 ))
 
-- 
2.53.0



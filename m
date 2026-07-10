Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7535CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PV-0007b9-Cb; Thu, 09 Jul 2026 22:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PT-0007ar-Jh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:15 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PQ-0008NF-Qh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:15 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8487b7b4066so23699b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652171; x=1784256971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CP7TwNMhGsAYzkErI7A9pqhNKpJqLZ/PiwwiYKqhgh4=;
 b=acWJuBTCC3q1pzGnyi2lqD9KoeecDz4fBtYti+LduZdUMXUoA7OCkgm1UgkNyUUoLG
 EdZp4fmHoCSEeDEYLHBALV4vzdhH7KyI03xuBKNkftmBJSA2ant4GzcYA5vRZnamLp4u
 zBr0KvY87mQGKWfXl/KgjEG5Py3ABiEVjNePDEFdx8d80T02MV42JAnvu2isa+zde07W
 ATQwQuWlgyOUliSn9ayXPGw0Qd3JEYgsKjElDDj35viDqomkoP2DS7B2J8gBgUyHzg+W
 sZ2IQWTTTLXT9zVQPF5rhc+MynvCygr0whVaLrj2G0iLdllUErEWTNP0zmIrl+8voK6v
 TL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652171; x=1784256971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CP7TwNMhGsAYzkErI7A9pqhNKpJqLZ/PiwwiYKqhgh4=;
 b=Jd6yYA+36gLuCUx9A833/zJGXS/6gEW32fgVfXSfmzI/SZXoFnVZAgqt75kUXuB1WS
 XW7EcULCuD5gfMAj1dGAlGINsTJA0nIWGbexjdvf4ChsmcPP8olW3EA3QgaNDjRUp/7m
 R5oYwCfEnHkQTo5OJTYNS7DCDAH4/hJo97y9X3tJYlYT/7VX5G2PjBLMoWCUAd02h32n
 ztCnOwAHihKneXiIT/lE6RDzlPFAPpOZGzTlwlVr/+9hxFN3Vmocru+ldB1eYfgEEGi1
 0K91/WnchpmTFmiGpubTrUKRB7MsPBrQ347pNeznfHfHUe0xxy4rHAMuO9HiplBmTFWR
 1IQQ==
X-Gm-Message-State: AOJu0Yz/qHUsHecBRFni0u9LP0m2lZV2r1eSbunH0MTbpr/a3JDhp78d
 5VMj3rj3m+TJ63UOgcgR9F2xSu6RD1XIJrB202F7Ir26FCNemg2z+SCIuttOxw==
X-Gm-Gg: AfdE7clYgPr7RICU1skoeGYHesHCEQvSVNN2anzWF4uJE1NWZrHW3T6/m+02nVtv8Mq
 zEfDHvK2n0ievwF/Dgp30IseQXPNFKoguvuIe1dRyrZ7NXG+Lo25ZDZ7HEKiOnv7JlJFD38Y1Z+
 p+2E3XoGqEEnQEN3ZZbTpmgTK4JUpxjkSTKKDweB46CmMGOdewocNpLalk9S1AiAIFhiBGE2lRe
 PqDDW5CZb0i7eG2TSCOjIM69p90S/kdUKmOHBPfP6+zxn63HKmMBE6KXghOD7/kHIlQrCBIkPtJ
 30Kl1yvyD2spWqlGxvb3s6hiC+q5ALWQ2780XaULGY7F5j+dXQ5/24frvXCJL+54Fa7gGHnEuL2
 cV7nNARnU0/YqvehHm/NPk8N4c1Fp3cxserv2JCkRpW5K7XlDo6cX/xdPm/Tb8bOeKRE4kLA/je
 BWzV+n4r2aOTHwKT51Jj1M1O7v9LHf5T8=
X-Received: by 2002:a05:6a00:1251:b0:838:127d:a167 with SMTP id
 d2e1a72fcca58-84842fe9fbcmr8685517b3a.16.1783652171373; 
 Thu, 09 Jul 2026 19:56:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 10/40] target/riscv: move TCG only files to tcg subdir
Date: Fri, 10 Jul 2026 12:54:55 +1000
Message-ID: <20260710025525.1704417-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We have *way* too much TCG-only code hanging around in target/riscv,
where ideally we would have things that are shared between accelerators.

We'll follow the example of other targets like i386 and loongarch and
move everything to the tcg subir.  This will not only cleanup target/riscv
but it will also expose what is common code but it's buried inside a TCG
helper.

We're leaving some stuff behind because these require a little more
case to not end up breaking KVM.  We'll take care of them next.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260703180538.3346781-5-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/{ => tcg}/pmu.h                  |  0
 target/riscv/{ => tcg}/vector_internals.h     |  0
 target/riscv/{ => tcg}/bitmanip_helper.c      |  0
 target/riscv/{ => tcg}/cpu_helper.c           |  0
 target/riscv/{ => tcg}/crypto_helper.c        |  0
 target/riscv/{ => tcg}/csr.c                  |  0
 target/riscv/{ => tcg}/debug.c                |  0
 target/riscv/{ => tcg}/fpu_helper.c           |  0
 target/riscv/{ => tcg}/m128_helper.c          |  0
 target/riscv/{ => tcg}/mips_csr.c             |  0
 target/riscv/{ => tcg}/op_helper.c            |  0
 target/riscv/{ => tcg}/pmu.c                  |  0
 target/riscv/{ => tcg}/th_csr.c               |  0
 target/riscv/{ => tcg}/translate.c            |  0
 target/riscv/{ => tcg}/vcrypto_helper.c       |  0
 target/riscv/{ => tcg}/vector_helper.c        |  0
 target/riscv/{ => tcg}/vector_internals.c     |  0
 target/riscv/{ => tcg}/zce_helper.c           |  0
 .../insn_trans/trans_privileged.c.inc         |  0
 .../{ => tcg}/insn_trans/trans_rva.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvb.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |  0
 .../{ => tcg}/insn_trans/trans_rvd.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvf.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvh.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvi.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvk.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvm.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvv.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |  0
 .../insn_trans/trans_rvzicfiss.c.inc          |  0
 .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_svinval.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xmips.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xthead.c.inc   |  0
 .../insn_trans/trans_xventanacondops.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |  0
 target/riscv/meson.build                      | 16 ----------
 target/riscv/tcg/meson.build                  | 30 +++++++++++++++++--
 50 files changed, 28 insertions(+), 18 deletions(-)
 rename target/riscv/{ => tcg}/pmu.h (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (100%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/csr.c (100%)
 rename target/riscv/{ => tcg}/debug.c (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/mips_csr.c (100%)
 rename target/riscv/{ => tcg}/op_helper.c (100%)
 rename target/riscv/{ => tcg}/pmu.c (100%)
 rename target/riscv/{ => tcg}/th_csr.c (100%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)

diff --git a/target/riscv/pmu.h b/target/riscv/tcg/pmu.h
similarity index 100%
rename from target/riscv/pmu.h
rename to target/riscv/tcg/pmu.h
diff --git a/target/riscv/vector_internals.h b/target/riscv/tcg/vector_internals.h
similarity index 100%
rename from target/riscv/vector_internals.h
rename to target/riscv/tcg/vector_internals.h
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
similarity index 100%
rename from target/riscv/bitmanip_helper.c
rename to target/riscv/tcg/bitmanip_helper.c
diff --git a/target/riscv/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
similarity index 100%
rename from target/riscv/cpu_helper.c
rename to target/riscv/tcg/cpu_helper.c
diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helper.c
similarity index 100%
rename from target/riscv/crypto_helper.c
rename to target/riscv/tcg/crypto_helper.c
diff --git a/target/riscv/csr.c b/target/riscv/tcg/csr.c
similarity index 100%
rename from target/riscv/csr.c
rename to target/riscv/tcg/csr.c
diff --git a/target/riscv/debug.c b/target/riscv/tcg/debug.c
similarity index 100%
rename from target/riscv/debug.c
rename to target/riscv/tcg/debug.c
diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
similarity index 100%
rename from target/riscv/fpu_helper.c
rename to target/riscv/tcg/fpu_helper.c
diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
similarity index 100%
rename from target/riscv/m128_helper.c
rename to target/riscv/tcg/m128_helper.c
diff --git a/target/riscv/mips_csr.c b/target/riscv/tcg/mips_csr.c
similarity index 100%
rename from target/riscv/mips_csr.c
rename to target/riscv/tcg/mips_csr.c
diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
similarity index 100%
rename from target/riscv/op_helper.c
rename to target/riscv/tcg/op_helper.c
diff --git a/target/riscv/pmu.c b/target/riscv/tcg/pmu.c
similarity index 100%
rename from target/riscv/pmu.c
rename to target/riscv/tcg/pmu.c
diff --git a/target/riscv/th_csr.c b/target/riscv/tcg/th_csr.c
similarity index 100%
rename from target/riscv/th_csr.c
rename to target/riscv/tcg/th_csr.c
diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
similarity index 100%
rename from target/riscv/translate.c
rename to target/riscv/tcg/translate.c
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/tcg/vcrypto_helper.c
similarity index 100%
rename from target/riscv/vcrypto_helper.c
rename to target/riscv/tcg/vcrypto_helper.c
diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helper.c
similarity index 100%
rename from target/riscv/vector_helper.c
rename to target/riscv/tcg/vector_helper.c
diff --git a/target/riscv/vector_internals.c b/target/riscv/tcg/vector_internals.c
similarity index 100%
rename from target/riscv/vector_internals.c
rename to target/riscv/tcg/vector_internals.c
diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
similarity index 100%
rename from target/riscv/zce_helper.c
rename to target/riscv/tcg/zce_helper.c
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_privileged.c.inc
rename to target/riscv/tcg/insn_trans/trans_privileged.c.inc
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rva.c.inc
rename to target/riscv/tcg/insn_trans/trans_rva.c.inc
diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvb.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvb.c.inc
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvbf16.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvd.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvd.c.inc
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvf.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvf.c.inc
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/tcg/insn_trans/trans_rvh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvi.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvi.c.inc
diff --git a/target/riscv/insn_trans/trans_rvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/tcg/insn_trans/trans_rvm.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvm.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvm.c.inc
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvv.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvv.c.inc
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzabha.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzacas.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzalasr.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzawrs.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzce.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzce.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzcmop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfa.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicbo.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicfiss.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicond.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzimop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_svinval.c.inc
rename to target/riscv/tcg/insn_trans/trans_svinval.c.inc
diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xlrbr.c.inc
rename to target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xmips.c.inc
rename to target/riscv/tcg/insn_trans/trans_xmips.c.inc
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xthead.c.inc
rename to target/riscv/tcg/insn_trans/trans_xthead.c.inc
diff --git a/target/riscv/insn_trans/trans_xventanacondops.c.inc b/target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xventanacondops.c.inc
rename to target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/tcg/insn_trans/trans_zilsd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_zilsd.c.inc
rename to target/riscv/tcg/insn_trans/trans_zilsd.c.inc
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..61874ed0af 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -16,31 +16,15 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 
 riscv_ss.add(files(
   'cpu.c',
-  'cpu_helper.c',
-  'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
-  'op_helper.c',
-  'vector_helper.c',
-  'vector_internals.c',
-  'bitmanip_helper.c',
-  'translate.c',
-  'm128_helper.c',
-  'crypto_helper.c',
-  'zce_helper.c',
-  'vcrypto_helper.c'
 ))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
   'pmp.c',
-  'debug.c',
   'monitor.c',
   'machine.c',
-  'mips_csr.c',
-  'pmu.c',
-  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 061df3d74a..5684fcf985 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -1,2 +1,28 @@
-riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'tcg-cpu.c'))
+if 'CONFIG_TCG' not in config_all_accel
+  subdir_done()
+endif
+
+riscv_ss.add(files(
+  'bitmanip_helper.c',
+ 'cpu_helper.c',
+  'csr.c',
+  'crypto_helper.c',
+  'fpu_helper.c',
+  'm128_helper.c',
+  'op_helper.c',
+  'translate.c',
+  'tcg-cpu.c',
+  'vcrypto_helper.c',
+  'vector_helper.c',
+  'vector_internals.c',
+  'zce_helper.c'))
+
+
+riscv_system_ss.add(files(
+  'debug.c',
+  'mips_csr.c',
+  'pmu.c',
+  'th_csr.c',
+))
+
+
-- 
2.54.0



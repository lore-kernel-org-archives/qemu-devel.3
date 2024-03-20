Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E7C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqMC-0006Bu-UI; Wed, 20 Mar 2024 03:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqMB-00069d-87
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:27 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rmqM9-0003gK-QE
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:27:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e704078860so3400849b3a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710919644; x=1711524444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOaigCZs+BnuWhUv4wDibuU2PGEb2drtLYE0whFxmy4=;
 b=QejeSH5xKWtLJAhqwxSd9Q+8TjVfdfDmBjs1S2OKJwj+9FIoSskJ/UuqGai5Ue0W9B
 KR3XDpnUbcjKGJbRUzWtU0WSXIkAV8LW4MN1h/TyluEPsLuOwgx+HIjl9JEQ4O02zST2
 PqkkQ9Rfb/X0frJujZcXmFDnrBcU/c6YfKHeYjh3yQ2vD8WBZNcwlwj3WZNdftTyJFLY
 SsjPP0g1xtwYIp5AouXNxlzWWRxi8/+43NE6JYitZgytH09V2P7CRx4rSduUTsVdM5aS
 /1cIQwMdRPZbsh+jrQiCH4wmkrMb3/IAKFBBoOEpkzYybtCw915Nxg3jFZSM1/55oXnu
 MHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919644; x=1711524444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOaigCZs+BnuWhUv4wDibuU2PGEb2drtLYE0whFxmy4=;
 b=LHTAoEthW5N56/vS5GSPVJstUBmeYiz1EFdybmh2KMUblWArQOLIzniPRU7clN/d/W
 L8gVuxnT7o0XBgFgQz+h7tqLsRhOkn8Me2lEiC7FNPqhq8r0BSCdGuQzWXRVgxkNBiXq
 pX9ixSoAOLeKVJNKbOvDx1P4+ImPlBWHzWnx1feWr8kOSekmRayhazCsT2QOzeCUU9sP
 wleY0oePv/OTQKukr5Bazb1Zolf9o7ziPy46IWZwKdjTrJv+SEIt3y/kAPHK2iRTCsue
 B+gsTjGjs6LTvmJrVumpS2DRibkLTou2JKbG52yJW4F6A1tCCvs5I7njFVpkqdGNsac5
 GRRw==
X-Gm-Message-State: AOJu0YzKQ/LfwBxtIQZgMrd96uQUxaZblqiJx8A83FtLyVD1/DAFay/k
 c2ozar4+5yB+Mw5CZ7qtkJmXC9XSEhYjz1o3GxuMZeA3dB6M6FgTVR59n27OGaN+vTmP8MybdBZ
 msS9rM5jhgjpL8UBT7/1ZAyGgVuX9DWJYSf8oqKRSvGumKNgPiH2CGPWewsbP7OKyHcu6iEEGiM
 A+I/5370GkuGdkQm7zqh/a5DQViYKnjFDW9wvUOQ==
X-Google-Smtp-Source: AGHT+IHBNdXqFDMQnnF0XTcwB8TlA80BiQWdbrYGg9WH5g36TNXw4R3rKHVWmaOk+mHNv+ktXykx1w==
X-Received: by 2002:a05:6a00:1805:b0:6e6:830:cd13 with SMTP id
 y5-20020a056a00180500b006e60830cd13mr20201631pfa.23.1710919644204; 
 Wed, 20 Mar 2024 00:27:24 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 p10-20020a056a000a0a00b006e6b45debe8sm10811376pfh.78.2024.03.20.00.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 00:27:23 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/riscv: rvv: Check single width operator for vector fp
 widen instructions
Date: Wed, 20 Mar 2024 15:25:03 +0800
Message-Id: <20240320072709.1043227-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320072709.1043227-1-max.chou@sifive.com>
References: <20240320072709.1043227-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The require_scale_rvf function only checks the double width operator for
the vector floating point widen instructions, so most of the widen
checking functions need to add require_rvf for single width operator.

The vfwcvt.f.x.v and vfwcvt.f.xu.v instructions convert single width
integer to double width float, so the opfxv_widen_check function doesn’t
need require_rvf for the single width operator(integer).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index ef568e263d..6cb9bc9fde 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2331,6 +2331,7 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
 static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2370,6 +2371,7 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
 static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2402,6 +2404,7 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2441,6 +2444,7 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
 static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
@@ -2941,6 +2945,7 @@ GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
 static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_widen_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.31.1



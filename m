Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3329FCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGy33-000581-Aw; Thu, 06 Nov 2025 06:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy2z-00056y-Fw
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:20:57 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy2x-0002mY-Et
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:20:57 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c28ff7a42eso262458a34.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762428053; x=1763032853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTKxVuBCxwnHszyRkY/kZ8dOE4K+EhtgSC9uwTs5XNk=;
 b=dOLkwVT2vKr9jpsqNWxcDMF5YsK+4KC1zZ2ARfz5TnQaMt2bKflytS8DNkpwszKV7P
 W4zm91OhXh/a15QX5a+PABSwEY1I02rh40E7Ig00gagSnDq+EI+Kxq+ZRDcVQTJDAqUb
 nf/4zhRRU2NAA+mhElHYKYkihv3TdXrtoJwhRAZ7PIa1dlO/kL4OretuPRXmDYkDhnWs
 vOJnO2/fvV0sKJ5OKzXDp6wC4WmLGImMEUtkIVKWy8u7DB5mBHoIhqB8FsMDC5PmVmy7
 WzVrtRTWrmPa2R3B/jKMqqRcfV9I7U6PypJyu1C8TAAbUcyBz0gRl3nlM7MT5Lcg2U8d
 y2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762428053; x=1763032853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTKxVuBCxwnHszyRkY/kZ8dOE4K+EhtgSC9uwTs5XNk=;
 b=R5uHrk3/dVJ7SZuOI+StUgJL22kYFonh0MT3cc2d9XnzaozrZnxF7SXX5OJcmZ90SN
 MgRba7Q857T7jqig5SK/ApGXUTJSSMTo6zOS9JeegP5bodEI45z+fdAiGTSDtCkx8LF7
 RO1Np2gbL4GLfgsfZ3c3JdyPvLBEdssZM4HsK/O7k3FtlfhsDeb92uYld6+CH7Ih5wrD
 iBozXfnRzo+eEc2Bp9OaR4YazazxEyE01qLGrJfy3PRc2TiMsWDKDu3IdSkY8hHrD3J9
 KD8tRCqd6G/zFz10UUoVxcntrnnlwotg+T4AfMxNMXAFd2gMDX4ZjFwj8M6wqOITRlJk
 +3vQ==
X-Gm-Message-State: AOJu0YzEDY446XkTZKG4b+gZ+twERW6/XHgigKiLjnaR+ZgZh+LRw092
 kAzDrZf/s8ScVX1leRUeoFfMII5yI5Yj305xvG32gvpTxpgRQxAQbI4bXFzPn3F45a85sJe8NpZ
 Tb8G1fi0=
X-Gm-Gg: ASbGncvoW6CNxdmbCwCLffO7lXgQ50rK7zxSvOIFnQkAzbf1CVDJqYpkBjKryXm3Whj
 5mzXQogc/JpR7er9OSN+EZ31+tJ7v2EMm3bl00DwIvO1WR7nRU3hf7pOG2Y280jp2bC+xtpQski
 u9R/HRPgjUHvLfTReL/dhMvZPo8zAPj8LMKONjIfjwYufOWRIZqJVp6UoNVmd0TsJhsCgrER1KL
 T5gwb4YPR6Ou7aglC1nRjAojkb8amkubpCpp868sIjkUZV8Dn0nVFxp2+efQHoXBhV++s15rsAz
 Azwgkn7Rz2EAUEU3+RMwYh+iievkuhtxwBXlQUnlNtKS9XBL9gInLtQZvPIN2qymBO6Gl9aNUCy
 IIumQxSKPD6rUo6jaNRH5sHRawR+S1rsOtRaAkrqxXR/zp3Uo2lBPL/ePEN1joggHA6rU1Flkct
 hov1uH7yvKRMyhB4NCN+HInI5TCxcBX7PM+/ejPuvT
X-Google-Smtp-Source: AGHT+IEwHypvZbtNJ6lXuGCnU9iF/ApoFgmdZ2VxFZBA/pLYgJ2XS0DZk+I6/+h4gc8gQNPGV+nuAQ==
X-Received: by 2002:a05:6830:7110:b0:7c5:3e44:1903 with SMTP id
 46e09a7af769-7c6d1449007mr4649318a34.25.1762428053457; 
 Thu, 06 Nov 2025 03:20:53 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc2:7873:e847:e589:d030:667d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e30a439b97sm932716fac.16.2025.11.06.03.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:20:53 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv/cpu.c: isa_edata_arr[] ordering fixes
Date: Thu,  6 Nov 2025 08:20:43 -0300
Message-ID: <20251106112044.162617-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106112044.162617-1-dbarboza@ventanamicro.com>
References: <20251106112044.162617-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Yet another patch to fix the ordering of isa_edata_arr[].

The ordering errors was found by a python script that we'll be adding in
the next patch to, hopefully, automate the ordering of this array for
us.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae8b721e55..79fda08f9d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -114,8 +114,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
-    ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
+    ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_zifencei),
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
@@ -138,9 +138,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zdinx, PRIV_VERSION_1_12_0, ext_zdinx),
     ISA_EXT_DATA_ENTRY(zca, PRIV_VERSION_1_12_0, ext_zca),
     ISA_EXT_DATA_ENTRY(zcb, PRIV_VERSION_1_12_0, ext_zcb),
-    ISA_EXT_DATA_ENTRY(zcf, PRIV_VERSION_1_12_0, ext_zcf),
     ISA_EXT_DATA_ENTRY(zcd, PRIV_VERSION_1_12_0, ext_zcd),
     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
+    ISA_EXT_DATA_ENTRY(zcf, PRIV_VERSION_1_12_0, ext_zcf),
     ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
@@ -166,8 +166,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvbc, PRIV_VERSION_1_12_0, ext_zvbc),
     ISA_EXT_DATA_ENTRY(zve32f, PRIV_VERSION_1_10_0, ext_zve32f),
     ISA_EXT_DATA_ENTRY(zve32x, PRIV_VERSION_1_10_0, ext_zve32x),
-    ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
+    ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
@@ -190,8 +190,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
-    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
+    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -201,11 +201,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
     ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
-    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
@@ -213,6 +214,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
@@ -224,8 +226,6 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
-    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
-    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
-- 
2.51.1



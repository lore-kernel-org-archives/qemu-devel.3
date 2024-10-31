Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85335E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MHR-0002Pz-IX; Wed, 30 Oct 2024 23:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MH9-0001uM-JX
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MH8-0004Cs-1a
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:55:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20caccadbeeso5506035ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346908; x=1730951708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ur8LYWZRvT+qQvnT17XmswKRLf3qm8o1ZqFivpailak=;
 b=In+lEud085vvdhCIbTT/Ne3n2e0SNyGkzRvySVCPOp4Zo1Ybx+SoKxxFg6yqzPPVvf
 wZpZ+YNVdWA2GSMYzF3oaTUbahqt+f5BK1Dg4vGVGoLDIJOgeRTnYF+4fnZex0xQrkKA
 VXM/9GxFVr0hR79BFW+UCSVxPDCZPsFdzd51QzaEsxN0vhePcVkKFXKRrfdQZYFXugIN
 9rWcmFicaHRdbILOotYno2LlsY9oGsi4DPYNFSeA6MQHFkxkiL6edV3GXkIdnPEyPDJh
 Lt7IhpJgmGHTg7+WXE1woNGpur3Oez4voINAWNN41ToteGMuavfjEqiFnVJ8i/og2Jo6
 Wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346908; x=1730951708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ur8LYWZRvT+qQvnT17XmswKRLf3qm8o1ZqFivpailak=;
 b=NzVRcs9qsGZYQTXEZg9j33lq2U55N4HPShRxHEPweP5s6YCBdu71ZQ7iH9OQywdPcK
 7jPoRdAvxQOCS64fPO/sUkFn1LxTkQrzIq4t6SREURP3XlJSZzmcxcEXHkd41jf/98qK
 QzptjEgYzaDJGg3lcOXnUIcckLEPZTG6Ao8ewOiYAC7X/VGoN3aB/lFrqsUwLrFjr5M+
 1mpAa+HCRAxj/o7t1VNbx23dXx6FutLJHtafm67QbrOgsoPN/I5jJGuO8oC7MqkFntNu
 MbkMxr9bVVS9PcnSa+afOHWn6sMASoyCWBW2+wxKzOMyyC+VgR5GNK+xfu9/igMzfeyQ
 J19Q==
X-Gm-Message-State: AOJu0YwBDx+Mxajj1bH6kcX9d/1AWYZ1r6ze2UdWZCe8epllZXtsf6OT
 bsEwm1fiIOvLMFL0EbMqDd+aY9j1+AbDobvmo3rzczjBrGZhy1T/vNKjV5Vq
X-Google-Smtp-Source: AGHT+IG5aV07CAXxuDbawFMLZu2NWexQGFkYx6nfvRKoS5WemIGOtqNw57TSBM4NN0WynF54KyO4Lg==
X-Received: by 2002:a17:902:d2cc:b0:20c:5404:ed69 with SMTP id
 d9443c01a7336-21103b1de3emr24240595ad.31.1730346908512; 
 Wed, 30 Oct 2024 20:55:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:55:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/50] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 31 Oct 2024 13:53:00 +1000
Message-ID: <20241031035319.731906-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Deepak Gupta <debug@rivosinc.com>

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241008225010.1861630-18-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.47.0



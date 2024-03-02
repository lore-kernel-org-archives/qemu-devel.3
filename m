Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCB3C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHje-0002TA-Vt; Sat, 02 Mar 2024 00:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjd-0002Sd-EB
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:33 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjb-0007WE-Fn
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:33 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e58a984ea1so2075917b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356590; x=1709961390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8HyamXhbkNWazMUAhxBGWQB1mar+xWfEVCvqZkv23k=;
 b=kWuRIlY1kecl596CAO1HFovaTx221835Zxq6zazEO/5dmyq2jw8Dx9VYNTuLdAnZAL
 zH2PKluOVPDwJXs4pKkzmO6YwZiYn7hDZm/6MOIdvZEWfZEN1kBuA0AxZNS9+9Op/GYZ
 jF1DnetI01lZq3vBZg/qQjdjoipKYljUUP7PTpTTRWbTECvvtZ3GOEBujE/Nj+fMMxv/
 ro/kR2fC8L8Iho8fVBnJ+q5Ag9Y7uM6zwG/PFzdcRJzPFUq3KImCECW0VeqYJ7XYDs3W
 fmgxd2IplM2KdyGIiVfpOWhQa359MN90H7SZRPNeiF8QHKg6FiqJE5AhwRfESdSkS7dJ
 /QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356590; x=1709961390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8HyamXhbkNWazMUAhxBGWQB1mar+xWfEVCvqZkv23k=;
 b=GjOBWRLFlb+LQq2ZO7iosJlqjFq5Tk6OrsBpGh9hUq3oY/AS0MeqhVTz7VYIP+/sgO
 opNjndkXCgOS7/jAx0C6l5NgUxVv8seFYRQimEqELbYVn7zrTT+3dnEqirHrpMaWJIx1
 0mg9NoUdB1bHF6lUDZwmSv5yHfbU9wMYGrkUcm8cn3qMO8PV3XA+pPhriFfKnbsf4f/l
 l21vHqj6CrZv3fZJ53cfFuu5QaAL6rPmhHA1MkviNpsXcuq9N92QReMz0K//ZNVakuEY
 MflPH5EmntODoIsXend3YvylhO4aPrtnPAFjK7o/VObab3+SkY4rigIThawM4g+FhMlw
 lrqQ==
X-Gm-Message-State: AOJu0YyOF8NT6UGl8cZXz2EfZpPnznhK5q1SgCkG07iVFjWOemwsP/SS
 g5gMY74GwmuBhPfoaYmZNjXKFB6OvICDecgdXUHrw4WzUlgURVGFP9hgQkAuzZfIX7ceymNBOcK
 N
X-Google-Smtp-Source: AGHT+IGru1M2TTtLqeea0/LjDsQDN+q889BWGQqj2b31BTDUdTITEf1jLCt6tsjiLo+m4X2vUiSsDA==
X-Received: by 2002:a05:6a21:339f:b0:1a0:e3c7:963d with SMTP id
 yy31-20020a056a21339f00b001a0e3c7963dmr3626858pzb.23.1709356589877; 
 Fri, 01 Mar 2024 21:16:29 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 14/41] target/sparc: Implement ADDXC, ADDXCcc
Date: Fri,  1 Mar 2024 19:15:34 -1000
Message-Id: <20240302051601.53649-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 14 ++++++++++++++
 target/sparc/insns.decode |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0ebb9c3aa9..0b6d92d0a8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -442,6 +442,17 @@ static void gen_op_addccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_addcc_int(dst, src1, src2, gen_carry32());
 }
 
+static void gen_op_addxc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_add_tl(dst, src1, src2);
+    tcg_gen_add_tl(dst, dst, cpu_cc_C);
+}
+
+static void gen_op_addxccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addcc_int(dst, src1, src2, cpu_cc_C);
+}
+
 static void gen_op_subcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
 {
     TCGv z = tcg_constant_tl(0);
@@ -3673,6 +3684,9 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
+TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
+
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
 {
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6d5fa26e90..07796b8fe2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -376,6 +376,9 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
 
+    ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
+    ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
 
-- 
2.34.1



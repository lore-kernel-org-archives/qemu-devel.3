Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF086CEACE4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK2nG-0007o5-RD; Fri, 14 Nov 2025 18:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mE-0007Gn-O7
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:31 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mC-0004b8-Sd
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:22 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-4332381ba9bso23885385ab.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763161219; x=1763766019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnAX0+EnRAJr676o/PiOZ16BLN9mB74861g8sJCRKgw=;
 b=aii6V3BhhZPUg7uZqt2ynjWEPhXeDDg1BqVsJ2svjC6NL+UHXEdysBI1j8JXoCCpwe
 kHHckhGA5j6rb/HJQeT5uL6WFB7Tp+r/emwfahEFa34KmMC3mQJ96eF0Pi3NlSRHYClr
 tVakC0wMf4wNIAvJWJ6lBCgGiqc4oc/IAWZ2GRRLI0W4KpdI5JVRNPGqQqpE2dcjL3kW
 HGm56Ffz9eP+n5LX414kYJ+GEn+SkApIH53N2qJPlvE8anwkxEfZLjOMCPZk/NbuCB1n
 Lj5Is+uGuL+pSgr6RDPx2gE2fmOuSLd4/rfS/7YCoAwQpKprliRGlXKrGth4hMriC0RU
 cOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763161219; x=1763766019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnAX0+EnRAJr676o/PiOZ16BLN9mB74861g8sJCRKgw=;
 b=jxYlpCYoqmJtpKbJvj3Sod15+K6OUPg/vEP18YLLwxUDSPhYscJk3fHKYmTHswf6Yj
 l1g8S6yiYDaEeMp57DKblbaRfSDq1dLaUcFOj23DMJuxwuh/a1fueGFDmr1yp2ejuzu1
 hQQIEdA31r+eWJU1uGwUWMjWnSCz69hAU0r9+5/fwMyJREfgwn9oBGrziHk9o4RJCQLT
 XFzFxpa7GI2+9KdA3/vUe0cHQogQDuJ8RTYC3HAewIkR9mrK60Ji4PPbYIpZP8X68Dfa
 NIvmnNLiMcF+3m1jRfygLFF+BTppA1IcNvxWVhPJA7HJVt8gJUMVo1C1ljS6D4Q3SbUF
 bqyA==
X-Gm-Message-State: AOJu0YxIL+6Uk1vY5qrVgM5OzrThJUo4XyYLskNnjIsMaPv33FcOXnZw
 n5n8H9MiJ40bjFLTrUJo/2nfXyqM2wzvjp7HuDKPcIdxJGk++sFv+VRjYFRUkkMQ
X-Gm-Gg: ASbGncvxPEcXZRdWzEQ+OcfoU+AqOpRYATaRotdDcg6XD5Htn85UxTgOD+qxmnF7WXF
 ZzLV72HPvigegss4dhI3T4RK7UEEvcYnkTZ211u8X9PNcxSBcrAl++HVFVWd9BuiHUIRFulEHD1
 UMcf+lVVekOFp4JoxpB+Z/N9ERMm9YOyeU3WnrwX2Zb6UJ5z8xJGkZ6WlXLytkjQAHaptH2aX6i
 7GNKGRadz2S19mIQMe9TUqAacSuzJqb9oLBTP04/AN9B8o8L+fqh1T5x1Nzb1zkEA1p8GGgNvP3
 6Da2dYEIXb1vFRuhGwflbYR4PIjKzrH5T1nissNYF/0fAPku4lSPA+XyTLytz98r6OKD4vg3dXd
 A8aza/u1jXZ93pyNntjShzUe00Z7js8wZZnM/WyxR3r2b589CX85OztjsUDwvKXizgqhzA8Msjp
 7WC1Ba+fue35HqN3pFHG5vGtFAAfQZeuJrpVtE8p1qteqKyD3SZrAkV3kfoOFZoOISpdTRN3OcQ
 bBd
X-Google-Smtp-Source: AGHT+IHOqeMLhB1mYuz+MnTkGV6DDhnKSk/F1lswSVV/ijt5FvWPothcCjD/Uuza9XuQOw/xH7it9A==
X-Received: by 2002:a05:6e02:1749:b0:433:575b:9e93 with SMTP id
 e9e14a558f8ab-4348c949985mr70783655ab.25.1763161219471; 
 Fri, 14 Nov 2025 15:00:19 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm35673075ab.15.2025.11.14.15.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 15:00:19 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 3/4] Hexagon (target/hexagon)
 s/gen_log_vreg_write/gen_vreg_write
Date: Fri, 14 Nov 2025 16:00:12 -0700
Message-ID: <20251114230013.158098-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Note there are two functions impacted
    gen_log_vreg_write          -> gen_vreg_write
    gen_log_vreg_write_pair     -> gen_vreg_write_pair
These functions don't "log" anything, they just generate the write

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/genptr.c      | 8 ++++----
 target/hexagon/hex_common.py | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index bfbbd61c33..616db17907 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1174,7 +1174,7 @@ static intptr_t vreg_src_off(DisasContext *ctx, int num)
     return offset;
 }
 
-static void gen_log_vreg_write(DisasContext *ctx, intptr_t srcoff, int num,
+static void gen_vreg_write(DisasContext *ctx, intptr_t srcoff, int num,
                                VRegWriteType type)
 {
     intptr_t dstoff;
@@ -1190,12 +1190,12 @@ static void gen_log_vreg_write(DisasContext *ctx, intptr_t srcoff, int num,
     }
 }
 
-static void gen_log_vreg_write_pair(DisasContext *ctx, intptr_t srcoff, int num,
+static void gen_vreg_write_pair(DisasContext *ctx, intptr_t srcoff, int num,
                                     VRegWriteType type)
 {
-    gen_log_vreg_write(ctx, srcoff, num ^ 0, type);
+    gen_vreg_write(ctx, srcoff, num ^ 0, type);
     srcoff += sizeof(MMVector);
-    gen_log_vreg_write(ctx, srcoff, num ^ 1, type);
+    gen_vreg_write(ctx, srcoff, num ^ 1, type);
 }
 
 static intptr_t get_result_qreg(DisasContext *ctx, int qnum)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 1277fec9a2..6b683487bc 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -823,8 +823,8 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
-                               {hvx_newv(tag)});
+            gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
+                           {hvx_newv(tag)});
         """))
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
@@ -915,8 +915,8 @@ def decl_tcg(self, f, tag, regno):
             """))
     def log_write(self, f, tag):
         f.write(code_fmt(f"""\
-            gen_log_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
-                                    {hvx_newv(tag)});
+            gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
+                                {hvx_newv(tag)});
         """))
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
-- 
2.43.0



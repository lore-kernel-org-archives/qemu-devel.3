Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11461606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=benbp1nq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTS-0003ax-1D; Fri, 30 Oct 2026 09:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSr-0002j9-3J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0005VW-90
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:08 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-55e0090c580so221550b6e.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366163; x=1793970963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgqHmLtxUI+2J2wQe5DSkZKh5v8ZwaNLONboGey2duQ=;
 b=benbp1nqL3fhxu5dz+sAHjIfMvkjyiM/M4FPJLzdUdTnA1h+ntYLGEbPdSRG5th2Lx
 3JL4axkWQrTogKlVDPboGDV4BSwn+bRtLC8AC7E0nEqBg7fkDbRFTLv5u3ppnO22ccj0
 mmfzRzTN+TVBah4RXiKRbDfzAgnIonxz+7KN+rq8hqUN/OQk3FKGXQDjyKZ4HRA7SNN9
 d14Uf8ouSaRNlyLkoJWal1z3bR8WD3nF1q1Oi9V5JRX1jGdk+x8hK/H9GazKFcah7W1s
 RTfz9p9CCbhYVo0umfrM7hwvKkvog5awTypkKgDQloMuS1xHGQeZS48Rf99BDzzj80hC
 O7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366163; x=1793970963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgqHmLtxUI+2J2wQe5DSkZKh5v8ZwaNLONboGey2duQ=;
 b=B6YVEZg3VeXAlyUxN5DstO6PZpmBC6CYG3N4ZnQGhbs+jU/PbDH1IaNcmd6nFhP3Vl
 OtKGsaqReZQZw8gucGt+UaRBSFRdKYNYjDK31KwJUcuc+Lo3LPZ2sffNkEimZ+7tH1AL
 IjzA7evr4HBIIcGvK2bx7xgpNEyKhIf5cEWfotUZgNMz0MDWPMBo+2qY+PudEwjneN5E
 hHZDWOra1bI2K0tkasg8/HICduQkWiUNigD5Nly9PfVH9jWn9s7pduPakodUJk+BLdK1
 ku5fWPMerCI00IlL0ikphomUJp7Sv35yGaxwU5ByT/d4JnYD6FgQJjyxEb06TdmaOMIJ
 mD9A==
X-Gm-Message-State: AFq9FYLT5y0QlWtfLDFqwJAB3iPF1OGbZY7NiQzNEXEv/yfUejHk4rF3
 RShS5cvqsoBj2tirmW27klPfT4vYzaKn1/qV1ULPBHIgCJ5bzNsr263J9xsiH/tNWcVxPLo1il5
 iWOTr
X-Gm-Gg: AYBFou3yiMpNyz2BrKkk5eEd0AHFUx8WNczVp9J+M5QfAb7vMRzvVaxcRh7rDbqWR9C
 SYfPAnMBGKcOde3+guK6s7yQgU/N2Pnet3txVqaRVGMLcd8ckLlmdlZG3Pp5JQIoznMSQdyFXBa
 MEKwMjfsxtAHM6N2+9BJ1FGlodm6MZ/pOU5MHo9XzgOLfUASB7UCXSx4Qm4GtCHsN5GxbmsTLMi
 F1RVWkwl+jtRXS9cALExXvu+SAcDbb538E9WEvCVhITkkwJVkDrhPe9jfekEObCekJRLeVBi9o3
 63KmcAVts9TYDhRjVoKsDpKO5XRfQ9keoPODT8oXl0gP1HnvPa+nIZdcHQb0MBvwriR49KBFycZ
 /nAMT0STrrWNSubYwwmZj31jlCb+3i3dfhrpOI0nLfC84FtW0j5N07hlBdE4jmHa77ZXkr7KFuf
 dGuKiJKzJs9gN25cqCN6P8iI0q7xV1nCVgOvTOoN8t3Rpw01Kv/8Y2ZH0VL52XNSVZ2oVvzA0MI
 VDZo/w6YoGJCs+g9iBKquKRM6RJPbjsar65HHcUn+g38Ssl5zvYzuK2qVnKSf5LyJkxX0/CasHH
 D7K6qjEzEFh/D8b0A3BFz2aJ7Ab9cts=
X-Received: by 2002:a05:6808:1a0e:b0:4e8:5ba:8809 with SMTP id
 5614622812f47-5640dd797c1mr1741195b6e.26.1793366162970; 
 Fri, 30 Oct 2026 06:16:02 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 07/19] target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
Date: Fri, 30 Oct 2026 08:15:42 -0500
Message-ID: <20261030131554.41208-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c14..6f18b8d1af 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1474,10 +1474,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x02:
             /* S4ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x09:
             /* SUBL */
@@ -1502,10 +1500,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x12:
             /* S8ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x1B:
             /* S8SUBL */
@@ -1524,9 +1520,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x22:
             /* S4ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
             break;
         case 0x29:
             /* SUBQ */
@@ -1544,9 +1538,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x32:
             /* S8ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
             break;
         case 0x3B:
             /* S8SUBQ */
-- 
2.53.0



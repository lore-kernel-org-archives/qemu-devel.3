Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FABC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYk-000537-LL; Mon, 21 Jul 2025 09:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYM-0000Kx-O1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYJ-0005KJ-JR
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so2163797f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104453; x=1753709253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nIp1SgM0w0YUcpzxsTa6KoX/eMZJ6QjBTnu86Ie5yyQ=;
 b=ID0CBs42M2bJa591kwlwCN3Fb/Gtcalv4G4dYkpJK7Rb5nZK4OBywgrniZV0Jj/ktz
 GAvA7gnY0xjAKzxaRK4db8NfZroHIq260KYxpxfi8vF+l1tz9wnXzTdxJbjIUCW9Wi98
 QCtTk2HFaSbo+gAUqE8ZWDrS5r+uFJIqKRadNcrBKpcOWod2TgSlBWeHWf/1sW3kTMMD
 TJM3kK54hBpSxUA6RiJ0EAiWKNMeH8Kn5BOlvQKu29CYEXFimPzLIErz3FX29wAeQK4u
 pWVJGLPsw/ybP2OMBGWipOxSdeovSqJSI33VfMi7h0YWYQrcl6ugRZDQ5EgVsM5QAUmX
 wS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104453; x=1753709253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIp1SgM0w0YUcpzxsTa6KoX/eMZJ6QjBTnu86Ie5yyQ=;
 b=s94fSXG6I2UDq/P/wE8O/lCXE3kOvvTNkdaEhp8/JvmFMWWc9AlOJpVyWUiIjvnDWE
 aQ336WttjrhEmr2EnpVy21r3nlTJzizleevpK49Q437YMIIyBc0kDkHkEcQYPENsNi4C
 ONMbQNt3dxCyjcVYV5qns5qpb5T2EfqP4mmgAMQWzFwPBU3BdKkHdhhCN9akGt6rtihA
 M19rRLthITZQ5H6Krq1DTGjxkXMvYQ/K233JEnyZEMxfwthJBKVb+9Ggyz+jRsEUZivI
 QxAwhRZkld5Eqs7SKcDm40Ryil5l1ASrnq1CHfQnmgw4khNADy37SEafszKwKbubYIFw
 G6aw==
X-Gm-Message-State: AOJu0YxGZYRzUqkwW6PzJj04CRYyfy0sH7uSKj2JNenpKzlGmPqo1ihS
 VcuLTU3GrFrIfg85h25qTc8djthquKIwXlkezVMvmRgZEmVvReH4UyZQVBkIJCY/E3q1Q5k1CL8
 ySSB7
X-Gm-Gg: ASbGncsQ4YAJu6QL4sR1RWt5yK4lXjDSajjBUndOBoLTxDFlE4xG0gdRtLjc2luwLZ+
 jNx8LNZVVmcrbCwZlsgp3tta2EZll1mDlCHi3VprlwOrL9kWpoh9JsQJDt6foOTIjhppOSCOcie
 A1sFzPOzOEMlyrYS87IhJKKz8er/bDn6glrY4gqPJepYy45Np77oRFDxoR0Kt4HIq5PqDqSLn+U
 Eqtj9tkdd2btmx3VUc6ck3arMh14npAfS1G3ftvsR+RAhDjs6SWU8ZDD+vlZnaajlKPk4JKv5M0
 qt6TayzPr1QV6qZ/PyFJ2aBjsYoHFbG6AVkhNyY22JlAYrEzpVshN8KvRCuXcAv8gkXwhOiq4CI
 /vQRwtEeYYU+f5W3Woj9fe0PnOfjv
X-Google-Smtp-Source: AGHT+IGAtJjUOryD8JmZZAHOMQyFlsUHbewore71K7Riv8BRKOiXtFmq5ZFf71rThKwLr25ufQrQdA==
X-Received: by 2002:a5d:5d10:0:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b60dd641d0mr19346661f8f.12.1753104453217; 
 Mon, 21 Jul 2025 06:27:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] target/arm: Correct sense of FPCR.AH test for FMAXQV and
 FMINQV
Date: Mon, 21 Jul 2025 14:27:11 +0100
Message-ID: <20250721132718.2835729-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

When we implemented the FMAXQV and FMINQV insns we accidentally
inverted the sense of the FPCR.AH test, so we gave the AH=1 behaviour
when FPCR.AH was zero, and vice-versa.  (The difference is limited to
handling of negative zero and NaN inputs.)

Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250718173032.2498900-8-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fc76624b5a1..2ed440aff15 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4020,7 +4020,7 @@ static gen_helper_gvec_3_ptr * const fmaxqv_ah_fns[4] = {
     gen_helper_sve2p1_ah_fmaxqv_s, gen_helper_sve2p1_ah_fmaxqv_d,
 };
 TRANS_FEAT(FMAXQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
-           (s->fpcr_ah ? fmaxqv_fns : fmaxqv_ah_fns)[a->esz], a, 0,
+           (s->fpcr_ah ? fmaxqv_ah_fns : fmaxqv_fns)[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const fminqv_fns[4] = {
@@ -4032,7 +4032,7 @@ static gen_helper_gvec_3_ptr * const fminqv_ah_fns[4] = {
     gen_helper_sve2p1_ah_fminqv_s, gen_helper_sve2p1_ah_fminqv_d,
 };
 TRANS_FEAT(FMINQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
-           (s->fpcr_ah ? fminqv_fns : fminqv_ah_fns)[a->esz], a, 0,
+           (s->fpcr_ah ? fminqv_ah_fns : fminqv_fns)[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
-- 
2.43.0



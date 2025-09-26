Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D51BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AA-0000uB-IO; Fri, 26 Sep 2025 10:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299N-00006l-Ak
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298Y-0005lE-Ec
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:03 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so582661f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895761; x=1759500561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yu9kzAeBPB/Ob4WL7UmKiEqwNZHTkyayHybedVgHt68=;
 b=nX7rbeX++3hDrELSc6pb4eQDNwMdBxIlLB9vbVEQJg0I4MjNZ2SxTV1FREcgRS3hPK
 DaPNRhC4zoXMkD+FI5G+SGkBamWy8tlpsGw+fZEbx9CR4EnqXDxsBtoLG9AyF+lRPir/
 R5r8O2rn3PenqRL5xyMRlmA8btacQxCZ8Mk6eXvIKo4/qHMy14UdM4dzyUbFl1++VVsU
 FP3Ya6sWG016DFDf2sxFl713XbFohlLKglUvLwZJUM/oe0dL543XHjD4mUXClRJT91vD
 tZCx1d1bmSqyb4YFV7WSQ1pTQBIq9lwd17FFP8hYoGdxAJNeXRnLXlZaOtHITN+kUTTe
 +HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895761; x=1759500561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yu9kzAeBPB/Ob4WL7UmKiEqwNZHTkyayHybedVgHt68=;
 b=XWqeFhsyQuWNa8lgwndQ1VygRsOFa0OvVQqA+m6wBDkhrl5v4jitaqmo+7sHbsymsO
 Vz3h7rFQ8pgwYwOAb0mwKYLCFgMlHkxfS3KaXvXpNDFhVvwh9RN7c3q4J5d3p37zveIZ
 vW/Ni9iQsqLFsy/MdXKXkLBhRdTvvgGBcevYlmPDEiR6VsufdwtqZQxcJRsbL7Etr3xE
 5esvL8kIaCac/G0WdzCr/Ubc128En447RNk6jzZxrkvo0/4I4ZOsfNYRuq3mmKtaaep1
 9zVUWxpdU+cKhxMRAbVd2eU2ZckQgl4ABzvA2d0RRD4alzeS2XTSY2wUokp6pC9sUdTc
 v7WA==
X-Gm-Message-State: AOJu0YwInF3o9GO2mbWAiM/QUT2Va3XXVainiBqPu11SdLFJDzbCplMd
 gK1BkgCxRQo5DvnghKDmcEZnneeqo24VjnabTOV8//ulubGKzw7LPGNaPU5i1HIg5gFGjPxXoEF
 gG45z
X-Gm-Gg: ASbGncsucTYZp+Nbtx/4t3KmffdUw8uZWq0yMKVu1nX6HJbKnbrlmzHPxlG7gJGCgGW
 ela+xEkVee925/EhS4NbSMMtNQYOAGy3mghlBb2Cs/8cmbc+DPoHULNdlHlDvUyP5saw7mAccBd
 RUIPTEPtFutTh1yJy8GOIgSJ4Ap7t1lyAO0925hluCBGPmtxmYaKJWZcQ7iYcTepqNvBEM0h4M4
 rbeC3y/p4O2TTpikx3OGmKmxpaRBytOLx0JJ0vpKOcXJ+Gb7ijW7d1esrkR32Z3kpFpi3fnn4s3
 CmPKZJkGWsGkA0Gva5mMF5cza9Zg8rDN0/+/9RXdCOGrkPq7IOYSIuRGznH+4prohbETqDOglct
 o/3lTBh+DqyY2QtS5etXTH5bSayZG
X-Google-Smtp-Source: AGHT+IEtv8TeNmS12Yjc0ZpKMmiNrk42Z5OV4dxEnGuRc7hwdX9cjntLuX7eRQf82DUBdvQOVETnew==
X-Received: by 2002:a05:6000:430d:b0:3e9:4fe4:2619 with SMTP id
 ffacd0b85a97d-40e43737150mr8343629f8f.25.1758895760943; 
 Fri, 26 Sep 2025 07:09:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/44] target/arm: Split out redirect_cpreg
Date: Fri, 26 Sep 2025 15:08:34 +0100
Message-ID: <20250926140844.1493020-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 599e7a36ee3..c0fa2137b63 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2455,6 +2455,19 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+/*
+ * Look up @key, returning the cpreg, which must exist.
+ * Additionally, the new cpreg must also be accessible.
+ */
+static const ARMCPRegInfo *
+redirect_cpreg(DisasContext *s, uint32_t key, bool isread)
+{
+    const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    assert(ri);
+    assert(cp_access_ok(s->current_el, ri, isread));
+    return ri;
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2603,9 +2616,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * fine-grained-traps on EL1 also do not apply here.
          */
         key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
-        ri = get_arm_cp_reginfo(s->cp_regs, key);
-        assert(ri);
-        assert(cp_access_ok(s->current_el, ri, isread));
+        ri = redirect_cpreg(s, key, isread);
         /*
          * We might not have done an update_pc earlier, so check we don't
          * need it. We could support this in future if necessary.
-- 
2.43.0



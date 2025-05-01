Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4928C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLc-0005Vn-PG; Thu, 01 May 2025 02:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL6-0005C7-4E
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL3-0007A7-Bo
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so704617b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080644; x=1746685444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nytbMb4sgZrZygEF1t706bwsFhUC7rAu+zrbjRJ37jY=;
 b=tcK66LPptSskViD1HGz3LzrqsnDO3Zw+ZdAMc8+M6sfXaX/NHM6ZRD6Cknn2zqdARK
 EoMTRqC8YIdgu7krkBED/udd31sqFWUNHpPM0X59N9H/IqdD+j0Fu12ghMAp5GsYxRkE
 NrwPD9YCNfBhqruVIwqYbQYYxFsDXtnjLE+RYuhR6Wodw20CY2e8FCXw5uU0wDszCvde
 4H4iEpPY9ksluVCPZ+LiXPw8bb06gCs2YP3k/EVtbQ8Ve95wlHZPWuUfE3bK4YhMAzD9
 PD82GXKFBZnbHe7dUt8VFV1WWm+duNMeON+Q2GJCqOyHGIGC2Sabp4GwafptMfS/suzp
 XQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080644; x=1746685444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nytbMb4sgZrZygEF1t706bwsFhUC7rAu+zrbjRJ37jY=;
 b=slSn12rHee9gkL3N8mKa46gIJP6jDMA5wmvduKDfQ1+ql+1+Vxihp8mnO2rjcrzl2M
 XdoVSrD+ApXtT5yEPPyEZPpxHyHC7sRXWBsV5gYjbTsCkjiw/ALNJL30fvCvM0YRSKAb
 cREurkOMpe7f/rLykg3U3/5A7yrCykKgdwv+imvZ8JlbBNFk5rUSz5G6dD4gUGm+PMwg
 jg09LBG8uAO9xb/0wa1lzTD9Tz/8lz52wojl2uM7MWaqpxm4skNjWZ/H/u9ebC7zEIJn
 VowQE7TI68bjGgb38vCfIlxMJZnrVPB3fCrqgsaNBBnbaUDrHE7tvy5266B14ZYfkGsQ
 l3eg==
X-Gm-Message-State: AOJu0YwyNeK7I2JLYypvuYWzIJweWBXENVM2ACV7Eq7DSwTLbTXma1nf
 fqkfXRRx06yMnkeK/MWsRlhfKGZzE2+FIgcs2IXFT5Tv67uLWQX9T//EfzynfqLGV9Z+TeOLSEh
 J
X-Gm-Gg: ASbGncuG/glx0FXV1DfV83JzBx912TdEmVslKnj5CyjWYOafVYAWU+w5EHhiPN1vGmt
 E2eLgHduYZ65nnHRRevEEV7i9HtygLYlA0/h3ZrD4KmD0FMjVvYU/IhV4WBXoGQozU5AgNNC49u
 gDwmH5VQ3Hwhz1lMyop0rGld+0OiN91gvJI6+3xEQ+Iab5uW1k1wAg8b64w1PmWNdxHT7cdPy5z
 Xw5lFscxBF6Q1U1U5H6843vc0zlweemzD1WtFdaqKfjyOKNh7x6hHCgvbXwVTghADI6U5PA73+p
 zaBWr3lkJnC8D9IvpBGUjAAP/SVa2YHG2r9guFoX
X-Google-Smtp-Source: AGHT+IHfkV3iPRLyjYnlQE65kamxUee+Atz7k3DbAE140bq5p4dc3YmLffIe7x96k+PR8VB6puKHcQ==
X-Received: by 2002:a05:6a00:179e:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-740491a556cmr2192248b3a.3.1746080643897; 
 Wed, 30 Apr 2025 23:24:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 14/33] target/arm/helper: user i64 for probe_access
Date: Wed, 30 Apr 2025 23:23:25 -0700
Message-ID: <20250501062344.2526061-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 450c9d841bf..f870b707c7f 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, i64, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..32344bd06d1 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, uint64_t ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.47.2



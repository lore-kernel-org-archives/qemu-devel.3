Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846D7CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OJ-0000EP-FD; Thu, 07 May 2026 19:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OH-0000CP-Vz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:26 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OG-00010r-Gy
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:25 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de431da8fbso1140478a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197462; x=1778802262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xQFL5qnJbTCMuaEBPieq6VTwctzd/ZwaJ3ywMslF2Q=;
 b=JjYitrDE+6ZYEEBaFrt1WsgAz4vcYVmdJK3Hvi4JWxCj6OBH4qkRTz2364hVRVMDok
 dpOF7vFVuOIPz6m+k88GlC6ZTgZb3gP1jcPgmnS2foRlvLG9gJBzjcPjkoN2kXVsVJ7/
 djCcgmyaaMsRg/xMSypmG644Blgx0ZN7k52OOjUdegbsDl/8POondO2+YtPzWI96GcfI
 yCQnLNLId4hqUwyPuu63BkVBTZ6MxFzEDXliUJXzd4aD0S59q7cWg36EbT5J/joOGrQp
 eBJV/kgseBjMmDf1MZex8kYoZqb+G+Dh4pY2uDoCzIVfjAcSGOevTpA1+nuDbr3ButzV
 GsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197462; x=1778802262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7xQFL5qnJbTCMuaEBPieq6VTwctzd/ZwaJ3ywMslF2Q=;
 b=HtiqxBSAC67r29DsyXgu2fIdnxAvAOvmk3AGbsCaOqHBdpDbAeH9OIftH9ob1Opirw
 +QeI807OcsjfoSWALTDWo3m9xVYdkTNtvRw615TCZOydclXPbatBOp0ODn/vMY3+XMOy
 WnVATeE8HdEg5A/63RYD4/GqJJ2Mc/VgvqI0nNXi93uhWNII+RXIKa3tW4Had1rEoiWL
 GYYEbYZKAjjRj9h3Irnz6lxqQvXVyRQuIeOMQBwEGE22c/4N/q5tlYTFPMjHlJRuP0OD
 J/0yCrPq0DcXWewavijCsv+6l5bZUJh76I87AHfywW8ahdsEkwFLXW5Mla9eFkzz9ejd
 7Duw==
X-Gm-Message-State: AOJu0Yx4LvVm+pBvhOm9l1aP6lMEZXGX5mEeDDyZHrPMcVQTjorDXHEE
 lnGdfrnjFIRdym7sHgDud5l3eLCyyxqlpC/YFkivfh6HpPWNpJID9v9vQ7X8dHEtN5ttEy/ia5p
 DZsFO
X-Gm-Gg: AeBDiesQDszYf4Uf1VDsEFzpwKLCckaVg4hfr3KVlsFvDgcg3ZGFBfxtStLFkDg5Zzd
 3tfOSucjoZ0jhembgqsSzfZTATA/efqGSZY7b5ywgNwM7nSdErH8q5HZDtY3ypilO4LuVOxbKp4
 h3p7fdJB0KgHFY9DymFvQwbSXyToKw6deeYvm3+nUPeJkdnSFCxbf2QsC8IZu2BkZcXVHxCC55g
 nrG0Q6LPnaIebgR95d/5OTxmrbMpMTjPN1L1ny8Kd1E8CX9sUrmhZa3iVwCU19XUepVq8YoaZ84
 Xs1LuEtWsi1gSNs0mt9bAh0K3VyHS5BL/dvhWfvrF7FnXI54/MnASBQjUKkyEnKYxrRwvPMJmYg
 JTNWiN8WaDnaGC22b6EfMXxq9plsjJFJbDhXvxHvjbTq8eeAqPyGDUfU/2AXjyiguY19MdF+V2w
 mpJY9i4lpC46i4jDK5lMJyvkVJr6Ac4Ns4UWUSVLpuIiKKZA==
X-Received: by 2002:a05:6830:6005:b0:7de:4198:7a2f with SMTP id
 46e09a7af769-7e1df0d2b55mr6576257a34.16.1778197462262; 
 Thu, 07 May 2026 16:44:22 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 07/60] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Thu,  7 May 2026 18:43:20 -0500
Message-ID: <20260507234413.643512-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a632584a4e..6376ae1ca3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,7 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0



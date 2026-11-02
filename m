Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3EF606A338
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oP2Qy+y1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDK-0003Z5-BJ; Mon, 02 Nov 2026 08:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCw-0003Bi-9x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCu-0002HU-Lv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1386213f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626575; x=1794231375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D9QwOSyi+RM6LM5rWegMG0zOQZWEqJa9UG3bOkEvr4I=;
 b=oP2Qy+y1vgiCAa+ymazI0TAF9bVek5bz0pt7x2juXo7RSssKQsr1NubjSOxmtsrgHP
 kxh/o+gdw73DMGBmHh/NJQFsI77WgizCbOMdQtY2BsuQMxpDRSOOqrJg6uSN5WrEK3DE
 /000RqMdzsVHHC3TrDwQwEEF6mK1gRoxYw4K6BSJ8DqhRdJ3vMe9VHXzb1DMPzdMRW9f
 8TroD8vDXsYPpk2RE7pOtJG5NGWSMWjxDyYbdVt4BVqUjRWmTxOUbynwFCrgZ3b9hFmD
 vhguTuMzfAyKIBgQz97lNHbpdPjmJZcD93wstBzNJY29I2Q19CEH/2UuJV29Eys7Cr0i
 icwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626575; x=1794231375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=D9QwOSyi+RM6LM5rWegMG0zOQZWEqJa9UG3bOkEvr4I=;
 b=LroRe2E7CkMv9w8swcLdH1tFHV/ixNq5C0aUfFE8Vcrgracg2P0/bRFlP/+FMpEeDa
 PDt4g0tyFW84b7DzXzaGfmwXZe6N6pkYHNkQPY70NUTMtme1P6u+4Joq8DXt2TbvORIe
 JAJqRiKMeNnTYKXTIBlpi1H0s1YuvCduS5o1xKK4imDBCRYc8ZWrhIdR6wb0jtucfH8E
 9IkygPuvPhfcmExeMA4O4Lxwz0X2/nYzY4+Iz1r6yEQPMJmwVJ/q7IclCdfVYuSDpOzb
 8Dow9pyEWMNVJP0+8NVE2KntYKsKEnmM131xd2N8j56PFAn/OBHA1ULH0x1q9+S5NFX8
 cE7g==
X-Gm-Message-State: APuU4Z/0ivfSJVoFHhBpUr7dN94IT6nWGfeHksb7XGS4cuDhMT66J6u6
 QwkucQ7NF0HuIr0zcxSwj2fvUmAIe5K1xakyHtbs4jmpJBc2QHBcFaf2jUS06oaqlBGRuRv8Jfw
 PZUGpQUo=
X-Gm-Gg: AYBFou0Bwmvltm2lvvmLvTKO205ZrIbEdwxEPNDcf+gWyh/dvxUjHlXgdyp5gkKIKyR
 Zw12PGdFCy/7MaEn4BmR8UPXa7KaY9M63hhNRlH08efI4ek7irhD6LZ5wjN0bx0TIg407Kl/oRC
 JYolUtY19t/8b+0VRqSz8Uuo0dQkofdqj7Obovn3MCkGnAe4YjkVjFv0L7Z8pyeer8QHZvKmxZm
 n4Su8TWxaouTDzyxFFhpw0d78/ARFq/3nNLxJBZbkZjwHtbXu0C5WUFGg7TkS5OljO/aXhZmIpg
 BqSv1V3U4ssaLcOJPbH6Q5pE7p45GoA3q5rz3pNpksZF41WHVjGpZhn4VX5jmbslf63+heY15HR
 GjlJRsy0+WKO/yQT7A2vMJuMc08g6eRmg8632kl1kvehm4uciMSKLLKRguvfBVyDVc6BxUMmqgH
 MXr85sVUCYvb7ywRJeaGrigd0ag+/B+pVyELWYDULD1sWzLCfTTaTyZQy4U38Qb2HTlnj3Hx2+/
 f1tdy3ZGIafb0GzZABV23pSvDhCfzjHVnC2ef1Ap/VtArvRh+Zq2OXAuGcAWhLiYxAvvLMhAQLc
 pGwPF0suxyb2x1Hj9se582T2vmZsVxQJn1ElDK79fSrEob5Aix5LnPZqQzZEtSgvCwTrLLbU3fj
 GvkXRKDnYwosfjNCmBFXpRREjF0Tl/UafG8kSSMumof3YxnqT14TlpIE=
X-Received: by 2002:a05:6000:2587:b0:48d:dec7:974c with SMTP id
 ffacd0b85a97d-48e6e2bbfd3mr23237744f8f.7.1793626574992; 
 Mon, 02 Nov 2026 05:36:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/47] hvf: arm: save/restore SME state only when SME on
Date: Mon,  2 Nov 2026 13:35:22 +0000
Message-ID: <20261102133547.1375701-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When SME is disabled as part of the CPU configuration, do not restore SME state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027120135.53048-2-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a845..6085ac22849 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1394,7 +1394,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
             sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
         }
 
@@ -1444,7 +1444,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
             for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
                 hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
                 uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-- 
2.43.0



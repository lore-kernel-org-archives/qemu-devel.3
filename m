Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B8C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1N-0005Ds-R2; Sun, 04 May 2025 21:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-000443-3c
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0002dD-SL
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3714343b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409977; x=1747014777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEdUza85WO+DzwzEMeWL7z4M0hhaS2RgQrae4P4VTDk=;
 b=Z77uDWrEcpVPeKxEJVuQOVcbsJDBavL62GwquNzONKNvHzMVftq59D1r6t/gGS2ggJ
 RKmo2Cd714vE1i1AbGBsQTLtpVAehDRRQqFoBYVbBYY2aaRAXYZuLwu5lS0BsRT5VFs3
 mlHH6XjaymbiiSihD9pDfmZO2YhYuAJiNbjN6stABk1f7sch1G0+Qyn6k8gkDwBBt+gm
 BpGBRlGkn5b1YJ3z5276V5u4gDICtYcsg54nmbJlAzwYkDUhD5D53T9xoDIXWqdpMpXt
 5wgOvyBWcSMe2yzCzsByWPLATRsFfGFcCS3pkc0so6IxroIt3rNRSZYBRSTgqI8epxLf
 82iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409977; x=1747014777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEdUza85WO+DzwzEMeWL7z4M0hhaS2RgQrae4P4VTDk=;
 b=Huv9bi7yGKLteMSnojsxC0Y37oa770EdFBCbd7SPb7rA6q2x8iTIfZD/3MMltWYr17
 AWg5mxQRaI0nTqdbJAdCMb4Ic0lOyHoaCYRLhPSgP+lRv1UF09QZV+wShmz8ppl2JfEE
 vwueRDMcKgqlCPrmPgkg3Qsfq0MfmOnU3Hw1jhC/R0tKlxC7CHLJPpan5LX+07pYY79L
 1c/q3uyypsZsimdivKJhU+40exxmXSOb+hSyEnO3diaMeY5iZchpyPFMQ6RKFnxKjgzT
 TxDNSQSmW9fidn6PaELvuQirXP2buBNjM79k8kx7M+VUnYr5xqndeuPui4V0v196l2VR
 NskQ==
X-Gm-Message-State: AOJu0Yx0lUUGhvhBGddWWMH+d0U5rSYL7Is6uIB6iqZp2CEJCmDw8y+d
 KqGhnK8+dZKRofwu+HsxfdXxvzLss0JANVYzSiwrN1Yb4DHsYVC11+GOTh5Tucid1jbp0Qqt0pJ
 gFFk=
X-Gm-Gg: ASbGncsrFd6e4VWzKPz6oNxzlTnmcVUN+y+NLcR63+GL74N2GfPX+/EmpzB/w47r//t
 4GCPGoleHHuaBh7DWl2hdZPu7eOlpj9A7D2TGKU94pYxs9PQamo5a98BnGzdC4mSJ+Am74I65Pa
 c+CnI9E8Kpn/JRujCXqd/5hbEIkMRkBpDwmTIi1Wp4kn3byyxFwNJ8sQ4pBzzP6W3VCs8aswHIE
 ciF8RL+QgTVla5u92jpW+aC5XcqMPZETJ3CwcWFTGXiqc8qoghbkIN2JsgFqalnHbLOtVZVOBOM
 G8atgcCk6NHhrwpi35pEqmfV29G7J5qBLvtsCtM+
X-Google-Smtp-Source: AGHT+IGxlO9gTykq6ulNB0WPj1QemoIP4SS2JOIADwz2/WJQVG/BKVmUJZdt8lSEKyp+6CHlJm1dyw==
X-Received: by 2002:a05:6a20:7350:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-20e97ea92ffmr6762334637.42.1746409977012; 
 Sun, 04 May 2025 18:52:57 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 31/48] target/arm/ptw: replace target_ulong with int64_t
Date: Sun,  4 May 2025 18:52:06 -0700
Message-ID: <20250505015223.3895275-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e0e82ae507f..26c52e6b03e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.47.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E5CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkZ8-00007w-FX; Tue, 12 May 2026 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ7-00007j-KL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ5-0004wY-V4
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44b330c5cc6so3883759f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778582534; x=1779187334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFZUlls1c5X4NMYGrbnJvphrDhgD5jx9UANy2AKruuc=;
 b=vBI46e95+eVq7WpJ5RPrxXET+LMEbb/risLAynu581ByME8tnMcij5p9nRU1ms055O
 W2qf34wc2DHfFVrz7/nAi6QoKbMFUeLcKSU+bY30sLcNRiZ82nElUvuTiDRdq6s7bsI6
 m78zprU//p7H2+sXj+cqyV8S6SqlRXGGbW4kaM+Z5oD1FN5oHxJN35xFptqC6Ng+5zy3
 oylAomEYQCj4wfC+tVTOmIGlPwKGoZ+vrbwSLvGvZVrdt6ldM3PNMKCWRIAF1vXDFsLX
 oPag95lwyfahi5SN7Nz+SzmQQN2vy9DDxLxF1a4jqDOc1lClxZpGAt/w21kporQ7jZjT
 js2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582534; x=1779187334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MFZUlls1c5X4NMYGrbnJvphrDhgD5jx9UANy2AKruuc=;
 b=anoXw3zo1iU2qKSMCZk+oG1bTgdymzhSrbZLy2x4H1agwfW4GPhTWp+0nmITYeQmqp
 s4zku0ZYOgmZKklkp1SeAuVPWpVtph+ujWXltO6k/5hybAg4A1eY5faempbv3WqUyJjl
 zdKjOKSoGIv+dLFuwLKdXIKsLjsMRZr9L+OpRWJ/B+KiN+TExAVEncrD31VhyKfyTcnB
 OGGVCN0oB7Ul4DfAkKHNaHlXyVUu3Qu8xMPmOn+w67Fb/CPm90Lt4RJAAwLDKRevcI1C
 SLIjQxX/Io+GxCFj746PYMq9xxDdTfkv+1J93UhQKBrwooNpug4mn5ZBu5ISUPKMoALO
 RaxA==
X-Gm-Message-State: AOJu0YwAtPjONqtb4uHKPOHf0Tjq3CbdfVUTEevdo7eMNiFInBY9tmwN
 bwnk5wPAddIoxOcOaheaU5LVPyfbCnvR7EeO0YSP0IrGMn8K+Kilt+EuO5bVzFCIvAmN3acJJ/j
 E0B2j
X-Gm-Gg: Acq92OH7By4Zfjy9L9t/WHxgrZttNhjWo27ZjD/c1oJ5TODL+pszFdeSVS/KDJZnKBY
 9b2PZtJiRaO3OxGpyHMMv3MPL/bR1lq3UTndCbk7qrSnLXw0UKW3XFBLL/D87svrY3od4VjRDix
 hnVohQfCbeoAn3WY5ISZXj1pwZLYpCwUuf8WUobs0L180rhjpTlcqEuIHDpG2b/U1tOcCyBD0ga
 SmD7k6GI4TlgVzB9lSDbo2dTV2NgUONXfjT81liUQXbl2u4F5Xc8WhzWVidAKOByaLSjGJAXuUN
 BvkGGdYgtROm7FBVlDojwUEX6ISkwQn29NiCOD1zmmN23uO/zcHuVxLvyzY4qJzmZPtZTzocU6N
 ez9tcLqiI+7J1q5dIXYy3hE+HuYKw9aHj5HyjyPVjsxbiK2zyejsEyupzu95EIl96XTZ6GUX02D
 GWNulza7GE3Er43D/Ocey+yBV07wptDchHSVcU4SSiJVUv0ZOmBsksLbBnTs2MGtzO5FmMe0Cxn
 s3pXzhh7Xy6F3HXfEa7h0LjoPHw7cQ=
X-Received: by 2002:a05:6000:61e:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-4515da96528mr44021450f8f.43.1778582534572; 
 Tue, 12 May 2026 03:42:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm31481680f8f.34.2026.05.12.03.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:42:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/2] ui/vt100: Take byte as uint8_t in bh_utf8_decode()
Date: Tue, 12 May 2026 11:42:10 +0100
Message-ID: <20260512104210.3330835-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512104210.3330835-1-peter.maydell@linaro.org>
References: <20260512104210.3330835-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The bh_utf8_decode() UTF8 decoder takes its next byte as a "uint32_t
byte" parameter, but it assumes it to be in bounds as it immediately
indexes into its array with it.

Use "uint8_t" as the argument type instead. This moves us away from
the upstream implementation slightly, but it is the same type as
we use in the one callsite, and it makes it clear that we can't
be indexing off the end of the array with this guest-derived data.

This probably helps make Coverity a bit happier (CID 1659590).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I was tempted to split the utf8d[] array in two, because it
is really two entirely disjoint data structures -- we look up
the input byte in elements 0..255, and then we look up
(*state + type) in elements 256..363. But I left it alone.
---
 ui/vt100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vt100.c b/ui/vt100.c
index 7e373766bc..f8140cfa85 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -438,7 +438,7 @@ static void vt100_clear_xy(QemuVT100 *vt, int x, int y)
 #define BH_UTF8_ACCEPT 0
 #define BH_UTF8_REJECT 12
 
-static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
+static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint8_t byte)
 {
     static const uint8_t utf8d[] = {
         /* character class lookup */
-- 
2.43.0



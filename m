Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A32E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Zh-0004uh-QG; Tue, 07 Jan 2025 03:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XF-0000Nv-F2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:57 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XB-00030B-SE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216401de828so208901795ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236912; x=1736841712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6YgeU3kN8o3zjG1+JgEUxkKcTo6SQEhfms92q0lJc4=;
 b=LDkZhTjt0ZOLiEmb7KIYlZ0M7Lupq6VeMOJDwZAqkLrBXQzbGiLlZ8hnWq4X4GvjFb
 6p/1hnavCqB0CMBL7bPA+b5xeeB4mS+v/4HyKIOXClX2nYfiKzUgeiz8gexGwZoVZhuB
 rESRMUaNW6F9AVR6dvtup8zRDKZ0ZBvQl9hNfVssK9/V5HYnsqK6jHZbxUAWlGhAYZ80
 kh9Tnc8aVGoIogr40ekru/a9jtaUK0H2y3NUU5L6mvSwZUpkHuffPZ3qJWPyY4vJ0B1b
 gom73tQpeA0flVct7WeUufoEDylXRTRLn8Omm2zw7nFCllANq/ezq2EWLn5XVvm95b1m
 SsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236912; x=1736841712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6YgeU3kN8o3zjG1+JgEUxkKcTo6SQEhfms92q0lJc4=;
 b=VzOJuXifYp06wiK9bbTHKQVLylBTMYiA92t0Rq2sU5bSQLNrcg0ez6Ti4I7oaW4UV9
 hguvpyKVpEPX/8hToqsG+64ZH1B5oVaoGPJcEz8yeTK++NJNlsHhz5Cy+BRk7dnkBGId
 Al+HTkwuCQiy5weD1tUj41suPaoTtHjzmzMCbGS9G4Leg/E1cqfVAhjjtaWpxIN1I13V
 8IQWKQTYfBRK/4NXd2tXh/CNsph0pTqAd2DgepkQNAwxeUXw/7xmGeDjuXqrAkjHiA1j
 F//8F49NGmtkZMgwI994amIikqkqYW70aJa6IhhMXAqUyjt9NUWhgYLuZ4KVRxQE+LmJ
 NDmQ==
X-Gm-Message-State: AOJu0YxLCNY+pDIqdtoMzOfmFR1UPKSKlb32eXG7vkLvdUvQJ/fWeFC2
 oHWOS9iOqSQKo3WG1UV4ipTcRx5XFncmbrjl9XN7rTHU9yTongCVDInrOV021mY2kmB4ukt25Lz
 r
X-Gm-Gg: ASbGnctGkjK2D7a6IJCm5gWP+WBl0BXsyY8le9ljTGGQoB7IQ1GOZpxDyY7IPbDOuza
 lLGnrLmpeukmtbTzPdYnB7OA4aWMkIOHN7TRM6GJ299Z6EChWvlmJYSfxPJrTv0Tve8/KBwzrIl
 6DYpNYCNKsjWapscyaSWHxIRjQmyy+PGOaIn4NDB5DtxB1IGZQJZ3YZkssE1IolpoDGc77SVp7c
 0eEjjB4aXBv5dcuuNAbM3vsiazo6atK2mSeK7jYIWKm+zDlMsditqU/rpoLXS8R0MbtDSZymYAQ
 IwNfWaabiLB4fVqzSA==
X-Google-Smtp-Source: AGHT+IFNYlgRcf7OQI8D/fy0db19vSGCKFGhu+1Lb9jYw8yHCwO6oRjvk+Y4kSE2PwctsAasjuaRcQ==
X-Received: by 2002:a17:903:11c5:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-219e6e894demr850055295ad.8.1736236911585; 
 Tue, 07 Jan 2025 00:01:51 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 36/81] tcg/aarch64: Expand extract with offset 0 with andi
Date: Tue,  7 Jan 2025 00:00:27 -0800
Message-ID: <20250107080112.1175095-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

We're about to change canonicalization of masks as extract
instead of and.  Retain the andi expansion here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index ede6f47235..66eb4b73b5 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2450,7 +2450,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
 
     case INDEX_op_extract_i64:
     case INDEX_op_extract_i32:
-        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0) {
+            uint64_t mask = MAKE_64BIT_MASK(0, args[3]);
+            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, mask);
+        } else {
+            tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        }
         break;
 
     case INDEX_op_sextract_i64:
-- 
2.43.0



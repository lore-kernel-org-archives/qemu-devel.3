Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B20DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNzz-0000XQ-3H; Sat, 30 Aug 2025 12:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERg-0007Zg-VK
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERe-00053t-U3
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-248ff4403b9so17479275ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532889; x=1757137689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=n8iVZXGAFq/SZyurglApvl+Sook3Um1klhvTQmlkti//w4G6PW3yGOduOKwayHSmAz
 xHY6e7n6ILnY80f0MwMqOxdx1dBR14rzJjazzmaP8AKI++ngDcfJiUFHiuhRaQQSHiJL
 AI0Wc7SBtlztTaPcPqJEIhogvZXGQ/BqnPvVxLR0pRdT05hXLr4Z3vSq38LwtA74E9MN
 aYwARVJX0WrSkNv57oFSsX42XGGWcSAqiQjdN8UggW50SH9ICqWV3mEPZcqrYeLJ4N6c
 VLZB6CLjA+OkSzTT6peCnObaDVqnywqyc5PG5Rhh5ZEQ9oCbs4gQDtCyb+UuBIfoqu0i
 1Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532889; x=1757137689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bac99cWBoODM0lZjzPV8FafpKsc60jTDKb6XVoHXo24=;
 b=DPjk0q/qB2iBtvK+G7WzH7VFOG2GtqLPrVficKRKYKLgHF+/GzZUlV9nD+w7fuTa//
 rqgiY3Rv0zUwgJiIax74/Nn0wxyKOdINwVGK5FNTku34aSBCujx1H0Yd0P/eQ8zyVFTp
 Y8om4N5AYQ7w/MG1GjGcaujXvWScD3xvmr4p+gco54s145VJopP5aTnS+qRKo+XNVL23
 boo+6XMlKJK1SWaKEuILb3xMjGfVVv45ukDDgiX8UW4N8A9ox4RJmQUJ8ooVYUbtjh/n
 aRfQJjFHB2D2gAp0X/WKN9OxP4BEGsHY52KO0hUEI6jenwHoeJCW1KjuW12P3E77/R2h
 xw7Q==
X-Gm-Message-State: AOJu0YxvBb3m3LCGd7CsoK2JfLaQaweWNC2r/W9VsHZaQ3p6lOuCBkFP
 lAv4fm2hOfjOxrAW+cG4ulbe86PQSqrEr5LXLRBv34yor+V7KI26zElKdRfzuYfOqQgcN8uYox9
 CJwm1f1s=
X-Gm-Gg: ASbGnctR6XhOvTOBqdKMy6F7CRUFSUVrWTZeCpot+iRhNha2E+exk/YGczHc9CY5/l+
 qZkfdOPbGteiG6/lCeoSFnDUZb8STW62TtAvTHiwFpZLO+pv25/H+BeTYrd+6zaqOCAyCgeOezH
 e7egiU817IUoxMO2fFUSBItId40tw7ltcmaE5nnrIQKq95jOiRRhmqwmhTI3rixiGXnHrf2vTCa
 j4LEfRh8WEHD8OyUJjAdcEh7G4dE3Xdi9IG8k/WDZ4FjaizWc5FqqgDq74ByTGzujZwXxcK56YO
 mMgj9+QdEay+4dj182+90VK/hTX1tddm4nl8yzRQh7jNL276kVX97cjcv8X3ol4W8AkUNXeLXCO
 reZbAf4CWkXMEozssxqW7RsmQjk1gmw69KzE+sQIBMGInuEZiPIOPUewhHB9x6S4=
X-Google-Smtp-Source: AGHT+IGXaQpscm7/1zUhEeaoZ9ooDyQHhqZN0Z+WC+sNrG55TUaAuzpT/bs2zdf6XbdLvnzkq4mM0w==
X-Received: by 2002:a17:902:e847:b0:248:9c98:2cf4 with SMTP id
 d9443c01a7336-24944aeebf8mr15656665ad.46.1756532889443; 
 Fri, 29 Aug 2025 22:48:09 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:48:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 76/84] linux-user/aarch64: Release gcs stack on thread exit
Date: Sat, 30 Aug 2025 15:41:20 +1000
Message-ID: <20250830054128.448363-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91210775ed..dfe114ceb3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9309,6 +9309,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E9CC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg87p-0004ax-HG; Thu, 06 Feb 2025 15:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Y-0007pC-K6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:07 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Q-00018A-6m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:55 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so2353176a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872051; x=1739476851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5KiZyKM080ZbjR4LrQImvIYhFqt6qNWMePeRVyLyag=;
 b=l/C3f/uWwWY8TGe2T1p8KlI0s+TMp94xhg3ebrAErup+dy+rIWr5i07dIqjlKAKDqS
 7iizN1QeSH+LDgV/hFEyoCblZpGXfileYxTDKcF/EqdImTi7TqV9gi0rioaQv0awNaC0
 Y14F9+ItOPlJ3/lLWVuknQUu1FKY8DEMlr94vElE2j7j3TOprKtGBu7Ps3t2v3WrR10y
 fdZgyiPOcZr3tMR6+YaxP2QL9+XBGCaE2tnueVxIsKBQEGD1Wz/1nrMJLx8fRfKlpKyu
 /u3D+P85kwSxnk+UnZatiWmQZSMThSV3DMhRLr6NTOY3uPrf59pASANriAxXGaLrJY5Q
 lhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872051; x=1739476851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5KiZyKM080ZbjR4LrQImvIYhFqt6qNWMePeRVyLyag=;
 b=UucBoB8LCi5yZvEVTY8ogb/v3wY5MxGZN1zmbWTLr94a03okvTDdHIyHPx7Z/NWn4p
 5qLfOlOi51iHMGzqntg5JQ27+YyxxR6/ML7MHl32eh3xdn0BHxuOPToamYETouyG/l5f
 6lX3sJdIXA1sSzC+i+6D+9yUaQ7FgzZ8Mu2jzP8BWY2kMDeZ07WgIhyfrDu4jcjspLOO
 Bjqy1KoNHbhfE0Ef+3R4NVEoWdOuY8QaUJvUecgn6HcsMRZEqjdpecOdy/71PDjrIOMJ
 LnW76qLZmEY5l6lSwJzvt0Lzr2P3A2Q3rOtGzGn4xWoQJTgJ7VYHkF6kSaFZDQKB2+yV
 jdbg==
X-Gm-Message-State: AOJu0Yx2HBUEmRI6lqhWpbtI9ZTO3W0wUh8JjQ/9kslUDwaLcx44sH2j
 I5fBkKhDr8N8JQkHXVhRm0XCXOzKQQzaYLq7c4NlHCi2pZaT/MzMFllc+C7OkxRRAQOLKEMJM5Z
 S
X-Gm-Gg: ASbGncte1C2RDcAMhbAF9htLdEVcOOHwD/xCwZpiNrRaWpB820bR4pjKLuPzIeFWxCL
 X/vnqGQERm3WzOn/N8k9ScDVZs+2BZxnsluU1uQGK4V8lK7ij/y9z6C6x1cQMU60+rGOmKI1IlV
 1PH6ez8D+aY+qAwmpUoglADJtAssXiGOpoWCS4kLhxQ3DZtpm/5xSByciEXMdw0oIYIQMknv6ks
 OUQJMHK+L8yVg++JZJWYijUP2UVbvbVqMOeRR8D2KTVzSJQ7Y4Az0xmt6VmoL3dxvCkvSVt7Ld6
 IHC1UQ1kDSmM2fBfRsdD4rRkSCPQoo4Q4KAspO+zQzbVmHg=
X-Google-Smtp-Source: AGHT+IFZTv5NN1vpruEUCGwOsHKSlrQ30W9nd0wyLyynDG7fdgOUETEWsmrvHJyDx3L0USFQSWpjnw==
X-Received: by 2002:a17:90b:3c81:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2fa240641ddmr555335a91.11.1738872050859; 
 Thu, 06 Feb 2025 12:00:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 45/61] target/arm: Remove CPUARMState.vfp.scratch
Date: Thu,  6 Feb 2025 11:56:59 -0800
Message-ID: <20250206195715.2150758-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The last use of this field was removed in b2fc7be972b9.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 61f959af8b..91edeae9ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -693,9 +693,6 @@ typedef struct CPUArchState {
 
         uint32_t xregs[16];
 
-        /* Scratch space for aa32 neon expansion.  */
-        uint32_t scratch[8];
-
         /* There are a number of distinct float control structures. */
         float_status fp_status[FPST_COUNT];
 
-- 
2.43.0



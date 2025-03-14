Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898BC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8ti-0005tL-7o; Fri, 14 Mar 2025 13:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tC-0005cp-NM
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t5-0008Fw-Ne
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225df540edcso18252275ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973515; x=1742578315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=QM8Kuu6PyYcqBshbDbxID7Dnz9SsNnmCksX2a5w7zaRfTKxxtZzjZPDQGHza1TYmGc
 5KN5UvuIXLwX1azcvqNjT9xTLvuS/0/M5TBZRJjLam0acqL1oc5N2zpD/0GGr7Lpl0MQ
 MmeB0qPJB4YiyFknwMx5JA++zFiCpRjPz1LlNjaMhkjTqRgNzZnXYm+MCINwHNBvxfSM
 oLXkxp+gqBduWjEWkfs6T+xmRtgVcVAu+2tMODKWXXRQxqc1vHBI8g7gzNHTen9MzO3G
 Ejv4K8x1PJog/jKIQD5hQJAQmpzutkspbxOofHP18hijH5yRZ7gOh3fNe2cN8aryraIC
 70gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973515; x=1742578315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=EyIO5cGCdFyN5tSeh+cb1GzSA9AivpKBsTsfPGe+B6PgmS5ED+nqI/3NNanx/u5L8q
 QXMUCxMCLPMtwPBpl1StQhsuarCGpNe1Hl+odDlNTEuxv3r5t4jicHWZp8HeZgsN4BD/
 LiIJSWhaBexr6VDbXjcqFow66EZewfiBFjO3KHsAsIlxlhAnHha/u7FuVeH2rF1NDKGH
 YVxCNMuphwaN1zfT76XUq0wPwlRJ1QC/JFFxPVvvrraqvS8CZCiuxdQZG8FiBQupH2Pg
 xITotPKJwODpwcqOJ7GhkzkbzoZkeCP6mbCJPxFJrkva/ltYBHHWZXV46GFX8O0pF3OG
 C3Fw==
X-Gm-Message-State: AOJu0Yw/yUUrY4RMUta0ZNMil+umfEeyuvv06UQYX1RTZ3OiQQI8r3v+
 l1HPLgrPOvkIdlQocITYnNdnmk25dQ4gpQGa4YAB3jaFUvo3+3ZYCF+Z4ZX+cyHWBiUuJbTUJnM
 lRt0=
X-Gm-Gg: ASbGncvXAn76uRvRQwQDOFvyfY+Jxtl9H+kwxdTlcQhMIhHMWk+bQUdT1I0Y6wi28TF
 7pIeUMyFn2vy6qEo/ZuGKz4erq5AxYvOcI+durPqH3V4xk+a72dfHlxsLE0dz3kzswsRxRIaTW/
 EJ0R1AgqLMaZiP9pNqAK+Jl7SWbhacSRPrLPObJBmKtLYirUBl0lf0guaSwyoIlnBA5raty3OFC
 VnmOOIZf900UohbirOFzbVzkM8kj0mp74NnN9uUd/DHFo13luJ6LxNLOlNgAJevo9Ethgg7aXpI
 OeA8l1Ff0AjFSSthGqywKWET/D5CBIt0dpKGcOfw+SO5O/91Ammb86s=
X-Google-Smtp-Source: AGHT+IGj/I3RP0NPhKjXDLOwbHPd8rrkJpTvSehnV45pZ5KtPvxWJrCPU4ZqmKsKsNZoI57izw+qbw==
X-Received: by 2002:a05:6300:619c:b0:1f3:323e:3743 with SMTP id
 adf61e73a8af0-1f5c28650c4mr5059385637.12.1741973515400; 
 Fri, 14 Mar 2025 10:31:55 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 09/17] exec/ram_addr: remove dependency on cpu.h
Date: Fri, 14 Mar 2025 10:31:31 -0700
Message-Id: <20250314173139.2122904-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e4c28fbec9b..f5d574261a3 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.39.5



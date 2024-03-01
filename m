Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF00C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h3-0001ws-1Y; Fri, 01 Mar 2024 15:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h1-0001qX-EQ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:19 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9gz-0006yd-TH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:19 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so2132115a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325676; x=1709930476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSxGM8jSCUAKauTODiPxOuZGF0sA3+vBxABkPlr2Gc8=;
 b=D1BRQr5+QOiLN5I/UNqsClGgT9yMul/wBvtZjIzhW2PVKAYZ/qQYsah8/BaCgxbIKE
 uAmPIXurda3IPYXJZBJqbWmO4a6vjuci3bC2bSn2xoshmqJfpwfuw+QncMajf6cI+fyh
 44um+pZleU8t1MfcYklp9uageSBIv38CMOP4YHPyXuc7t9ByaP6sWJdkCbT1AKMQfolN
 B7YKvr7rqbwv2h2p9fP12Fe0md29lwih806dg7RZmwCaEI5IkSdvzWyqWadZisP84hP1
 rzst2e9Ov7ibL6mqWWvVNFoidd+DoH2zkbAwljGiXw0Zo+Tb5h5h8XLOTLL/5Gtga5/0
 eXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325676; x=1709930476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSxGM8jSCUAKauTODiPxOuZGF0sA3+vBxABkPlr2Gc8=;
 b=Q3MVwH8D8DroOFkrlz05oywV2Pvpsaq4v3Z69Xp+Hm+3OpvJRZQRqgK/GYZS4m6pmZ
 zOTqJADfMJeijUq2hXzftDeZLtvc5Y+DOgtEXTayRUGMAZJpcLU/z3DVVqIEre38Raqy
 0LKbpHNJiT1yqD3Tx4y7N60KtKOxEdO7Aho73VgCh71KRsNTBcDD1nct5JSCyVPeAE2E
 4VZ2QT1Fc7t/9iF+erQaz7djQ68/vUOTyoEjpYbcucjTwVEvYyP8P0cnBMt4SPblMyed
 MpquvrEEpWZul/AR9gBHY8esmELmhpt09s166WnkjnhUMfAPXJKvuqbU/F/F8CpTJtI3
 6b5Q==
X-Gm-Message-State: AOJu0Ywjbhj4Z2U+QxSzWlnJlbuOJq2EBsJwTQ/9KuNvUcOGVQNNTiKq
 9y7AYeuQA862r9lEPNijulJ4qzkX3Eu0hiWOa0Rp6qJIYGbtzm09bESDr+CskF+eDxyeliThP8N
 M
X-Google-Smtp-Source: AGHT+IEzdqGd8SqXPjUZ5yakxxH+7zIKAHvLTYU8dF8CKF+yEotgHayXy2xv9Jh1JCkZ/T+077zJmA==
X-Received: by 2002:a17:90a:b96:b0:29a:f150:aeed with SMTP id
 22-20020a17090a0b9600b0029af150aeedmr4650938pjr.19.1709325676472; 
 Fri, 01 Mar 2024 12:41:16 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/6] exec/memattrs: Remove target_tlb_bit*
Date: Fri,  1 Mar 2024 10:41:06 -1000
Message-Id: <20240301204110.656742-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These fields are no longer used since 937f224559.
Target specific extensions to the page tables should be done
with TARGET_PAGE_ENTRY_EXTRA.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d04170aa27..afa885f983 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,16 +54,6 @@ typedef struct MemTxAttrs {
     unsigned int requester_id:16;
     /* Invert endianness for this page */
     unsigned int byte_swap:1;
-    /*
-     * The following are target-specific page-table bits.  These are not
-     * related to actual memory transactions at all.  However, this structure
-     * is part of the tlb_fill interface, cached in the cputlb structure,
-     * and has unused bits.  These fields will be read by target-specific
-     * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
-     */
-    unsigned int target_tlb_bit0 : 1;
-    unsigned int target_tlb_bit1 : 1;
-    unsigned int target_tlb_bit2 : 1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.34.1



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JewtPqdA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrm1-0006uJ-4I; Fri, 30 Oct 2026 14:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlp-0006sM-Ss
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:11 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlo-0004oj-GQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:09 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ab43af5e97so13184217b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386567; x=1793991367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AiG69fVg0vTrsRYUt3PicmCOLEYjh1xeu/BruZIA7DM=;
 b=JewtPqdAImtEGCbv6IBXPpwEjp5+8zlGRHDfod2RIFktJc3Zm0PApLKon6OeJSuqqk
 qYiQ/WB2ms21vXyE0d31CnqTblpTHbDiahERIinXPe445Z6zPRKOY/T6wBcuhl4WzwzB
 nB4+aPkog1qkRYemAOXRhki64pzxdfnx3CkSTZielNEx8VtZd/+oMdzCpogoruULrSHA
 tpTwSnd+oRevj6aOqlsAWR59W9c9WStFRq9T/RIu+lDEHEPdBZFDnaEB4KeTNSelxUXt
 NaGKz7/P1yOR1jH8JaRK4ZZagDndsUXmax7BWT837I1Vl1uw4/1JxcsldIWh+pFEPC6B
 7mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386567; x=1793991367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AiG69fVg0vTrsRYUt3PicmCOLEYjh1xeu/BruZIA7DM=;
 b=kjgIS5FBWJORfJIqLvM82qiy08OVjztrOU0zUIqJ3eJtTWhTdmHxRyX+5nXqjY7EDY
 sURn3c5q/FIhAU/DOSfh0khiw7JfPI3bl9UNc36SmOtC+jawRpRAivKVM1dBKagR5JM0
 wuz1q88vhzmPJiBefGCnTrClpLsb6gslkcNi0EzD1+jSEnIoAb0uo3teT/XIL2vk551Y
 Ur2mq8pWZrPtFzc6WhF3XYKZqGFUUPyWgeWKHNjJdc/C/wVPoMmoiiowEwiD368QEmS/
 aVj7KttQSWssm5forvHpZlZHJXDCvzUKjoXDs83OBC1BD4tLPsZvAv4TthlXTr4OoFXA
 YGVg==
X-Gm-Message-State: AFq9FYJzhH9byUWS1FoejLM2LRoW8jRcziVgsaIstmdbT0o8P12TbUos
 lV2n8PauSpNo2or1VqR2qYl1erS8RB0Lb6981Ph0JEPqk8ul8FxUko9U3ru0HY5BdqXdVnjx41w
 +zcht
X-Gm-Gg: AYBFou2Q+P9TD2+fdG89Bx3ujvtkW3Uo/ou3CkuEqRRHw9ZP1JBMcASK9MutNfCBtrG
 7DoVunowM0cUeDaJZJLSKC+Ll89A/Iw0QA3RDbplugJMcpGoMHe3IrFm5xrcu/3HTLZbsykLSDr
 QeJjWVv5nH3vvf0L9BNhg7Jp41rhW+AtyLpy4tR7RggtJwyl3awQEKVjYXG9teMubQKQzGq8AO0
 daxn/KADv66+jWYn2GqxxxEQ5+GsncTfZdKI/9HZN7IzDjMJPQFVmxi9norGvsT1tLXnKGxC/wh
 HZeQnv64g4aKBNMAXZUSaw/TxBFKoIt4m8uDr0BRCHIPu5oorlGNA8I2DakFlJ8HfZ22r4OKagE
 B9/qad3QFtQNhWg5FFyXsmUQ0OH8iaq8N3vLGT3WyxalHqdNI7DO13MypEGjN/DH8BgdpQw8keZ
 GLXXdqk7htAWo2sOw+KEK8VBPZbgES+Yw3paZc7o/j9jxzmGwt7ndkOwOLZE5p0Cee0WGvsTz1W
 M7RdTk31ObCdIAIA9Ulm1lPnGrjH6Ggt2tt+bF9uqQKp26hPTmSJnwRDYaXzXuXVJuJNYM+UzKv
 EAwonsSDvWG8l9IA8TPU1BMhRy3zKA8n5JQ=
X-Received: by 2002:a05:690c:800c:20b0:8b1:60a0:c311 with SMTP id
 00721157ae682-8b2b67c6b9fmr14770667b3.33.1793386567140; 
 Fri, 30 Oct 2026 11:56:07 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 08/14] include/exec: Move tc within TranslationBlock
Date: Fri, 30 Oct 2026 13:55:45 -0500
Message-ID: <20261030185551.193092-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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

Move tc so that it is adjacent to cs_base, flags, cflags.
This will allow the s390x backend to load them all at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translation-block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 4406db5ab2..a675b5038b 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -93,12 +93,12 @@ struct TranslationBlock {
      * Above fields used for comparing
      */
 
+    struct tb_tc tc;
+
     /* size of target code for this block (1 <= size <= TARGET_PAGE_SIZE) */
     uint16_t size;
     uint16_t icount;
 
-    struct tb_tc tc;
-
     /*
      * Track tb_page_addr_t intervals that intersect this TB.
      * For user-only, the virtual addresses are always contiguous,
-- 
2.53.0



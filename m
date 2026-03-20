Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A5E1098781
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZiM-0006k2-UH; Fri, 20 Mar 2026 09:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhv-0005yn-6d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhr-0000Mo-Oh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b979d16dd0cso259911666b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012562; x=1774617362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujKppTRG/sc4zJGYXpDLc5sF8JwfLa5qpUqi5ZvK+Cg=;
 b=e8U6GiD46mOiklWq8BSzxz/awh2PRTW4Ok2rqTLDMvhAlcqOXHgxWIlnegrWtjOKGn
 437bQ9IVzZY75ZF1S/I2MeMb4X60C+me3M82hsiwQXpZZCsobjJYFGnCh0hb/Vqxa+2u
 KWvx2FGh8dCLWybhnl9DUbX8RVaoR/P+KBW4+FDOE66MvPFWKu2isbyj85hdIU4r9t9W
 4gc1Rf6vQ/v6E+Ohp7olES3OOdu72Z9pu2MO5z+s0iyVWShzEXZ+kxSI2JB0BjRA3Bxd
 ar6lkCrst77brHDjf7KMuhSb+wkhjN+49nkDm364qzbrjeXUPP9LsXY+g0sQpBgWcgkG
 ysdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012562; x=1774617362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujKppTRG/sc4zJGYXpDLc5sF8JwfLa5qpUqi5ZvK+Cg=;
 b=Ym+lKQxKhU9G8TM7mTfOVdnRFEejZwTx0TbXQFTbq2v7ArYYYQZGD9c2eokLL6Ml1P
 nB4N1kyBDdFPlIu3c7k8Ej3UnWJcKTBrkI4ULSTwXtg9AEX94AiUSRj+46U6X0sClvcS
 okbjdwXg68gpgho2cpMHZsgEim/tsSfqx2UbDMDUYo91FHlN++HfgK5U2Jr4gCQ0CYMZ
 +1Qu5+Z1xIUmWJ7AuGXDL6IntMOH7ouWG28H6Fg7JKJTP10yOQrxpZUwQufqYs0CvHbr
 JooO6FPyhnOkf0yzYB+7iJ/tmqhxHMulQqg8eEfz0NRmgsUaLYzv5rh9x1VrdBT/NJUP
 7XCw==
X-Gm-Message-State: AOJu0YxCsXsr5kYUUF0PoZskxgKYWr9Wf6a/9MQTPaOm2i5d708RWGW7
 bO3GKw1JZ/keR2y5Cp0j+Zm84lSEhhmhYYC44iIDHMpkacO/5Y2odGVKQ4jH1GPnJ7c=
X-Gm-Gg: ATEYQzzciBuTEfphA7ou7IS3hGEFKE1zMWRus+CZV5V0Vc1q++tHKt+r8FvEufoX1bk
 bP5M1JZcpky/M0aATBRGX3ITKnxf1so/SXLjnpH3YlSAWwkeAZGSXFN+7VSW1lIaPsRRFT+ZdCT
 t4GcpWYfzBL/Jh8e4yyUZ4ptJ1I3sN9F8bsg6HOh01SHXBGDkGGIvBX8y7dIxxdASN7+KCIDCvk
 nq5jM5b6TWsBxpWOPVXgkKjAhZbT6m63khygF1xZ3EpzNjwrquJsBi2GdWdL5nGSjhmyzBDUZC6
 sqC+oALFgWjdun/LxbyzWWsscdtzCJUbFReL+UoEowx6s+LmpOHZFaTLIY8QBsIHcbOYcbZIoIc
 AwYE4m7sXU7vETmtbhjBNdMEWgrX0GXDO3XI5PWKurt93QYSColQZQ1kpX5v998IEGFs6KYENLR
 +0Km0gyFf4nZ89Qy1mHHsCnU4=
X-Received: by 2002:a17:906:f0d8:b0:b97:b379:b3fa with SMTP id
 a640c23a62f3a-b982f35f23emr183606566b.39.1774012562080; 
 Fri, 20 Mar 2026 06:16:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9833871003sm158908466b.54.2026.03.20.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B7D35F910;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 20/35] target/arm: use syndrome helpers in
 merge_syn_data_abort
Date: Fri, 20 Mar 2026 13:05:51 +0000
Message-ID: <20260320130607.2071996-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

One more step to removing the old defines.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f9..c74d8e785a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.47.3



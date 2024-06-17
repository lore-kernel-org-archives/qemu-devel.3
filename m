Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DFDC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 06:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5rp-0003mn-Fw; Mon, 17 Jun 2024 02:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5ro-0003me-8N
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sJ5rm-0003T2-Hd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 02:29:24 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c508ea0cc5so880884a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718605760; x=1719210560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THKPrI8tkqIcVbNLqgSdh8XD5pC35UvKcKsvFX/vTJs=;
 b=sg015BifnO6gDhoP+juRO+UzUVbYkMwnVES/ZPAlKWtDUkiuP+IS6z9SJTwwkBgAwS
 NrgFhj43wyGsxFtjzhmlvEpplzCbSNIWuQJ4ENVzJl6LmJINCXlA7B9vb762ZI+ihF/3
 ZXeSqcLRK9JiVqpZJujq7oR677vKaMdd2ocdFXlE9kGbx05AckKorbc8uikheN421Mna
 /3IupMSjbzBBu+fWSzZtY1mdispriQpVzCGt4MVKVSiircMoiyfhOTINeSkuq756vE/d
 qj9SKnThs3ip9Yeu9c/MXhE7Jh16bun5lDIv9Oq+Z4slzGW10lzpGUq1ErcHkLAXUjsS
 Tw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718605760; x=1719210560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THKPrI8tkqIcVbNLqgSdh8XD5pC35UvKcKsvFX/vTJs=;
 b=ZwIENE1o/H29hIH1H/MLgE0Lcprhrwb7kplVs5TxZyKzbmZPCymZRJzsx9FqrWjYMo
 CoR/HYQJmnNFo1Mh8hiEFesct8D3yc6daSYDVevDO2Esb+V245MJKweTotjHb0xQEoDB
 Kpu8xxxt4T9upHvqJqmOybSQoRS95S3fKgOqQU5f4eyXSlStAMpfqTcuX+KtiRDMrHPP
 GOMJDC+ElqmcE7h4cj6qWKnT4dzTvKvkM8Jx5NAsisKeEB1Z8/xBUuoCwKB+MX245QKj
 aaviWnfLe4N4wQKdcqCo+Z09cLKVUMxIpIzMznkFtAPoB47OaQz6o/pC0p2r0gSivQp1
 7GJg==
X-Gm-Message-State: AOJu0Yw6OmAbFdXy/jDvHIzfayPntRIKvBep0tMirPmau6YPTiOb9nFf
 cwtZ9ERS0jD0PqbOj1lNaJpRqHJzUHkh6tZWJICa4hIHbaVmH7FWPVFxXwY9Mpn7B9pWXLkQQH/
 b
X-Google-Smtp-Source: AGHT+IHidaaaQFDtARtlrcOvm2xzXUPIF5geZNmZz8kOLHcw8fg/3ZhdVCZNcXhnpnWegyNQYU2QVg==
X-Received: by 2002:a17:90a:5d13:b0:2c3:274b:dfb0 with SMTP id
 98e67ed59e1d1-2c4db24b497mr7594237a91.17.1718605760456; 
 Sun, 16 Jun 2024 23:29:20 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75ed69csm10641863a91.14.2024.06.16.23.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 23:29:20 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Mon, 17 Jun 2024 06:28:44 +0000
Message-Id: <20240617062849.3531745-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617062849.3531745-1-gustavo.romero@linaro.org>
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1036.google.com
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

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036FDC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIe-00034j-1Q; Mon, 24 Jun 2024 01:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIU-00032z-PY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:26 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIT-0004ag-5K
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:22 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-250c0555a63so1944972fac.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207079; x=1719811879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=u8oJpM1aJ5M714o8Zx3DhgZAHWYB54FkQvdKfjW7riUnNIRgnTLTuD5qQBmt3K/0we
 NmxIOIqhR741RHVXyBgSUOkRRE4lzvcRLBM/cRERnwSSwUEg+49K9ArhxVd2JVMM+M78
 UW+qKRTuzyfNdWsfsOd84ERKvRMQqEoqdj+HTee3HIcmV3uAMI3Pv0CbsZrfMttXfkff
 vYw97zbTRm+twpZNidLIeuF73fTw/FMuKFGwEJ+RQFZxV7O7YHOzZl3mIX+nYXCG75AP
 X6EwHz7guaIkH/jMlJjCwMhT4AsZ61FmkNwNLs2C6ZHvOOLSecKNg/qSQdvhCIvAXZr2
 pf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207079; x=1719811879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=X8BfXV8ibi0uRMz8c8+aU8b82smmkeKOW2jg9sUMhZ/yB76xn0qSWhYXqjO40VZm2R
 YGiG9iAwWHNIJ3B/Lgypae1oEyerzQNlNiQ9Cpge5HbYMXgsGirF/38f5y1INZkIrEMi
 H6Uw5UaNIALcQEfLt/hSIz70qjQT+uxMB2WJeedlKX9NX4y0XkluCKyWO9zb7tJR29bX
 +gYi+sR9JjI0pomVHPa8z9Kpn1Tcf5VuXNoe+OLpSFaRcwGoa9qhAjFVH2fGaLOHF9SO
 E/hFjKZqcWGVi34c7HeeOfJSUmf5BJblISWnYOzTW67+Yht+bbtKJ7EQLdUfOKcgINVF
 LRUg==
X-Gm-Message-State: AOJu0YxiGuTHgyM1+BFpABUTMxGjMUetejEAUf25kFgW89R3PRsHEjom
 mQ6KY7MoQuVkw1G+H7jOaPlfIOFfjeogi70nTAtDaHczdrZjt0fq85aCijGEtFTvkRzv94axwWY
 BaJg=
X-Google-Smtp-Source: AGHT+IEqWqlPNUWqcwtW8V7oEeHp/gWBaHH3dU8nyAFsz5KQ0Luv5xFJnpgom3AXU7FQbso87RYTZg==
X-Received: by 2002:a05:6870:96a1:b0:254:bf41:de9d with SMTP id
 586e51a60fabf-25d06e8c2a2mr3906789fac.48.1719207079403; 
 Sun, 23 Jun 2024 22:31:19 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:18 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Mon, 24 Jun 2024 05:30:41 +0000
Message-Id: <20240624053046.221802-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x29.google.com
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

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



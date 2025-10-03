Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DE4CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHr-000244-Gw; Fri, 03 Oct 2025 13:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHp-000218-LV
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGc-0006Gf-WF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2188456b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511295; x=1760116095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZ3yHz1Z0fadc6ANEoFNUPabg2WfjYlleRkXRfBO+KY=;
 b=nybM6LvQquSlbZ8EPQSSynNAHUcqkueSxM2IqPWFgzZoiky4ZUIUBrnXvzmH7s/Lq1
 pikpZ1mwsw3uo3xwAqEHKlN6hMrHRn95DOVY6qsQOqcK8FqK4EwYXxOnij2CVb4Qx2hH
 jTCc8wYrj8X0I7IddG4JbBJFVd3NEBn+VjEOlp9+ks56pf2X8ZioVdv+NYym5KDWrmsH
 WVwScGOCJWgExBpHFqzXfuc5oSrOAko3vckaQTc6Q3aNWXCxIxMe+7GFSS/lDkVFFmBr
 8hnQ35HBbsRMzG/sSYAROh9RVD/mztt6DWqNX6z+roOUl9Udu6iQ43d2HHQWuConzULT
 FBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511295; x=1760116095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZ3yHz1Z0fadc6ANEoFNUPabg2WfjYlleRkXRfBO+KY=;
 b=PTPGjQGsSyE5BCIVY5YVxGrDVHlBroTYjkILL7WYgZcxu4dOcyks07J2NYr4xEkw/O
 sdY9myn6Ei5k18TDHJyGUEzRSCPgtsm+9ZvA6FOOz7nwyogNm1kVsmhYPOXm2kAny7zT
 qaJlHTzrNo6RLC62QisYXzWMm/wCpMvOHRnL1jC6N0X2yAeMJL4rM/IFBj7FTrCEjQPQ
 bzh4Z4slcbcPmn/69PtMgnUuARcmKoG18mHieAJXANP/pGkCoL6YLBOabbrOROI31V6X
 sov9COmdLfFi/83UDfUm1ImEmg5Y6Td5efvG0BjcH2yMJKMQ5tTQMGp7l2CM1eR069NE
 PFRw==
X-Gm-Message-State: AOJu0Yx7MUYRTBIZP5v5MRrHHRXTUCqlLVs2ux4beGKCZljC0XrQn33K
 PEYbeNcGIlnuq4MNbB2jCY6V9T1QfxrlU8vWP1YentThLdYF2sh/Lxp9gj0t9t/LbfMIN0P2Sce
 ByzT04Yk=
X-Gm-Gg: ASbGncsOLBSCg6HcKdb1Q36aNZOSpknWewCh8j+3ZAhAnBcWOlLmCej2xH7Gvxfa2df
 fyFzg+d6VlM14eUg8b1FQm27SVsskdngrYxcc3yCIooEGrwIqBLniaRtViXR4vIrEYMRqh/YBgD
 EWxOZUUnQnEPh3qHp5P3wvK/pcFDzfRv3bqqw2dOAofecbh8RBlwF3H9zlo4I8Kptqv74ckUuTY
 TGZwaxw+OghqP4Zze6xX0uvKVIlA6UHxx+zTbzXa5WoLm3e9Gb5LXB2eZoLtSSWaKx4VSfeedCx
 0ojR8w2AHXEFS9oqCEmfivM9xRjIXZDgE9uD5RX+RKYuV/HcZPKFBfK82b63zwgpfHXbjvRcYXG
 +YwHfvosjsIIqvsmb26cFoC/e145aYDuYiH41xeubUzEy7immD1rQ7NrM
X-Google-Smtp-Source: AGHT+IHMoWnaZePQFu1vWuHQgcCB4wNkJgdw46amBuoj4hRJ4rv60iXjmCnVSvQSONat680GqrqqCA==
X-Received: by 2002:a17:903:24e:b0:25b:f1f3:815f with SMTP id
 d9443c01a7336-28e9a664fe1mr43711425ad.58.1759511295093; 
 Fri, 03 Oct 2025 10:08:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 15/73] include/hw/core/cpu: Widen MMUIdxMap
Date: Fri,  3 Oct 2025 10:07:02 -0700
Message-ID: <20251003170800.997167-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9f40c2539..71c31cc6bb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..416aaa1040 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,9 +89,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0



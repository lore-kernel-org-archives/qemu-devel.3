Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D257CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd2T-0001Rx-12; Fri, 21 Nov 2025 21:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcIg-0002mv-Gw
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:20:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcIR-0006zU-DO
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:20:27 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso28022665e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763774394; x=1764379194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBepVKYV1tqDt+M6yeXJGPjMchvP/4Ty5uCcKnUn5wM=;
 b=tBJ4hpsNVK8zT3Fhlg/w+EA+QeGeqWqhVNrpzXBtUvKTpqUcmyEh9MNoXRkBoT81rI
 fnkoNSTBt/LiZzjy5V/GPWVDgZ70ysGGQSIIv9D5XPFzvLDoKPJJGRXPI2hGhWneZmRI
 4g3dHhlM+n39+lNgqkA3A4WosWpT28M4J/jX+XOUSrPOjTg+JQa2F9k7jlluFA50CHQB
 gQjMofPbF5BRb8lJO8bG48JDsksBtqmr2A3NW7x8nV7Y002yO1eiu14tkwERx3C2BHEI
 e93PJQvPs0mNWnCGY9HsasTpGKe/4Sb6uyiNvKL1CHXX8o2TYNzhOUthnr4DBJmnqdLq
 PmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763774394; x=1764379194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CBepVKYV1tqDt+M6yeXJGPjMchvP/4Ty5uCcKnUn5wM=;
 b=uAKtoCCA4lDV+KYJ5SrlgSZXRUq44S1Sn5lMJ0a692skpyq+4qwK55/bIzOmA6IUDS
 ezdZ5d2PvkwvvV9O3hZ9cNcKG3RNJzF91xF/n7Hjq5LjuE0TlI0xBVXZpXizgFPMcBUR
 DyBd04+SWtE6cYZiC3+I/KYrD0pmkzHfKNJ1NIrJL9Egx9Z8mD1e8e9mltnm1Jcpufmj
 5+KpF4emuxOww80+63bFCNXvCEQ/5KngoKyEHrUBFheVM1rDISZWFm0lna/l7G3EKWqM
 vaDduvCaJOjnqNiY3sYRVbnyQ42qx9y+OET56YzvzhBWkl7DxJgsBeXs8MXkwPPA5C2u
 SURQ==
X-Gm-Message-State: AOJu0YwbaJmKq6gkqlMrteOeXhpA8NJjkCyHJa/fqCjelXYSyCPMWRmT
 fagbMO2G5Hob1yuKcqspFH1NN0+Nl5ygqLDIH8R20dpebGut8nbH+iQFgGkmxhLMeOG5HGfC2Pr
 GMyPjr64Y3A==
X-Gm-Gg: ASbGnct+aHX4JOhjhybDDiNfi8xxAaXW8D2u5PUDLui5sBSa/wTMNbuWjBcVR4bnITD
 dK0KPmuW+gxfZ2zAL1siVheqADOelQHRSnOjiOTxzBgUCaTfLmM5BEEK8+5MxxJxWoNvfXnk1qQ
 qfwazz1URyjVTquAET9f//DIEqvc9JtF39DSk/P7ug1CZRz37phDj3kigArjJmURlw3flW+jmaW
 uLeV2+V6epROU/0a3oLSM0cLnqOdWMxMNOhakFUN9w5PMshZomeBTf74hXvkI89GidMiu12OgLu
 oCtK5jeUiO9eb2jG9x3w/NOYEtMVSV7Of897X3HC1j9AqFmxSSrUxo39QFR4CGMWnA/bKEyz6XY
 E3mdlq+LU6DGHWevu2gXCF9yi1g5WIyqZTsstxLJ4ev6SbTEhQaoBbOBmLPSBVGt4olEQ5v7dJ4
 thjiyBY1T9ZHdxWW0NJ8FWObVjRctHfv77/d1YO0/HGBYGPXV6mwBfES5ALER2KfmeN+kSh5g=
X-Google-Smtp-Source: AGHT+IGNrQmrpxmF7PoFIbUzaaLYwg9orSTcPtVnBOTCdObQ9Ayepn30kjIe9MJIUdIx5/S1YODG/g==
X-Received: by 2002:a05:6000:2681:b0:42b:41a6:a670 with SMTP id
 ffacd0b85a97d-42cc1d51b98mr2460147f8f.54.1763732845183; 
 Fri, 21 Nov 2025 05:47:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e574sm11223189f8f.3.2025.11.21.05.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:47:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 21/21] accel/tcg: Remove non-explicit endian
 cpu_ld/st*_data*() helpers
Date: Fri, 21 Nov 2025 14:45:03 +0100
Message-ID: <20251121134503.30914-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All uses were converted to the explicit cpu_ld/st*_{be,le}_data*()
helpers, no need for the non-explicit versions anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
FIXME: Still some PPC/MIPS uses
---
 include/accel/tcg/cpu-ldst.h | 46 ------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index a3125fc9026..70442bd08af 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,52 +428,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
-#if TARGET_BIG_ENDIAN
-# define cpu_lduw_data        cpu_lduw_be_data
-# define cpu_ldsw_data        cpu_ldsw_be_data
-# define cpu_ldl_data         cpu_ldl_be_data
-# define cpu_ldq_data         cpu_ldq_be_data
-# define cpu_lduw_data_ra     cpu_lduw_be_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_be_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_be_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_be_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_be_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_be_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_be_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_be_mmuidx_ra
-# define cpu_stw_data         cpu_stw_be_data
-# define cpu_stl_data         cpu_stl_be_data
-# define cpu_stq_data         cpu_stq_be_data
-# define cpu_stw_data_ra      cpu_stw_be_data_ra
-# define cpu_stl_data_ra      cpu_stl_be_data_ra
-# define cpu_stq_data_ra      cpu_stq_be_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_be_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_be_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_be_mmuidx_ra
-#else
-# define cpu_lduw_data        cpu_lduw_le_data
-# define cpu_ldsw_data        cpu_ldsw_le_data
-# define cpu_ldl_data         cpu_ldl_le_data
-# define cpu_ldq_data         cpu_ldq_le_data
-# define cpu_lduw_data_ra     cpu_lduw_le_data_ra
-# define cpu_ldsw_data_ra     cpu_ldsw_le_data_ra
-# define cpu_ldl_data_ra      cpu_ldl_le_data_ra
-# define cpu_ldq_data_ra      cpu_ldq_le_data_ra
-# define cpu_lduw_mmuidx_ra   cpu_lduw_le_mmuidx_ra
-# define cpu_ldsw_mmuidx_ra   cpu_ldsw_le_mmuidx_ra
-# define cpu_ldl_mmuidx_ra    cpu_ldl_le_mmuidx_ra
-# define cpu_ldq_mmuidx_ra    cpu_ldq_le_mmuidx_ra
-# define cpu_stw_data         cpu_stw_le_data
-# define cpu_stl_data         cpu_stl_le_data
-# define cpu_stq_data         cpu_stq_le_data
-# define cpu_stw_data_ra      cpu_stw_le_data_ra
-# define cpu_stl_data_ra      cpu_stl_le_data_ra
-# define cpu_stq_data_ra      cpu_stq_le_data_ra
-# define cpu_stw_mmuidx_ra    cpu_stw_le_mmuidx_ra
-# define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
-# define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
-#endif
-
 static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-- 
2.51.0



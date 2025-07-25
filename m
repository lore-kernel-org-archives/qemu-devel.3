Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A58C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGoi-00011J-5k; Fri, 25 Jul 2025 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoY-0006LR-VT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoV-0000NY-KY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so1279099f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443729; x=1754048529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PinCpmwiiZ9d4MZyO9bt3FuY6Kd3BIPB1uqdmKrdfwI=;
 b=g4tJ+B7sWRVNuQSpU/TUbq2+5kfsiwOFcVlqRWlZk/2AgoZ4pVt5xr2+zTszTxxX8H
 g9b5Sn4OKoAk4+h5Rg3fHJuNgWBmjU9NWalEu8cQYnQdtCDcbRfqvDb6IWivJfQY4D5+
 RyKTaKCvNCCTTZKFvOgV8Z07ji0B2tCtDfc8zL36858/t/hMwUizMqopU6nNtqyoB7a2
 ELbmJMu8Q4dHXSARnbTzTBz4gh5uZ/hNcUiGtG5qggCQA5jYvsXM/b0O5uiN3UrFU5IL
 ZRD5/qOSMVCw84nqHUaloj1iu8Y0ql/FkqMCz4byGYtbsaisvybT80IxhOYg5RO8ltI4
 UaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443729; x=1754048529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PinCpmwiiZ9d4MZyO9bt3FuY6Kd3BIPB1uqdmKrdfwI=;
 b=FkWRHyEyuWmMdN4PMBR788pwoqvYBQXbIuGE7G7IqC6EcjdWdGd54E0e3NwjXZvD8o
 hdQks0USr7cHwTvqyc9HDog13+vXKNBlmB1biglj/+uq+7DzdnMvLkDJxY3qUkeFWtN7
 fY9yg4mF92JZPy6hhDch7QtgZNef2sSgIEWykRwT3Ls5zbnxolXgHZBVF9xctgmpsBJn
 YIzAZa1LSJnNX3hYHQ0V6du2UiDFPuz2RYlrwxv+7npGWPe7u0WXFffcbf44+qxlvWqR
 Sb6N3j40ww+7xwe3CcYnwnYCft0LEI3A+22Xwkp3UVGo6xg8j79oxjDljPzwtdUPSOcb
 3jKw==
X-Gm-Message-State: AOJu0YzcQL9M9MXbvQFxgbhoD3LzLGXsn5MEVtXitBwzOKtzX+R4xjBj
 ibQB2/gHjN2L/QdFAXpbasvKKwE7kon17Nn79ArMWkPYYpkVGlY1mfyBnSMwrXkd37vZJzz8qd/
 D7MOA
X-Gm-Gg: ASbGncu9/47B6jAZT2jUp5sefQ6Do/73mrp3laFw/tuOqCevT5uDL0g2Hzk6FRbeuP1
 s/NG37S0V+fg/YlehphJQKXmwfryQe7R+TYtb24bcpPrO8TjApEloWNzVDvybJVi3YbyAkPw8uS
 i9tN2NoUgA783jHieN6OX7+oIHhnvJIQTokMcJKqyGhmXe46rD81rYVLw4b5DhMFW8ZZY/uEkDZ
 GBQP/ns8qEi/vn1yUM9eGZrm9GZcTOW00RUCaMpPwPqLxEaqdhFJgSgaU6lqEBlgjxRFJVhwbxZ
 dI/QyhPIDlyb0OJoC383d1jLoRNFTRk3vONIk/PYL/bFn8M9dNRlSauhiJ+F6sBob4z50hiXGWB
 FEko5fJ+WPiCxdFDC2EXvvpVEY15Q
X-Google-Smtp-Source: AGHT+IF/3cg4QUqfpqwt5GdTqIaJFt6oUb6nIfbt9dxGMA3odmCP16m+1sZjYD+Fj1jBLx0/BWqVDQ==
X-Received: by 2002:a05:6000:40ca:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b77123f244mr4844451f8f.12.1753443729600; 
 Fri, 25 Jul 2025 04:42:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] hw/arm/smmu-common: Avoid using inlined functions with
 external linkage
Date: Fri, 25 Jul 2025 12:41:57 +0100
Message-ID: <20250725114158.3703254-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: JianChunfu <jansef.jian@hj-micro.com>

Similarly to commit 9de9fa5c ("hw/arm/smmu-common: Avoid using
inlined functions with external linkage"):

  None of our code base require / use inlined functions with external
  linkage. Some places use internal inlining in the hot path. These
  two functions are certainly not in any hot path and don't justify
  any inlining, so these are likely oversights rather than intentional.

Fixes: b8fa4c23 (hw/arm/smmu: Support nesting in the rest of commands)
Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f39b99e5269..0dcaf2f5897 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -319,7 +319,7 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
 }
 
-inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
+void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
 {
     trace_smmu_iotlb_inv_vmid_s1(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
-- 
2.43.0



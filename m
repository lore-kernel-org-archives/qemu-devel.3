Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD57C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww7f6-0002J4-HB; Mon, 17 Aug 2026 20:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f5-0002IM-7D
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:39 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1ww7f3-0004Ht-RU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 20:26:38 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-495b27007d0so2605872b6e.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 17:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787012797; x=1787617597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbzlCnq7BoCNcjr2oog9W53YJn8mdChq2YIHwfpzYtY=;
 b=E61iLflBnj+kX9UiamVjvGbZo44uVKee1i22v3wjBzghBtPWd2qQY7ZVPTD6HcBxUe
 +xGm+wElelf7OQfDQYnYSWO15+nprSaQ2coNb5ypSddFTrchArjgG7CeXiZlNKe0Mjib
 Rg4nBqyHL8WOU988rzGJdz3PQy3w8FkDW30k0cgJ6Suz5uo6O5TJop6F5/I+JfKCEn2N
 TsPMJTYUE/25zD224zUO/1fOPbu4KPAyCN+nLZfFWq9aAquUs5lKG0vqKl3EX2tns+we
 WYats9ry9v9O3t241sV9jlF0QILZUA6InTBnhbwzxpuKL4iev9ntbQg/3dCp2xdxkXYg
 omlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012797; x=1787617597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbzlCnq7BoCNcjr2oog9W53YJn8mdChq2YIHwfpzYtY=;
 b=Mefbp6dNoTIW/1j6D6M/wnnaoJwMLI6tQ/K8CYq70mDm9M0kBose6uH3ZjTsTLzNJk
 Ec50oJQZGmELv/fc09FGz5/+wPjlSR/SF5ke/uO9DJuswBQX2PqoD9By093/ZuaIa8Bo
 Il4xOFMLFB0u+nzqFi7+gyep2fP/2/hpOjIZvxg9Q6x4wB9rpgwnDlqHYgplz2RPE7/m
 XRPxr2HS1AgCF9X1bIo6/yybFnMShpszc6NCDB3+5Bq/IskhgxYGR++vyV2MynXrk5Rz
 pfAA8LEYpCPmAkeYVPBF71wHsx/ZJMIDWV0mtVeTpuwAcLNumMt09bB4pvuEIna+KHKq
 o6AQ==
X-Gm-Message-State: AOJu0Yx2C7zadZ6sp0nBKnSITi5YK4COk+bXZgsPnC1A8flCDCHsGjJw
 MPB63xA5+5XLI5d4g9UZSTsdGukbk9+w7KPOW4Iicztt/rnQNh89wc4Zz9oQqAZ9
X-Gm-Gg: AR+sD125tAEZEy0oZOjQZ0csMnqogBG+mOw8OC0h375J33b1guRLVLBFriszJBNnz8A
 isJ3lr6745C8n2X4BZ0UaSa6V8ROtmHLz4AbF7T9D9/iyt0nzrZTuEZruc6W4qURwmHLBcYL1Ud
 dOq9DDNIcrQRyoZPilxx9lQS24+dUaUHbV/n/Wu9eZAIWw7OLQmMd7FUpmvwdEeAfllZiunC93Y
 xINeYMDdK9b9Q+jnJ2MgUeyTwODsPmhe21yTrqIhjh6lrqabSL+KJEVEsBIMRJPPQIQodF95d/N
 ywfNvoe1VXLmVrSYA6WvDRlRtQ7tHXsYdnbSVE9Dla+pfAzbMcQoKOy/8PdTzu/xFlo4JJkZWsM
 ITLIT3cvDbb8Z1aiHf5mVJXk2dKGgpXcvA186OwfEv0lfchcYw4ELkcpV7rO5zQcXawtv9FtnXh
 xTQ97IdVa9dO1Gy4UmHX4Pj6RcTM48u1L7NxNm69w2OLBAdbE6QP65o7Q+J4gFoO93YuZvte2Nk
 j84KvVy0Kg=
X-Received: by 2002:a05:6808:c2f1:b0:4a4:ba4a:9ac4 with SMTP id
 5614622812f47-4b241bc2632mr25904607b6e.13.1787012796751; 
 Mon, 17 Aug 2026 17:26:36 -0700 (PDT)
Received: from LAPTOP-86EU4LQA.home.local ([23.124.244.239])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2960dfc9bsm1715165b6e.14.2026.08.17.17.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:26:35 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>, Owen Giles <owen.giles@hpe.com>,
 Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 4/9] hw/misc/iotkit-secctl.c: fix AHB secure read
Date: Mon, 17 Aug 2026 19:26:24 -0500
Message-ID: <20260818002629.172827-5-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002629.172827-1-simonxhy0404@gmail.com>
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Fix AHB secure privilege to read AHB instead of APB.

Fixes: b3717c23e1c0 ("hw/misc/iotkit-secctl: Add handling for PPCs")
Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-5-simonxhy0404@gmail.com>
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 54bfe1ba59..93753c2ced 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -195,7 +195,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_AHBSPPPCEXP1:
     case A_AHBSPPPCEXP2:
     case A_AHBSPPPCEXP3:
-        r = s->apbexp[offset_to_ppc_idx(offset)].sp;
+        r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
-- 
2.53.0



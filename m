Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75FCCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgWy-0001kq-Qi; Tue, 12 May 2026 02:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWQ-0001Nx-Cf
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWO-0004sK-8n
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso44286425e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566990; x=1779171790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qKmEe4LuuYggAdOjf4sUzqPh233gR7Hz+OandJbQdKg=;
 b=jxAbP6/N5IooSd7JjXUb7gOa+kthOLS+fSugRUrLGZp/y6BhfcYneSM8Jkh32+e38s
 1ewpfmEiaguj/VvFCkTXG0KTqXaNasRWu6OJLWpffIgYNxtpqBJHBuL8NLor20XmIW/2
 kO5dwRDDF1naE/YrBn0xDR0H4BcIyboXdwD9d91TNvaGJEpjUTueo/B1L159MtKqW7H/
 NdPr5mPoR6qQmONtN1GtJvDyNFctvV3wMcHqExF3HgcxeNCt2eNuTQjMXJje8gRvWfZg
 vCUhOnXi31vmT73KAAkhKV7nPLXjFxCprP+l8q2diVwdUZ0eoFalob2dpAgVRv7mjv6l
 0ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566990; x=1779171790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qKmEe4LuuYggAdOjf4sUzqPh233gR7Hz+OandJbQdKg=;
 b=ajBJRL9RapY1LFz8W0dsZVnVTPwDc89g/MiXylO6hUx+UnwoSolvCUbftWvFmtvhbO
 75xom81O8P83uyTvajsijHt4IbR2gVea/fZk7wIMiRBXUjJlFmM6BzLsG3RiYmGcK8qA
 qVlq4zsDRMdkXpHaxYyz+q9JDfZMiLM0vGkocHYNLrsK7UX+1wTCOFMKI9X23CmYs6y3
 vpBvUH7GmVPVbcWCLW3tDkx8UumdALJ6Jgh7c5a23IEGKSY41A1mWLltVip50sQVlBBz
 Ohn6pdZtucNjCai2YvPQFME0rIKLosg83gE+fg+ViT6L/6k5GdJ3XUegwDdkQWIDX+8y
 IAhQ==
X-Gm-Message-State: AOJu0YxHPECVOVCN10gL0Q+2WbKmCR3noSsYbMZtEShmnP7alQC7OCbN
 Gr29bKeGMSy/4tV0oJ4GXPIuhLkXNqjARZ7hkSvQablRJYNmZNpkOrz7kJyklnE0/OarxHt82ML
 JWh0wAUo=
X-Gm-Gg: Acq92OHBKDKUl87S/HqzXhfwlUAqs49L9kcPjxczO0KsLFR25k51VkXUNkJoV0uK9+d
 ANP3adflKFx5rXm00McbTSDSBm83W/iGlQgxmYHNk7SBAKYNME9gNaVGqwGS7oqIwuHyX6zUnDf
 IL2o2wJmOWlQN7C/cpeykWGduEIRqyPdCcN3Ae3sCPZk8TixSsUDSgpHGRQQc2rKfJ2zPJGPXNh
 NWrT1BuJLYDILBhuF4KnrsSlcB8lNkJGheE8rAZwyA83AMeXqbmSab2nZpKpQr3NNpSjTSrDgGM
 BEDtLpY2jntliqH1JK8IpT/E6RMU0iOpUP4ccqQrJ+ndRFnG7ByDjFZ4Ze6szASCA7RrLu1pMyA
 GlXvqvNNWppPh14xmTba6eg/TmwddeJ/54cRbGwvgdOotzscbkgALGRxQHKdaNw9w59wcdKhYm0
 8lkEeiH27TQk/omsruCOmf43Ws2hOlGvcDlk89d37KQeHvDYf+yfoWdpQOPFQsCrbtPEH403Uk
X-Received: by 2002:a05:600c:17c3:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48e70687ec7mr105686895e9.1.1778566989570; 
 Mon, 11 May 2026 23:23:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f429fdfsm10105205e9.15.2026.05.11.23.23.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] target/alpha: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:13 +0200
Message-ID: <20260512062142.67998-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For alpha, the get_physical_address() function accepts arbitrary
input addresses but may return an output rounded down to a page
boundary, so in alpha_cpu_get_phys_page_debug() we OR the within-page
offset into it before returning it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-3-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7ae..af6d7847d50 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -301,6 +301,7 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
+    phys |= addr & ~TARGET_PAGE_MASK;
     return (fail >= 0 ? -1 : phys);
 }
 
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97D108E1E9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQh-0007r0-Cc; Thu, 19 Mar 2026 07:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQf-0007qO-Nm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQe-0006Pt-66
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so1807245e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919238; x=1774524038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILd32R5A8XKeMpYg01CS957pigNHqjKdgnpyoMw2kbA=;
 b=wi3WcjX/nsjKLL+xLWCMw2hICs2UGQBhOBnpj8DJyL7+E06bulr36MRGh0jzgvLT5F
 rhbHKfpJAWAtSUZIe+efqAxiGfv5dshPqjqXyl3R75/XRh6uTUHaSi3fjlT/ZKaxdUdN
 6pMqoTmo9S22Un3AAcL3ZRYP8pTADc1uxs3fcqxKavY6gQpQwCMvkXyjiM5N33Zpg1/j
 T0cVzYqJ1HTYtUHOfrcvR4m89rrKL1hNtTXLW0BOyxHNKQOtT/jwEPkbpHUvc7kPx6dk
 YBmjzMcrGXgMxBjEeWKMHNMM9OIoyK2Hkhnmtu0pQZtdl5GD6I9eeX5JVcWMQqL5Z8PE
 33fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919238; x=1774524038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILd32R5A8XKeMpYg01CS957pigNHqjKdgnpyoMw2kbA=;
 b=J0/FJX+LnImwSGyFb2tYkJ9XNBYeqNWOpC6NiJNE5wDM2UmI/HqFtSedsoAwL8cDP+
 FxXUpMA0vFL7oPyBXnaaYweiOVuJJfD0Jw2xrO2REZp1kzXHX51P7o59kBLBnamUKAmm
 gAeEwOM6pQSCIQUvJ5n5JRtUZvdfltFyxhpzqY/bMfnjdqfXw/jRXsKVUnvKKAjo4IGj
 XiS/vbo+4lS5kLHY+rXA+iviwRDvLGZHGYrf1HlR6xOcCXS2xhvSjgrZ11wGV9wtk0FL
 raUCDBkK/ejABhw/YA+1UGsWzoQb3SDv+9UFCAeKy0N9+73wH+OlhX8hdPsfF9JwSNnU
 9qEg==
X-Gm-Message-State: AOJu0Yyqe4qJvQ8f4xD89ymZNiRN7EV2KcesV9xfJY3z8RaJkUI6k0fS
 O/DLPhScIoCmXOpjWRimRva3oeYxsHYGhINa0au+nRTFm3KCVv8/Rz194QvzJ0Ybw4oFq4ZGkns
 pcJnJoXs=
X-Gm-Gg: ATEYQzyg3EhvRD6P2AWEK63qduYGWFgtfGFN2hAN0qn2PDebG8Im6DMGu6uYrB3FVib
 xyIM96KCnPUxVO+/JffM3jxlj4HMhat1RVB7KOsmwzhC+XiL6PUKOe8ceTISpURoJwI3IrSPLee
 WBRcrEzfwiQBQMhabvQXZEAY7cuQbOCAN15V5LEmQ8ocJZsUWKEwgMxrLRm2UnviLGd6jine6Dz
 d4ymZ88HrI0iDHwYFwWsbTy4r55RHvyQvXsr3OrR8WkjiaAqgyfUmqjcSlmEeJiANYAheLUlpu8
 hIozQXvIE6wMdU+VgzQFDAdDEpbhMJaMhiTilTlpGlybhsljdE0M7F/WtImAN7suJXRrhZORpWY
 rsakSJ3RQXhCD2u5z8dI6D2oYYZx7t8Y5mOMV12SzFjJWSj6TyteNMOHJN8iTECmLxHTZBalYbw
 LRd9eoZ3DOufhEk81a2ITXXcBvO3lB/nimFQZkQnGd0L5/v9F9lSKw5QfrK+xNTLsBB50i+LdPS
 jOkQIJRQY4=
X-Received: by 2002:a05:600c:630f:b0:485:3fd1:992c with SMTP id
 5b1f17b1804b1-486f443850dmr121722005e9.1.1773919238343; 
 Thu, 19 Mar 2026 04:20:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949a5sm56957205e9.11.2026.03.19.04.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] configs/targets: Restrict the legacy ldst_phys() API on
 PPC
Date: Thu, 19 Mar 2026 12:19:36 +0100
Message-ID: <20260319111936.68041-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 32-bit PPC target doesn't use the legacy ldst_phys() API
anymore. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable
to hide the legacy API to the qemu-system-ppc binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/ppc-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..ae7d593bf0d 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0



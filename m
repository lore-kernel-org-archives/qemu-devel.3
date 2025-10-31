Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7E6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwX-0004OU-Lc; Fri, 31 Oct 2025 14:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwS-0004NY-R8
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwE-0006Bg-KD
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso1204944f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935600; x=1762540400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uC51IGSZ6aKIQJarGBBFkxEx1ZqCq4mk7PN16zUVOWQ=;
 b=op3ErCc7Bk4hj1AEaRQbtptDATL3I5N2K5fNrSAJaLkO/nUUx1XZOyGqiAAemZE074
 rlnjY4zasEOfhNVrC8aBNfwP5vZng5qLZW0Res6NS0bIQIj7rZrcbnN5N/2wJHvrles1
 nD88oIBv6QpZdBrxVPUdNSHUraA9KJEi7AeMJ3yAjlE2xAkJ8unrlu0xu1G282+dP5UT
 ILf3/1VNUAkTAHXSM5e49n6/WlvD+e9LjVTwGIqRc4A85LsluQb983ZlZzfKqPjduB/T
 O8K7c3L4sSTIIqL7zHBMzbeYVImVDhwDEO7RMDwbIZLC9nsTDJyaHgprsMf3CLR1f5lO
 8Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935600; x=1762540400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uC51IGSZ6aKIQJarGBBFkxEx1ZqCq4mk7PN16zUVOWQ=;
 b=LjJKOi4OGJ/V9wSLVTFFQ/8uH1ScNiyUiu1lZNLzQWB8fVJ3PVGsbFlCtj2PVUjnx5
 Y2yltMbnv0MAVpnT7/jeqzDgWOGHOcX907SkAqlyrCRwQAqJxWqkSZTxNAaPRXdlb85l
 qQ9aShueVIjtvA0LsjwcLwzlc1K+n4NaIsSBHRip2BBkgrTQ2z4yJIWG61wlMl9FZdqI
 8+bMO0P9xYy49B7fsQE5uNGbz2Hxphgz7liQHNHDeaXW8UuxW4hWzYs8ydP2KszgdXbX
 GRmqBVB5ctrzK3Iuce/EG8wtF2q91UJxWQGTQW0RCLej17hDy8ZwkaLpLN48rzt1Fz/f
 mmEA==
X-Gm-Message-State: AOJu0YzsjuCMAnavEJTYnHMIr3wk1V6pt2DSuoG8RyBTTa2WXw7GeOe0
 Ea6Tl5dl46qDWpYOsd8QD3FVJfaKy5ptijGgBGscAZxUX6kdGl2sxCyfyBwX/RrLxBD+1yraaPC
 eEE72
X-Gm-Gg: ASbGncua7R8iijtnNtRgIz8fhDT2iO7Hc+UMqyjq/HOvkvz7D24PBcq/r2TuzYjs7dz
 4nSVeEcB6UVtaRM9YGCxnrLo6ciqMy+I/nbdb4fRIMa1/GGDODuI8t/41rZjKTvIzGb7vbSNP3p
 d9Ij5y/q55G6UheQkuwxRxzDGSRnpcjucF8xiX1dM7F1VVMLyoJgfq3LKbSx8ClchCQ62mHUz+P
 JJmQi3/tDvWKTR5JV7otH7hiFVsjGTVKIJ1xAqVI4UimWtSg6/7LvD4x0krUKiD2lzhCI9wx15r
 k0i1XQNAS3c8KR+zn4od1EHf7fl8DqiEww/lJEk497zjWy0zqvTG6ya9js6AlSMUuFYkZBgfSpZ
 02J9NbeZByszPsElrkxihF9qTT3+Gg6OugL3mR2lUu3CV+hSFjRC0oD3Ikz3QpSsZMzIOqmIik4
 DahTCmbA==
X-Google-Smtp-Source: AGHT+IHnLoWrotTZh1sMBT9XrD+4g1qRpFV9gO2E5APbWAxu3F2oUWTWcf4Je5l41uY5P/J2FzeHvw==
X-Received: by 2002:a05:6000:41d3:b0:427:62b:7f3 with SMTP id
 ffacd0b85a97d-429bd6c1a33mr3981056f8f.33.1761935599636; 
 Fri, 31 Oct 2025 11:33:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] hw/arm/virt: Remove deprecated virt-4.2 machine
Date: Fri, 31 Oct 2025 18:32:39 +0000
Message-ID: <20251031183310.3778349-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251020094022.68768-4-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4d03317b599..751e22e6f42 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3700,13 +3700,3 @@ static void virt_machine_5_0_options(MachineClass *mc)
     mc->auto_enable_numa_with_memdev = false;
 }
 DEFINE_VIRT_MACHINE(5, 0)
-
-static void virt_machine_4_2_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_5_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    vmc->kvm_no_adjvtime = true;
-}
-DEFINE_VIRT_MACHINE(4, 2)
-- 
2.43.0



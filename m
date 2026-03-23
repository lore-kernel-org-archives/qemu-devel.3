Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814C3F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXJ-00048b-Au; Mon, 23 Mar 2026 12:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXG-00041W-TC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXF-0000a0-Bh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso3252335e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284827; x=1774889627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9xec0PufxJI+IEi1jZgcoZUa38ZsCLM2bEVrWDrVSGo=;
 b=o+yOhX0ANdGr/TKOcZAiCEViGrwXDKsTXxnRPPfKvF69I7HYDVcRFbSNoXzQEX9XJs
 achnVb0jNaodvqaxmEVDTaf/GvdO5TNvlKeH33UhTTDLMo5gwbk3DV6sOESogYDE4l7a
 q1TzdojRY01dkRuvep4J8t42f9fumnIAXhKe18Xz2+2r0d5DLWs/6TBxqnxsKt2JAnN2
 6W0eOqmGZVc1kDXAUhDi2ddZyYlytb2MWDEubo7RHR1Cip2HpCqaJg+JJOVGhpGhlA5b
 i+VVesW09gomUTnjX+Ks7DyEeilB8GSDs+8FCSLMPiIINP8KVf+gq5LEg03ox91XI6sq
 ggbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284827; x=1774889627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9xec0PufxJI+IEi1jZgcoZUa38ZsCLM2bEVrWDrVSGo=;
 b=IB+E3Ymy0/x0zsPM0dA+VFuOoOiaqaDmOiX8fCbwDMMYudmG0jy5lzLrrO7Cnr+M+3
 Ww+Cx4BX5cI3rlGKzZU86XEtgCi75xiMK9dopuLkEIiMEjhf8Ki5yokuYaxmP/Ocj5gI
 UJFgrkt7MkBFryLlNiD2bgNUq5FpVzkdKeY/IX/AWJVnNV3k3IB0BLXBh9L9H8TSZOPc
 vOw4yXD8wAjYYbuJkdT/nd1t0LqXRmXldo508nvmglOXgJdyX02qzV4a/xTHkaNCIWiq
 Htljyfs8vhvyLY8FjZ7sOFnGAca8QHinYGss3SxIa5sgPddaJnX054lt5bucX7TcyCFN
 tD4A==
X-Gm-Message-State: AOJu0YwRfLhTaMM4Byxm336ysahsx9ZqZI9oPAkusBHd755M8dccs54Z
 ln2Qm5j92XaBfntEYSnjIp/UovYb81XO9BUYVv/ULIPEkNcgwPifbn5LOmuFoby8OHoqv6izq2q
 0x452whA=
X-Gm-Gg: ATEYQzzpaM7hHmp8eobuQ9GGaz7oLW7HnMr4bWOr7aBQdYrfPRiwRkYyWcgEELB5Oyi
 Xde9SOo/O7uZ1i7uoWwrrKZDpYFKiMcpl89ZjtPJ+OhF0JJ7wkWe9W9pW80+Q33/UWU8gHr3FeN
 rF4ybVy9UgujB0xHzeXsItBWfepiJS1fB1zF7fmHu4y9Mm/XqEPaUv2Ijl2RH/QdBh+xKUoZ+eP
 Y2EEcIBISVmgzI3Morq0CJiBOLu0Xtfh1C9yDxE4qLXk338xTMdLmAKVXRpXnYmlpAG59xy7MRm
 DzhtP30ZIlgDyYhm5/fYRsXChqChxkYTYuudcI05I1ynaO5UGYZROcRY8strKr+J09t0qjjTPnv
 7X+i/HEDdEd6hJFb8V0dPq8gwXOfHeUo16cOK7/xyxREolIOKX99Y6IKXiW+PFXCqSzJMMfrKT8
 PQLMrGd2oDaG7be9Z1Pq1BmBUu3lkDjee1sy3GkgBpvo54wYwLzczllEy1avxtcZqA5npVO0Br
X-Received: by 2002:a5d:588e:0:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-43b6424e655mr19486926f8f.16.1774284827277; 
 Mon, 23 Mar 2026 09:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae37dsm31032656f8f.2.2026.03.23.09.53.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/27] backends/iommufd: report error when /dev/iommu is not
 available
Date: Mon, 23 Mar 2026 17:52:04 +0100
Message-ID: <20260323165218.96607-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

In case current kernel does not support /dev/iommu, qemu will probably
fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
since QEMU opens it before /dev/iommu.

Instead, report an error directly when completing an iommufd object, to
inform user that kernel does not support it, with a hint about missing
CONFIG_IOMMUFD. We can't do this from initialize as there is no way to
return an error, and we don't want to abort at this step.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-ID: <20260319205942.367705-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/iommufd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c03..e1fee16acf2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -82,6 +82,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
         } else {
             cpr_save_fd(name, 0, be->fd);
         }
+    } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
+        error_setg(errp, "/dev/iommu does not exist"
+                         " (is your kernel config missing CONFIG_IOMMUFD?)");
     }
 }
 
-- 
2.53.0



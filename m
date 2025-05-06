Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598B0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWt-0000O7-UZ; Tue, 06 May 2025 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVB-0001YS-Kk
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV9-00026m-Oc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso50602325e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542547; x=1747147347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cZw/ZP8Vznbis2zvfPW1P/VpXk0UFQxSXnKxKLB26gg=;
 b=LjWg66kKrtYUAMoCaNajwf/UYRPo3igwp4ZmisvawBX/mSMPc9BF/LXxiw5KfjfOOh
 8M0Mah9V37D0U0HUwaJHonldAw9Z1PeEQ9UP2Imax9Xh5txY2RXuHSYqNgURkpmizJIb
 BnRgPQ17dXnR9ZULoCaewqlotv0+nA2RaBoDVVqK53ABVoqbCpg28c3awy93TlWmqvGw
 8HGoXElqrYrtjNSpdTh5OQDM3nKH0afaKNBnxBwVgtoxQXBhXP/RRkMpzSU+vuBzjCSN
 fz1cc8IPXeHDS2iAnbXSmYOy8lGJoDQ3Zamd+rPMGVNhBWHQ5r644xPteOWAYzqDcVDC
 k3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542547; x=1747147347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZw/ZP8Vznbis2zvfPW1P/VpXk0UFQxSXnKxKLB26gg=;
 b=aekn0KWByGQG0T2w3cun0jwo+PLBSW8FYyJ9+pbl4fnbyRYxyciDZoWJlv/gO3JMR9
 1yVxS5IQqITqKyew6DIVLx3RpOn/x8WEWL2agNf7TrxmstqsDN7sWIGkoZ9XAx99+yDb
 wYekFBbTi/BHKKlJVkIx6A48Nq0i+HpoKsrEh/0peDMsTziNMpLNj4bXAtLKyCzXNCpO
 DAxw2URVZlasWcTIVVzSBfVw9vkm3NCZ1hpCN7SVG8WdO0jl/5Z1yjO0BQauBDv6EAcp
 iLXKTW8PAlnjUO/1MZXcV8yaUYYdIDM6T5yfCyxq8VdGUjUAZNbxH57jkmBmgN0rd5+/
 g21A==
X-Gm-Message-State: AOJu0Yyv+Q4z5PaDxAus2O8QFqN7uSEDKucf4lLKl2s55IlT/9Px+r7m
 ZECYINyX+sN40Bs0NF6XsD2uXFwEkbfO8IlwUc6ne17qaFhYLsZ3tSLpNt6T7KNByu6APcz1kHP
 Q
X-Gm-Gg: ASbGncv4z1VcB+vl1XwnSCQh+BTR7f0EpXV84ddNK8cqO1BWAqP7J9mBbx7qJdyQsrF
 PRxr0T+GTl3vMZtDHFcC3Vv/hp1FZ3S4nWKl329K8CaP3u9hjwxTfb6oNNrXqrGnBOGCxhbIUBr
 KLHH6VQipDBssT8pEJ8ko7r5MWlUGptihefzo0i28m4+SFDha3eAcCMQmyyUkvWQaDn26SuOA0n
 yJyf1vIo15872oelh8WQ8Ma3zOYfUzQ7GAs9UGIbEbKXrqppSuCQLdcpwJSkbkkJ62GbQcH4vpY
 6K2wteD5jfrcSW9PzMIR3UC6kC7Urb9L+UZsxcb12OST6tEeWrZ6B2+ngA==
X-Google-Smtp-Source: AGHT+IFblBukBhYFXD2+4Wd6Ecrt7dRmhubJl0sHEmUL1tpNf3htBxN+n6qu2PMGZrfCI/Flik5RtA==
X-Received: by 2002:a05:600d:12:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-441d0a31ec5mr33723555e9.0.1746542547360; 
 Tue, 06 May 2025 07:42:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] hw/arm/virt: Remove deprecated virt-2.6 machine
Date: Tue,  6 May 2025 15:41:50 +0100
Message-ID: <20250506144214.1221450-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 177f3dd22c1..17a88aa9b25 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3667,15 +3667,3 @@ static void virt_machine_2_7_options(MachineClass *mc)
     mc->minimum_page_bits = 0;
 }
 DEFINE_VIRT_MACHINE(2, 7)
-
-static void virt_machine_2_6_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_7_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    vmc->disallow_affinity_adjustment = true;
-    /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
-    vmc->no_pmu = true;
-}
-DEFINE_VIRT_MACHINE(2, 6)
-- 
2.43.0



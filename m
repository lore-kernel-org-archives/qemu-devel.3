Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5704106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxP-0003jo-Fw; Fri, 13 Mar 2026 02:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxM-0003SY-Qi
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxI-0007RP-SQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso11119755e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383103; x=1773987903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+iZzhMY7DdBeFcLPw8YSfAyM3ouyR4CAyM7GuS7FrM=;
 b=ubvYVwPg3snPLcB9ILcCl3hF7igyuW+oeUyBtCvKD1CDyNFTnP9SrlVLsUViwoUu72
 qEV8rAKh9BZcZR5Wu5PmKe7dc6vuY6ABFbSx2qOq9guldfcIZ+fZ4TieGHW4QihCm8H7
 VDcpMuFx65jaA1VXpNPhXoC0eiLymNz8s342FPgKAavD8BP/ej0MirNbwiR85gg1ziQO
 Yim9kqu9CieJiTidrkWjfcTH2k9Dxf6Y7Ifyo3TotBiCW/qwvYLXfXFXs5qDgtxAxaR/
 6zC3ExYcETz2aGJtv3DxB3E5MQYlFp2aLfKQhjtzCY+I2rGzjCobgGmIKpHvEmDZs+Z/
 Oc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383103; x=1773987903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b+iZzhMY7DdBeFcLPw8YSfAyM3ouyR4CAyM7GuS7FrM=;
 b=TeRj2sJtrKQK04C6FZxQTKAfCLhJ0awfDYg+5KQvIVr3fWb2mQ5u/KZ/s6tP9b5A9s
 MPJdkqYFDC16rJnh7fa4JdsUPNWvOIXYNmqQvP4htmm+Du50db4ym8c7asYhrdqB7l3u
 1nrQfVVzg938TLyTpyUhCoj1HrPRtXk3DTwanx82nUR3IfNS8hbtsSEnffeTvR6sLkTY
 RQC0esga2/b+B3N+XPL+HRGIQGMhE6vU0OBCAlW732Q0A0mN94Q8Tjoc290fsLfBz3vR
 R9dGv53r72GofkGKp5MJ2nZJh4FI/uOg9ptfOpmfqNOpfVs1Whb4Ht8SkUsFvbzNgACy
 f/Xg==
X-Gm-Message-State: AOJu0Yy4omN1F598qiGYinu4mMqD0axONRuWzXMrnEtiIG+wFLs7k+rP
 stnr0PlNEfV3GrOLJ2j1mwj1P6YEGKUcTly0zf9EeOeYz9J9RkbjeWAFPh3DrEWKp/rCmAZYqRT
 iJbX9TxY=
X-Gm-Gg: ATEYQzy5Kiw6Y5P/7dncRWWRFSPjsk2vFN8HkOAXekiGKQndJwyXptDKfZAujP5Cujx
 fagVQq7xVFv0TWbPp9p3yF6DTI+OkYVlaa6kV0q27o4ueM4zpUG59LN7SiVT0QxXa5J528uWXNj
 MC+W++rNv6ruDLewUq1vrKKAHhrVL95Lz7Y1SO/u287VUIdNqXm9Y57KhSL0A4dfCfIsfM0DOfx
 AXbYqFdcW9wAS53XAZ/XTaJzamQ/6M8l0sxPfCQyvU7ntMLszXwh9UyqLIkTuQWK77+O5e14WpD
 8PO7WKbV45DLQSQReDOwy3WMsqUM3j9ylxJvDgNP2j5O1VqLECwkHXW1J57IBeUQAkE9Je68yGe
 5OiUxFsxPsMEngyEfzqnonQ3fiypE7vT4KcAl+1Ca3Vf9dbeLlcEZRkTKAFcxTGLRoUboEvdGzi
 G98OMhWrgTdqGbXL333hJQ6OAIdq7s+ZcgOQlfWTi+dPAETE/+BO7d+n5wJz9756W2PSWd0XmRI
 x+nxo4B1STF7O9K
X-Received: by 2002:a05:600c:c8d:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-4855671052dmr28175645e9.33.1773383102921; 
 Thu, 12 Mar 2026 23:25:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6c24sm167966025e9.5.2026.03.12.23.25.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 36/38] hw/misc/allwinner-cpucfg.c: make compilation unit
 common
Date: Fri, 13 Mar 2026 07:20:52 +0100
Message-ID: <20260313062055.2188-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

include "target/arm/cpu.h" is needed because of:
bool target_aa64 = arm_feature(cpu_env(target_cpu), ARM_FEATURE_AARCH64);

This file is reused between various allwinner boards, including 32 and
64 bits cpus.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 96b6705b7d0..392d30b1423 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -46,7 +46,7 @@ system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_DRAMC', if_true: files('allwinner-a10-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
-specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
+system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
-- 
2.53.0



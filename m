Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B1D10775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uzp-00023P-MO; Wed, 18 Mar 2026 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzm-00021U-PI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2uzj-0005qR-RI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:47:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so249985ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856065; x=1774460865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+l1w5qb6p7Up3a9/P0k7Kk818jkXYKGDbz9+e7AVto=;
 b=QHP2r7qwuhlH0KbUinwBgkg04OuTFXzXYkBL7Ud30+vSm+5G3nrQb0Mt/NPUFePpsM
 ep7I06AEZmei51UT3IwUjbZbTg4/zAbEO8OJMD/OIF92WITPKSwpsAQiUWW1wyQYowKi
 6Wka9HNK4oEBYfJRCi2sxuGSzKjOcCp0TkD5CqGaGmYg58m99rskmGMcobAAxv13Bebx
 zGy/I2SpjUxO2Tq69Ma6XDGoDfjxR/2B8L/eOa8oI2dy/Ik6zC0bHL0P3zyk9/lFNEky
 xo0xiAUF62rGaO3woKVPItWs+vtbDICAAmahZSOOZbq6s2P6N20zOqtJZ4JXYDYwBdEr
 Y68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856065; x=1774460865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+l1w5qb6p7Up3a9/P0k7Kk818jkXYKGDbz9+e7AVto=;
 b=Jai/prHZChY0lgccNiQaw2Cij6ZYC9rhPdk1BGjQuG8pF7RD3vLhbD2tLfUA4lPhrO
 QCAVHutpN/QtZQJmbLjkfpbgTzNAaQwHkU8q5VZtxveFX1eYt3W01nCC5i+8WGDHKRXu
 MVwbjmXtVGSozvtJ0bM6EpQB15/cuvneuzyY+HyyD64iKan8//v2bx+zBPz7cof9rlnm
 wYMpifZxVL6KeC3CHZgpGDyZv1G/MsLnXvj9p1MoI9jRadfC6ANxHP64VCOZXHMSWGr5
 KHD8GQ5uKWawMFGiTLvLHZY8b2bx1WagL8YNClbQ+xSmXKnR4Vjri5NRFp2hYXvuoNBJ
 QDog==
X-Gm-Message-State: AOJu0YzXqSHBBDXZ4q/bGOXjKV7KpX2hQfYSaroFOzb7SKiHFb3ZQJKK
 BwTbYlBsj+2ZxWjxALECXv4r5cZDoyRKZsT+sl/qKHSvHaQ0foMjVMDuy3SEHcTW17CSecKw8sM
 IT48xnNM=
X-Gm-Gg: ATEYQzw3wiKTmIQj2/QUpq9PCpQDePg0vV7p0fbGBAH4VDwRLYaCnDjkj622b8NEDOP
 +1hzrczla0UJ51gWb0dqcIKh21zFXl0CPc5gQusGlaU8cUrsko7zfs7+7AGPrbCJkCgeazsL6cL
 Bvzw7K1xy1Z8P6/VD21yefqaiGgXjujxYlicgUQTMDmYqaVpv+BkcI40yryjXxxWfEsE0YxBtz5
 gdoEMsWew11poS0lVG8ArY8Tiz5RHv+AwQzOLRrS4mot/o0TGt01qZQMK7F2jnHLqmL4/wpz247
 B+bWxRY5SItu2YLcaV7x7kRkVMplvvXllNNk6SXaplO4wkVEEpi0pS4rS0CMiM1XjTk5fptin50
 jFo0Wcnw4/oIktN8IPxbyTDenm7JuSrliv+cuDe88YSaiAU/FlRGKiKO26x5kY+SnAGWAsk2E0E
 MdE7Qtv+3Yd+0rKlkg93j48ubvfKY0CVRQWQ7HBj0E8yqWMw7tsWuwGvAQSgBj64+PyF+2uiyoo
 eXO4mBKnGEZLvM=
X-Received: by 2002:a17:902:ca8d:b0:2ae:4fc8:3f5d with SMTP id
 d9443c01a7336-2b06e4399acmr26003215ad.48.1773856064856; 
 Wed, 18 Mar 2026 10:47:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5f0ac2sm34066185ad.52.2026.03.18.10.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:47:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org
Subject: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
Date: Wed, 18 Mar 2026 10:47:33 -0700
Message-ID: <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bab5f2b7f15..fa0ea6ecf0e 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 stub_ss.add(files('igd-stubs.c'))
 
-specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
-- 
2.47.3



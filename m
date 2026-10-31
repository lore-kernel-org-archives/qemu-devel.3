Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGsVssfq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNAWy-00013f-Mn; Sat, 31 Oct 2026 10:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNARB-0008P2-S1
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:07 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR9-0006ZL-VK
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:05 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-369f3e9e431so1284361eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458322; x=1794063122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNaO0wgwi4Lzs7E2ManR6jBV5/KErR0RmzXMkUIskao=;
 b=eGsVssfqxSU6LtYhvQiAF7HrRYqbiCxDBfxBiTUMU1vFPBD905s93Ju2NZQlLGmlcG
 V78mU96nWsWtGRkXT4a1d9ArBrDT530F+/Km2swod5MTLaUFj0cn2Xz1S+0QOBbcSOsu
 JM8f7R5TyghuvkPyXNEv80DT6boL9D/ih/fVFFx27SwQdveAembGrguzsTKBhFTqYDI/
 TQw5by85M7umudULl4Gv5sxabDLgYftnwml1don33JiY5v5Omr65Mi422kmoXX8F9YOX
 2plYUoMJGnOxh7RDiZXJyOvWCEmrtEe04Bnkd9BxnYAjWZb6CwjKM1OOGeMphGYp7T8a
 JtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458322; x=1794063122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uNaO0wgwi4Lzs7E2ManR6jBV5/KErR0RmzXMkUIskao=;
 b=X3UZ46CjYHorIu26qLOmi03zGFRaBPSmbglV2EZy466LwLiwvPAolnOh075WLTNXp1
 JqPSoVSqCARnXgPMdPSD2b9GVRATckHUlBoPBVGx+NTduIi92iFiVITWDbxQZ52SGORi
 fSBAaMXhfdBVr5BRu29+N3ueOSiMx2/wo3zVCUXMyrsVyvSbCz9lN1Re2ig8Qfp3M+zV
 KA8eo1T8p8riKxxR3jQcY7i8TyKGXIf1dKWwF5tEX66jlSuAOOJcsLTqFAiMNcbMYB0M
 b4W9xKAPgQ36ZEtBYGF5tEQm5K1cm6a33jbWffKRo1n/VCOygKiWGuwYQuYXq2UABmQR
 Xibw==
X-Gm-Message-State: AFq9FYKazcL8XWjkj5/Y7482y6MyvrlYBknp2C3uR+2ERGc8baxgfvkh
 oTHsO5wHbF6tod9MUrvIV7yN3iPCkpi4a27yfZB/K98JRutySnpsjW4LNcFXuMLH
X-Gm-Gg: AYBFou20emk5kItuqYHfKmDPe+VQzg/cXBoNg4L/9b9QlCw++g0tw868UZxj81ldbRi
 W9dsxbd0OTSy6zlOYyC4NbRyyFvsRqVaWeO/Sieh108PwQBmW5lyz6/drsefVY4dEPkUyp5ZXSF
 XCP/9vBhR4sYhKy/2DOHrgLalD3oA3xBPxK08LWK9ohYcIOWTlwrvVSOKBiCg9F5MWugKDbtZZl
 VIUsRJlaHyqelR4d6s825V9qTrqbP+xsXZED1Tn9otaOXFgVa03QAaoByzmqn7niGCNag2sfkCR
 IfL7vguPlXLQ32rkIpqbCMlPw+38rxB/UnKbUFiMQEbHd3Z6WL25x0XnW4vpdqk3U0tEYgBh/w9
 uNsnn01fwntsfzu0cUNtPe+FElXilu/kW7cZeQVZrFxbmRySkPQTBHciWuAz4N9Pklwm+SfZl/N
 7WYFLuJaMBZntUBkfa+bzDOFvvoAa+Hrg1nb06gV0hSNOMcrAf4vZGrBPloxd77qbmQM5tKlTh3
 OA5EPGu9DMHuTtoZjX2qHEzrEyf1hF0Ra6o9N5L4h/kgVshFF5fpOZXKCigc8l689XUL4zTa0ej
 IPbJtKPUTa/veSW0A+WWLNLgwCsqefQe
X-Received: by 2002:a05:7301:53c8:b0:36a:22de:d85b with SMTP id
 5a478bee46e88-36a2fd48fb3mr11289751eec.2.1793458322098; 
 Sat, 31 Oct 2026 07:52:02 -0700 (PDT)
Received: from ubuntu.lan ([2405:4802:913e:86f0:fc32:76b2:b6d6:a3f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm17541006eec.6.2026.10.31.07.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:52:01 -0700 (PDT)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH 3/5] hw/misc/allwinner-sid: Separate ALLWINNER_SID config
 symbol
Date: Sat, 31 Oct 2026 21:51:45 +0700
Message-ID: <20261031145147.32683-4-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031145147.32683-1-dovankhai97@gmail.com>
References: <20261031145147.32683-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 Oct 2026 10:57:53 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a dedicated CONFIG_ALLWINNER_SID Kconfig symbol and select
it from CONFIG_ALLWINNER_H3 so the SID controller can be reused by
other Allwinner SoCs.

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 616beae7bf..21480e277d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -309,6 +309,7 @@ config ALLWINNER_H3
     select ALLWINNER_SUN8I_EMAC
     select ALLWINNER_I2C
     select ALLWINNER_WDT
+    select ALLWINNER_SID
     select SERIAL_MM
     select ARM_TIMER
     select ARM_GIC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 685b7ff1e7..1639978874 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -268,6 +268,9 @@ config LASI
 config ALLWINNER_SRAMC
     bool
 
+config ALLWINNER_SID
+    bool
+
 config ALLWINNER_A10_CCM
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc3800baec..059d4c01a1 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -55,7 +55,7 @@ system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
-system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
+system_ss.add(when: 'CONFIG_ALLWINNER_SID', if_true: files('allwinner-sid.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-dramc.c'))
 system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
-- 
2.43.0



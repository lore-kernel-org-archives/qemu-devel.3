Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2E606FD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qL5Q/PpS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSugQ-000611-7W; Mon, 16 Nov 2026 06:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueg-0003wQ-0b
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuec-0002DW-Te
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2971836f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827616; x=1795432416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U2TJBdmaT9802sOwSLNMILIxCRxhEyMKotbJLoaw8xo=;
 b=qL5Q/PpSRskrwlyxRXSU6xm1XrQCdrWtQYrRQpspZiLlqqic810je2ootepU4G6WpP
 tzKpA7wPFnr5ei3VkMAm9p+g+mXaoQDhKupgK0XAVyZVq/o/H6WeyXQ+Qesjk7e0dJDo
 /VC5Gq1+iuf748XtJF822xZLyfVmgKijCjuiPaLvI5tuMfH88oI9iD3KW41F2erRQzQO
 fpZmZfHOCqkqS7tJm4EWRYK/hMYN30c2Tl3n3/hFfbXTJ9nwREvFIYHCdUL/vfml3kwg
 JyXeJTUdB949snc0+o08WR1UmPJMtzFOU/Hno3viNa8Lo6Cm+GhL35yjGQeeisU3BSD7
 XcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827616; x=1795432416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U2TJBdmaT9802sOwSLNMILIxCRxhEyMKotbJLoaw8xo=;
 b=fFmZmUfdSBRwCasK1RSMi/p8MH5lfewQZZLbyJ0YD/R8AmE+gZU1Uek1LQWa01vRqf
 J44MUp+KFismDVBlY47u8aL/bEFeWr96h1pNhD4YSQ9XscK9tbSRQKlp2FXV74UOpn9v
 kfzE+LsMQeCOMAJcgZamSAMp82adbX3ISKDqXMsUI5xFpjaDnjrzAf3HfUL/C6r3o5n0
 WkAobvCcVPJQJxCx1KSQdKMassMS5IiUoRr4jJTMv1wj3Oj3p7ioyV8YUYbLi/JtQ2Eq
 gJCT+gKBJHprYNHB2/VcDp/F1mZFCHMyvwUILkuATS1N25a3Rb7yhkwKAhRa07fRq3qT
 NEBQ==
X-Gm-Message-State: APuU4Z+fpz4fgr80uNGj0Mp0cqcZokxsyUsrq/IRDs4/dx9osZVsoTFL
 3Jh9Y3u2Rn7b054BBZKSJZAr4EOasALwkzDs99gUDCiqGC1A4gw08mv0InojX5+psjMPv9QsKtT
 HvHFbYh4=
X-Gm-Gg: AZFdTZe/0uMrv2hh2a+PTnicTHVfnoNG5KOGrZLuIpHdb7YxwJxJplsx3dcCMbKk9IH
 YyAIaVtIZD9IyMtM0N2OBngv6Jf8R25krn7D9aet7ddDvJ0JwlXLyMpyX9iw2JqoM2CLEZGTezn
 b8K2lObLOAb83qaMwWCgL/XZpaab1KjH5Cmn5QdSzQv/cBUT6WiU3MaavL3j16cYek8Tud1jqjY
 n+c793C7CiHFLURv+Nm4OXxoYT34PSeU6Q2BJGJOOiqkdblq1sjEcnKc2a9AWy3RjCfiWUHFqH4
 BWPyElEjGK7m523tW1NuWtWK6Kf/wRxrYFPHbffoz6hzWj3Hz4PyFuxbJaa0HyGlIQZPb60hVkL
 1UFxDf0q3AAYwqULghfUzCgeR/9k5r0krOEFdy1RWemvN3KN0zSaBPNdWgpcE9onWtoT9OTxV2t
 ZQhjNhSsDRbNZLlh55lDcMrr+80PmEJ2Wg2HUdVH4mRvm/FnhGbhuV/ZSKYoIQ1rW5OsenjC5Bo
 fNccJQMH6x/DmdKCGqkSSKQ/VTlf2RhoHlcJaVmAAAFHJKo8p0VFeAe/6xVjc5APyoeLK2YhXMs
 LzFCwIASbRGzW9ABJB38Fy7kOjGLCKopVMkiX4qwxW+bv4l/eBDN3zqQk0JO4Vp4EwhQr2xTbUK
 ifUBsIIBQEwqkc3SVNt7rD15c3a/bd7YXrQ==
X-Received: by 2002:a05:6000:27db:10b0:49c:9e8a:31ad with SMTP id
 ffacd0b85a97d-49c9e8a32c3mr15104672f8f.42.1794827616274; 
 Mon, 16 Nov 2026 03:13:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/33] hw/arm: Deprecate Nuvoton quanta-gsj board model
Date: Mon, 16 Nov 2026 11:12:58 +0000
Message-ID: <20261116111303.1692832-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The latest OpenBMC release as of June 2026 no longer supports the
quanta-gsj board model (as noted in docs/system/arm/nuvoton.rst);
support was removed by OpenBMC back in 2023:
https://github.com/openbmc/openbmc/commit/ab5062cf6f562ad0c844570ba1ea0089961848ca

If OpenBMC don't care about this model any more, it's unlikely to
have many users.  Deprecate it, with the intention of deletion after
the usual two-release period.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261030095731.581512-1-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 10 ++++++++++
 hw/arm/npcm7xx_boards.c   |  1 +
 2 files changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0891bbc44de..de7d502babb 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -287,6 +287,16 @@ The machine never got fully implemented and can only show the firmware prompt.
 Given the incomplete state and slow progress on improvements, it might get
 removed again without replacement.
 
+``quanta-gsj`` Arm machine (since 11.2)
+'''''''''''''''''''''''''''''''''''''''
+
+The ``quanta-gsj`` machine models a system with a Nuvoton SoC
+intended for use as a baseband management controller in a server.
+Support for this machine type was dropped from the OpenBMC project
+in 2023. If OpenBMC no longer care about this hardware, the QEMU
+model is unlikely to have many users, so we are deprecating it.
+Users should consider one of the other Nuvoton-based board models.
+
 
 Backend options
 ---------------
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 9c526a26839..ec4b530986b 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -496,6 +496,7 @@ static void gsj_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = quanta_gsj_init;
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
+    mc->deprecation_reason = "No longer supported by OpenBMC";
 };
 
 static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0



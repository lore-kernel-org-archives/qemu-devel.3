Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424A6D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZov-0001ct-Vg; Wed, 07 Jan 2026 15:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZos-0001Zr-IX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoq-0002FZ-ML
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so16436235e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816466; x=1768421266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fa5NrbzDfN4jB45m8/tRLk36haRcKLwCy8459c3N8EQ=;
 b=z7cprh9ClWte7P1Gb2i69/tkdY7r/o5hjvIHmoko0iN2nxg/EkjYJWXq1cBx5X9Jdp
 q7yBrhTRsL5GytSUJAXwz4hNsHZZrMdYWM0P+SaVZEWE7sOklxyxU1JMROrRg/avrU2M
 WuNha/QIqtz9K8liA9sdWX9b6ezmKvYSPPRj7xJh88xwNvruyNtP5ZzesbDGFlTp/Acx
 0v2JTAcFTawVV7gi6uMFXQ+DjYcCew0YxXw0+0gMAf6wYM+spvogvZ6LeCWSlQ5rzWcR
 UB27xWAVlRpBgOQgrw6xyhePiIFdxmOtwaT8ObF1Ge6/Nn4fmhX6ED9FBjQ9EQ1xsKQ8
 Iv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816466; x=1768421266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fa5NrbzDfN4jB45m8/tRLk36haRcKLwCy8459c3N8EQ=;
 b=ZlrptIDjIDrbHlosFqEtR3VollX+CMkHJ8ZAHlQZkbEl61vZKRurILHNG9/H1XPIG4
 qeByefUHVlel8jArY8XowNuIjHo+8YV+QCKyw1Sv0qaQK1YHoeUJuDY4Q/dAkNQJwhcP
 7H11rbj+CcBq6bfhn5WQkdjeiz4pdYngNjyKslhT0bH6WlB8EJrctsbUH7agcb9vqIPf
 sYbemvOqUwBm5R5KWqIzs57QUVU/izf//D4/5y/OKsC+paVkrzhIwdY14FEwv0LI9hd/
 1xraLiLEzJ05J4Mya1I1VjOtObObOhAnfYt1jH+NRlfkC9wRwHTSymwu9nDICv7YZfBZ
 AcDw==
X-Gm-Message-State: AOJu0YzCirhWVfQXkTrbEAhYvKqQzTzJXfATg00Nir8nwIpJR4dBtO55
 sx6ratJANWaC752SRfY1u+PzWXMS1nBQ8uuerMlbeC2JTdtk0vhFC8xvVvQkp0OI5cs/91GEdI2
 Fe8yit/k=
X-Gm-Gg: AY/fxX5Q0TfVB2bHZ34GDsW7JTCRstPrCANgD+i60C8FVD2o1B8GfcnAr8AOOAtSI+r
 hfsoAGxz/sRKIOS1OM0WWZNNT7wEjrttDnudLGR2ReE3fHGBwPOGfuWr9fw6rKxNAMFvOAcO4Fq
 japh+ilINgWMM8VXzv+U24SCbZIKfhYYd5MtGgdUMOroo0SmREYhw2a7tWw+XPGiGe8uNHod5WU
 GJ7yjgerTGlb84O+rhT7dvnA6l9MnERbRwLjQu+PKgtpC5Ef60v6CHiCzhVORZ0YiywRNoM412D
 vPW4BtZMI6lemkNN7H3YM1bfY5qkP+9Pmse3FigUMcgT1WZ1luP5szcx1H9VrY5eT91glU2qR2w
 gLH0HJes3UMi22eNC+fdza4GF/KDiiDEdCGQgxx4Xe20oYqR40zkbFMMurTcwnvWsGW+FcFL6Jd
 17A/yevxqiZeaaM5uwJLhv8ClA9VD6b8Lt9ga81A3NgQ7QusbQ8Dqw0O3P/Qky
X-Google-Smtp-Source: AGHT+IFMTvqxuW+wSdFbZUnnBRIVryoR+Q+ih2+fhPFFWvQHYNxMYM22C15VzPL1tN/2SGQiMwTyTQ==
X-Received: by 2002:a05:600c:3152:b0:47a:940a:c972 with SMTP id
 5b1f17b1804b1-47d84b18752mr44204945e9.4.1767816465855; 
 Wed, 07 Jan 2026 12:07:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm114577875e9.9.2026.01.07.12.07.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] target/openrisc: Build system units in common source set
Date: Wed,  7 Jan 2026 21:06:59 +0100
Message-ID: <20260107200702.54582-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Since previous 2 commits and range 2795bc52af4..5b67dbf1dc3 we
remove all uses of the target_ulong type in target/rx/. Use the
meson target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
index 31608b6dc7f..d51ea1ab753 100644
--- a/target/openrisc/meson.build
+++ b/target/openrisc/meson.build
@@ -22,4 +22,4 @@ openrisc_system_ss.add(files(
 ))
 
 target_arch += {'openrisc': openrisc_ss}
-target_system_arch += {'openrisc': openrisc_system_ss}
+target_common_system_arch += {'openrisc': openrisc_system_ss}
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B330C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMPV-0002BF-JX; Sat, 26 Sep 2026 03:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPQ-00029Y-GO
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:21 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPP-0000PX-0H
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:20 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664e061cso1769006eec.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406077; x=1791010877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WjKPIsB7XPfjiOJv/P7w8oTcFul76ata5y5bWuKERHA=;
 b=K41XgtDN1x3gaHo++yHEnC9AeaANzJKHb9w0mQ3b9KVLub18iGK9anbWA4/E6qUjqI
 AZJghq5mnB3vuqrPZV6wfNGlJzaGLkqq+X3UsL2JPva7yR7Rafi11ty3vRUHg5hSSyUN
 VpJR7VX1y8PDOGGcLQ+gbCu0zhxaZ+dEMmiTxjSfTfqW4/xIgdW3pnnjLy66w6nz81Mv
 LYHDvkBSsjB2pO7odrebpUIDht+ZVzsy/5DlM3jo3Bgsw25f/HVofKqeNEBmThFvbofQ
 KaY182ybWBoFwskqn8XkBNapwmBSA1coBVsACNbTRL1a3nuVFRTzgFszGfHD/9pe6qzj
 UtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406077; x=1791010877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WjKPIsB7XPfjiOJv/P7w8oTcFul76ata5y5bWuKERHA=;
 b=SMlHaZnxlzWOsgTDS1IM3YO3CRBZfenNKYaloaeZeK3nR+pKh7cWGyoA4TGHYdHSix
 qA0NpWtKGA1csP+5tDi/DlpyU96CEbcE8nXLb+pI2DvVFcW6nnQ+xJZX8iaIxuf18jcl
 11jenvmj4PNP7E3k3Gy+6KwQP4vEl+VziLdRrbNtynrNHqPBJjYQSeThg7Pwx0yL7Gje
 JRczy56JRAeTXXRRG/iDCOK+NGyODD//uSQFFqpWhWBW2GR28+8/oGSZh0m45UetNqqJ
 +LT5tkUp3NnxjhtDrsE61DWMAO5J5i3fz9BUpKhp+Ex+I/U8JFR8XimbOLrjtMN5uUQz
 wbOg==
X-Gm-Message-State: AFuF++kGUWvgMFk1c/CahZ5P8bpNCob3VkDw+rbgGLHGtM5xbP8k82XA
 2fN1T05mF4e7QxML9dCYcDBkg1pRo+sJ8vxIpwC0cszV2QT/HoP7s+ldBePU6N1p
X-Gm-Gg: AYBFou0IbpyY11prI7ednXBpExg7pLXfGepm9tsY6Sch0t+we8J20MG7rWXYiflkxst
 nA9bApJ2IKVX+o6jfhTwXod1/c1CB7xLe0jV8suOVJ22tSYBEZAArmT9EYUNUc83YxIN9uni5eV
 QRctwXnx/Hq7V/tfFu6cHPix7m6Rl+XIsM3zwswRmleZXTtg5XCxKCxNJp0CzQmf6IGVjjaCOnZ
 rh2QcMzH/jK0GpvWWT9KbpfgD1I/kX+SvmtGdgxw9pa3keIYCp6WJfhJjL6TD9I9A2wAj0aZlmA
 7QOxSB08vZlWRekTw1et5IVMqCdYGOo9MFdSCmGZ9+aU69zIrqqhWbQsJE0jl2fPq3wie30AZcz
 nDthcJbpIZOxPw2EuxWrXxLBgIVEJbclG+2EK7aqH/ytQWM64pRR7c4X72Y+HdqMrhNGy33CX2s
 hP67IWsE5iYmpUwtf2166u/B12MEaC1wp3u+TxL5O+CKF9tRLbmHAAqgkQE3QD9w/YuPWlh+vIS
 i5xaFMNIAzLWF/HoovKrFN4w51tX/Y=
X-Received: by 2002:a05:7301:712:b0:32d:205e:31b1 with SMTP id
 5a478bee46e88-342705b8903mr2066052eec.3.1790406077527; 
 Sat, 26 Sep 2026 00:01:17 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:01:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 03/55] target-info: rename target-info-stub.c in
 target-info-def.c
Date: Sat, 26 Sep 2026 15:00:02 +0800
Message-ID: <20260926070057.1234-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index 732f0a885ba..51bc0905294 100644
--- a/meson.build
+++ b/meson.build
@@ -4330,7 +4330,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.52.0.windows.1



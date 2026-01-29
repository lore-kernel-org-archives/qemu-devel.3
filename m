Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C765D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyX-0004uv-5E; Thu, 29 Jan 2026 12:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyW-0004uP-5a
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:36 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyU-0000gu-7N
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:35 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81f4c0e2b42so716832b3a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708313; x=1770313113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NXpbQqzZXg6RDvTPuhPR+5gSP2cGuSgQ3VkVvuuuIs=;
 b=e8c2LMJlvY5hipvA6t2ixJFHF7Pm+r/1B04EcT8VPiQctdOgZG0TAZP1iGgVSxYtH4
 uVWpoKde//VJGQL4/3nDX2oHFYWSiBHYEg9E6PwkQl+mzJmxCPNCpt28AhR7/E8oJvUZ
 qL6NRsd7RpZezzShK1yph6xIcQlruFC7hVuuYomb2b6yRKpOF8jZCiISMzOJulRQqnhB
 HRB5bMy7dOEhoSj1dGiAfg1bElRPNHDuEue+PdHkK7Bilf0onvyO9we8fMnytT+dwIXf
 n70hkqP/mIhET6jn+Y4vds7ELNwQlJWuiCLEYFUvS3bVPYf+IHlkIZffLTbpz1n+0sG/
 FUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708313; x=1770313113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9NXpbQqzZXg6RDvTPuhPR+5gSP2cGuSgQ3VkVvuuuIs=;
 b=kd4fuBgV7iFtl9Zc6Ud/DMWMq5bHQ2GIV465gcERGbuEzhikPISLPgI39BSaic39c7
 RhutO/K0yljMQ1pSzI4Qh5Vp/4xICQ2dKNuLRIdrS9VUFzhgcuyiO8nhO5d+1qcAg/qy
 RzdqotgFBXaSOm0b2xYp+PgWGE7MluytRgkBm96t4xsiRd3yF236CIGB+NC1McMKi7At
 etqCfM+Wnecm/Nv0prPj0fdj4ye6rM5c1pcwFARlCDcYkXSr79t7tG1TfIsj6uIy+pyE
 1DhTx890rVmyWE0PVjSgAIuXJ+OXWGISNeX/dWBYFc3ILyyCcPBnxyx592QdBlSEooyR
 ghBw==
X-Gm-Message-State: AOJu0YybcKGvu2qBDMc9cSQmzCLFuJNvo77I2lrDuZviImV9Q0Pk6+8l
 ZWE3ABi2C6rVR4HfOHdE06wAFARfBC1BoDr06shUhIUFJYTlWVXumseJzFIpEcGvP3fFOlOa5bX
 9UZw2
X-Gm-Gg: AZuq6aI8ASembbpeVKEgoUSaf8yZi2y1QugZ/HYDQRJ26bbrAY2GlR+B32EceysbzDB
 ZrUSQ79JWOnOMqlWcf4ZmiTB41Sw/Afm4NAG/J/98Q0jnyHpKVMrIS96eF0NuEMmYJSeQgUpdP2
 KGw+af0HotQcrN9EL5JVi2N9KaMxepTvizRWo9FWTJfPbAA+zJHNVGn4l+ODxrVRM4c+yUx3BAT
 TAxoahuo0U4G4/B/TJNWRuVuRDTn1dj0RjMLBJ0Y5ZMCB6Pqxi728qmyAdq5gEtlqpEWauU5HWv
 XEr8rqG61HxtxYP52iCEjzFydG4fWipiR1j2p2HZjk7tGum0JE+HDQrsRLc/3yAf9gCNY9/PFsE
 dyam6h0Zy5eVyqNGTTzHn8k06woZtRrpHXyE2u+70jBzo9Ul94kpafXppQ6A5ieQJPB3JvtMcYK
 HgBuE0rQvdAA3D47yXfKiDkpohG5UXSeTa2J5A/bMYvpW+rdbpyTDvq7PLa5B3jpWg
X-Received: by 2002:a05:6a00:2e82:b0:81e:4476:f67c with SMTP id
 d2e1a72fcca58-823aa3fd494mr158810b3a.3.1769708312658; 
 Thu, 29 Jan 2026 09:38:32 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 19/21] meson: update C++ standard to C++23
Date: Thu, 29 Jan 2026 09:38:05 -0800
Message-ID: <20260129173811.138036-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

C++ is evolving faster than C, so it's useful to enable new standards,
especially for standard library.
Update to most recent standard available in our build environments.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-11-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 149655058a9..8c6c0a9a32f 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
-        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
+        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
                           'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
-- 
2.47.3



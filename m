Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF48C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ6-0000eX-FC; Wed, 07 May 2025 19:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPt-0000B1-M2
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPq-0002Y6-Jn
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227b828de00so4514625ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661385; x=1747266185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=KGSLWXlnYjZ7wR+ltuq3ObW9aRNd7sq38jnxM80HmZCtVF5AQfnBPGiP1G2lt8Bk5Z
 RgF/D+R9QKMdhao4Gn5OqrvChcpTkQfPuktfTEEmXDB28qCU3bv3auVKS+ask+0KSZz5
 q75HtNMXM+eJeFI3u+Pdwv2KGYwC3r3S59MXFjni/L+FKA46tckvmnOJkA49hMQofF58
 mXeOikJ2DDDhv+TK5YagYpHRQwvLHQXo78FqCIi5FLnNsanPkjWH2y70/Yk8N+Nkz+mN
 XHDlOsUqkI6xyJvmKVDbo69kbqHdqKbNkv8WF4AwL28z9EThSCEE0JaTBofTwG82w2o7
 gTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661385; x=1747266185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=ps8H5JnIQ02ZhWIudMRVcluaLuUXfSnUHNb9C9WoRm7ljLNBRUh/h7o8DH541O4AlQ
 2qDLXbetJ/Zs+I5UpUCDMOZjXJxUWs0gIx4jmDBNwu3QgHfAm+eYuVIMx1fTqGYXWD5y
 xOXFid86MXG3jvZBgaewtQYDkTm64AHlgAErRaiOUTNNXJlEip/gojuANOiGEtf0r4U+
 t+vGRH9iRWmASV7NMWvrKC/lHuxqs50tTggwoBntM9XFmDkTXoHvEKs6scLqeVNgbmzO
 gWjiI1XEReqdj+yec6Tx1KG1LhPYfb31YVQ4j3EFZ5kHlbdnM8nW9AaSkWHpElr2f630
 tHwQ==
X-Gm-Message-State: AOJu0Yy3OZt/68KA8/pC2wQnW4AeIWH0J1ZpQ042GLdv6gkHT+B1Q/aR
 EXTE8FUPLsiJbaO19Zi0o8nOd/JITz7HrRCDZ4KMjNvONCjyYWA2VK+FAu8DbJhbjjd6MpBw27N
 zR7DEhw==
X-Gm-Gg: ASbGncvDGjUtcY33GLk0Wb9z/LQkLkV2Tmug7/z+4KAg5j9P68LpHlhMkAF9LIJSXNo
 FOieWgLejlsVmLVVifbKPX2wb+ZjT5mFenDlHSV7dKR0HYqeWUezobPdryzhd//y1PI0ThTgBXk
 UH4vBdYbrf2BthnQGQFB/Oy7ail9BLZyfLHcfCgQYtn7q/1bSF8P5PPwPAXeHo/QsulsKxufbc4
 7uvdp2iW+OgKUcZI4CvYK+rJfUN720W29PCtypXYbBAPhMZjb83mNFhlR2DRopY6Hsl6LwgN2pJ
 ZOIXJk3bt9tjlqnU2Zt/tVTqVKlwt6J/SULk8S3P
X-Google-Smtp-Source: AGHT+IFVqPCNhJ/SeZ4WWES//nY2YQYeFl/MFJZQYr21OLGxZWrJfOfR+lX0wne2fBbdqAzOq0UHOw==
X-Received: by 2002:a17:902:ccc9:b0:223:5e56:a1ce with SMTP id
 d9443c01a7336-22e5ea9dcf7mr74347735ad.32.1746661385074; 
 Wed, 07 May 2025 16:43:05 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 25/49] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Wed,  7 May 2025 16:42:16 -0700
Message-ID: <20250507234241.957746-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.47.2



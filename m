Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33620C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLs-0005v4-Gb; Thu, 01 May 2025 02:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLP-0005JQ-C8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0007Qq-Nv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso626219b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080659; x=1746685459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smxeq8t77rmr1khTGCWgeqn2IHOGcCtHx62ulud5haY=;
 b=P0jaRw4ZqvgwJpeR3sVHECyN7pBmh1GIK2c2UWra5lDrtuIF8EqaakiJRT5K1QLmrn
 /OtgJGQTjwDWaqqetORVXCZhJqm9gz2ynaTn+YGIQpOZjpVgs0PULis6vULp468BKeW4
 7OJ62S1Xj1eMUsvQZXra52LxUDRbNZh4oQ4C+0q/yITX6b/7rpssU+R58QJOPR7r927u
 tnRBHR8pbbV7t6IOWs4zn834NXQWTp8TB9/UDz6H4k2uKnFE4OTbkq34R+Db/TrmvIgj
 A8Z1rsZ99A8y8KG6ArIlQIA61LJI7nr6YboCVezrOb3OXQBaqlp4ckLzatOOsymsDQLT
 1xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080659; x=1746685459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smxeq8t77rmr1khTGCWgeqn2IHOGcCtHx62ulud5haY=;
 b=fFjEdlrAZggFxYR86ypvOoUBDf3mw6HDkO7JzQeBz7z71P4e7IiS8JJggWFLj6mM13
 Q4T3i+d+U8M4mhIj86QebXNMNX9+Pwk7lqGO/HSKdPcBLi4Gb4fdGxfIz9PjWNE3G/h4
 NYy3FHILl92abl4UgbrnI6GzmHrMVEOnZuP84zWamghHSRys1c9Zt0PqvtxxNaF3b40P
 aF6YwLyy1aQ/6q3C2iFD4PfA9KA44bWbN7+xTHEs4Od2gcAsJKTfRxTfUYLlMS+QA3ef
 j7ncslfu7Op6EsSLS8KZsOlOMs6lmVGu/Ta3dHQKwPtVuUCFaK7ScNyroE+IesIxvB9F
 RdKQ==
X-Gm-Message-State: AOJu0YzMmFCvT5JNv4yzFs3y3f2wQv6IrOasDl1x4Fris+iOxs2uwOiM
 0wzlvC9oE4IirLj1leDIcaSsXhnMXYNdIuyVT90xfVqVqkCemRIHxXxPja49Z7MfqcmpucEx1Mr
 x
X-Gm-Gg: ASbGncvPeQn0z7P1QYlPH5gwD7TVX6uCyO+VFNOVSNi5fTPhnazDqszxwmeD4le3Jvi
 7Q4PmUliO67Ga8T36P04uyU/7YkfxclKu5uXB1XJ94cJFzVBeRC3YbX/fkuYwcEcEt+kFkL+mpY
 e/RpcOC3Fguub/TeAVQYK01sST6pBpuQKxqSdSrrNLGsg5R0GYYi9P/8v6FkRkprjj7SsCrq1aA
 EyQhVDlu4kYwpf4km/trkDs66HLOmLtN5nedknV3SFXujwV0o3gJbxJWggwxrub9BWkv5DH941Y
 c51EYvtECHPmi1W0R6DN9OaeAQ/BP3rfs/VkEWnp
X-Google-Smtp-Source: AGHT+IHG4UGGkkz608m5AZZyK3bj7kb6xgjT5nZou0FUnCfiy2hpqLLhUwXRyD5HV3onb5k4znr43Q==
X-Received: by 2002:a05:6a00:1942:b0:73e:2d7a:8fc0 with SMTP id
 d2e1a72fcca58-74038959453mr7648202b3a.1.1746080659119; 
 Wed, 30 Apr 2025 23:24:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 31/33] target/arm/ptw: compile file once (system)
Date: Wed, 30 Apr 2025 23:23:42 -0700
Message-ID: <20250501062344.2526061-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2



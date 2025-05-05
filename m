Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5022CC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl18-0004Ju-MN; Sun, 04 May 2025 21:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0u-00041N-VB
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0002cw-59
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso3973775b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409976; x=1747014776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=g8r7YrlB94glQ7ofZYzPbAbemPtoQw0ZNstlvArG7q8jwPD+zGy0vg0SgGoNfSwLo1
 wgNJwhTP2NAxfJuqWb1zlEbtiIAXyjDoO6WmwxF9eVyy+XxDgDYyoMF+yZGLcKJapITn
 S8v5wQjNDyiCTmCZO7DAvrCImBJ/6E+lKLCvCPa08SKA6cm7H/X7za3Q9Su8YJlgaWf3
 UDxLD48NnyZrLgTCiTVBP2DQeVqpZ0rXYyI6V9ezexNOTehogAcxOvBfWjfQXDc/XOjb
 /Uf3mrD0+tUTOwLEjTKMZOc47S7LFZnTezRsjdKq/hQfkxbNiYiPtQzG28oITn4598lG
 V8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409976; x=1747014776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=AXy01UyUM24h4ktfXTfwALNPIrx3/plSp5N5uKDO81TCfXzs1nkUtdp7ICWYVCbC4v
 eGl5EiA/MHCYK1G/IXNX/s1i2Ozo5ZazWZEmjCcrxSqGW+pyh2LHvnX1VczZEo4gX0vY
 L3yA4ewWnLUilQnj2QEJ6/1IRC8dxGdcMw6ijZJOthQotI15jIxqhuiOUzbaUNqeJ+nV
 gDOmHm63Q3jAr2JanfTUWGPY27T9HX+oZUK61h5FQml8umyL33P3XgDjKjefL5IlU2e5
 flP5iuiImYdCoV1uv4kwxXKF5iQB1KRJcVhmJQod8Zyj867PTFk1HzqY7uPw3wVWSje9
 Mpdw==
X-Gm-Message-State: AOJu0YyKkaN6FJ0b7D3SZO7kTMtnnOGE+oDwWe08IVHbmhH9wl2ixKZF
 rSBmcGCtuyU4dlePSVpKsbTf1btDBgMJPfFOjh7AL6kSunOTDxzwD6NxL8vGL/BXiAfZbKDkBb+
 +y98=
X-Gm-Gg: ASbGncsEsKWqJod4tD9BqP298PWVCPUysopRMFdMp782NQYKEjzQkBXYYwKEH7qwWWB
 mdW4RXBtjqDFKUvPm/NuA7BESsG2u99e2gHIAM+7vyCBp0I4rpN017omNi6ZsHnKpkPYZRmx7O/
 zIFG8dWXxV8aP9sXEmoBZvpcNexKNf1s9M7GHf26Do58xbPvhutF0lc6u6cYm97l2Kwl2RRoelQ
 ntOnyPFqhFPHOsdXf+PUWSm8hp1vvWqYW+AY4+a3xZP4K6psr20jJbgPMDZAn6Yirp3WmFdMoxQ
 6zTBuYjP7LSyf2VR0RyaDqofD9O1QC975CkDw/IJPqpTNKsVPWM=
X-Google-Smtp-Source: AGHT+IFCVf22Y8b++NohiLhDf7F1rpFLdSCNO7L9sTB0r+8DXUCBJ/9XAzockGK74r3gOY9XTNVHLA==
X-Received: by 2002:a05:6a20:cfa9:b0:1f5:8e33:c417 with SMTP id
 adf61e73a8af0-20e96206094mr8736271637.2.1746409976114; 
 Sun, 04 May 2025 18:52:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 30/48] target/arm/cortex-regs: compile file once (system)
Date: Sun,  4 May 2025 18:52:05 -0700
Message-ID: <20250505015223.3895275-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2



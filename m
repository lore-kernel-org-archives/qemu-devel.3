Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5902BD232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56f-0004If-7R; Fri, 09 Jan 2026 00:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56d-0004GM-FW
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:15 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56b-0003hf-UA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:15 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-34ca40c1213so2178316a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936732; x=1768541532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngtjUpvQSnSSXFkGDj1e3aXK24fPju2STHLXexCxl/M=;
 b=KBLfmKwvobQDcuJ2HiSUby1I6Gh+EuPQjJOfhhGsbkyECHqoQZHIvP4/cEWtwTRMCQ
 eDkCLN+wEvfOt+0/SEmRh5M4Vv2DEvtxzHQfPeN1xvafyYjhbaet6TAZ2JovCcG3TJcx
 kOnoGrcicJjsb1z0KAQazcbvX2JgNYKqzyRiQ02LNzlIr5WAI04v+vbJAHrZUHdDqvv+
 mmlg/mHU+oCLONywHQQ+i5cgON8faHFKhELhLV8Nui1NQ5AGuuYPeE8qgYy6raRJFYgh
 7qd1lpcQf0ua72aTUnkzx04ifNo6QQGJm9Y8/0wHOkGtu3jMcRVAchdGNW8Qlb6YqCDi
 i5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936732; x=1768541532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ngtjUpvQSnSSXFkGDj1e3aXK24fPju2STHLXexCxl/M=;
 b=a2jK47m9LN3/180tS5og9/TJTPHnIrWwzuWrc1KDUEqLoHHdNsS+jMOCoUgAYD/lLw
 O2Po7Wf3ZEmx4KtHen/jJFrcjqoqxw2qAdtD+axfI2B8WwXzFiO88ahHDZIk+WUs9HDb
 hLgsdqoZoAxhZZorE2flLneGIc9INFojlDFyFbk9C+T9w12fPb08933Ne3zLm9H4++ng
 0KzuDKhdHq/WVxiH0fgnRNn2HiJDesH19t7SMCLZVO7IZFn6g+I0zBpC5X09L/SsfFXW
 J29mGiNGncDV4RVl4A+Q5gxvqBYBzyp9J+bEUgPq9fRGA8DoDuujGKE6nFLqfLM+NOMw
 sPVQ==
X-Gm-Message-State: AOJu0YyV9jrd5MtFfXnw/rXpy2zT5BKsYrtr62pgSMzhT94RvpW6OY4U
 GXXWqqTlgm3YOlxc4e9hcAVKikgSFfRyMM3r0O15Zeh2Eo2CI3RrrJn/hDPYF944LN0tPG9NNE2
 rL9i7
X-Gm-Gg: AY/fxX6/QhOde4Hgh/s5zwOw+/WdAX9gA6LShAN19IDxdyIQiAywfTvHcAvZtxJbIwl
 d6vsCj9pAz3UjS6JxnRqgTm/GqW82m1fHxsLlmfCHhRBFRWbq+QvpJwRsedDxOm9cKuWMjMZhqy
 4vtqQexRTGONkk39x5YFHCcoNVkF63pPcf64DF5Tk9ecVHJkPUnDvW/ZSfvXW3F3O0Aj2NZPM1o
 lPsTvWvyj7ikku/3QY1mx/VzRdhDUUSDQvoiMohcNJVN7J/JeVDM7yN4szyLRZ7btAi9WXgpdtY
 4TZPyAErfsQo9nehg0me6zr5lwJmOKklGJpTgqpp4ITh+E2vdNeFDsB8OFkj5pq9IYZiYdaM8Ya
 dkorgLOKquikv9E/MmDKqZ59D2/S9kr/xo3IGnxZ0lPzfGFa6wyT4TjHN0JMdGdRFqJs1FdFsMe
 1bz/e2m+giduDGAOiNeoIMxvZmiC6e9pUIdugUsybSkzu4B4DDRGUwzrAkatlSbPsx
X-Google-Smtp-Source: AGHT+IE3hDLlAF4cuN/33hrUO3fDEn6GSpqnPgH1SNYiccGa1KACtNrJzSdSkKBoSH4062+hj97aYg==
X-Received: by 2002:a17:90b:33c8:b0:349:3fe8:170d with SMTP id
 98e67ed59e1d1-34f68bcf7f4mr8117647a91.3.1767936732355; 
 Thu, 08 Jan 2026 21:32:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/29] target/arm/tcg/psci.c: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:36 -0800
Message-ID: <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Now that helper.h does not contain TARGET_AARCH64 identifier, we can
move forward with this file.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/psci.c      | 2 +-
 target/arm/tcg/meson.build | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 2d409301578..fc23d62ed94 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     uint64_t param[4];
     uint64_t context_id, mpidr;
-    target_ulong entry;
+    uint64_t entry;
     int32_t ret = 0;
     int i;
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1b115656c46..144a8cd9474 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,10 +49,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(files(
-  'psci.c',
-))
-
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
@@ -67,6 +63,7 @@ arm_common_system_ss.add(files(
   'cpregs-at.c',
   'hflags.c',
   'neon_helper.c',
+  'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
   'vfp_helper.c',
-- 
2.47.3



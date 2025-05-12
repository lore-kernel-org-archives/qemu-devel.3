Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42B5C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXY-0003ST-Sz; Mon, 12 May 2025 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWo-0002RF-KV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWk-0008TY-Am
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:25 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso6255715b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073121; x=1747677921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=v2uYadwXtJPGuuGkheF2TEGKqEkR0KbEF+kAfqrXuIJbFxu4m4Ww06w+gBjTh/ACW9
 ycCgKJaBLLaMtDOSZ6q12qfplrBSE0FAdHo9yGQEmliYVNj0FAJuAcv7Wf06hv1iadW/
 KUX6TACcFZDtcgecBVqsd7xosJdbWcpgjro4qJ321NisfgRtDXL2Br+hwexdFQsZ1RiQ
 Ru+wsmTHrru4o6IpzeSimfoh3e1Nuw3kXR3gu7oxsQuZrC6ovKokeQ8PeXSwiK0boYn1
 /mnZJhEzYP+m/vXfRp5hNSOWy7KErCtFS21hyfGhyDkTEm+5dGSycEElqCl6HOMrYVE/
 ARWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073121; x=1747677921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=o+LV7F0fQj3BQsxcBW1B+D9+K4w8mbliKa7uwB9s7Q9KHUU2Umsl6DyOXlSra8UEqo
 DWxMHqmwv51Qko7FHrZZbdWp/ZRnOsNgOKcMZ3wK0lxD1NuTokgFNT+61gX16zL0BsaV
 gq6d/eNxf4PwJ0j9gtug7zLXrIghkVmHF39cj5Dv80NP9XyiJSK4q1AK6zJr2JwKcXpG
 gLwiA4ohGKzsFa1txE32h85fuy6DtOEApnLZAZhfIPawSDfWPjKyzIrD05bSG+anBAAN
 wYXc503kSfleCpdLW8x32OxWHj4Vp98uuGGDOTwnuhTZPpqoqUDf6m3ydEMr2PWOjvOi
 0jRg==
X-Gm-Message-State: AOJu0YyO5DB5L4CKxBq4ndLEP85cV4ZhhBJrJPZdhzsS17HxSXXUu721
 WCW7Rh3yu0umapoCDlW2fy/yqdszhBcyx9ecK9yqjr0Jrs1W9PE+zX+Fq9khX6AcpbfFvIKhmxp
 e
X-Gm-Gg: ASbGnctRe+opz7BYQwNieO67IR39SG4XblyxSYf1Eg/qrbgedpEZ9AkCh4e16+HWaQ3
 OYfMni+ScWgNHSMpeqcQyoKOxtv2GXAMiC8eOoAU7ub1q7aqp2oBcwh4x3A3TyFyUby5MXjRkOY
 IgYzD2OXR3IvPNUtw3TgLX4Qsdk3IvZPbVPmVDDoXWj1bMB8w0GXs35hoM5Kz81uzh4ZfRVoaHQ
 6oLb64WcR3FYVGJD9kLW56lsM/7VxrsYBENRUxtHQWazpeGsJl0lWD/U5+ch8BNlhEso+azNT0q
 1Y4berzG0isQFKINVuDIr4eAuR09VtW4BPg+qexCsVn3bE76LlY=
X-Google-Smtp-Source: AGHT+IGQ0jT14jyzTd9oLZJ5Ff9RHlx1LDHlzLtes2Wc+VS1ksOBLnpI4eSNg5NipXT2Z1Fqyejf/A==
X-Received: by 2002:a17:902:e810:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22fc8affe60mr200210875ad.4.1747073120819; 
 Mon, 12 May 2025 11:05:20 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 10/48] target/arm/cpu: compile file twice (user,
 system) only
Date: Mon, 12 May 2025 11:04:24 -0700
Message-ID: <20250512180502.2395029-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2



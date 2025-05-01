Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C39C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLf-0005aB-6G; Thu, 01 May 2025 02:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLL-0005G6-90
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0007Lc-Jm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso721655b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080652; x=1746685452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miCfOFxcLwOy1CTNdjQhs14VDpxTa+yf7od3eWjLkPI=;
 b=Rf9B4NpAGOByjkKSCmmhelkfLnDbVMTQ0knng2JZVqzp3ONVZHHcZDLwfFqN3tdJib
 wAZFUtcbi4nhbUaFGurYf5+Swz3cVQmGQ2mBFWlpgv2bWhAa7X4KweBhMYpST8T90jGW
 9ymh3mGcJAaIBGGkK7B4DB7MC+BtVJDiVOMJuqGmDLla52HUlvD8zIChekwM1/FOhYrV
 rPVLSKKZQMIWyfNisWr3YdW+COlfTsY3fHn7S1kXk0moOQuiCRNP5TV/Vz3pW7qduk2B
 kYgbwzx1Z/8dqsFBAn62db01KPUeivXGW0Ve/LMJNriXkkjdeMCnuejDag989l6IqUtV
 J1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080652; x=1746685452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=miCfOFxcLwOy1CTNdjQhs14VDpxTa+yf7od3eWjLkPI=;
 b=QCNz2ZJBqWEiEyC76p9gbyvfgscVTlRKcoHF2b+gAdj98YUIApYDpS8LRnDsoSp1YR
 AZIkfR5ySx9sh7Id9hjYvUhEVBBjwUPzs8v2zDXG2OgF8H+c30Jt/0RiGfHrxXWC4cZg
 NDRrk97Hs9AhZju2stqyKt3Y0m84W+AlwwucrFL3yMWCcMd1/UIab9Ggp4htqkyW0H0B
 9YCyU2YeJ68dRrTKqC8vIKRiaIgsb/SqtdsozsnPPbHbNTlwrNlCVtFEFWUqIXx28FAF
 s4Obq5SNqLg4ZHvW/oAV+SdT5yIOedu1ipNJQ/tBaouv/oPsip+56v8JC2xjyrYAOZk8
 MgKg==
X-Gm-Message-State: AOJu0YzlRUMN/RQuV3Dz6BSFEIRerGqn/IEsjoEnO+1dXLhSSxDGutJm
 AzBoZNDJh2uDH+DfKzCYRYspZqAZLN25xdV0FwrQVCtpfJt7MzzYasQbgQZUmzN/NYRvAjqRKj2
 D
X-Gm-Gg: ASbGncukoaGXnJAyUj7W7CSfnU1W3VeDfRRiO5iSUs37oNhPgHoTHep4U1xjo9+bqO0
 GknfiQ2arwdbeS2Zikt9hieAiZink6gWnkfMp/eRh7VzCoIBCH0NvHu/NANWpOjVgkTnZcY0Vd3
 20ziJ9SU/z44J0n3eo/9pplcHPbLOI8229klYYgvHW8qhReby4ehd7qXZbURR8RaI6Ddb0DS4Vw
 DVtiy2Kot+LP83KY4hAHiePz/Xc3FYf8pptZ+mMV2g4gzOyy2klI5as4+9efpOMUo4FXEj4UwtT
 seGaqWkhvooVrekAIsqph0MFxjBoytXdK9+4RIpq
X-Google-Smtp-Source: AGHT+IE4iNMjCRGNXv/fseoNykwPT2G0LRq1qk1LIkgMA+iLCoJoZ7bKEIOylarNXH7Ek9PQxpdm2g==
X-Received: by 2002:a05:6a00:188b:b0:730:927c:d451 with SMTP id
 d2e1a72fcca58-740492600d1mr1992567b3a.20.1746080652023; 
 Wed, 30 Apr 2025 23:24:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 23/33] target/arm/helper: compile file twice (user, system)
Date: Wed, 30 Apr 2025 23:23:34 -0700
Message-ID: <20250501062344.2526061-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 48a6bf59353..c8c80c3f969 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'helper.c',
   'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 ))
 arm_user_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -39,6 +39,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 subdir('hvf')
-- 
2.47.2



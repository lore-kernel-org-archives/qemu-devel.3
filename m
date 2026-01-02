Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D046FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0U-0006lK-Sw; Fri, 02 Jan 2026 16:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzg-0006fr-Cw
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzc-0000J3-IT
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:36 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so15181895b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390450; x=1767995250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JfIRF2rFr3TmpkMzwSurtenlCN5AxfALqStaf+SSlM=;
 b=BdeEnM7HsHxCHtULg4A0Gr2EG60BsZQ9KSDMlgf9ecIeQBJdvG68HVfKF4fD6KzsKj
 6nzyUSZ1V+NdkwEvNpiESG25C9xWdyj0gVTI4OfQWK25sktGS+gw6cNm3n7PdTnNcERq
 3tLARKpf0Gm2sUga3HutrMtOW9JNc8ou64egzIzP2WPC0xYoa5A8d7SvYss9YpU6X+Xb
 0H3FqJWcKtGSUwuUwIFPPLsQKuBnDlJFu7rwhKwUSIoMJfkwx4W7BzsJO2pBAxiOV6NI
 ts64ia1kYO2fWFSKE8svADw3POubrc+t6ds6tkF+BSqAppU398JNzWatMB1QjCpLnlyK
 h6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390450; x=1767995250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JfIRF2rFr3TmpkMzwSurtenlCN5AxfALqStaf+SSlM=;
 b=oP4PJKbWcF6eL/JPqjNmcRvNd4sQUwU807biY+U4zDSv8BwG9annnEePJimxJAxpVd
 DIqqrhKlZ3a+SwqKeczEHVoGwvWL/4NYiEl4uStwWKRDTWPJwUsojj5fKgc0cOkSi7GT
 VXckHdC7AIMjdd8iy3Kpawk2NyYcLAQru6YXBcLnp1uYiK4fGVy4s2ueyhiOlapPP4nG
 MefX041EEtnXbRU81Hed9RAzdyqz0aWVZE68qBAAkrotUvCQNzAnJwgslu75HVYIONq2
 tWX63APwpTbTirRLltzejfIuFqh3VUp4yc4x2oN3YuKnMomkEJBWz5gF/DXgAuROZ3En
 f9Rg==
X-Gm-Message-State: AOJu0YzJkaNLDXyQKbGibGxKg7dTiEGy5BjsSLM4iZiTWtvSVzGEQckB
 4fEH9OQymyiNQrdfv/QMfrhtyqUrp2sjS1sHe8d5deY6F0hpHj8bi2/3/Z+Ya89eDHMzyC8Ggm4
 Zpo/i
X-Gm-Gg: AY/fxX721UMYZshzK+BSGOXPwi3zR2eizwFaugnHrVDNbUkicDHk+TF6I6snz5J6MdA
 xr3rDboYSiK77k85zbbwvbJPV5cuimJNKe+wwOtt0Ka4bjshi3iTfT460gBROmAfYImqRGZh9B/
 zZ6Sf++L7L7OEHr3SLLZIpiEZhl3anQgXhD7pOw0Y6d0dJ8Som8BXrFFq5ZEACN0bymLm6ZoELJ
 8rQjOzJGkw3e3fcIz5t5+NGB0s6UwogM33A6Ez2XzlZ66y7v9Tt/VHaLMBDFjxDm0fahp5OVA9b
 VrDV7B0t8bGgtL8uFNTkOP26sI0DhFZSoKFjHPAVXFO3bwZTerF3vv2+CCXz6EQtqT9tYgNCLON
 CETos3L59INLKsHnZfBzphh5S/5wDxGePhQM9RxRfb4qN1gjQiZops1dlrUopNT/1y7Ri83g9RS
 9khbIv+sN6QOpSseV3ok7gsi6PPkvpNbH8TrSalL5u+9Bt9VMSC0QmolU7OUVJ91Bmo2lP2xar+
 9I=
X-Google-Smtp-Source: AGHT+IExRCcBYwKbvL0R7qsPYqt6f5uYYRu/Y8uVPCotLsCOUspEVTGDNVsV+1sA0sRDFRvccGG+RA==
X-Received: by 2002:a05:6a20:e290:b0:364:13c3:3dd0 with SMTP id
 adf61e73a8af0-376a8eb6c35mr44162513637.36.1767390450277; 
 Fri, 02 Jan 2026 13:47:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/11] plugins: move win32_linker.c file to plugins
 directory
Date: Fri,  2 Jan 2026 13:47:14 -0800
Message-ID: <20260102214724.4128196-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
 {contrib/plugins => plugins}/win32_linker.c | 0
 contrib/plugins/meson.build                 | 2 +-
 tests/tcg/plugins/meson.build               | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)

diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
similarity index 100%
rename from contrib/plugins/win32_linker.c
rename to plugins/win32_linker.c
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..6f72b2ce0c9 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -10,7 +10,7 @@ t = []
 if get_option('plugins')
   foreach i : contrib_plugins
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159eb..a6e78438510 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,7 +2,7 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23318EE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqim-0007TY-4d; Wed, 31 Dec 2025 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqik-0007SM-DY
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:14 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqii-00019Y-TB
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:14 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso14200065b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166451; x=1767771251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JfIRF2rFr3TmpkMzwSurtenlCN5AxfALqStaf+SSlM=;
 b=lHLy29ppwTS3dqcOskPDCqH4KBsagOVq1MzLXdmff/vPNKwVUCiS2wkVZCltK10CwI
 v8ZlRUZqlkMBo42LSmN/Mr5W3/O+F6WMWejMEcZ6EgV4ybkTyIBLxlPSieCQsYXYnpsX
 vwNquov57WjzLKm5qX/q+iBRwZtm6rW4jXJxdcyjeDsOm/uYzp3OKFolrbmkKJOwhszS
 Sp9Jzn6cqNd4SAgqgOUuiGV7yI/iVniuZOm+P03Sx6aonKtxr5eg+9vOEVpJwQo1MGis
 /hfvPtB3Hxki3ZHNJpbmhrxc5Jv3oWrBY2ww+6CUZzEultwGi+76cyUZGIeDV6FJcD6w
 Cx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166451; x=1767771251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JfIRF2rFr3TmpkMzwSurtenlCN5AxfALqStaf+SSlM=;
 b=r6FUinBHqemDwb16qkLsN2B3q6HtyxIBo5/VaDnfMnQcgQCYlh34nH6UY770D4ruka
 zpg0UUxVNrD/FkvR+zQnZmNu0xOBT52Kv2SzXgwKYxfMWDSHcgyDtqsqvzdygolaoc1y
 v+/bE/ziNaVDRb33gqP2K5Gob0uoZv8/DG4SM3J2/jrxc5OS9g/VMDjllA4cm4qvU1FW
 g6O8vK5Ief2mjEpfc7qLhaAwezVCdUEBT/bj+1cACeP6iFy5NFwYS9gXy2F3fxyb8Kr+
 EATK4t561GzusFRbTzXQ3Y5RdD0s8uTMvK3TDRYQBhPpCxP1RRheKeeDZit7zflcxaI5
 EcfQ==
X-Gm-Message-State: AOJu0YyCMNaoKS1h5Aer2n+llUvVECQ/2qilc5hIjz/k/xo8AUF6Lsfn
 eZOYUCs36sBp6AYYj/x6wHe2NiHrVGrDTpqyrgo+xUZBZvkVos4+iOE8ujkvc42+O9e9o4Hf7dn
 LBUdp
X-Gm-Gg: AY/fxX4SH2HLhMjDV/oC7etcGxyR7sqROy1XZWUVq4GW/1DAMHBw0d7k3JcF1h1wHtZ
 CoCwdo2aKG5aoYr/Mnran/+P3ngBHtDnJDUH4eh5ewl/IlPvdm58icf6ftoQEyEQ4rSo6WPEpPC
 ggUQVcgfPwRU9S0x1r1Lusyif7hYOSD2UYK07RwPT8I57ZQixTXNLWS5eOCHDy9ywboULvhuNvy
 i+myi/V4krlKY8x240DKYwtoYDZ3SDPEYWFBPbhWcGY7VxEVHbStG7o1zbE/JVPET+Vl66eVRkJ
 +LYqGFjK7qDv/wND6g+yxOB96UIrPRnV9o12craCkeqtwLlcOs06havsQc62PcVAGdr0/B9zpM5
 NSYaQcBSpBuOSdBxZHhj9g/53a/08+CDxTKLixCxsrPtsrj3JmCbyhhkZeL8S7eP7v6p2bUmWgk
 R53Q3q2Nh6bqjoNSz4Mhpo2eaLFmFgBeSNkgFtEJVqVyx1xHeqLgWl7iJo4QCjjBCN
X-Google-Smtp-Source: AGHT+IGWHG7LEI9zr4Ocrz1Q0OLYG7Qn1bZWbl0H1LRksLzmBXTPtBOr6vGW1bYoO5qpZJc30vG/Bg==
X-Received: by 2002:a05:6a00:3404:b0:7e1:7a1c:68bb with SMTP id
 d2e1a72fcca58-7ff64cd45acmr35945020b3a.16.1767166451417; 
 Tue, 30 Dec 2025 23:34:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/11] plugins: move win32_linker.c file to plugins directory
Date: Tue, 30 Dec 2025 23:33:51 -0800
Message-ID: <20251231073401.2097765-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
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



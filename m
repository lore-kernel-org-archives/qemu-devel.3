Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E3CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zwl-0001hp-Vm; Thu, 17 Apr 2025 20:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwk-0001hF-BJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwi-0005mU-Lr
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so808518f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937467; x=1745542267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+EWdOmeXtjoMOdMj9vCcTmXULED5K7o4s48YuBpbO8=;
 b=QJr2qU7YGz58hkgOcIuq4w77dREfTZGV4XCa2U26dpkg6nE3FuqsHrHsJQAVquqYVF
 M8+usJGIxTWYh2lh3RKKsunjmMaaUB2fMhzzFEc3jjTem9l6k0NyHZMqom0PfOb5t7BM
 hmxSBkh1QNhr3qjcIQInMVv73I/aDY1HU/JTCBE6U/wMc852QgOPX+uF7A6CRRVUHAPG
 sk82weUtKQZMK4JLP/716kZYEPBGGNx/oaLYUY4dnrBZv2mn7vI/bqy5W5EoQEbRHW0/
 MNrZZkHARyI0AbATVXgeat23ottyTpKodN2fsIHXLGIcajCCWtfi//GxKTWZZcGhQorL
 x5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937467; x=1745542267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+EWdOmeXtjoMOdMj9vCcTmXULED5K7o4s48YuBpbO8=;
 b=LYoi4C+sK7RWPinzGwthouFEGdgV2ZHG4QcOfTcFL+deGtuAsXqDQw6/dT9z/z7Pd0
 WyyObFpad9RhqDYQOhteH9MmhbSFsFkbVPVbEEvjeg+VM7WRKzJvvnpJzKEQzrfVqyjv
 m8GrSYUNhrJ8J5PnRsVnwrudON2Se3kvKfYZvJ0uZDKqjw4d/v/xDCduvxnHVBtn4l9t
 PPyj131jI4uxd58xC4/xBcOU54d7ZBjGk+SzuKPoQWPu4oyF0yL0RDYecWg7rKdmoVVn
 YtSYAOwZR9oKfhXkL8LqXWGCSbMe5j3GYrd/dv5jQOmFnCPZjlSNLcdAD8wsiyIPoSQ7
 WbMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAfMhr/Wjmct6S2wZ5/O7M4LelN1BqXtnaMkxKE9O2ANE3RjTYwGvDF8STd6KQAQl5br6nn5HlHFR6@nongnu.org
X-Gm-Message-State: AOJu0YzlXbUXn6bHZ0573uL5bhLlXQ+yHoZaWQTAkKCXQZdfkV/RVgTR
 y4cyK5GbLpDDnrCUVpPbTfXUp644Cs8qkqbwpBDwFKZW4SKCO4Vfflm5EOMJfuE=
X-Gm-Gg: ASbGncvL1rZBwK+mYpP054E69UyTVTlndU4jZFRLBn/X9/A+6sTQO9v2tkfJBFTKf8Q
 RihQT9uS8l3YgDgaycF3NAY400kPpBldaPK6dCCcTNsoq6UC85SjPdCG1pooLM4nw3LPh2M5GcZ
 E9Wci8PU8oBd5ExufzhGHLPV6IhqG0VvDUWDlrvgBLIFxl6vq6ROBJEnV15Wd9d2vCpSBNdrg8s
 rJkrRttSKZ7txpPvZiz+yK7O0AFsiRzzAbL5yGvD9zMe/eWli6MsRXXIOq+n8Wqf57mwGXTt2im
 wORqmmfJhZy5RMUcM+CIvyg21r1sFxdaVLRaKXHQ+yAac1EScL//AD3Ja/qOHRaJJMEkZZ8frDI
 K0WsTacYi3r8kjdezyZL9
X-Google-Smtp-Source: AGHT+IHMG2PQBagcsTEyTLIoYbqpdV5Wx2qAwSaizor9gVAHVM5XpX+Cc0KkEz30rg7eyutvVJAsyg==
X-Received: by 2002:a05:6000:2503:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-39efba2f341mr590610f8f.3.1744937467118; 
 Thu, 17 Apr 2025 17:51:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5d7a3dsm2052675e9.38.2025.04.17.17.51.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 01/11] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
Date: Fri, 18 Apr 2025 02:50:49 +0200
Message-ID: <20250418005059.4436-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The QAPI-generated 'TargetInfo' structure name is only used
in a single file. We want to heavily use another structure
similarly named. Rename the QAPI one, since structure names
are not part of the public API.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 12 ++++++------
 hw/core/machine-qmp-cmds.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..3246212f048 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -275,15 +275,15 @@
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
 
 ##
-# @TargetInfo:
+# @BinaryTargetInfo:
 #
-# Information describing the QEMU target.
+# Information describing the QEMU binary target.
 #
-# @arch: the target architecture
+# @arch: the binary target architecture
 #
 # Since: 1.2
 ##
-{ 'struct': 'TargetInfo',
+{ 'struct': 'BinaryTargetInfo',
   'data': { 'arch': 'SysEmuTarget' } }
 
 ##
@@ -291,11 +291,11 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: TargetInfo
+# Returns: BinaryTargetInfo
 #
 # Since: 1.2
 ##
-{ 'command': 'query-target', 'returns': 'TargetInfo' }
+{ 'command': 'query-target', 'returns': 'BinaryTargetInfo' }
 
 ##
 # @UuidInfo:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..408994b67d7 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
     return params;
 }
 
-TargetInfo *qmp_query_target(Error **errp)
+BinaryTargetInfo *qmp_query_target(Error **errp)
 {
-    TargetInfo *info = g_malloc0(sizeof(*info));
+    BinaryTargetInfo *info = g_malloc0(sizeof(*info));
 
     info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
                                  &error_abort);
-- 
2.47.1



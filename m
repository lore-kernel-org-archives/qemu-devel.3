Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EFFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wh-0004T4-FY; Thu, 24 Apr 2025 18:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wc-0004SS-Cq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wa-0000w4-OL
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so992502f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533279; x=1746138079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LxRNMlVfoq/xLHs+1YnVYUs29an33zqnfwHUeMoXn4=;
 b=Ngljd7ga0myWaA//gl0BKuJWPVEKAEfY4vHpgZIkTSOlG7A7WRQ0pK4fG2gEWIUV2m
 V+QBrOzO+xGkuSnvJXaF/RsWJOEGsiKydNmn5nJQwijM97mKn+YTWTINJibOKiyR+GLT
 LYdC+4FzsArppdMuvdFSBJORyN9OnV7VYJBDhHHDgywC+/xxeQ0ET3OS9Jxfm0CEI2/I
 ts0wIYItt8iaXT3uxzYSMp43EbK5NL0WfXeXG5DzFgjb5C3HnSe7HP6Ul85CgvmrfmKf
 8fKhfnqeRY9WoXjJAw2dj2jcWXtI6i70T73ZTYTayVXJ5lKNTt04kdtL2ALwr4pVQhm+
 ZIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533279; x=1746138079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LxRNMlVfoq/xLHs+1YnVYUs29an33zqnfwHUeMoXn4=;
 b=rKSZG7OuPsnfAwJJwNJfmfNyhFmq1aW2xizxofyy8mAJt6VhDgcyLffpd+kpLWxxlA
 liuBFLV2d+Lgf9qhz1R77kJs89/vKL3gmClomtV+5yPjo+1jq8qqJPiA+bBRxUgc6c4H
 oWb8swK8ms97g8Ime35s1QeAciazkQq9I+AfMSr46QVh3BjY3u5ZnE4yjgTXgcZ8VcDt
 eKipbpPkBg65CvOujWrT2A+8JyPugye9s47LSpXxSMiAz+BjFH8kpFFYkHpk586yTeUA
 cU92Xn9GG+izsg+VLJs3V6qeu4s1rc6xCEenoPAatmOI9qdlZ258hkFIDGSg/RhBWLqT
 PuHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRVJwew1mo3RBoa1wGaHtd1Ca7sg1lrD5p4x69z+3jJI1FLIni1J97gqJHd8aLpHeQV5USTgSlt/CR@nongnu.org
X-Gm-Message-State: AOJu0Yx/O3LuXfqxed5LWySCzCm7rWMSdiMtJtutOyXHMK9U7k8Hn6wj
 N0qawnwrEEDnfM4QSg3v/OsC7xt4/ec+AdxkhTvfN7t478JVNmfvuljxaDhAZCvSLavieGVJeeV
 x
X-Gm-Gg: ASbGnctUEuwKLF3H2DKlRG/ysffnX4eATKoEie/WsEQOzDFBYsVZ6+z49S0LPsOuKnD
 0qjTsCeonUfSGksTVT43pOSQbIVUe0M2XWljZFZGic4ufBFR3IAtsWI+2ylT/Sj+tLWoeGlpUeQ
 cVa3Jg3PlKquQJWLWfy6Kihidz00FAzMgrRz8eQGwj/qh9/hA4KCpmSvtleEa9gXdWGYBMorLLe
 k7e8TsFk1cMKB3pYV+/A/JGanrxJEhmYM/IvCpYi3+CIuzoCkR607IlI1bqCd8CPbm4UuX40ZBX
 talbdrQjGI438Z/TJdpypBU0zCZaZ/l69IvYYpnQvtY4ydA8sRMOCjsaNgddnhkBZ05mIHy9tDP
 sAIhzTzLYCW+c8Mg=
X-Google-Smtp-Source: AGHT+IHSad4Xz7LFQzJPYSs85Be7hKqxjhStIklnsslLexuzRdqmT+tUHQ/6l9UPL9jmTD+kmXwGQA==
X-Received: by 2002:a05:6000:1888:b0:39c:142c:e889 with SMTP id
 ffacd0b85a97d-3a06cf635bbmr3575647f8f.27.1745533278969; 
 Thu, 24 Apr 2025 15:21:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm508551f8f.27.2025.04.24.15.21.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v5 01/21] qapi: Rename TargetInfo structure as
 QemuTargetInfo
Date: Fri, 25 Apr 2025 00:20:52 +0200
Message-ID: <20250424222112.36194-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The QAPI-generated 'TargetInfo' structure name is only used
in a single file. We want to heavily use another structure
similarly named. Rename the QAPI one, since structure names
are not part of the public API.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20250422145502.70770-2-philmd@linaro.org>
---
 qapi/machine.json          | 10 +++++-----
 hw/core/machine-qmp-cmds.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a9ff8076317..c8feb9fe17b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -275,15 +275,15 @@
 { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
 
 ##
-# @TargetInfo:
+# @QemuTargetInfo:
 #
-# Information describing the QEMU target.
+# Information on the target configuration built into the QEMU binary.
 #
 # @arch: the target architecture
 #
 # Since: 1.2
 ##
-{ 'struct': 'TargetInfo',
+{ 'struct': 'QemuTargetInfo',
   'data': { 'arch': 'SysEmuTarget' } }
 
 ##
@@ -291,11 +291,11 @@
 #
 # Return information about the target for this QEMU
 #
-# Returns: TargetInfo
+# Returns: QemuTargetInfo
 #
 # Since: 1.2
 ##
-{ 'command': 'query-target', 'returns': 'TargetInfo' }
+{ 'command': 'query-target', 'returns': 'QemuTargetInfo' }
 
 ##
 # @UuidInfo:
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9447e345b3c..a5e635152dc 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -134,9 +134,9 @@ CurrentMachineParams *qmp_query_current_machine(Error **errp)
     return params;
 }
 
-TargetInfo *qmp_query_target(Error **errp)
+QemuTargetInfo *qmp_query_target(Error **errp)
 {
-    TargetInfo *info = g_malloc0(sizeof(*info));
+    QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
     info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
                                  &error_abort);
-- 
2.47.1



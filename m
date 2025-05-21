Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993ECC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4f-0006De-Sv; Wed, 21 May 2025 18:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4b-0006C8-Ip
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4U-0005an-66
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-231fc83a33aso45174255ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867075; x=1748471875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKpDcwMErvQxgyaL+Q2tctV5ddB+KbCBa/wlI68stYM=;
 b=kIJ+bRDU1R4UhJKjqPzMIUec98SalVSV/HVgN7JDubf68onnlSlSG4apxVotLq0uaF
 T49t6tx3kMZh+NCCHvcG5ysQbwwaUh1ID8bITfwqzbXbVosT9zL79u5kFfqlyFQNyU1f
 1gIZL2gKHoPk9oeoM17ZWgXwbaIJGcNwsRPrS4uk1hBbFl1g/BJzvXlZ1gqoqH4egmMN
 grWnYgx3fX973+oNHwxNir3RsQmNjKXmkgYEIHs+PlSj+LG6xa/DJNuu6yA8gOSUOi1V
 LCuKrMmMX1G9KQDp2cxcDfaComJCqkLAFozfM5aU5RT+kFJ0+SzSTgD7RPSGLJ2R91oJ
 N8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867075; x=1748471875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKpDcwMErvQxgyaL+Q2tctV5ddB+KbCBa/wlI68stYM=;
 b=B9mQAfG6M8IQDmVCoG0WcCtN9amNXp9lMQZG/Ja+YBxPVCrPnEA7uHQV1vXez20AfG
 ZznHiJR0aI7BlA+mM8VfPP+bm4Yx4IVwSD0WQf05Rwu0tpqN/VAxniv4MxSTNTeUFOJF
 5omBn+/RB5Aigg4tGXky93vtNp2xrIcYYT28yt3FMFM2ONDEzF6Ah56eXIs5ZcfoYw46
 Fg8Io0Xz5AFEb3d4DbJIwqDSueAuMIMOJW9J21DVVL65TMAwLlP9SecDnOUptHoyEv0E
 WZUf0wnSl+v2CeGArMbQQOseylm6C+zrxDv3Bta6b5KpxH7eI+LRrLedepX85s7R68zL
 5vjQ==
X-Gm-Message-State: AOJu0Yx1xawdeS/rLm4Am3GXyYztm0lc67GS1mnao1lO5DhnfnX6sIth
 Qmtbd+/4mKTiZ81UqZkXmrD5108BTZ2GrZHaMcW/EL8lULwGhYAXDguFpUyOLDbZ2F2hAAFG1Ln
 uYtbc
X-Gm-Gg: ASbGncsl6TfBc/tEQy0KK73RbvAgbyBXKVJT1aGo5rfTp/afJOEy1WtWpkC0K1951UD
 VxGludLK3gw2MHIyqRcudEXNza+A9yctBYQw7g6DDzY5yMQTtBcgYj8GQfa1qS9mw39BBRi5v44
 jW5RepK9kE/exD3QCdI7JTPRV41jAakeN4fNGIe8TR1ogBPaTr/vMSPMiEvWH8CTob2z4hnpGd3
 DNOxCpRBCbiI3VDrGpxLaY8+vKGpwh5BRO44uTZbaS3Kz3IE3GLEfLfY6BwcknI0MhydVU90TCW
 sZcDHmC2Lu2cXmSLvlN8kYqcs1uPX2VkS4HvneVgrnFuQdIbPd8=
X-Google-Smtp-Source: AGHT+IE8bb15Nmmy76tq0E32hsYIaWrKB2zggQmhQOa+EFtlzKvZr6af7RPPx9e0HlV35bRO2X6dJQ==
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id
 d9443c01a7336-231de3ba25fmr271002475ad.50.1747867075331; 
 Wed, 21 May 2025 15:37:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 11/14] qapi: make all generated files common
Date: Wed, 21 May 2025 15:37:37 -0700
Message-ID: <20250521223740.249720-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Monolithic files (qapi_nonmodule_outputs) can now be compiled just
once, so we can remove qapi_util_outputs logic.
This removes the need for any specific_ss file.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7582c2b5bcf..3b035aea339 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -85,8 +85,7 @@ qapi_nonmodule_outputs = [
   'qapi-emit-events.c', 'qapi-emit-events.h',
 ]
 
-# First build all sources
-qapi_util_outputs = [
+qapi_outputs = qapi_nonmodule_outputs + [
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -109,20 +108,17 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  qapi_util_outputs += qapi_module_outputs
+  qapi_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_nonmodule_outputs,
+  output: qapi_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
 
-# Now go through all the outputs and add them to the right sourceset.
-# These loops must be synchronized with the output of the above custom target.
-
 i = 0
-foreach output : qapi_util_outputs
+foreach output : qapi_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
@@ -132,14 +128,3 @@ foreach output : qapi_util_outputs
   util_ss.add(qapi_files[i])
   i = i + 1
 endforeach
-
-foreach output : qapi_nonmodule_outputs
-  if output.endswith('.h')
-    genh += qapi_files[i]
-  endif
-  if output.endswith('.trace-events')
-    qapi_trace_events += qapi_files[i]
-  endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
-  i = i + 1
-endforeach
-- 
2.47.2



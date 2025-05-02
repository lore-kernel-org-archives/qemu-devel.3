Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDA1C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyCw-0000hm-Kq; Fri, 02 May 2025 17:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCu-0000hF-VQ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:09 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCt-0003W0-0B
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:46:08 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso384454866b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222365; x=1746827165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7Hzb0w1jlzsKSiFmuI60CliIwDp64ZHh16gYYLKY+A=;
 b=FIkrvETVpM7/xF+Bqq/Zqmhjna3nhTZpAovxV7z13FoOaLqiC04VzqXoWw4AvDMQgZ
 NZ9kqKX7j4XqrE3GL3LrlmMXIxK4BJ1g9BNivSxphx5l6r5JMO3COQnTrIbEf3dejUgd
 WnSoFHuX0sGPGak3rebxlXI6MD07oObUvKVy9TEX99mCNOx2M2EHWC2Wl+X/JcoTHLCg
 8I+XjBGRIz4kUlIK7ltDXZau0et3kHMOvhQ+x8lRDH0p3+3yEDnhDUstLI/pESw1B/Av
 ddsHCC4c0QoxKEGapTPa3OwHjz0nftBYAVDUATrdYRm89ouew05OvdNmjnmwmB+dpedw
 bOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222365; x=1746827165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7Hzb0w1jlzsKSiFmuI60CliIwDp64ZHh16gYYLKY+A=;
 b=NUVcudW1LQd3auFwFmbMlo/zohvSpt6kFKIe9B0VToOUIC53dZhCzseXuMcyT8jIZ7
 Q3fQOH4Xak0DlC5B2ia7Wsn71EfyXdSO69hD61pPyLm0GuQMX3IZvOBq+WJuIeEPIl1U
 2o+1NhiGtl5+p98LHWwpkp0iHlQyddoz8xhyOLrkVu1oA6N22giSEGx9YS8Cer7s4QpW
 62EeDx/gS0VyuBES68Tgl7zTAfVn6SgvHbi5Q5Lg/smMrAdnWxFmELHt0LVrw0Fwg+Yi
 MKT/LA90WoxaOgKOrKRmRrHuCRjzAvuspQ5M9/p3sx9EUuM604TynkBoVcnOvCn19Vtp
 rVCQ==
X-Gm-Message-State: AOJu0YxHWcrxn3OGIOuzOSh2xNdyqJ2g1fYKAEwfTDa5pRrilc0mPD61
 OADd4CatYlj+uOLcim/LkMXyz8zUCdoGGaCxqYKIt0kUiWOIUZUue6aXduZC1UKYIkgKwBxcxc9
 U
X-Gm-Gg: ASbGncs3gae5NVDNs7FSmjQVZ0eZgCk/T5RD/c2PQkIxoSsVvPbgGgUV6WZALWDal2m
 RKo7K0sdiBbJXX1MtcIeUoeePXjx8A8Nw7qW8r5QeaXjeSBpS2fvIVFmboUYHb0OKVoivnhXQjt
 w2HwEC7mqNl6kgt+lsNwNg0xvKcI0KzcgRSJjbarwjsrE1Z38wxhUQzBaZgl+556ifnm4RUihq3
 VmL2ThQvWMQioxqR2SLlbGryUr6W2dCBzGN68UIzvFrYY2LRVSps5kuuC1HoM8GHauGhT/Hvz7j
 w5XbRlMujIhcCKQB4JemPdMBi3tIEsVWh/W6GjQhlQlWHOSldOFoIcuVh47rqVCpoZ2zJ39t4KH
 Xh0z+dhh7O2vNh8E=
X-Google-Smtp-Source: AGHT+IHSKjF+MWbA44wjBev1Hm9LEvO6FYp2edyMD03VZ8CX8LAX1Fei8dTHx3IfcxkLW1QyIvSd1A==
X-Received: by 2002:a17:907:3fa4:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ad17b5dbc19mr446152966b.29.1746222364621; 
 Fri, 02 May 2025 14:46:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895402c7sm100512466b.164.2025.05.02.14.46.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:46:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/5] qemu/target-info: Add %target_arch field to TargetInfo
Date: Fri,  2 May 2025 23:45:48 +0200
Message-ID: <20250502214551.80401-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502214551.80401-1-philmd@linaro.org>
References: <20250502214551.80401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h | 4 +++-
 target-info-stub.c              | 1 +
 target-info.c                   | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 1b51cbcfe1b..83d584d7dba 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -9,11 +9,13 @@
 #ifndef QEMU_TARGET_INFO_IMPL_H
 #define QEMU_TARGET_INFO_IMPL_H
 
-#include "qemu/target-info.h"
+#include "qapi/qapi-types-common.h"
 
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
diff --git a/target-info-stub.c b/target-info-stub.c
index fecc0e71286..2e4407ff04b 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -14,6 +14,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .target_arch = SYS_EMU_TARGET__MAX,
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .machine_typename = TYPE_MACHINE,
diff --git a/target-info.c b/target-info.c
index 8232d488870..5f6096606e4 100644
--- a/target-info.c
+++ b/target-info.c
@@ -25,6 +25,9 @@ SysEmuTarget target_system_arch(void)
 {
     static SysEmuTarget system_arch = SYS_EMU_TARGET__MAX;
 
+    if (system_arch == SYS_EMU_TARGET__MAX) {
+        system_arch = target_info()->target_arch;
+    }
     if (system_arch == SYS_EMU_TARGET__MAX) {
         system_arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
                                       &error_abort);
-- 
2.47.1



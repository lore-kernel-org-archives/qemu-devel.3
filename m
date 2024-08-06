Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC21C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbL2p-0001a1-Hy; Tue, 06 Aug 2024 10:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2e-0001PF-7L
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:20:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbL2c-0004Vq-FP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:19:59 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso762493a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953996; x=1723558796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEYxqiGFTFwjc+puEXGbYroS/ETTWPFhLrPNeiiUdpw=;
 b=nI/GErxmlImr3E7+3KSu2D5M8kL6DAJsQnshfyVpZhFp+fRxpW9qj9CBl0Dj5R3L+7
 gzpG+V2WfkWcy4yQobAVEqS2Utx8kKiXh9IWHcCCy6TWmNR5ZaLF/8a+KP+8m3I/k56t
 Hk8HZ95bK2LeIWNNm/1ERQmXzEqg+KOzN7v8/6+neJTdDPqftMZ55qqG9UwnNssm5boE
 w2LD4zD13Dl0ORXd5ym+Bq4r3jq7QCm99MdZIgP+d0Hkqd4vlBULQ3USWE/Bh9N3ucni
 ZlnORhI/PJxhm1Z4TFVNG6p6nNBcZbrzpyO6EQunt75zgagYEHsPkfUqNgSpbiFN2yQx
 enMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953996; x=1723558796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEYxqiGFTFwjc+puEXGbYroS/ETTWPFhLrPNeiiUdpw=;
 b=JOxnKbD1KVLgCUObFCYzX3wypmvdVHIVCagmWzXA007Sh1jlxh1Jg1EPabpOMzXm2Y
 9VA20E3froRwp4gpAu4SnAaA8mJQzHX7mPn2fwJYucDXK0lCNaFsv1a23yAoETWc0f6M
 REUd1pGdXITBYq37CylJg6g2IeSN8IXNa7UvgvcP7AwyuY4lDP2PNdu2lQQ4x1ArCIqp
 LnKo826czSCc1dG1otwgC/HEFk4fE0UzN0T3G4P3/7lvfsiSsxk+BUqa9FdXV6j5CLdQ
 kiwQJP59oivWBaBsXMq6KQ3azH4CvPALwVTRbLZLu8ER3BxdlnNygjFLgkq69kO0hYBy
 k5/g==
X-Gm-Message-State: AOJu0YyBYcfITqVjADQ8fO8IdM65gc/S0oqy0DedUhwMaMC/kmE1SmvY
 k0zrQ9s9qOyw0TUVjmOjypnPeDJv+sx/A66zZwvMEvuQ3ZDNgXSPpzc+k36sO4+U6iTfiXBLzIp
 x
X-Google-Smtp-Source: AGHT+IH1kVcq6PvtuOsEvVhlvCsjwjhTyIAny7uNav/VWxKNC7GH+B4O2p/YfJoLMZUgZ+ht4eAxaw==
X-Received: by 2002:a17:907:2cc4:b0:a77:abe5:5f47 with SMTP id
 a640c23a62f3a-a7dc50a2e83mr1153162066b.63.1722953995801; 
 Tue, 06 Aug 2024 07:19:55 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45452sm550439066b.111.2024.08.06.07.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 07:19:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
Date: Tue,  6 Aug 2024 16:19:40 +0200
Message-ID: <20240806141940.22095-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806141940.22095-1-philmd@linaro.org>
References: <20240806141940.22095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When configuring QEMU with --without-default-devices and
not including machines using a GIC, the GIC model is not
built in but the 'query-gic-capabilities' command still
returns false hopes about GIC:

  {"execute": "query-gic-capabilities"}
  {"return": [{"emulated": true, "version": 3, "kernel": false}, {"emulated": true, "version": 2, "kernel": false}]}

Restrict the command to when the GIC is available. If it
isn't we'll get:

  { "execute": "query-gic-capabilities" }
  {"error": {"class": "CommandNotFound", "desc": "The command query-gic-capabilities has not been found"}}

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2484
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/misc-target.json | 4 ++--
 hw/intc/arm_gic_qmp.c | 2 ++
 hw/intc/meson.build   | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8..b857e44c2e 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -316,7 +316,7 @@
   'data': { 'version': 'int',
             'emulated': 'bool',
             'kernel': 'bool' },
-  'if': 'TARGET_ARM' }
+  'if': 'CONFIG_ARM_GIC' }
 
 ##
 # @query-gic-capabilities:
@@ -335,7 +335,7 @@
 #                     { "version": 3, "emulated": false, "kernel": true } ] }
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
-  'if': 'TARGET_ARM' }
+  'if': 'CONFIG_ARM_GIC' }
 
 ##
 # @SGXEPCSection:
diff --git a/hw/intc/arm_gic_qmp.c b/hw/intc/arm_gic_qmp.c
index 71056a0c10..1fc79c775b 100644
--- a/hw/intc/arm_gic_qmp.c
+++ b/hw/intc/arm_gic_qmp.c
@@ -6,6 +6,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/util.h"
+
+#include CONFIG_DEVICES
 #include "qapi/qapi-commands-misc-target.h"
 #include "kvm_arm.h"
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 45d3503d49..b9550967e2 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -39,7 +39,7 @@ if config_all_devices.has_key('CONFIG_APIC') or \
 endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
-specific_ss.add(when: 'CONFIG_ARM', if_true: files('arm_gic_qmp.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gic_qmp.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
-- 
2.45.2



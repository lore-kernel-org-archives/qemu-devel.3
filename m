Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3B1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mau-0006D4-2Q; Tue, 30 Apr 2024 08:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mar-0006Bp-8F
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:22 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1map-0001lB-Nm
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:28:20 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5727dc6d3edso2754003a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480096; x=1715084896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpvZhy7XsvsWKcm8hvoUbAXH7VSAOk4EonhNZ/4rKGY=;
 b=kNyV0q7ZspnQDMnrpMv5cmIojv5QJCU59tsL6XkiHY+muOlkpkbRdPxm/jM1VUPI7F
 HFi/ofTElc5CbwMrpqmoKDs0yGFM7DcxV1hS98gJEpU8WLvjHLqR+MsYH2wyjOnVHojo
 AweGcNMGmZIKi68ppOTlhcR8uV5oRrfgoPXNJGLIRlL1seNjZ4xlcPOteKT8eupd0/ss
 S6rcfoPqIQSrctNstIVhkhRO4QQ2KH3FwMTyZnNhRBS3M2THdKduQs7KpwM5iFDSQJsZ
 beWrgarRd6gzQchtTQ4fezNB4ZnTGNhcNZ0Vnxk/q060tXNz1OTb3jjg/ripDC5WEFlM
 bvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480096; x=1715084896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpvZhy7XsvsWKcm8hvoUbAXH7VSAOk4EonhNZ/4rKGY=;
 b=A8xEZ8cJK1youprazyC/OSi8UwmS7OXIWmuNTKs6eoOVy4TJE2mXZGDmvPnjs2Ochb
 aQXhJX1blpPRvxtohDql9wwKyNQSEuGAqCZRfDPmEn29CrWeacV9GnE/Iyhm5cvTatwo
 3xh1HRqzfmzkCUO9s+fAz2bloLFGMI/E1NBSIqhboxvagfNF7xWBBavL/5BirpmfaHlf
 qN27PBPDfrOTdv4kLmQrBjDm5KA07EC5I4knjSvf5+AJg4Bo0js7Y0xempCiziICOhzV
 GdXX0ZGkHTwRnV/OtMyt39Sb3b5O6YJr+6dsi452i5JbhwrWWM4swlsE3N6p8mZopC5f
 JQ4g==
X-Gm-Message-State: AOJu0YzjwtDFf1c7UJq08JgHCkmHb7kTxHP7x+48+TxPY3ryFVLAf9/L
 cxehMWun54woEWc49zcXkJrN6dacM9kImDCrO+qetbSwAun0rZER0JUqtl5Oy7LfetAAme0ZPKM
 r
X-Google-Smtp-Source: AGHT+IGIEirzZwyqLvIm4B+sbHH6x9Qx1+RpKw5s/wnlS9jZHP/x/+j0iptFDxCuU/8EgXCO0b88Tg==
X-Received: by 2002:a17:906:a10:b0:a58:ed01:3d with SMTP id
 w16-20020a1709060a1000b00a58ed01003dmr1718376ejf.16.1714480096680; 
 Tue, 30 Apr 2024 05:28:16 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 jz12-20020a17090775ec00b00a58a9a56c44sm6545738ejc.16.2024.04.30.05.28.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:28:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/13] accel/tcg: Restrict qemu_plugin_vcpu_exit_hook() to
 TCG plugins
Date: Tue, 30 Apr 2024 14:27:55 +0200
Message-ID: <20240430122808.72025-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

qemu_plugin_vcpu_exit_hook() is specific to TCG plugins,
so must be restricted to it in cpu_common_unrealizefn(),
similarly to how qemu_plugin_create_vcpu_state() is
restricted in the cpu_common_realizefn() counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429213050.55177-2-philmd@linaro.org>
---
 hw/core/cpu-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cbafc79033..f2826d0409 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -30,7 +30,9 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
+#ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
+#endif
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -226,9 +228,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
     CPUState *cpu = CPU(dev);
 
     /* Call the plugin hook before clearing the cpu is fully unrealized */
+#ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
         qemu_plugin_vcpu_exit_hook(cpu);
     }
+#endif
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
     cpu_exec_unrealizefn(cpu);
-- 
2.41.0



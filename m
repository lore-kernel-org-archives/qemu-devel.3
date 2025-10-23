Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC36CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw4y-0005qZ-Pk; Thu, 23 Oct 2025 10:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4t-0005pQ-Jv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4q-0007O5-8K
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:14:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso857092f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228841; x=1761833641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YWr4zExFLVkS/USY8dnF7Z2qM9YsNMJfD7DIjDOS2k=;
 b=Re+VSc/4URZQ/dH+o8iJwGvAfA5CEgfcExw7kZi7D1XFLfj+RSgItN8hJxnvo70S+7
 wHEI0BdI7oqnYOYIAGjJks5+61hy2qInyQPWelFmvdMxK+gdrT8tzyjPI2kB8mBkhtQj
 Jns0hByKyrkWkGBeKIn3MU5onwOsmItoMWDvHqtrFCCacJcb7UJ93XOrD+YJlG9Vqpvo
 J/b0RAAlU+bXYCgoDC3h1zraYCL4eKxR8vIOjZ+YDHyyDr0ysfrngQkSgSoYfP6ZGa1H
 UmALz7YoGz2sfC7z7rA3dLUgEVBP2sWIoTrg6dS4MM51p8yRqZOlJekijGPk7j/aUY93
 hsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228841; x=1761833641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YWr4zExFLVkS/USY8dnF7Z2qM9YsNMJfD7DIjDOS2k=;
 b=tYKQDKT7Ygvbur2qbkbis0uNibkPN/scUxTCHFoFZIwkoKYrkqmejy7btH2H8NDvsi
 czDceeo1OWgxJuPp3PEtGfl36ZwN3GmrYPbYeUMREgQ27Wqb0Sv+/sdp7/U8O7wLqR+e
 +P9te/EWfpvNf1fSgVILIFPBQVqbxZClTi3rvL4K+iW8QdRtGmH1LVnEM2A4rndSoAAe
 XUXOpzVOxlV2PtCJDPm8v/WsMBwyBwOR3DuKyDlS8x6qHB46E6FgOcztpdK1VBs/nkGt
 uOkxTKW1QqjGFEfhbZ/DnKqTUs1lpGUvO644rtP0X1YGdmCIsxBuXwsI9zzIAsNcOyxW
 p9iA==
X-Gm-Message-State: AOJu0Yy9QT0KMnWm7d5Hp0I7SyZJLdoKRqY+Crwmfs9uCnsI17A+4pC0
 4Z1eWHbsFglJMTi9tMZiGcaaTwvNmVpO3cyihd2AK462U0ltYJjewS+gkYDNFP6ZryamS6pUwak
 cCKU58qo=
X-Gm-Gg: ASbGncsBLsIl0C4nh3h6oCY4E8KhhxN+1mTxWFQFRyBXJl02kKDnIzxd2/0eGfuHtl0
 YpTAU84QHpA9DACjNeo6Lgvueb8XdJ0fwadPuf1RQXjOZe13mZYkJy1szkXWAIPe501XiyYmU2+
 zRwa4Gb8yRSobASfnPzRn8hzXfomz7Ye9aYKTSff2SUxx4ko0jx/1/L68H7EOMdMsP2HyYu1WgP
 epEpDXTp55oHRDOYZlgt3u3zNhDR/7FxUknE0DPM+nNZb5tm3TJKoc31pGnLlpX4w2lMnhgU1D9
 4iK7f1MyDTgDDc9NRDxwe6QX1lwG7GyCPX+O8N2ggHRyFOOxc/pyEHqK+lG8ZBJLRxjMaRKvDp/
 a5wwBTkYxrqXX+UY3+vqJyaWCDYWNoPhpKd3JDLzAzDZH760J7oaD5Kh7mGg+u4syVAEOc8zUKv
 TWeSttnEnOfT4cRbsHsGMOj/QC1z/bFe80dpv5u2UR93dS3pMuhg==
X-Google-Smtp-Source: AGHT+IE5kJMbKIloHuIF+iO0x/rjaYysicQVlzEsz/rTTGf5wI8KNHrB+CP6oynYwyhQy10+JtgltQ==
X-Received: by 2002:a5d:5f82:0:b0:425:86c8:c4ff with SMTP id
 ffacd0b85a97d-42704d90011mr18488871f8f.22.1761228841290; 
 Thu, 23 Oct 2025 07:14:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f57cesm4406320f8f.17.2025.10.23.07.14.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:14:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 14/58] target/arm/hvf: Hardcode Apple MIDR
Date: Thu, 23 Oct 2025 16:13:33 +0200
Message-ID: <20251023141339.10143-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Hardcode MIDR because Apple deliberately doesn't expose
a divergent MIDR across systems.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d13ccf5508c..890e9266f93 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -763,6 +763,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
     hv_vcpu_exit_t *exit;
+    uint64_t t;
     int i;
 
     ahcf->dtb_compatible = "arm,armv8";
@@ -781,9 +782,19 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_get_sys_reg(fd, regs[i].reg, regs[i].val);
     }
-    r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
+    /*
+     * Hardcode MIDR because Apple deliberately doesn't expose a divergent
+     * MIDR across systems.
+     */
+    t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0x61); /* Apple */
+    t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf); /* v7 or later */
+    t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 0);
+    t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
+    t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
+    ahcf->midr = t;
+
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
     /*
-- 
2.51.0



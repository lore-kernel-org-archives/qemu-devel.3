Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7837BD12D55
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 22:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAFuP-0003qm-6v; Sun, 10 Nov 2024 16:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuM-0003nI-Rt
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:55:46 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuJ-00040W-Mi
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:55:46 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso609917666b.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731275742; x=1731880542;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOlf/wzEJ+wM7g5BTurCACeEWddAq/2jF0kyAkwof9o=;
 b=fkzxlQcxU547idvGrXJ+MC5R7FX+23Gbvfs39lgS5u8G5mF60FfB9R/DyqOs8hWLPq
 3AjZyOUYpUZZWDNNd2xt3OcDGZHEe4PhjAiplJnfcxVqFTZkifotAtZboL1zQdOBAZ3c
 VTRJPaYukcWq6oby/OAqA3pr+4pXuP8a5q1AguONORXJvUB04A+Evb6gC94855QMc0pG
 vibOx2GE7e4nGMce6mWnMpP1zpaY+CJC2WOm+HRbWNv8UJFyNHt4kG+th4YwXGRLqKJ8
 D859kLuNpxafxuyRy7WrH62WECRygaOQfBF+gw5gAxv8i15c+ZhxZ+eGFLDSP0GrEGtG
 QJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731275742; x=1731880542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOlf/wzEJ+wM7g5BTurCACeEWddAq/2jF0kyAkwof9o=;
 b=kA17L1IFinnDrV8WLc4wPOc5lZ2c4s++YSMrJJYXaQw+9ibYecEEg/nVfjfgpWt9m1
 lhhLy+DHJ8r0J5gcKJoZbM3vTFKz625FxhH5KbRNolnl504IDiOONd8/E9/cOx7bxEGL
 ifs/L/jM3RrWw5edy1GaNJy7ztPK7d9yvrzK6nS8dOrzFcHonsovB26sf3L0lcBSvFQM
 8dmw/w2PJSzdqTE9gqXdr7yR70HcKK9k/I0MO/+SzthsT96luQFtVKfK04ADof68Lpcv
 w+V+NDCq8es60xZksslS+yMdDDUIMVX404JhPhOMl0L0UVaqJse3NU6iJbEtnsj45FGU
 Yp1w==
X-Gm-Message-State: AOJu0YyHsyY/TiX5GSyfwlm9v0o3wa1UEtK+jMw3wjDTzP3V5jxGp3NK
 vAXihpdzmOE1ABB8+eyfHV/KaazyNrikkR2z1b+GUNvEWuVGCT2CTPTbB+rAIKzBohJmmO+YIw7
 Ntg==
X-Google-Smtp-Source: AGHT+IFFmOXyc6ptj6nmG0SSXnGWKaTRApyRiD1sYoG+6LVBtyK7NJWvG2iS3P162et5AwdCJI1CgQ==
X-Received: by 2002:a17:907:318e:b0:a9a:cf6:b629 with SMTP id
 a640c23a62f3a-a9eeff4458amr1035374866b.29.1731275742123; 
 Sun, 10 Nov 2024 13:55:42 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2f731sm523715566b.189.2024.11.10.13.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 10 Nov 2024 13:55:41 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v9 08/16] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Sun, 10 Nov 2024 22:55:11 +0100
Message-Id: <20241110215519.49150-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241110215519.49150-1-phil@philjordan.eu>
References: <20241110215519.49150-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62b;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

MacOS unconditionally disables interrupts of the physical timer on boot
and then continues to use the virtual one. We don't really want to support
a full physical timer emulation, so let's just ignore those writes.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6cea483d422..b45b764dfd0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 
 #include "sysemu/runstate.h"
 #include "sysemu/hvf.h"
@@ -184,6 +185,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSLSR_EL1      SYSREG(2, 0, 1, 1, 4)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
+#define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -1620,6 +1622,13 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+        /*
+         * Guests should not rely on the physical counter, but macOS emits
+         * disable writes to it. Let it do so, but ignore the requests.
+         */
+        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.39.3 (Apple Git-145)



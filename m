Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388CD2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciQ-000350-Uu; Tue, 27 Jan 2026 01:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciN-00030m-Ud
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:16 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciL-0006n7-4f
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:15 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c622ce9a33bso1657845a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495891; x=1770100691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/POBbzvFsH1ygUjRGcpksWmZ9M+w+T/oFj7/7kP11s=;
 b=gBxTD10nGcDZwDcwS6xb4j2wJgy7DMFpjxlaw7vDCQiql3DFzxTqEYi0eP8Jn8u7zA
 IdhkUGGIhhsduDjnrhgJDhBGnmlGG5dLypjS/rJHKakvlzJsCaxhEIobMMvUD4yUayCC
 3eHW/2m4ifvF9r3vu8Kde6/2oJLI3DlCYqaB9Hgn2BnzpYbKseMoAEcz2t5iuCBg1sZ5
 h+wlFhwof7UPdPhSClL7agFeSMX78K4kZkXToNn0O2DM7nVwFdS1IvhiwjSU7JjBPJDH
 eoRlmOAcx+jlR4sfwAk4zlW/JD2YG7bVCveaU0bLmEHddC40qJc/HL7PVgMs1iVP0N94
 O3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495891; x=1770100691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/POBbzvFsH1ygUjRGcpksWmZ9M+w+T/oFj7/7kP11s=;
 b=IK6gk4LQvUcKceOLPv5KhMSM8mCpof0xPqAvkd0wTtYqW8l+vRTuZAsVU4a4Z5N39r
 mT+dKOUZjIgkOtxWo3S4N7LwKajD5/HAwmB9O9P6l8lIaf/q/4PvsONPMA7ecPExyPCG
 mS5AJe82zXppaBfMH1gTli6ZBElF14hpueSvfbx0ljAgtPGD7nSn0d+2nmLnah8xHTm5
 cZdLGtqc+XQXGt6RSE0YYfLZ+WiOKspyoKPc/xyIxmR8tOmq11VTaD4DhaciB7J0lh5M
 fh2HhsllEMAdExj81DNpVTL0bIaySrUz/tcCKRwxtTEAEE3FgXI9uIihEN+/ZDtm5Udr
 2KmA==
X-Gm-Message-State: AOJu0Yw7ZxCWqFm31iJEX+lYTbIMX5kN+VxHU9HCFctWAc8I9xwnNNYf
 L7fEu6FfSIOum58AzozGb9kUEEFITz8fWZNPNOIZXa5MOrLfpNNQ+yjvNyOFXKKz6L6ZzVBkchI
 TZvl6oUvu8jqZNFXn0qIBHsRQnV8mfRPD9TBJx9pviZya2k9yRW68eLICfiXPMxUyKqD5Y1lOxm
 YiTwzTQCZJVTtK0I3RvOq0M6S8YndSMcBRSb7zD+Hk0w==
X-Gm-Gg: AZuq6aLLHx57O7NGDePiQglMsRwetjqBNIAa+ASCU578DY5cKHmJZgN4Iq+IoTHr9Mg
 Mx05x08fldMFytmahhJadvGSX55xkfUq1q35o1IpdDEDUfP8g9zm0AV9tpRZtfr5DoADZ3mdXtu
 O1/UQSSwgXq8/nPElOg5Bue65H8EB94O4d1icAYAgmwhrxOnlbDiHhpQF2jkHZ3z+Cf92Sb+wTc
 b9bPhP0u9fy5e9J2g+YXTh4Vz2nRp+g6ERuB9aXloa33ZIF59mqBCWW+Umg/jCsvXQGpdO4z1Re
 0ZJpb15SFChvmreQPkt/r4pag0FLx6AhZQGcHFUpI/FF1dsY5BA5JBQUec1H/cklBEx0ZihxaKs
 EkPAbcwaKE1OaactUoOZVgWtdZ5YsqQY7lcJOIy46l/JghLRIuqHRXY5ENIVtG/lZnyUkcdeVCb
 j8JVxMdFzKWC24MOVVo1k8uGQMz3YGHdd327TV7DctZoXjRz++/HQ/yqi0rcz9ur7O88HtAdksZ
 e+oSZTl3DqKp2U=
X-Received: by 2002:a17:90b:2c86:b0:353:4f7:cc3a with SMTP id
 98e67ed59e1d1-353febc7f59mr830740a91.0.1769495891477; 
 Mon, 26 Jan 2026 22:38:11 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:11 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 16/17] target/riscv: Expose Zvfofp4min properity
Date: Tue, 27 Jan 2026 14:37:22 +0800
Message-ID: <20260127063723.442734-17-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 87827441d3..d2f25cd14b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1384,6 +1384,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 
     /* Zvfofp8min extension for OFP8 conversion */
     MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+    /* Zvfofp4min extension for OFP4 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp4min", ext_zvfofp4min, false),
 
     { },
 };
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CDED232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6z4-0002sx-Cm; Fri, 09 Jan 2026 02:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yk-0002YW-Rg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yi-0008Ic-2M
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:14 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso97241b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767943931; x=1768548731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRDm49NvemgpsDycWeF9XfPyaIh5gUwvlJ11vWn6hk4=;
 b=NUnYsNgGzo79WJ26za1OAZJrO+95NLv8QR0ek3EakOgHS4Xc+yiKM+b+wSLIXqIg9Y
 qtt9fak+o6mNRMkG721zVME4O15IBOjG2GljrehVL2S0dpGKybpvRLRu/tivHR4p0O5v
 tDYkwcPlBeN3I8geVQ0QlBFsDgoohthxTDlw1ketMNH5rTgOQYOtree/g4g0Iia2Ef3U
 UEitBRTg7pp4l3fCg4lPzBeDXYRgIna7O0SSThSShhQzF4r0NZmWdSmpIPBIByV6r3ZH
 Z7cc6H3LhqTWr5I9ksPRDUQRWi+pmMxVzGvS4R3uW2c0q3PxjS43//OO4Uruvwpwa6tU
 9qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943931; x=1768548731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TRDm49NvemgpsDycWeF9XfPyaIh5gUwvlJ11vWn6hk4=;
 b=QcThPgAGDmvd6km2ChmgJj0xuOpcK+AAHAT413Bkw56rxf0bw+bmPe+S9nnNMPzfyK
 mrk1qarWqMwIO+3f0SpO0G1PcagbUDQBjUbLLqGnmwIzhjPJDFIJfjAiPcxpF5aUXvHD
 B4+M0C5iJoS3Gx0abGlUuOCvLFwqLTrgzBZzIQNQ+F940YRY/YxEQMj6wDpdeGiYdhrP
 p53Yyxwj+9wdfjHUdf6EAo4idRvb0FY8fjmRRNLyJDXnd3MuM3nKS0Bc6w3pkKDS+SeP
 L6uSZd9y3NnUv5FAw9394LqOOt/FaNwIm+KI4Romx0QGOKTGgW+pJIfTUVX9q1ZtKHPy
 HLZg==
X-Gm-Message-State: AOJu0Yy/smC+fuAEarxe9TVAbWXHC50VYPnZPsA75Mdn2CYYuy+haT9M
 OnR9fZb8PtVWWtbLZIUmH6iFvATqnZVS4msR8GaSkVQBF+vwMLuNI9SeV2P2cRhYxTEm3k9Yws1
 3pu/O7KzQJtamWGEViUepO5qORecKma2viyDdNimJDmMCLv7wvZqQtmy9/kf6rSwG2VDwSdI5mu
 4lPV5189KEQne/ng/bu5C2T9eraevi2ZI56JU5tKU=
X-Gm-Gg: AY/fxX5D7N5bcWpdNXOslD18QYXvCI51yM666G/yZd8+AbPimtAaVjN5CJeS9JAV2uj
 KHjFEYZsqD97xuR+Bza2+glmLWGC90wl3LGjtNNYTQsh/cWQ52LFvSo73040QdpeTOUkfkhbTMe
 rswQKyBCad1V97xAGy+t8S/KW4s6cN5cIUx/iIRMeV79SdtKi3pFMCZVJyq4WJjcr+os90KEpYX
 iD/7XJ+QL16Chq7wbEdC+fBmbz3ujcv973mgvwDfV1MzzQCXXX+pNV4i6FsF1hJTyxxyBMU/r8H
 UOW5mtOpjMBLzJf5/tDzdMy5rWEs0wNp4JgXfXedd4R6voCsvafMLy3rYragtxIIpzeuLmivogi
 yu+8QuKG0hLll0dn9VtvpdMjAPJqaio0PAobj8NMEbi0BGS9+GX3Wu0FUZEu/NR9YFN5DSJ6BEd
 5U8GJrmaYMTAqMz67terfK0yCLggiMz8vzRaKDj8eZD3cqq8P3iisXuPY=
X-Google-Smtp-Source: AGHT+IHUKAI6BQGfTkjwRhgYQ5PqRd/6mEHJ3yaOMpPEdHRX8SLNmA/JImNhJR2AAiFVg4OUnG9NqA==
X-Received: by 2002:a05:6a00:4c0b:b0:7e8:4587:e8c8 with SMTP id
 d2e1a72fcca58-81b80cb21abmr7788062b3a.59.1767943930603; 
 Thu, 08 Jan 2026 23:32:10 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm9490421b3a.33.2026.01.08.23.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:32:10 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/4] target/riscv: Expose Zvqdotq extension as a cpu
 property
Date: Fri,  9 Jan 2026 15:31:53 +0800
Message-ID: <20260109073154.46251-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109073154.46251-1-max.chou@sifive.com>
References: <20260109073154.46251-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a295ddefdd..e1f408b037 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1377,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvqdotq", ext_zvqdotq, false),
 
     { },
 };
-- 
2.43.7



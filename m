Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720F8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7ht-0006or-Kc; Sun, 12 Jul 2026 23:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hr-0006oY-8f
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hp-0001Lm-S3
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:47 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c9d1fc053e0so2334596a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914704; x=1784519504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Gykh+5P8EC5j4uZxNdjyOMe+zEXw26y8NMVO5QDhqI=;
 b=dtXnu2uJ3EWAo3qWFHkH0X13wvmHYPZObnv40/mF4ffqvvOFVvl6g7/rR+XkAEy2A0
 ecODn3kYuNoYEgUxlxZ5h6cUuDdIlP7u3j/PVt7oggxjf2winxVssQ96nuE1RMOLoKOC
 kKjiL6g+51ONqdrBd3eMJsjfN4UqTRULBcysRooFmVKPQnrNP633kqxML0gCPZ2LV2aw
 wCAOm2ICMUN3BZva3ZZmdY23wM69PjGh6Xfe/tShM47byFqp2fOqHpqi9ReGgf14FHPO
 d9ZHNdoUnKi/2P2STOuM6OVdVmE+4Z1flBgG03q0xO98OXgvY0RXtAbxKruqTFmOB4TV
 NZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914704; x=1784519504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Gykh+5P8EC5j4uZxNdjyOMe+zEXw26y8NMVO5QDhqI=;
 b=ruLDlL1NDmWy4FEsrZ7nfIeEoOk+l0y2QGLaMsBj/jipfTPDa/V7ggAiTihGkS34HT
 vFCMWUoOKLDNEk0tunK+thdUzsvmtz7k+K/fyZMwpnLmjFwD55RAxOW/3+cqBmEn9E18
 BG/8uzhw983akc9Vf0AThKLX6vb42BqNccA5XuVi/LhyEN6BpIGn7ir30vK2sNEGIKKD
 5ARy9Ye0qd1kTDCxiup4/WzP2zWd8fY6b/8nuzz1hhcfbmEUX5C7eYEGosqcLSdJOHNx
 Ho/CgGkqg5yXtfjiWPDhSD3yPlgN6o8RVc2QXcRvaWyCZ8sdKViyzj3G8OFFE37KbUif
 g0Yg==
X-Gm-Message-State: AOJu0YypJEJ2B4YFBZVmue/UpdoW5OGlCUiQ0C+KEa0dP79T8IhjCmod
 oMntwf2lFB6TCUnAKRvDTJzC8rJxvATHZSfXklkUp0NjZO8OVOBMvv3+WA/asDFMv0e0q2bTg5T
 7mIrgRk7O7fyoIKfsvEMlUhTIsZ3Ce1qXEnep2HMh17BthS6cdzNVfHzd81iTEkl2c1k6Ynex7s
 4NMnxZ4CwJoNOTzrofTsUudkJbOtxPSKkJDShyF+b19tdlZkNZ
X-Gm-Gg: AfdE7cn8/n/jSke5nwnKPK1/HF8imXLQZx387YPWVXqw9iZWY4FMCTsTq+vHq7+Q0Ei
 9KZrGBaPIwg41+abthYrP33heqdbn4zuL8kZVct52a++MuJBeNPQ2z2vUaSaapWc+57Yuc98Z6s
 y6SkLGvXTcG2qvv43115EEY1F2tRKzEzn3WsfbFjQs3GfMrYhCjcvvca4aw5s+TMxIshvvPpgsw
 A3OllMd0XIR+SI7wK9ENc86uEZfXfbP4AESUrGxpyyV7EA6+Clo+pwE7AE1Jr7U7mi/PoPSFaVY
 Z4Szt8MjX4J5tnAnD5tlf5P0Kj4Ivw2OZVE7DhEJqhPyqPFhWUZtsp9RQrcFg+kYcjCNbtbg2BW
 DLWoiRqUmwVmmypOdI5rl3TsMwdvtj0VZDlLQKkeomyy9F8MzcqvnpQPFHaXWbyQwlcwtIxYOSJ
 mU3fYyXRgyx5A0NijnZ3Oesatn4aKZp5GiFbXBQLQ=
X-Received: by 2002:a05:6a21:50b:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c110a1213fmr8503751637.66.1783914704480; 
 Sun, 12 Jul 2026 20:51:44 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d3csm7739884a12.18.2026.07.12.20.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 20:51:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 1/6] target/riscv: Add Zicclsm CPU option
Date: Mon, 13 Jul 2026 11:51:30 +0800
Message-ID: <20260713035135.3996990-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035135.3996990-1-frank.chang@sifive.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52b.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option so that user can turn on/off misaligned loads
and stores support.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a76..f8c27a574f8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
-- 
2.43.0



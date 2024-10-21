Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23679D3C938
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 03:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2iiL-0004zO-An; Sun, 20 Oct 2024 23:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiJ-0004yf-Vv
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:12 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiI-00074W-Id
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so2891259a91.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729479848; x=1730084648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlLGdc5fIPn5eaknq6/MET9nRw789lZrt09kcp9138w=;
 b=HMQX2e5IIY/yO7K8cfglbFXMsrhWOJBRqBEaF2ArXjVCUd0Hs580XeIhWFnFFEX5Sc
 hdl8/Bhzr3txPNHhbNFiLNscXcUh0pvn/tLqKDGB4y8Gam9ZljvwjKsVUKlKsc50MRcC
 gnSWiCd0ulduypmUvMA175pZBvr/PxXiO84sCepb2kjXDXHEwpX4ac2UakfmhDBuKuWb
 C+0EHuqUjjAU3yWerh7xudOcW6/hAIZStXL/KqDnN6v2UGHlAQYZ70Zl/0JnAqUUQyy5
 QJqbq8rEtayocNBaPeVOeZTHVc6WL7btvxI7phuQ5+G2ReG5P5tR/+Q4uGxwbJigZmcq
 BOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729479848; x=1730084648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlLGdc5fIPn5eaknq6/MET9nRw789lZrt09kcp9138w=;
 b=FHsRDKPbC7ZhxV86S7450Xs4h3/usOpmzjwJhm2ynb/rrPUJimCPDAWsP9FVANT97F
 gU5E9m+gb2nTXV/m1lT0hjdU84LjXJwphNhn1qQcrk7VtUmkBddAcE4cPjKUDmVa6wwB
 vPMqYeaIPv+zvyyVC2g27q/RDyfSi9CNXxUdmFBPrOWz09uV85+/fRD7bxGldotbykl1
 UeJiBh7b70Mea0/jN1AxsvWMbvfgSWSo3lSs6w2ZykGzc54XGoskIXGM58vR7igVEKtz
 RyiDBnNisF1wLbm9sd1AiwYrCBgUP0XnMfGdGB295WF2o7ylWxK0ZXSWzuNIFGhSKqHZ
 IW8Q==
X-Gm-Message-State: AOJu0Yw4+KRZ+MN9PNX2qTsf+bNXDLhk8w7+tBtGjkqIeQm8kwZ7Z+ny
 B2kempctDE6FdnKjJ+xdAIcQQ3PTGHQkKBAwxNLEH1eabbXghBftNKlSRH0wFLTb2MJGskbsMK0
 7TfGX0ZlT/RsamS3GBh/UWwQzpIg5XJNaIcVm270I7rWoKjB1vkWZZ8FUpUgxRiVNEgfP/uLjSE
 AbOiAjoI6HUt24+l8wqd/5KkdiwCBli2mkKTCcZOE=
X-Google-Smtp-Source: AGHT+IHwchW//LRjffYqpbmWDHk9Gb8drNRRIThjZ/1kv51L72i4PcFee28mqIyhkykNFa6sK3ZorQ==
X-Received: by 2002:a17:90a:c08d:b0:2e2:bbcd:6cbb with SMTP id
 98e67ed59e1d1-2e5616db70dmr10571635a91.6.1729479848001; 
 Sun, 20 Oct 2024 20:04:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad368b25sm2348846a91.24.2024.10.20.20.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 20:04:07 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 1/5] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Mon, 21 Oct 2024 11:03:54 +0800
Message-ID: <20241021030358.12454-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241021030358.12454-1-frank.chang@sifive.com>
References: <20241021030358.12454-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1034.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 355afedfd3..092744360e 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -126,6 +126,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.43.2



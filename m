Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40020D185F3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2f-0001FK-7x; Thu, 08 Jan 2026 08:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2d-0001Bb-I6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:27:07 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2Z-0003XK-Aj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:27:07 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso1968065a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878822; x=1768483622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkeBjY0PxCpkeFpFitWQ/OqLEycCKIIEIdHr5OmBzpM=;
 b=OnlMmQ/Q9WcwzfT8rzww/06H8Bi8s0EmlUWFZGsPpMxDLrlbXl9W0bA4GRRvREfqpe
 jMjkIj5tipOgYe6c5UxERpB/aff8aU+1xppIJF54p5noaTJ9J0et9PMmj44h8bfVtuO7
 U17X9ZJ69GteIPO2pl7fMyW8t1gPnItNqrAbA3w5DbgJP1Z75BfviOdCIK3eiPq9724K
 vSRWh+tkSig3GGLZMEywmDePoxFot+v5+lM1zIiOJVxU1EeA2Cfa7HfH5PcAMkGobAci
 3Q7BuWVZ+Cfp8yiOuaN7yVl1hVYjqsP+7bX8CvwU7lM0P8jecHuPrqD3CWXkAZJ8lmZ/
 fazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878822; x=1768483622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SkeBjY0PxCpkeFpFitWQ/OqLEycCKIIEIdHr5OmBzpM=;
 b=b6lAsJywmLZKD+vP/eSOPBZsSJRkFco6YUsdvIw3AG6+IUKIGoM21u3MbpmwBxgIYh
 O+89Z9b1NmWMdGKCzVDeCqeMCf1bayOUPrJ93GI8SujJp8t1i7CdzXK94FNXxX1nMw2K
 DpwweQJLRo9Sv3dKFslz/xrRpbAoi7Bu4wj+hXNYEpfdTEmlnBlaJf2b3wT0LWger8jP
 36mkMqQwPkehFS5eBPDdXnkungFfPNr5iS03wcLdcSdB6vdw+M89xRV9YXGadgP9za2T
 GrgjVap4en204jiGwFq0lX9+1+Ig9gjpmdEmSm1oRZMa/eC7BNQG7PwwHK8krq/4CDso
 Pq/g==
X-Gm-Message-State: AOJu0YzKvi9KAhjMSN4MhkNRqsnR/UeYzEYjJ49vV+4Rq9auJ/NnsM95
 ReoqTa0d3KVZ+jSctXUo1/V1DNs1o84PWKSoFGOpS3RTJI3UPi1JDoLLZLL39HK13InlQeDUS2n
 gh5N2J/0jRc/yzJHu7XRKDib4hMPkoWBxXtn91wDlsiNjjCJ33Ov3zdbPsKSHzK8ySbRHNcnKnK
 zVUyPOs78/CWyr/woxJ+J5PA59psqWgOSkLn2BPqY=
X-Gm-Gg: AY/fxX7xQeJx6bjOCnP7FLV6X8rBKxaZCEb2MnoL3J6Xv0cHIHnZH1ycnovtW69SS0G
 z3ETvsRaGe2n2MeHnEOMFIusAWea/PV/NZFEpqe/xXTc4lDMRQRwdJ86IgfT4m/Smea0bfY/+v/
 LTIOebDsJAp2fQsWPwW2QK6woj8gBmdwfGQ/JuYgxlzKMrlRxEzEhKUbWWBJrf35+AXtrFyuiON
 yErXLKOyKS8KyTd4Tcd4sSDFIzI4Dhr4DiO9DykusKDQgoLuPhN1UsU4nbnjRblriHCbgBW/qlx
 qWVIosC/MLkeH2qQ3H3HwbmPM8TkbdZ324UjIGxb0YWL2m/gAAl1048+uJYXsXe9xeAg3/6jw75
 r8ctY0M1qQjLMe/SumjPwP4WMcYKjH1XDf5F5TmBg8G1fwbmfyujxckRrGRrH4AAN0alJGSMWoJ
 EXfl9qm7SsmK9Or0UwlImzL72wPOZj919ZT+ZIgbSpHSLyVAKTTs4R5p8=
X-Google-Smtp-Source: AGHT+IE5qz7RNySuDa8yq2PicL4GcJv2VTpE51prCMptiWEe40G/DTtIDlNVW76XvV665s27vG1WQw==
X-Received: by 2002:a17:90b:5823:b0:34e:6b7b:ded4 with SMTP id
 98e67ed59e1d1-34f68ccceb1mr5142280a91.36.1767878821813; 
 Thu, 08 Jan 2026 05:27:01 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:27:01 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
Date: Thu,  8 Jan 2026 21:26:30 +0800
Message-ID: <20260108132631.9429-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102e.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b3caf26704..8eab992154 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1377,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
     { },
 };
-- 
2.43.7



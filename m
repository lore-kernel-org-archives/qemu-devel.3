Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD6EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4R3-0001F3-8L; Fri, 10 Jul 2026 02:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qo-00019U-KM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4Qn-0001vr-8o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ccf2360620so4184225ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663788; x=1784268588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3NJB/BD9o3McPFMsI4fHEIir4MrFnImKCe32i/p8+g=;
 b=Mz+mKub6TPWpY5JbGDIilYoNcPzYWg1tGykL8FLOB+mlJufgurk0zLzqsppMTuURCy
 l3j91hTm4eenUwwHzD8MAy15tdl8dUzSMGeMXjuHBRPwFQqEVGbBLjofY+9oSIBrTdoK
 qO/YeB7XzJ9UoxhC6YrYtJSJ4vzypFBdCB2+F65t73QnYmdDUNcagFGSWPwxSrfRA3Ya
 0Hob19Nex8rotYNJud+Q42B3ZG/mERor6wtorTL50i+ctgu3uTxhOttrZU0LhcExDyHX
 2dX+I0EIgX2Qxz9iAc6fOGw05Wv9O884Le1BB4fzeoHYwKj7B2T007qkAx/gwYXujyop
 8Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663788; x=1784268588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p3NJB/BD9o3McPFMsI4fHEIir4MrFnImKCe32i/p8+g=;
 b=ZZ5oZbhlIhftdj/Y6bLnWRb7UaRn9ZLCRs5iaPwAK7Gn435lqtesnlJz32G1hjhrD7
 08YRH7ibDMiWN/J7IE/ma5+ywzPvwxHJF34A4xw1W7q1UUFIH/UcU4a2gN0+VCpz7uP6
 6dWg8pFFc1o6UNe4LS4ObZEcTa2KFjDBjmPrnJssbPl4pHG6Bkj24CvubJTvd0hv+QCq
 0XBagSe0wvIZF/unvVqSap3uCND0eUsSg7LMzaMBst9/wIiLyqFu7SXDoSOrRqrZXCeu
 QAqNpu7nyZIQV0oGJPk6419KbVI6nrbt7moxITIFF7TwEIeJ5daJ/pXpBZt0QBs0oGku
 juWg==
X-Gm-Message-State: AOJu0YywKh7SJIduswqFF0YMv/NVCyizoTR2pWtwDDHCPQUJ9dfVQwEP
 EWs3JrqHXVRBMDHpYxseqqDsSYB9OimvippFvNkFf9NgMrkRYA+CYnyp2mAK++jCWbUVTrqj3/6
 kSvsdnW5uVLvKjczLNj64L3LbIcvn87QhHI+zvUidPSrh8ZWkA1XsS9lVo+hvXB8I6XDDpDcOZ5
 upjUTW/xNPoVfPSNktLjKvOHbCl/MRM8jKTi3koeAqts+UtD2K
X-Gm-Gg: AfdE7cm6AOEXDnv3dGS3WHhud3N7pIC7ID14hatUD1HJiv+/5qWUhi5d1wSicH0qIoc
 wSHXDCwewnE39QRM0ry2MLoxRRZUohA8I19hVqZz9Iqw0/eyHp2/mQBaSD0+5mS+Ozg522Nvth8
 Ss42d42HCQX4Dd83rHvgZUcM2McSeEeKTQf+3fqM22XBDYSE503aJ9JB42p02zPGiQ8ZanrXp7h
 2/R3PULKuVzzewSi3OWrgYMf/Hd3bMWU11pelxEGVTJQP+XNRUFa8vI+Kr0oiChZfN2vsgaHkyw
 ZPS47OURVa7nN2FKnpJV25kZgAMGXrbD7bOJhlTz76RNsGvH0zMz8+uD2TZYPj1+3K8x5gwnyJ7
 ZgTiTboOdyMIoiPYOLIRfhVkqNNizBZ+j5rdNbTxMbvrnxwhjHv0m4RlRrAMrYW0Re8cWKgSUOq
 +aAektakdd9PYDUucU4dTRCPTUsVb5ZoXb+5rIPwQ=
X-Received: by 2002:a17:903:234f:b0:2cc:f4d4:29a6 with SMTP id
 d9443c01a7336-2ccf4d46bfbmr83096455ad.23.1783663787721; 
 Thu, 09 Jul 2026 23:09:47 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:47 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 7/7] target/riscv: Enable Zicclsm for RVA22U64 profile
Date: Fri, 10 Jul 2026 14:09:14 +0800
Message-ID: <20260710060914.1227027-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x635.google.com
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

Zicclsm extension is mandatory for the RVA22U64 profile. Previously,
Zicclsm was enabled automatically when has_priv_1_11 was true. Now that
Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 04b1ac22f11..19b93f9c979 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2237,6 +2237,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.43.0



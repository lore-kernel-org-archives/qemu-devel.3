Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA18C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN79z-0003Pz-Ee; Thu, 05 Jun 2025 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN79w-0003Mr-PT
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:45:16 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uN79u-0001zP-Si
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:45:16 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-7d09d4c8543so88545685a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749116713; x=1749721513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ubn/J2LD5Dpe/hzEurxm0V+J1k3g0NG4AbGEd3fS58w=;
 b=Bp08Wn/6bA+HPDfnXyGopQcrMES1KX8Dz6XxMBJPJJccYvyKWQ4/TwVFY5gC0t5D0E
 hTq3TzkBAB9KWAQrAnKdkwnpyNw+B5NLWAoxT96JSisVVtgC1KfmyrZdXxYh0cUpgHME
 +w5Ltbx+PEIJGANsl/pzxl842UO9yMuZg8NDlpnJdErOXkzt5Zete0cKkyoKUEzY1Ssg
 VLy6L66+F+YoTJbG6KkQ0+ntiCxIVBWo/X7ikIpqMmANCuADTRsmzFupXaK2MOXNSYev
 otO6AbTKq+TQGI/3DvOfMh8Poe3ip2/5q7yaEQD5Dp/YVcsIbZNj8lHwwKIAwA1FLZmj
 R6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749116713; x=1749721513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ubn/J2LD5Dpe/hzEurxm0V+J1k3g0NG4AbGEd3fS58w=;
 b=QPozsD3ZxO/gfV5fQMaswcL7ogaKUaJlnl0PtGirOgQkqpc9S/z1wrqsLVWrhMJI5/
 nzqDl1Q3hRWzocp0a9w9vFhw/+7QearL41QgQanAU8ZZB+yI24h2qARhk4mB6qvxSKnO
 z/hNjEZqHIu7KiwtCu33/yzObn4rpUswbC78IPsLh7XpZmyf3FsieueV+M7/alw0INXC
 Ozd7IOitA28ZhJH2SO4S8IPF40qZU20zMbfkWjJlJX16DuDBvhR3aY2NNJ2kfKOWRgcB
 A5vbn3rIv3+liXTiajQ8kTvRqLmAWphSIirLXw48ZzOKtEFe5DKZ4vH/xqY+5r8AXd2G
 rqWw==
X-Gm-Message-State: AOJu0Yzjc4MZVqt52gbB74q2v/qgBMVdPfcb7jn8lPnN1kABtdL9N98k
 ceC+eRvT/3vsgq1tCznO6uDEkGkkr6cdE6FcURxk1PMQ+WrH2L2a4/xJcJSggFWYrEwcYNd9IL7
 WfpaUwU4gxA==
X-Gm-Gg: ASbGncvwwU6o96k/2/y40clCiV+hs7mzBBQc+dNpYD68EEyzok0jOMRYAh3cCKMH5gB
 iOPOgmik32gHw62MKaK6+tNWxAJhb8twYthOyy+y5CQnEGDgY8vbBPySTWW9+7gtHURT3QSwIN7
 DJyS9mReXTwUJpPhjl6JozyBT7aImDvCG/kVmcoRu7MvIVzXDlwb2xpkjIOzYl4EIAw9CZe7NMA
 9bhl2i/tNB1iNKQI4dkur8LAT9bxGrqa3N09k2sIi5CtZWuQkAKROxgOzT4cIlXPVunXb1+wiNW
 kMhSbHUY9FWfiFkNHT2NIdEjYCa//bN+XWyDQlJQNxk2HNSeaHSlMd4Nr/CSdAVM9WcPPbiZ+Js
 h6VUPppCPhGZSbwM=
X-Google-Smtp-Source: AGHT+IFGdS3cZUGZqayFGX32YUB7XyxvTrtGrxnbYTNW9eimRQ/Z96qxLDlRve1wnRyPrh5qqJc2UQ==
X-Received: by 2002:a05:6102:534f:b0:4c1:9780:383e with SMTP id
 ada2fe7eead31-4e746d19f41mr4214959137.4.1749116703187; 
 Thu, 05 Jun 2025 02:45:03 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a2c28d8sm10063093241.15.2025.06.05.02.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:45:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/1] riscv: qemu_chr_fe_write_all() in CONSOLE_WRITE_BYTE
Date: Thu,  5 Jun 2025 06:44:55 -0300
Message-ID: <20250605094456.1385105-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x742.google.com
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

Hi,

In this version I removed the reference of SBI_EXT_DBCN_CONSOLE_WRITE in
the commit message. That API is *non-blocking*, and citing it to justify
a change in a blocking API sounds weird. It's also uneeded since we have
a good case without it regardless.

No other changes made.

Changes from v1:
- removed the "SBI_EXT_DBCN_CONSOLE_WRITE" bit from the commit msg
- v1 link: https://lore.kernel.org/qemu-riscv/20250605090012.1268809-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (1):
  target/riscv: use qemu_chr_fe_write_all() in DBCN_CONSOLE_WRITE_BYTE

 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.49.0



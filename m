Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14EBCED274
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy4tU-0005ih-3b; Tue, 08 Oct 2024 03:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy4tR-0005bx-Ez; Tue, 08 Oct 2024 03:44:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy4tG-0004A9-KW; Tue, 08 Oct 2024 03:44:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c593d6b1cso2495245ad.0; 
 Tue, 08 Oct 2024 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728373455; x=1728978255; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fvPiUFqeTwsIjYhM+dD6WWD6sdYIbwRbf+mb8y/PZ4=;
 b=fuA4CJ1nVqe0jd/j6o/xtPN4jMWpNeVosK5mXxqYcME73OY0KROr/vnFKEluSLl4Aq
 VbvuZySX+81LV1RxaK3rAijRx7pShSyNf2Bs/5Rkoxaf/LZcHTfL9vo1cB10T5kcAUBS
 vGwqYi0+TSSegXasmeHBdYJxVTBAK/oijbXww1F/QjlO7lqb3CdR6e8N2zwA2XY7pU3v
 BZJp3/DkkfEf//o8znXZ1pucyiM+PfoUVYLBsK3JbSdyQcBVYitZ7xtg+OGSxwynZwXH
 QQvJiH8D1+q4h3nvopt7lWA4/iHTF+mPfbdB8vNIZxF+oWFtnwGX+SFLpltwgSb1hFc4
 vgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728373455; x=1728978255;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6fvPiUFqeTwsIjYhM+dD6WWD6sdYIbwRbf+mb8y/PZ4=;
 b=BMNGQWRE+TdGfTn7oy5ffxG/9Iz2EUCA3nYj9QffIq6ybvZm6ij/l8tVcK/tBmeEPo
 5JsjxMdH+Emdwa2IHBxRsFl0gpAnbKqj7TCcGgdxIVeIBwX9RsRtwmOyCfbdqewVn7TG
 dmurPyLC9npiwIBVfZNcO8roha4nEuQecIocTdg0Xu01fcspoIeNNE0tN75GjAUXWUjg
 ihNBsKyKGtunfgrbJXUSgMTGkInO8TimO3vLG8Hv2O004OaEVjFxrp/2OV6gxaDeuORG
 8uTg2LXu2hSi2m4P8aqCyg8B9R7Vex6JkPtgr/Y0iKteB/3jkxoiBwwOSDnHFFek1mNR
 L5nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDgRvG2kJfujdX+yf6kCq2FK4CB9wapDAfVZRAQozIfxvQYH7ePzzxYoQTqSFr9Akdf7zvSLuHV8qz@nongnu.org
X-Gm-Message-State: AOJu0Yy0ShwV+13s3aTPwhzMzhMojzFoibgxN0+2HiGUTSe55A4VrMkG
 yYofNqzwuJ8jEFM64+hszU4slTbAT+HCaTMJDsYSh1KsgM5IU1fF
X-Google-Smtp-Source: AGHT+IEEZkj0P7044ctWPwXSHiDxqJyMSfRoMLQCSYSAAweL4upvDnN84AcVyWWhtqULROonJ58DKQ==
X-Received: by 2002:a17:902:ebcd:b0:203:a030:d0a1 with SMTP id
 d9443c01a7336-20bff18cadfmr278881505ad.58.1728373455279; 
 Tue, 08 Oct 2024 00:44:15 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c5bea1e94sm776865ad.92.2024.10.08.00.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 00:44:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 17:44:08 +1000
Message-Id: <D4Q994U5GSYV.2BL8PTP7YQZTG@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Cover PowerPC SPI model in PowerNV
 section
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <20240918165045.21298-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240918165045.21298-2-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
> From: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
>
> It is unfair to let the PowerNV SPI model to the SSI
> maintainers. Also include the PowerNV ones.
>
> Fixes: 29318db133 ("hw/ssi: Add SPI model")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffacd60f40..b11c4edaf0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1541,8 +1541,10 @@ F: hw/ppc/pnv*
>  F: hw/intc/pnv*
>  F: hw/intc/xics_pnv.c
>  F: hw/pci-host/pnv*
> +F: hw/ssi/pnv_spi.c
>  F: include/hw/ppc/pnv*
>  F: include/hw/pci-host/pnv*
> +F: hw/ssi/pnv_spi*

Should be include/hw/ssi/pnv_spi*

Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>  F: pc-bios/skiboot.lid
>  F: tests/qtest/pnv*
>  F: tests/functional/test_ppc64_powernv.py



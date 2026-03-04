Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921D7EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpsu-0006nf-Uh; Wed, 04 Mar 2026 12:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vxpsm-0006my-Lt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:19:37 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vxpsh-0000Yt-LZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:19:35 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-899efe93d4eso48206836d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772644770; x=1773249570; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R3iYifLeFmiAAIRNLZEW3S8HIbLls00CHTTy5gn3y80=;
 b=B0IaXTMGrM8Ofm/PrI4o86WL48hYjPeI18cl4+JtPquv4IfC86ztIZrIGOOBB7NtqK
 JbrV6vCcrUkmRdbdVcPSYcsFsZKgHhKVacUsDrx0iyQF4YhcQUhDOjjgnggPypvTwV7V
 AyezuzsmBr0cctcRxmPttWRtM/OC5HNnDUR2+YjvoNHZGZnMKzrxxRiVCaArdGm7iQ23
 cAP7S+aA4Xvd745jspPo0V5THbhXVoqSF1z8zlvbFP7YuPPi96uvRtqJV8yhd2IOfKl/
 tWae2mrL7rU5MoUGhZKlPqe9tYZoUvYa9h7nZEAmdaNS3BJFRBs8jt79sdnAGPJU1gbv
 3jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772644770; x=1773249570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3iYifLeFmiAAIRNLZEW3S8HIbLls00CHTTy5gn3y80=;
 b=NbF3EgTugQVo2cO/T3TsOxvflrPjvhXsiTrElzRlPCnbNZuTvoQ58VPThFser+HdzC
 7nu9PYfAesGKlBMjn1W6338DA+lRWMht3lvoEhOngUEoHqWDbjCtto5OVD1OR8yFq6yx
 nG1Dbp7GaRtCAXXOWV+AhK/PiCqyX9mkj7ADRg314X65FSJZzYLRRvx/ohPQ5Ji9QV7A
 x6FW3FWVVmB/uYGOok6HopVLjGp5/CTRwH91Hr+hjZgQu5r8WzzH99DtAqQ14lecr2Gh
 Dj6v1dkuv+gb1/RGnnjBnYfyk0ZVkwRIQBmVZyHYFfODw3s/IN7EkiE6nng2xyTZV6bQ
 NyRw==
X-Gm-Message-State: AOJu0YxYA50fnhz3S9G49bGoa6qu849LZ6ySQxcIm6RjvImL32c+1xVL
 Upc595+/WMzEC/1xoEfHIhqFLNWz0eCw3FWJnFQuOk21SAuflcvy5+UigmD1M1ViT8U=
X-Gm-Gg: ATEYQzzWkOCX10MPk9Vpy0kaFmNXp83usEiK51Md1wMiQiuiFNKLeXDN128YwWz9tg+
 J+MfzChMgGIyP/713x1p8LSZ8jFdjwQtJbhUjhEepKyM3IDn4Oc2/yMtZA9ZNQ6c6zLiHYLh54I
 7h36nVu4mqTq1QfHAYne4PbBWHokjMW/RPy4caJMgSXve+XGmxo0vmeSLoPsXTvqXay/oykI5fo
 Iihro4kozZ5kqQm3b5Yd0zWIGWWJNUsMywpKb+lpHCaR4khm2HUCVeSEM26chr8fyMahY9rJpzs
 e+KUdSqtIMZEjs+d5u7V8AKW7rlZdZhRqvF0k+FuMNxhiQU+OWki8fxCEUS5+9se0HzeVDxdzlt
 RLP1z5SVQHSXoI/bEhI3Jf3xcsqwPH758MaS56DCTL4Jeqts+NrSAda7mPE1Sao4QRKGjymtE+D
 xCU2t3xidgRz0aXlCSZrnTpM3ZbvRIfuZXrXZVjr5/c79Eeh4/ZSWqmKiAmMlIYXOpZkboq1F3Z
 lcD7fkYqT2KzSqs7F8O
X-Received: by 2002:ad4:5ca2:0:b0:899:a91a:2e08 with SMTP id
 6a1803df08f44-89a19d03bdemr39974556d6.52.1772644770087; 
 Wed, 04 Mar 2026 09:19:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899ef69b089sm92205146d6.46.2026.03.04.09.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:19:29 -0800 (PST)
Date: Wed, 4 Mar 2026 12:19:27 -0500
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, apopple@nvidia.com,
 dan.j.williams@intel.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <aahpn6ClnUZXjlXu@gourry-fedora-PF4VCD3F>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226105023.256568-2-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf29.google.com
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

On Thu, Feb 26, 2026 at 06:50:23PM +0800, fanhuang wrote:
> Add a 'memmap-type' option to NUMA node configuration that allows
> specifying the memory type for a NUMA node.
> 
> Supported values:
>   - normal:   Regular system RAM (E820 type 1, default)
>   - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>   - reserved: Reserved memory (E820 type 2)
> 
> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
> that this memory might be managed by device drivers based on guest policy.
> The 'reserved' type marks memory as not usable as RAM.
> 
> Note: This option is only supported on x86 platforms.
> 
> Usage:
>   -numa node,nodeid=1,memdev=m1,memmap-type=spm
> 
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>

Thank you for the reworks!

I will set up a test soon, and this will actually help me with my other
work, so it's much appreciated.

Reviewed-by: Gregory Price <gourry@gourry.net>


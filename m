Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11BCC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcocv-00080K-47; Wed, 21 Feb 2024 10:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoak-0001kA-TT
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:33:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcnGY-0006AZ-OH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 09:08:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41275971886so4928355e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708524483; x=1709129283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvxVlg/e0FP+JmtR5W204+N0FWXnrrzSs/9Cl2xOz2M=;
 b=z3HXdVJnqbapcoUIuKiFuh6wnZKMSDsdQRmnAkbZucJ9TSf4HNPxdp8RAFRgNJyJlP
 eZmPCbkFPbI7TgzQn/bO1QPWeLyxN2nYcaRP222QhB3bNEMlnw+5JaDOF1blZ9gapzut
 aNkswxm1AZN6zm/VJ/p7ezzBw8cXkDT+ABXZdKmo63SRNsR/J4JllUsngTTX0O1OBtVp
 sm0GwU6IbQt56eZE1sg7Wll4JOTYcV90wGtbXivCnDZ57Nv5P2g8BdMBZa9q03Ngcp8n
 42okGtwyqh4D6OrRv2ITbypyZMnPS2BiTfdWqnunpUdOP2b3/7tKrJvUbLAwkB43YYiY
 qQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708524483; x=1709129283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvxVlg/e0FP+JmtR5W204+N0FWXnrrzSs/9Cl2xOz2M=;
 b=eKdYhV2+yRFSRC/YZLXGx/v6Jd26jgTfp5JCc5Yc9Yw3WSQedfJzr5tAvgHBPYFCBE
 Z+l19/9GiSLxKQjLElDbZjKsXboK04iNXyr/s6CNSpTUOGlNnVIh7sXskpkSQRUZUpsk
 5C5G+RIHGwtuKTE9uFEd7EVH3A7frKKTb3d3x6Ehts5XqXLkSh89pRzSDKLnxuPeM8Xk
 SeeUx28D/oB2imvN1IHUg2A8diKBtpahozwi8GEEsgOPKkKjjvmVcqQ18V/hTz28Q3mZ
 oDEwsv+ZZjvSrW8Lb1GuT53YgUBEd62gg5ZHbZGTXUwXKolu4KHtJLleQ/+1coq2CbaT
 xG/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsX5hy2poE74PjjqXVGMLDU8oFUHA5K3qoRcE9CFueTZjvh/1VgO75KOr9ABaJ7Qls+tKDfLtRBlX3BBRyBL81NF+fY0o=
X-Gm-Message-State: AOJu0YzwNfqzww6qhCZDHvf0uMLMl9JQl4i3uhfJu5uFT1MRz4LonI2V
 btIVdfJaK+v2q6ysk1f8hIUeR0K62POHYcxKiv/0JXxAMUSiznktGP8zQzx4/MU=
X-Google-Smtp-Source: AGHT+IGIu9bpxh9ZSs8olx7byzqCkTXn5WknDtojeWHM4O2pqlfsOWghNdpuOY0uy/02vpv/2X1TkQ==
X-Received: by 2002:a05:600c:1d89:b0:412:78c8:c665 with SMTP id
 p9-20020a05600c1d8900b0041278c8c665mr741191wms.13.1708524483243; 
 Wed, 21 Feb 2024 06:08:03 -0800 (PST)
Received: from [192.168.245.175] ([81.185.169.168])
 by smtp.gmail.com with ESMTPSA id
 js21-20020a05600c565500b0040fdb244485sm17930129wmb.40.2024.02.21.06.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 06:08:02 -0800 (PST)
Message-ID: <71c88e69-e5e1-4729-a3b3-c4e82dce68d8@linaro.org>
Date: Wed, 21 Feb 2024 15:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] hw/i386/x86: Turn apic_xrupt_override into class
 attribute
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-4-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> The attribute isn't user-changeable and only true for pc-based machines. Turn it
> into a class attribute which allows for inlining pc_guest_info_init() into
> pc_machine_initfn().
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h | 3 ++-
>   hw/i386/acpi-common.c | 3 ++-
>   hw/i386/pc.c          | 5 ++---
>   3 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



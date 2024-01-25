Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E01C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpCz-0001ha-Oj; Wed, 24 Jan 2024 21:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpCy-0001hI-3D
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpCw-0005Tl-LR
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706148669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxVvneKtmt0XkxdEeJCPkZw+HwbT0oKKeve1U4V7NSA=;
 b=QwdZDZybhfPhuK+5YoAwf6BpFKecCZwNhHXC5J2BqFI1EINg139gqv+PO6WkG01VSzhiwd
 Uf3A56zVt877jhElTQCKzxysFuk4Y2HaTTau6Gh2k8fU4OrKu080EF984zUfLpImI6SdW4
 y2DVeU1DP16yttXGQlO2i6C1aVdDsX0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RdXoT5otMo-TwcKRvPYMZA-1; Wed, 24 Jan 2024 21:11:08 -0500
X-MC-Unique: RdXoT5otMo-TwcKRvPYMZA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce67a3f275so3746354a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706148667; x=1706753467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxVvneKtmt0XkxdEeJCPkZw+HwbT0oKKeve1U4V7NSA=;
 b=P9Uk2EVtnIl7Vp/FDTVJOPNQ5AfLrWmvLdG6EFj20PeSiRSOJ8um8oYv4Lq2uJGoeW
 TzIkEQX7z/x3o8+bF8J41HTL5FvHOisPyhWB7BDlLS1UEF3kpmYQH26fi/Fu9sc/rLGP
 z/XU5SI52LNLfKtMOSfXAvFVHg7ZXur2hi85HZE/lTZsc9S5tdKT/pQXOveld91WBPLe
 GlhnSThjiczUwru2qmh1u2pZtuI2PeUKLcUUm2BDGD2UGggER4hyWAclMdVtQ/3sTcd1
 Q7VUn/ILqs16GZyzT+054heCBeN2Ix6BSXaLj5dnTZFCAK7tejTk86VJwufpeHx5xtlP
 35rw==
X-Gm-Message-State: AOJu0YxjLdCn7pXDjgEMo5PUKUv8SgRPYmMlF8Dl2mRKMGV6Ck+mGFOI
 FQmT2MQ/iUm4BrjdEL0I8vlBntINk1sOPPxutMTx5zCXIB/3CMiWcFj3+CAulDLJh7/j1bpjKLx
 +eowmaSNmm/3K5/YrlC/e7afF4GwvvbJma4wENA9vxSlJNhxepDbv
X-Received: by 2002:a05:6a20:7d89:b0:19a:813c:62c4 with SMTP id
 v9-20020a056a207d8900b0019a813c62c4mr339947pzj.29.1706148667162; 
 Wed, 24 Jan 2024 18:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJZNtpzAOxDwX3zP2ZeUwQ+7BgepNDHaC7xXMWRq8cCEU8TufXabwT7NgX+/F9a9KA82jlhQ==
X-Received: by 2002:a05:6a20:7d89:b0:19a:813c:62c4 with SMTP id
 v9-20020a056a207d8900b0019a813c62c4mr339931pzj.29.1706148666898; 
 Wed, 24 Jan 2024 18:11:06 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902e9cc00b001d7035b11d6sm11015403plk.254.2024.01.24.18.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:11:06 -0800 (PST)
Message-ID: <f3465ee8-74f9-4b95-919b-16f7255c93a2@redhat.com>
Date: Thu, 25 Jan 2024 12:11:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/arm/exynos: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-3-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123222508.13826-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU type.
> 
> Instead of ignoring invalid CPU type requested by the user:
> 
>    $ qemu-system-arm -M nuri -cpu cortex-a7 -S -monitor stdio
>    QEMU 8.2.50 monitor - type 'help' for more information
>    (qemu) info qom-tree
>    /machine (nuri-machine)
>      /soc (exynos4210)
>        /cpu[0] (cortex-a9-arm-cpu)
>        ...
> 
> We now display an error:
> 
>    $ qemu-system-arm -M nuri -cpu cortex-a7
>    qemu-system-arm: Invalid CPU model: cortex-a7
>    The only valid type is: cortex-a9
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/exynos4_boards.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



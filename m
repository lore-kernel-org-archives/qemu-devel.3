Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34751CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrKd-0003r3-RT; Mon, 04 May 2026 07:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJrKc-0003qY-M2
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:19:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJrKb-0004GB-4u
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:19:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso2250836f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777893559; x=1778498359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDMHwGyW7502QhopCExMsRazAqKSVL5/HQleasGK5Ms=;
 b=t6N7qwfrLaoaQGAJpwCkGHbCMMdRM3XMH8zow8HaiR71VN09//KQHJbCemKsV1POfo
 wXDjYcqkcZAYwgFWxJOLNMU/a6SgQQNBU4nA5kg9+hAAIP56yMPfMqJNPDMLsUekaxR+
 5ndCKmM0F2zU1COJxGHEU6d6i6wiXNtvBOQanuqudZgydXELI3GWrSp8C+tCRZ2675F5
 OWE1ajl7lL4jzmkaTqayC7PtLq8CEr+oAqDyfNCtfQ4R0G7lniDsyNxO7uapqSKMtPiH
 M/5T0bAGzerjNMmhuLtgMKFjUrcqv4Qco8Yx98bx9eHJroK3cyWCsujkfADsx5gBQLHI
 S0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777893559; x=1778498359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDMHwGyW7502QhopCExMsRazAqKSVL5/HQleasGK5Ms=;
 b=maz1Jeo8UjRz2AZG+HDQkT8ILoLCSANtDYI2ayk9rvRSFQIjvROu13IrTSMpqgW6Yk
 eiuLJMn2PfM7Vb9KJgo1dywiBboiHS+dBUs31onx+g6Smi23gnEr/lLIE6MqNG4jSuhx
 KX/wn/7R/c9nFrpuv2C4lb56AyvkqnPFBNtv6CN82BrJXERWG2GFPF5FawdAlsqwPePV
 7HftyzsdKu+Hw4HRY943ToSEozk/WEtGtnL6fAO0dzH00VblSaa8raN+o7IbmIykLGEq
 6nvGpSh8Xpv04tvanaenURxM9aT2XB1Ttopl5fUqKN6N/jvjWg/gfwqpWv30CUbMp0T/
 LQ0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NHOWeJgouX+t4y/pfS6/hzXRsmth0wdI3DSYrliqkVhpsGQ0zNq3drJxZMXKphecKKmqm5r0xqNFj@nongnu.org
X-Gm-Message-State: AOJu0Yw9hE5LXAl2kMr+Uy4WRdv+9FTblO/4kHxrkNfpzvdBRFoKG9kg
 m9/OTYQRn4VsGsjYnQyqOnTmUQz4j3R9q81hhSU/vINN7My3JtELKMVpAL45eJEcKvU=
X-Gm-Gg: AeBDietAKhFd8ZSLoY3/PyNQNAkFr8szl5aPUx/vym9ChOIoSuZ/nvPXjJL70HwfsEg
 8rLln8b+qBWj04AadMEuINYmycP4p34RK+BVmRz87P7fvA8aIy42h+NLUgXn/dSwdHq8dNHWBW4
 jGiLZpKqNVkCeZgn0jh1ylugna1vhKP8DIgTWZu0VlV++L7AW2nDRcFOBpVgud7vD/LpHcpuROS
 msVYe4AN6oCi+uvjY0rTIVGQZOJYqzBSq8iLEHzhdFLTnzBZSL3hSQNhjs8Jc5w7FQI8v6nKZ0R
 wrSv/jgz0C7aqeyGGu/Xf3wTr/AoMkffWLcP+x8HOqBRlz36fY1BSW+jYpZHEOBeULHZSmu7mPF
 7vAMG/ZxDce2gwTG4nvc0pCpy4MvgmV/g5/sCEFDECqXfqx48Jh64G4lMa2+P33o05wPte0I4dj
 DnSraLWB6ndKWbOcb5fzl18m7vc9z4KOtnvY11bWORFwjRLUPnF2/LQnM2dln/CVZuiQxvG843g
 egpMz/EiW7fKY8=
X-Received: by 2002:a05:6000:2103:b0:43e:ab40:28d with SMTP id
 ffacd0b85a97d-4494dc52adbmr17441943f8f.2.1777893559517; 
 Mon, 04 May 2026 04:19:19 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7cfd2sm23691611f8f.2.2026.05.04.04.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 04:19:18 -0700 (PDT)
Message-ID: <5346becd-5178-4a63-a049-b4fab4f5eba4@linaro.org>
Date: Mon, 4 May 2026 13:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] hw/arm/aspeed_ast27x0: Set EHCI
 ctrldssegment-default
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260504025342.1452605-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 4/5/26 04:53, Jamin Lin wrote:
> On AST2700 platforms, system DRAM is mapped above 4GB with a base
> address at 0x400000000.
> 
> The Linux EHCI driver programs the segment register to zero when
> 64-bit addressing is supported. As a result, descriptor addresses
> derived from the EHCI registers do not include the DRAM base
> address.
> 
> Descriptor memory is allocated through the DMA API with a 64-bit
> DMA mask, allowing descriptors to reside in DRAM above 4GB. On
> AST2700, EHCI queue heads (QH) and queue element transfer
> descriptors (qTD) are therefore placed at addresses starting from
> 0x400000000.
> 
> Set the ctrldssegment-default property to "sc->memmap[ASPEED_DEV_SDRAM] >> 32"
> so the upper 32 bits of descriptor addresses are adjusted accordingly. This
> allows the emulated EHCI controller to construct correct system
> addresses when accessing descriptors in DRAM above 4GB.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49936C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqY9-0000qm-Uw; Thu, 11 Jul 2024 05:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRqY8-0000kN-54
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:57:16 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRqY6-0007Gk-7r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:57:15 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eeb1051360so5162541fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720691832; x=1721296632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DESmmqZqcnlslB5OYA+Wlgd/MFSudQnqD8xQ0+B3Ih8=;
 b=BUKGWgbOL5RJm70wKjTBchqcHQFL7UHp80J/sGcpbwKeWgYLrtXj8d6sup9dfVWXMH
 QN5tMzois/mvUJ5CSOBAAbKFcLmAVxrbzM23SthidHxtutBAKpLGkLoPrihVDTa+AWT9
 ZZMTC4k/eb7vkppsAOmCiqLFlGMhBbv8TpOTnPE4m++B5DbLWNk3q8pAdvIw424b9bAw
 TkTLEfmEoOOW+5JeYOoZtoPl9oaOOQLD99xiPw9lkVbVdaIYPtMvW8bsRz0L0D2mjhH7
 wgxy1plH/yF6pEyd65vjskaUsqJQwuzcUG0VviJqpzwaAdFU8RjuGfeXuoW1kU6BItCi
 T0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720691832; x=1721296632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DESmmqZqcnlslB5OYA+Wlgd/MFSudQnqD8xQ0+B3Ih8=;
 b=Ct6ufulGc/Ebhw/RJ9NNt1/zOXluOfXr5tWYe2C1WqtdgErXimQPJNPRlxrDLjLFBl
 sGrb8jdnhjZHKEAdKpSfu6P/W5ORRuQxuo7Q+6p0r+dHEIN6J0YHoqEFdZ9qfNu/7iyb
 6wnIF1rFfZSiPpFPuka5/Jpulmhvv52mDEF9poSmW33cwqd2Em8ZX3jwN3r4CfhlRBRe
 Kz46x6yHI72jGFbjlBLSa/+D3vg7hsNmQluhRJlQrK4Sts7eiWuIQog3/Visdrog45vZ
 nGC5cDeim1T/+FIVxDDeXAoeFM3m25n5Kcp8jZjddeVpjTfLb6337qc4E+Bjjkdiv2QV
 CQ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlB7MBm/HY4NvhkhSBROsNLYhjHQQZDN3zw5tu1U9iY56pazf6tCWnEhWPhiRhab0b6Hf7hHbceCNehbwS+YQs4iTEyNs=
X-Gm-Message-State: AOJu0Yyvt9SJa3TYthLmvSIhJTLJltq/iht5QRAJy1FtYyrDI/f4l0+X
 tk3zcq/wtupGSOC8gGmE71Oc6LBx1l0UkaFkveDpV2cazKUlO8Jt5pJX4HeZkKY=
X-Google-Smtp-Source: AGHT+IHBpB1SZe/EZxXzaldogBzQuZ/3dDM2WSt5vj4Jxm7vuw9Vr96jeP8mArDPVm0vuITY6OYfBw==
X-Received: by 2002:a05:651c:1039:b0:2ec:4913:2b55 with SMTP id
 38308e7fff4ca-2eeb30e3cc6mr53715801fa.22.1720691831985; 
 Thu, 11 Jul 2024 02:57:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.207.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde846a3sm7338237f8f.30.2024.07.11.02.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 02:57:11 -0700 (PDT)
Message-ID: <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
Date: Thu, 11 Jul 2024 11:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240711074829.3338879-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711074829.3338879-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Hi Richard,

On 11/7/24 09:48, Song Gao wrote:
> The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:
> 
>    Merge tag 'pull-aspeed-20240709' of https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240711
> 
> for you to fetch changes up to 78341408e705e1b8dc92eaae2071ae0023d586b0:
> 
>    target/loongarch: Fix cpu_reset set wrong CSR_CRMD (2024-07-11 15:56:50 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240711
> 
> ----------------------------------------------------------------
> Bibo Mao (2):
>        hw/loongarch/virt: Remove unused assignment
>        target/loongarch/kvm: Add software breakpoint support
> 
> Dmitry Frolov (1):
>        hw/loongarch/boot.c: fix out-of-bound reading
> 
> Feiyang Chen (1):
>        target/loongarch: Remove avail_64 in trans_srai_w() and simplify it
> 
> Jiaxun Yang (1):
>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine
> 
> Song Gao (2):
>        target/loongarch: Set CSR_PRCFG1 and CSR_PRCFG2 values
>        target/loongarch: Fix cpu_reset set wrong CSR_CRMD
> 
> Xianglai Li (2):
>        hw/loongarch: Change the tpm support by default
>        hw/loongarch: Modify flash block size to 256K

Please hold on before merging, I'd like to check with
the author for migration issue regarding the flash block size
change.

Thanks,

Phil.


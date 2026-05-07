Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3141CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrk0-0007Mg-1u; Thu, 07 May 2026 01:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKrjs-0007Li-Gr
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:57:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKrjr-0002VU-4R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:57:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso3179045e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 22:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778133452; x=1778738252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DcSAW5v6Nn6KAJOBB2SGq2XiLgGcRFcX+C3SezePc8Y=;
 b=K0CPdPV+D/PBtA4LLFysWFhea29IxOieQV7gmt+wDGGiz/PfszsRkh3p7/aAsS32aD
 NnT4g7HGT2A7H54QPV960p8Lj1Hdcx6ZvvaIRwgnoGZtBoZLxrzRw3AUgZmZrrohlFqK
 j3JoMq7iQu1FmDVtgKdO2mcjNtRW+PlOPC88dZl0PfIkZ1lcsAwZNEsSzqiC5BBcZIXW
 Uv4/zqE2U+ra4i1Z0xThRXtfopp2EbzyOALenDulvghf9B0jWMpA8ofgGUeDrg7wTx6Y
 3LsSBHIP8zcjqkhgnKt0vH/nEEq5mNGqCZTWf+pSFQKQnOrtEIvY23jOsRkQrKlDNIFn
 9S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778133452; x=1778738252;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcSAW5v6Nn6KAJOBB2SGq2XiLgGcRFcX+C3SezePc8Y=;
 b=XXQMoznHEhwIlzwMXt5yCP5gw0EieN1VoPI4qMEk4s+MgrsNrkroCx2mI7gcnEp8e5
 MJ2wfiOUcXCYVzsQj8i6UOArGofIsE549XN1S9dRcFbhCM6l32enfXY//2ZjNsyTtXTb
 PUGw1ZpcLAzxGO2QLI5WOt9uKP8+J6+3C5KOADErXhRUbWmJjRnJe+j2WaB/8dtB44mi
 xa3JV7fvh8MrqeLhBLFcONhbFDWtzKMYgPbygl1RW+aErXUPOP3Hzt5JuevbHkCInc/H
 UecdzSGwOvJXor+gZLvK8vPxLAp4xG8JTrKLhpLEZQNkBhZZXmq9cSdbgG5a+wYUQJNI
 cYYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wOUQeP3J6kHrl5TLsZXQteUGf3o87iSYh+z++W2iSDXbCJOtb5DW5xILsFyL7+ETUvPyDw2rwayOU@nongnu.org
X-Gm-Message-State: AOJu0Yw1khThBUKJ1fSv/hBybxUX40ouOv7Zvsd0uzli7rDi3JP3QhSu
 RO6vidNvdHqIAfxfReacgkN/HdAvwYh3MENYiiEVmWhQg16nRxIuCZcFdsc58HRxDu4=
X-Gm-Gg: AeBDiesSmdkp3kUzMP2Zkup1P9TqNDTmuoIO8j+OLwWj3BFyIDR0KQN3YNeLz++5ZIe
 QdiVdWXZYnzmHT5Hi5ubWkFlTWf2Ywj13kzqXLKJNIX5VPcS61CZ8tdTqSs+8d7lDLm74dtdRsR
 em35OPnQu2HC6fOZomaIGu9lMPPiP/ewHLWdQtQ0Rr/y4ClWWUNJJ+U6idZwVdbHQQeo5j+eS9j
 XU+oRDxy6JCliVKWDngWShzaoaW1xr3z5enfAuszxD424OkjarKO/Vq4jVZE5swXvW8T1TpM8kG
 bUzxU+3ezbmzkFOZUge/yzFtzouVxUMaJG2/6Pu4zos7mBXgyF8PIlkcCxIB679lMzkR1PXrw6Y
 5AgsN+5ilyM2LrFPjNt73EmBv1Z1c7s26Z7TJhEll/SOHZEFOwVk/hrhADrnrXiMrlG1SOcLU5v
 C1ptW6JcdK83wsu+zFXwGZVzl1lB3ljS4UAG1tSpbZ8kk3FlHX/jqFo5nZOHjm9MBXrfl0wP0XR
 wFi
X-Received: by 2002:a05:600c:4e0c:b0:48a:54a6:b29f with SMTP id
 5b1f17b1804b1-48e51f2f793mr108256405e9.17.1778133452303; 
 Wed, 06 May 2026 22:57:32 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a8159sm105881505e9.6.2026.05.06.22.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 22:57:31 -0700 (PDT)
Message-ID: <9ae38eb0-3f2d-41d0-9086-0653d82c476e@linaro.org>
Date: Thu, 7 May 2026 07:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Maintain OpenSBI Firmware
Content-Language: en-US
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260506234243.1873782-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260506234243.1873782-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/5/26 01:42, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Mark the OpenSBI Firmware as maintained by me (Alistair Francis) and add
> Daniel Henrique Barboza as a reviewer.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


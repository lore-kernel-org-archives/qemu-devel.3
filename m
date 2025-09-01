Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04FFCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 21:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBcm-0000vG-Lx; Mon, 01 Sep 2025 16:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBcj-0000un-Lo
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:59:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBch-0004e6-0y
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:59:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ceb830dd58so2612654f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756760369; x=1757365169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58gfm8UT5tA7TOYg+p+NeZO1ZPrQ06FMwsOc+6aVS2g=;
 b=Lz7MKAptR3Nz9U5LRggON/CF/NH0X0nVFr3yujYXZUv2vcDhj8XmRhKM/O8PD63v3X
 +ZWsBc3KNDFTBK+yhR06JAyRIgO5WlYf1xq3MbVBs9AmLZxBUvK/Bd9KNRw0965EZEo9
 WqHU5Bsl6UZRXESmnbFFS0Yg2wSQTTgIaR+slD6t2EhgbffgjnQjZ6mECJD4KJi5OJc1
 4uAojNr2dS0+xb5v7rl+Xt+DpJEuMWXRAINEpORoP/RcI2DM3JKNVObnX7jiv+IPqJGh
 +Oxt4jGsoF59x45WmEZHELbttVBef6weObkclePWsimo+z8U7fC1QnrbXbTyQEL0jPDB
 V3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756760369; x=1757365169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58gfm8UT5tA7TOYg+p+NeZO1ZPrQ06FMwsOc+6aVS2g=;
 b=DF7EO9bHA/r1dOdKUy7Svpr69mM5Qf3JuBWWqiBqApeHrQIGkxsYazDzgq8HkiHI7J
 Z6ocMoGFbLCXSUUmmcc3jpL1D32nOZLqqpdwI/xodfaE4cvKDzV8piVH5KUA15nXdKCe
 Xc1COr/II3cIemruo+xzP9eMOXRQHpl3N8zXCHW0irDH/SPNqTpkq3AFdGZ0FoKuSGXS
 S0M2pcXBpJzTdcOK6cFbEzj/GieOAZNQo+hfvhbGqU8ZdXZjTWZer0gIEvbT/lrXiK9o
 0hOqgDtGFqvmx2QIr9Nzm0hbKr/RgeRPBS3xGFcADXJsqYqwoaJkS4So1RIOFDBOppFm
 FfPA==
X-Gm-Message-State: AOJu0YzGfspWYOg3HkpadViFtd9WX5SfVwG/X6I2mus3jn4oI7l67Swd
 cBeOBl8oNC0bu1mIhUzngSkf1Ap6O99zDbdSxzmTwEWZG+TZCRI+CKwF1rfjPA+bpHn6NAlrDGp
 LaoLS
X-Gm-Gg: ASbGncuZBrtsunHVW+KsJ9cBkteAwsJR5YcTgbr3YpmXrcSKkEDEHfNqCAUOgRu2Lix
 2/uBTsAOdnbzlU7qNVtW4WanAYL3CficXQjgdMS0n0qdNOsMydlt5J7bqnG4a1tXCxDv4/PWSDD
 yxV91Y4RbpAOfTbamvKxTnlOJNH9rY4z0nJJpj8LV0AT9i3BH1G7LN7CmjtwW7bt02+eRz7xOe9
 64809OMpHYLXRCmAclcl49VTGkbudLLuXqo4qolO/fspgS6K+766TL27ujjnJ8PAK87EyP6+1WV
 /muR9TeDRLDOYSFNcpsZqRqw872ufbNOgL1SomoiHk2srBmb434kjz23paTy820zCGavpDoYlQE
 73toqkeOkZqKrA5xpcGUpugGIlDeCIF7jtKAtNwKxmGSW5VgKBu+2LOIubmz2nCTdyQ==
X-Google-Smtp-Source: AGHT+IGBUcnzB8JPxnBa0YcwaZd8NqQLa7TcQdO3bI1MTQ+pWTnuNLdhK72CbXIzd+lE2cZZsX/faw==
X-Received: by 2002:a05:6000:659:10b0:3d2:633f:d02e with SMTP id
 ffacd0b85a97d-3d2634f1711mr5732319f8f.2.1756760369084; 
 Mon, 01 Sep 2025 13:59:29 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add504sm16476088f8f.30.2025.09.01.13.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:59:28 -0700 (PDT)
Message-ID: <e99d98ce-5e56-49f0-8b2f-6c85f805373a@linaro.org>
Date: Mon, 1 Sep 2025 22:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/mptsas: Avoid silent integer truncation in
 MPI_FUNC_IOC_INIT
To: qemu-devel@nongnu.org
Cc: Don Slutz <don.slutz@gmail.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250811095550.93655-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811095550.93655-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 11/8/25 11:55, Philippe Mathieu-Daudé wrote:
> For the MaxDevices 8-bit field of the request / response structures
> of the MPI_FUNCTION_IOC_INIT command, the 0x00 value means "max 256
> devices". This is not a problem because when max_devices=256, its
> value (0x100), being casted to a uint8_t, is truncated to 0x00.
> However Coverity complains for an "Overflowed constant". Fix by
> re-using the request fields in the response, since they are not
> modified and use the same types.
> 
> Fix: Coverity 1547736 (Overflowed constant)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/mptsas.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Patch queued, thanks.


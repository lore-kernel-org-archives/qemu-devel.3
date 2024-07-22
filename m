Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25D9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0OV-0006ap-Ki; Mon, 22 Jul 2024 17:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0OS-00065z-Vl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:16:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sW0OP-0006xu-Uw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:16:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so33942205e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682983; x=1722287783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDWMQvdXIiq8x1xZYflvJfvpfEHJMEtDM+ZW2/x7pkg=;
 b=GpYC/4BPcflDlGFc2yS8PL1CZZt4LnbS2sWOk1gqdIIPr5rCjzQnsVer0c3eRvhKF0
 vmUMqczeDiAW4x/CUwiV9Qc0u2PIjSUW3GgbHQ2MLt+VLepjA4a0ycd/DdUaNkURwqyX
 bHh0VzcNSf73IRp2G95BV5XnwUpQCXdedfWRJuw/bakAW4Zm6lY+uIbubrUBPnlt5iPl
 FglfpocIDsD07JvZM1T7UzE1hDdr4Ta8z0H13lOdje8uowlm2doUu0abSQmD8Ud4ySU7
 cIaqujyaGvWgop+A/7Zfn8vUn5t81nYMRBd4AMGhjP+iiMKOvvNbFyRKmDvCXgAYZf9q
 QdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682983; x=1722287783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NDWMQvdXIiq8x1xZYflvJfvpfEHJMEtDM+ZW2/x7pkg=;
 b=kQBWCbSAnX2S6FwpKdoMmUmKetWlQCBOac6fZjpeT6Z3XGqEX2gXBpoDfeRo94pral
 xjIjoKHjDzSUqnBCVHGA3WRLXvUFixCRRKmWDSgPPGrmQ2OQsG71bllcM355gVGfGerX
 E37rqctlMuEJ3itYWVPh2ONHbEvfz59ZNHJndTcVUQvAnVhwZqydzZUV2k9lDXspQ9Zo
 GoohKDBb6O4xhAwFntY/pDo0nmwz362maYHTis47zQcGDZZO6z1GgBwlz1114kOuWL6Z
 9Uvq6SIrq37I0kodvoV3RGpprYnI7y0asGT2IWuzrUxXWVo0/Eb5eLam4Hx/KWLEIUhU
 mE1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3i0C58mMtvNWS2QEnADy0w/h2/9Lj6rPmJDFGfXyHZmrzsTHr5a96fOfakLCDW4SWN4OYBomExyMq8RH7tMW+mGE7wtg=
X-Gm-Message-State: AOJu0Yw3S/FBrVC2GJ55hKp7Z/dNndJ3G/KmukpuXd8VtgQOCFIrj5mo
 +ypOin7TA2KBjaWYinKitwMX+5euZvSbxB9dRKluZLPPKwwk5WYbtMN1vbE7Z16Z4+Fa7wflxmQ
 9
X-Google-Smtp-Source: AGHT+IGJpNi8IuiOeZpYpNlNrdKrPX8xJA+DRjZ7OPUH9gxW1u9OsaLmHh8EPpWTVL8VjRvep9lmig==
X-Received: by 2002:a05:600c:1f8f:b0:426:5fcf:5e89 with SMTP id
 5b1f17b1804b1-427dc5797e0mr43082645e9.33.1721682982813; 
 Mon, 22 Jul 2024 14:16:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c0fasm172340405e9.7.2024.07.22.14.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:16:22 -0700 (PDT)
Message-ID: <e81bcfc9-bea8-4807-86d3-c18ecab3a318@linaro.org>
Date: Mon, 22 Jul 2024 23:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mips/loongson3_virt: remove useless type cast
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
 <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/7/24 11:17, Yao Xingtao wrote:
> The type of kernel_entry, kernel_low and kernel_high is uint64_t, cast
> the pointer of this type to uint64_t* is useless.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   hw/mips/loongson3_virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.



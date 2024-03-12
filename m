Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFADC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxMb-0003tN-6V; Tue, 12 Mar 2024 04:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxMY-0003kt-Lc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:19:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxMT-0000Cm-SN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:19:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-413385f1a0dso1579795e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231587; x=1710836387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=44i2lDGh0jAhCERlnHbPhNRhFIOzGufwrWXJwUrgyLM=;
 b=lU7lWdBK6hXA86PZdqvFThRnnI8XKm/cJphiDiwJaxLRdHlZXmQpyWzr6CLd0t3Yup
 iTuHBeMOyt+j6urIcqAcqk4yoch7XTiEx4pxU0iJ5w+WEU1mU6dMepHPGOUhtUNMMfJe
 WMgsN1hWskDgv3Z43k4zpBTn4/9nFplRfUiLHMNaKlVEC6ycoMoM1KhEMF8f+V7qF9k3
 uuejdqEuqfwcqD9/iggTihxl7Y1gEVvo92g7w1hSrsIHekMQLUAA3akdcKial5LuMWaX
 RJUTpD1YhF/uOHkMe+7vpviTHsNss2eC7aze7Tri4YAJ00tiGqLKqxqUsRloG3kNyA0M
 Z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231587; x=1710836387;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44i2lDGh0jAhCERlnHbPhNRhFIOzGufwrWXJwUrgyLM=;
 b=dbJshCUvkO/Yx00dgKAAGZfTj3PQMw6QflV9MrZYctW4TL0jEo672GK4qMg8cCbclx
 dEk0TPHAvg8GAI00+XqIb0o24zUiRu0QrWle0GFSnmPpGqw1Sh2mmDdP4fzkXNp3Dgs1
 pjX+r22NSut8BlvgUtfqOPDJTTPEsDjoFL8eng31Vnm1rrl+GzlhTgeNZ7YybHJYrorI
 4ySkjkvjdpqOQq44mLfhwI+AA37/uLxBF2HQ/g3SZnXLY+rLJyIi7tmYc2fiDSBlDaEe
 vWrig2FcJq3xRRtkdXX+JS/HG1A8EcRlsFWCIw0TWe+sqMJea1eiC1648g6bAowrkvjX
 Diaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVewPoIKNqYCYqZHRviynpvY1f+DZoHHpCKvPzQmwxYE510Fo24LGEZzV4geY2B6Ia+dhl/1yKOqQ+1uH6ojtcYYVyaXK4=
X-Gm-Message-State: AOJu0YxilAunmR7tghgNN4HOivG7CbJsYQCj5fWWWT2xYnWNqCvLspHL
 O0hy1VdTrOgTt5gP95gOPUa+B1nmLE7t5wS0sQwjHTphHW17MY0GmW3ZGJ/wEz8=
X-Google-Smtp-Source: AGHT+IGIARh81btxNkuDE0STzfty+4YJkuCMJTYRuDF1yBGlWXIMm1YpzifNTmMCfzqeLSIJ5xStuw==
X-Received: by 2002:a05:600c:4991:b0:413:194d:12c6 with SMTP id
 h17-20020a05600c499100b00413194d12c6mr6419929wmp.23.1710231587483; 
 Tue, 12 Mar 2024 01:19:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 d9-20020adf9c89000000b0033df46f70dbsm8536533wre.9.2024.03.12.01.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:19:47 -0700 (PDT)
Message-ID: <01ef7588-481f-4c5b-b398-c27ef71951d3@linaro.org>
Date: Tue, 12 Mar 2024 09:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about/deprecated.rst: Move SMP configurations item
 to system emulator section
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240312071512.3283513-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240312071512.3283513-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/3/24 08:15, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate unsupported
> 'parameter=1' SMP configurations"), the SMP related item is put under
> the section "User-mode emulator command line arguments" instead of
> "System emulator command line arguments".
> 
> -smp is a system emulator command, so move SMP configurations item to
> system emulator section.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> based on 7489f7f3f81d.
> 
> Note: the git diff understood my move of SMP item as the move of the
> whole "User-mode emulator command line arguments" section, which may
> cause confusion about the contents of this patch.

Oops my bad I guess :/

Thanks, patch queued!

> ---
>   docs/about/deprecated.rst | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)



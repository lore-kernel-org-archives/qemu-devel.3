Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD60CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNdL-0002qM-Tw; Mon, 11 May 2026 06:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNdA-0002mj-Mf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:12:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNd9-00033L-1Q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:12:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d73422431so3186863f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494373; x=1779099173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SRYUAXnziZp+vIy4v+3MC/24jUlT/vn84MF2Ul3935M=;
 b=s58yYSv/bHPyWV55bwIzfHbSLLIFKiCzy50cm/T9smgXNfRfPLZJ9pJ6uboBUPdfBo
 3LqfwXlFOUBiKKNxD3gKHDzUhkhFPINcw9K8PmHFFr9otpf72oPYroSegLFF9tKnkz9t
 7X66GXwfOjsFWO+wbeLKrhwWaLiMMg+c5b9otTwMujUHDSZrLmIXam2PrZGA12nbAaRB
 /KOKro2tiMJ/uRYeUtpbDqz/y1zDfyJKnaCmOioaSFYmbRwdzB2EUyxjxMNg+R46TdHF
 NUwfEAlyEj9DAtYO11AHVnSfj/6lu1+JHuJQJ40leVh0xvPN5BbW+FhAiwZ83462j+lH
 ZivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494373; x=1779099173;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SRYUAXnziZp+vIy4v+3MC/24jUlT/vn84MF2Ul3935M=;
 b=XFAdZRNnSABaCLnR0g4qUFJx6t5NP0XyX5t+1lx/VVlXfSj0F+rBOdls5dIxaRk41S
 Hx2ELDiIQ9hMJxjUdKyG6bjbqur0EkIQWAxezh/1bP0K+MqpzDwt0G0svzIm50r5sO4b
 zGf1+dWMPvs1egzRh/50TvLPmnGTl8iPmtwU377SpHjIBx+Sda2ZMW/O/0vx6TBfzavp
 6qsB5/ss0lAQ/kq3NWL19kvbpmVzN/F/Pqs+tR2xwvKSkNCNC4LWZ5VKgyW0KQYmyr9s
 jV5RIhh69Ji+R3UgLRJg6zEB+mGow4y3hdpYitYTfGRQXm7/D1mB4yEtxUOgDehp/HTd
 XHbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uif9l9SYju9t4TE/3oGthoafIYfZmLwmIgF4q+LKBRZdZ8mEk1/r8Q1eZxMIqovUh8KM7OP9EXjE6@nongnu.org
X-Gm-Message-State: AOJu0YyYfRDMw+5AX64qBdMLKxM+haAfkv4WEMQTACZuctPwkTSB5VP8
 JdycfHU2EqgX37v+87su39wUzKalnmVQWlraKmnv+Zgo/colBoR//a1hs5hmavf9vek=
X-Gm-Gg: Acq92OGIIiNyowbpGfLrULSgekPFHAJmbyGccweKJoo79PUIKm8UszF8lFgUiILdnhB
 yChQVMsZCDVt3OQYO2XEWgCJ5GCjb+ff+LF0FMLBNaQ7ThTt8GhpmIeqYrkLoprrZUGUCLycyu3
 6bKiw/rB8YdyIMgmatHE5EySZLBB4l8ui72/o/KTcMMCgA2lTyBj93NfR0aNKbTUlks/YMRrRvM
 D/PmO0apgox61HYG00HfE/KYJE4ob1eKF0Ouo+suAr6VfHVRMWVUlwswKVvqSqmrg9+YavjuYxC
 CC+QuOMxuej6i/L3s1bUX2+ZIFkLdgKvYkw1HoSdBTXEfX+e7l2kiAeVh6YqaC6jzLKocFa0AnI
 Z1e38maVK0O00AuXNVWBo91ccza1W1TtusHwnIkSNZ7mzwnrFdXrrxRhL64Qd9gBPl7PV4MxIgY
 C6tAdNsWicTCosBXYTfI8U56QzeQ326hA5L1hHvoNlRAe05q7DzRNLPDqV97B+wAm1cw==
X-Received: by 2002:a5d:5d03:0:b0:441:1c95:17e7 with SMTP id
 ffacd0b85a97d-4515b5243efmr35615173f8f.15.1778494372786; 
 Mon, 11 May 2026 03:12:52 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6cd75sm23445305f8f.16.2026.05.11.03.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:12:52 -0700 (PDT)
Message-ID: <8a319b22-3b72-4996-99c8-09ff95ea7808@linaro.org>
Date: Mon, 11 May 2026 12:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: strip leading './' when searching MAINTAINERS
 file
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20260511093858.82753-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511093858.82753-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/5/26 11:38, Daniel P. Berrangé wrote:
> The following two uses of get_maintainer.pl should return the
> same results, but do not:
> 
>    $ ./scripts/get_maintainer.pl -f ./hw/net/vmxnet3.c
>    get_maintainer.pl: No maintainers found, printing recent contributors.
>    get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
> 
>    "Philippe Mathieu-Daudé" <philmd@linaro.org> (commit_signer:4/7=57%)
>    "Michael S. Tsirkin" <mst@redhat.com> (commit_signer:4/7=57%)
>    Xiaoyao Li <xiaoyao.li@intel.com> (commit_signer:3/7=43%)
>    Thomas Huth <thuth@redhat.com> (commit_signer:3/7=43%)
>    Zhao Liu <zhao1.liu@intel.com> (commit_signer:3/7=43%)
>    qemu-devel@nongnu.org (open list:All patches CC here)
> 
>    $ ./scripts/get_maintainer.pl -f hw/net/vmxnet3.c
>    Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:VMware)
>    Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)
>    qemu-devel@nongnu.org (open list:All patches CC here)
> 
> In the former case, the leading "./" needs to be removed before
> trying to find a filename match.
> 
> Blindly stripping the "./" is valid because the script already
> enforces that it is run from the QEMU git root directory, so
> canonicalizing the filename vs $CWD is not required.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/get_maintainer.pl | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


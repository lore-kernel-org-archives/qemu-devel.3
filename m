Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1AECD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrP0-00067B-47; Mon, 08 Apr 2024 11:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrOx-000672-L1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:59:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrOv-0002mD-Sm
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:59:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41693741eceso3046625e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712591956; x=1713196756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34PXZ5Z5iG5RaPmwfkJ5lw3OU5H6/VEZV/axUkQLNb8=;
 b=aTCGEyUCVGLRvD5XEexPn17OKpQqsM80AEqT+07r4vHDfO2SauQkekWTWk6qQmaQrB
 FqFz+foulmpWW/qGkzQQ67rcLJE2jqP3eknnZkd7CZyR+F4dscXILshIPZVOUnRzwYzm
 vXF+f0ejZqX9WKnHzG2vlIlheCn0VOZ7bhHvx0Hy2+/vNiWzh63/VVxhErgjpIHmwqu1
 fkKlUTFUwLmVo3P+B5nWmUDPmGmT90fkx88l/tuVVL7zkSKGFJS/mqOjbnadxOpYJk5G
 m4AHG+HsKa+cmKj85CBgeKM8VqUb8C/+yD/1aF0h20rIuFuXrN61MhcIjsdQfgUI64QO
 jhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591956; x=1713196756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=34PXZ5Z5iG5RaPmwfkJ5lw3OU5H6/VEZV/axUkQLNb8=;
 b=clFeh5d9O6jUFPAFP/ueGzGsxmwstq/4xF0n8ARUWIicvkYZgqCtpan4pOV8GY6Cmo
 9AHtuFuwF6nVJTKchYK2wH2maHN96gr8quSJMX2MBQQL0HUpWk24tBlSCZSdO2QiKGuU
 ZHbCB8FCVUelZUTHlYCBqPzddbOGcrfpU55GVuVqZGi6hhMm18O/M/L/xvlhvVuZ821/
 Ez6+ufwXB+0TKkkxGWGUN3uj+7y+O0Yq/C/TyKFrSp6lJXZH2hWBtgMQgBxhOE6wnlXb
 JhvSKnMCna8DdeEDxjDwVBbwEf+YlyFD91dYEOFYBFQZWoquMpKJFZs3ImX6GRn4r9j7
 DUMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWKle15/8kBujpx24A7EZwUwPso+DOOVAG7Qnv8hL7xZz9z0TgVAVMJfj1i70WrILpH7gqd/+31ZSSHa9DRocrvMlp1aQ=
X-Gm-Message-State: AOJu0YxqiaCwGj1T0jWijZZ1ALxfDiV+WE+yrBitGhUF0nxDgmk6zp0F
 sDVkuLkcd9JR9oIsyCZtwWXkGHaUF8oBtVlYr2QLEtPQg/6DkrPTFuG5A88rTp8V+kK2qsmL5oF
 9
X-Google-Smtp-Source: AGHT+IFIONfmsnHjN47eTgEqgbiw8VZZ9KGQuGwdheuCLPyPp+PkvbcRroY4LRUFdeIwSmrG6n+QGg==
X-Received: by 2002:a05:600c:4f44:b0:416:7500:31ae with SMTP id
 m4-20020a05600c4f4400b00416750031aemr1992467wmq.15.1712591956023; 
 Mon, 08 Apr 2024 08:59:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c358f00b004156b689edfsm13934054wmq.33.2024.04.08.08.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 08:59:15 -0700 (PDT)
Message-ID: <71d52b50-c728-4488-b5f4-21822a5e82da@linaro.org>
Date: Mon, 8 Apr 2024 17:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] hw/usb: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408155330.522792-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/4/24 17:53, Paolo Bonzini wrote:
> Since the USB stubs are needed exactly when the Kconfig symbols are not
> enabled, they can be placed in hw/usb/ and conditionalized on CONFIG_USB.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   stubs/usb-dev-stub.c => hw/usb/bus-stub.c | 0
>   hw/usb/meson.build                        | 2 +-
>   stubs/meson.build                         | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (100%)

> diff --git a/hw/usb/meson.build b/hw/usb/meson.build
> index aac3bb35f27..23f7f7acb50 100644
> --- a/hw/usb/meson.build
> +++ b/hw/usb/meson.build
> @@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
>     'desc-msos.c',
>     'libhw.c',
>     'pcap.c',
> -))
> +), if_false: files('bus-stub.c'))

I like it because the stub is restricted to the
subsystem. Possibly easing maintenance.

> diff --git a/stubs/meson.build b/stubs/meson.build

> -  stub_ss.add(files('usb-dev-stub.c'))

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



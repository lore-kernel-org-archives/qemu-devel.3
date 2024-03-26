Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE98CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6AY-0007RC-Vq; Tue, 26 Mar 2024 08:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6AW-0007Lt-IA
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:44:44 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6AU-0002Za-Bv
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:44:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4734ae95b3so523572866b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711457080; x=1712061880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6y3dXxT2LvK5BmUuAXOk1aeNE8lK2zNenWRM67Foq2Q=;
 b=TBkBN5FS490gScZYytBwmVIuVzCvh8+JZoFfBOBwuJUhKWTbO18ULf9jUk93eJ4+HX
 TxCNswjoIu4ZeQSlyDBJdZSYOB/o4nlfKf/r1OGA3mvE4k0C4iB1t5jRAIjy1y7xI6Ps
 oeVJ46E5pAiAkzlcWR/9N+/Z/ybRVUIKtzz1guhnT0CuwLvBw5nHyjNG9+WQ58jI1ipY
 hj29YqNeqkhVb1ufSnSMZsN951maI7e+07eIkCswZSvd4UPrDk5AKzyjCyA1dEfr2mjb
 JsHiZYlN4QqxGz3FvZrjOIa5Zod+RRO2yvWbCTr9VoAc8uiuptedOBVSs1LyKiInnVy0
 shtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711457080; x=1712061880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6y3dXxT2LvK5BmUuAXOk1aeNE8lK2zNenWRM67Foq2Q=;
 b=X1mIznAoJdTjT+8eVQ9IwwYRo3pyFKtyIw0swqFmOOIwkpBgZYnshDH4WNFA2rYbaE
 rqYrjjP8BvVMq0iuhfch+2yfIbnn3MjIC+qo04g3F3Sx/iSADju8vTZlpSU06U0ZhnTX
 7YOJ8fWAfnablKbdTU7dLnJk3zPy3uRtdddjB2C1S/la6BIxPu7PM3YHV2ndxu5H2QrP
 Ze1wf6gg1ox7QL9aZLiiYKob3A4c6aizWZU+ysXP/MuYQDN94qBNuzjE/LZYoWg8kZmV
 u0FsQMFv6Aj1XAi/2YVSkt8DELAQUPM+lbbVeBUPN9jTghOq9a32VHshPiTLkc27icPg
 ms5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKc2LsHnjRUU6QXFY5vCFizltk2WPgpWk3EryaOU+WpyuFKH2JogBFaVm1BCQWfToW6tVNSQe87XPDt0KKgaxtv/pi+IU=
X-Gm-Message-State: AOJu0YzJn7+JkRxoWVbrqdkcCxPNORcjVLhHExpkR7FvowxFXAAnG4hR
 ds27kgovQRm9l7fJddSQ8s03KOqtPW8QcegTQlZvYoOWjf+EzevYH/4101I86m00+eAmO7fcuYq
 q
X-Google-Smtp-Source: AGHT+IG77PdbeLzSjGKBMUSFLwnEroujx9drC/ePc4XqNVTH9VM8GXrjznhsQxrFTr0GJdH54Ekfdw==
X-Received: by 2002:a17:906:ad1:b0:a4d:fa3f:43f7 with SMTP id
 z17-20020a1709060ad100b00a4dfa3f43f7mr381474ejf.55.1711457080361; 
 Tue, 26 Mar 2024 05:44:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a1709060a4f00b00a455519bcb3sm4211247ejf.55.2024.03.26.05.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:44:39 -0700 (PDT)
Message-ID: <2b158752-9a6d-4013-a9d1-bb380b31cbda@linaro.org>
Date: Tue, 26 Mar 2024 13:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial for-9.0] smbios: add stub for
 smbios_get_table_legacy()
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: anisinha@redhat.com, mst@redhat.com, laurent@vivier.eu,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20240326122630.85989-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326122630.85989-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/3/24 13:26, Igor Mammedov wrote:
> QEMU build fails with
>    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
> when it's built with only 'microvm' enabled i.e. with config patch
>     +++ b/configs/devices/i386-softmmu/default.mak
>     @@ -26,7 +26,7 @@
> 
>     # Boards:
>     #
>     -CONFIG_ISAPC=y
>     -CONFIG_I440FX=y
>     -CONFIG_Q35=y
>     +CONFIG_ISAPC=n
>     +CONFIG_I440FX=n
>     +CONFIG_Q35=n
> 
> it happens because I've fogotten/lost smbios_get_table_legacy() stub.
> 
> Fix it by adding missing stub as Philippe suggested.
> 
> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Singned-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Compile tested only.
> 
> While it's fixing bug for off-tree usecase with non-upstream config,
> it's trivial enough to go into 9.0 if time frame allows.
> Benefit of it going into 9.0 is that folks who play with minimal builds
> won't have to carry the patch in their tree.
> 
> 
>   hw/smbios/smbios_legacy_stub.c | 5 +++++
>   1 file changed, 5 insertions(+)

Thanks, patch queued.


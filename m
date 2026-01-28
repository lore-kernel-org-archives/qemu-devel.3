Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B15D3F098
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 16:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8nc-00019o-5s; Wed, 28 Jan 2026 11:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8nR-00017F-Ky
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:53:37 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl8nP-00009t-T4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 11:53:37 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so65091f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 08:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769619214; x=1770224014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5bliGkFEbdQWwTAXpaZ1oV3QTb74LZ6bYq4dIU1E4Y=;
 b=m06R2SdWbrT2Prf7IXfNs20qgW9250sskUUJoE1z5jgszhP877v7RktbJAxKqAXuho
 FUQukTnVulRBka+GV0BeZiD9sU4dmHAW3RKmNkNVMmhV1H7qDuUl5UYJhj8T+O3y3Zr3
 640M+e4cdB+z6/sO9ae+XIgt1xBmrV9VnLW1oNzMaBCosJVb6hjyzJ4vZzYzgdNc3yY8
 y3u9/dXH+N2i+M3AzUheatOQkXtUeosAMR6RoLbxdU+Hqf630pnmGY9+jTfReNOczbys
 m12IkAYodnDfvy6kr7+2qM9+bd4wUYbXFxFdZnY1bQML1FroiZIz0ntjDBJZT8Kl7lqc
 RODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619214; x=1770224014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5bliGkFEbdQWwTAXpaZ1oV3QTb74LZ6bYq4dIU1E4Y=;
 b=Hs74UdhLWO5etiRLXDksPRvGh1ghlrFy9mz0o2PQXx1hKclJRyLFqBrevjoMgw9vxk
 nB+KW1xd3GVReOTenk3oEYzhkW+4vH4Zax9B8YUjaFW2yHVkGGkqHCUsh6Y44xiept0Z
 wfn/JZ76jwgKrre8VGLkUXtpEY2zUANIiofg853TJD2eNj+aGM1dgAGYCpJJ0ip+8eUc
 fHjambEXl53sw9xOsJksu1OzPhkH6jDVDd6aX0ACKPomPwlVSRa5ikqOjOV3PtgqMZ5Q
 e/0752fsiNgzCO3/d1DpDVb6hhgmx28RLOKqd90h+Lwd1R8xq/mxtEjlRSoPePGvwnFw
 Y0hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVmb5eiiZhrVPnm9GJWJnG4iGCdji2MiKbf+w3jzrGkK7OysUgUUTjqCHNSTfbkZr3NEH/pNKJXI+@nongnu.org
X-Gm-Message-State: AOJu0YxPTMPnHwirJcB/U7e29V9XTwXtVjKt8SqMjDDRdntduuZqzsAT
 R33Y6axNwWQEQovxoD8qi2sibtarGr/+XUyn7iaQkqUpM7MMYM0SC4R9GMPXU+XoT+E=
X-Gm-Gg: AZuq6aLIYSIh7Ebk60zAubyiN8F2bdlLq64WgV6T1EsEmS4vCRKlkKabeJxU10Mn1gn
 /GTabEISc7i4915xe7/wkLMYPenMvwFTkHvFP00l5rjWMIRfCmOvQcojxVh31SABXFcZK9mUDV7
 mMYdN8rjgmmD3ogZUUkpemyVZIiahM98mzG+89FfbD7M2ITzxJ5qxZ/ePsbWJaWCPELFnBK5Fvb
 /eRYYPQRIdIuaTKA/wb1tlPqrZu+8YcxV8hOdFb0ol7Gj78VZ7RpDwRFArdU8QrEePeuDgLYkjf
 qCe0/PPHse48RsAbbVYB7RQ43OMOLDel/NUNwNE7w+bRBPqdYw1Ysk/zsCnFrrsxrY/piYeQsgC
 hJFn8x4HkvvU0xiOnn0cnY52Ntsod7YBpy32z/TAetsUt5467okmsVxd7Xojs0mLY1gsiXpwuiT
 wXI1sFUlVQYjUAjk1mfDbUFUWoe6r+oXqUir8RmyR+gQEhF/bVD0hZow==
X-Received: by 2002:a05:6000:40da:b0:430:f7ae:af3e with SMTP id
 ffacd0b85a97d-435dd1c1339mr8006306f8f.32.1769619214284; 
 Wed, 28 Jan 2026 08:53:34 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e490esm8178792f8f.9.2026.01.28.08.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 08:53:33 -0800 (PST)
Message-ID: <437948e0-2ad1-4c52-83d5-94fa3dc71137@linaro.org>
Date: Wed, 28 Jan 2026 17:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260128105839.3487840-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/1/26 11:58, Alex Bennée wrote:
> As the builds in codelinaro.org are going away migrate the binaries to
> share.linaro.org. As the hotlinks don't encode the filename we need to
> explicitly tell uncompress how to handle the files.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/aarch64/test_sbsaref.py | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


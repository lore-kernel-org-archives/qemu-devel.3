Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD429D46C06
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 21:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlDLd-0000Nb-7b; Wed, 28 Jan 2026 16:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlDLX-0000Kt-Lu
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:45:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlDLT-0004RR-FD
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:45:04 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so2193005ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769636702; x=1770241502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnzN44OcwFG7PKD1vuBpA/mTqAwUIm20jUJ9NjRE+9A=;
 b=sCHGgrgXSuHdjOcHg2uNbkWmUxDsIuQR4Xbzeavd4lVDzq5+SZLDqWzhf5dzxj9XKI
 ep1WD9LZkcBQ4Wehm9GYWh2HB+udc/Qygh4BQfN42jCVnV8BZpCMfGypfa9gi4PABh4L
 Zz2zqbgm6WrlxFH8tAxaeMGuOMWrSa6EfQwl1JBbh3Dq1sokzn1ycq8BigwJAjWC+XMv
 BLELo3thtSIXGBI+5/sHvmG4ylqbanguuRYYRq/+94YfqAvc62Z7t/u2+CA7NPYARjsm
 Nir+iKo0L605HgpCC5/f6k/y0HPiIvDW6KVGYxkUKWOSKKGmfhG6v8mBIugu/aKDbI26
 jmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769636702; x=1770241502;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnzN44OcwFG7PKD1vuBpA/mTqAwUIm20jUJ9NjRE+9A=;
 b=UCms/EUkGvTr5FuZYXH4xy7lHQhCyNFPD6nMi5Nu+65JvZfNxCpFg6BcNrFd3Rj3AL
 ByvaxMRMPqa9SjHJ1r0as5gEVhPYlk9nBiNkVJweffEpvZL0crk+qGznDjEjm0kZc8/j
 POdN8PuEVLtoFeWhZUZX7EGyOHZTiiFQJa6/6ozaolYx83ITgbIvamZ9W7OFp6Yhr0h4
 9dTIIT5LP4561P6tNZaifE0pVf2fRwkbP5SQwoQpWhTOCtr1ktse9cU/0uOPe/qCkDl9
 zzYUsttOW+51CQ8i28SMDqHlmcMfYVJ1o66aW1k3bhy4rrqQ6ysPb6oMwr2Zqu+AvUt7
 UKdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbFNQH2R1mnOebcZzmx+IqY04YHBe27npbsKvbNxWi0QsBbG8TrmmufWVTBEFWrAbQ2cZ1NmqaaEJZ@nongnu.org
X-Gm-Message-State: AOJu0YwrFKBC9agxf2uTOs2k2Xb8IrbdISbdsrjFdO1dpKF/YruyoSLE
 9QHat0rknZDBNORS9o+P5d3A+bOuVbioboaE5cJOS+vc3loZoVKByfmMFBMg7KhAKSg=
X-Gm-Gg: AZuq6aLa9Rjw0kv4N/acRmdEqmi/RMITlfEW/FXdTcDKIQtskd8hM5KeEoHWE0JSSAg
 1cckXDkS3I47Ow4LY2m/39Nx9kNd2lhV7oGzrQ2mg3/e0m4/cqa3nXRNNr1vBGMA0dK0LizFbtG
 P92Rk2bOSKoqG/YNUBQzwoH1QsCv7RNjIp3ELpmRPu8E17pP3sWK2s2w59Tg5q/TmdNFoMFDAIS
 0d1EORYfALE6V1KN87MDYE+IzxXC1XrIUiK2UtalC8g/SsPtJ1Gjb+orOxCQPXaaeLXpLeoOkfc
 +W+x0dsie1EeasGI5p4quuZJl7gW4RSkWHN8uZ6Ewuq05aVvKpXtJSrmVkbxKQ7EWZzUusVljNq
 GFsZ5r6YGny/5vU5OZ2AWE6AW/yiu3JcBi0zHLPcVhkcMfKABsL+ypR2HQV3Lofu0oVXpY1K1MU
 f1/pRNT1YuOAeuj6dKM3dRapR39eeAH3snjbI7it+z2FnjSytl1h/boI7t
X-Received: by 2002:a17:903:40ca:b0:2a1:5d2:2e45 with SMTP id
 d9443c01a7336-2a870e7dbf0mr61094925ad.59.1769636701788; 
 Wed, 28 Jan 2026 13:45:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c3ddfsm31777955ad.66.2026.01.28.13.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 13:45:01 -0800 (PST)
Message-ID: <bfa4720c-2c39-47c9-bb71-46a86e4cee7c@linaro.org>
Date: Wed, 28 Jan 2026 13:45:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/physmem: Remove the assertion of
 page-aligned section number
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-4-jim.shu@sifive.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260128152348.2095427-4-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x642.google.com
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

On 1/28/26 7:23 AM, Jim Shu wrote:
> The physical section number is no longer ORed into the IOTLB entries
> together with a page-aligned pointer, so it no longer needs to be
> page-aligned.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   system/physmem.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

We don't need to OR it anymore since we directly have a pointer on 
memory section now.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


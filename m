Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D19109191B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KW6-0008FJ-8z; Thu, 19 Mar 2026 17:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KW4-0008Ew-HU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:02:52 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KW2-0007W7-Sc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:02:52 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c73a12af63cso874496a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773954169; x=1774558969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRcovxxiRcCs+idcY17Kdjw9jLOnYNhglB1aBB4yp7Q=;
 b=stKH6IdmMyJLrSQB6AKLJnKuIO+R9EreiJQ52YSEEFcBKqyiL6aU1reatEFWG0o4yW
 CO6NBhdO5G8Fqrb8tCe1f5reG2ZezV3pBsjAf9uA01enPcoEoO86ZkMCIyHz6z4/C87F
 grC4RqfyEUJm4XLpTCAFpMOK2QyKKEn4Y2uCGJje98CLuE6UaA9FaL1J3H6xmotC2Pmo
 w06Y3QpaSlzIILoVSYOPOAVYwiBzRII/FJ69aFytITfYvCd//iI1mfaax97r1uSi45d4
 +8/GIYRHi1IDKbCNlgQqmFgO61OTrraJgCfnOnEb7zroaepidMhhi/Hhg9bHDpFMe8YG
 29Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773954169; x=1774558969;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nRcovxxiRcCs+idcY17Kdjw9jLOnYNhglB1aBB4yp7Q=;
 b=J/tYMoHePM1yvTLG2+kSOEVNUGkwEIHoXm9XAXTbJmWFVNPE2zgc3ErXw9l2mfHHyf
 Xr9OV8P3A4ttkDvyYU1iMn7GOZkryeYahLNyH8q5uZyihtkKl0dd8iDXBkyOtQPBN/LJ
 aOAtOXtspoEnhCGFlfglXlCH1wM9XlHi9nssYpNz5gxyMhabmnKb6PdaRwEpPNUKNO3h
 9ZOcr9f+jT+2XbAYw+dvqOPEXIvCmorY7t4UK+nKDIaOqY9FKhbg06/d59EBBy8AvYn+
 5z3DZVo0c22cbOsZhHM1C+plSfAmBzlxZxD/64tfWNZdCr4etX0ixI2Dlqijmeb6VmE7
 3VTQ==
X-Gm-Message-State: AOJu0Yz3NA2Jt+P8yK2lRIONvQG12NcXhHCf+DnO7D0KMPacmih/0w33
 HrV+6vIWqNR3x5Tc3AWfFh5nd82kzdpKR02p7SbxwW1YWxVCY+0ueo1BVsi5fEFH+fNLSvp2Txq
 r25qglNY=
X-Gm-Gg: ATEYQzw2VXlnZCZ3Xr/3nhHMoujrBCcDEpw5/11vCsB1GmLcianVNfayTbhcgIjemKM
 +6QbEFHliyVXKiIc6LDQPum2GJulZQ2WwgoEpyt9EQtnX8aCi9dL/Q1a/LlJnvZqt/lIUpBAcI6
 y1LNs7rFNb65h21OzH09VijlAlfBW+q5GnbtLF1r2cmxpmUOH+O/nexmv3AfHPzbu2wWAtptzIM
 pQPi01dVF0lrKNpm2s+RzM+N4/bIAZOuw1cs8R/3EmR8x/mUSR0mGWf5ad8vYDdXifmsSBAsyP2
 /z5TjvBZw7Qz+a9qbeRdS9Bw+HPrYK7IWTToyNwxsEwK+/5kz4YZShO3FM1WL79/H1vt37cXEI+
 dKRHPmtuy9v6FO+AoBPDCfkS8JVWxZHGXuPpIWDjRSUuZ3k3+mjCM15D786QiPjps46xT8vxAGh
 VIsC6B0uNVeW3vPKfSb2rJKZicKQuY2/inA5lA/Fe29M50gwd8AuAEI7j1tUonMyXqL02c
X-Received: by 2002:a05:6a20:7f9a:b0:398:b16f:7054 with SMTP id
 adf61e73a8af0-39bceb6b4a6mr658278637.32.1773954168803; 
 Thu, 19 Mar 2026 14:02:48 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c74443ccb56sm238207a12.25.2026.03.19.14.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 14:02:48 -0700 (PDT)
Message-ID: <e5e277fe-42a4-4496-a93e-3d9e1328b394@linaro.org>
Date: Thu, 19 Mar 2026 14:02:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommufd: give hints to user about kernel support
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, philmd@linaro.org
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 3/18/26 11:06 AM, Pierrick Bouvier wrote:
> Using iommufd requires two different kernel config:
> CONFIG_IOMMUFD and CONFIG_VFIO_DEVICE_CDEV
> https://docs.kernel.org/driver-api/vfio.html#vfio-device-cdev
> 
> It can be complex to identify what is missing when trying to use it. This series
> gives hints to user about it.
> 
> Suggested on:
> https://lore.kernel.org/qemu-devel/0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org/
> 
> Tested using a cross compiled QEMU and a custom kernel + debian rootfs [1].
> 
> [1] https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough
> 
> v2
> --
> 
> - Move /dev/iommu to iommufd_backend_complete, so we can report the error
>    instead of aborting.
> 
> Pierrick Bouvier (2):
>    backends/iommufd.c: report error when /dev/iommu is not available
>    hw/vfio/iommufd.c: report hint to user when vfio-dev/vfio*/dev is
>      missing
> 
>   backends/iommufd.c | 6 ++++++
>   hw/vfio/iommufd.c  | 5 ++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 

sent v3:
https://lore.kernel.org/qemu-devel/20260319205942.367705-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick


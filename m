Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF0DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtqq-0000vg-5g; Wed, 20 Mar 2024 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtqp-0000vY-9W
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:11:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtqn-0007E0-Kn
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:11:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-414617882b3so16861985e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710933074; x=1711537874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Twww0SvUzgi118cl+BDxhWUwb4DMWthO0fWIxLB8J3c=;
 b=DBDhz7SRYRISosVnp1VDpqOz2NJMqGhyHBXKwO/2beDqV9e9dtGUXtVF0Oee5pzvYS
 6RMc0EM0C34JS3C9gogieLT942OqZAhXpDJEPixQOCeKejX0v+Par6VYQFj8FCiKL4y0
 Xp8a5RheMbLjWXI8hoo9kOuAq4beTL5bn8/ViERSQjN9xZvQIWV5UFVs8d2VWSezZMW6
 jjMZBK1/+/Sr/m1c/bSjwuA4+sqKjovAqhC5v8g+ok93RQrkf5RgSH3c4qcMh2rjg7Fw
 B1d8qhit/dGxHYA1FpuB3sNfMC0AT6u2qW1eaYVLkwDrebp7htldC/t1saZCWgsJUudq
 I7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710933074; x=1711537874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Twww0SvUzgi118cl+BDxhWUwb4DMWthO0fWIxLB8J3c=;
 b=NZzAwh4ZLU5wp1/R4h0LPEXO3QG88RLacAg4DY7uI8CKPd7OAsf0puFzRm+zYvuDN6
 Cs3lpzoeU4OF/Ug14rzOuxvFeSiP/p+7SBXJqSthCG8bvxeB2Hym7lDfpXo6mxITXxCY
 H7eWYXh1q65iN234m3qFSz8iNQQ4HRjgkyTcSez9kl2zZCDTJ1puFPPDiGvu8L7hiazg
 htsofsV6dm0RECZsAPFvfozCq6aef8S8d3Kf6Z+RvAT+aJweSlwSGXFfMtnsdFo2CZYo
 GRL5YfhtiY9UzNG1Xr9ClAb9POew1qBqoyIvLEdo2bhoDnK1NJLpuNDnDQL6UHg/vA8k
 jQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKynWS6oASom4usVlov9xdtuLE8b/h7cmI0GdUn/6dLpx6DNOtf8QFrZGP+tKPJ6uLLzcHGUPBGmnGbh1B+SdpA2U9ITs=
X-Gm-Message-State: AOJu0YwRuo3OvsFHeAfSo9wrf4JmUmXWUn64Ur9NF9fq+iUPg9uuTYxU
 sLkV/wfYcRh7EUGG25t40sjDGtyXijK2vujSVHbCg67AUCQKOZ+wL0Jx6zlb8yvsLvY2mIppPxP
 J
X-Google-Smtp-Source: AGHT+IGtLNIXuKX3Yk2WsqiIEr/TJFXicZQ4ZuNqcVSV2qdeBhiXNivAo9pWtoe99CFe+bIksFcE8g==
X-Received: by 2002:a05:600c:5493:b0:414:6c72:8df with SMTP id
 iv19-20020a05600c549300b004146c7208dfmr1010391wmb.38.1710933074424; 
 Wed, 20 Mar 2024 04:11:14 -0700 (PDT)
Received: from [192.168.64.175] ([92.88.170.201])
 by smtp.gmail.com with ESMTPSA id
 ay16-20020a05600c1e1000b004133825e6cfsm1923445wmb.24.2024.03.20.04.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 04:11:13 -0700 (PDT)
Message-ID: <821cb0d1-a9fa-4d49-8751-311ca77e7671@linaro.org>
Date: Wed, 20 Mar 2024 12:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] .travis.yml: Remove the unused xfslib-dev package
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20240320104144.823425-1-thuth@redhat.com>
 <20240320104144.823425-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320104144.823425-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 20/3/24 11:41, Thomas Huth wrote:
> Drop the "xfslibs-dev" package which should not be necessary anymore
> since commit a5730b8bd3 ("block/file-posix: Simplify the XFS_IOC_DIOINFO
> handling").
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index a8d1e12190..8a3ae76a7c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -220,7 +220,6 @@ jobs:
>             - libsnappy-dev
>             - libzstd-dev
>             - nettle-dev
> -          - xfslibs-dev
>             - ninja-build
>             # Tests dependencies
>             - genisoimage

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

The rest will be cleaned once this MR gets merged and
we re-run lcitool:
https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/469


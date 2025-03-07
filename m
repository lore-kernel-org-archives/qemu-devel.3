Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9521FC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeqa-0001sR-7o; Fri, 07 Mar 2025 16:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqeqT-0001rM-Rj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:03:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqeqS-0005VZ-5L
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:03:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948021a45so19474495e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381378; x=1741986178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1pIO3W6UHho5/y6qR/VqXNkL6ggB/e6+WfIGEybHyU=;
 b=mmz4N48xd9EZ8TqKedBFiZa6BPEtnBc8RP+yt6sbAFRNPkS06u/JE7W+aqdCVDieXd
 PvrUa6A71nnUHFjeReoKjepaSkpnyV9YZh6sv1f1LUflM4yP0JcKYHCAT7CjbPpfnZpK
 5RkP1gnDwOxhhxkzdyhCetzou7PghEauaAjsuK7ZcRdAgJxupuoCTfl5v/sxh5ksqkVF
 rY6JKEZKTR7x8vN9/fUGDnYOE3fw9AWisfSpgzXKIlpQEAkIYUtp/F6SZmPlYC4nO3YV
 9KTzv5/OYUKRhnvk4Ns1gCPyVv/TyoegcYYPceOwvBUEAWGKOlwlyYG5zLH1tvMgoblw
 cx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381378; x=1741986178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W1pIO3W6UHho5/y6qR/VqXNkL6ggB/e6+WfIGEybHyU=;
 b=qDeKnmYvGsjsUwXN5mPqnZwMrka0SZJg5u2d+B0i2MQ1ivqaf+i812eRKgVyvWjGfo
 SvRGsjPDAbUmUPC6+oZOpz9gXvJP3dAxBWREr5CCTwumeHtac4K374nTVQQYu1UIrGMq
 1mYTD1P7SBwwSBgSw+gcadM1I4G6Wx3XkfgbZyWCHYZ73d58A+sMiT/VFJRt5LPoDfdS
 9VFBSYN9sqdfnoZ/jXgKPXTgj8qo6iufs+ug2lWE4ArMmKrpcJKfqst3DjqiYJq91TBO
 CxM8vSoitCcpFefCwTEY6brMh2aLM4cPg8Rh/8k8lxNMmGyMxPAJetMdM2r4qivjJjiC
 HIzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwVHXdGwQd+G4nSP69ikvWcSN2S4/OGfcSKcp3w4DJ2qYKx3IfNwaYADaZiID8SuRYL4j8SDCGP6QH@nongnu.org
X-Gm-Message-State: AOJu0YzQuBPsAK+Ln2Xkl168zF0X3xjOU5CtnFTQSIf2XkSSpKecOhAf
 RmbEBDJvxlxOb5YzSDgz/zwQOVXzlwt/M/bpe7aViv2BU5aD3c/+sdBhmXrZ69c=
X-Gm-Gg: ASbGncs1X+rTPn5G5b9MUrJH8/cawKiJoOZR0zzsYJeabN5S+8mRHPGxit01ziqiYGx
 u9BHoFSRchralV/rZftZUXXTv0EXlFyyK3BHSwN0N680HqXPnMpzUvNHt+75fac97IGcUl5s1UQ
 8y5hdBgMT4Iy8dUGukb/zybdLwO52OM4KfO5lHFeeawDrsFwBHNOfA25kHRNtEidAecmw93C2Oc
 NQtob2wc65rO06MKp0MM8po35XkgaGdLaIhkMcJmjpR6DhydYVRglm/gxu4TWpKf8HET7vaDgq2
 L4rosuurUgfuvCxAL3a1X8ol/yuv+2403fyMR1l2QCf65uI/WmHpRvVfp0zAeXZIEMf2I9/3FlW
 N0466eUbZgTPg
X-Google-Smtp-Source: AGHT+IFnECB2WJgp4h3URm4FZPTxJWKmnEDM3Aq2p4c4hzaxYSIhwVdcFCF4TerCDIJ8dTIfi5XEXA==
X-Received: by 2002:a05:600c:1c05:b0:439:6e08:f4 with SMTP id
 5b1f17b1804b1-43c687014f2mr30261315e9.26.1741381377638; 
 Fri, 07 Mar 2025 13:02:57 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c11e9desm6344762f8f.101.2025.03.07.13.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:02:57 -0800 (PST)
Message-ID: <26709015-6fac-48c4-80a2-cc6a4150d3a4@linaro.org>
Date: Fri, 7 Mar 2025 22:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/20] Revert "hw/acpi/ghes: Make
 ghes_record_cper_errors() static"
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <9cb6c734f32f01206db562b9a406829bf81e19d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9cb6c734f32f01206db562b9a406829bf81e19d9.1741374594.git.mchehab+huawei@kernel.org>
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

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> The ghes_record_cper_errors() function was introduced to be used
> by other types of errors, as part of the error injection
> patch series. That's why it is not static.
> 
> Make it non-static again to allow its usage outside ghes.c
> 
> This reverts commit 611f3bdb20f7828b0813aa90d47d1275ef18329b.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   hw/acpi/ghes.c         | 6 ++++--
>   include/hw/acpi/ghes.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And I apologize for missing to relate the 2 previous series.


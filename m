Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E16C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnsK-0002JO-Ui; Thu, 28 Mar 2024 07:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpnsF-0002Ih-PW
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:24:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpnsD-0006Dg-FV
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:24:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a4715d4c2cbso107175566b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711625083; x=1712229883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SxaDodnPVpVDb2UZFdTRn0wi4HcAFM+OAP8fJ5lpON0=;
 b=HH2B7x0/kRz8kgHIxFgv0TexwOWAjProhx9mTH4ougblFrvBxs4xbaZcH844DVbzh2
 0PcHbxjaL1FlCiXU+up0N0GnMB1HwONah6NNdWW9A5sx66rthHgDN/ZGBMo+Qg5EOMFP
 SiWbT0m92MkVLawSlhmnNNBkvvs6zwQXggh4TQeNn946HDoDuTEcaBu25hACVGNSORtx
 eveWi1dC96IEbGfXexhPCTiDprxdNU/3Q3hAqFcE6vk1zW3pK82jKGDLUMV9qEp1dAeo
 02nQKqgjZFPqEaE4AnCW/iBCpK/sje0g5GVmAPBVhcnyQkcQ8X8qiMgAGnCFQ5O8HEyo
 11vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711625083; x=1712229883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxaDodnPVpVDb2UZFdTRn0wi4HcAFM+OAP8fJ5lpON0=;
 b=saKjhBUNdXrGu5kWiPIJXtnxxWMCUy9kjWLoScmHLsZFt1Esi8kDkQQbefEgS5AgOP
 iNbnHg+z1UVBi05cIgtWqmKDOy+rCsI21fiBNTZgHbJI44ZLU354oOtJd15SESp9Ciyz
 ap++INCwhktsZItm215SYrGlZIzwohH7RitnV/blGkRi7RVDB1aVFEX+U00vN1+Hi3gj
 OfGSgO8D24Q5fvnEjMenBjGTVyjXsKdrQiG6avlZTugFVi8ri1wVLl1e7Feg3177KXkH
 VbgetFS/zYvL1Ex8VTRzeKL/Fqr0bWlYtrdUietsv7nag98vhkgUAcI5EYJhUodM4/z0
 6Pnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq5ESCN6TNaXR6hdspHRQyNFfD1KplVe8Eni4d29ywGOMhOdiZDnCjFZaTaihcZMJ7MxP/Ff4nvfRWQ3vgQfDwftLer0g=
X-Gm-Message-State: AOJu0YxflKghwTu/Q4RkNiuF5y7CXqRudbPoh+wJhrjA3mtRzzd1l+3D
 bh08gPXoZIM8z6HsYGHr0vucK7geL2NOu13tvjrym4p6j7e2OYICGQA96U+jYGU=
X-Google-Smtp-Source: AGHT+IGNXWuHoLToyM/9YFgqay5y6y0w/EGyS/DhE7Gmi3I9igmJNg9nBaHrEfJ6LxrwGAgyuwMuJQ==
X-Received: by 2002:a17:907:7214:b0:a47:4862:7fef with SMTP id
 dr20-20020a170907721400b00a4748627fefmr1798382ejc.76.1711625082887; 
 Thu, 28 Mar 2024 04:24:42 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 bu6-20020a170907930600b00a4e26aec839sm278573ejc.197.2024.03.28.04.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 04:24:42 -0700 (PDT)
Message-ID: <5f6f92e8-b30f-4021-86ec-41945e6c0342@linaro.org>
Date: Thu, 28 Mar 2024 12:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unnecessary NULL check in bdrv_pad_request()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: f.ebner@proxmox.com, qemu-devel@nongnu.org
References: <20240327192750.204197-1-kwolf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327192750.204197-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 27/3/24 20:27, Kevin Wolf wrote:
> Coverity complains that the check introduced in commit 3f934817 suggests
> that qiov could be NULL and we dereference it before reaching the check.
> In fact, all of the callers pass a non-NULL pointer, so just remove the
> misleading check.
> 
> Resolves: Coverity CID 1542668
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




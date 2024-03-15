Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D327FC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 05:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0NX-0004Dt-AW; Fri, 15 Mar 2024 01:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0NP-0004D9-N7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:45:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0NN-0003fp-1h
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:45:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ec8f13c62so955716f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 22:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481503; x=1711086303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8arAaNVstKZwhIVQ7fSihPVe3hczpmTjAmKzikJMFuA=;
 b=khHxrJBFp1wns4FbgTQnrw1zLl4SyJcx6om8M0dHKe/U/Ya6PKjffIhrTLHOkmDoLI
 7rwdC41lGiTj6VquB70D7mrTiEHLh8kQMH1MDlTjstZ6kAsQtSW57wLeWuvfF9VPlOJ8
 brmO/DxfbQrEN6c5IUYfv/G3UzGJYIKn5nL9jQWLEICtu5D8yInov/OxqDkliBOG7f6C
 /B5TcuYWLKXgVroJMpjHSaq3wsW1D4SybQx9JyYdUWz6dGjQg1Lnlblak3dALaV/skg8
 7TM8TH18xydDi1860uH853RAmv6jT9bRLmCCrbOBroxcZajWIaLzQG1bSLBHd5qSjo+6
 5z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481503; x=1711086303;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8arAaNVstKZwhIVQ7fSihPVe3hczpmTjAmKzikJMFuA=;
 b=v5TYgeQhAU6mPxpL0Tu9SjAbvRhhZyM1sXEV4zoBjmdOmpOnxWCCd+FA9/+J96yJe6
 p41jGN+ZNU0Kk3P8tk8JMl6nUrkkFfA3sKMZqDVSmWocPfWs70LepFiHmvhDdeqyKmK4
 Q8sCfFfXoat7ChHHDasRoT2ta4RdcW2JyRKttPA+MXk6fsLWNb461GNyAu840r2zNolr
 s56AZ2wxyosVk8YwyL8pQ9RHvw9t3AQSOxfYxeuxvmHlz3HbO3DqPbWy8VjupwJW+zQo
 E11qLn85VACgS2ZX8jmxYh6mIk15eAyI/tQ+mhddq7Y19BDcQQgLfcxvuhAKVLKcscYO
 aOIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhhaVv8dy5RvQf0mM5JdEOrqFmaSxl0JvY4S7A4LLzKcl+BsTor0PibuepCncW7sZ9o2Ra842h9FZ53hZTrpU7UL85MDQ=
X-Gm-Message-State: AOJu0YxnksT/5MS7NHQJYsLC4siFDGNrPaOpFgBh1CYjb1i2ZkI7/eXX
 j5KFMkSC8LrfIwmOMQJDeDUvn7mlaUIa4IPM09RQOwkNimB+xlLFQAIyleFlvzzA224WoUtFN6n
 Ua24=
X-Google-Smtp-Source: AGHT+IEoP0kpLlqetT6feevSrDWyaEPWSD5CRFg33Ox6ZU9lxnZG3Ku3+3PLj+dHNC5dCg3kg4gxZg==
X-Received: by 2002:a05:6000:e83:b0:33e:c271:8ca3 with SMTP id
 dz3-20020a0560000e8300b0033ec2718ca3mr1443536wrb.10.1710481502573; 
 Thu, 14 Mar 2024 22:45:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.77])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c310600b00413294ddb72sm4535083wmo.20.2024.03.14.22.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 22:45:01 -0700 (PDT)
Message-ID: <93378ae2-d9f9-454c-a77c-b1fa2ffce26d@linaro.org>
Date: Fri, 15 Mar 2024 06:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] roms/efi: exclude efi shell from secure boot builds
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20240314115307.628118-1-kraxel@redhat.com>
 <20240314115307.628118-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240314115307.628118-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 14/3/24 12:53, Gerd Hoffmann wrote:
> Bugzilla: https://bugzilla.tianocore.org/show_bug.cgi?id=4641
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/edk2-build.config | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




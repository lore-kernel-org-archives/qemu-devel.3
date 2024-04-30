Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A2C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jc0-0005a4-MO; Tue, 30 Apr 2024 05:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jby-0005Ve-52
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:17:18 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jbr-0000pa-Vt
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:17:17 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so86862091fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714468630; x=1715073430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gT/tN3TNpN+IUJNtcw//AG97VoYm7us8ctnkUy88qSo=;
 b=shT3AgmjBldslrLx/3gRkaJ4ei0l0IfrmeAXTGUAI0swP0ewk3QXHNhaKI+ZUcd15S
 9/fLOcFiBhJlC3xjTzj64toUGjxYiUgSsaHQxreQZbZJPuucgvz+mZEXLcAFKlowjc1Y
 h7YC+a7cjL4iMV4c9hfmSgYZjovCSjaZJrZjfge8EFQgbf/K2vpcDd/AIu5+0V4ypoEH
 hQl+qOB6WpHCWaBHAMG7uNw1eLO/uoYr1saMLhWotwr4ZPg+Jik2PM+gMkqawNF3MJlT
 4mwT5lUoCbZayeZVGOXOvYQZYTegCpl/CsUww5acjGi6ROivmAUhD+NJ900ade1h5Bhj
 5WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714468630; x=1715073430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gT/tN3TNpN+IUJNtcw//AG97VoYm7us8ctnkUy88qSo=;
 b=PGpJ6G0v1IRr6rq4pPuN4FYqVW6AsfWWhFkqDX+Me0fnF/6fn3WQC/ZQyvwzwFPFwy
 WH8tiLkcW2WVP2X7norcCef6qruJYuIL1+x5zGmvdwozPxSUUBDrSha3MzAEAIsi4iDO
 lg5RDUc6Qjh+E2sR2krs2SB7vQ4N43wBJ0RtOwLNwBPOVr8Dp1up9DaVk7WGq9VZ/0Ti
 SbaPFyYRr+OoRkgEFVcEu/M/tbVAKnbFbJNNIm0omrSRpn/dpB+pTRd4HOLLl/qw9uhT
 ftGSqHflrwx+yGqImAiK98Saw+F9nKKN8+9nRXHW/WNuTLVB0SmMANFflMZZThEJgoBg
 dpUg==
X-Gm-Message-State: AOJu0YwVBJekawZ9CKWYqnBxpj0IbBzX1yjRO9FMuHuvW2uHlndHUSJT
 hU7sCx/JVBVPw8ACQa20FbcJaI7eBIuvMLIW0L0c+gAVVZUokzdlRmVwSMw2jOc=
X-Google-Smtp-Source: AGHT+IFtrJtEjywOr0Nb0MtqundD/sBgQ2NJSKic96GMYISNDIur/WHjumu+oUqH7K4kHfJYN2Lg3A==
X-Received: by 2002:a05:651c:14c:b0:2e0:c6ec:bcca with SMTP id
 c12-20020a05651c014c00b002e0c6ecbccamr2306607ljd.48.1714468629931; 
 Tue, 30 Apr 2024 02:17:09 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n11-20020a170906b30b00b00a5242e285aesm14728959ejz.184.2024.04.30.02.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:17:09 -0700 (PDT)
Message-ID: <207d246d-28bc-4998-9177-7fbd7c1cc9df@linaro.org>
Date: Tue, 30 Apr 2024 11:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/pylintrc: allow up to 10 similar lines
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, f.ebner@proxmox.com
References: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 30/4/24 11:13, Vladimir Sementsov-Ogievskiy wrote:
> We want to have similar QMP objects in different tests. Reworking these
> objects to make common parts by calling some helper functions doesn't
> seem good. It's a lot more comfortable to see the whole QAPI request in
> one place.
> 
> So, let's increase the limit, to unblock further commit
> "iotests: add backup-discard-source"
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all! That's a patch to unblock my PR
> "[PULL 0/6] Block jobs patches for 2024-04-29"
>    <20240429115157.2260885-1-vsementsov@yandex-team.ru>
>    https://patchew.org/QEMU/20240429115157.2260885-1-vsementsov@yandex-team.ru/
> 
> 
>   tests/qemu-iotests/pylintrc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> index de2e0c2781..05b75ee59b 100644
> --- a/tests/qemu-iotests/pylintrc
> +++ b/tests/qemu-iotests/pylintrc
> @@ -55,4 +55,4 @@ max-line-length=79
>   
>   [SIMILARITIES]
>   
> -min-similarity-lines=6
> +min-similarity-lines=10

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



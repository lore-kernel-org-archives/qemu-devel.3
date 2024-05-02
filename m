Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843E5C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2STz-0003EQ-Kz; Thu, 02 May 2024 05:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2STx-0003Bw-4F
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:12:01 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2STv-00021W-80
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:12:00 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f40b5e059so272592e87.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641117; x=1715245917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwPuA4LiwHXGAeo5UtAtK2eqZQuqxtbamMEaWsTSPVU=;
 b=iQTEm6CY0LPYsG29xHRFXBpzYP/tHuzVgQjuG2DIGV/LCAYwZu68XiIRGNEF8UakQG
 xU/suF2ZxD4GcCPh9wwIiA6tpEjKNNKUg3yNZMvCO1fxc8ZJmFdGWtMTM04gplbupSO/
 fg5qd/zi723Jo19/ualUj4Cz9f5R0MZHxKucHHZjGH1zqknUnoZPXWFi8I06aUdAPmPK
 L1UEZA6/WL+p3YGNEGtmmKWX45qHrvtI1XgLMcRaDyl1eMr+xlU5+kgeA3QpaqjEWY2N
 GGOtJKDGph6QUSHc3e90cajq+7FUeaZ2RfG2pSSTektjM2BA/No1POfciuPe4OM02cqq
 L00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641117; x=1715245917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwPuA4LiwHXGAeo5UtAtK2eqZQuqxtbamMEaWsTSPVU=;
 b=hqueNMytHqNePX8iNLRfYKRwbMvXrKagXn2BUBbAS+GPjK+LffgEmJD57VtSGQcv64
 NLBCjyRgX4J6nUy1v83c/H8c311eNd5GIp5lPiymSjmaL06lYHZFq99tUGgdobtUrQqg
 w+07smP352AO3uLOe02V3FxyLMUijRy4uIzf1fkk6ywSr+mF4BOLeqIsxr2OLuNAP5ZH
 qj1N8KxQO242rZrHyUuJl9l+kAD7HDUjniki4iTghMhUahLP4q97i8OFPYz4G1LyO4c/
 lYzqyw9TLGPZmd54FYp+tqLw3ad03Xt7cUPQk6YcS+q/3utqbgWYFF5+rt57Xvw7k8dx
 UY3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuve+PgG9UOcZrmQDhXUsXe7wrfsR82vZPQC6jZ1ZwM5L9cbCEaIZVLZwuNSvWNvpvekQIslwBTXMiKS7p3qhakaoSt28=
X-Gm-Message-State: AOJu0YyTcXHzadU4s1OjQq6fIiA6qtCTUybydGp5iK8Yo74C6ANQ2xkO
 6QvNXOUNDtTY5MuV6C1dRLNckALEO+541mpWKxAVNXG0Z8QMaoy8sfzXbn+G3gQ=
X-Google-Smtp-Source: AGHT+IF7Js3wt3Q3xkLNTbfJpswvzQgjIkB/nU/cZufrZ/j7XPTgiklkxxmPsQNNiaFwjbtHpaNl3w==
X-Received: by 2002:a05:6512:32b8:b0:516:582:2348 with SMTP id
 q24-20020a05651232b800b0051605822348mr3079161lfe.54.1714641115515; 
 Thu, 02 May 2024 02:11:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c314b00b00418f72d9027sm4989009wmo.18.2024.05.02.02.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:11:55 -0700 (PDT)
Message-ID: <4e0d411a-675c-42bf-a472-1dd27de842e7@linaro.org>
Date: Thu, 2 May 2024 11:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update the reviewers for RDMA migration
To: Yu Zhang <yu.zhang@ionos.com>, qemu-devel@nongnu.org
Cc: mgalaxy@akamai.com, lizhijian@fujitsu.com, peterx@redhat.com,
 jinpu.wang@ionos.com, elmar.gerdes@ionos.com, armbru@redhat.com,
 berrange@redhat.com, Jinpu Wang <jinpu.wang@ionos.com>
References: <20240502074414.236284-1-yu.zhang@ionos.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502074414.236284-1-yu.zhang@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Hi,

On 2/5/24 09:44, Yu Zhang wrote:
> As the links [1][2] below stated, QEMU development community is currently
> having some difficulties in maintaining the RDMA migration subsystem due
> to the lack of resources (maintainers, test cases, test environment etc.)
> and considering to deprecate it.
> 
> According to our user experience in the recent two years, we observed that
> RDMA is capable of providing higher migration speed and lower performance
> impact to a running VM, which can significantly improve the end-user's
> experience during the VM live migration. We believe that RDMA still plays
> a key role for the QoS and can't yet be replaced by TCP/IP for VM migration
> at the moment.
> 
> Jinpu Wang is the upstream maintainer of RNBD/RTRS. He is experienced in
> RDMA programming, and Yu Zhang maintains the downstream QEMU for IONOS
> cloud in production.
> 
> With the consent and supports from Michael Galaxy, who has developed this
> feature for QEMU, we would like to take over the maintainer's role and
> create the necessary resources to maintain it further for the community.
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00001.html
> [2] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00228.html
> 
> Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Peter Xu <peterx@redhat.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1f692202519..fa9c62aae3e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3425,7 +3425,10 @@ F: util/userfaultfd.c
>   X: migration/rdma*
>   
>   RDMA Migration
> +R: Yu Zhang <yu.zhang@ionos.com>
> +R: Jack Wang <jack.wang@ionos.com>

I'm getting:

   Your message wasn't delivered to jack.wang@ionos.com because
   the address couldn't be found or is unable to receive email.

   The response from the remote server was:

   550 unrouteable address

In 
https://lore.kernel.org/qemu-devel/CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com/
you added:
   Jinpu Wang <jinpu.wang@ionos.com>
   Elmar Gerdes <elmar.gerdes@ionos.com>

Please correct the email address you want, otherwise,
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   R: Li Zhijian <lizhijian@fujitsu.com>
> +R: Michael Galaxy <mgalaxy@akamai.com>
>   R: Peter Xu <peterx@redhat.com>
>   S: Odd Fixes
>   F: migration/rdma*



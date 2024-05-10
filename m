Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B42C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NLJ-0000fj-C1; Fri, 10 May 2024 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NLH-0000cN-7P
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:19:07 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NLF-0000WE-1a
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:19:06 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5a157a1cd1so452167566b.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715336340; x=1715941140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JQkt38aHTnvOSYV1A/jZEReBxomoy4jry3E3WUfypLw=;
 b=szYk2F4Fku6ciPcq+PcZUp16Rr2Fu2NPs3q7cOSN0fyzBcl6qF94vNZNE8octHoAiX
 uqjSRgRBlkLn+bNIOVh9/Pn1wSU1T3eKo0VJo0VWJ3FJh9ue4gRXSc7cZtEGHPhYiaXq
 XO8jVdWBUhNqi7hbzGuiaW6IYNB2x4JXZ5puL9b26WS5CI5ulj1h64oQoUBGjnl846W+
 LHsukA8etbj00ZrajCzyzD4nPJYthoOR6V8/CaB+0oSvpQcXUfV8sRBAOw/7GMbX5pKH
 VHOhTMw0yTBs5izIKBxcFSXty1ihuMzq4s0E16IMSSzW5tF7tr6vXMhiQr803DOTdU7w
 Y4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715336340; x=1715941140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQkt38aHTnvOSYV1A/jZEReBxomoy4jry3E3WUfypLw=;
 b=XfTySyHTiMV42OE2G7PyCrywzDZa/d/TExhQPLnkRpy6KSsyT0CvVgzVZ4egyb2PKW
 Um/+dTrIbXjtZfYYKSdDxxX1eNzkI1l0jj7nYFWb5EjvtYgWN5xtFYVe6/cREBzz++0T
 /N/1dQhb3G9pN4O7SlJJ6w7rerqFOcjmSi05N4mlmzAk2+ZRtbftXyK8S2W3lEQxGRJZ
 QwhjxdSyppqCDyrEDapjibiDWip/0hk3WQ2zDzRk3sCOIsJVEcafCmY+XloTOogWsyLg
 7os9bhVI4SXRrX9w/EmGIOWBdIbGsJKL/RhD5izrAXtY9Sl2II/jO8rGpswKJOff59aj
 8yXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS5jbWMiTFf0Hm2ps19rtz9aKRutRp6gSyXB3KKxbA86oh87B1g3QbGMiMlnTRdap77Bj+zCPZkQOaA8PYHO16psdKEn8=
X-Gm-Message-State: AOJu0YyNdfiyG2JxMmgArw+XUMhRv9WXTza6lBUkn8IC431d8l/g4CxU
 c2rYOdzGGsg+LT6m13ZOU79CRI34igY0ftYKfqQYASIqqkTaTkKf5B+UUoHKOfTIdyBrG//90LQ
 E
X-Google-Smtp-Source: AGHT+IEe142bhjDXQ1F32En3/icRvIht+fQq9B308jY2U+463VfrLJ4/cm/EJeP/uNjlXoC8JkU5OA==
X-Received: by 2002:a50:bac5:0:b0:56d:ee61:6874 with SMTP id
 4fb4d7f45d1cf-5734d5e4089mr1631125a12.20.1715336339951; 
 Fri, 10 May 2024 03:18:59 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c32710bsm1644771a12.93.2024.05.10.03.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:18:59 -0700 (PDT)
Message-ID: <5be185fb-bc7f-4b2f-9a5c-b578f85e4213@linaro.org>
Date: Fri, 10 May 2024 12:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] xen: initialize legacy backends from xen_bus_init()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-7-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240509170044.190795-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 9/5/24 19:00, Paolo Bonzini wrote:
> Prepare for moving the calls to xen_be_register() under the
> control of xen_bus_init(), using the normal xen_backend_init()
> method that is used by the "modern" backends.
> 
> This requires the xenstore global variable to be initialized,
> which is done by xen_be_init().  To ensure that everything is
> ready at the time the xen_backend_init() functions are called,
> remove the xen_be_init() function from all the boards and
> place it directly in xen_bus_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/i386/pc.c              | 1 -
>   hw/xen/xen-bus.c          | 4 ++++
>   hw/xen/xen-hvm-common.c   | 2 --
>   hw/xenpv/xen_machine_pv.c | 5 +----
>   4 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



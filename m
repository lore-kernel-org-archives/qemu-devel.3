Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50642C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ria9y-0006Xu-Pl; Fri, 08 Mar 2024 08:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ria9h-0006J2-9g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ria9f-0001BB-0w
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709904053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FFMgT/3idhuOfI2p68avhQzkZxma8nPocRRr9S88OzU=;
 b=On5ovIim0FepBgipJgzX4KybrVRNU6VMAHZmtiVc+AL5FCTgIV6BI+we9++stvKi4l/WxV
 W6qAHNX4jnlncwJU5WktsJ3cSXVJctj/Yv4dAfNkr7koTLqfr3EmM3svk2+l6gAeTPArHt
 Ol0LQ4RsjtbOcvxfA1AZ088bhFEm2Tk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-slF6r9kzNEWzUXN6l6uXrg-1; Fri, 08 Mar 2024 08:20:51 -0500
X-MC-Unique: slF6r9kzNEWzUXN6l6uXrg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6900ad85a4dso38691756d6.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709904051; x=1710508851;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFMgT/3idhuOfI2p68avhQzkZxma8nPocRRr9S88OzU=;
 b=inK2KDcQh5tIdbqi72Z+l6ySRKtaf92z03ENHHiqdboUA/swb6niAP11vjNQZnf4IV
 Km0NCxn+aQ+1KmBFkogZeJ1NgCvASwCaRANIAIqbtj+6SZaw9Co3T97s7tkeIeCg8TC3
 n+Fz0W+p+fwGo4uMn2x1QxwmuSJecoaa4l/zymq3Lan1WOdIYMxCyokH4V7AeJLJkX0I
 8rwyGJ3thLrNJouBIUwM5J86FJSXaRTaoCWfb5HWHVhiAOw5JAcekseS56TCfZ/H68EK
 jgpgmMuO97GPxkHx3Yq+82YJdwJxKHMfeXhxKnV1S6ixWXUpXCfahREs0Ojw5R0epB/Q
 MTTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcqxwfsO4ebxSsACv9kGk+nMWzW0amryxEm5/CLjXwVApSYqbS0/DFVKYIfpSWIxH6ggWX0XkLMikZ5jjSNas+iEetFlM=
X-Gm-Message-State: AOJu0YxfU8paf0y3EnYxG7f+Ixt8DksNi5DBiOwrk67raCAkBBWfDgxS
 +aDiJFv7iPgmL7ZmRdxxR1Qr4co/2InXGnDeIJk0W5ioM46v2ymDvWfpIQ6gMjI+LQ4+2XYoAjR
 IrA7eeGVQT4cXyaBjqUaYS4Lds2mVPS+gUzKmaXK9MThUUWq+BW5q
X-Received: by 2002:ad4:5767:0:b0:690:b863:6ac9 with SMTP id
 r7-20020ad45767000000b00690b8636ac9mr321075qvx.27.1709904050949; 
 Fri, 08 Mar 2024 05:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnv5dS/nSf2gJ+OZwomGZOowj1GvWqRKj56WGt2Hy1pIkkcq9XeGqECLBgg9SNMJW14ba5ig==
X-Received: by 2002:ad4:5767:0:b0:690:b863:6ac9 with SMTP id
 r7-20020ad45767000000b00690b8636ac9mr321050qvx.27.1709904050697; 
 Fri, 08 Mar 2024 05:20:50 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 q4-20020ac84504000000b0042ef5b8b697sm4803812qtn.32.2024.03.08.05.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 05:20:50 -0800 (PST)
Message-ID: <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
Date: Fri, 8 Mar 2024 14:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 06/03/2024 10.53, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> SMPConfiguration initializes its int64_t members as 0 by default.

Can we always rely on that? ... or is this just by luck due to the current 
implementation? In the latter case, I'd maybe rather drop this patch again.

  Thomas


> Therefore, in machine_parse_smp_config(), initialize local topology
> variables with SMPConfiguration's members directly.
> 
> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/machine-smp.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 50a5a40dbc3d..3d9799aef039 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -82,15 +82,15 @@ void machine_parse_smp_config(MachineState *ms,
>                                 const SMPConfiguration *config, Error **errp)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
> -    unsigned cpus    = config->has_cpus ? config->cpus : 0;
> -    unsigned drawers = config->has_drawers ? config->drawers : 0;
> -    unsigned books   = config->has_books ? config->books : 0;
> -    unsigned sockets = config->has_sockets ? config->sockets : 0;
> -    unsigned dies    = config->has_dies ? config->dies : 0;
> -    unsigned clusters = config->has_clusters ? config->clusters : 0;
> -    unsigned cores   = config->has_cores ? config->cores : 0;
> -    unsigned threads = config->has_threads ? config->threads : 0;
> -    unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
> +    unsigned cpus     = config->cpus;
> +    unsigned drawers  = config->drawers;
> +    unsigned books    = config->books;
> +    unsigned sockets  = config->sockets;
> +    unsigned dies     = config->dies;
> +    unsigned clusters = config->clusters;
> +    unsigned cores    = config->cores;
> +    unsigned threads  = config->threads;
> +    unsigned maxcpus  = config->maxcpus;
>   
>       /*
>        * Specified CPU topology parameters must be greater than zero,



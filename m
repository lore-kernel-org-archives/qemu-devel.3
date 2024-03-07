Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5AAC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 06:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri792-0005Wb-5D; Thu, 07 Mar 2024 01:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri791-0005WS-0P
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ri78z-0004hM-2s
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 01:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709792535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ARACsLOwO7FbT98c8ku8fiqn/wSjVpf6GkrOfgzyZNQ=;
 b=a//4AAGbz5Izq3BsdsIXUIZ1+fallEGeUB6IS3U9wtX6MqdGoKK87wjMKtKla7lz19YMUi
 iEfIjTaoRI/TWAGOd8Wv8d7N4JZWq9Bf+LF+Xv9VkwmFAzOfUBROEdhNumw3Dw4QI6pW8K
 yo2F2RkNkVwJn7okx5KpEnyIaxEBZ24=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-GlqgrJ5zNMuzBAsxTiDGvg-1; Thu, 07 Mar 2024 01:22:14 -0500
X-MC-Unique: GlqgrJ5zNMuzBAsxTiDGvg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5135dbd79e7so637742e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 22:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709792533; x=1710397333;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ARACsLOwO7FbT98c8ku8fiqn/wSjVpf6GkrOfgzyZNQ=;
 b=OZM4Tl53rkRJO22dGhUjS8QKpD7pxTNMlGjbQBHDjpD/QSKBfoozbsh6keHZjAqAHm
 UGK9BIBytBXSsVU6WgcnXTII+MPBfQowzJdjvKDN8ouU69OjafQqhRNATovkkdIJW1Fm
 0Udb1DKDCM0aKwpcEwpkniAPqYbJlj4Ve5zDIzOfltKHE5oFY0hpd0sGW5n812AcYt+u
 i+ZBI1Kgq3kS8g+Ei1xeCCbHqgaDPPpFgpKG6tJv0Mrpqw34WQFduXsUqpXbfZ1vmv9q
 WViFEae3OwxIKEVoYL3Tur6zJ/n5k6U1+NyPYO8Vzoq+AxeAZAH962JxSLONu+Q+UzMJ
 unJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIZFzuPrEV7Mn9xBsZP4DkpL94SwJhld2tg3GTyD+4dXivpdL7FIr0gA5ecM8GITgLA4GpGuPgaSjTcsfdc+Vj8kBsn/4=
X-Gm-Message-State: AOJu0YwyfDmCdTMi19zfWcoPSA1qfuuZetqGD8XUGd17xNqKacIM26ma
 tL+bpB01dkxuGR20QnqlaXjM38Y/YvYq9533J4+CINmFauYOH3QpBrQXrte15j3sKeQ6+U1/WrB
 LHpxW0DC/9YGHPF1QcjUkPlWu1xCdsoYLI5Pm6eLN6uHX/UWxSbu/
X-Received: by 2002:a05:6512:224c:b0:513:596a:e660 with SMTP id
 i12-20020a056512224c00b00513596ae660mr763212lfu.42.1709792532802; 
 Wed, 06 Mar 2024 22:22:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd+8OimFcaJtZfZlD8YrNlaod7u79W1gz63au2s/CLugpNY2T+kKRl69eSiv24FXyBdMCcaw==
X-Received: by 2002:a05:6512:224c:b0:513:596a:e660 with SMTP id
 i12-20020a056512224c00b00513596ae660mr763194lfu.42.1709792532417; 
 Wed, 06 Mar 2024 22:22:12 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906075300b00a44cf710cc3sm5882195ejb.182.2024.03.06.22.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 22:22:11 -0800 (PST)
Message-ID: <5aafc78f-8c2e-429c-9599-4d2e1bb184e9@redhat.com>
Date: Thu, 7 Mar 2024 07:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/core/machine-smp: Deprecate unsupported
 "parameter=1" SMP configurations
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
 devel@lists.libvirt.org
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-3-zhao1.liu@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240306095407.3058909-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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
> Currentlt, it was allowed for users to specify the unsupported

s/Currentlt/Currently/

> topology parameter as "1". For example, x86 PC machine doesn't
> support drawer/book/cluster topology levels, but user could specify
> "-smp drawers=1,books=1,clusters=1".
> 
> This is meaningless and confusing, so that the support for this kind of
> configurations is marked depresated since 9.0. And report warning

s/depresated/deprecated/

> message for such case like:
> 
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported clusters parameter mustn't be specified as 1
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported books parameter mustn't be specified as 1
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported drawers parameter mustn't be specified as 1
> 
> Users have to ensure that all the topology members described with -smp
> are supported by the target machine.
> 
> Cc: devel@lists.libvirt.org
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/about/deprecated.rst | 14 +++++++++
>   hw/core/machine-smp.c     | 63 +++++++++++++++++++++++++++++----------
>   2 files changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 872974640252..2e782e83e952 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -47,6 +47,20 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
>   However, short-form booleans are deprecated and full explicit ``arg_name=on``
>   form is preferred.
>   
> +``-smp`` (Unsopported "parameter=1" SMP configurations) (since 9.0)

s/Unsopported/Unsupported/

> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Specified CPU topology parameters must be supported by the machine.
> +
> +In the SMP configuration, users should provide the CPU topology parameters that
> +are supported by the target machine.
> +
> +However, historically it was allowed for users to specify the unsupported
> +topology parameter as "1", which is meaningless. So support for this kind of
> +configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
> +marked depresated since 9.0, users have to ensure that all the topology members

s/depresated/deprecated/

> +described with -smp are supported by the target machine.
> +
>   QEMU Machine Protocol (QMP) commands
>   ------------------------------------
>   
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 96533886b14e..50a5a40dbc3d 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -112,30 +112,61 @@ void machine_parse_smp_config(MachineState *ms,
>   
>       /*
>        * If not supported by the machine, a topology parameter must be
> -     * omitted or specified equal to 1.
> +     * omitted.
>        */
> -    if (!mc->smp_props.dies_supported && dies > 1) {
> -        error_setg(errp, "dies not supported by this machine's CPU topology");
> -        return;
> -    }
> -    if (!mc->smp_props.clusters_supported && clusters > 1) {
> -        error_setg(errp, "clusters not supported by this machine's CPU topology");
> -        return;
> +    if (!mc->smp_props.clusters_supported && config->has_clusters) {
> +        if (config->clusters > 1) {
> +            error_setg(errp, "clusters not supported by this "
> +                       "machine's CPU topology");
> +            return;
> +        } else {
> +            /* Here clusters only equals 1 since we've checked zero case. */
> +            warn_report("Deprecated CPU topology (considered invalid): "
> +                        "Unsupported clusters parameter mustn't be "
> +                        "specified as 1");
> +        }
>       }
> +    clusters = clusters > 0 ? clusters : 1;
>   
> +    if (!mc->smp_props.dies_supported && config->has_dies) {
> +        if (config->dies > 1) {
> +            error_setg(errp, "dies not supported by this "
> +                       "machine's CPU topology");
> +            return;
> +        } else {
> +            /* Here dies only equals 1 since we've checked zero case. */
> +            warn_report("Deprecated CPU topology (considered invalid): "
> +                        "Unsupported dies parameter mustn't be "
> +                        "specified as 1");
> +        }
> +    }
>       dies = dies > 0 ? dies : 1;
> -    clusters = clusters > 0 ? clusters : 1;
>   
> -    if (!mc->smp_props.books_supported && books > 1) {
> -        error_setg(errp, "books not supported by this machine's CPU topology");
> -        return;
> +    if (!mc->smp_props.books_supported && config->has_books) {
> +        if (config->books > 1) {
> +            error_setg(errp, "books not supported by this "
> +                       "machine's CPU topology");
> +            return;
> +        } else {
> +            /* Here books only equals 1 since we've checked zero case. */
> +            warn_report("Deprecated CPU topology (considered invalid): "
> +                        "Unsupported books parameter mustn't be "
> +                        "specified as 1");
> +        }
>       }
>       books = books > 0 ? books : 1;
>   
> -    if (!mc->smp_props.drawers_supported && drawers > 1) {
> -        error_setg(errp,
> -                   "drawers not supported by this machine's CPU topology");
> -        return;
> +    if (!mc->smp_props.drawers_supported && config->has_drawers) {
> +        if (config->drawers > 1) {
> +            error_setg(errp, "drawers not supported by this "
> +                       "machine's CPU topology");
> +            return;
> +        } else {
> +            /* Here drawers only equals 1 since we've checked zero case. */
> +            warn_report("Deprecated CPU topology (considered invalid): "
> +                        "Unsupported drawers parameter mustn't be "
> +                        "specified as 1");
> +        }
>       }
>       drawers = drawers > 0 ? drawers : 1;

Apart from the typos, patch looks fine. I recommend to run "checkpath.pl" 
with the --codespell parameter, that helps to avoid those.

  Thomas




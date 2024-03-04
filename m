Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D679EC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 05:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1Dt-0005dH-8Z; Mon, 04 Mar 2024 00:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh1Ds-0005aQ-2k
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:50:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh1Dq-0001Ob-A8
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709531444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ap/FusOmaxcFRMYTAlypZ51kpY0Di8qJw8l4H0Nl8AU=;
 b=Qy5we6o9uGwPcSOgWMR5CsCeRgzereQjXIeiFK/1IKO81FyCYN2SlyGIhjyycd7XKMd8vf
 cX1+9bVPNGPPZXwjmmh19+zvRswgdisP2hfM1ZoYv6u4hpHGkzzeLGTiM3SeuEiAid61DR
 Q/D8WDkwSuOOs4cNNrU8MiagIE8hvpY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-S63BmkMWOA-2HffsGLe-8w-1; Mon, 04 Mar 2024 00:50:41 -0500
X-MC-Unique: S63BmkMWOA-2HffsGLe-8w-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42ef6c2e84cso1611161cf.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 21:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709531441; x=1710136241;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ap/FusOmaxcFRMYTAlypZ51kpY0Di8qJw8l4H0Nl8AU=;
 b=qMASJICDq0DSqMqjROc9Nm5ZPt2ltgZ3uzH+G2uj7cwQMXM/SByNkCK2dM4IQTJYJw
 /6lQfLfTyug695iuL9II6KrdvcETz4TOyLdDwHm/yzY/Yskm29gAcW4dccMXKy/Xat13
 y8EATl4IJcH4T4JZGkfifNhvno0daFcBwdh6i+FE6aJO75Z7IbBCEFIjyihAj3UOpgsv
 c+ADGWnIzAXCuXYo7PU7P2Lj49AnOoYJwzJ6tuKTT7/+GFf6JYDU3cqekR1zyE2o6iHg
 PgikPYMRCir4XAJ0dOQfjZ6W++QhJrojEumkmsASKXU+wk+nRQkQHq8tDU0hqkx3kE1Q
 7KpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Qv3OiuPtd6ZDoB2Ca9ZPrMrrjN4ppWwoBX5vap7oLy3mMQ6aOadftfgckOs2KaerSPRGQi47YItg5aVZaWDrQVYk81Y=
X-Gm-Message-State: AOJu0YwmVRG/OjtSUarr4P4AjJyFG3VfykxBaYbtVtt6uA8ZacE6a+JX
 FStyD/EBY81bMwPhCCKXrXKmkFx0VhduSpgadBjexILPBAhAEIkf2QTiXQTf19TKDJMhRI1Jkel
 Eraq4q8UQmjzYSENBuDOXCTlB25Ktnbw3d5M44eSFOaO3zD4bN+1W
X-Received: by 2002:a05:622a:55:b0:42e:79e7:c7c0 with SMTP id
 y21-20020a05622a005500b0042e79e7c7c0mr11200248qtw.27.1709531440764; 
 Sun, 03 Mar 2024 21:50:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGXtVbY83z6O/pqwFtqQHiXzPoQ3rw264T2Mke+0YzoOuBWK9RuhUNjHUq92cLRK/XDPZZVw==
X-Received: by 2002:a05:622a:55:b0:42e:79e7:c7c0 with SMTP id
 y21-20020a05622a005500b0042e79e7c7c0mr11200236qtw.27.1709531440436; 
 Sun, 03 Mar 2024 21:50:40 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 bl33-20020a05620a1aa100b00788244dc8e9sm1115007qkb.8.2024.03.03.21.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 21:50:40 -0800 (PST)
Message-ID: <d5ec8ee9-7830-4231-9d99-96b3382b5556@redhat.com>
Date: Mon, 4 Mar 2024 06:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 04/03/2024 05.45, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The "parameter=0" SMP configurations have been marked as deprecated
> since v6.2.
> 
> For these cases, -smp currently returns the warning and adjusts the
> zeroed parameters to 1 by default.
> 
> Remove the above compatibility logic in v9.0, and return error directly
> if any -smp parameter is set as 0.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/about/deprecated.rst       | 16 ----------------
>   docs/about/removed-features.rst | 15 +++++++++++++++
>   hw/core/machine-smp.c           |  5 +++--
>   3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 36bd3e15ef06..872974640252 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -36,22 +36,6 @@ and will cause a warning.
>   The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
>   rather than ``delay=off``.
>   
> -``-smp`` ("parameter=0" SMP configurations) (since 6.2)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -Specified CPU topology parameters must be greater than zero.
> -
> -In the SMP configuration, users should either provide a CPU topology
> -parameter with a reasonable value (greater than zero) or just omit it
> -and QEMU will compute the missing value.
> -
> -However, historically it was implicitly allowed for users to provide
> -a parameter with zero value, which is meaningless and could also possibly
> -cause unexpected results in the -smp parsing. So support for this kind of
> -configurations (e.g. -smp 8,sockets=0) is deprecated since 6.2 and will
> -be removed in the near future, users have to ensure that all the topology
> -members described with -smp are greater than zero.
> -
>   Plugin argument passing through ``arg=<string>`` (since 6.1)
>   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 417a0e4fa1d9..f9cf874f7b1f 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -489,6 +489,21 @@ The ``-singlestep`` option has been turned into an accelerator property,
>   and given a name that better reflects what it actually does.
>   Use ``-accel tcg,one-insn-per-tb=on`` instead.
>   
> +``-smp`` ("parameter=0" SMP configurations) (removed in 9.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Specified CPU topology parameters must be greater than zero.
> +
> +In the SMP configuration, users should either provide a CPU topology
> +parameter with a reasonable value (greater than zero) or just omit it
> +and QEMU will compute the missing value.
> +
> +However, historically it was implicitly allowed for users to provide
> +a parameter with zero value, which is meaningless and could also possibly
> +cause unexpected results in the -smp parsing. So support for this kind of
> +configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
> +to ensure that all the topology members described with -smp are greater
> +than zero.
>   
>   User-mode emulator command line arguments
>   -----------------------------------------
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 25019c91ee36..96533886b14e 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
>           (config->has_cores && config->cores == 0) ||
>           (config->has_threads && config->threads == 0) ||
>           (config->has_maxcpus && config->maxcpus == 0)) {
> -        warn_report("Deprecated CPU topology (considered invalid): "
> -                    "CPU topology parameters must be greater than zero");
> +        error_setg(errp, "Invalid CPU topology: "
> +                   "CPU topology parameters must be greater than zero");
> +        return;
>       }

Reviewed-by: Thomas Huth <thuth@redhat.com>




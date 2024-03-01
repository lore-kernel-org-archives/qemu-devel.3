Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67CDC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxSh-0003qU-HL; Fri, 01 Mar 2024 02:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxSX-0003oU-7w
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxSV-00019Z-Bt
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hcI/NtXeicjRAtUMLLrt+amMQwfobj4PMzE2Ib3rUEY=;
 b=NuQSpStxBmzTq2d6IjaBJZDm8diDg+e4yCi564k3TYLNxqatGa22POwGLh0c0aVD8K55gw
 Qaek5dtb2FrslRH5ZzdrNpE9nte1w81EG+5vR7EndPRDAiMvvSEOaT7AiXB4IX7WUmEUJW
 j5qnel9MtB6VlZZVuMCfvZI/gmZjkX4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-qnMJq2jFNMipUwnfc3aeDg-1; Fri, 01 Mar 2024 02:37:26 -0500
X-MC-Unique: qnMJq2jFNMipUwnfc3aeDg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4415f97672so117806566b.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 23:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709278646; x=1709883446;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcI/NtXeicjRAtUMLLrt+amMQwfobj4PMzE2Ib3rUEY=;
 b=PmtozFsO9paD2eprg1+HLXBCeDPpzGLlHE0vMyOm8m64jUA9ToOhUDmHuPb6ilUJW5
 lZJtB1Z/k+xBI/lZLu/Jzqxx8K81hK8JpJ0XZgXXDHpfQpj5T6UU9H97QJDzVPXNzYYv
 tJsX2aRNpMaLSzJ9uc3qV796RLBLCYv/351bcNNIN5GWeO5v59tHIv+lQI2F1pIzTxLW
 W2ZGiLWvDO/1l/mBaxryQ9RMDFsYmrDPSAcYXNNQIQFMZpJI4sTUomupPYn6JaUmO9hg
 zGNWrfbhjjSCyXRRZq5/Fz7E6++oU3UmCnl/6IV6q+DEoCuDN9gi3HvCnXo+rQ5RwUCl
 vqNg==
X-Gm-Message-State: AOJu0YyRsfUgBUViW5YYQ1nzDm3I2KraVAbcTInnjYrONO8U/joG96/W
 TRyV0MiP3YMC10lSP3j6KBx2mKnw2owLU5f+prqN9fi+P5VLkSzdYshSYIWwlNxTP08n+SLqSQJ
 PZDDXRCGoOipK0OEOOkZqZx3yGV9JCesv81s4nHXWV1zHnkFj4qRv
X-Received: by 2002:a17:906:6888:b0:a43:adee:81a4 with SMTP id
 n8-20020a170906688800b00a43adee81a4mr602813ejr.13.1709278645855; 
 Thu, 29 Feb 2024 23:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL/ovvVDipdnuXDASiQjWbLWKN/d+wKzStf/c7IzG1sEFkrQ0ScSle5YHkTk46jjwp4p1TRg==
X-Received: by 2002:a17:906:6888:b0:a43:adee:81a4 with SMTP id
 n8-20020a170906688800b00a43adee81a4mr602803ejr.13.1709278645452; 
 Thu, 29 Feb 2024 23:37:25 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 hw16-20020a170907a0d000b00a3ed5479b8bsm1439373ejc.21.2024.02.29.23.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 23:37:24 -0800 (PST)
Message-ID: <2c9163a0-a863-4387-b615-2fda216031b6@redhat.com>
Date: Fri, 1 Mar 2024 08:37:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] tests/unit/test-smp-parse.c: Use CPU number macros in
 invalid topology case
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
 <20240118144857.2124034-2-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240118144857.2124034-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/01/2024 15.48, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Use MAX_CPUS/MIN_CPUS micros in invalid topology case. This gives us the

s/micros/macros/

Apart from that typo, FWIW:
Reviewed-by: Thomas Huth <thuth@redhat.com>

> flexibility to change the maximum and minimum CPU limits.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   tests/unit/test-smp-parse.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 24972666a74d..20c663a006b3 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -323,15 +323,21 @@ static const struct SMPTestData data_generic_invalid[] = {
>                           "sockets (2) * cores (4) * threads (2) "
>                           "== maxcpus (16) < smp_cpus (18)",
>       }, {
> -        /* config: -smp 1
> -         * should tweak the supported min CPUs to 2 for testing */
> -        .config = SMP_CONFIG_GENERIC(T, 1, F, 0, F, 0, F, 0, F, 0),
> +        /*
> +         * config: -smp 1
> +         * The test machine should tweak the supported min CPUs to
> +         * 2 (MIN_CPUS + 1) for testing.
> +         */
> +        .config = SMP_CONFIG_GENERIC(T, MIN_CPUS, F, 0, F, 0, F, 0, F, 0),
>           .expect_error = "Invalid SMP CPUs 1. The min CPUs supported "
>                           "by machine '" SMP_MACHINE_NAME "' is 2",
>       }, {
> -        /* config: -smp 512
> -         * should tweak the supported max CPUs to 511 for testing */
> -        .config = SMP_CONFIG_GENERIC(T, 512, F, 0, F, 0, F, 0, F, 0),
> +        /*
> +         * config: -smp 512
> +         * The test machine should tweak the supported max CPUs to
> +         * 511 (MAX_CPUS - 1) for testing.
> +         */
> +        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
>           .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
>                           "by machine '" SMP_MACHINE_NAME "' is 511",
>       },
> @@ -575,8 +581,8 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
>       MachineClass *mc = MACHINE_CLASS(oc);
>   
>       /* Force invalid min CPUs and max CPUs */
> -    mc->min_cpus = 2;
> -    mc->max_cpus = 511;
> +    mc->min_cpus = MIN_CPUS + 1;
> +    mc->max_cpus = MAX_CPUS - 1;
>   }
>   
>   static void machine_with_dies_class_init(ObjectClass *oc, void *data)



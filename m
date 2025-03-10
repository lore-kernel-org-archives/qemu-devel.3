Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27693C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXiY-0003ki-AX; Mon, 10 Mar 2025 03:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXiV-0003fr-Jn
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXiU-0005A5-1r
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741592305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fcGMiPuXUpwi+/5XTTpJX6j45pWqFypmx1+7cGeA7kA=;
 b=PO/AaP19EnY6mJ/vrZq2z3UZCN1qpVq3m+kidkci07hUOu1NcpM6gE/WiCmNG9Dt7wQwP+
 js9I4UdrZ3t7Ht6r8sFSbcB7nvVdnLKeGhMnQvYb5Rwknv3TGUqqscgKKPeV/fEr0Fjw8S
 dr+YrkWavobzKV2col7zSm/d/uzRc+Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-MBhcFaGtPCGsPrH-sZHXkQ-1; Mon, 10 Mar 2025 03:38:20 -0400
X-MC-Unique: MBhcFaGtPCGsPrH-sZHXkQ-1
X-Mimecast-MFC-AGG-ID: MBhcFaGtPCGsPrH-sZHXkQ_1741592299
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1234299f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741592299; x=1742197099;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcGMiPuXUpwi+/5XTTpJX6j45pWqFypmx1+7cGeA7kA=;
 b=RlY+uxnWfotXQoT1aOWjzkGWfuHdeaCfT+IvHZe4+OV/R4YrZzPTLaIcfgNasCNUk9
 0MuwasrvSFJ3lA7Nm27Vbux6p2fRpIkQVIrg5G+iEm75y00TA4No2FgPRRYEHUaA4Tf4
 gy94AN+o6TN1CketxCF/ztXz/ZtDWxBO5NBgw30BsC8i9RTi61gowE/Fk3X3PpkCsGJc
 LnSVAHsX37FvGJlxBX/OydZKGJlJM+alHSfnR8S1HLtv7oAet+tB6Ahj7DPgXzTNqxvg
 m8XP+AlyUS9g8GX6/1uGWAy81y77LUYQwHSGCRqHxoo+Sr27gX72PUZBIFqpT8AG6v35
 +hhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX64sBe8PKS7WuTLoonZA4sRGSXsvaVNP952vwVoGnkqDsIni61D+nx4Df4z0bz3lRZCnyt0MZYHYlZ@nongnu.org
X-Gm-Message-State: AOJu0Yw2bjiMpVElBrU+UH0/lnXjnBQl+s09wjKda0cMb1TrSllEj2I+
 IQZoNR78DfPo53XRub/vvOeEBH8XSBx5IIhKIgm8ZNxFUDc2UfM0JHiQiBTM5gz+P2o7/VPD526
 auSAe4WFaBr2AgKFKKZurOiL+FuWOu7DtUL2DBG4XKas7cehwDXib
X-Gm-Gg: ASbGncvCDL1TYHjvd8/ykSXcKPVihgZfQNHlFXDjNBCZqpgwzdHqvMER6t7if1VEzef
 UqJp+0MtMdHwEY64KmYSfM1CITlEo/6zS3cCobygyqcwtMC/NwcW7rOhbRFnLbjBYs6j9VXdYpk
 FAB5hv9efwx2lhzPuEqjXJxY6+jlIWN0wmyMqDKaTRBtngdQMudAUHyIcOYS2N4v2DDtG2U0XMB
 PeUvasYOb5cRCCKvLpBXbBDR/bI1s0etEJDBwTn1vAauNQgTPAxk7k6zjy7/Lubl6qkecrrn09B
 UdkSjV/Lo+JQ22Tm9oi7qPgMzEU8ec4zobeBg+iAmJcV8vkWsfzk1A==
X-Received: by 2002:a5d:64aa:0:b0:390:e853:85bd with SMTP id
 ffacd0b85a97d-39132db1108mr8321567f8f.48.1741592298833; 
 Mon, 10 Mar 2025 00:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0MGS9KJUmdCejnHIUD/RZQ1jDAmK+3msRX4LEXUMNgnJkjKsldrWGKI/drvwRgRDBSDmiVQ==
X-Received: by 2002:a5d:64aa:0:b0:390:e853:85bd with SMTP id
 ffacd0b85a97d-39132db1108mr8321532f8f.48.1741592298503; 
 Mon, 10 Mar 2025 00:38:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm164018355e9.36.2025.03.10.00.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:38:17 -0700 (PDT)
Message-ID: <6c9b7ba4-e894-44b5-8a35-eee310c50c94@redhat.com>
Date: Mon, 10 Mar 2025 08:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] qom: Introduce type_is_registered()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-11-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250308230917.18907-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
> In order to be able to check whether a QOM type has been
> registered, introduce the type_is_registered() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

FWIW,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/qom/object.h | 8 ++++++++
>   qom/object.c         | 5 +++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 9192265db76..5b5333017e0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -898,6 +898,14 @@ Type type_register_static(const TypeInfo *info);
>    */
>   void type_register_static_array(const TypeInfo *infos, int nr_infos);
>   
> +/**
> + * type_is_registered:
> + * @typename: The @typename to check.
> + *
> + * Returns: %true if @typename has been registered, %false otherwise.
> + */
> +bool type_is_registered(const char *typename);
> +
>   /**
>    * DEFINE_TYPES:
>    * @type_array: The array containing #TypeInfo structures to register
> diff --git a/qom/object.c b/qom/object.c
> index 01618d06bd8..be442980049 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -100,6 +100,11 @@ static TypeImpl *type_table_lookup(const char *name)
>       return g_hash_table_lookup(type_table_get(), name);
>   }
>   
> +bool type_is_registered(const char *typename)
> +{
> +    return !!type_table_lookup(typename);
> +}
> +
>   static TypeImpl *type_new(const TypeInfo *info)
>   {
>       TypeImpl *ti = g_malloc0(sizeof(*ti));



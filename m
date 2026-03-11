Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EA31125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OBB-0007gd-Qf; Wed, 11 Mar 2026 14:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OB5-0007f8-Re
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0OB2-0006QH-Lh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773253258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOhLNeMkt/xUr6zSUOKnMS9UpFF66N4foeoMxSIjBwI=;
 b=JcZ6kdRriWTjZilpwArI7Wjjq3xWWPsDMehxJBgTSn0Tjo1yukeWCm8CIPaw+i6hdwgi2b
 O+Hum4so1RY8Xb9pNpUBcnlC7UcEPk66pL118DS5c9bzvMjdKjfgkdgABdKlTc84r90hQE
 khqVu0szvogdRsJIjEmgIBYr/n+N9r8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-eAm0fx5jOeOjOUYZFna3YQ-1; Wed, 11 Mar 2026 14:20:56 -0400
X-MC-Unique: eAm0fx5jOeOjOUYZFna3YQ-1
X-Mimecast-MFC-AGG-ID: eAm0fx5jOeOjOUYZFna3YQ_1773253255
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbc5fd75so118839f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 11:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773253254; x=1773858054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOhLNeMkt/xUr6zSUOKnMS9UpFF66N4foeoMxSIjBwI=;
 b=dSUQnNGTNyRPt/8nEidiY9GQOZWiRPmxWbH7gL8rKLAvDEFaBcsC594cH1X0aExOH5
 Ldch7akoFAo8pI+IfifUbwfI0fUTrFVzCdT9lyMFcILzMq14GCIR9K6dTt8aXdzMnN6h
 8mP2De4W6jTSNkmOjIpoqLSiDkaM+gaPOuInik/U9b/9pQQZwaVlINm/L9Ih6ohJOPzT
 g+nIJaMpppkLmBkdyYObJ0AWGjBZw/TofBlnJljgqJOSpfgLZNqfCGJMPolkLaNUY1m+
 D723TxTTldWak5/VBGhygUYnoCtGSV28aVpXCrN1XMDTgwfqPAk5BdyOLzgb1eRaxnE8
 rQOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI4VhnLaTA3o8GQRYUQ5oHNLbvpIk8Y7EteCNTLmXIm+nEAVwKhz2v4UrrbWIMb3810tHe0Kveg0Hg@nongnu.org
X-Gm-Message-State: AOJu0YwbhePFB4oa7TKGz7d59Z9EGJ0IZPcX+X+J8hFBeRNW6NnK1OuL
 NguJmfcWJ3J0I8HaHMSpxArNkNRr4x4p9DZUbZ+hfb6Jt8WlXjNZttaulgEWilMjHNeyEN8O1B0
 F8ck8+J7dqEA5RL+26VSQi2utyZAU/bIn8lHpYQZcd5u7eAwBkMsBE8Vi
X-Gm-Gg: ATEYQzz4WQweBeHgK/FyimBuMLR4u3iN7MrpBgsj6FmuUI8ShPiMkgnNOx+rgxQnOdc
 Vyi2FjWRmopI+GwhUOE4uk44L4uIOV1PaX2K5Pgcboje9kvfvJh3L0hDGUBuxx/VsKfXhd5Gu2N
 VuXA+T9Y9LvfbU7vZXJMsaPy3vd2uYAPMSJq4/Y1l4onkas2MhIWmDwllkEg5kPgYy5nmJDWRA6
 UJO528E2lHGzv7MVD8mvqt+gvMv/hR/aNvtJLopgXKYdHatKasRiskki3v0LbaGjzGEbiAm135i
 27pcSGDLYtJk7WW6MXXsiP1Ekp+M1rV76Y8r+5J1m7Hjc1kGUEBgNrfbwNUs8nQPWprbrZgIVgA
 eiSaL8Z3B+JarnLXtWIJtlraaa/17+ZYjFING/s6AgRn19Wbgpo+tcrO6ghpJhvnqH/kFDw==
X-Received: by 2002:a05:6000:3113:b0:439:c5cf:fc68 with SMTP id
 ffacd0b85a97d-439f81bd343mr6922386f8f.1.1773253253629; 
 Wed, 11 Mar 2026 11:20:53 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:439:c5cf:fc68 with SMTP id
 ffacd0b85a97d-439f81bd343mr6922345f8f.1.1773253253149; 
 Wed, 11 Mar 2026 11:20:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe23afc5sm1166520f8f.39.2026.03.11.11.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:20:52 -0700 (PDT)
Message-ID: <793c6796-177a-4e31-bda7-60bf2b9e1574@redhat.com>
Date: Wed, 11 Mar 2026 19:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] qdev: Add an OasMode property
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260309192119.870186-8-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nathan,

On 3/9/26 8:21 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Introduce a new enum type property allowing to set an Output Address
> Size. Values are auto, 44, and 48, where a value of N specifies an
> N-bit OAS.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/core/qdev-properties-system.c         | 13 +++++++++++++
>  include/hw/core/qdev-properties-system.h |  3 +++
>  qapi/misc-arm.json                       | 16 ++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 4aca1d4326..a805ee2e1f 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };
>  
> +/* --- OasMode --- */
> +
> +QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
> +
> +const PropertyInfo qdev_prop_oas_mode = {
> +    .type = "OasMode",
> +    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
> +    .enum_table = &OasMode_lookup,
> +    .get = qdev_propinfo_get_enum,
> +    .set = qdev_propinfo_set_enum,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- Reserved Region --- */
>  
>  /*
> diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
> index 4708885164..2cbea16d61 100644
> --- a/include/hw/core/qdev-properties-system.h
> +++ b/include/hw/core/qdev-properties-system.h
> @@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
>  extern const PropertyInfo qdev_prop_granule_mode;
>  extern const PropertyInfo qdev_prop_zero_page_detection;
>  extern const PropertyInfo qdev_prop_ssidsize_mode;
> +extern const PropertyInfo qdev_prop_oas_mode;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> @@ -64,6 +65,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
>                         ZeroPageDetection)
>  #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
> +#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>                          LostTickPolicy)
> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index b372a3661b..76b6965502 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -60,3 +60,19 @@
>  { 'enum': 'SsidSizeMode',
>    'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>              '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ] }
> +
> +##
> +# @OasMode:
> +#
> +# SMMUv3 Output Address Size configuration mode.
> +#
> +# @auto: derive from host IOMMU capabilities
> +#
> +# @44: 44-bit output address size
> +#
> +# @48: 48-bit output address size
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'OasMode',
> +  'data': [ 'auto', '44', '48' ] }
you also miss other enum values

Thanks

Eric



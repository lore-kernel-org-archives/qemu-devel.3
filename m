Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A306F013CA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22lV-0005pL-Tr; Mon, 16 Mar 2026 03:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22lT-0005om-VJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22lQ-0005eB-MK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773647573;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whKbiEctbNTZFgdePeGahmc1szbx1x2qNPNfTtbZT1k=;
 b=Lneu/l1PIMNUrva/RQcngsxU2XuvLqN2AqMCxdkoYkEuEe7d4c9M1xoR3Bm0H+LFz0UQ/s
 Ob3PEboGvfnpu93iSUdpJs6DuxRyxt3ejJrotX7OkcoW6JeLw3lB0XCfNzwVyz/1FV6RFQ
 QOJwo5GkhUYC0S7AKumlA4Wwu+RArRI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-BJMxGjtiOZWlire5SZtDRg-1; Mon, 16 Mar 2026 03:52:51 -0400
X-MC-Unique: BJMxGjtiOZWlire5SZtDRg-1
X-Mimecast-MFC-AGG-ID: BJMxGjtiOZWlire5SZtDRg_1773647570
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c54e0f6aso3389531f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773647570; x=1774252370;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whKbiEctbNTZFgdePeGahmc1szbx1x2qNPNfTtbZT1k=;
 b=X3qNvHjYhUVZm/MJRAPWH2Mk/5mCQcWxW0cq0vF1/vNYGBWbBz4EcObk0D7mXmCSUK
 6//k5va5CcogtuFem0ZLyzgOgR2sRYz4aF8SdqoCSv4HfK3gaoo9PCm8LDmZakrd/5sQ
 N0ZwPrd1MoESxLmzFI+qOfs+nlS30XKvR9EAAPUSSLWOHPdNyWfAjCHUD491/qSLwpVm
 SbJdK6qpfjKCQz9i8PTOKcZmttyPE5Vz0LvIhp0A3TEPeIXDOom3SUa52h1jBeySIEDV
 uExLyJyYrf2/3zRYNJMNmypFy9HTwhpdj+3WoxWiW3TqE7oxoaia8DmKgX+rLFfLp6lo
 CVLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg8NRpnSFDHO+hmSzFE2XINHuJ0t/DIcvRz+DHVN1gTmJx48F/8Li6mAJK5CwHDwfuNTitgCmdV4r7@nongnu.org
X-Gm-Message-State: AOJu0YzK67F104O2qCd9t/uYXgRaXadAxG+QVjnE4LLABJtjzm26NRf3
 Ux6qP+47qpSnaq+0TdJc+0nebMfJU8Ztmwv2hVN5Kmw9VRhNxZOffSTrgK13+aDZsR7Qjd1IpPp
 FzzGw/rU8L9lCR9CpjYxWleQTxPvIqqtJsWwInz3KS9byrs8aHC/S23u/
X-Gm-Gg: ATEYQzzp11s1YRGDfx7Xd9Dd6F7LShMEkpaBG/OP1GqFSZmWWZ1BU5qmG64+3yI4QtY
 83A5oPqQgMepDLIbypwmaSUhbhLeTlcgHUZGqDl4jT7DcT6C6WTxluwcmB9sVedi04NtghhxVQp
 gSsGz5jkhLEhbXTAr3UWUTE3tPsSK9A7Ql4XZKrEk4RX9jRpnhTSUC37pDyGL3OgOBCyR+xjhiJ
 oGJpli1zyXNEYbwuYWe+1uAVSiSU+uGiXQS4K71p90IR/d+VWKW74r8qZ3HMzJQh8Au0pmKN/ll
 IFVYbg5+hw1NaCW+JTctFCHuUXEglV8xedLH8WkdUCxtXkbR9R6Fr8ki+fpZqi6PXJ16CxPWHLG
 aCR6WwWQxtMW08S22Hn/cUWwmPkZs1rNfnXQibRmsJ6aOBQlItdFsWUEq44vclVVJjKwvLQ==
X-Received: by 2002:a05:6000:4312:b0:439:d74d:a66d with SMTP id
 ffacd0b85a97d-43a04dba87cmr21581243f8f.21.1773647569782; 
 Mon, 16 Mar 2026 00:52:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:439:d74d:a66d with SMTP id
 ffacd0b85a97d-43a04dba87cmr21581204f8f.21.1773647569169; 
 Mon, 16 Mar 2026 00:52:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm42026453f8f.24.2026.03.16.00.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:52:48 -0700 (PDT)
Message-ID: <04cf988e-9fe4-4971-8afb-ffb1d984221c@redhat.com>
Date: Mon, 16 Mar 2026 08:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] qdev: Add an OasMode property
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-7-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-7-nathanc@nvidia.com>
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



On 3/12/26 10:03 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Introduce a new enum type property allowing to set an Output Address
> Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
> value of N specifies an N-bit OAS.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/core/qdev-properties-system.c         | 13 +++++++++++
>  include/hw/core/qdev-properties-system.h |  3 +++
>  qapi/misc-arm.json                       | 28 ++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
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
> index 76ea0a09fa..5dbb4add91 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -61,3 +61,31 @@
>    'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>              '10', '11', '12', '13', '14', '15', '16', '17', '18',
>              '19', '20' ] } # order matters, see ssid_size_mode_auto()
> +
> +##
> +# @OasMode:
> +#
> +# SMMUv3 Output Address Size configuration mode.
> +#
> +# @auto: derive from host IOMMU capabilities
> +#
> +# @32: 32-bit output address size
> +#
> +# @36: 36-bit output address size
> +#
> +# @40: 40-bit output address size
> +#
> +# @42: 42-bit output address size
> +#
> +# @44: 44-bit output address size
> +#
> +# @48: 48-bit output address size
> +#
> +# @52: 52-bit output address size
> +#
> +# @56: 56-bit output address size
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'OasMode',
> +  'data': [ 'auto', '32', '36', '40', '42', '44', '48', '52', '56' ] }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric



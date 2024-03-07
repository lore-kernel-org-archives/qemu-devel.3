Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBBt-000698-Le; Thu, 07 Mar 2024 05:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1riBBl-00068Z-SF
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1riBBj-0003wy-R0
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709808082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdyxcId0BGYqIupKtO+ti4pOXOphvh74SgPn6UW63oQ=;
 b=CL2IzFz9QM9iHm/Fz6Etqa3TyK/iZU/IvOZ9Df4N/w8MyV45VpCtipWwysR3KAmCJl9WAn
 eVYBa+2286+BI937aoYt8V3LUFpNU0fr3vVYmHMEnJdH6z56YRy64t+XLAxypstwcoXgEV
 td2AxkAVphc/VQGUZafXBW/b/chWthQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ytVuWJceNISNzFAblTQNCw-1; Thu, 07 Mar 2024 05:41:21 -0500
X-MC-Unique: ytVuWJceNISNzFAblTQNCw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6904160e997so7378496d6.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709808081; x=1710412881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdyxcId0BGYqIupKtO+ti4pOXOphvh74SgPn6UW63oQ=;
 b=sT2nHkVUoVS1ZjPFx+jNdLwr0xt49twUzrsjHzQnfsqlnEm4AwYDX/O7jx+hX3gcDZ
 pjgeiqmD37Qnd+LokNrTcUeKFwC10KJ0FVSq/pjFYIM3T3tv4T6T8xuCRiNw2UVGBHOs
 kyCK+rYNmOwzOk94juWgofifKsC6el7HzaKO3dDHDZGU8ZxDvxkyeixlW7wNNLQzwmQT
 U72/p0Y6B2qZpiCixiFPUNxdhk1XVTZRm4iY1Cfl+8i/DGa5KaUp3nXAzQoZz4PGDtI7
 Aerpvck3RHfPvrW4z/StS0FJEyyZxh3A3N+5A2fnfs/64vvSdjRrgDK5yUelnhkZjXXB
 3nKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMekjN7souE2wnNEUI1VMG3YOIbUV603i7y4KfC6U5Xz4L+1DaG5jbucWv0TGDmsMQ+c23TevDiznbdKTE+ney1VWxzWY=
X-Gm-Message-State: AOJu0YxwJCe02jLULGW81Zq/VpTqco0IX8MJLiALuvt8NbikqMBzRoj1
 ZGcvgbDekgYzIYaj4p7JIVTrPlV1IiOUoOEV6h/hZq5vGbuYTPvdVY1Kb++T8ljEd2v8mS5Kpkj
 ld+0kQyml6KKOf+G2Pl2YNvX+dddYvbyevC2W5dW/CBqLW60ddtLs
X-Received: by 2002:a0c:e584:0:b0:690:9785:565d with SMTP id
 t4-20020a0ce584000000b006909785565dmr3201846qvm.64.1709808081034; 
 Thu, 07 Mar 2024 02:41:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXPnkFpRHVyjY/kc/Opsi1NT6xjJSBAp1GBLdQ7IZI7iHzk5FCNmeNTtZgt+xOhroV/fT34w==
X-Received: by 2002:a0c:e584:0:b0:690:9785:565d with SMTP id
 t4-20020a0ce584000000b006909785565dmr3201824qvm.64.1709808080669; 
 Thu, 07 Mar 2024 02:41:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 na4-20020a0562142d4400b0068fa2898a67sm8515142qvb.52.2024.03.07.02.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:41:19 -0800 (PST)
Message-ID: <16ce67d5-1987-4fda-85b5-33ad66c84435@redhat.com>
Date: Thu, 7 Mar 2024 11:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] qemu-options.hx: Document the virtio-iommu-pci
 granule option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, imammedo@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-5-eric.auger@redhat.com>
 <fcaf95d2-bb09-4c55-a333-21a93a707ad2@linaro.org>
 <07478583-ce74-4de3-8983-010c6617e4a8@redhat.com>
 <d0ae5297-08ff-4f91-9ddb-0ae7acdc8748@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <d0ae5297-08ff-4f91-9ddb-0ae7acdc8748@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/7/24 11:21, Philippe Mathieu-Daudé wrote:
> On 7/3/24 08:32, Eric Auger wrote:
>> Hi Philippe,
>>
>> On 3/6/24 21:44, Philippe Mathieu-Daudé wrote:
>>> On 6/3/24 21:32, Eric Auger wrote:
>>>> We are missing an entry for the virtio-iommu-pci device. Add the
>>>> information on which machine it is currently supported and document
>>>> the new granule option.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>    qemu-options.hx | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index 9a47385c15..757df3eac0 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -1172,6 +1172,14 @@ SRST
>>>>        Please also refer to the wiki page for general scenarios of
>>>> VT-d
>>>>        emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
>>>>    +``-device virtio-iommu-pci[,option=...]``
>>>> +    This is only supported by ``-machine q35`` and ``-machine virt``.
>>>
>>> Don't we need to precise x86 and arm here?
>> Well I got inspired of intel_iommu doc. I think this is sufficiently
>> precise, no?
>
> Apparently not:
>
> $ git grep -w '"virt"' hw
> hw/arm/virt.c:96:            mc->alias = "virt"; \
> hw/m68k/virt.c:314:    .name       = MACHINE_TYPE_NAME("virt"),
> hw/openrisc/virt.c:37:#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> hw/riscv/virt.c:1754:    .name       = MACHINE_TYPE_NAME("virt"),
> hw/xtensa/virt.c:127:DEFINE_MACHINE("virt", xtensa_virt_machine_init)

ah ok. I will precise then.

Thanks!

Eric



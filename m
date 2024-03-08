Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E512C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUsE-0005aC-D8; Fri, 08 Mar 2024 02:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riUs8-0005VS-Iw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riUs6-0007zr-EK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709883745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWPXgq62QinHImbj8z86QZckxHMyr9+EGnaIVP9hb8o=;
 b=AGGYHhWvBnmRG1wbxkaQYazyKpPe+AXLkLgLdqtl2PiqMIeirWZWCXKl0dTST2LWSthH8U
 hC2u+C7rYS5FyYjW5ga2Qm/5e60aBv68Snh6i8tBoOSAzqRsm2efuzLy7R99KgI+StkTg5
 AuDWGGCGrpeHbuwLNnYGrvHkFXpmdRA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-K3mS3eoHM76MCj3S2cO53Q-1; Fri, 08 Mar 2024 02:42:24 -0500
X-MC-Unique: K3mS3eoHM76MCj3S2cO53Q-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-608e4171382so27626197b3.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883743; x=1710488543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWPXgq62QinHImbj8z86QZckxHMyr9+EGnaIVP9hb8o=;
 b=f5Zv7vEpYNUCpRXdFN1WG8Pmg+oRst8r0L3CFt+hvhRdx+6p/c5etpdjFqJelPq0qW
 mhlw9/objlAmn81KyO4FDR6x4Om1oMtmWUJLllZe2M2oBu5d+7thqYMa+5U0zqYLGa3F
 q7+XgdgaxqiIx2LFub0jU6xFos/94vDyvbKfxwnRj4btvf5LzvIaz2RRHCEfyGFPWlPk
 hEu4AyZNGs/w9vrL75EneSW3wNDC3Y1Xl6ScCCTdt7quG6+i4bRCg0/7VfMgsiy5DaFH
 7vZTNelddDBCHh0V8vLGcoPh/OlfAD+xbdxVT+gvv1f2qeh+H/td/M2ssQngXoCgc0jJ
 2hVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Q366dOvPUeys8YnoEtEzraz52xLTAdUIkbTTWFHq6WSNi+Ww7hzc1NGXD2S4G/8Nzq2DISzJZXgLZZ8990pOZ6OHWMA=
X-Gm-Message-State: AOJu0YyfBW797SO4gkUFHhEw99lq2gOmeyhriu6nRUUAeGzp/3ndMrsY
 EmfnX6FapZAU2FLo1RcjV8PETNPvvIcIlrYyVycyUVVdGMFL07wgBF1Z7aFjTBixiPmTyd23lDz
 NAGYAUSQMpiCBFyX519YTBgCszPByNzbnJgum44z1NsFgZXblvA+3
X-Received: by 2002:a05:690c:f8f:b0:608:78b7:efb3 with SMTP id
 df15-20020a05690c0f8f00b0060878b7efb3mr22893591ywb.38.1709883742236; 
 Thu, 07 Mar 2024 23:42:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHex1ao8R1d8I51hyXU4oq1N4D2IOSbTDbW5ZSjAy0WsrDOvgdLJJaROnTiIpVyi/Wc+CW0g==
X-Received: by 2002:a05:690c:f8f:b0:608:78b7:efb3 with SMTP id
 df15-20020a05690c0f8f00b0060878b7efb3mr22893585ywb.38.1709883741985; 
 Thu, 07 Mar 2024 23:42:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b0060a015c9da0sm279077ywf.72.2024.03.07.23.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 23:42:21 -0800 (PST)
Message-ID: <f8b5dd4e-058f-4968-b598-2df53aa47c3a@redhat.com>
Date: Fri, 8 Mar 2024 08:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] vfio: Also trace event failures in
 vfio_save_complete_precopy()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-25-clg@redhat.com>
 <c7fec11d-284c-4134-95aa-d10cf7658f6d@redhat.com>
 <0a4ecd0f-721b-4c58-8300-911eaa888332@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <0a4ecd0f-721b-4c58-8300-911eaa888332@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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



On 3/7/24 14:36, Cédric Le Goater wrote:
> On 3/7/24 10:28, Eric Auger wrote:
>>
>>
>> On 3/6/24 14:34, Cédric Le Goater wrote:
>>> vfio_save_complete_precopy() currently returns before doing the trace
>>> event. Change that.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/migration.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index
>>> bd48f2ee472a5230c2c84bff829dae1e217db33f..c8aeb43b4249ec76ded2542d62792e8c469d5f97 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -580,9 +580,6 @@ static int vfio_save_complete_precopy(QEMUFile
>>> *f, void *opaque)
>>>         qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>       ret = qemu_file_get_error(f);
>>> -    if (ret) {
>>> -        return ret;
>>> -    }
>>>         trace_vfio_save_complete_precopy(vbasedev->name, ret);
>> it is arguable if you want to trace if an error occured. If you want to
>> unconditionally trace the function entry, want don't we put the trace at
>> the beginning of the function?
> 
> But, then, the 'ret' value is not set and the trace event is less useful.
> I'd rather keep it that way.
ah I did not notice the returned value was traced too. OK then

Sorry for the noise

Eric
> 
> Thanks,
> 
> C.
> 



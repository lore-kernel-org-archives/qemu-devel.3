Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB45EC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hyk-0004j5-2d; Mon, 07 Apr 2025 04:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hyU-0004eX-Nn
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1hyN-0004Ms-Ha
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744015010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HNk8bcOKFnabe7eEIaANsBeLhVIc0LBYJ5zp5mYcZ3Y=;
 b=XeRPT6xdOWipIcBC7fOI+UDXffiF5h/DGFmWcI3zqPE7CRAGF4Aq5FSQvMEDZwfRgGKmP3
 rC8Re7l9qbZ50tTsnlUsK6njFlgO/JolH2g5J4q6RCYrnTLT5QWSPST1mzhXwcNBzGhbeP
 zxY6TRoSMiGaLKOpTPwzgAX7QxDFc0E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-EMI65gdkNVC1eokcChPo8A-1; Mon, 07 Apr 2025 04:36:48 -0400
X-MC-Unique: EMI65gdkNVC1eokcChPo8A-1
X-Mimecast-MFC-AGG-ID: EMI65gdkNVC1eokcChPo8A_1744015007
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso2396616f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744015007; x=1744619807;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNk8bcOKFnabe7eEIaANsBeLhVIc0LBYJ5zp5mYcZ3Y=;
 b=qxm1MmLL6VvbNihv6++mYXZFsKoraeUFxG4bl+tPkoLtNdcrv1/geEp0q2zBfeic6A
 DaQ1ucvmyiSnRBOmKGYkFApf7hmTWd7ugS76bgWNfgkgeMtDlUZSpR2ILGsY8mqHrQtJ
 depTcbO4PxPM4epFP2pZaa8jrTku2CoRtFcM0tw3+wuNkS9d77s2vPe5fCvD3QKEoB6d
 sUCMf2I63OWgtU4HrWBGgz9dCgwCbc3IXmFSWpNsNWNFSgBWN8zUG1KYjWy+aTjFkm2W
 bX7rilERco1nKNewJQnavi9JgtOo+gX4xPqYT7O7X4MKV7pwiOPXooM/IMpsX4jeosOE
 6gnw==
X-Gm-Message-State: AOJu0Yz2pEyLLLpyO0cG2jbW9xs/sWXn7yZpX6bqzdg2kqssjzWTEgno
 oq4omh4/Wgcc/LO9EXjPVZwkqcQtSHxui+zGK5EyDwhqevJdWg96O3rM+vkQ9cY5EjDI2Ls+PdV
 HZXArfmCC7bEggPC8WTV6axJduh3dAZSNF/POzt7za+Kh7WPmVwtF
X-Gm-Gg: ASbGncukUSEQC1Qxeg1iSzHHbvzl9ThxJYS8vTOhHO4SLHLo2/mal9okEAGaarykji9
 C7LppflMw4t980r2pnZKsU2Nf+JZHM6SZhIC0AXRHll1Q0LgtCD7QkdiM2hhr07NkhAO/AoUu9W
 O2Esa3W4SIUmE2dCc6uY8Q/XUD8RLjFoPq3NzEXd9TfLVyYuSjKMvoIGgur4C3LtZAVJvncAnQs
 sbiJ2xHwRadO/xr2UNWi0QnUEB95HeD8g6Tdtyt3n67tmJhwTy724pGlhNR7Butei5nTQmFzdNL
 L9iZ5R0L8zNZcC9xjGnITJixHoemz6kysbFwWwPo2bFZhelprj4bTw==
X-Received: by 2002:a5d:5c84:0:b0:39c:1258:7e19 with SMTP id
 ffacd0b85a97d-39d6fd373c6mr5341192f8f.58.1744015007419; 
 Mon, 07 Apr 2025 01:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfGoNsSqOlCEFuKKOYakOk3yEAL8p8/XMiPC8WJmfHFv1t06i2Z9n3O9/ns+regfzrSqjNLg==
X-Received: by 2002:a5d:5c84:0:b0:39c:1258:7e19 with SMTP id
 ffacd0b85a97d-39d6fd373c6mr5341171f8f.58.1744015007023; 
 Mon, 07 Apr 2025 01:36:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6a1esm11400202f8f.45.2025.04.07.01.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 01:36:46 -0700 (PDT)
Message-ID: <c8fb320f-03d0-44b8-bd03-cc8b974a665e@redhat.com>
Date: Mon, 7 Apr 2025 10:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 33/37] vfio: Rename RAM discard related
 services
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-34-clg@redhat.com>
 <Z+UfqXAgNGaE3rR9@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+UfqXAgNGaE3rR9@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/27/25 10:51, John Levon wrote:
> On Wed, Mar 26, 2025 at 08:51:18AM +0100, Cédric Le Goater wrote:
> 
>> Rename some routines to better reflect the namespace they belong to.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/listener.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 26ced6d4fb04b0dedf399686db40acaca5d85552..07c8dc6ce343510dea20c5946e64a23a57c0f91b 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -243,7 +243,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>>       return 0;
>>   }
>>   
>> -static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>> +static void  vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
>>                                                  MemoryRegionSection *section)
>>   {
>>       RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
>> @@ -318,7 +318,7 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>>       }
>>   }
>>   
>> -static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
>> +static void  vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
>>                                                    MemoryRegionSection *section)
> 
> Nit, unnecessary double spaces introduced here?

Indeed ! The sed expression I used was bogus. Fixed


Thanks,

C.


> 
> regards
> john
> 



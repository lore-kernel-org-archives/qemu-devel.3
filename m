Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B8C28B23
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 13:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpoZK-0004tw-Pn; Wed, 05 Mar 2025 08:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpoZH-0004tc-D3
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpoZF-00012Q-CG
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741180423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w82E2Dy64YVsrOg8XgWKYMUp0K7NFjHu1Ck/pMvu8es=;
 b=HsFhCUVWtRXIt1KZd5O7dobasqHojC+W04dF6uYeekieZs7XzuIUyfMDZgev2dQ6mycwIK
 1O+rXVFIQn2Bqdvm1HKjwI9wbdNNY19C7CPF4gtLd5Ih3l2Px7ZrD/oPMlk0g/RjyeES6M
 3auA8AjyZwIAPTg0sn07uWiZD2YVFAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-hOV5aktLN46PvuFL7pLe8A-1; Wed, 05 Mar 2025 08:13:41 -0500
X-MC-Unique: hOV5aktLN46PvuFL7pLe8A-1
X-Mimecast-MFC-AGG-ID: hOV5aktLN46PvuFL7pLe8A_1741180420
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso6345214f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 05:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741180420; x=1741785220;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w82E2Dy64YVsrOg8XgWKYMUp0K7NFjHu1Ck/pMvu8es=;
 b=NcxS0h7qLmb9X3As78ISb/iURo0QMOm7GVtWom2kHPhSzY8f9+OE5xSa9fDT6FcepU
 xQtUGxd7JqyPhvYc/n5kyrzNsp5HobGNiTXQEA0Wutdrv/Wy72j2s4DWbNsUVG5clNwJ
 YS5vuXC6w3dwe7KW941T2qIsuRvmoAXoaqe2wtVheQJO8hhad/SITyC5KgYoGN9zmR+P
 cp7j6bNvB2XHsQ6hWBq77N9ezO+vY7AkonLY37LXFcATLfxtsc3reAP/JLkz3kMhelD7
 9zDPLkNBSDe8YrpRcSrgyWaSODDBk3jt7wYup4WsMmhDRNx38FZbpi9uSzpvkNS/ZCs0
 g51A==
X-Gm-Message-State: AOJu0YwfwfyOWVTEXIr5O73I+Xw2C8MvYHqGxlyMsJRDrMoM+/Ulzqp9
 WgIxPC8/y+9JeBvGb1QSbZ9NCYYdmHxfXN7fLECCbc93QQvOYi+6hMNcPSemOB4SdILvgXdEmmf
 lncFuynenS5iDMq+Ld0wNlW55dBB+DcYLT7QktZ1Dnpm+FC2WfhS3
X-Gm-Gg: ASbGncv2WerRjBISZ+KxSI2S4lYpRf08sgGR+gyVV4NqvL8jIqxCsi3GpPnALuoWAK4
 PQ2VQSwdtVh90C5ARp9UmESXCeU4CAjU+jegQUHtrZP+TXkygtVE0+UF8Bhz4KGjbSzdRFnUvAY
 +nGwP8I4JH3lHvjbui4zRnZyXTXamAjCTV8psqxM+4w5QY0gBLUltlNWIA7VY2G/fWmVhUw+KcA
 8ciAP+pbUUmytQAm78cvTcuA3sHKPu6anRLFfmSgwGboHWEMy1olnMY9lQawOJ7WbvMDpZKGMVI
 H3awvkvFK9KfNMUaUvbVF+ahEv5yYRywxHxnC1fj9C7+xyi762ENyQ==
X-Received: by 2002:a05:6000:2a86:b0:391:253b:4050 with SMTP id
 ffacd0b85a97d-391253b435amr1249284f8f.51.1741180420325; 
 Wed, 05 Mar 2025 05:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAZBDcEernJgvo0xHlPG48Zu4kmVfY797BGlFwWYNmwvAYaHfLSgwPRfJVumvTPvyl8YqCTw==
X-Received: by 2002:a05:6000:2a86:b0:391:253b:4050 with SMTP id
 ffacd0b85a97d-391253b435amr1249251f8f.51.1741180419941; 
 Wed, 05 Mar 2025 05:13:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6ddesm20939950f8f.41.2025.03.05.05.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 05:13:39 -0800 (PST)
Message-ID: <8ac4f034-3e68-4c8a-9a63-9eeacc0de113@redhat.com>
Date: Wed, 5 Mar 2025 14:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
 <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
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

Joao,

On 3/5/25 12:16, Joao Martins wrote:
> On 14/02/2025 13:05, Cédric Le Goater wrote:
>> +Kirti
>> +Joao
>>
>> On 2/13/25 22:45, Alex Williamson wrote:
>>>> +
>>>> +    /*
>>>> +     * Migration support
>>>> +     */
>>>> +    object_class_property_set_description(klass, /* 5.2 */
>>>> +                                          "x-pre-copy-dirty-page-tracking",
>>>> +                                          "Disable dirty pages tracking
>>>> during iterative phase");
>>>> +    object_class_property_set_description(klass, /* 9.1 */
>>>> +                                          "x-device-dirty-page-tracking",
>>>> +                                          "Disable device dirty page
>>>> tracking and use container-based dirty page tracking");
>>> These are really debug as well, right?  They just happen to be
>>> migration related debug.
>>
>> I suppose so. I would rather keep them under the migration topic
>> and add 'debug' in the comment.
>>
>> Changes :
>>
>>    commit bb0990d1740f ("vfio: Change default dirty pages tracking behavior
>> during migration")
>>    commit 30b916778517 ("vfio/common: Allow disabling device dirty page tracking")
>>
>> do not explicitly explain why these properties are useful in any way.
>>
>> Kirti, Joao, could you ?
> 
> Sorry for the extreme delay but I was out travelling for the past 3 weeks for
> vacation and work.
> 
> The property is marked as x- but my intent was both debug/testing and to have
> something that allows me to select the dirty tracker between device vs platform
> dirty tracker if something is wrong with say VF dirty tracker or if there's some
> limitations around it. These days we actually use it a lot as my default to have
> IOMMU dirty tracker in use. I wouldn't label it exclusively as '(debug)' just yet.
> 
> The precopy option might be to avoid dirty tracking at all and it's generally
> useful when you don't have dirty tracking at all or say snapshots or 'offline
> migration'. But I have never seen real use of it, or need for that matter,
> except the early days of VFIO migration during testing.

Could you please send a patch on top of :

   https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com/

This would be great to keep the information in the git history.

Thanks,

C.




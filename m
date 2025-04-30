Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A35EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACKK-00057u-E9; Wed, 30 Apr 2025 14:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACKI-00057T-IN
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACKG-0007PE-L9
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746038311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IFqAqkKEI3Tpf8qjbAFKolGaln5XItGf3jSuG0skgxM=;
 b=hEFgo8vOcINrQ1oU+rSA8mgihRcwWHON5eSlrrg30rlYUAV57yObnRWUfncSYNs7wubaBN
 m+bR9SveuPnX/vGuH8Yyxkzmj2iXX7LEUvejDdOfIfm99OQkE6dH54PrMvrxvQZk5E7+Tx
 HnFJsZ85R6u5xUDVnLgrngyGoFB+CRo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-P7tvekrENGKDPaAXLXekyw-1; Wed, 30 Apr 2025 14:38:26 -0400
X-MC-Unique: P7tvekrENGKDPaAXLXekyw-1
X-Mimecast-MFC-AGG-ID: P7tvekrENGKDPaAXLXekyw_1746038305
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac6ef2d1b7dso11943766b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038304; x=1746643104;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFqAqkKEI3Tpf8qjbAFKolGaln5XItGf3jSuG0skgxM=;
 b=kNa4ZxXnayv011vjcuAjL6b7yrtdKZhjHcceJh9xFov8wLe3Bkdu5w/SLHGRXcyITV
 wm5X+tajAoQ4VDI8aEXheGLbO5aPznvCVET/VQg2nEB/rAGqoYYkEN5DHXB8g4f/XsFj
 FT2MZYOXmUFWNrIiqPXRSbsEPVDlGGJRVqCyVYvtIFHRodQ4MovWpUTapiC8OCTxDfzi
 /aj6layLa+cU/UcmqCeXimY4Got9nlosgAK88zsFaAVcvbj/FMz8URmwkWueSZXotYDF
 N0NxW787tnMZux4DuFoTi/ErbKjwPFsLQV++xs9bTzcNpG5KrB3hpZ6m1pwk/b8Cwpn6
 q4sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ6I4uUoMKA0Z6Qtlw6p6egDJjMrcd/0ntgLqjB1GPTR5qH9G6LQVAw7PA6/NigB3H7ChCcgUn12N8@nongnu.org
X-Gm-Message-State: AOJu0Yyf5tDz3YOMTsopyotuVIc95hDTvdpHOpjJo2d7WcyVbaoRRQ8D
 9H6gjd9MhjXDBUTbvxXz/NxyFnej+qdtoXSp57pC3arB/0Ne3AifBduCuLEIx7QLKGgqj07/YaP
 JCcAVBMfmNuf8oiQDs5sJ89MlTDC4oNmzRfKR2ax4LwRxJYeRJOVa
X-Gm-Gg: ASbGnculmOup7kFph7cT1ZtLjszkcK9PeGowXkyku18eWelSlyApYd+9wQvIC5uxS2b
 2hmdDsaQL9WhOslMX7WsE4qJN1kP4bhSAc+xwzKZI1bepQyOAit/dhpkNJEcvYSuJMEMwxemezi
 3ONh3GtcVtiFhOgOfX9sPJwBXt2a1I7RvEV8DOGCkQVgwqueAbDVjS7Ezg0w8GRDwhli6RTn32g
 e7XOZCu6HMWFKwNIh0qQw5QQ+f8OhQWl8NVYwQOqxyaggz5XKXb90ovzF2ISGVoJRT42t2XDOcy
 VMf1aQ1OSirOSmsxqxZs+kdelTVNUi424jo9HZBH
X-Received: by 2002:a17:907:9724:b0:ac7:75ce:c91d with SMTP id
 a640c23a62f3a-acedc5dff06mr467691066b.15.1746038304510; 
 Wed, 30 Apr 2025 11:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqjX8cX2ZYCXZFvS0E5jcCtgifLgxlOqHJc6gxqyHtUfmhfB7BykRfX9k0UXECLgI6e0CdbA==
X-Received: by 2002:a17:907:9724:b0:ac7:75ce:c91d with SMTP id
 a640c23a62f3a-acedc5dff06mr467688966b.15.1746038304105; 
 Wed, 30 Apr 2025 11:38:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acec57bece2sm319791866b.10.2025.04.30.11.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:38:23 -0700 (PDT)
Message-ID: <ccc42584-bacb-49b4-bee6-fd5207f4ab79@redhat.com>
Date: Wed, 30 Apr 2025 20:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] include: Add a header to define host PCI MMIO
 functions
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-3-alifm@linux.ibm.com>
 <8decd67b-f1f7-4dcb-b2d5-519ea907e317@redhat.com>
 <e07375e3-6984-46aa-90b7-848594539f81@linux.ibm.com>
 <f632f551-b9c2-4474-9116-eaea3e2b4410@redhat.com>
 <12288279-df65-4869-84a3-b42ca47f9a7a@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <12288279-df65-4869-84a3-b42ca47f9a7a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/04/2025 20.32, Farhan Ali wrote:
> 
> On 4/30/2025 10:52 AM, Thomas Huth wrote:
>> On 30/04/2025 18.47, Farhan Ali wrote:
>>>
>>> ..snip...
>>>
>>>>> +static inline uint32_t host_pci_ldl_le_p(const void *ioaddr)
>>>>> +{
>>>>> +    uint32_t ret = 0;
>>>>> +#ifdef __s390x__
>>>>> +    ret = le32_to_cpu(s390x_pci_mmio_read_32(ioaddr));
>>>>> +#else
>>>>> +    ret = (uint32_t)ldl_le_p(ioaddr);
>>>>
>>>> This is the only spot where you used a cast. Is it necessary, or could 
>>>> it be omitted?
>>>
>>> Yes, the ldl_le_p returns an int. We do similar cast here https:// 
>>> github.com/qemu/qemu/blob/73d29ea2417b58ca55fba1aa468ba38e3607b583/ 
>>> include/ qemu/bswap.h#L416
>>
>> ... but that function there returns an 64-bit value, while you are 
>> assigning the value to a 32-bit variable here, and you also only return a 
>> 32-bit value from the function here. So there is no way that this could 
>> accidentally be sign-extended, could it?
>>
>>  Thomas
>>
>>
> I checked the Linux kernel and there too we seem to be returning unsigned 32 
> bit values (readl) for 32 bit mmio reads. So I think it should be safe. Do 
> you think we should remove the cast?

It looks redundant to me, so I'd vote to remove it, yes!

  Thomas



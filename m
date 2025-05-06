Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8D8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCD2M-00027Q-TI; Tue, 06 May 2025 03:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCD2M-000271-2n
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCD2K-00082d-0q
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746517697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1zBd31sCgeHkNh0b9k4v+ywNk65pkNh9qlED7tIfxW4=;
 b=BllXLHTykO/N4FrywwdTveeyh300iSaK4ide6dVrWI760dMbPLCNjd4NFf+MU0yPyLu03O
 NNyaeMl4yCsAM4Gz2EZ9GKZLvViULToeTnb4+2F55b30XQaIxB2v7YRbUECPv8qguPSMSI
 71a94ngRJMaBvvh3aW0jLkvS7b4L1Hc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-9LuoCu2hPfONhBC-5p6kAA-1; Tue, 06 May 2025 03:48:16 -0400
X-MC-Unique: 9LuoCu2hPfONhBC-5p6kAA-1
X-Mimecast-MFC-AGG-ID: 9LuoCu2hPfONhBC-5p6kAA_1746517695
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-440a4e2bad7so24284175e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 00:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746517695; x=1747122495;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zBd31sCgeHkNh0b9k4v+ywNk65pkNh9qlED7tIfxW4=;
 b=xJdKU+yeZ2i1K+qr6SrusHCe0AWUmxaQ0boGQjcZbERGNrMN1xmzJtI2iM6+WQGNDn
 PYl5PSpx2r55Q9mdrigyFqgqEZfPQXDqWz6/md6u5xwLoZoT3R9fa9Ap85dZIXU3+gjt
 xEO2h90Fp1wXng1REmEoqeVx6bqfXPAvxuZfa9YsMPbbbQRqxM0wtx3XjeUU4v4haAR+
 JSBrsvFSZLvXis4tgLDAnPpe7bNbZLPLcWpNsEiIs/MSSo5WLA/flK0kWl+plPun49tt
 aNl08ZZ4CLJRAj/WixXCZ7mUqhqh+BIqeRxRe2PwVAVknEI1NCQ3zJ3kpMmaSdFLbp4w
 xwVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBrrpLuNTu01rwcV/0OzZsIS6jS8DpMUVNcIGzSd8PACpqpt8RYZAwDpRhxg1FcQ0d5Sjg5RD3RXIy@nongnu.org
X-Gm-Message-State: AOJu0YyxV4+7p9ZloN1GDkw6U4LKUUMPMvLgKcmmCv0AMlUduwvKYm9/
 xT2L6e6uB0AZ1kd5VSTgOqDwb/DZJCynXPymN4KlFMUJxpklJnA+8aLGh89Pw7ZwhghoU1ktdrA
 H07ir5mKyAT/fbTsj4t3XCV+qpdVvuEKDTM6FnM99dD6YjKf0z/oF
X-Gm-Gg: ASbGncvw2dDJEvu25GXJGSWpVUG9rbNVfxU8KB/bmgCuKf1xIeP0x3SFE1YZKmkrG7C
 ZpvGLRuHU2tRIsPk/D3L4JjPirNuaAPM3g5cAmRX5lJ2SnDYDiyhcsHITOAF79k1lNTmwyFdBuD
 lDPh8LIjh4ANTW9D4wsJz7v6TC8GNDI0iWB07WPf/H4c7/GwjxjGBlht5+G/SzxtdgqZWTDigWh
 BS1drHOykmsgR26+sPntclEwrsKPCldiDUTCqjsh3f+BWnnAq0LmM6Pqcw//nEn+tbWAGpsn46N
 8CGHxeHB6x+g9H8uyvL2xqMmuML8uBZ1yvxu8vC/yspq0rtnBuyP
X-Received: by 2002:a05:600c:c04b:10b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-441d00fb871mr12349865e9.15.1746517695239; 
 Tue, 06 May 2025 00:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBPhAg29xrnMCpmMkdO6Hyto/V6a7UyxYzDcsV8bkQ6VZ/Bx6VavnqM0f2hgxiLzMRa9eReQ==
X-Received: by 2002:a05:600c:c04b:10b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-441d00fb871mr12349765e9.15.1746517694862; 
 Tue, 06 May 2025 00:48:14 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d1266624sm8505395e9.2.2025.05.06.00.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 00:48:14 -0700 (PDT)
Message-ID: <5077ebbe-5a4d-4db5-8a1d-067d88244bfb@redhat.com>
Date: Tue, 6 May 2025 09:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>
References: <ad66ac925ff301a945ac1f56fc1d31cc@linux.ibm.com>
 <db6dbf5b1baf3a6ada04168ecf9fde24890cc1c1.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <db6dbf5b1baf3a6ada04168ecf9fde24890cc1c1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/05/2025 08.48, Nina Schoetterl-Glausch wrote:
> On Mon, 2025-05-05 at 08:55 +0200, Shalini Chellathurai Saroja wrote:
>> On 2025-04-28 11:22, Janis Schoetterl-Glausch wrote:
>>> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
>>>> Implement the Service-Call Logical Processor (SCLP) event
>>>> type Control-Program Identification (CPI) in QEMU. This
>>>> event is used to send CPI identifiers from the guest to the
>>>> host. The CPI identifiers are: system type, system name,
>>>> system level and sysplex name.
>>>>
>>>> System type: operating system of the guest (e.g. "LINUX").
>>>> System name: user configurable name of the guest (e.g. "TESTVM").
>>>> System level: distribution and kernel version, if the system type is
>>>> Linux
>>>> (e.g. 0x50e00).
>>>> Sysplex name: name of the cluster which the guest belongs to (if any)
>>>> (e.g. "PLEX").
>>>>
>>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   hw/s390x/event-facility.c         |  2 +
>>>>   hw/s390x/meson.build              |  1 +
>>>>   hw/s390x/s390-virtio-ccw.c        | 14 +++++
>>>>   hw/s390x/sclpcpi.c                | 92
>>>> +++++++++++++++++++++++++++++++
>>>>   include/hw/s390x/event-facility.h | 13 +++++
>>>>   5 files changed, 122 insertions(+)
>>>>   create mode 100644 hw/s390x/sclpcpi.c
>>>>
>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>> index 2b0332c20e..60237b8581 100644
>>>> --- a/hw/s390x/event-facility.c
>>>> +++ b/hw/s390x/event-facility.c
> 
> [...]
> 
>> It is possible to add the identifiers directly as the properties of
>> sclpcpi (eg. system type as shown below) and remove the
>> control-program-id.
> 
> This is what I meant, drop it from qom.
>>
>> virsh # qemu-monitor-command vm --pretty
>> '{"execute":"qom-list","arguments": {"path":
>> "/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
>> {
>>     "return": [
>>       {
>>         "name": "type",
>>         "type": "string"
>>       },
>>       {
>>         "name": "parent_bus",
>>         "type": "link<bus>"
>>       },
>>       {
>>         "name": "realized",
>>         "type": "bool"
>>       },
>>       {
>>         "name": "hotplugged",
>>         "type": "bool"
>>       },
>>       {
>>         "name": "hotpluggable",
>>         "type": "bool"
>>       },
>>       {
>>         "name": "system_type",
>>         "type": "string"
>>       },
>>       {
>>         "name": "control-program-id",
>>         "type": "S390ControlProgramId"
>>       }
>>     ],
>>     "id": "libvirt-16"
>> }
>>
>> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
>> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
>> "property":"system_type"}}'
>> {
>>     "return": "LINUX   ",
>>     "id": "libvirt-17"
>> }
>>
>> However, Hendrik Brückner suggested to group the identifiers together
>> during the initial discussion of this line item. So, I would prefer to
> 
> They are grouped together under "sclpcpi", no?
> 
>> leave this as it is. Please let me know if you still think otherwise.
> 
> I don't have a strong opinion on this, just wanted to mention it and see what other people say.

I guess it mostly depends on whether there are future plans for using the 
QOM type elsewhere. If this type is supposed to be used in other QAPI calls 
in the future, it makes sense to keep it separate now. If there are no such 
plans, it's maybe easier to integrate the values into sclpcpi directly. 
Hendrik, any opinion from your side?

  Thomas



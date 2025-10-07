Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA1CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EUs-0005y9-4h; Tue, 07 Oct 2025 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6EUp-0005uV-JE
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6EUl-0002j3-8b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759869667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DXDXRhtHvWsLs04AlkuIS1BUBULhGvS0mBbRInPHYZ0=;
 b=B6pu7GlLMfewyAgKzjMeyRfucd6Bt6krYd+40qBsRzub0EhA1deqOwkUbU0TEbqmD3+Syn
 DyUZATvcGXolHBKHqveUVuwaInqbxkA1Cw+mDE7J9IlFqcFlyk4Lsvj5kb9f79S6288etF
 DKf9eNXGGIkFYivEE6uRId57HlsUpw8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-bFeEo44YNuifTv8G6i0Qbw-1; Tue, 07 Oct 2025 16:41:06 -0400
X-MC-Unique: bFeEo44YNuifTv8G6i0Qbw-1
X-Mimecast-MFC-AGG-ID: bFeEo44YNuifTv8G6i0Qbw_1759869665
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3d43bbc7so25978705e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 13:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759869665; x=1760474465;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXDXRhtHvWsLs04AlkuIS1BUBULhGvS0mBbRInPHYZ0=;
 b=GXDPoc0w6T3lQsy8ODbJ0UsXCu11yZAkd6BpeMdcLAa64RWZHGd6BgUR80SUB4ehQT
 Cp8xbWJB0yn6LfwuHdeFgl+EGlT3Y8Z1NNquSEvvJ5x7H7TqDUSa2rsmltiZ+ZCkZ16n
 /7U6tFych/ZkoUPrbdOpstVr84T/k+Fpnqe8itb5WPP034nGbYiFY/50/rN46+xzvimT
 ADon3sy4F9Hr/AsVP8QQvcMnX2KdakQsc9bMxjg52g/1MoMnm6p6/uNnww1RloasMTov
 Jss/aq6VugG6BQv+ggtFDhD3EUvWJN1UOw65UWxkdpfRlUAF5IXAhyoQWfoT3JD5oTwM
 LDPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkIlKqzEJ3zO+iyXl/LdaV7YiISXZKZLgOEtWoahKlkQWEFcSg4N2Q2x9iYcmyLIHVObSTObm1mzva@nongnu.org
X-Gm-Message-State: AOJu0YxLhH5/zsK2hAFV7A0+pQ8tBUXejRyfMcF6WYVp2Z0uHy0zZiur
 4HTorJ8rRftXrfaBdWQ+MqYSD8RhtVtBgjr0JfiuRs+58MV6rpvgedthJO6porLAh6ZjLP5Oggg
 XTVY581sVd+nZAFigZHpTBAvj/ls9kuTZnrrcbrmlsl77BrIQX1ZvA54e
X-Gm-Gg: ASbGncv63FOR7ZegZTd+JPNKockRslLyTnU0zFx+thjYnnrIW0PAMf0FIz3uG436DEF
 X+TP/ypODfRua5csZrlvqMHs4DxD816gkUzN/bKOthXYYS8sqYOuUXymosLwGowM7ApB0dFN6VX
 2Y9hTccWfOqMxg1/rQRe2U32TAdr1n6uEZVa+Jyn6GnLs4pZfJPFnta4Vx5sGkFKwnFxGRnWsBD
 4ILgEvPl9oSJjPtLA2eHsxd0ToZhW9WqXWs3cVOBkibDppJzn3MFpm9tLpgk0JpmJMC72azZm6m
 yQyNm4ZW+YMMxNJaw71mntCzVi6Eca01148c5sgG5F3EJJ69vLJrxPxHcZ55/NlH4TuGXz5n3Yi
 ZjaszMn0/
X-Received: by 2002:a05:600c:8b16:b0:46e:4004:a296 with SMTP id
 5b1f17b1804b1-46fa9a965a9mr7450985e9.9.1759869664994; 
 Tue, 07 Oct 2025 13:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW67syV7a2se0zUX4BcokjiHsBOFU8zmIKwsvj/qJYapLy4DGt6CCmPDXBzRMkhZGuPdZShg==
X-Received: by 2002:a05:600c:8b16:b0:46e:4004:a296 with SMTP id
 5b1f17b1804b1-46fa9a965a9mr7450845e9.9.1759869664622; 
 Tue, 07 Oct 2025 13:41:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf7f80sm8143435e9.1.2025.10.07.13.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 13:41:03 -0700 (PDT)
Message-ID: <5c394db1-221d-4a87-a1d6-6782056c54ea@redhat.com>
Date: Tue, 7 Oct 2025 22:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Joao Martins <joao.m.martins@oracle.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, Ankit.Soni@amd.com,
 ethan.milon@eviden.com, boris.ostrovsky@oracle.com, qemu-devel@nongnu.org
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <505e04a7-ebd6-47a2-b4bd-02b1164d841b@redhat.com>
 <8e48a225-6ea7-4aeb-8f8a-58955d113319@oracle.com>
 <c1db7b86-bdfa-40e6-8713-a0c5bfde81de@redhat.com>
 <08ce5d66-a644-44bc-9165-b46ac618545b@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <08ce5d66-a644-44bc-9165-b46ac618545b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/7/25 21:04, Joao Martins wrote:
> On 07/10/2025 06:45, Cédric Le Goater wrote:
>> Hello,
>>
>> On 10/6/25 20:44, Alejandro Jimenez wrote:
>>> Hi Cédric,
>>>
>>> On 10/6/25 12:07 PM, Cédric Le Goater wrote:
>>>> Hello Alejandro,
>>>>
>>>> On 9/19/25 23:34, Alejandro Jimenez wrote:
>>>
>>> [...]
>>>
>>>>
>>>>
>>>> The current status of AMD-Vi Emulation in MAINTAINERS is Orphan.
>>>> Since this series is about to be merged, should AMD-Vi be considered
>>>> maintained now ?
>>>
>>> It should be considered maintained.
>>
>> Great :)
>>>> and if so by whom ?
>>>>
>>>
>>> I volunteer as maintainer. Assuming no objections from the community, I will
>>> send a follow up patch updating MAINTAINERS.
>>
>> Thanks.
>>> If there are additional suggestions/volunteers for co-maintainers, please
>>> reply to this thread and I'll include them on the patch.
>> This series includes a co-author who would make an excellent reviewer !
>>
> 
> Heh, I wasn't sure you were talking about me or Sairaj but FWIW: while I know
> some things here and there, I am not nearly as deep into AMD-VI as Alejandro and
> Sairaj. Hence why I haven't voluntereed :)
We don't have a cap on the number of maintainers or reviewers :)
   
It would be helpful to add someone responsible for handling PRs.

Thanks,

C.



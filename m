Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A01DE7718D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 18:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPnD6-00031S-Fr; Mon, 23 Dec 2024 13:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tPnD5-00031B-0l
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 13:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tPnD1-0003T2-Ru
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 13:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734978673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YJ9YQAFDJKmiAYbozMueHPDV4q/Iopr44666HqPxaAA=;
 b=BydpR7XfrkzsffLh0DEkvOh2zS1Ote3Z+NaLSpxW0jcozaH0M3MTgvK5e5jltUV3EEZUtX
 GbfDwRuMNbUiYxItLkWtYGiEt7Tx/F9KBa+Y1JDFo7cZ4Z3QqobRpvp4HGjAVjS9xQcdEq
 qVvXw5ZCsRbH+XQdoEdG/HYKkmQEiE8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-wJwIVXcHOm-0RI8ExSA1GQ-1; Mon, 23 Dec 2024 13:31:10 -0500
X-MC-Unique: wJwIVXcHOm-0RI8ExSA1GQ-1
X-Mimecast-MFC-AGG-ID: wJwIVXcHOm-0RI8ExSA1GQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f943f5abso812512385a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 10:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734978669; x=1735583469;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ9YQAFDJKmiAYbozMueHPDV4q/Iopr44666HqPxaAA=;
 b=Y74fRk6hq3t9QspQVbcYpgfAdUZP4Q8PU1zE2j+m+AVltJj0kGDI7msYvD8DjKEuE/
 gOJ4KwrPhveKKszoF6LaZW/zlp27a5W/97L5owkHy647ubnO17J+F4uV5UDwQFm4QWNT
 /3MYLQSATKavKTaj4NV4bCE3xMJSlgmOuBBU9DmHlFGMfyPh/S9hA/mOaWCMjLcxr0XN
 FUtTFwA3W+STIeOQ6DS+3lRSTZmOwI0NGG4E3rMxJy3uw87EsGWzz2h6b1y55UmW5muc
 5Mbmc9h+yVsxYu8TUvUo2AMpUzMTgBI9A9PVU1CTKey2f2H2HrDvpp8UQ3VevsTaNwxO
 XTEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7wUQ/3Skar43v86Gg3ivUpO+a5eLvr0xLswR5hW3sMpc5+qduOAY0zRl6JmN08hf1PoArCZLvQUDD@nongnu.org
X-Gm-Message-State: AOJu0YyMlWUXGmci8VMl/k337Dh1TxDQKD9wlYDp+sWjWpix35D4cx5n
 7CGPUartT2rLtVXBXaxvik948mtvqsj4PWN2CD4Awuf4+YRMvDrklSmEcmmo6PafhXsz8zOqJJc
 7+pfSkFnJxVyREBHGlakqHMwHsrIzHh1V46b423rjrakkKx8PgRSi
X-Gm-Gg: ASbGnct5/7FCSu0MC6Z88T1jN8DYxGkigMeF6uj7BPNHCzDzX5QmVrD+Dsp2wKl9/78
 lSHN9H8tbU3mYegruSD9ZDkmmQkwbAXStVpy7HMQymhAgPzxhhtWaCn+xGyVlp+NJbtxyWtKrmv
 Oxr003044VXj5zBkz293Q/IVX/M367us6bUxFiTnGdRI2xpKUNLlo98TAeEcTj1jKW89xhDg0/n
 3j+O60rIqjyw2n7hAMSprNrPmPVqqDIW1dDOn+XibWlgDKuYDrO3KchRjS6gFeWs0zjLXpRj29/
 vbgYnx0mPc58Me6L
X-Received: by 2002:a05:620a:2447:b0:7b6:da21:7531 with SMTP id
 af79cd13be357-7b9ba717e7amr2154092485a.4.1734978669667; 
 Mon, 23 Dec 2024 10:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa3flcpOmdvgM2FbXw6dm7UNowo26+thQsiNKsOI0qExxETSV6AZDufOmqtJWBo5uGpiex8A==
X-Received: by 2002:a05:620a:2447:b0:7b6:da21:7531 with SMTP id
 af79cd13be357-7b9ba717e7amr2154088385a.4.1734978669290; 
 Mon, 23 Dec 2024 10:31:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cf7fsm46019451cf.5.2024.12.23.10.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 10:31:08 -0800 (PST)
Message-ID: <71295cc6-794d-4fed-a1c8-6c1a1ab98933@redhat.com>
Date: Mon, 23 Dec 2024 19:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <cc96d3e7-4362-461f-8398-bea956b22d73@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cc96d3e7-4362-461f-8398-bea956b22d73@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/23/24 18:55, Joao Martins wrote:
> On 18/12/2024 13:40, Avihai Horon wrote:
>> Hello,
>>
>> This follows up on Peter's series [1] to simplify migration status API
>> to a single migration_is_running() function.
>>
>> Peter's series tried to drop migration_is_device() and
>> migration_is_active(), however VFIO used them to check if dirty page
>> tracking has been started in order to avoid errors in log sync, so they
>> couldn't simply be dropped without some preliminary cleanups.
>>
>> This series handles these preliminary cleanups and eventually drops
>> migration_is_device() and unexports migration_is_active().
>>
>> The series has been migration tested with the following:
>> - VFIO device dirty tracking.
>> - Legacy VFIO iommu dirty tracking.
>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>    currently blocked, so I used a patched QEMU to allow it).
>>
>> I also tested calc-dirty-rate as now VFIO dirty pages should be included
>> in its report, and indeed they are.
>>
>> I didn't test it with iommu DPT as I don't have access to such HW.
>> It would be great if someone with the proper HW could test it.
>>
> FWIW tested iommufd DPT (migration and calc-dirty-rate) on said compatible
> hardware (Milan hardware). Things look to be working as expected.

Could we have a Tested-by tag then ?

> I deferred
> vIOMMU IOMMUFD DPT testing to my own follow-up once I am back from vacation.
> 
> Thanks for fixing calc-dirty-rate along the way your cleanup!


Thanks,

C.




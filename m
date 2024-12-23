Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F74AE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 19:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPnve-00045H-Pf; Mon, 23 Dec 2024 14:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tPnva-00044Z-GD
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 14:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tPnvY-0001e8-HC
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 14:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734981434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GSajRNSwQZPwf0Ee9c8fVuideypaMnDfBwYTdiva1Fw=;
 b=eVn4pRlkOfa+gTmTbjPOl9E2osHam74dfsPhZRmvlUn8gNsQx1tpw/G0ds86LWNr5M3J2p
 S3QcK/cDf9tDf8eKQTm1nAJSKaPWdKPMUxyagLNw17BgWg4CxkYY9dZELw2Z8EcAdwBQkV
 yb9O48zGz5gqe/igjUSiWFpSCs9wPSc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-J8D1b-q4NU2nKRxwB1KFdw-1; Mon, 23 Dec 2024 14:17:11 -0500
X-MC-Unique: J8D1b-q4NU2nKRxwB1KFdw-1
X-Mimecast-MFC-AGG-ID: J8D1b-q4NU2nKRxwB1KFdw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b35758d690so846151585a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 11:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734981430; x=1735586230;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSajRNSwQZPwf0Ee9c8fVuideypaMnDfBwYTdiva1Fw=;
 b=IN9Z/2ct4ZHJk4hwFy6n3KYhRN7TAau1wtqC4XDhFOuTdv7tlGo1M69BwXfbLLEPPt
 UcfqJNrwxmgTTJjoa/DxzowqTbJiENlY8z8ELSG+BTcxzdhNgVjR+l5DzQy+NOkXr6+A
 NYKu+2iQgx4I1AiH1cs2haQ8mSjTFCjvc848BT7qyWMAi/frPs5Arwn8SJkRlWbZuGv2
 o3c9ZsDIjBAbvzr9VIMeKs3kFsDz8WGGj9ZIuhK/u6vOP/hobMSceEtJUuGADCd3FDcX
 fRoCH1wSGKhVT8SPjNsWTBERVBFs3LCFHjOiX4ffptMbu9fMXfgPSGalwXzkWMg7Yosb
 WnuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAooAKKSeeYVa+1Sd2wFD5M+9qiLB3qaw22GZuU0s7Phq29IhFNylkRDd5vmT2WH/1whWfOCdbg9Gs@nongnu.org
X-Gm-Message-State: AOJu0Yx7mXisvqmOAw6pZe5DlhGP+OLp1gK1f216o7+80MvMQSemXJst
 Fny3sxq2vHrOsYB4wjWPeRC0pXtRRWr1cVxKvOTw5JQ3RbBh5X7Ln0vn7bpFxX99nG3NydYg5JG
 hn0kB7UeCChjRypQwBEnvwHk5IU7fe1FOzOO9+cXobM6o3s86HjRS
X-Gm-Gg: ASbGncvs01xEs10zICh1CdpQZuo6BO/UTFCBF14cV5NPAr5Chm6d62dVeyaRyL0QR8y
 Iy4nEr6ius53sfa0LoAOW9Qa+q7FfCvWv0h1MxpdAbCo5qpg3iFMiH23d1eSIauDQFfrmlkBrye
 3UgRi/sRmLH/QS0dxnyBfu+1avC2Hevs8Vaut3ZIiY5vBOY3f2UWvtPpHTt069Tfk8aD/fDPOSi
 pwPK86H0zdgt7SXNKuDCWhkh4QCg3nkBrIanVKwOcwOHmK11TWiFs0guxULG0VALWfIndoJprzZ
 MV3Ma8zxAh4iCZeS
X-Received: by 2002:a05:620a:248e:b0:7b6:e510:1de8 with SMTP id
 af79cd13be357-7b9ba7ade80mr2026098185a.33.1734981430507; 
 Mon, 23 Dec 2024 11:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfQH3CTWmJ9q9/3zlMnr5aJtoOzyEvY/col2rOwENsQi1pbionUi/oJF8Sj0/+gMOmXMgNOg==
X-Received: by 2002:a05:620a:248e:b0:7b6:e510:1de8 with SMTP id
 af79cd13be357-7b9ba7ade80mr2026096285a.33.1734981430183; 
 Mon, 23 Dec 2024 11:17:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480943sm405817485a.89.2024.12.23.11.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 11:17:09 -0800 (PST)
Message-ID: <18545a71-af9f-4cff-93e6-3273c44b68f9@redhat.com>
Date: Mon, 23 Dec 2024 20:17:07 +0100
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
 <71295cc6-794d-4fed-a1c8-6c1a1ab98933@redhat.com>
 <f7a9be5f-2925-450b-a97e-cbe4f3adfef6@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <f7a9be5f-2925-450b-a97e-cbe4f3adfef6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 12/23/24 19:43, Joao Martins wrote:
> On 23/12/2024 18:31, Cédric Le Goater wrote:
>> On 12/23/24 18:55, Joao Martins wrote:
>>> On 18/12/2024 13:40, Avihai Horon wrote:
>>>> Hello,
>>>>
>>>> This follows up on Peter's series [1] to simplify migration status API
>>>> to a single migration_is_running() function.
>>>>
>>>> Peter's series tried to drop migration_is_device() and
>>>> migration_is_active(), however VFIO used them to check if dirty page
>>>> tracking has been started in order to avoid errors in log sync, so they
>>>> couldn't simply be dropped without some preliminary cleanups.
>>>>
>>>> This series handles these preliminary cleanups and eventually drops
>>>> migration_is_device() and unexports migration_is_active().
>>>>
>>>> The series has been migration tested with the following:
>>>> - VFIO device dirty tracking.
>>>> - Legacy VFIO iommu dirty tracking.
>>>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>>>     currently blocked, so I used a patched QEMU to allow it).
>>>>
>>>> I also tested calc-dirty-rate as now VFIO dirty pages should be included
>>>> in its report, and indeed they are.
>>>>
>>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>>> It would be great if someone with the proper HW could test it.
>>>>
>>> FWIW tested iommufd DPT (migration and calc-dirty-rate) on said compatible
>>> hardware (Milan hardware). Things look to be working as expected.
>>
>> Could we have a Tested-by tag then ?
>>
> 
> Yes:
> 
> 	Tested-by: Joao Martins <joao.m.martins@oracle.com>
> 

Applied to vfio-next.

Thanks,

C.




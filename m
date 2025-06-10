Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36839C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2dC-0006Nb-41; Tue, 10 Jun 2025 13:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uP2d9-0006NO-Pi
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uP2d8-0000b4-0C
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749575960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AFFKncku69hO0rRO29FKwQD8s3wGsZQz1kP1UdrCS5s=;
 b=ehTTSeyIaMdsurrWv6EOcdp24iUNcOtSrrcVotc9V1aOvnqoPPeky+ZF7dmMw1WgF0uJv3
 hgl2+llf4jJ/vanlKhaPMgY7REAGvbJofm4SHUdRVV26ZNVAkETjyYPcIzpT5UunCnRjgP
 vZCfeSmciz62yHDS04PRx4WUGwxnBbM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-qOeiYV84NM6qmRs1U4Ss-w-1; Tue, 10 Jun 2025 13:19:18 -0400
X-MC-Unique: qOeiYV84NM6qmRs1U4Ss-w-1
X-Mimecast-MFC-AGG-ID: qOeiYV84NM6qmRs1U4Ss-w_1749575957
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so2735439f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 10:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749575957; x=1750180757;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFFKncku69hO0rRO29FKwQD8s3wGsZQz1kP1UdrCS5s=;
 b=KEKAMP4FSRu+YYVRvq5gInaNgw0cf7McnQnKnFkAN1VQfrBrHfitCnonOFTtGyd4LO
 fqwQdV52xaPcNxQqHYBpvUrOb7fDeDXRTX0qvRlonJpRItgZhocayKAFYuhnHFkG1OOH
 K+79lhPaLI6F85vWtTr9b1FilpgBxGmvnxWaNW81yTER/IewpydUl5iPpLb6Jmk2D3hI
 ZJ1TGdZ3wk8z1TuqNbucJDscePotMtXtyG1FvNMGrt4QtnTizKMBqgJcnTio/wroG25d
 ip8sNmmFhNzrK5TtGHS26PStRUSdrLku9MEoEWMw4w/ho0DL6yPeDCrmQJx2uilC7EDS
 O2YA==
X-Gm-Message-State: AOJu0YzTCyKU30HmpoYJeaf5Q+tzKgf2IEq9tMQ6B3o78XFqmGEuPLjH
 +gR9lsWSP9yX4qcBmjW03Te9Qm62eyyGfYldrjXHMHl3doafVq4eGZkURpWPWXTUHl4EENa/K+C
 Bi8HcvDm7ahtm+sniBYUawBB0rL1zYOFv/A+jMsEkFxpn/dLuiDqBDEOq
X-Gm-Gg: ASbGnctpZFV3SHoMdIv7oPwvvpcoxpH2RFwRhAY7iKjeydmfL2p7xE7V9jwDgQaQzov
 3ENNzSwW1aY8EBcltVccrkDe7Zt+jf/22YtEmBu4SgXkZ0kQaT9dv/jgaChBbF0eItUPf8pCAxw
 Cun2ln/Jvw13AX2td6VJYnDg8ziKi4MtbHjxXPkE6nfc+j8GptmxrKtQLxGKQSce3sLnrbYApA1
 cX9/dQK9U+2BQnePkLUfR9/L3pwyfjjGy6Iv2o12964e+NvfQxchPOJYCQUHUeChFsp38IiPP7u
 iGjnwVECpWecNJF+NDd7y3haiQDr9IxK0nK8nb4QwihYtCCsBfE01u/DgdSH
X-Received: by 2002:a05:6000:310e:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a531cadb5amr15108858f8f.39.1749575956684; 
 Tue, 10 Jun 2025 10:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD3IGZVhBApZtbjAwUgdh5l+9zudqoMR7vQ9doYhYPqCEFJxYnBcuB1blW/xYloAbMazPz6A==
X-Received: by 2002:a05:6000:310e:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a531cadb5amr15108845f8f.39.1749575956294; 
 Tue, 10 Jun 2025 10:19:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53243688asm13164945f8f.57.2025.06.10.10.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 10:19:15 -0700 (PDT)
Message-ID: <1ac290ea-e91f-4d96-bdd1-3375986d84c9@redhat.com>
Date: Tue, 10 Jun 2025 19:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: Steven Sistare <steven.sistare@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
 <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
 <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
 <20250610122246-mutt-send-email-mst@kernel.org>
 <6354f3a8-6309-495a-9014-6f5243a7785e@oracle.com>
 <296d0933-3f77-48f4-9096-8bd358aae617@redhat.com>
 <c629f838-9a2c-44b7-b300-b8a6f42e5588@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c629f838-9a2c-44b7-b300-b8a6f42e5588@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/10/25 19:14, Steven Sistare wrote:
> On 6/10/2025 1:11 PM, Cédric Le Goater wrote:
>> On 6/10/25 19:05, Steven Sistare wrote:
>>> On 6/10/2025 12:31 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Jun 04, 2025 at 03:48:40PM +0200, Cédric Le Goater wrote:
>>>>>> I don't see any advantage to making this a class attribute.  I looked for examples
>>>>>> of using such attributes for vfio to configure pci, and found very little.  It
>>>>>> sounds like overkill since vfio already sets and gets PCIDevice members directly
>>>>>> in many places.
>>>>>>
>>>>>> I defined skip_reset_on_cpr based on this existing example:
>>>>>>
>>>>>> vfio_instance_init()
>>>>>>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS
>>>>>
>>>>> pci_dev->cap_present can be modified at realize time. skip_reset_on_cpr
>>>>> is a constant, for which a class attribute are more appropriate.
>>>>> This is minor.
>>>>>
>>>>> Michael,
>>>>>
>>>>>    Are you ok with the 'skip_reset_on_cpr' bool ?
>>>>
>>>> Generally yes, but maybe cap_present bit is even cleaner?
>>>> vfio already pokes at it, and we have history of encoding
>>>> quirks there, see QEMU_PCIE_LNKSTA_DLLLA_BITNR for example.
>>>
>>> Sure, I can send a new version based on a cap_present bit QEMU_PCI_SKIP_RESET_ON_CPR.
>>
>> Please send an update of patch "pci: skip reset during cpr" in the v5 series.
>> Hopefully it will apply cleanly.
> 
> Please clarify: do you want me to send a delta that applies on top of the
> old patch, or send a new version of the old patch?

a new version of the patch.

Thanks,

C.




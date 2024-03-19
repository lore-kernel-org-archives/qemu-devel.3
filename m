Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B395C54F61
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmajv-0003B4-0K; Tue, 19 Mar 2024 10:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmajr-00039E-9P
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmajo-0002wx-D6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710859607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pg3bEqWaGPDiVK7AGI9rlO9rVjF8l0P792zDm6Wf9fA=;
 b=Yd70AS1UvaSfI0XaI6Qo0yDJQKj4+EKprVTb/tMhtu3uDdTqGX+V2udaXwKS6xfvrkpQKh
 cdlf4B23M0MfJcCarKEEMpquDl1TyK58TgGDieh2B3KLu7Ihqzvz3LG9kcRDpXp22nODFZ
 oTAbeQtJMBJ2NXyw15NW9pkSoguoaag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-eaCTaT49PGG_wZBg8s3zHw-1; Tue, 19 Mar 2024 10:46:46 -0400
X-MC-Unique: eaCTaT49PGG_wZBg8s3zHw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3418f237c0bso162809f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859604; x=1711464404;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pg3bEqWaGPDiVK7AGI9rlO9rVjF8l0P792zDm6Wf9fA=;
 b=ok9BQp7b/BFHOjMvrPzt99vRNcDUN3qh30uOJtGV73xnaAIYM4wJE9a7QGTkajGZ7h
 rapaSOCl4cnr+kNBD2lkqZCx4XIAx+ALncqTW3zlS83KP1re82HZuQ84tRdPOxMOXf/n
 GYtRYWq7Ec86LICe3SHZjNDlMYDEjkl/pZkHZtX8pwd/79HbXxt66Q++LzMvlqjdJPEg
 +BZV/j37GZVHbjXC5keWdPSLn3ZPqlwXu7FuRudoHPO3kbQeGXqQnzwhl8M1gX45fE7i
 OEtb9028unI5PBsQKDqUfd67onV6XZQBDUVWphqC8tJynT/YcU457m3VaU3a0npn8hYg
 VHxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdKPtm7n13i2A17VeP4trFVOxiNzhnF4H9n7onOeojfQkpmmhMjhvU/zIj7MJtHsfgxmh6KH5m0SCTLneNpGP05tGbYlg=
X-Gm-Message-State: AOJu0YyJPBKMoIv8FdVYIgwuM+JpkQa4no2yHbsBwpb2vHoE9pX0QCkD
 39lN6FnpfdczqNFfRazQhfdP9dFAsgyZOw55pSywcco/WcISrBPgrbuUTXAKk0judam3PQ+vyfF
 7boh3l4SHLtPPBOf8v8g7CD+3d8+DvkK+wk8QH4m6S9nS3XeIKFDy
X-Received: by 2002:adf:f3d2:0:b0:33d:b376:8a07 with SMTP id
 g18-20020adff3d2000000b0033db3768a07mr9197397wrp.8.1710859603797; 
 Tue, 19 Mar 2024 07:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaweO/L0aqdh91ulpjZC7pAIatW7kZ3rki8b+KAY9zpnS4lyKdgCIWFfQi7PeKQnkXwdm/4A==
X-Received: by 2002:adf:f3d2:0:b0:33d:b376:8a07 with SMTP id
 g18-20020adff3d2000000b0033db3768a07mr9197381wrp.8.1710859603432; 
 Tue, 19 Mar 2024 07:46:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f?
 (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de.
 [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
 by smtp.gmail.com with ESMTPSA id
 bp6-20020a5d5a86000000b0033ecb329f15sm12608923wrb.9.2024.03.19.07.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 07:46:43 -0700 (PDT)
Message-ID: <319276f5-5f29-43df-a36f-c2264b3a6021@redhat.com>
Date: Tue, 19 Mar 2024 15:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYxIDEvMl0gc3lzdGVtL2NwdXM6IEZp?=
 =?UTF-8?Q?x_pause=5Fall=5Fvcpus=28=29_under_concurrent_environment?=
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: zhukeqian <zhukeqian1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
 yuzenghui <yuzenghui@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-2-zhukeqian1@huawei.com>
 <4d7795bb-1dfa-40e7-a98e-4c0bafdf3db0@redhat.com>
 <7387988008764735b2f1dd5f2c83a45a@huawei.com>
 <7cc3c19c-00f0-4ad2-b0de-ba42e9b20c2a@redhat.com>
 <CAFEAcA9iBPBvZ-9cFVRdAJaFPZmPK3adn10v2LiS90+1iUzwXA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA9iBPBvZ-9cFVRdAJaFPZmPK3adn10v2LiS90+1iUzwXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19.03.24 15:23, Peter Maydell wrote:
> On Tue, 19 Mar 2024 at 09:24, David Hildenbrand <david@redhat.com> wrote:
>> I spotted new pause_all_vcpus() / resume_all_vcpus() calls in hw/intc/arm_gicv3_kvm.c and
>> thought they would be the problematic bit.
>>
>> Yeah, that's going to be problematic. Further note that a lot of code does not expect
>> that the BQL is suddenly dropped.
> 
> Agreed; we already have one nasty set of bugs in the framebuffer
> devices because a function drops the BQL briefly:
> https://lore.kernel.org/qemu-devel/CAFEAcA9odnPo2LPip295Uztri7JfoVnQbkJ=Wn+k8dQneB_ynQ@mail.gmail.com/T/#u
> so let's avoid introducing any more of a similar kind.
> 
> Side note, the pause_all_vcpus()/resume_all_vcpus() calls in
> hw/i386/vapic.c are probably a bit suspect for similar reasons.

Exactly my thoughts. But there, it was less clear "why" it is even 
required. It's only performed for KVM.

Do we also just want to stop KVM threads from executing instructions?, 
so blocking KVM ioctls might be a reasonable "replacement"? Really not sure.

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8084C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVEVh-0000ad-GM; Wed, 31 Jan 2024 12:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVEVf-0000XZ-Kp
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVEVa-0005OK-GO
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706722580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOYwCGlmE+aFpCla/jeAufVBHiSRmPbxof+BsiBr4LA=;
 b=VKeWhucBShSIX6lkafXzevhvHllWazwzOxBJPfCMavQCtJAcus/Z/mgt2m9hF4b6XswVWj
 Fz/1wzFeahnhezvhKma5C1yQKq8aFyRqIHqB6rGHX+pbdqs4RpqxepbpGuX0w5Vk+flYt6
 5PuKvA0mBD5xzPK+EbIPZLzsj9wXif4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-aylc7KG1P6yuVC9OlJ6auw-1; Wed, 31 Jan 2024 12:36:18 -0500
X-MC-Unique: aylc7KG1P6yuVC9OlJ6auw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7853d5e3983so8803485a.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706722577; x=1707327377;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vOYwCGlmE+aFpCla/jeAufVBHiSRmPbxof+BsiBr4LA=;
 b=PpNuatQQFGGRuX4Ltdh9YFriy6MI2xzaGr6sn30/m1ou3fd2kmbngj6OLsI5Se+iDf
 s59khJbE5RRZpbUSKL5ux7sccwhqIcbX12x/moqcY6vuuh/i7Vda52MHrd2zNBC7kBle
 JccwWGBCV3b1aYui/oL7pCvP5iLv1kL4EF6lIjzwmrzL4TuM9Zl+Db4dkNcfHNaitjfA
 Htbso2hyUdDhUXmuPTx1DLctgtZrpN63/c/MMDeB6hzhhBZ2NdQVfAhLL8htKnCmGAgQ
 bKgydecGtUWMuwH2Nt5eMn3Jee4JsxfHvfpy52w4OsCGcH/9GapMLFl21SdBij1yJSUw
 /K/Q==
X-Gm-Message-State: AOJu0Yw7hJ4/79kJTAacZ+WPHK539w87kP0OY6Rgx5yPzxZnQQ7pUFdO
 UqiSF6FMlNZT6iA7d/mkp+weuOp+4vDKp+e8/o69PxzU395nbnL+YLxawBTyTcpZHtF+hPDhaRI
 znj5DhnApdbWOlBQex84DsrUFa+kb+zqC/X41Jr7OJBcAI9c3m5eq
X-Received: by 2002:a05:620a:16bb:b0:784:4e1:adc6 with SMTP id
 s27-20020a05620a16bb00b0078404e1adc6mr69266qkj.65.1706722577035; 
 Wed, 31 Jan 2024 09:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE9pwtDeMjbXOKoGXtzF2vB+RK9+J9qrCGdqe/2XZ/H2FDPIY1THRRIcV3IMsPoPTUGAVTXA==
X-Received: by 2002:a05:620a:16bb:b0:784:4e1:adc6 with SMTP id
 s27-20020a05620a16bb00b0078404e1adc6mr69245qkj.65.1706722576753; 
 Wed, 31 Jan 2024 09:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWXbn2poaUCSpiGOPjdC6oCsbtrdOOJpBP5QyxRVu4Ckpze57CtWD1ELteuk0cFuvr0fxCdRM1ska89f1I8jrva5Ov3PM+uozz9/QoC5r0l3wHwugWl5am9fTTnpl9kSt2Xnt685eycmSfB9oRVunuInEQFCP/tzVFI/OnxqxvF0+8q3JpahwSIlYEeS1VI9mBn4G5g5/jfkRoQ9z0RbknQrFZXNu8wB8HIX/7A0VVGWzhb8fH++4GnNmKMF2TTmXCbjfbIvLXj1RC0IHCL3/8apUJew2RLUrMP6UfFkL0cKzRH71mwtbeeWbcF4LWJkOanb2b1DUa7RGeXpsNdikV+ZO8R9mVbWUevEE81P+ACT+KIrjb9yCKR2V1xpyP7zeYFu5GjHA==
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 de42-20020a05620a372a00b00783f669dc18sm3373100qkb.118.2024.01.31.09.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 09:36:16 -0800 (PST)
Message-ID: <dd3c72e2-4e3a-4449-8c57-646df6783bef@redhat.com>
Date: Wed, 31 Jan 2024 18:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] buses: switch to 3-phase-reset
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <Za3NqdR2w_4bdIew@x1n> <a90cdc45-34bc-46fd-b9d6-4b13b6cfbe78@redhat.com>
In-Reply-To: <a90cdc45-34bc-46fd-b9d6-4b13b6cfbe78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/22/24 15:19, Cédric Le Goater wrote:
> Hello,
> 
> On 1/22/24 03:06, Peter Xu wrote:
>> Hi, Peter,
>>
>> On Fri, Jan 19, 2024 at 04:35:07PM +0000, Peter Maydell wrote:
>>> I wrote this ages ago and recently picked it back up because of a
>>> recent PCI related reset ordering problem noted by Peter Xu.  I'm not
>>> sure if this patchset is necessary as a part of fixing that ordering
>>> problem (it might even be possible now to have the intel_iommu device
>>> use 3-phase reset and put the relevant parts of its reset into the
>>> 'exit' phase), but either way we really ought to do this cleanup
>>> to reduce the amount of legacy/transitional handling we have.
>>
>> The VFIO issue I was working on may not directly benefit from this series
>> iiuc, as it's more of an special ordering on both (1) VFIO special case
>> reset path using qemu_register_reset(), and (2) VT-d device is not put at
>> the right place in the QOM hierachy [1].
>>
>> Said that, thanks a lot for posting the patches; they all look reasonable
>> and good cleanups to the reset infrastructure, afaict.
> 
> 
> Yes. I took the series in my vfio testing environment (x86_64 and s390x) and
> didn't see any issue. I will keep it for further testing.

Acked-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.





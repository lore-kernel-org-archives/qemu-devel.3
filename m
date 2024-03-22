Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019F5C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 07:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnZfE-0006wd-HO; Fri, 22 Mar 2024 03:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnZf1-0006vD-85
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 03:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnZey-0003rv-Nr
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 03:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711093791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzKLMicNWycf3oA0gDzmt2LQfjKd7VPVTIC6wfZR9HM=;
 b=HsQElxNikfu+rRpHJywBuMsgMhkisHuKlSO+gMIb7AtFNsN6Sg06e1N/9DN5ZAUJe3Mn9u
 OG017DeOjDpSjU70/o+T46W1/l5HsOm6NuPmQjc9Rx8twxRa9Zd1gnoJ7q5ajTmVU9pGVL
 6kQ00sSmzNfzcdk+leZC60fZy7PMG90=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-TtpxyKggORSRP95b_FcHuA-1; Fri, 22 Mar 2024 03:49:49 -0400
X-MC-Unique: TtpxyKggORSRP95b_FcHuA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d599dba7fbso17121021fa.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 00:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711093788; x=1711698588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzKLMicNWycf3oA0gDzmt2LQfjKd7VPVTIC6wfZR9HM=;
 b=JlC7YY+LxywiPLEzKDvdfy8WXSByWBf4TAhvJlIHy9JB5Th+LnTxZMSErYiq6eyVcu
 Im7oIo3RajuJ4AVN5RpWlT3S3qH63pc28BjfH4oawGVZRvARc1oSXhmhd1dxIYfEWbu4
 nKBvSup4K4FzHORMdHAQoz3iYWQ09AR2Fm7ABsUf46VnX+MckmvEcXlhGmiKnn7f8vrr
 lw/4MhyTsitg5WWT7N98OtqvtBfvDF/2BkPXJgGDkW/jZuzhqhUUHC7w9evoK37Ua3jg
 795wzHq43/CFrZPdKzie7L4DAvaDIwsmm+LLN5SVAX7kbk9TWufGvF7jq9wvMz76VWLw
 N+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTsLF7BZv2CQ1njazS8OfPWuq3SzZ76tgZEqYtFdNpliHeDkxbLqxivjfh7GuOZO+lm9fr3m7CfM75LYnYZ1jUlM6rksM=
X-Gm-Message-State: AOJu0YyiT9oXyxNEEuoxF9lcVp53Pu6eHcwNEdrEJGsO/mIKtNbD1CBa
 0btXrpTgQKgV0XmhXMxXeYUvkoWL8/WYoaxWo9cUPO54dxxdOjXroLwnmZQ2A+wILFkuiHn9HCM
 EyIsQOSAkgt0EZkJZQgEMn2hR2M2/MH6LetUs3mOPBsJHoL6vQp2C
X-Received: by 2002:a05:651c:1037:b0:2d4:5c0c:77db with SMTP id
 w23-20020a05651c103700b002d45c0c77dbmr1168477ljm.3.1711093788167; 
 Fri, 22 Mar 2024 00:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7pOG04qTd3uPYl515z+fQUyKyoBAMJREMLpX+OZdQxMr1aGZaHoxygHXJPMggas25EOLOXg==
X-Received: by 2002:a05:651c:1037:b0:2d4:5c0c:77db with SMTP id
 w23-20020a05651c103700b002d45c0c77dbmr1168469ljm.3.1711093787765; 
 Fri, 22 Mar 2024 00:49:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bp10-20020a5d5a8a000000b0033dedd63382sm1426285wrb.101.2024.03.22.00.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 00:49:47 -0700 (PDT)
Message-ID: <43de228d-0fa7-465e-b8bf-5bab08de2f0a@redhat.com>
Date: Fri, 22 Mar 2024 08:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc/pca9554: Fix check of pin range value in property
 accessors
Content-Language: en-US, fr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240321160154.901829-1-clg@redhat.com>
 <f74d141d-69aa-4d7a-8536-5378e4353db3@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f74d141d-69aa-4d7a-8536-5378e4353db3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/21/24 18:15, Philippe Mathieu-Daudé wrote:
> On 21/3/24 17:01, Cédric Le Goater wrote:
>> Coverity detected an "Integer handling" issue with the pin value :
>>
>>    In expression "state >> pin", right shifting "state" by more than 7
>>    bits always yields zero.  The shift amount, "pin", is as much as 8.
>>
>> In practice, this should not happen because the properties "pin8" and
>> above are not created. Nevertheless, fix the range to avoid this warning.
>>
>> Fixes: CID 1534917
>> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/misc/pca9554.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Isn't it the one Peter fixed in
> https://lore.kernel.org/qemu-devel/20240312183810.557768-5-peter.maydell@linaro.org/?

Oh yes. I missed it. Hopefully, they are similar. Let's keep Peter's.

However, what I would like to do as a follow-up is to move the
hw/misc/pca955* models under hw/gpio/. Is it something we can do
for 9.0 ?

Thanks,

C.






Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9754C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZ9I-0005Ne-4A; Wed, 27 Mar 2024 15:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpZ9F-0005NO-Sx
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:41:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpZ9E-00077j-6z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:41:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ea838bf357so235427b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711568479; x=1712173279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RG8GD+YGbxvnhEJ3K1sxxXGqD1w9LsSUSpA7ZJ5u5yU=;
 b=EPqclhLBxv0GExlqBx9c2k68aXVOywcTcjYNlsjDBNg+5kI05WD4T8Q9EORVUhTyLe
 DIBPpGqdrPOHSmUhNBTW5T7hrRlWU27YUMfaEiugd3AmP3QGLgZbLclmEiyDLzGw6Iov
 oe19mJ91dydlugVqm7Z3CqKHfkJ0BVaApKYc54lGyn2omsVeEzE+vcTf+Ay+5OngOj9f
 SWc1TguHRTQniBm1kqiHbEPXdIRjQp4AQgl20vR3n0sAvjEeDKQK1Tq63bdz8SBVMsId
 gI7Wsg7C404YTs3UtFIC8mrp8eaAz+ZiooO6jPI0RFfnzJwSlNWuo0m7tJefpinYohTa
 fyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711568479; x=1712173279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RG8GD+YGbxvnhEJ3K1sxxXGqD1w9LsSUSpA7ZJ5u5yU=;
 b=p1bC3No+0hlsvX4JkWRDFwVo5keHC94UmWWcF1GAHyLdJWxYC7GVx4bzKMT+VsyeLj
 VndS721qjDgj19gT3cf3jRsxcbBzGGc8sv6YuYReFIZXyCWQHlrWhVY/Qrcr7ue3wo6E
 O07atd/YtnRlXFpx5m+AkKSwC7EFyXbA6ciPjepcGkS7MugoWkp7qCi9BhruSo3kJ+Pu
 29m5bZV7d/a0RUY05IXA5Z5iO0G3mTovFexT2om0B3P0zOHRUvE4HpJv1cZUuCvaMceM
 /4DNykAzINWXSeKeB68lb2aWxoJZAGmk1nh8I5pzruL+sP+bwTZpydesHVwYo0D4xSVI
 A8Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr2P2Y9dINJLQKj+apEaJaTM28x9RPw6OgaK9aZidPlmXw9oFqCa1TXXtf5IKZ7xfsxAiG3lpNB7zT2UaZWz5ZaaSSGr8=
X-Gm-Message-State: AOJu0YzOEJQfihsJjEqwgPxamsnJpg8//9mEXKeJrBvxGfvaneAC9LpA
 ZDRnZ5MGRUjnQmuzTtJ9WnrJorQ855s9Vf7KM3yIfcucx3hm2T/ZJMtC/9zptI0=
X-Google-Smtp-Source: AGHT+IHWAxzbgxlrjNshdTcmQRap6B9UaomWqc1N1XtJgxhvyh/pb5fzbPcPwSNVKpNM4In/7KQfbg==
X-Received: by 2002:a05:6a20:6a11:b0:1a3:48c8:6858 with SMTP id
 p17-20020a056a206a1100b001a348c86858mr1410156pzk.2.1711568478745; 
 Wed, 27 Mar 2024 12:41:18 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.241])
 by smtp.gmail.com with ESMTPSA id
 n32-20020a056a000d6000b006e6b9dd81bdsm8395903pfv.99.2024.03.27.12.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 12:41:18 -0700 (PDT)
Message-ID: <7861e603-93e5-4961-b31b-b9a7057d8add@ventanamicro.com>
Date: Wed, 27 Mar 2024 16:41:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
 <3153513.lVJF6dkNTK@silver>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <3153513.lVJF6dkNTK@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/27/24 15:53, Christian Schoenebeck wrote:
> On Wednesday, March 27, 2024 3:20:09 PM CET Daniel Henrique Barboza wrote:
>> Hi,
>>
>> In this new version we took a different approach after the discussions
>> we had in [1]. The tests are now untouched, and we're addressing the root
>> cause directly: the fact that we have a single temp dir for all the test
>> execution in qos-test.
>>
>> We're now creating and cleaning temp dirs for each individual test by
>> calling virtio_9p_create_local_test_dir() in the .before callback for
>> the local 9p tests (assign_9p_local_driver()). In this same callback we
>> queue the cleanup function that will erase the created temp dir. The
>> cleanup will run after the test ran successfully.
>>
>> This approach is similar to what other qtests do (in fact this design was
>> taken from vhost-user-test.c) so it's not like we're doing something
>> novel.
>>
>> I kept the revert of the slow test gate because Gitlab seems to approve
>> it:
>>
>> https://gitlab.com/danielhb/qemu/-/pipelines/1229836634
>>
>> Feel free to take just patch 1 if we're not sure about re-enabling these
>> tests in Gitlab.
>>
>>
>> Changes from v3:
>> - patches 1 to 6: dropped
>> - patch 1 (new):
>>    - create and remove temporary dirs on each test
>> - v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html
>>
>> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html
>>
>> Daniel Henrique Barboza (2):
>>    qtest/virtio-9p-test.c: create/remove temp dirs after each test
>>    qtest/virtio-9p-test.c: remove g_test_slow() gate
>>
>>   tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
>>   1 file changed, 11 insertions(+), 21 deletions(-)
>>
>>
> 
> Awesome!
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> Are the riscv patches already on master? I.e. should I push those two patches
> through my queue?

Yes, they were pushed to master almost 2 months ago and Thomas got wind of this problem
at the start of this week.


Thanks,

Daniel

> 
> /Christian
> 
> 


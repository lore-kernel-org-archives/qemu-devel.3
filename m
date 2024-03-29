Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A79CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9UG-0005Yz-RK; Fri, 29 Mar 2024 06:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9UE-0005Xy-LX
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:29:27 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9UB-0006JV-GH
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:29:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56c2b4850d2so2245072a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711708139; x=1712312939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2i/M9AeqDtFkt/QZdzAPEVB4C367tIQYUV55KfBm4KA=;
 b=spn6cTUMpodrSGxeUazu1YJrqVgCWIrismm9dObHsrUv0j2pvNhiMOj/QS80qdOIP8
 tCG9ka3yrf47qxqih9S0UEVw+UxEeBSdmy52hzFo3XAns5QZhvnNaf7zgy2SoN++2bwl
 ojGW9FAhO6OzL3O0HFUiu2JZBhMNcOlO4oZ88rcjIg0mbVjjcxHRhDONRSVPBIVORnaU
 0j1saD2F28MmkfWTkdbwhnBSnQhthJDa7dxnOft0QiWyCdfeKd2NcbHKAGxr9Xi34gDO
 NSVCYlsvgtCHIxTt7Mj6lqA1SgaQfDLaBnEFSyifDFZom5gssowiwrIJumRF5xhVFiZz
 K94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711708139; x=1712312939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2i/M9AeqDtFkt/QZdzAPEVB4C367tIQYUV55KfBm4KA=;
 b=EtjnPFQH9IdvjpC2QOx/IrAPitO8+f7ClUv65cEGCsfMFNdyb9+BvAj9MuSoVmfa6k
 URfglU1nnacHhNTU29fXeOzUgcVFuisUAmPcIduBcMzQ902+L46wzxEbAAJ0mfzpU1Vn
 ns2l4CUy7Du7es42xKGLf06am2+S6/GfdewxOJx4pR7Lpd4CHtI2Di0ktej+kzxMncQx
 Lry11xfvPNbXrXCNtGD8ODZMz1Lv5zLzqmWKr3eDLRQVnKGiwDUuUgQtjtNGCLzc+jqp
 vQp2uZ/v8FVWw15Cg4rAxX5YMyMV0Tu/5m/r/I00UjYW4ctNI9OZCLHLlxDmW2zdW/NP
 jUWA==
X-Gm-Message-State: AOJu0YwFlLZTtAqfmz5oJruimvrzRgrMvZY1bSbAcK3quM4I6Pl6duAY
 he3c2t/DYmTtZ2zsZEuVJPH8D3GW1ItxAbOV2FccLuEkkC3YuS98ad9KAoFLg04=
X-Google-Smtp-Source: AGHT+IFCj8i3jWIJkJXR0xRJKZ1ubewqd/bUQ0qJobHJCmTemJTmjkwIbj7oRMTb3jNQsdZQHWK0lw==
X-Received: by 2002:a17:906:d054:b0:a4e:14a1:fa81 with SMTP id
 bo20-20020a170906d05400b00a4e14a1fa81mr1367143ejb.46.1711708138984; 
 Fri, 29 Mar 2024 03:28:58 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 le6-20020a170906ae0600b00a4e275ce430sm1383663ejb.141.2024.03.29.03.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 03:28:58 -0700 (PDT)
Message-ID: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
Date: Fri, 29 Mar 2024 11:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yu Zhang <yu.zhang@ionos.com>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n> <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zhijian,

On 29/3/24 02:53, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/03/2024 23:01, Peter Xu wrote:
>> On Thu, Mar 28, 2024 at 11:18:04AM -0300, Fabiano Rosas wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> The whole RDMA subsystem was deprecated in commit e9a54265f5
>>>> ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
>>>> released in v8.2.
>>>>
>>>> Remove:
>>>>    - RDMA handling from migration
>>>>    - dependencies on libibumad, libibverbs and librdmacm
>>>>
>>>> Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
>>>> in old migration streams.
>>>>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Li Zhijian <lizhijian@fujitsu.com>
>>>> Acked-by: Fabiano Rosas <farosas@suse.de>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Just to be clear, because people raised the point in the last version,
>>> the first link in the deprecation commit links to a thread comprising
>>> entirely of rdma migration patches. I don't see any ambiguity on whether
>>> the deprecation was intended to include migration. There's even an ack
>>> from Juan.
>>
>> Yes I remember that's the plan.
>>
>>>
>>> So on the basis of not reverting the previous maintainer's decision, my
>>> Ack stands here.
>>>
>>> We also had pretty obvious bugs ([1], [2]) in the past that would have
>>> been caught if we had any kind of testing for the feature, so I can't
>>> even say this thing works currently.
>>>
>>> @Peter Xu, @Li Zhijian, what are your thoughts on this?
>>
>> Generally I definitely agree with such a removal sooner or later, as that's
>> how deprecation works, and even after Juan's left I'm not aware of any
>> other new RDMA users.  Personally, I'd slightly prefer postponing it one
>> more release which might help a bit of our downstream maintenance, however
>> I assume that's not a blocker either, as I think we can also manage it.
>>
>> IMHO it's more important to know whether there are still users and whether
>> they would still like to see it around. That's also one thing I notice that
>> e9a54265f533f didn't yet get acks from RDMA users that we are aware, even
>> if they're rare. According to [2] it could be that such user may only rely
>> on the release versions of QEMU when it broke things.
>>
>> So I'm copying Yu too (while Zhijian is already in the loop), just in case
>> someone would like to stand up and speak.
> 
> 
> I admit RDMA migration was lack of testing(unit/CI test), which led to the a few
> obvious bugs being noticed too late.
> However I was a bit surprised when I saw the removal of the RDMA migration. I wasn't
> aware that this feature has not been marked as deprecated(at least there is no
> prompt to end-user).
> 
> 
>> IMHO it's more important to know whether there are still users and whether
>> they would still like to see it around.
> 
> Agree.
> I didn't immediately express my opinion in V1 because I'm also consulting our
> customers for this feature in the future.
> 
> Personally, I agree with Perter's idea that "I'd slightly prefer postponing it one
> more release which might help a bit of our downstream maintenance"

Do you mind posting a deprecation patch to clarify the situation?

Thanks,

Phil.

> 
> Thanks
> Zhijian
> 
>>
>> Thanks,
>>
>>>
>>> 1- https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
>>> 2- https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com
>>>



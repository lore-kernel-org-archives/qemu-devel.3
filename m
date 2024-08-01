Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E1FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOMj-00046M-RZ; Thu, 01 Aug 2024 01:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZOMi-00045X-1e
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:28:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZOMd-0003Md-Qv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:28:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so47823615ad.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722490114; x=1723094914;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpF9C2q3R9ZQtAetHx4QHtyEFrmlQwAecWxHeVwSnQk=;
 b=y07dylDJ8PV7DJbZBH6Jc12THaoWYeUoHGJZ3NPgblzNTqCypibwAXr2neH01B52pz
 5ME8ts5Z8IjxovOnqmuL7xlQM6aXP40Efb8QZRWl/2NBFd6hLgbLKngrPyBwK2FtQLCy
 cit7nkzHotGfeodfld+fqW85MHcpLmKxMGrAYETBigaShlU2QaleJMEI9LsUIiHes94m
 ctWV8CHW7mjgjoxzt6Rijg3BQ0SPueQai68idqzOedC6wkEhR91J+fXFM3rdZ2SwctKe
 97zS3uiNmOiHSqoH87gc2AtlTfZ3VSpI7Nyh9kgdt7JxnUcfKyCyZPHCAn44lFtuQHCb
 SyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490114; x=1723094914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpF9C2q3R9ZQtAetHx4QHtyEFrmlQwAecWxHeVwSnQk=;
 b=eEa3vDvX2Bn51x19PIYbOo0Iwn2C/6z3z5YOfYkZP9aKBe5HhL7Tzfk6KLjkUhUB5H
 SixUkDvQO+um/HIPrSfxUKSZ4oNzJlf+hfZhl4yzVfMhmPee8pRcmLNNpD6m9+SkM3gs
 GNggvNA0O+yPOhmkWH5mWx8C2Y412Cg9A5bd39AeDzvOqKhtG2mNYeOW4Qf0W/Ath31W
 stJdVYWilmqOlkT5bSgki/vGgsXPPHsV27wdValK6SeDTP9eODYv0Th3A/AE+xYIFDSc
 12rimAiBUVZYySwpIddDeo3/mrvg8Am6qTGIBQggJtFuLn/hXMWOvdIic/MvX9IAnuTA
 Aojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzTH6OrLrox0GnIOcNH2cWqmFwNfkmyYCwhsNVyGXDHVERuxCv+dxJw6Vxk7DNbQ6AyKXJXlTKNHfEH8rnKEyuNGAQrc0=
X-Gm-Message-State: AOJu0Yyk0RdqqHRjfvgw8zkGWMt5hsrGsvdL+CYTqK9nGi/liln8wZRd
 y0hLppNfPNSWc4lNCDLi5IIzPMbW+d55k7UeRHw1yHKvKKNRCYrvbg1O18Z5/Zg=
X-Google-Smtp-Source: AGHT+IGXlBHMKzaG2Jmyi/GOesU3IdL50qUFpUqK+vulcUkiR/VQGqBFEJLKSiXMNw+DXWy/iykUJg==
X-Received: by 2002:a17:902:e752:b0:1fc:6a81:c5a1 with SMTP id
 d9443c01a7336-1ff4ce85acemr18380745ad.12.1722490113948; 
 Wed, 31 Jul 2024 22:28:33 -0700 (PDT)
Received: from [157.82.201.15] ([157.82.201.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ce41c5sm129710165ad.85.2024.07.31.22.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 22:28:33 -0700 (PDT)
Message-ID: <2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com>
Date: Thu, 1 Aug 2024 14:28:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 devel@lists.libvirt.org
References: <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org> <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org> <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org> <Zqo00Na1MZpksY9A@x1n>
 <CACGkMEuM+nONim_gNsjgxu9R+0=vcKGx7SQaTGMOoczL6666fw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuM+nONim_gNsjgxu9R+0=vcKGx7SQaTGMOoczL6666fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/01 11:28, Jason Wang wrote:
> On Wed, Jul 31, 2024 at 8:58 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, Jul 31, 2024 at 03:41:00AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Jul 31, 2024 at 08:04:24AM +0100, Daniel P. Berrangé wrote:
>>>> On Tue, Jul 30, 2024 at 05:32:48PM -0400, Michael S. Tsirkin wrote:
>>>>> On Tue, Jul 30, 2024 at 04:03:53PM -0400, Peter Xu wrote:
>>>>>> On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
>>>>>>> This is not what we did historically. Why should we start now?
>>>>>>
>>>>>> It's a matter of whether we still want migration to randomly fail, like
>>>>>> what this patch does.
>>>>>>
>>>>>> Or any better suggestions?  I'm definitely open to that.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> --
>>>>>> Peter Xu
>>>>>
>>>>> Randomly is an overstatement. You need to switch between kernels
>>>>> where this feature differs. We did it with a ton of features
>>>>> in the past, donnu why we single out USO now.
>>>>
>>>> This has been a problem with a ton of features in the past. We've
>>>> ignored the problem, but that doesn't make it the right solution
>>>>
>>>> With regards,
>>>> Daniel
>>>
>>> Pushing it to domain xml does not really help,
>>> migration will still fail unexpectedly (after wasting
>>> a ton of resources copying memory, and getting
>>> a downtime bump, I might add).
>>
>> Could you elaborate why it would fail if with what I proposed?
>>
>> Note that if this is a generic comment about "any migration can fail if we
>> found a device mismatch", we have plan to fix that to some degree. It's
>> just that we don't have enough people working on these topics yet. See:
>>
>> https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
>>
>> It includes:
>>
>>   "Check device tree on both sides, etc., to make sure the migration is
>>    applicable. E.g., we should fail early and clearly on any device
>>    mismatch."
>>
>> However I don't think it'll cover all checks, e.g. I _think_ even if we
>> verify VMSDs then post_load() hooks can still fail, and there can be some
>> corner cases to think.  And of course, this may not even apply to virtio
>> since virtio manages migration itself, without providing a top-level vmsd.
>>
>>>
>>> The right solution is to have a tool that can query
>>> backends, and that given the results from all of the cluster,
>>> generate a set of parameters that will ensure migration works.
> 
> This seems to be very hard for vhost-users.

Can you elaborate more? I was thinking something like follows:
1. Prepare a QEMU command line.
2. Run the command line appended with -dump-platform on all hosts, which 
dumps platform features automatically enabled. For virtio devices, we 
can dump "host_features" variable.
3. Run the command line appended with -merge-platform with all dumps. 
For most virtio devices, this would be AND operations on "host_features" 
variable.
4. Run the command line appended with -use-platform with the merged 
dump. This will run VMs with features available on all hosts.

I may have missed something but this seems good enough for me. Of course 
this requires changes throughout the stack (QEMU common and 
device-specific code, libvirt, and even higher layers like OpenStack).

Regards,
Akihiko Odaki


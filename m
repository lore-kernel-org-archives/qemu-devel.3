Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F76FC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 04:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZjwV-0006QI-RA; Fri, 02 Aug 2024 00:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZjwT-0006PF-Hb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 00:31:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZjwQ-0002OK-U2
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 00:31:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so59190535ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 21:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722573057; x=1723177857;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YAw+Wa+iMeBFnvKUJ45HU12H4zVEN139z5Gxl9EOCdM=;
 b=f1QY6pUY1hKJotb+pwP7ZhAYaBTFSTeLI7umKzBe2aneGUDBrngJuyPJ12bC7N3OT4
 I3Sxxu9k0bpI0gS8p34bq+jZB3wtUf1hR+GjhIeQSGwrlCQqYvxFQKhncaSxSlLF/DLj
 CreBuoAY+7a2TJYj56RBki0gU1YCUhzLdvZSe+kxJHoI9erx1L8rbXpuSo5m7bdSB8mF
 wZm131lQbAzZOyp0alDj5Jmb7z0YPKIhEqVTeWqnq34WYmx5lGN7m8cMBDD6n9h5wV/R
 odsNqSxgxjeK1atUEBpGwoQ9xr8sKD1YCc37mus4mHTAUi/fUlnXoJ4ClBiExQuX9gQx
 Bqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722573057; x=1723177857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAw+Wa+iMeBFnvKUJ45HU12H4zVEN139z5Gxl9EOCdM=;
 b=i3sxt5bPDvmCU9em443bK2NhPkZGDcC9UIX04Aj1/NvGdGfE7u7Q7CDIB1wyE4J3jp
 Wsze1bbZQ2mjUBHPZnaqYYKHI1hODXBIpjGVs1KIxqBWrhg0CZwI3PVgBW9zPNFDj1/V
 2hHWIU78DCBs/JK0VOalirwUK47fTEA7+FKH/7gHODQdT/WSZioFeT5fhoP8OCdga0W5
 Wk0xttoas+szNH/Won9UoEvYpap5PLWc5pECio+sqY3x1HgPmqU4Nj5JPXVjvT2Htk+O
 saH+olU9akL30oQiDRiGmoLUPKxfv28ctk+Cn8QRRodapDBYt6ljVtoQUBIItAidC8zi
 zn5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYQ+Paf/pchZe6/SXit5+GFQp/uFmMpMnmq88T8MP8DU4PmY2OHd9GLaf9UtcuvRz/0wHp74eUC+8tM5cmFlMQuOtkWoo=
X-Gm-Message-State: AOJu0YyXqIC4POGe5zc5zt+8OSbeqK/SLu7TU1u0bIQ+VV2JgGzxf898
 50B959/EufbQ5YXVRWkR9dsgFhueLh3CqGieucrE68PkDwG1pNrH6Q443PBnWoE=
X-Google-Smtp-Source: AGHT+IFU49BhlSGPnYXzAKZwbo0BLPtqjpYew6fH8yXoay5aXhBLoolIn1V0Sq5FLPMILLptJMXy4A==
X-Received: by 2002:a17:902:d08a:b0:1fd:9e6e:7c10 with SMTP id
 d9443c01a7336-1ff5748d30cmr21069465ad.41.1722573056744; 
 Thu, 01 Aug 2024 21:30:56 -0700 (PDT)
Received: from [157.82.201.15] ([157.82.201.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59295790sm7246415ad.261.2024.08.01.21.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 21:30:56 -0700 (PDT)
Message-ID: <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
Date: Fri, 2 Aug 2024 13:30:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqO2HvFJ8v7hZFOd@x1n> <ZqO7cR-UiGpX2rk0@redhat.com>
 <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com> <ZqumIZcs1tCNTpRE@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZqumIZcs1tCNTpRE@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

On 2024/08/02 0:13, Peter Xu wrote:
> On Thu, Aug 01, 2024 at 02:05:54PM +0900, Akihiko Odaki wrote:
>> On 2024/07/31 4:11, Peter Xu wrote:
>>> On Tue, Jul 30, 2024 at 07:46:12PM +0100, Daniel P. Berrangé wrote:
>>>> On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
>>>>> On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
>>>>>>> On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
>>>>>>>>
>>>>>>>> We've got two mutually conflicting goals with the machine type
>>>>>>>> definitions.
>>>>>>>>
>>>>>>>> Primarily we use them to ensure stable ABI, but an important
>>>>>>>> secondary goal is to enable new tunables to have new defaults
>>>>>>>> set, without having to update every mgmt app.  The latter
>>>>>>>> works very well when the defaults have no dependancy on the
>>>>>>>> platform kernel/OS, but breaks migration when they do have a
>>>>>>>> platform dependancy.
>>>>>>>>
>>>>>>>>>     - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>>>
>>>>>>>>>     - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>>>       by default, while advanced users can opt-in on new features.  We can't
>>>>>>>>>       make this ON by default otherwise some VMs can already fail to boot,
>>>>>>>>>
>>>>>>>>>     - If the host doesn't support the feature while the cmdline enabled it,
>>>>>>>>>       it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>>>>>>>       this host does not support running such VM specified, due to XXX
>>>>>>>>>       feature missing".
>>>>>>>>>
>>>>>>>>> That's the only way an user could understand what happened, and IMHO that's
>>>>>>>>> a clean way that we stick with QEMU cmdline on defining the guest ABI,
>>>>>>>>> while in which the machine type is the fundation of such definition, as the
>>>>>>>>> machine type can decides many of the rest compat properties.  And that's
>>>>>>>>> the whole point of the compat properties too (to make sure the guest ABI is
>>>>>>>>> stable).
>>>>>>>>>
>>>>>>>>> If kernel breaks it easily, all compat property things that we maintain can
>>>>>>>>> already stop making sense in general, because it didn't define the whole
>>>>>>>>> guest ABI..
>>>>>>>>>
>>>>>>>>> So AFAIU that's really what we used for years, I hope I didn't overlook
>>>>>>>>> somehting.  And maybe we don't yet need the "-platform" layer if we can
>>>>>>>>> keep up with this rule?
>>>>>>>>
>>>>>>>> We've failed at this for years wrt enabling use of new defaults that have
>>>>>>>> a platform depedancy, so historical practice isn't a good reference.
>>>>>>>>
>>>>>>>> There are 100's (possibly 1000's) of tunables set implicitly as part of
>>>>>>>> the machine type, and of those, libvirt likely only exposes a few 10's
>>>>>>>> of tunables. The vast majority are low level details that no mgmt app
>>>>>>>> wants to know about, they just want to accept QEMU's new defaults,
>>>>>>>> while preserving machine ABI. This is a good thing. No one wants the
>>>>>>>> burden of wiring up every single tunable into libvirt and mgmt apps.
>>>>>>>>
>>>>>>>> This is what the "-platform" concept would be intended to preserve. It
>>>>>>>> would allow a way to enable groups of settings that have a platform level
>>>>>>>> dependancy, without ever having to teach either libvirt or the mgmt apps
>>>>>>>> about the individual tunables.
>>>>>>>
>>>>>>> Do you think we can achieve similar goal by simply turning the feature to
>>>>>>> ON only after a few QEMU releases?  I also mentioned that idea below.
>>>>>>>
>>>>>>> https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
>>>>>>>
>>>>>>> So far it really sounds like the right thing to do to me to fix all similar
>>>>>>> issues, even without introducing anything new we need to maintain.
>>>>>>
>>>>>> Turning a feature with a platform dependency to "on" implies that
>>>>>> the machine type will cease to work out of the box for platforms
>>>>>> which lack the feature. IMHO that's not acceptable behaviour for
>>>>>> any of our supported platforms.
>>>>>
>>>>> Right, that's why I was thinking whether we should just always be on the
>>>>> safe side, even if I just replied in the other email to Akihiko, that we do
>>>>> have the option to make this more aggresive by turning those to ON after
>>>>> even 1-2 years or even less.. and we have control of how aggressive this
>>>>> can be.
>>>>>
>>>>>>
>>>>>> IOW, "after a few QEMU releases" implies a delay of as much as
>>>>>> 5 years, while we wait for platforms which don't support the
>>>>>> feature to drop out of our supported targets list.  I don't
>>>>>> think that'll satisfy the desire to get the new feature
>>>>>> available to users as soon as practical for their particular
>>>>>> platform.
>>>>>
>>>>> The feature is always available since the 1st day, right?  We just need the
>>>>> user to opt-in, by specifying ON in the cmdline.
>>>>>
>>>>> That'll be my take on this that QEMU's default VM setup should be always
>>>>> bootable, migratable, and so on.  Then user opt-in on stuff like this one,
>>>>> where there's implication on the ABIs.  The "user" can also include
>>>>> Libvirt.  I mean when something is really important, Libvirt should, IMHO,
>>>>> opt-in by treating that similarly like many cpu properties, and by probing
>>>>> the host first.
>>>>>
>>>>> IIUC there aren't a lot of things like that (part of guest ABI & host
>>>>> kernel / HW dependent), am I right?  Otherwise I would expect more failures
>>>>> like this one, but it isn't as much as that yet.  IIUC it means the efforts
>>>>> to make Libvirt get involved should be hopefully under control too.  The
>>>>> worst case is Libvirt doesn't auto-on it, but again the user should always
>>>>> have the option to turn it on when it's necessary.
>>>>
>>>> If it is left to libvirt, then it would very likely end up being a user
>>>> opt-in, not auto-enabled.
>>>
>>> Not sure whether there's other opinions, but that's definitely fine by me.
>>>
>>> I think it even makes more sense, as even if Libvirt probed the host and
>>> auto-on the feature, it also means Libvirt made a decision for the user,
>>> saying "having a better performance" is more important than "being able to
>>> migrate this VM everywhere".
>>>
>>> I don't see a way that can make such fair decision besides requesting the
>>> user to opt-in always for those, then the user is fully aware what is
>>> enabled, with the hope that when a migration fails later with "target host
>>> doesn't support feature XXX" the user is crystal clear on what happened.
>>
>> I think it is better to distinguish saying "having a better performance is
>> more important than being able to migrate this VM everywhere" from
>> explicitly selecting all available offload features; the latter is lot of
>> chores. More importantly, users may not just know these features may prevent
>> migration; they may just look like performance features nice to have at
>> first glance.
>>
>> I don' think what a user would want are not individual performance knobs,
>> but a user is more likely to need to express the platforms they would want
>> to migrate VMs on. There are several possible scenarios in particular:
>> 1) Migration everywhere
>> 2) Migration on specific machines
>> 3) Migration on some known platforms
>> 4) No migration (migration on nowhere)
>>
>> If a user chooses 1-3), QEMU may reject platform-dependent features even if
>> the user requests one; in this way, we don't need the users to make things
>> crystal clear, but we can expect QEMU does so.
>>
>> If a user chooses 2-4), QEMU may enable all offloading features available on
>> the specified platforms. Again, the user will no longer have to know each
>> individual performance features. QEMU may also reject migration to platforms
>> not specified to prevent misconfiguration.
>>
>> The -platform proposal earlier corresponds to 3). However it has a downside
>> that QEMU needs to know about platforms, which may not be trivial. In that
>> case, we can support 1), 2), and 4).
> 
> I'm not sure if I read it right.  Perhaps you meant something more generic
> than -platform but similar?
> 
> For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
> "perf" or "compat", while by default to "compat"?

"perf" would cover 4) and "compat" will cover 1). However neither of 
them will cover 2) because an enum is not enough to know about all 
hosts. I presented a design that will cover 2) in:
https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com

I also want to point out that "perf" should be rather named like 
"nomigrate". In general, a program should expose a functional 
requirement on the interface. It can then do its best to achieve high 
performance under that requirement.

> 
> If so, I think I get the idea, but it'll be challenging in at least these
> aspects:
> 
>    - We already have (at least.. that I'm aware of) three layers of
>      specifying a property for a device, they are:
> 
>      (1) default value
>      (2) compat property (from machine type definitions)
>      (3) qemu cmdline (specify one property explicitly)
> 
>      So far, there's an order we apply these (1-3), while (3) has the top
>      priority to overwrite (1-2), and (2) to overwrite (1).
> 
>      The new "-profile", if I read it right, introduce (4), and it's already
>      unclear to me how that interacts with (3) when -profile says "turn
>      FEAT1 on" while cmdline says otherwise.
> 
>      It can make things very compilcated, IMHO.
> 
>    - This still will break the "QEMU cmdline defines the guest ABI", e.g.,
>      consider this USO* thing that we boot an old machine type on a new
>      system that has QEMU+Linux USO* all enabled.  We specify "-profile
>      perf" there.  Then when we try to migrate to another older QEMU it'll
>      still fail the migration instead of any way telling us "migration is
>      not compatible".  So even if it helps the user turning on knobs, it
>      doesn't sound like to fix the problem we're working on?

When it is named nomigrate, it is obvious that migration does not work.

> 
> For whatever profile setup, it sounds like more applicable to a Libvirt
> option that user can choose.  That may avoid above two concerns I have,
> especially the latter. But I really don't know much on Libvirt, and this
> can be some extra effort too on top of either QEMU / Libvirt, and we may
> need to justify worthwhile.
> 
> Do we really concern about users not enabling features that much?  I
> thought users always can manually change the XML and add whatever they
> need, and device properties do not like too special here to me.  I mean, we
> have bunch of "features" exported as new "-devices" and users must opt-in
> for them by changing the XML.  We never worried on user not using them.  I
> doubt whether we worried too much on user not opt-in, especially for
> performance features, because they're, IMHO, targeting advanced users.

It is not about whether the user is knowledgeable or not, but it is 
about what the user wants. Migration is mandatory for a user who runs 
multi-tenant platforms, but it doesn't really matter for desktop users. 
Which are more knowledgeable? Personally, I want to have higher 
expectation for users running multi-tenant platforms, but it all depends.

You asked for the next step in another email. My suggestion is to 
satisfy 1) first because it is the easiest and safest. In particular, I 
suggest disabling all platform-dependent features by default to satisfy 
1). Combined with an existing option, -only-migratable, users will get 
the maximum assurance of migratability.

4) is the second easiest to implement, but the design of 4) will depend 
on whether we will satisfy 2) or 3). In the email I cited earlier, I 
suggested an option -use-platform to specify the expectation on the 
platform. If it is ever to be implemented, that option can take a 
special value, "host" to tell QEMU that it can use any features it finds 
on the current host.

Regards,
Akihiko Odaki


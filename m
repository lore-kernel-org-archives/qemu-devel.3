Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD7CC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZO0v-0000m7-NC; Thu, 01 Aug 2024 01:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZO0t-0000le-Bl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:06:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZO0o-0002P9-7L
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:06:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ab09739287so3953614a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722488760; x=1723093560;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmvxux6hVQEmzgXXQNF7v6OK/4+IqY7sagiCIjDfPnc=;
 b=GYFZsR01i/UESL65YgUNqp3RvEr9G3KvVljv5dLjyWOmEF4+g20xk+2itgl3hlYTB9
 9aLOZmpR0mv+gnho3iOq/Y00siNHew5BZ8CJ+1pyuAvxrfE2EdvpGluhvOEaMDhOE+sg
 vtTW+I2dgGXzxbX5G59QvT/QESYwF5c43SX7SmBcDEyA0EsgVx/7Jvjr1DzHp79ngCyh
 LSYRKtHBVZKZ+j7O/v4G0YKykTwX1qZgM+n8xQhRzisV03FBej8errkAHIfOf+MIgHQ6
 b1iWkB7CYuS7Bov5PyBBJ4hkgQ4SPnnIOWPLGRiY8QAvZEexAAh3q6c3m/0HzRevNakl
 H7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722488760; x=1723093560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmvxux6hVQEmzgXXQNF7v6OK/4+IqY7sagiCIjDfPnc=;
 b=oOcMzQ8GQ3MVnDnlSIhLEtDZWISWvnhj3eoK5y9WkdX35FKhgHmJ7aQtb8oiNz2jjy
 L4UtdLHU72sXx6kqU67f5N1I7DzRITVWMiHkkCp+RYXSwv99a/pYFrTqAlnpQr4KU/UO
 z7SOoT66mXruZj3QIASG9ZCzDS0ctrGwJv56AdIA8wKXmGIiTE7BXdi7xnnqu25CbBN4
 9f0mpyI2oYDOsWuM2zAkOPspnXYSyFdOvc5p05HtZsQycUhrdXFpLw4oGhQraSTGnXO3
 h3SX8B4T9uG/3W/J2uJdm6KSDKQbKI0Shvz02p3V8t/nEhvXLVVK+vkycSCIb0FZ07cK
 eMqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqE3zB33OGmuSvIw1Zq+HRjJrjHH75cBHRzWHrbMqE3dg2yasTJ9WaiBFTc6VLvT9j5gU5NM0HQ/YV+IHArggl5CRWycs=
X-Gm-Message-State: AOJu0YyAmR0Tq5J1a38T90AMmZN1QThrYDbDbWSCtlLAlTaZzeEzb2AD
 5wk0aspa4ENqF+bi58HQRN2rajZgyZL8dE//dhdpiy/H6ygYNXyuUWP1qY71cwE=
X-Google-Smtp-Source: AGHT+IFeA+3bxZUxnYE1SYx+1H+Tn6qbcnd9FRkdBJrXAdTeO7Cjq1fmMBCJ+PjQ3YX/X7VwnhT/Cg==
X-Received: by 2002:a05:6a20:7f8f:b0:1c1:61a9:de65 with SMTP id
 adf61e73a8af0-1c68cef2f0emr2117456637.9.1722488760170; 
 Wed, 31 Jul 2024 22:06:00 -0700 (PDT)
Received: from [157.82.201.15] ([157.82.201.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee3f74sm128916815ad.142.2024.07.31.22.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 22:05:59 -0700 (PDT)
Message-ID: <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
Date: Thu, 1 Aug 2024 14:05:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zqk6x2nd3Twz--75@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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

On 2024/07/31 4:11, Peter Xu wrote:
> On Tue, Jul 30, 2024 at 07:46:12PM +0100, Daniel P. Berrangé wrote:
>> On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
>>> On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
>>>> On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
>>>>> On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
>>>>>>
>>>>>> We've got two mutually conflicting goals with the machine type
>>>>>> definitions.
>>>>>>
>>>>>> Primarily we use them to ensure stable ABI, but an important
>>>>>> secondary goal is to enable new tunables to have new defaults
>>>>>> set, without having to update every mgmt app.  The latter
>>>>>> works very well when the defaults have no dependancy on the
>>>>>> platform kernel/OS, but breaks migration when they do have a
>>>>>> platform dependancy.
>>>>>>
>>>>>>>    - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>
>>>>>>>    - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>      by default, while advanced users can opt-in on new features.  We can't
>>>>>>>      make this ON by default otherwise some VMs can already fail to boot,
>>>>>>>
>>>>>>>    - If the host doesn't support the feature while the cmdline enabled it,
>>>>>>>      it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>>>>>      this host does not support running such VM specified, due to XXX
>>>>>>>      feature missing".
>>>>>>>
>>>>>>> That's the only way an user could understand what happened, and IMHO that's
>>>>>>> a clean way that we stick with QEMU cmdline on defining the guest ABI,
>>>>>>> while in which the machine type is the fundation of such definition, as the
>>>>>>> machine type can decides many of the rest compat properties.  And that's
>>>>>>> the whole point of the compat properties too (to make sure the guest ABI is
>>>>>>> stable).
>>>>>>>
>>>>>>> If kernel breaks it easily, all compat property things that we maintain can
>>>>>>> already stop making sense in general, because it didn't define the whole
>>>>>>> guest ABI..
>>>>>>>
>>>>>>> So AFAIU that's really what we used for years, I hope I didn't overlook
>>>>>>> somehting.  And maybe we don't yet need the "-platform" layer if we can
>>>>>>> keep up with this rule?
>>>>>>
>>>>>> We've failed at this for years wrt enabling use of new defaults that have
>>>>>> a platform depedancy, so historical practice isn't a good reference.
>>>>>>
>>>>>> There are 100's (possibly 1000's) of tunables set implicitly as part of
>>>>>> the machine type, and of those, libvirt likely only exposes a few 10's
>>>>>> of tunables. The vast majority are low level details that no mgmt app
>>>>>> wants to know about, they just want to accept QEMU's new defaults,
>>>>>> while preserving machine ABI. This is a good thing. No one wants the
>>>>>> burden of wiring up every single tunable into libvirt and mgmt apps.
>>>>>>
>>>>>> This is what the "-platform" concept would be intended to preserve. It
>>>>>> would allow a way to enable groups of settings that have a platform level
>>>>>> dependancy, without ever having to teach either libvirt or the mgmt apps
>>>>>> about the individual tunables.
>>>>>
>>>>> Do you think we can achieve similar goal by simply turning the feature to
>>>>> ON only after a few QEMU releases?  I also mentioned that idea below.
>>>>>
>>>>> https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
>>>>>
>>>>> So far it really sounds like the right thing to do to me to fix all similar
>>>>> issues, even without introducing anything new we need to maintain.
>>>>
>>>> Turning a feature with a platform dependency to "on" implies that
>>>> the machine type will cease to work out of the box for platforms
>>>> which lack the feature. IMHO that's not acceptable behaviour for
>>>> any of our supported platforms.
>>>
>>> Right, that's why I was thinking whether we should just always be on the
>>> safe side, even if I just replied in the other email to Akihiko, that we do
>>> have the option to make this more aggresive by turning those to ON after
>>> even 1-2 years or even less.. and we have control of how aggressive this
>>> can be.
>>>
>>>>
>>>> IOW, "after a few QEMU releases" implies a delay of as much as
>>>> 5 years, while we wait for platforms which don't support the
>>>> feature to drop out of our supported targets list.  I don't
>>>> think that'll satisfy the desire to get the new feature
>>>> available to users as soon as practical for their particular
>>>> platform.
>>>
>>> The feature is always available since the 1st day, right?  We just need the
>>> user to opt-in, by specifying ON in the cmdline.
>>>
>>> That'll be my take on this that QEMU's default VM setup should be always
>>> bootable, migratable, and so on.  Then user opt-in on stuff like this one,
>>> where there's implication on the ABIs.  The "user" can also include
>>> Libvirt.  I mean when something is really important, Libvirt should, IMHO,
>>> opt-in by treating that similarly like many cpu properties, and by probing
>>> the host first.
>>>
>>> IIUC there aren't a lot of things like that (part of guest ABI & host
>>> kernel / HW dependent), am I right?  Otherwise I would expect more failures
>>> like this one, but it isn't as much as that yet.  IIUC it means the efforts
>>> to make Libvirt get involved should be hopefully under control too.  The
>>> worst case is Libvirt doesn't auto-on it, but again the user should always
>>> have the option to turn it on when it's necessary.
>>
>> If it is left to libvirt, then it would very likely end up being a user
>> opt-in, not auto-enabled.
> 
> Not sure whether there's other opinions, but that's definitely fine by me.
> 
> I think it even makes more sense, as even if Libvirt probed the host and
> auto-on the feature, it also means Libvirt made a decision for the user,
> saying "having a better performance" is more important than "being able to
> migrate this VM everywhere".
> 
> I don't see a way that can make such fair decision besides requesting the
> user to opt-in always for those, then the user is fully aware what is
> enabled, with the hope that when a migration fails later with "target host
> doesn't support feature XXX" the user is crystal clear on what happened.

I think it is better to distinguish saying "having a better performance 
is more important than being able to migrate this VM everywhere" from 
explicitly selecting all available offload features; the latter is lot 
of chores. More importantly, users may not just know these features may 
prevent migration; they may just look like performance features nice to 
have at first glance.

I don' think what a user would want are not individual performance 
knobs, but a user is more likely to need to express the platforms they 
would want to migrate VMs on. There are several possible scenarios in 
particular:
1) Migration everywhere
2) Migration on specific machines
3) Migration on some known platforms
4) No migration (migration on nowhere)

If a user chooses 1-3), QEMU may reject platform-dependent features even 
if the user requests one; in this way, we don't need the users to make 
things crystal clear, but we can expect QEMU does so.

If a user chooses 2-4), QEMU may enable all offloading features 
available on the specified platforms. Again, the user will no longer 
have to know each individual performance features. QEMU may also reject 
migration to platforms not specified to prevent misconfiguration.

The -platform proposal earlier corresponds to 3). However it has a 
downside that QEMU needs to know about platforms, which may not be 
trivial. In that case, we can support 1), 2), and 4).

Regards,
Akihiko Odaki


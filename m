Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE6E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 05:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYIPD-0003bN-61; Thu, 16 Jan 2025 00:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIPB-0003bF-QB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:26:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIP9-0000fR-PR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:26:57 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21634338cfdso11031275ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 21:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737005214; x=1737610014;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kOQxZ9iQJZfyNRePP61BxbGCbio4DQnO5CInI7zqxEg=;
 b=xVZ37SOxSUQdDBSanbm4qJZ3pFi4b4dLbtL6LzPW8kV05RirB9E6A0982hFDciD5sw
 jnjnpIb+2LylIeHlWY6X8ZxP+N+to6EIYedu7EywizukRQIdgRuieUgMevEyWRtAg8ej
 QRqFqDHpgoukMmpKbhoDrCxjAcQVgvftKkHv0mw5UA6CDz2dGGBunavyo3xuvkRPTwnP
 l+IApqJo3JtD/22LhZl+CHkyGuTYjOOu1MS5GqRekLu+DmVFD/rdrk+kAz1J+JkG7OZ3
 oAJIPV1SpwVS6LnoZBhNlLDhwH9aRonTrdQoSsgSUzNAQAEqS3QZ042ZTlWpv1vmQaZz
 qhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737005214; x=1737610014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kOQxZ9iQJZfyNRePP61BxbGCbio4DQnO5CInI7zqxEg=;
 b=hD4CySLkn25oMbGt4YdIfJxcDMh9Me+krCNhoMOuLfZXJafTAkZTflilC9aX8GO3GP
 Ah2x+qlyK/BTs7fbAaPLTLqhJRNCylZqL31sp5Z4HJMEYXjdM1rL1tJ+b1IzxZJiM97/
 lPmLRf+526lNEy1ldshtogWkuDywH7BJwfX2S8FrehO7mNWuwgq7YbZhfZXPucwrmIGP
 mCFac0rJvngaSjVRF7+xsX3FPeSzg7U/PlVdwzV0ekGW7ry7BmItP3bwUf3ibi0YG68D
 O40xEvRgusrz43aZLkUsMDRk1cV0HYRvJZ2l27q/pJOuzA05n0L2z8IsUmu5Q18oB8c0
 1pbA==
X-Gm-Message-State: AOJu0YzEAL1oc11IqXIplkFgNQcSoD9aAwpd+GxedEgGEmt9a1ZR8sdE
 3zXX9qmiDWj4Lhi4bLUsHFBKlm/t9w/gY+3PzO30fPgIRUNJLmpGvDQBEYNuK0s=
X-Gm-Gg: ASbGncsZzYPTkGOJ3Jh7ZOsvXhfwQMjwi7fUWwdDi7YqrYFQvugj1+6n7hklr6jXFeV
 EOcjt8Ru6VFI4wCQIn0vBu0E0Y+0oazRBFugzwAkXEv8N/m+4RZVSPvYZevjuMl/DlO8xcB6dn6
 LoekOmXSX0aBWNHBeOqegXUI1fqmI2Dl3Vh615V8UPR0zrvi5fYEnaCLCcqMUcQ4z7eesh9fXiC
 WjAaTmb53/6VMZHQftEmF6u4NBVLHWDPc0ZmmB9zwsl1Jx6yOhtzeyUO6bdtxCiOZc=
X-Google-Smtp-Source: AGHT+IHxw8INgHiuRfsNh1RzsaKKBwNWDaUHTG/laEw7AuNmEeqAWbAxd8OX/FDKLYKuZDlDJvXU3Q==
X-Received: by 2002:a17:903:191:b0:215:a964:e680 with SMTP id
 d9443c01a7336-21a83f65330mr474769725ad.25.1737005213919; 
 Wed, 15 Jan 2025 21:26:53 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f256e39sm91198055ad.226.2025.01.15.21.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 21:26:53 -0800 (PST)
Message-ID: <bd84bba9-3aef-4c4e-a88a-566815903599@daynix.com>
Date: Thu, 16 Jan 2025 14:26:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
 <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
 <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
 <db4deda5-2869-45d2-8d56-9ba390324cd6@daynix.com>
 <CACGkMEv0XwU=P-V6RiRgBFtzZt19En921SPuTj+bNhYFyMSrFQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv0XwU=P-V6RiRgBFtzZt19En921SPuTj+bNhYFyMSrFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/16 10:17, Jason Wang wrote:
> On Wed, Jan 15, 2025 at 1:17 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/13 11:59, Jason Wang wrote:
>>> On Sat, Jan 11, 2025 at 1:43 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> Hi Jason,
>>>>
>>>> Can you check this patch again?
>>>
>>> I would like to have this if
>>>
>>> 1) it would be used by libvirt.
>>>
>>> or
>>>
>>> 2) there's no other way to do this
>>
>> I need this to make QEMU work with macvtap on mkosi, and this patch is
>> an effective way to accomplish the goal.
> 
> I'm not sure how to define "effective" here.

I just meant it requires me writing less code.

> 
>>
>> Requiring to pass a file descriptor is simply less convenient. Most (if
>> not all) aspects of QEMU can be configured without file descriptors; I
>> don't think there is a reason to make tap exceptional.
> 
> TUNSETIFF requires CAP_NET_ADMIN and qemu doesn't want to run with
> privilege, so fd is prefered in the case of tuntap.
> 
> For macvtap,ipvtap, though open, doesn't require any privilege.
> Passing fd via SCM_RIGHTS is still preferable as it eases the
> interaction with security facilities (for example, you may want to
> whitelist /dev/tapX for Qemu to access etc).

That is true for almost any kind of files, and QEMU provides options to 
specify files with file descriptor for this reason. However, it also 
provides alternative options to specify files with e.g., path for 
convenience.

This patch does not add a entirely-new complex, high-level feature. It 
only pushes the macvtap/ipvtap support to the same level with tuntap and 
other features interacting with files.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>> On 2024/10/22 13:59, Akihiko Odaki wrote:
>>>>> On 2024/10/18 17:10, Jason Wang wrote:
>>>>>> On Sat, Oct 12, 2024 at 5:05 PM Akihiko Odaki
>>>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>>>
>>>>>>> On 2024/10/09 16:41, Jason Wang wrote:
>>>>>>>> On Tue, Oct 8, 2024 at 2:52 PM Akihiko Odaki
>>>>>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>
>>>>>>>>> ipvtap and macvtap create a file for each interface unlike tuntap,
>>>>>>>>> which
>>>>>>>>> creates one file shared by all interfaces. Try to open a file
>>>>>>>>> dedicated
>>>>>>>>> to the interface first for ipvtap and macvtap.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Management layers usually pass these fds via SCM_RIGHTS. Is this for
>>>>>>>> testing purposes? (Note that we can use something like -netdev
>>>>>>>> tap,fd=10 10<>/dev/tap0).
>>>>>>>
>>>>>>> I used this for testing.
>>>>>>
>>>>>> Anything that prevents you from using fd redirection? If not
>>>>>> management interest and we had already had a way for testing, I tend
>>>>>> to not introduce new code as it may bring bugs.
>>>>>
>>>>> I don't know what ifindex the macvtap device has so it's easier to use
>>>>> if QEMU can automatically figure out the it.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>> ---
>>>>>>>>>      net/tap-linux.c | 17 ++++++++++++++---
>>>>>>>>>      1 file changed, 14 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>>>>>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
>>>>>>>>> --- a/net/tap-linux.c
>>>>>>>>> +++ b/net/tap-linux.c
>>>>>>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int
>>>>>>>>> *vnet_hdr,
>>>>>>>>>          int len = sizeof(struct virtio_net_hdr);
>>>>>>>>>          unsigned int features;
>>>>>>>>>
>>>>>>>>> -    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>>>>>> +
>>>>>>>>> +    ret = if_nametoindex(ifname);
>>>>>>>>> +    if (ret) {
>>>>>>>>> +        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
>>>>>>>>> +        fd = open(file, O_RDWR);
>>>>>>>>> +    } else {
>>>>>>>>> +        fd = -1;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>>          if (fd < 0) {
>>>>>>>>> -        error_setg_errno(errp, errno, "could not open %s",
>>>>>>>>> PATH_NET_TUN);
>>>>>>>>> -        return -1;
>>>>>>>>> +        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>>>>>
>>>>>>>> Any reason tuntap were tried after the macvtap/ipvtap?
>>>>>>>
>>>>>>> If we try tuntap first, we will know that it is not tuntap when calling
>>>>>>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again
>>>>>>> in such a case because they precede TUNSETIFF. Calling them twice is
>>>>>>> troublesome.
>>>>>>
>>>>>> I may miss something, we are only at the phase of open() not TUNSETIFF?
>>>>>
>>>>> We can tell if it is macvtap/ipvtap just by trying opening the device
>>>>> file. That is not possible with tuntap because tuntap uses /dev/net/tun,
>>>>> a device file common for all tuntap interfaces and its presence does not
>>>>> tell if the interface is tuntap.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> This is also consistent with libvirt. libvirt first checks if
>>>>>>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap
>>>>>>> otherwise.
>>>>>>
>>>>>> This is not what I understand from how layered products work. Libvirt
>>>>>> should align with Qemu for low level things like TAP, not the reverse.
>>>>>
>>>>> This change is intended for the use case where libvirt is not in use. In
>>>>> particular, I use mkosi, which is not a full fledged layering mechanism.
>>>>>
>>>>> Regards,
>>>>> Akihiko Odaki
>>>>
>>>
>>
> 



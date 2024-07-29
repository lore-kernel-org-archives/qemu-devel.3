Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTSt-0004q2-NZ; Mon, 29 Jul 2024 12:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTSs-0004pV-24
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:43:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTSo-0007V2-UV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:43:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc5296e214so24297215ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722271389; x=1722876189;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QyTiIIph8kr0OPMQ5PCn0uDyUF9zn75JnUPPsOSVc8I=;
 b=Rms569qeovk4sOdNW8r9DlXIz+DeI9H17X/2rl0WunMszXgsWFfm6ysesLBu9KAXIg
 QJbLCUEEV+z8rP2knt+7hQ7uthiR/L6EDso46SQ82TPB9fx0grM9537RTTK7dCVL8loP
 r2GbWOTxImJJQ7JU+uAAbzSUxwUyol5l1FKtfV/pzD3R/VC4NYvTZ0uu7oZ5Y4+UFQbG
 Jq1s0ZWeNS1RiRn/fHbeCkxpw41mjgMvH4kD5r7Pv1PakNyKljECPEfLLSwFMiqtfY1O
 T2mDC3dBKhGUCSoODDztRt4VKTgRYJHKEaohd+5QBBZKexUCSwN1uYAwjCxIRai7hxmc
 DB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722271389; x=1722876189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QyTiIIph8kr0OPMQ5PCn0uDyUF9zn75JnUPPsOSVc8I=;
 b=I994UZCop4QUJV+3ZOtang+ccSPAML67BF/msUbECdiGAqB4M17bV/Q6UilDy4xAFc
 YnQyxps9RlVmnyllqsX6nc9jAkJ713LxoLk9sU/CWdOUIC2Kx8pOuiqdDetsbdlLvlAJ
 6aeLrvntEJxXcWFgQJbM4D4pTedyrxFR/WPg1fT6DO8J8ktWYNWAc+n6NUYN6tsav+Cl
 jeUh7/kDnysm7TlRSVZQs4glODiia7jUeLOlVqs/inVfmM/8+vLsWWHEMSKxYVpcoz3L
 k2i47ZY0EKroHDMc7vPRjj8hzw84rex2jGwYMj7LX9pxzoPL+t3bZIPsZtCyZ6me+UyD
 z3xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHnNDwoEuBxdZwqSaPBn8R/+jQwTtL4TqY1JaJ+iM8feHDP+qrgL4VXFktq2OYVxlZW1vt3J2vOU0P2o2Fu/QrqO/FBJo=
X-Gm-Message-State: AOJu0YxDw2z+Q0gLq0xY28Xu1qCoBNmLJ5Xyblj8CFQBehOzjjIwLHLh
 yjl/MQAvkpAlyigvVFtI2pbD5yNOCo/XYmXPpdg+FccApm7IUlo+Wi5XwmP2mek=
X-Google-Smtp-Source: AGHT+IEW02LfXIX74xPutI/TWu4aLT9/zU7bNLvmMwgsGMXhGIFv9RbpELiyTN2VpodLDbEugl0/dA==
X-Received: by 2002:a17:903:2a85:b0:1fb:9b91:d7be with SMTP id
 d9443c01a7336-1ff047dd5d1mr103591125ad.9.1722271389031; 
 Mon, 29 Jul 2024 09:43:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ce4239sm85510805ad.80.2024.07.29.09.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 09:43:08 -0700 (PDT)
Message-ID: <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
Date: Tue, 30 Jul 2024 01:43:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 devel@lists.libvirt.org
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com> <ZqenSQHzniN14g7G@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZqenSQHzniN14g7G@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

On 2024/07/29 23:29, Peter Xu wrote:
> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
>> On 2024/07/29 12:50, Jason Wang wrote:
>>> On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/07/27 5:47, Peter Xu wrote:
>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>>>>>
>>>>>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>>>>>> USO supported, to another host that doesn't..
>>>>>>>>>>
>>>>>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>>>>>> don't do this.
>>>>>>>>>
>>>>>>>>> May I ask for my understanding:
>>>>>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>>>>>> between machines that have different host kernel features?
>>>>>>>>>
>>>>>>>>>> Long term, we need to start exposing management APIs
>>>>>>>>>> to discover this, and management has to disable unsupported features.
>>>>>>>>>
>>>>>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>>>>>
>>>>>>>> When QEMU automatically toggles machine type featuers based on host
>>>>>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>>>>>> as we cannot assume that the libvirt people are using knows about
>>>>>>>> newly introduced features. Even if libvirt is updated to know about
>>>>>>>> it, people can easily be using a previous libvirt release.
>>>>>>>>
>>>>>>>> QEMU itself needs to make the machine types do that they are there
>>>>>>>> todo, which is to define a stable machine ABI.
>>>>>>>>
>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>>>>>> sets of features which are tied to specific platform generations.
>>>>>>>> As long as we don't have that we'll keep having these broken
>>>>>>>> migration problems from machine types dynamically changing instead
>>>>>>>> of providing a stable guest ABI.
>>>>>>>
>>>>>>> Any more elaboration on this idea?  Would it be easily feasible in
>>>>>>> implementation?
>>>>>>
>>>>>> In terms of launching QEMU I'd imagine:
>>>>>>
>>>>>>      $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>>>
>>>>>> Any virtual machine HW features which are tied to host kernel features
>>>>>> would have their defaults set based on the requested -platform. The
>>>>>> -machine will be fully invariant wrt the host kernel.
>>>>>>
>>>>>> You would have -platform hlep to list available platforms, and
>>>>>> corresonding QMP "query-platforms" command to list what platforms
>>>>>> are supported on a given host OS.
>>>>>>
>>>>>> Downstream distros can provide their own platforms definitions
>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>>>> diverges from upstream due to backports.
>>>>>>
>>>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>>>> setting whose default is derived from the kernel. Individual
>>>>>> defaults are opaque and controlled by the requested platform.
>>>>>>
>>>>>> Live migration has clearly defined semantics, and mgmt app can
>>>>>> use query-platforms to validate two hosts are compatible.
>>>>>>
>>>>>> Omitting -platform should pick the very latest platform that is
>>>>>> cmpatible with the current host (not neccessarily the latest
>>>>>> platform built-in to QEMU).
>>>>>
>>>>> This seems to add one more layer to maintain, and so far I don't know
>>>>> whether it's a must.
>>>>>
>>>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>>>> thought it was mostly the case already, except some extremely rare
>>>>> outliers.
>>>>>
>>>>> When we have one host that boots up a VM using:
>>>>>
>>>>>      $QEMU1 $cmdline
>>>>>
>>>>> Then another host boots up:
>>>>>
>>>>>      $QEMU2 $cmdline -incoming XXX
>>>>>
>>>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>>>> can boot up all fine without errors on both sides.
>>>>>
>>>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>>>> didn't, I thought the ABI should be guaranteed.
>>>>>
>>>>> That's why I think this is a migration violation, as 99.99% of other device
>>>>> properties should be following this rule.  The issue here is, we have the
>>>>> same virtio-net-pci cmdline on both sides in this case, but the ABI got
>>>>> break.
>>>>>
>>>>> That's also why I was suggesting if the property contributes to the guest
>>>>> ABI, then AFAIU QEMU needs to:
>>>>>
>>>>>      - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>
>>>>>      - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>        by default, while advanced users can opt-in on new features.  We can't
>>>>>        make this ON by default otherwise some VMs can already fail to boot,
>>>>
>>>> It may not be necessary the case that old features are supported by
>>>> every systems. In an extreme case, a user may migrate a VM from Linux to
>>>> Windows, which probably doesn't support any offloading at all. A more
>>>> convincing scenario is RSS offloading with eBPF; using eBPF requires a
>>>> privilege so we cannot assume it is always available even on the latest
>>>> version of Linux.
>>>
>>> I don't get why eBPF matters here. It is something that is not noticed
>>> by the guest and we have a fallback anyhow.

It is noticeable for the guest, and the fallback is not effective with 
vhost. Enabling RSS by default will result in a similar problem although 
it is older than USO.

>>>
>>>>
>>>>>
>>>>>      - If the host doesn't support the feature while the cmdline enabled it,
>>>>>        it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>>>        this host does not support running such VM specified, due to XXX
>>>>>        feature missing".
>>>>
>>>> This is handled in:
>>>>
>>>> "virtio-net: Convert feature properties to OnOffAuto"
>>>> https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/
>>>
>>> I may miss something but I think "Auto" doesn't make sense to libvirt.
>>
>> The point is libvirt can explicitly set "on" to avoid the "auto" behavior.
>> libvirt does not have to use the "auto" value.
>>
>> libvirt can still use "auto" if desired. virDomainNetDefParseXMLDriver() in
>> libvirt actually parses tristate values (libvirt uses "default" instead of
>> "auto" as the mnemonic) for these features though "default" is currently
>> disabled by the schema (src/conf/schemas/domaincommon.rng). Allowing user to
>> specify "default" is only a matter of editing the schema. Of course
>> specifying "default" will make the VM unsafe for migration.
> 
> Isn't keeping the default AUTO the same as before when it used to be ON?  I
> mean, AUTO in a qemu cmdline doesn't guarantee guest API either.

True. It only deals with the situation that "the host doesn't support 
the feature while the cmdline enabled it".

> 
> Indeed it looks like it's a step forward to make ON having the clear
> semantics of "fail when unsupported".  It's just that I am not sure how
> useful is AUTO here, because anyway we'll need to break ON semantics even
> with AUTO, so that an old QEMU script with USO=ON used to boot on old
> kernels but not it won't. >
> What I was trying to say is whether we should make the default parameter to
> be migratable.  IOW, it looks to me AUTO should deserve a migration
> blocker when chosen.
> 
> After all, Libvirt hopefully shouldn't use AUTO at all but only ON/OFF,
> while any user when not caring much on these perf details should always use
> OFF on any kernel dependent features that may affect the guest ABI.

Well, there should be libvirt users who care performance and do not use 
migration so it's better for them if libvirt can use auto. But the use 
of "auto" should be mutually exclusive with migration of course.

Regards,
Akihiko Odaki


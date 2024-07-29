Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5AAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 04:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYIGD-00013E-Mj; Mon, 29 Jul 2024 00:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYIGC-00011o-2c
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 00:45:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYIG8-0003ct-94
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 00:45:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so15598925ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 21:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722228319; x=1722833119;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNTx5cEPzI9j23q864X+Wz4PfbzkkLDumoJU9jUzrKw=;
 b=u9R9sdXh6MEOkfEksujXlMbCSyfGWh1YcMLrYi4X/UOElkaPjU9sfinZKkwiQfk88K
 PO/w71ZqdJQpK2vlgYBE1DF+pstwfDSJBRVPir4NavR6D7k1Kbj+9x7SH4cpnGR2YZ92
 5NGBCrOpv+ASgXluYFqz+Ra53urIlmPzFzX9hnd85cPiisLnXWWHq7pN5P0zRZiyJ4ST
 z48eBwRRT6l0p9ev2mDOlDcLOCwwVS6qqMIf5MmsbUwuS5gzz9evlk1FL/C+ljUYDF1o
 pqBzJKRMqcztR/MOQk5pSrcUv66nIrsqoO5VJV3a94nTJV6ZQRWgNHnpNaRTuMsybPt4
 3Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722228319; x=1722833119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNTx5cEPzI9j23q864X+Wz4PfbzkkLDumoJU9jUzrKw=;
 b=P8ZCcgBNeiRh5kH+HuBTzWBDiEBVced69HBkIzfbfRCCrbMlHMWpgomHpYMbDdwPIQ
 t6wzp+DYRAzJyjR3n2hrnU0tPC1fE3kxiXsuNEY5dfDU7uinLZNCTgAuuQmp9QDYayi0
 DDlmeL2q+HX3LdX6z+dmcQ/t8CsDvM5LdXARfOJJUHpUZBh16FNeiQcb3O4dImj35geR
 3eEyD0XQePec519/yic8YkSaKY2eqPoLSQ3C8LtxuYgq0UzRYIYZyNQUGZ8O4juhfW/C
 2M95ad3rW2fIzXpTZJy6CbHObvYAqx6fP5vheJLF3TKugH8/s/qOXaWG00DYVgQkZrxu
 HT0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiA7R4R8U/AiFb7l6SBUptmBBWiltMf+sVU0YQd3kYXongSr1WSEp5L3pNRYmzSiGQa6bnos7e+HYb/AXOGWuwDBXY8w8=
X-Gm-Message-State: AOJu0YxOx4GMRuPNQHeodl2/+C617rODA86WNR0UA2DUhBlY9ffsrPMx
 1vr9lni6nJbT5i45GFc1Brb2lPZNwaDJuydlrpiljKTaDDHAUCKzaR/PSWcDceA=
X-Google-Smtp-Source: AGHT+IEMrmoi9bKBNBELjpV+zTbAkrAfZYk99aTxpsP3CgjO0CngLnpatgzQ1vyoCuE36zT4v7r3wg==
X-Received: by 2002:a17:902:e549:b0:1f9:d6bf:a67c with SMTP id
 d9443c01a7336-1ff04a2397amr119551275ad.5.1722228318507; 
 Sun, 28 Jul 2024 21:45:18 -0700 (PDT)
Received: from [157.82.203.140] ([157.82.203.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7d25fafsm72294015ad.108.2024.07.28.21.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 21:45:18 -0700 (PDT)
Message-ID: <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com>
Date: Mon, 29 Jul 2024 13:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 devel@lists.libvirt.org
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
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

On 2024/07/29 12:50, Jason Wang wrote:
> On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/07/27 5:47, Peter Xu wrote:
>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>>>
>>>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>>>> USO supported, to another host that doesn't..
>>>>>>>>
>>>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>>>> don't do this.
>>>>>>>
>>>>>>> May I ask for my understanding:
>>>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>>>> between machines that have different host kernel features?
>>>>>>>
>>>>>>>> Long term, we need to start exposing management APIs
>>>>>>>> to discover this, and management has to disable unsupported features.
>>>>>>>
>>>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>>>
>>>>>> When QEMU automatically toggles machine type featuers based on host
>>>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>>>> as we cannot assume that the libvirt people are using knows about
>>>>>> newly introduced features. Even if libvirt is updated to know about
>>>>>> it, people can easily be using a previous libvirt release.
>>>>>>
>>>>>> QEMU itself needs to make the machine types do that they are there
>>>>>> todo, which is to define a stable machine ABI.
>>>>>>
>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>>>> sets of features which are tied to specific platform generations.
>>>>>> As long as we don't have that we'll keep having these broken
>>>>>> migration problems from machine types dynamically changing instead
>>>>>> of providing a stable guest ABI.
>>>>>
>>>>> Any more elaboration on this idea?  Would it be easily feasible in
>>>>> implementation?
>>>>
>>>> In terms of launching QEMU I'd imagine:
>>>>
>>>>     $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>
>>>> Any virtual machine HW features which are tied to host kernel features
>>>> would have their defaults set based on the requested -platform. The
>>>> -machine will be fully invariant wrt the host kernel.
>>>>
>>>> You would have -platform hlep to list available platforms, and
>>>> corresonding QMP "query-platforms" command to list what platforms
>>>> are supported on a given host OS.
>>>>
>>>> Downstream distros can provide their own platforms definitions
>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>> diverges from upstream due to backports.
>>>>
>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>> setting whose default is derived from the kernel. Individual
>>>> defaults are opaque and controlled by the requested platform.
>>>>
>>>> Live migration has clearly defined semantics, and mgmt app can
>>>> use query-platforms to validate two hosts are compatible.
>>>>
>>>> Omitting -platform should pick the very latest platform that is
>>>> cmpatible with the current host (not neccessarily the latest
>>>> platform built-in to QEMU).
>>>
>>> This seems to add one more layer to maintain, and so far I don't know
>>> whether it's a must.
>>>
>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>> thought it was mostly the case already, except some extremely rare
>>> outliers.
>>>
>>> When we have one host that boots up a VM using:
>>>
>>>     $QEMU1 $cmdline
>>>
>>> Then another host boots up:
>>>
>>>     $QEMU2 $cmdline -incoming XXX
>>>
>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>> can boot up all fine without errors on both sides.
>>>
>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>> didn't, I thought the ABI should be guaranteed.
>>>
>>> That's why I think this is a migration violation, as 99.99% of other device
>>> properties should be following this rule.  The issue here is, we have the
>>> same virtio-net-pci cmdline on both sides in this case, but the ABI got
>>> break.
>>>
>>> That's also why I was suggesting if the property contributes to the guest
>>> ABI, then AFAIU QEMU needs to:
>>>
>>>     - Firstly, never quietly flipping any bit that affects the ABI...
>>>
>>>     - Have a default value of off, then QEMU will always allow the VM to boot
>>>       by default, while advanced users can opt-in on new features.  We can't
>>>       make this ON by default otherwise some VMs can already fail to boot,
>>
>> It may not be necessary the case that old features are supported by
>> every systems. In an extreme case, a user may migrate a VM from Linux to
>> Windows, which probably doesn't support any offloading at all. A more
>> convincing scenario is RSS offloading with eBPF; using eBPF requires a
>> privilege so we cannot assume it is always available even on the latest
>> version of Linux.
> 
> I don't get why eBPF matters here. It is something that is not noticed
> by the guest and we have a fallback anyhow.
> 
>>
>>>
>>>     - If the host doesn't support the feature while the cmdline enabled it,
>>>       it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>       this host does not support running such VM specified, due to XXX
>>>       feature missing".
>>
>> This is handled in:
>>
>> "virtio-net: Convert feature properties to OnOffAuto"
>> https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/
> 
> I may miss something but I think "Auto" doesn't make sense to libvirt.

The point is libvirt can explicitly set "on" to avoid the "auto" 
behavior. libvirt does not have to use the "auto" value.

libvirt can still use "auto" if desired. virDomainNetDefParseXMLDriver() 
in libvirt actually parses tristate values (libvirt uses "default" 
instead of "auto" as the mnemonic) for these features though "default" 
is currently disabled by the schema (src/conf/schemas/domaincommon.rng). 
Allowing user to specify "default" is only a matter of editing the 
schema. Of course specifying "default" will make the VM unsafe for 
migration.

Regards,
Akihiko Odaki


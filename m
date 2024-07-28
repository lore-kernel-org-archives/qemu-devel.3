Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5599C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY5fz-0003aO-Hm; Sun, 28 Jul 2024 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY5fu-0003ZU-Lw
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:19:08 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sY5fq-0003FT-V8
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 11:19:05 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-808a8c90f5bso70871139f.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722179941; x=1722784741;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRanTqE28pCkknn1RH5M+l3uAyZsyROIPCYeCogoOfo=;
 b=j+vJq+8gRff7uYYBPXXJsiV7FD6pZJwNDSBsRFp8Pv8PI7mmqGOW4SiIAWvgGavaVf
 0NjEneYgmv1b2MKrRLO0tGPbYZ4wXgmgcNdFdLesRHaaC0C+AHCTRAaw1zhcT1VGS2hd
 pwsWFDFnhQA2Qd76chSvNTP89sU7s9FY0bXukbJp5xFPSl1lvnLogCI+h8EszYTd0Ire
 B4kJPZiP4tEFLrQS5wx3IHtUNz2A5bb+/wAL2PLH1vJZDgvj656ZVhzDTX8mdCRAKLbQ
 0o4GC6GGv14dst6qhPk6y9aOH0gvMhOhWQjmo6ey2vmVXzRm6swDrTJUGGi6G/JjlgNl
 1B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722179941; x=1722784741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRanTqE28pCkknn1RH5M+l3uAyZsyROIPCYeCogoOfo=;
 b=Gj42U0lSZrI/YogO+sO6PBjwTjcq2idS4It+njR0iPT8p/1wXa5umxmVyi6G/mBNn9
 Frhkf01Fok2fcc0WJz8DMfgQjMueV5/WIvK0OpubcWISb9VX4OVe3OjQX/A1vGdDk2zX
 KgXlSai1HSHyRyUYXqoAA05DXTZVF7MYbwrlY+kDpX81bCp9ur0jbXFxf1zzVWcxocXO
 k5rbZNwarnAwULmzA8JBzap48YHtvWFq/mZldIOqq7UYH6Hqe9sGBJZpPTAQu5dleNj9
 vnewQnuw+DsMjpvZFsOImBmh5MMmgAywOCTbXd1/PcmbgChI0cizpC9le3gTmFRHyHpU
 X3og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHzI2cGsq/VwNk6Sw+z6jU9H5ztk9knMNxFgWEDxZKfBX/htPr7jmzh5nna97wdepzEeeSQ9jAstwrxlijn9qMFbsbxYs=
X-Gm-Message-State: AOJu0Yz3wbp30Bv93lSeVVVHeOQP+R+08t8beI75AjhIsH/NIoCbKcO7
 fUfxZkYdCw9n6+Lp83xZQT6Ns0bv2o8IOL30qtuEA36XOClm4u+IJJZX8vwNrxI=
X-Google-Smtp-Source: AGHT+IEbqvsGcCNw6CYZ0i45FgGYwLLS5Fy4W7aGRFEvDBT4EXqXDiowtUAoNsLa9C8zvnMzzsvB8A==
X-Received: by 2002:a05:6602:3f82:b0:7f6:2e72:e81b with SMTP id
 ca18e2360f4ac-81f95a30534mr732664939f.4.1722179940547; 
 Sun, 28 Jul 2024 08:19:00 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28e3c38esm6829257a91.52.2024.07.28.08.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 08:19:00 -0700 (PDT)
Message-ID: <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
Date: Mon, 29 Jul 2024 00:18:55 +0900
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
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZqQLbGxEW3XT7qL-@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd34.google.com
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

On 2024/07/27 5:47, Peter Xu wrote:
> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>
>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>
>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>> USO supported, to another host that doesn't..
>>>>>>
>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>> don't do this.
>>>>>
>>>>> May I ask for my understanding:
>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>> between machines that have different host kernel features?
>>>>>
>>>>>> Long term, we need to start exposing management APIs
>>>>>> to discover this, and management has to disable unsupported features.
>>>>>
>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>
>>>> When QEMU automatically toggles machine type featuers based on host
>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>> as we cannot assume that the libvirt people are using knows about
>>>> newly introduced features. Even if libvirt is updated to know about
>>>> it, people can easily be using a previous libvirt release.
>>>>
>>>> QEMU itself needs to make the machine types do that they are there
>>>> todo, which is to define a stable machine ABI.
>>>>
>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>> sets of features which are tied to specific platform generations.
>>>> As long as we don't have that we'll keep having these broken
>>>> migration problems from machine types dynamically changing instead
>>>> of providing a stable guest ABI.
>>>
>>> Any more elaboration on this idea?  Would it be easily feasible in
>>> implementation?
>>
>> In terms of launching QEMU I'd imagine:
>>
>>    $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>
>> Any virtual machine HW features which are tied to host kernel features
>> would have their defaults set based on the requested -platform. The
>> -machine will be fully invariant wrt the host kernel.
>>
>> You would have -platform hlep to list available platforms, and
>> corresonding QMP "query-platforms" command to list what platforms
>> are supported on a given host OS.
>>
>> Downstream distros can provide their own platforms definitions
>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>> diverges from upstream due to backports.
>>
>> Mgmt apps won't need to be taught about every single little QEMU
>> setting whose default is derived from the kernel. Individual
>> defaults are opaque and controlled by the requested platform.
>>
>> Live migration has clearly defined semantics, and mgmt app can
>> use query-platforms to validate two hosts are compatible.
>>
>> Omitting -platform should pick the very latest platform that is
>> cmpatible with the current host (not neccessarily the latest
>> platform built-in to QEMU).
> 
> This seems to add one more layer to maintain, and so far I don't know
> whether it's a must.
> 
> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
> thought it was mostly the case already, except some extremely rare
> outliers.
> 
> When we have one host that boots up a VM using:
> 
>    $QEMU1 $cmdline
> 
> Then another host boots up:
> 
>    $QEMU2 $cmdline -incoming XXX
> 
> Then migration should succeed if $cmdline is exactly the same, and the VM
> can boot up all fine without errors on both sides.
> 
> AFAICT this has nothing to do with what kernel is underneath, even not
> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> didn't, I thought the ABI should be guaranteed.
> 
> That's why I think this is a migration violation, as 99.99% of other device
> properties should be following this rule.  The issue here is, we have the
> same virtio-net-pci cmdline on both sides in this case, but the ABI got
> break.
> 
> That's also why I was suggesting if the property contributes to the guest
> ABI, then AFAIU QEMU needs to:
> 
>    - Firstly, never quietly flipping any bit that affects the ABI...
> 
>    - Have a default value of off, then QEMU will always allow the VM to boot
>      by default, while advanced users can opt-in on new features.  We can't
>      make this ON by default otherwise some VMs can already fail to boot,

It may not be necessary the case that old features are supported by 
every systems. In an extreme case, a user may migrate a VM from Linux to 
Windows, which probably doesn't support any offloading at all. A more 
convincing scenario is RSS offloading with eBPF; using eBPF requires a 
privilege so we cannot assume it is always available even on the latest 
version of Linux.

> 
>    - If the host doesn't support the feature while the cmdline enabled it,
>      it needs to fail QEMU boot rather than flipping, so that it says "hey,
>      this host does not support running such VM specified, due to XXX
>      feature missing".

This is handled in:

"virtio-net: Convert feature properties to OnOffAuto"
https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/

> 
> That's the only way an user could understand what happened, and IMHO that's
> a clean way that we stick with QEMU cmdline on defining the guest ABI,
> while in which the machine type is the fundation of such definition, as the
> machine type can decides many of the rest compat properties.  And that's
> the whole point of the compat properties too (to make sure the guest ABI is
> stable).
> 
> If kernel breaks it easily, all compat property things that we maintain can
> already stop making sense in general, because it didn't define the whol
> guest ABI..
> 
> So AFAIU that's really what we used for years, I hope I didn't overlook
> somehting.  And maybe we don't yet need the "-platform" layer if we can
> keep up with this rule?

I think a device which cannot conform to that rule should be 
non-migratable. For example, virtio-gpu-gl does not conform to it, and 
does not support migration either.

Regards,
Akihiko Odaki


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBFFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 10:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYk1C-0003ss-AB; Tue, 30 Jul 2024 06:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYk1A-0003sL-LD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:23:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYk17-0007dW-W6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:23:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc6a017abdso25669365ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722335020; x=1722939820;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZB1trO7Zgav/Or10LlqydMyHjrEkqxgH2+5r7D2p4AA=;
 b=d9ucgM8Ke8rbQNpTS0H0KLq83odeGxXdRHvY39cOr8OVJkyG4BmrwiOlOm5JagTcTB
 d0oWQ7KVdCgbVJF/lR9oSzRvsqp9rcyLfWPyp7ahoneq+1CYvlIrA+iP84tKatcjUqZD
 2pjO0uqU4uZC3xhY1EHbMV4biKWOxBNPpJ8mi7IU9GgRvMU/3cMvAzQ8s8qbK7oP1kpC
 S64iOKngisIxX1KYEwpjmva55zzLZUEOaoClJJEYcLoDoh1TUcRuKfmYRw04ds/QnwhZ
 jgSgWhN/gq/khH3Lro9W/7GYFMqVekRMZz11RUTYIRwevjUducN1K8yituJXP/35T95z
 i4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722335020; x=1722939820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZB1trO7Zgav/Or10LlqydMyHjrEkqxgH2+5r7D2p4AA=;
 b=tJEHVVN+xoZptvcf1ss/Yv9UnxbPM4bPtA/c8qZp606AbOE2iIq7MUdKrZ7zz20TPE
 yDGSdotDmWjPp0fGK6bb4knBzHTjFBMIVEvrBExgsEvpZO7n9nZ56AVeIHASX2z/0T4/
 /4U0vFjfbHpR0AMBMq2ghXOOwgMiMPBs0/E49oQwB0OfN+s01+zkX6AbVe0vanWk8Gs6
 xmPLKDWcxl5VoaJlFrHTRiYN1FOIhQvSxjgYByH5Iy8Sn35TWrWuBoHY/WiefIkt1uOO
 VYiDDHgzhULaNRTt9LMyptJISDNC4/q3KuRMzy48/h83akwJrAxCHrgV99o/VAe4W8Y0
 HyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+YzWFbS4qCaCe4I9zmamKnK+QYabLuc5SPdMMGc2ey/mYyvcSM8ybIEO6+AEwnABPl9nLvmpZrJDPZKAyk5RZesRj/i8=
X-Gm-Message-State: AOJu0YxPLz200sZcqZeaQwxeYtQ8IrrUlMQ1XT29iEAgxX6pl/8gLXnr
 eIAT5y4SFRRnwTFg0mCxAxTT/28HeeYjLMwjojaPSxLy9Xi5//CPklfzGEzZTT7w3HwVUyohHI2
 jBjQ=
X-Google-Smtp-Source: AGHT+IECkUbATUsiwWXRBYaEAFAzzoxLzGZpFpmsayJP6Zf0NUUwgN0EQGmWw9/mFDf+AjBj6SoKWQ==
X-Received: by 2002:a17:902:ecc2:b0:1fb:8f72:d5e9 with SMTP id
 d9443c01a7336-1ff0489f5cbmr93765835ad.48.1722335020149; 
 Tue, 30 Jul 2024 03:23:40 -0700 (PDT)
Received: from [157.82.204.132] ([157.82.204.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff3b0fd8c0sm7493845ad.140.2024.07.30.03.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 03:23:39 -0700 (PDT)
Message-ID: <87ab434e-ae8c-4170-9d7f-8875ecf915c3@daynix.com>
Date: Tue, 30 Jul 2024 19:23:35 +0900
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
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com> <ZqenSQHzniN14g7G@x1n>
 <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
 <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
 <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
 <CACGkMEvgYTjQ5orDJMbmE8-Kwqko9dFPerTnxsRgs0EtnmKKTQ@mail.gmail.com>
 <bc2ef42e-9003-4a3e-aee5-e65d34f205bf@daynix.com>
 <CACGkMEvZgihjP3o3o6iLVJ69hHVZDoZdn3rJ5wohK+OEceStcA@mail.gmail.com>
 <90f29246-f63f-4cc4-935a-bb874ecae1a0@daynix.com>
 <CACGkMEtbeWde4_AbEZyTmShaXyo-WwAt7=o1=uimD0zmrKK8pg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtbeWde4_AbEZyTmShaXyo-WwAt7=o1=uimD0zmrKK8pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

On 2024/07/30 12:45, Jason Wang wrote:
> On Tue, Jul 30, 2024 at 11:29 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/07/30 12:17, Jason Wang wrote:
>>> On Tue, Jul 30, 2024 at 11:12 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/07/30 12:03, Jason Wang wrote:
>>>>> On Tue, Jul 30, 2024 at 10:57 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/07/30 11:04, Jason Wang wrote:
>>>>>>> On Tue, Jul 30, 2024 at 12:43 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2024/07/29 23:29, Peter Xu wrote:
>>>>>>>>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
>>>>>>>>>> On 2024/07/29 12:50, Jason Wang wrote:
>>>>>>>>>>> On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2024/07/27 5:47, Peter Xu wrote:
>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>>>>>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>>>>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>>>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>>>>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>>>>>>>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>>>>>>>>>>>>>> USO supported, to another host that doesn't..
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>>>>>>>>>>>>>> don't do this.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> May I ask for my understanding:
>>>>>>>>>>>>>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>>>>>>>>>>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>>>>>>>>>>>>>> between machines that have different host kernel features?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Long term, we need to start exposing management APIs
>>>>>>>>>>>>>>>>>> to discover this, and management has to disable unsupported features.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> When QEMU automatically toggles machine type featuers based on host
>>>>>>>>>>>>>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>>>>>>>>>>>>>> as we cannot assume that the libvirt people are using knows about
>>>>>>>>>>>>>>>> newly introduced features. Even if libvirt is updated to know about
>>>>>>>>>>>>>>>> it, people can easily be using a previous libvirt release.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> QEMU itself needs to make the machine types do that they are there
>>>>>>>>>>>>>>>> todo, which is to define a stable machine ABI.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>>>>>>>>>>>>>> sets of features which are tied to specific platform generations.
>>>>>>>>>>>>>>>> As long as we don't have that we'll keep having these broken
>>>>>>>>>>>>>>>> migration problems from machine types dynamically changing instead
>>>>>>>>>>>>>>>> of providing a stable guest ABI.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Any more elaboration on this idea?  Would it be easily feasible in
>>>>>>>>>>>>>>> implementation?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In terms of launching QEMU I'd imagine:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>          $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Any virtual machine HW features which are tied to host kernel features
>>>>>>>>>>>>>> would have their defaults set based on the requested -platform. The
>>>>>>>>>>>>>> -machine will be fully invariant wrt the host kernel.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You would have -platform hlep to list available platforms, and
>>>>>>>>>>>>>> corresonding QMP "query-platforms" command to list what platforms
>>>>>>>>>>>>>> are supported on a given host OS.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Downstream distros can provide their own platforms definitions
>>>>>>>>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>>>>>>>>>>>> diverges from upstream due to backports.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>>>>>>>>>>>> setting whose default is derived from the kernel. Individual
>>>>>>>>>>>>>> defaults are opaque and controlled by the requested platform.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Live migration has clearly defined semantics, and mgmt app can
>>>>>>>>>>>>>> use query-platforms to validate two hosts are compatible.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Omitting -platform should pick the very latest platform that is
>>>>>>>>>>>>>> cmpatible with the current host (not neccessarily the latest
>>>>>>>>>>>>>> platform built-in to QEMU).
>>>>>>>>>>>>>
>>>>>>>>>>>>> This seems to add one more layer to maintain, and so far I don't know
>>>>>>>>>>>>> whether it's a must.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>>>>>>>>>>>> thought it was mostly the case already, except some extremely rare
>>>>>>>>>>>>> outliers.
>>>>>>>>>>>>>
>>>>>>>>>>>>> When we have one host that boots up a VM using:
>>>>>>>>>>>>>
>>>>>>>>>>>>>          $QEMU1 $cmdline
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then another host boots up:
>>>>>>>>>>>>>
>>>>>>>>>>>>>          $QEMU2 $cmdline -incoming XXX
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>>>>>>>>>>>> can boot up all fine without errors on both sides.
>>>>>>>>>>>>>
>>>>>>>>>>>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>>>>>>>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>>>>>>>>>>>> didn't, I thought the ABI should be guaranteed.
>>>>>>>>>>>>>
>>>>>>>>>>>>> That's why I think this is a migration violation, as 99.99% of other device
>>>>>>>>>>>>> properties should be following this rule.  The issue here is, we have the
>>>>>>>>>>>>> same virtio-net-pci cmdline on both sides in this case, but the ABI got
>>>>>>>>>>>>> break.
>>>>>>>>>>>>>
>>>>>>>>>>>>> That's also why I was suggesting if the property contributes to the guest
>>>>>>>>>>>>> ABI, then AFAIU QEMU needs to:
>>>>>>>>>>>>>
>>>>>>>>>>>>>          - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>>>>>>>
>>>>>>>>>>>>>          - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>>>>>>>            by default, while advanced users can opt-in on new features.  We can't
>>>>>>>>>>>>>            make this ON by default otherwise some VMs can already fail to boot,
>>>>>>>>>>>>
>>>>>>>>>>>> It may not be necessary the case that old features are supported by
>>>>>>>>>>>> every systems. In an extreme case, a user may migrate a VM from Linux to
>>>>>>>>>>>> Windows, which probably doesn't support any offloading at all. A more
>>>>>>>>>>>> convincing scenario is RSS offloading with eBPF; using eBPF requires a
>>>>>>>>>>>> privilege so we cannot assume it is always available even on the latest
>>>>>>>>>>>> version of Linux.
>>>>>>>>>>>
>>>>>>>>>>> I don't get why eBPF matters here. It is something that is not noticed
>>>>>>>>>>> by the guest and we have a fallback anyhow.
>>>>>>>>
>>>>>>>> It is noticeable for the guest, and the fallback is not effective with
>>>>>>>> vhost.
>>>>>>>
>>>>>>> It's a bug then. Qemu can fallback to tuntap if it sees issues in vhost.
>>>>>>
>>>>>> We can certainly fallback to in-QEMU RSS by disabling vhost, but I would
>>>>>> not say lack of such fallback is a bug.
>>>>>
>>>>> Such fallback is by design since the introduction of vhost.
>>>>>
>>>>>> We don't provide in-QEMU
>>>>>> fallback for other offloads.
>>>>>
>>>>> Yes but what I want to say is that eBPF RSS is different from those
>>>>> segmentation offloads. And technically, Qemu can do fallback for
>>>>> offloads (as RSC did).
>>>>
>>>> Well, I couldn't find any code disabling vhost for the in-QEMU RSC
>>>> implementation.
>>>
>>> It should be a bug (and I remember we disabled vhost when the patches
>>> were merged). Have you tested it in a guest to see if it can see RSC
>>> when vhost is enabled?
>>>
>>> I suspect we need to add the RSC bit into current kernel_feature_bits:
>>>
>>> /* Features supported by host kernel. */
>>> static const int kernel_feature_bits[] = {
>>>       VIRTIO_F_NOTIFY_ON_EMPTY,
>>>       VIRTIO_RING_F_INDIRECT_DESC,
>>>       VIRTIO_RING_F_EVENT_IDX,
>>>       VIRTIO_NET_F_MRG_RXBUF,
>>>       VIRTIO_F_VERSION_1,
>>>       VIRTIO_NET_F_MTU,
>>>       VIRTIO_F_IOMMU_PLATFORM,
>>>       VIRTIO_F_RING_PACKED,
>>>       VIRTIO_F_RING_RESET,
>>>       VIRTIO_NET_F_HASH_REPORT,
>>>       VHOST_INVALID_FEATURE_BIT
>>> };
>>>
>>> As RSC won't be provided by TUN/TAP anyhow.
>>
>> Adding the RSC bit does not let QEMU disable vhost for RSC, but instead
>> it implicitly disables RSC in my understanding.
> 
> Yes.
> 
>> It is still better than
>> advertising the availability of that feature while it is missing.
> 
> Down the road, we probably need to change the behaviour of disabling vhost-net.
> 
>>
>>>
>>>>
>>>> Looking at the code, I also found the case of vhost-vdpa. vhost can be
>>>> simply disabled if it is backed by tuntap, but it is not the case for vDPA.
>>>
>>> True, technically, vDPA can fallback to SVQ, but it's another topic.
>>
>> My point of this discussion is that we cannot enable features just
>> because they are sufficiently old or because the user claims QEMU runs
>> on Linux sufficiently new. eBPF requires privilege, and vDPA requires
>> hardware feature. A fallback is not a silver bullet either, and there
>> are situations that providing a fallback is not a trivial task.
> 
> To make sure we are on the same page. I just want to point out that
> eBPF RSS is not a good example in this context.
> 
> It works only for tuntap, so we should stick to the behaviour of
> trying to fallback to userspace if we can as we've already had a
> userspace fallback. This is the fundamental difference with other
> features (like segmentation offload) or backend (vDPA) that doesn't
> have an existing fallback.

Some (probably not all) offloads are implemented in hw/net/net_tx_pkt.c. 
They are not wired up to behave as a fallback when tuntap's vhost is 
enabled as the in-QEMU RSS is not. In either case, we need to pay some 
effort to wiring things.

I'm not sure it is worthwhile. I think there is a high chance that 
selectively disabling vhost and keeping RSS enabled with fallback will 
result in worse performance than keeping vhost enabled and disabling 
RSS. Such a fallback can still function as an emergency escape hatch, 
but it is also incomplete as we don't have fallbacks for other features. 
I would rather make any features missing in the vhost backend fail to 
keep things consistent.

Regards,
Akihiko Odaki


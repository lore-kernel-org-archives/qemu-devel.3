Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFA5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 07:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sas8I-00026Z-7o; Mon, 05 Aug 2024 03:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sas8H-000266-9A
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:27:53 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sas8E-00012D-T5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:27:53 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cf98ba0559so5435134a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722842869; x=1723447669;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WEcnKxM26QCAmU8OuRDs2l1WoeZmP4wJpzI3LYIASN4=;
 b=ouCtOthEMVdL3J6QvlUCzV0rRfKRawP16nw/yXamjjtPJJQo93q44i2gfQeDlOZ2nw
 5GkN1oFQ86vbnijsm/R28JoqtmUJK5u154/Oi99qOkzrzBdwBaEX03J8jh5ygzxg5W8o
 vncnJgic81DxZjoJNkijXxxfoeLsdmcsYiW9RXqO2dpM2u08rKFJMuHBS76bJK/9/oXQ
 sNohjiE8N8qMQ1nOrYQDItdp83+PImgZaQp+EzVP9Sb+PCfjZvjWTVIuu047oPpMeTAu
 Ehvru/lzQFfxm52bgH1+OP/Y+ZpGRjip/C1jo+WMZRgZvYEU2ois9XA4sUrV80EtjTE2
 HVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722842869; x=1723447669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEcnKxM26QCAmU8OuRDs2l1WoeZmP4wJpzI3LYIASN4=;
 b=q5wc0SKiIrh2TfKC/gHOlnr7U3D9axZE/hsVNFtTnXUqIqOkBeUm69aX9ZrhMPxJmY
 qJFoeh4vf41VPak5X9scJM6oQM3aFLHJSqpBSBrETQsPdz75ejA6oDPPX+bUOvP0mbEW
 sYXrfMap50b+qvw85bTxPfLPoB2UJ8WW/O1J8fuLyy5wDzwjb7TZSTfwAITyYhGnWHqy
 v78Q3OpT8QyiLukF95OeRo5Vat1XpgLXgJFSyLwXupJx8UNrIxCpmGCNaCFpxX+OAof9
 pssua6WronH6NVGayzGX5o2wrLy1Hg/Y0Xc6SycNxki+L9MizHGJ/v3fowrIyV8L4MM7
 qoFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeoDzHYp3Au3NHWPnAEqF0fpTVLfOZeqE5T9BZk/EaESITNTuvifN60loXtc5Bx7pCzbid3qTtkLfCxrQt1V/iqOaPVnY=
X-Gm-Message-State: AOJu0Ywsu+ErV9YJRpQzjwyHssReyKC+4pEG2hNw8PZILE/wcfYlula/
 zYtr8l7HpMQGNP5juKUIRHKD/85G9s4RsFmUL1lKuZyewJGwcMYslwx/RN22rrw=
X-Google-Smtp-Source: AGHT+IH3vBERfzhNwqfmwXmY/UvMu2CHSHZU84XfXGTXu7bKJei6dYE2+CAEl3akM/jvZ+QZrL5OYQ==
X-Received: by 2002:a17:90a:788a:b0:2cf:f3e9:d5c9 with SMTP id
 98e67ed59e1d1-2cff94581b3mr9316262a91.21.1722842869092; 
 Mon, 05 Aug 2024 00:27:49 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4064c3sm9670369a91.10.2024.08.05.00.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 00:27:48 -0700 (PDT)
Message-ID: <d94e8fda-23bb-4905-b656-3e1cb247079d@daynix.com>
Date: Mon, 5 Aug 2024 16:27:43 +0900
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
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n> <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n> <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n> <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n> <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <Zq99NcMkDMkDKBLv@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zq99NcMkDMkDKBLv@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

On 2024/08/04 22:08, Peter Xu wrote:
> On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
>> On 2024/08/03 1:26, Peter Xu wrote:
>>> On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
>>>>>>> I'm not sure if I read it right.  Perhaps you meant something more generic
>>>>>>> than -platform but similar?
>>>>>>>
>>>>>>> For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
>>>>>>> "perf" or "compat", while by default to "compat"?
>>>>>>
>>>>>> "perf" would cover 4) and "compat" will cover 1). However neither of them
>>>>>> will cover 2) because an enum is not enough to know about all hosts. I
>>>>>> presented a design that will cover 2) in:
>>>>>> https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
>>>>>
>>>>> "-merge-platform" shouldn't be a QEMU parameter, but should be something
>>>>> separate.
>>>>
>>>> Do you mean merging platform dumps should be done with another command? I
>>>> think we will want to know the QOM tree is in use when implementing
>>>> -merge-platform. For example, you cannot define a "platform" when e.g., you
>>>> don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
>>>> connected to virtio-net devices. Of course we can include those information
>>>> in dumps, but we don't do so for VMState.
>>>
>>> What I was thinking is the generated platform dump shouldn't care about
>>> what is used as backend: it should try to probe whatever is specified in
>>> the qemu cmdline, and it's the user's job to make sure the exact same qemu
>>> cmdline is used in other hosts to dump this information.
>>>
>>> IOW, the dump will only contain the information that was based on the qemu
>>> cmdline.  E.g., if it doesn't include virtio device at all, and if we only
>>> support such dump for virtio, it should dump nothing.
>>>
>>> Then the -merge-platform will expect all dumps to look the same too,
>>> merging them with AND on each field.
>>
>> I think we will still need the QOM tree in that case. I think the platform
>> information will look somewhat similar to VMState, which requires the QOM
>> tree to interpret.
> 
> Ah yes, I assume you meant when multiple devices can report different thing
> even if with the same frontend / device type.  QOM should work, or anything
> that can identify a device, e.g. with id / instance_id attached along with
> the device class.
> 
> One thing that I still don't know how it works is how it interacts with new
> hosts being added.
> 
> This idea is based on the fact that the cluster is known before starting
> any VM.  However in reality I think it can happen when VMs started with a
> small cluster but then cluster extended, when the -merge-platform has been
> done on the smaller set.
> 
>>
>>>
>>> Said that, I actually am still not clear on how / whether it should work at
>>> last.  At least my previous concern (1) didn't has a good answer yet, on
>>> what we do when profile collisions with qemu cmdlines.  So far I actually
>>> still think it more straightforward that in migration we handshake on these
>>> capabilities if possible.
>>>
>>> And that's why I was thinking (where I totally agree with you on this) that
>>> whether we should settle a short term plan first to be on the safe side
>>> that we start with migration always being compatible, then we figure the
>>> other approach.  That seems easier to me, and it's also a matter of whether
>>> we want to do something for 9.1, or leaving that for 9.2 for USO*.
>>
>> I suggest disabling all offload features of virtio-net with 9.2.
>>
>> I want to keep things consistent so I want to disable all at once. This
>> change will be very uncomfortable for us, who are implementing offload
>> features, but I hope it will motivate us to implement a proper solution.
>>
>> That said, it will be surely a breaking change so we should wait for 9.1
>> before making such a change.
> 
> Personally I don't worry too much on other offload bits besides USO* so far
> if we have them ON for longer time.  My wish was that they're old good
> kernel features mostly supported everywhere who runs QEMU, then we're good.

Unfortunately, we cannot expect everyone runs Linux, and the offload 
features are provided by Linux. However, QEMU can run on other 
platforms, and offload features may be provided by vhost-user or vhost-vdpa.

> 
> And I definitely worry about future offload features, or any feature that
> may probe host like this and auto-OFF: I hope we can do them on the safe
> side starting from day1.
> 
> So I don't know whether we should do that to USO* only or all.  But I agree
> with you that'll definitely be cleaner.
> 
> On the details of how to turn them off properly..  Taking an example if we
> want to turn off all the offload features by default (or simply we replace
> that with USO-only)..
> 
> Upstream machine type is flexible to all kinds of kernels, so we may not
> want to regress anyone using an existing machine type even on perf,
> especially if we want to turn off all.
> 
> In that case we may need one more knob (I'm assuming this is virtio-net
> specific issue, but maybe not; using it as an example) to make sure the old
> machine types perfs as well, with:
> 
>    - x-virtio-net-offload-enforce
> 
>      When set, the offload features with value ON are enforced, so when
>      the host doesn't support a offload feature it will fail to boot,
>      showing the error that specific offload feature is not supported by the
>      virtio backend.
> 
>      When clear, the offload features with value ON are not enforced, so
>      these features can be automatically turned OFF when it's detected the
>      backend doesn't support them.  This may bring best perf but has the
>      risk of breaking migration.

"[PATCH v3 0/5] virtio-net: Convert feature properties to OnOffAuto" 
adds "x-force-features-auto" compatibility property to virtio-net for 
this purpose:
https://lore.kernel.org/r/20240714-auto-v3-0-e27401aabab3@daynix.com

> 
> With that,
> 
>    - On old machine types (compat properties):
> 
>      - set "x-virtio-net-offload-enforce" OFF
>      - set all offload features ON
> 
>    - On new machine types (the default values):
> 
>      - set "x-virtio-net-offload-enforce" ON
>      - set all offload features OFF
> 
> And yes, we can do that until 9.2, but with above even 9.1 should be safe
> to do.  9.2 might be still easier just to think everything through again,
> after all at least USO was introduced in 8.2 so not a regress in 9.1.
> 
>>
>> By the way, I am wondering perhaps the "no-cross-migrate" scenario can be
>> implemented relatively easy in a way similar to compatibility properties.
>> The idea is to add the "no-cross-migrate" property to machines. If the
>> property is set to "on", all offload features of virtio-net will be set to
>> "auto". virtio-net will then probe the offload features and enable available
>> offloading features.
> 
> If it'll become a device property, there's still the trick / concern where
> no-cross-migrate could conflict with the other offload feature that was
> selected explicilty by an user (e.g. no-cross-migrate=ON + uso=OFF).
With no-cross-migrate=ON + uso=OFF, no-cross-migrate will set uso=auto, 
but the user overrides with uso=off. As the consequence, USO will be 
disabled but all other available offload features will be enabled.

Regards,
Akihiko Odaki


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C343CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfu0L-0007zv-80; Mon, 19 Aug 2024 00:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sftzG-0002lK-Es
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:27:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sftzE-0005Gq-0Z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:27:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-202508cb8ebso1588205ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724041638; x=1724646438;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09PFNf1vQJFvM+ORXRgNgw85VoFCwA1lS4MjO4jnEjE=;
 b=a+8B08nR2fH3DedAbUP1EXzyCT9LENo3H0cQFrkgIXfXjQIBhJkKC+J9mQxC2spoNG
 6kxxVNL2/tJ3wmHRfJ8PC4AlVdpcgnPpYrCaoTJ1SjuoSb5VfPvH2pNUDa6s0b90hDzK
 t1Rkg+Gcnh3dYrIrpHTNpSMC6DLhB2k6+C8mtq8EHnwPadziPxqx8jaipAR/i+SWxBRq
 D+qG1oPIxHrDsq7MHuC9AEhkRj+pL9APfzrFbhKETveC99p6hJ7TGgaTH9kVpisPQ1Ak
 72rnZpR4dnCMEj5ucVtvG9rAnS2XH50eTZoWQ3RVGvmieQMKYqUjLUzxYGUXOui9x66s
 Iohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041638; x=1724646438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09PFNf1vQJFvM+ORXRgNgw85VoFCwA1lS4MjO4jnEjE=;
 b=RibpL3VNlayaQGtwcdeDF0vuUnupB9OZ+FkJSiCc5M2vGMF3MUF7gfSt1pRtIAYmPV
 nyLgCP/uMNJ03zlxz1jI241oIdxAHPLTBmHFssxviUXL1GcUm0ZXjUONSScnX4HecH1K
 XMkgyQVu8u4sXFPM2/AKjgfcJx3ghX0gQ3FPLDyHp5oFK2Ot5ndZy4ZJ3YCWlLNdbzFE
 +ClXYuyqXgQt8Vd1JW/EM7yszIKkGvt0hG6FkywZVHuT8EcPy9HZJGrqSlOx4cVycsQt
 mmx0tcAjsVn4FMV1AdvTXRmeN1Mpa/jyF/QP2c5GtLbP21mxl3YsMOiJd4Pfix62eXOr
 Yo/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2sfXv+tTTbv5VqFMuKkxih7ULPx5c7YWiT1sJ9jd5OGpu5sFSoLXeGlBKs2xPG14cCGP7ZH/k5pitFh7qKrKZba8To0=
X-Gm-Message-State: AOJu0YyPv94LEbm4H5k71gjIUti/jPfmpRm7o4A6ArJNk2C6M3FbXFTh
 4s60BBiWMEUxCrPmP6smPqtalGRGz2owk5/TneYvk+kj+I1TQkshuWONfmE2f4A=
X-Google-Smtp-Source: AGHT+IF6uTjovusHEtj6quscv/Z/p8oYd/dw9ADKNvQZn0aD1cdEHs8QkW0LiJJK9DfqBWId/9vdTA==
X-Received: by 2002:a17:902:c942:b0:1fd:a412:5ded with SMTP id
 d9443c01a7336-20203ea09f8mr111629345ad.26.1724041638060; 
 Sun, 18 Aug 2024 21:27:18 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f031cbfdsm56195805ad.114.2024.08.18.21.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:27:17 -0700 (PDT)
Message-ID: <3e46fb88-cd12-4bdd-ba3a-49ffa56e127e@daynix.com>
Date: Mon, 19 Aug 2024 13:27:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, devel@lists.libvirt.org
References: <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org> <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org> <ZrTjaZPyjDuJZK36@x1n>
 <8734ndhncb.fsf@suse.de> <7a330bb1-ca53-41b5-ae97-aec8694fc325@daynix.com>
 <20240818030325-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240818030325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/18 16:03, Michael S. Tsirkin wrote:
> On Sun, Aug 18, 2024 at 02:04:29PM +0900, Akihiko Odaki wrote:
>> On 2024/08/09 21:50, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
>>>>> On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
>>>>>> On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
>>>>>>> This is too big of a hammer. People already use what you call "cross
>>>>>>> migrate" and have for years. We are not going to stop developing
>>>>>>> features just because someone suddenly became aware of some such bit.
>>>>>>> If you care, you will have to work to solve the problem properly -
>>>>>>> nacking half baked hacks is the only tool maintainers have to make
>>>>>>> people work on hard problems.
>>>>>>
>>>>>> IMHO this is totally different thing.  It's not about proposing a new
>>>>>> feature yet so far, it's about how we should fix a breakage first.
>>>>>>
>>>>>> And that's why I think we should fix it even in the simple way first, then
>>>>>> we consider anything more benefitial from perf side without breaking
>>>>>> anything, which should be on top of that.
>>>>>>
>>>>>> Thanks,
>>>>>
>>>>> As I said, once the quick hack is merged people stop caring.
>>>>
>>>> IMHO it's not a hack. It's a proper fix to me to disable it by default for
>>>> now.
>>>>
>>>> OTOH, having it ON always even knowing it can break migration is a hack to
>>>> me, when we don't have anything else to guard the migration.
>>>>
>>>>> Mixing different kernel versions in migration is esoteric enough for
>>>>> this not to matter to most people. There's no rush I think, address
>>>>> it properly.
>>>>
>>>> Exactly mixing kernel versions will be tricky to users to identify, but
>>>> that's, AFAICT, exactly happening everywhere.  We can't urge user to always
>>>> use the exact same kernels when we're talking about a VM cluster.  That's
>>>> why I think allowing migration to work across those kernels matter.
>>>
>>> I also worry a bit about the scenario where the cluster changes slightly
>>> and now all VMs are already restricted by some option that requires the
>>> exact same kernel. Specifically, kernel changes in a cloud environment
>>> also happen due to factors completely unrelated to migration. I'm not
>>> sure the people managing the infra (who care about migration) will be
>>> gating kernel changes just because QEMU has been configured in a
>>> specific manner.
>>
>> I have wrote a bit about the expectation on the platform earlier[1], but let
>> me summarize it here.
>>
>> 1. I expect the user will not downgrade the platform of hosts after setting
>> up a VM. This is essential to enable any platform feature.
>>
>> 2. The user is allowed to upgrade the platform of hosts gradually. This
>> results in a situation with mixed platforms. The oldest platform is still
>> not older than the platform the VM is set up for. This enables the gradual
>> deployment strategy.
>>
>> 3. the user is allowed to downgrade the platform of hosts to the version
>> used when setting up the VM. This enables rollbacks in case of regression.
>>
>> With these expectations, we can ensure migratability by a) enabling platform
>> features available on all hosts when setting up the VM and b) saving the
>> enabled features. This is covered with my
>> -dump-platform/-merge-platform/-use-platform proposal[2].
> 
> I really like [2]. Do you plan to work on it? Does anyone else?

No, but I want to move "[PATCH v3 0/5] virtio-net: Convert feature 
properties to OnOffAuto" forward:
https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/

This will clarify the existence of the "auto" semantics, which is to 
enable a platform feature based on availability. [2] will be regarded as 
a feature to improve the handling of the "auto" semantics once this 
change lands.

Regards,
Akihiko Odaki

> 
>> Regards,
>> Akihiko Odaki
>>
>> [1]
>> https://lore.kernel.org/r/2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com
>> [2]
>> https://lore.kernel.org/all/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com/
> 


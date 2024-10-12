Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13918D1A44A
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 08:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szX9r-0000V1-3M; Sat, 12 Oct 2024 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szX9o-0000U0-Jh
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 04:07:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szX9m-00076N-H6
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 04:07:24 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b90984971so26540685ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728720441; x=1729325241;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9/KxBQsv3l0dljXkJqxkRh1WUn1vafXumv2nx4CPD0=;
 b=HmjJrFXxmsIfUN7CoYTz4/Gp+ZxErpu8AfIe98BSTJ7fbD9UZgnzE5CMLSBIejNizU
 UySk5IgJrORqYVD9NfC1xxVXeTeDvAXmI0Age1liBOwsJkTnXEast2q6E3h7r07qpE4B
 ToZ34Fxg7bnH/wrvr27EWWGWqwVC9sGdu6BJY06UOWCLDuKtgZEyYZ5/SZh2YxGl9CKG
 x+VDM5Tee3XMz8H8WmqrzGwoyT+cSN05z0ggoqlNW9YHpoxSvEUZgGEgrHP/AyNkMNp+
 o95Z/7OAwA5el7VAwx2oaR4mVXx39imxvRRYAMRSYXf3CwMT+uK8f2dAXcvR74HLFPBP
 Il0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728720441; x=1729325241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9/KxBQsv3l0dljXkJqxkRh1WUn1vafXumv2nx4CPD0=;
 b=l/0KEiIMenU2gYog+jmsDQI3N/xPyMDRI91rAxNjtuD4LdYv2jmbs7e6yrek6EFSa5
 F9cCN+tBt+4Zg67CQ2cKQLVk8yumYGHqDu3D3Pw5SqbIAyP90+cAZi4ywPXPMYPh5Ro0
 6zVNDnQbw/6m+X9jT8LV2q7qJEpqeDIbjeazYAV9xTQDTQOyfo+GGGta1Q3mnlnQt5fj
 Lx9yUMineUUK91pR7jk2+pUu5yj0XXGK2okRcEOBFKsJ9h3gxU8cJHkq/eG3QBDPh/ua
 NpiOqGcVu2OL8Wwk1xaxsfezWUsp4i5Ks/2xJi9KRDj/iWqt/fDXZL6OTzc4HtbXR8oG
 1s+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDipN1m80DhcVVfic1lh5Lmifmjfp1bV4DFkVaoJrtXFbXdMXx8frcIRLMf8EIpN7LrdASLR/ofw9E@nongnu.org
X-Gm-Message-State: AOJu0YzkpGDoIuKctm+A2oH0iXIG1Sp4tX4M2HBYSokrXYbk3lQR18zj
 5MX+tbWZoZwRNmmvZqPJEio5Xt5QrbB31KWl6HN9v/NGlf5gPKKR/9+ZuHQQUII=
X-Google-Smtp-Source: AGHT+IHdiJguaGKJcEIufmU8/SWVUTGXrHBj2QRR3ETWUVVIlyNZSdJHXc55u2gyWrfAQj+k3sUXbA==
X-Received: by 2002:a17:902:ce81:b0:20b:8036:f784 with SMTP id
 d9443c01a7336-20ca167bce0mr82079455ad.32.1728720440736; 
 Sat, 12 Oct 2024 01:07:20 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c33ff19sm33537835ad.272.2024.10.12.01.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 01:07:20 -0700 (PDT)
Message-ID: <16a3bae8-47f9-49c3-b464-07d2b25bd144@daynix.com>
Date: Sat, 12 Oct 2024 17:07:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Prohibit calling object_unparent() for memory
 region
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
 <CAFEAcA_n1nURHRAt6LXZSJ_b20VarMdbV56=_XTunMYQPosObA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_n1nURHRAt6LXZSJ_b20VarMdbV56=_XTunMYQPosObA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2024/10/08 22:33, Peter Maydell wrote:
> On Thu, 29 Aug 2024 at 06:46, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> Hi; sorry it's taken me so long to get back to this patch,
> but I've now re-read some of the discussion in the other threads.
> I generally agree with your reasoning and think we do need
> to update the docs here.
> 
> I think we could be more specific in this commit message; I've
> suggested some expansions of it below. (Partly this is for
> my own benefit working through what's going on.)
> 
>> Previously it was allowed to call object_unparent() for a memory region
>> in instance_finalize() of its parent. However, such a call typically
>> has no effect because child objects get unparented before
>> instance_finalize().
> 
> "because child objects are properties of their owner object, and
> (since commit 76a6e1cc7cc3a) we delete an object's properties before
> calling the object's instance_finalize method. Deleting the
> child property will unparent the child; the later calls to
> object_unparent() in its owner's instance_finalize will do nothing.".
> 
>> Worse, memory regions typically gets finalized when they get unparented
>> before instance_finalize().
> 
> "before instance_finalize(), because the only reference to the
> MemoryRegion is the one we hold because it is a child property
> of its owner, and so when object_finalize_child_property()
> calls object_unref(child) the refcount drops to zero and
> we finalize the MR."
> 
>> This means calling object_unparent() for
>> them in instance_finalize() is to call the function for an object
>> already finalized, which should be avoided.
> 
> "This doesn't cause any bad effects in the common case where we
> know that the memory allocated for the MemoryRegion itself
> is still valid, such as in the common case where the MR
> struct is directly embedded in its owner's device state struct.
> But it could potentially cause a crash if the MemoryRegion
> struct was somewhere else and was freed.

It won't cause a crash even if the MR struct is not embedded as long as 
the data structure is freed in the instance_finalize callback. I suggest 
the following:

"This doesn't cause any bad effects in the common case where the
data structure is managed by the owner because the memory allocated for
the MemoryRegion itself is valid until the owner is also finalized.
However, it is still semantically wrong to touch the MemoryRegion after
its finalization and confusing."

Your other suggestions look good so I'll apply them with v2.

> 
> Update the documentation to explicitly prohibit calling
> object_unparent() in instance_finalize."
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> ---
>>   docs/devel/memory.rst | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
>> index 69c5e3f914ac..83760279e3db 100644
>> --- a/docs/devel/memory.rst
>> +++ b/docs/devel/memory.rst
>> @@ -168,11 +168,10 @@ and VFIOQuirk in hw/vfio/pci.c.
> 
> Don't we need also to change the paragraph before this, which
> reads:
> 
>> If however the memory region is part of a dynamically allocated data
>> structure, you should call object_unparent() to destroy the memory region
>> before the data structure is freed.  For an example see VFIOMSIXInfo
>> and VFIOQuirk in hw/vfio/pci.c.
> 
> ?
> 
> Otherwise we have a paragraph that says "you should call
> object_unparent()" followed by one that says "do not call
> object_unparent()".

You are right. I'll remove the statement.

> 
> (Also that paragraph's reference to VFIOMSIXInfo is now
> out of date -- in 2017 we removed the embedded MemoryRegion
> from that struct.)
> 
>>   You must not destroy a memory region as long as it may be in use by a
>>   device or CPU.  In order to do this, as a general rule do not create or
>> -destroy memory regions dynamically during a device's lifetime, and only
>> -call object_unparent() in the memory region owner's instance_finalize
>> -callback.  The dynamically allocated data structure that contains the
>> -memory region then should obviously be freed in the instance_finalize
>> -callback as well.
>> +destroy memory regions dynamically during a device's lifetime, and do not
>> +call object_unparent().  The dynamically allocated data structure that contains
>> +the memory region then should be freed in the instance_finalize callback, which
>> +is called after it gets unparented.
> 
> I think some of these lines are a touch over-length, and should
> be wrapped a bit earlier.

I'll wrap them by 72 columns.

> 
> Also, this now says "don't unparent in finalize", but
> vfio_bars_finalize() has code which follows the old documentation:
> 
>      if (vdev->vga) {
>          vfio_vga_quirk_finalize(vdev);
>          for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
>              object_unparent(OBJECT(&vdev->vga->region[i].mem));
>          }
>          g_free(vdev->vga);
>      }
> 
> Is this wrong and needs changing?

I'll add a patch to remove object_unparent() calls from hw/vfio/pci.c 
with v2.

Regards,
Akihiko Odaki

> 
>>   If you break this rule, the following situation can happen:
>>
>> @@ -199,8 +198,9 @@ but nevertheless it is used in a few places.
>>
>>   For regions that "have no owner" (NULL is passed at creation time), the
>>   machine object is actually used as the owner.  Since instance_finalize is
>> -never called for the machine object, you must never call object_unparent
>> -on regions that have no owner, unless they are aliases or containers.
>> +never called for the machine object, you must never free regions that have no
>> +owner, unless they are aliases or containers, which you can manually call
>> +object_unparent() for.
> 
> thanks
> -- PMM



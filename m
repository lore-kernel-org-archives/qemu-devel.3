Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D76CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76Cq-00042e-Gm; Fri, 10 Oct 2025 02:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v76Cm-000410-8L; Fri, 10 Oct 2025 02:02:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v76Ci-0005U3-74; Fri, 10 Oct 2025 02:02:15 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59A5tgtt035371
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 14:55:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0P4w0OYm6ufqbmzDUCCHp2xxLmutRkyQKj7l+mZLozg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760075743; v=1;
 b=KxQtgKw5cvPAq/61nSzZuaHPN2+00zGPbAdHVVdz3qXkAvoYKJMKCOt7i/3p2nJS
 d21RJaJINxDytoO4m8YGoBmuQTg4PA9+uBFpwy9McCAL9A9Xtn1veDkiOgbBCbWN
 4WYn548gvwNWy23Wo/5S6r3fU/9N1Fmx6cvnHcGNZnkulbcMeqb3vm4beAoXo8Ku
 1BDvqCPzzEL7MmEas4dBJFt+xkx4pr4/ErEmO5EaZOmdsSZgvzXtOw0gineWx2Nh
 qT+FIHw283UU3qZmzpDKb9gbMhH1RY58/3Lq52FO/9oZikrmFstzyj2pn1pX3WxL
 CRA81Vhcul/lB1d6cLYwmA==
Message-ID: <13f5ba0b-8747-4c2d-af7c-d7ed3c2771a7@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 14:55:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] qdev: Automatically delete memory subregions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <aN7RHvjeQNtrXDcQ@x1.local> <aN7VH0j8HfaeRV1V@x1.local>
 <32e36e0c-c947-4fa4-bdbf-5ef3ce6ea0a3@rsg.ci.i.u-tokyo.ac.jp>
 <aN_rLDLeMcvRtmAa@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aN_rLDLeMcvRtmAa@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/04 0:26, Peter Xu wrote:
> On Fri, Oct 03, 2025 at 11:01:38PM +0900, Akihiko Odaki wrote:
>> On 2025/10/03 4:40, Peter Xu wrote:
>>> On Thu, Oct 02, 2025 at 03:23:10PM -0400, Peter Xu wrote:
>>>> On Wed, Sep 17, 2025 at 07:32:48PM +0900, Akihiko Odaki wrote:
>>>>> +static int del_memory_region(Object *child, void *opaque)
>>>>> +{
>>>>> +    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
>>>>> +
>>>>> +    if (mr && mr->container) {
>>>>> +        memory_region_del_subregion(mr->container, mr);
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    static void device_set_realized(Object *obj, bool value, Error **errp)
>>>>>    {
>>>>>        DeviceState *dev = DEVICE(obj);
>>>>> @@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>>>>>            if (dc->unrealize) {
>>>>>                dc->unrealize(dev);
>>>>>            }
>>>>> +        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
>>>>
>>>> PS: I'll keep throwing some pure questions here, again, Paolo - it doesn't
>>>> need to block merging if you're confident with the general approach.
>>>>
>>>> Said that, a few things I still want to mention after I read this series..
>>>>
>>>> One thing I really feel hard to review such work is, you hardly describe
>>>> the problems the series is resolving.
>>>>
>>>> For example, this patch proposed auto-detach MRs in unrealize() for qdev,
>>>> however there's nowhere describing "what will start to work, while it
>>>> doesn't", "how bad is the problem", etc..  All the rest patches are about
>>>> "what we can avoid do" after this patch.
>>>
>>> For this part, I should be more clear on what I'm requesting on the
>>> answers.
>>>
>>> I think I get the whole point that MRs (while still with MR refcount
>>> piggypacked, as of current QEMU master does) can circular reference itself
>>> if not always detached properly, so explicitly my question is about:
>>>
>>> - What devices / use case you encountered, that QEMU has such issue?
>>>     Especially, this is about after we have merged commit ac7a892fd3 "memory:
>>>     Fix leaks due to owner-shared MRs circular references".  Asking because I
>>>     believe most of them should already auto-detach when owner is shared.
>>>
>>> - From above list of broken devices, are there any devices that are
>>>     hot-unpluggable (aka, high priority)?  Is it a problem if we do not
>>>     finalize a MR if it is never removable anyway?
> 
> [1]
> 
>>>
>>>>
>>>> Meanwhile, the cover letter is misleading. It is:
>>>>
>>>> [PATCH 00/14] Fix memory region use-after-finalization
>>>>
>>>> I believe it's simply wrong, because the whole series is not about
>>>> finalize() but unrealize().  For Device class, it also includes the exit()
>>>> which will be invoked in pci_qdev_unrealize(), but that is also part of the
>>>> unrealize() routine, not finalize().
>>
>> The subject of the cover letter "fix memory region use-after-finalization"
>> is confusing. While this series has such fixes, it also contain refactoring
>> patches. The cover letter says:
>>
>>> Patch "qdev: Automatically delete memory subregions" and the
>>> succeeding patches are for refactoring, but patch "vfio-user: Do not
>>> delete the subregion" does fix use-after-finalization.
>>
>> More concretely, patch "qdev: Automatically delete memory subregions"
>> implements a common pattern of device unrealization, and the suceeding
>> patches remove ad-hoc implementations of it.
>>
>> And since patch "hw/pci-bridge: Do not assume immediate MemoryRegion
>> finalization" fixes nothing as you pointed out, only patch "vfio-user: Do
>> not delete the subregion" fixes something.
>>
>> Without patch "vfio-user: Do not delete the subregion",
>> vfio_user_msix_teardown() calls memory_region_del_subregion(). However, this
>> function is called from instance_finalize, so the subregion is already
>> finalized and results in a use-after-finalization scenario.
>>
>> Anything else is for refactoring and it's quite unlike patch "memory: Fix
>> leaks due to owner-shared MRs circular references", which is a bug fix.
>>
>> I think I'll drop patch "hw/pci-bridge: Do not assume immediate MemoryRegion
>> finalization" and rename this series simply to "qdev: Automatically delete
>> memory subregions" to avoid confusion.
> 
> Yes, thanks.  I went over quite a few follow up patches but I missed this
> one.  IMHO you can also split the only fix out, so that can be better
> looked at by vfio-user developers.  It'll also be easier for them to verify
> if they want.

I'll split the VFIO patch out since I found patch "qdev: Automatically 
delete memory subregions" is unnecessary; I'll describe that later.

> 
>>
>>>>
>>>> The other question is, what if a MR has a owner that is not the device
>>>> itself?  There's no place enforcing this, hence a qdev can logically have
>>>> some sub-objects (which may not really be qdev) that can be the owner of
>>>> the memory regions.  Then the device emulation will found that some MRs are
>>>> auto-detached and some are not.
>>>>
>>>> One example that I'm aware of is this:
>>>>
>>>> https://lore.kernel.org/all/20250910115420.1012191-2-aesteve@redhat.com/#t
>>>>
>>>> TYPE_VIRTIO_SHARED_MEMORY_MAPPING is an object, not qdev here, which can be
>>>> the owner of the MR.
>>
>> Patch "qdev: Automatically delete memory subregions" and the succeeding
>> patches are for refactoring of qdev. MRs not directly owned by qdev are out
>> of scope of the change.
> 
> Do you have a rough answer of above question [1], on what might suffer from
> lost MRs?  I sincerely want to know how much we are missing after we could
> already auto-detach owner-shared MRs.

There is no functionally "broken" device. The patch that does fix 
something is the VFIO patch, and it fixes use-after-finalization, which 
is semantically problematic but does not cause a functional problem 
(like use-after-free).

> 
>  From a quick glance, at least patch 4-14 are detaching MRs that shares the
> same owner.  IIUC, it means at least patch 4-14 do not rely on patch 2.

If the container and the subregion shares the same owner, 
memory_region_del_subregion() is unnecessary in the first place and can 
be removed even without patch 2, and it seems there are a number of such 
unnecessary memory_region_del_subregion() calls.

That said, there are cases where memory_region_del_subregion() is truly 
needed. In general, a device exposes its MMIO functionality to the guest 
by adding its memory region to external containers, so there should be 
some containers and subregions that do not share memory regions.

Reviewing removed memory_region_del_subregion() calls in each patch, 
patch 3, 6, 7, 8, 9, 10, 13, and 14 are for memory regions with shared 
owners (that's why patch 3 can be applied without the qdev patch).
Patch 4, 5, 11 and 12 are for memory regions with different owners.

The point here is that we don't have to care whether memory regions 
share owners if we delete all subregions for defensive programming.

> 
> Then I wonder how much patch 2 helps in real life.
> 
> There's indeed a difference though when a qdev may realize(), unrealize()
> and realize() in a sequence, in which case patch 2 could help whil commit
> ac7a892fd3 won't, however I don't know whether there's real use case,
> either.

It is not relevant what order realize() and unrealize() are performed. 
This patch is to de-duplicate the code to unrealize devices, and commit 
ac7a892fd3 fixes a bug instead.

> 
> I also wished if there's such device, it'll have explicit detach code so
> that when I debug a problem on the device I can easily see when the MRs
> will be available, instead of remembering all the rules when something in
> some layer will auto-detach...

Indeed, people who read the implementation of devices wonder where are 
memory_region_del_subregion() calls that corresponding to 
memory_region_add_subregion() calls they see.

That said, anyone who cares device code already needs to know that 
subregions (that do not share owners) need to be deleted during 
unrealization, or devices will remain visible to the guest. I see 
avoiding this consequence is important, and it is just nice to have less 
code by de-deuplicating the memory_del_subregion() calls.

> 
> Personally I think such automation adds burden to developers' mind if
> there're still a bunch of MRs that are not used in this way (there
> definitely are, otherwise we should be able to completely unexport
> memory_region_del_subregion). But that's subjective; I believe at least
> Paolo agrees with your general approach.

Indeed, memory_region_del_subregion() is still necessary for memory 
regions that are not directly owned by devices. This is a trade-off 
situation so there is no clear answer what's the best.

Regards,
Akihiko Odaki


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C55CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYkG-0003xc-5l; Fri, 19 Sep 2025 06:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzYk8-0003rJ-9e; Fri, 19 Sep 2025 06:53:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzYk5-0007Rk-2i; Fri, 19 Sep 2025 06:53:31 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58JAkcQT033756
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 19:46:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rWCFvrSz0E2oCjuTU959aed1+QCvq+UCU8sf+vOrvRg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758278798; v=1;
 b=CJhWqRXMK7EVEqt5O4fzgwRHkpbvNlCZaOFGT2JRrokvtE+QlXyrJW49lss+htTp
 KFQ9E4TwLqRPpCtI4tDvZhlu5p+VEeAg5rZ5h32ZHa35LPKVJVUy9pwNtE/60NSZ
 qq56vOq+zd3BaQf/Jvtr0LJAzESnC/31asffQw6Px03Q2E14OlyKOsrSBsT9SdS/
 sf6iBD4VFClJOHPImJDN5/M2qkalIoEDAePrmpoDFSsBz1S0IDQSBvgwEmvShJG+
 6hbf/Npf5//RO3LzPxRwYamdTAldhiXOb0FjhvPd7Yg15U62VVBLFDiaTcrYKflb
 uoErgJ/vf6oO0EVI+zRkug==
Message-ID: <7511a948-10ef-4325-9818-35775c522aee@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 19 Sep 2025 19:46:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] docs/devel: Do not unparent in instance_finalize()
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
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-use-v3-1-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <aMxlpfp_LSgiIk9Z@x1.local> <aMxnj7ID0PpWUVNu@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aMxnj7ID0PpWUVNu@x1.local>
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

On 2025/09/19 5:11, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 04:03:49PM -0400, Peter Xu wrote:
>> On Wed, Sep 17, 2025 at 07:13:26PM +0900, Akihiko Odaki wrote:
>>> Children are automatically unparented so manually unparenting is
>>> unnecessary.
>>>
>>> Worse, automatic unparenting happens before the instance_finalize()
>>> callback of the parent gets called, so object_unparent() calls in
>>> the callback will refer to objects that are already unparented, which
>>> is semantically incorrect.
>>>
>>> Remove the instruction to call object_unparent(), and the exception
>>> of the "do not call object_unparent()" rule for instance_finalize().
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   docs/devel/memory.rst | 19 ++++++-------------
>>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
>>> index 57fb2aec76e0..749f11d8a4dd 100644
>>> --- a/docs/devel/memory.rst
>>> +++ b/docs/devel/memory.rst
>>> @@ -161,18 +161,11 @@ or never.
>>>   Destruction of a memory region happens automatically when the owner
>>>   object dies.
>>>   
>>> -If however the memory region is part of a dynamically allocated data
>>> -structure, you should call object_unparent() to destroy the memory region
>>> -before the data structure is freed.  For an example see VFIOMSIXInfo
>>> -and VFIOQuirk in hw/vfio/pci.c.
>>
>> Should we still keep some of these examples?  After the series they'll be
>> doing the right things.  Dynamic MRs are still slightly tricky, I think
>> it's still good to have some references.

I agree. I'll restore it with the next version.

>>
>>> -
>>>   You must not destroy a memory region as long as it may be in use by a
>>>   device or CPU.  In order to do this, as a general rule do not create or
>>> -destroy memory regions dynamically during a device's lifetime, and only
>>> -call object_unparent() in the memory region owner's instance_finalize
>>> -callback.  The dynamically allocated data structure that contains the
>>> -memory region then should obviously be freed in the instance_finalize
>>> -callback as well.
>>> +destroy memory regions dynamically during a device's lifetime.
>>> +The dynamically allocated data structure that contains the
>>> +memory region should be freed in the instance_finalize callback.
>>>   
>>>   If you break this rule, the following situation can happen:
>>>   
>>> @@ -198,9 +191,9 @@ this exception is rarely necessary, and therefore it is discouraged,
>>>   but nevertheless it is used in a few places.
>>>   
>>>   For regions that "have no owner" (NULL is passed at creation time), the
>>> -machine object is actually used as the owner.  Since instance_finalize is
>>> -never called for the machine object, you must never call object_unparent
>>> -on regions that have no owner, unless they are aliases or containers.
>>> +machine object is actually used as the owner.  You must never call
>>> +object_unparent on regions that have no owner, unless they are aliases
>>> +or containers.
>>
>> This looks like a completely separate change.  So we start to allow
>> machines to be finalized now?  I'm not familiar with machine object
>> lifecycles.  Maybe split it out even if it's true?

I intended to remove phrase "since instance_finalize is never called for 
the machine object" because whether instance_finalize is called or not 
is no longer relevant, and thus object_unparent is always prohibited, 
whether regions have owners or not, unless they are aliases or containers.

The statement still mentions "regions that have no owner"; the 
restriction of object_unparent is enforced whether the regions have 
owners, so it is a bit misleading.

> 
> I didn't see anything elsewhere.  If you agree with above, I can queue this
> series with above touched up, then no need to repost.

I guess I will rewrite this patch, restoring the VFIOQuirk example, and 
re-check if this whole section is structured logically and consistently.

Regards,
Akihiko Odaki


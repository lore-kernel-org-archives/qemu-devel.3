Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A96CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNMu-0007U7-Cr; Sat, 30 Aug 2025 11:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1us093-0004Xz-0f; Fri, 29 Aug 2025 10:32:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1us08s-0005Vi-9R; Fri, 29 Aug 2025 10:31:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9821256F31B;
 Fri, 29 Aug 2025 16:31:40 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lqxsGrwcisnQ; Fri, 29 Aug 2025 16:31:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C36756F30F; Fri, 29 Aug 2025 16:31:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7966956F30D;
 Fri, 29 Aug 2025 16:31:38 +0200 (CEST)
Date: Fri, 29 Aug 2025 16:31:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com, 
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org, 
 david@redhat.com, iii@linux.ibm.com, john.levon@nutanix.com, 
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com, 
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 16/22] vfio/pci.c: use QOM casts where appropriate
In-Reply-To: <bc37692f-da9b-44e9-b4db-6ab7edbeaaaf@nutanix.com>
Message-ID: <3b64d555-d564-cf7a-9a0a-ea566a90524d@eik.bme.hu>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-17-mark.caveayland@nutanix.com>
 <d02ef0f5-3c52-7a8a-dc29-1a8c28e70b50@eik.bme.hu>
 <bc37692f-da9b-44e9-b4db-6ab7edbeaaaf@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-268935935-1756477553=:65066"
Content-ID: <39cb9cff-c11a-708f-7aa5-363a70bc60a5@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-268935935-1756477553=:65066
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <fce22f5b-47d2-bd6a-04bd-ef622b499f65@eik.bme.hu>

On Fri, 29 Aug 2025, Mark Cave-Ayland wrote:
> On 15/07/2025 14:38, BALATON Zoltan wrote:
>
>> On Tue, 15 Jul 2025, Mark Cave-Ayland wrote:
>>> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
>>> accessing pdev directly.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>> hw/vfio/pci.c | 202 ++++++++++++++++++++++++++++++--------------------
>>> 1 file changed, 120 insertions(+), 82 deletions(-)
>>> 
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 1093b28df7..fb9eb58da5 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -119,6 +119,7 @@ static void vfio_intx_mmap_enable(void *opaque)
>>> static void vfio_intx_interrupt(void *opaque)
>>> {
>>>     VFIOPCIDevice *vdev = opaque;
>>> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>> 
>> Don't do that. Opaque data is already type checked when it is registered 
>> for the callback and cannot be changed so additional type checking here is 
>> just a performance hit without any advantage. It's OK to do it in less 
>> frequently called functions but don't add unnecessary casts to functions 
>> that can be called a lot.
>
> In general the QOM casts fall into the noise in a standard profile, but I can 
> see how it could be possible they might show up in the interrupt fast path.
>
> I'll look at getting a vfio-pci perf test set up here to see if there is a 
> noticeable effect in this case, and if so think about what the best approach 
> is.

In general, casting opaque pointer of a callback is unnecessary because 
these can be checked once when registered so it's not needed to check 
again at every use. I think this should really be recommended practice to 
not use QOM casts for these opaque pointers of callbacks. A lot of these 
are also in hot path so not adding unnecessary checks is a good idea. In 
this case when you're in the vfio implementation what's wrong with 
accessing internal field of vfio anyway? An object's implemenattion should 
be able to access its own fields so maybe the current way is OK and most 
of this patch is not needed at all.

Regards,
BALATON Zoltan
--3866299591-268935935-1756477553=:65066--


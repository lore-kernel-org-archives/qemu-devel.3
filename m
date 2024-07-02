Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB205C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 17:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhYM-0004jQ-9n; Tue, 02 Jul 2024 13:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sOhYK-0004i7-0y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 13:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sOhYH-000443-Vv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 13:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719942264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JaKiqjE8H+Aayhqd6rmKo5HakO/mYJRoE8XSlqN7JfA=;
 b=Cc382AIzrdflOFAuh8wUlT9NRdltQnFsVZeF/Gl8YyJvizscfAPmST+LR3HFZ8EdKgUP+Z
 aADjUrn++C3lSnBHgNxzc2+IaxWLYGDTHPSfT8SKMX1cZB130nFMfFJ4fKaYVDkiMR+gFa
 tBuFwbMQ553pm3klcgjkpA0F1NxP+Vo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-3Hr3eNQ8MV2stB9lsd9ynQ-1; Tue, 02 Jul 2024 13:44:21 -0400
X-MC-Unique: 3Hr3eNQ8MV2stB9lsd9ynQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-446405b39baso2200351cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 10:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719942260; x=1720547060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaKiqjE8H+Aayhqd6rmKo5HakO/mYJRoE8XSlqN7JfA=;
 b=ki7q6uikABVppP1aaJ+OR4U8uKpeTTYotG3lGVSBF3sz7NxljAvI/Tuv5yJH8YSTJp
 fsSPhY76MC2ymKZHAFQY1GhmivZpIbbvgr9MDa6AWq7UfoIhpkAHuip4NxhuA/w1Ht3T
 tC8zlnbBY1oifeJwWbXaeOqRd2iNcbjCqCQDXMTFpoX13dXpvYcSHrPueo75cuJAAY7+
 4sYdTgrOiuE8CG5HztdvKDw7AnoLp2vgTIlCddG1q4FjTBpkVxYO5C670627CNFQ8Kjq
 AcKUouGizLd72Sr0AtAa2cOsLZuwz9ZZUWXDx1SH+d3+uSWf14gmCrUticFcXndemcJD
 eKeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBuc1YqgbH8oPDf5L93ozjwvR4M1n71Y1aNpBHKwP9IbG8M50gnJ7f7BW2Hu7NG60JhPMwvGdhIrZsTEJOIE6nd+2R7xY=
X-Gm-Message-State: AOJu0Yx9LoYOnXVfyP81bvXylxIbU2WA2W6CqrJ5S2U4xIuCg/+SgyIk
 TSfYjYLqXiSHf2zgHIDUDmEBYkyDw8c6oy1V+flac893axshsTpNSW3vVKuCQy/a83unusef/7K
 Ku8x1ZOoCcTR7F14xo+F94MqaxFhvPpir+gd1Zth0KQ4XkmcO8ybZ
X-Received: by 2002:a05:620a:298a:b0:79d:6685:4e71 with SMTP id
 af79cd13be357-79d7b9b0f05mr1055741285a.1.1719942260309; 
 Tue, 02 Jul 2024 10:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ce4jtQW1LvRBjVKmVL8Kr7Knx22aFCRdl5+1Mh0oFAvAp+6M7RpGwKA47taNotW567GNtw==
X-Received: by 2002:a05:620a:298a:b0:79d:6685:4e71 with SMTP id
 af79cd13be357-79d7b9b0f05mr1055736985a.1.1719942259847; 
 Tue, 02 Jul 2024 10:44:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d693057c7sm475309285a.116.2024.07.02.10.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 10:44:19 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:44:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 09/15] memory: Do not create circular reference with
 subregion
Message-ID: <ZoQ8cCrPXgK8I6b6@x1n>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-9-750bb0946dbd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627-san-v2-9-750bb0946dbd@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 27, 2024 at 10:37:52PM +0900, Akihiko Odaki wrote:
> A memory region does not use their own reference counters, but instead
> piggybacks on another QOM object, "owner" (unless the owner is not the
> memory region itself). When creating a subregion, a new reference to the
> owner of the container must be created. However, if the subregion is
> owned by the same QOM object, this result in a self-reference, and make
> the owner immortal. Avoid such a self-reference.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  system/memory.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 74cd73ebc78b..949f5016a68d 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2638,7 +2638,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>  
>      memory_region_transaction_begin();
>  
> -    memory_region_ref(subregion);
> +    if (mr->owner != subregion->owner) {
> +        memory_region_ref(subregion);
> +    }
> +
>      QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>          if (subregion->priority >= other->priority) {
>              QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> @@ -2696,7 +2699,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
>          assert(alias->mapped_via_alias >= 0);
>      }
>      QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> -    memory_region_unref(subregion);
> +
> +    if (mr->owner != subregion->owner) {
> +        memory_region_unref(subregion);
> +    }
> +
>      memory_region_update_pending |= mr->enabled && subregion->enabled;
>      memory_region_transaction_commit();
>  }

This does look like a real issue.. the patch looks reasonable to me, but I
wonder whether we should start to add some good comments in code to reflect
that complexity starting from this one.  The MR refcount isn't easy to
understand to me.

It also lets me start to wonder how MR refcount went through until it looks
like today..  It's definitely not extremely intuitive to use mr->owner as
the object to do refcounting if mr itself does has its own QObject,
meanwhile it has other tricks around.

E.g. the first thing I stumbled over when looking was the optimization
where we will avoid refcounting the mr when there's no owner, and IIUC it
was for the case when the "guest memory" (which will never be freed) used
to have no owner so we can speedup DMA if we know it won't go away.

https://lore.kernel.org/qemu-devel/1450263601-2828-5-git-send-email-pbonzini@redhat.com/

commit 612263cf33062f7441a5d0e3b37c65991fdc3210
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Dec 9 11:44:25 2015 +0100

    memory: avoid unnecessary object_ref/unref
    
    For the common case of DMA into non-hotplugged RAM, it is unnecessary
    but expensive to do object_ref/unref.  Add back an owner field to
    MemoryRegion, so that these memory regions can skip the reference
    counting.

If so, it looks like it will stop working with memory-backends get
involved?  As I think those MRs will have owner set always, and I wonder
whether memory-backends should be the major way to specify guest memory now
and in the future.  So I'm not sure how important that optimization is as
of now, and whether we could "simplify" it back to always do the refcount
if the major scenarios will not adopt it.

The other issue is we used owner refcount from the start of
memory_region_ref() got introduced, since:

commit 46637be269aaaceb9867ffdf176e906401138fff
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue May 7 09:06:00 2013 +0200

    memory: add ref/unref

And we still have that in our document, even though I don't think it's true
anymore:

 * ...  MemoryRegions actually do not have their
 * own reference count; they piggyback on a QOM object, their "owner".
 * This function adds a reference to the owner.

It looks like what happened is when introduced the change, MR is not a QOM
object yet.  But it later is..

I mentioned all these only because I found that _if_ we can keep mr
refcounting as simple as other objects:

memory_region_ref(mr)
{
    object_ref(OBJECT(mr));
}

Then looks like this "recursive refcount" problem can also go away.  I'm
curious whether you or anyone tried to explore that path, or whether above
doesn't make sense at all.

Thanks,

-- 
Peter Xu



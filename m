Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6780FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 19:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVyE1-0005P1-7B; Thu, 09 Jan 2025 14:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVyDl-0005Mb-4H
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVyDj-0003BX-FR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736450967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cne2WxLOcCYVcf0zbyv1wkxxNzlJAdgG4pyebQOlMgk=;
 b=Jz5dTgxW1Wu+Mtj65lAt+evddqrzDg3KiR76zBLa7cwR2u1l3LNQSMRvPuVZ969LmU+nfw
 0Wrguwd/4BEOp7WziBVi/mMyVWADm0L59ZK3+M9T7Dya7jY0xJvW9IbAXTW2Bfof/vXlQw
 lABtrE3Q2YUrmIw8GriYO53Tk8vpZWg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-eukcC0qrO3SQZXKOYSVhSA-1; Thu, 09 Jan 2025 14:29:26 -0500
X-MC-Unique: eukcC0qrO3SQZXKOYSVhSA-1
X-Mimecast-MFC-AGG-ID: eukcC0qrO3SQZXKOYSVhSA
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467a0a6c846so23832421cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 11:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736450966; x=1737055766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cne2WxLOcCYVcf0zbyv1wkxxNzlJAdgG4pyebQOlMgk=;
 b=aOAzI0gCLaGPmy+aJCPosw39guue5DcmesMttpHmBQxjee6LQ5b0i2MVaMPPKQBjhI
 A9rIr4ZawkWxmkFEY5mKb4aVvoTfgaKyKaNuUAdYJ35HCvD7wq9um/te7lLH9TaAe4v+
 CObXEy2rwFRBWC2GvqxYcxvAuZWLFsnxTY56LU7XP6DQs4+DQAPemyEMokrW2OSA1j80
 0u9z6z3M5yUeIi/wzMnWSdxxYp3IBFhEFB/yGi5NvJ4Uuol6oF2m08GKwbpOYzoFwl8u
 RZwl7NG9IZvwk/ZZiWcQwEWBvR8JF58b5G/iyFoLty0M17y5lP0CYLwadIgTqps8taRt
 kbbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxHeSeCOZZzo4tbOup8c2VtiO16GWQmstRmPC2W8gcHCBw9iyqyWGx5/QwN9pLE3ihdkocv8AaPVXD@nongnu.org
X-Gm-Message-State: AOJu0YzFAyQe4qqjL5sLfaMelZgvidEqALNh/xgUxfHlWZhg4ZPABha6
 LxsrsigxBEcEQWzv3J0eGj8ExxwpoEIip+uagBcXl3ORsv2VMHon9pkgPWUafl9+eY1WsKJ7+9t
 ty0rGgc6CuBdycfq8SWWj2tI6NmqY8Y42PwJRJmMi1JLh2Qo39Pl0
X-Gm-Gg: ASbGncu3jjxrardDBrNOITG7VetmfzLkfmkIXh+GU8kuQ0W82bgZFMG0FSceGCPlEBo
 yPtft1PsEFIKkK0y6kTmi6OPceVeQQP5g73N5inr4ViBS2HnJplK76LdS8fFNdyRWwAnpa0ObKr
 OPX6u8BPzjZJ4/1j2Fai0JPsbKBSJaLf9FeObFOD57WymCGfQSc9rUCHQc6u+hnoTK9OziL4tKu
 LbZJMHRMafqSXV/6gzSEB1PEAkr8WocywYlWn8x+89extvplpwdStEAUI7qtwzulLsInZ5935/Y
 7/oNrWd0OHSTpeW8rg==
X-Received: by 2002:a05:622a:152:b0:467:5711:bdb8 with SMTP id
 d75a77b69052e-46c7109e4f8mr119408431cf.46.1736450965918; 
 Thu, 09 Jan 2025 11:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Srd4QyzlvRig7hRRWAfT1ZSoKBug4DuiSnZ++mb367MMY5rxYxuu7miLpVfzEqja6jLAJw==
X-Received: by 2002:a05:622a:152:b0:467:5711:bdb8 with SMTP id
 d75a77b69052e-46c7109e4f8mr119408181cf.46.1736450965597; 
 Thu, 09 Jan 2025 11:29:25 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c87340e2dsm1513381cf.37.2025.01.09.11.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 11:29:24 -0800 (PST)
Date: Thu, 9 Jan 2025 14:29:21 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4AjkXbZeu3T94Y1@x1n>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
> On Thu, 9 Jan 2025, Akihiko Odaki wrote:
> > Do not refer to "memory region's reference count"
> > -------------------------------------------------
> > 
> > Now MemoryRegions do have their own reference counts, but they will not
> > be used when their owners are not themselves. However, the documentation
> > of memory_region_ref() says it adds "1 to a memory region's reference
> > count", which is confusing. Avoid referring to "memory region's
> > reference count" and just say: "Add a reference to a memory region".
> > Make a similar change to memory_region_unref() too.
> > 
> > Refer to docs/devel/memory.rst for "owner"
> > ------------------------------------------
> > 
> > memory_region_ref() and memory_region_unref() used to have their own
> > descriptions of "owner", but they are somewhat out-of-date and
> > misleading.
> > 
> > In particular, they say "whenever memory regions are accessed outside
> > the BQL, they need to be preserved against hot-unplug", but protecting
> > against hot-unplug is not mandatory if it is known that they will never
> > be hot-unplugged. They also say "MemoryRegions actually do not have
> > their own reference count", but they actually do. They just will not be
> > used unless their owners are not themselves.
> > 
> > Refer to docs/devel/memory.rst as the single source of truth instead of
> > maintaining duplicate descriptions of "owner".
> > 
> > Clarify that owner may be missing
> > 
> > ---------------------------------
> > A memory region may not have an owner, and memory_region_ref() and
> > memory_region_unref() do nothing for such.
> > 
> > memory: Clarify owner must not call memory_region_ref()
> > --------------------------------------------------------
> > 
> > The owner must not call this function as it results in a circular
> > reference.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> > include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
> > 1 file changed, 28 insertions(+), 31 deletions(-)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 9458e2801d50..ca247343f433 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
> >  * memory_region_add_subregion() to add subregions.
> >  *
> >  * @mr: the #MemoryRegion to be initialized
> > - * @owner: the object that tracks the region's reference count
> > + * @owner: the object that keeps the region alive
> >  * @name: used for debugging; not visible to the user or ABI
> >  * @size: size of the region; any subregions beyond this size will be clipped
> >  */
> > @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
> >                         uint64_t size);
> > 
> > /**
> > - * memory_region_ref: Add 1 to a memory region's reference count
> > + * memory_region_ref: Add a reference to the owner of a memory region
> >  *
> > - * Whenever memory regions are accessed outside the BQL, they need to be
> > - * preserved against hot-unplug.  MemoryRegions actually do not have their
> > - * own reference count; they piggyback on a QOM object, their "owner".
> > - * This function adds a reference to the owner.
> > - *
> > - * All MemoryRegions must have an owner if they can disappear, even if the
> > - * device they belong to operates exclusively under the BQL.  This is because
> > - * the region could be returned at any time by memory_region_find, and this
> > - * is usually under guest control.
> > + * This function adds a reference to the owner of a memory region to keep the
> > + * memory region alive. It does nothing if the owner is not present as a memory
> > + * region without owner will never die.
> > + * For references internal to the owner, use object_ref() instead to avoid a
> > + * circular reference.
> 
> Reading this again I'm still confused by this last sentence. Do you mean
> references internal to the memory region should use object_ref on the memory
> region or that other references to the owner should use object_ref on the
> owner? This sentence is still not clear about that.

Having two refcounts are definitely confusing.. especially IIRC all MRs'
obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
its g_free() on its own.

I acked both patches, but maybe it could indeed be slightly better we drop
this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
means for parent/child MRs that share the same owner, QEMU does nothing on
the child MRs when add subregion, because it assumes the child MR will
never go away when the parent is there who shares the owner.

So maybe we try not to touch MR's refcount manually, but fix what can be
problematic for owner->ref only.

-- 
Peter Xu



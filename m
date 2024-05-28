Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739EEC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1S1-0007Xk-VK; Tue, 28 May 2024 14:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC1S0-0007Wz-AV
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC1Ry-0002AP-Gc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716920489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GxOWPoYM75SZZUawGN2+WbmYHezm0tW5YX6QxhPmKGQ=;
 b=UGMGwZw+9ckp22WjpxohckIfIbDxIFKyTZdKEIy5zB952gAAvlwO3OxOOs+yYcRSwhA2by
 I+benKxUqqUvfZZHIAxYeZu2muSpeeUJ9m/5pXEjUGsxgj5ssFQDyGfMxMRb4b1qen3uev
 JlT1NpK9aXxtxe3XJ4by8XrY+LPSHxo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-3bwiD3pjOVSALPltPsCo0g-1; Tue, 28 May 2024 14:21:28 -0400
X-MC-Unique: 3bwiD3pjOVSALPltPsCo0g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab8ca6df0bso2980016d6.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 11:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716920486; x=1717525286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxOWPoYM75SZZUawGN2+WbmYHezm0tW5YX6QxhPmKGQ=;
 b=BvY/JQhBpXUeI2En/KMPF2oiK6TidYIPdz/D4UnF1Zpo1vFePbvAQlgqk22ex+Kilj
 sOmC7Lh/NlBAzwLGyHzPgfRotvNO0QnPhyrFo3Nu3F/hacf1Bz9+7nJj21KbJJQ+phWs
 zLv+ZN8D12sDZ1uN+sgqvI0vzP53+3x3/nnKmbhSzjKhGvkj/JYuAVNzJTrSngSh9F+t
 PBUdXg5RYTfVAf+5P0zq8o/Rxbu4bxeZrALABAXKWytVHJr6wxgu2s2eEcVnya2Utdig
 kRUUglqrLMaUNVVb0T7hshMKF5/zy9f4/pCCLgIXFZ40k2I/ONAGC1jp0MVy09JK2QJt
 pYZQ==
X-Gm-Message-State: AOJu0YxJV/SwZ9Ua1vlwtP/5CR8mC5y/Nxr4DWRGcjEEEsxf0aOz3zpn
 FJcciTrMofqTaigthvuJtBXZ1cvc255LxOd26fYUyMk5nb/0SoeAqLIWrkFJNTZTrYqjOPbFrKT
 Cl+rdTGpGsYSQyxlw5wbmqjTgqoC8r0xOWR/jzdtelzLLnIz7rSE3
X-Received: by 2002:a05:622a:1650:b0:43e:e6e:21de with SMTP id
 d75a77b69052e-43fb0e79634mr136657861cf.2.1716920486273; 
 Tue, 28 May 2024 11:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi/MKEZU1c/ym1EvWwaLSXuLS7VfPdFWO/Xi4jPuUSehwJxIvR3sV6wQrAnWvGMNqTnJuYgQ==
X-Received: by 2002:a05:622a:1650:b0:43e:e6e:21de with SMTP id
 d75a77b69052e-43fb0e79634mr136657491cf.2.1716920485523; 
 Tue, 28 May 2024 11:21:25 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b0e3bsm44921731cf.68.2024.05.28.11.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 11:21:25 -0700 (PDT)
Date: Tue, 28 May 2024 14:21:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 08/26] migration: vmstate_info_void_ptr
Message-ID: <ZlYgo0UupFdQJ95L@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
 <ZlTRgsNatkvsLKpL@x1n>
 <f0d4b6af-a3eb-451d-b131-62addb72f3ef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0d4b6af-a3eb-451d-b131-62addb72f3ef@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 28, 2024 at 11:10:16AM -0400, Steven Sistare wrote:
> On 5/27/2024 2:31 PM, Peter Xu wrote:
> > On Mon, Apr 29, 2024 at 08:55:17AM -0700, Steve Sistare wrote:
> > > Define VMSTATE_VOID_PTR so the value of a pointer (but not its target)
> > > can be saved in the migration stream.  This will be needed for CPR.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > 
> > This is really tricky.
> > 
> >  From a first glance, I don't think migrating a VA is valid at all for
> > migration even if with exec.. and looks insane to me for a cross-process
> > migration, which seems to be allowed to use as a generic VMSD helper.. as
> > VA is the address space barrier for different processes and I think it
> > normally even apply to generic execve(), and we're trying to jailbreak for
> > some reason..
> > 
> > It definitely won't work for any generic migration as sizeof(void*) can be
> > different afaict between hosts, e.g. 32bit -> 64bit migrations.
> > 
> > Some description would be really helpful in this commit message,
> > e.g. explain the users and why.  Do we need to poison that for generic VMSD
> > use (perhaps with prefixed underscores)?  I think I'll need to read on the
> > rest to tell..
> 
> Short answer: we never dereference the void* in the new process.  And must not.
> 
> Longer answer:
> 
> During CPR for vfio, each mapped DMA region is re-registered in the new
> process using the new VA.  The ioctl to re-register identifies the mapping
> by IOVA and length.
> 
> The same requirement holds for CPR of iommufd devices.  However, in the
> iommufd framework, IOVA does not uniquely identify a dma mapping, and we
> need to use the old VA as the unique identifier.  The new process
> re-registers each mapping, passing the old VA and new VA to the kernel.
> The old VA is never dereferenced in the new process, we just need its value.
> 
> I suspected that the void* which must not be dereferenced might make people
> uncomfortable.  I have an older version of my code which adds a uint64_t
> field to RAMBlock for recording and migrating the old VA.  The saving and
> loading code is slightly less elegant, but no big deal.  Would you prefer
> that?

I see, thanks for explaining.  Yes that sounds better to me.  Re the
ugliness: is that about a pre_save() plus one extra uint64_t field?  In
that case it looks better comparing to migrating "void*".

I'm trying to read some context on the vaddr remap thing from you, and I
found this:

https://lore.kernel.org/all/Y90bvBnrvRAcEQ%2F%2F@nvidia.com/

So it will work with iommufd now?  Meanwhile, what's the status for mdev?
Looks like it isn't supported yet for both.

Thanks,

-- 
Peter Xu



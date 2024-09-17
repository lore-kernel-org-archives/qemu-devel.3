Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19DBCAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdPe-0002CZ-26; Tue, 17 Sep 2024 14:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdPb-00022i-Up
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 14:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqdPa-0007y7-7H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 14:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726599533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dbsDhz99GeKIRcWdziRigqnZeNTSQWprNldoD/uHVgQ=;
 b=MznJo4Oz0Or2EHJxI0nCBsewsj3Ufj7ceAxXX9h7KP8kTUi9LLS67E0wBXTJ34piM3m8a3
 NBhDJTLPmWZBsD85H4m8adfNWbmZ60pA9vFZUyfGW/RKapfq/2KVOxv2PUTE6dtS0UY1bk
 e5MKtQsx80qlxtn35O/XWBCxq9M5Uiw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Pk9seloROhKyQhL3Sfl_og-1; Tue, 17 Sep 2024 14:58:51 -0400
X-MC-Unique: Pk9seloROhKyQhL3Sfl_og-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4585eba9b52so153812641cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 11:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726599531; x=1727204331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbsDhz99GeKIRcWdziRigqnZeNTSQWprNldoD/uHVgQ=;
 b=aHWADe1JgKZUzCKlZZ8ytBO+ZtpmzgMfR4rPUseIwkyDYsFn4eIZ52eJQ5+xAMihdG
 ooGsrWHoXllK1tFro6W2kTFUqLZn6IoFFGA/i17Xg6MR/rjfx76Jo9fM4jaeKZytfcXX
 gzn5KMeEKAPQkiH9gCrJz/Ndlo3oubJuIvTzsU/g+3A6Khv/6RWlgHntwlPF6g8TvYOb
 IDXAwaPPfcOm7OScmOg7/VI+7NBAJSAmwqoz7v8qNEB9J0/z1IV6DKr+5p/RORyNsYxS
 0RHUdZapOsI+NxEVoGOBCsZHldyPVYUffkMNrOSMVX0486N6Cigd4mHOXJuPeUvP+Ddw
 iJuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPJfsiNvGWPEvz4D8EXqI0Mw9WjkHIINMZrGLv+C223X2k6cWIf+y8LUgcAVmwZPq9KbZhmOUOvo2h@nongnu.org
X-Gm-Message-State: AOJu0Yy+r4K5a8F4ealxclVdnp1Q8xHCj83RJU+WIbqPpK79zNMTcQbn
 YpE+HbIg1e3wvJKHNvigrq5Sdqph5clVcpGOkqL2A1fCx86U5GnDUgoEKaBOpD2V9BjQctcicGR
 Q80qvZFC+bbIu03X81WZvGPhxW81A+jQ1gC2VAiAr18UDJlLK79r9
X-Received: by 2002:a05:6214:2f02:b0:6c5:51ed:2dbc with SMTP id
 6a1803df08f44-6c57358430amr283611036d6.45.1726599531006; 
 Tue, 17 Sep 2024 11:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0RMkHH4EDinYsa39HjVUWnIEegJyT26t2RSbeepH2ZAtrZV+EpGl9vyZnlS8Aa8AZKBXUtg==
X-Received: by 2002:a05:6214:2f02:b0:6c5:51ed:2dbc with SMTP id
 6a1803df08f44-6c57358430amr283610786d6.45.1726599530568; 
 Tue, 17 Sep 2024 11:58:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c62633bsm37561286d6.25.2024.09.17.11.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 11:58:49 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:58:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] memory: notify hypervisor of all eventfds during
 listener (de)registration
Message-ID: <ZunRZ5yA6KaNtmEA@x1n>
References: <20240910120100.9460-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910120100.9460-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Ani,

On Tue, Sep 10, 2024 at 05:31:00PM +0530, Ani Sinha wrote:
> When a new listener for an address space is registered, the hypervisor must be
> informed of all existing eventfds for that address space by calling
> eventfd_add() for that listener. Similarly, when a listener is de-registered
> from an address space, the hypervisor must be informed of all existing eventfds
> for that address space with a call to eventfd_del().
> 
> Same is also true for coalesced io. Send coalesced io add/del listener
> notifications if any flatrage for the address space registered with the
> listener intersects with any coalesced io range.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

This is only to make the API clean, as I see that only kvm uses either of
the features (while kvm never registers during VM running).  Am I right?

I'd like to double check whether we need to copy stable, or whether there's
a real bug.

> ---
>  system/memory.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> changelog:
> v2: tags added, indentation fixed, commit log fixed, code cleanup.
> 
> diff --git a/system/memory.c b/system/memory.c
> index 5e6eb459d5..8379e086fb 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -941,6 +941,38 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
>      }
>  }
>  
> +static void
> +flat_range_coalesced_io_notify_listener_add_del(FlatRange *fr,
> +                                                MemoryRegionSection *mrs,
> +                                                MemoryListener *listener,
> +                                                AddressSpace *as, bool add)
> +{
> +    CoalescedMemoryRange *cmr;
> +    MemoryRegion *mr = fr->mr;
> +    AddrRange tmp;
> +
> +    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
> +        tmp = addrrange_shift(cmr->addr,
> +                              int128_sub(fr->addr.start,
> +                                         int128_make64(fr->offset_in_region)));
> +
> +        if (!addrrange_intersects(tmp, fr->addr)) {
> +            return;
> +        }
> +        tmp = addrrange_intersection(tmp, fr->addr);
> +
> +        if (add) {

Do we need to check ->coalesced_io_add != NULL here?  I wonder whether this
could crash if some dynamic listener got inserted (with coalesced list
non-empty).

> +            listener->coalesced_io_add(listener, mrs,
> +                                       int128_get64(tmp.start),
> +                                       int128_get64(tmp.size));
> +        } else {
> +            listener->coalesced_io_del(listener, mrs,

Same.

> +                                       int128_get64(tmp.start),
> +                                       int128_get64(tmp.size));
> +        }
> +    }
> +}
> +
>  static void address_space_update_topology_pass(AddressSpace *as,
>                                                 const FlatView *old_view,
>                                                 const FlatView *new_view,
> @@ -3015,8 +3047,10 @@ void memory_global_dirty_log_stop(unsigned int flags)
>  static void listener_add_address_space(MemoryListener *listener,
>                                         AddressSpace *as)
>  {
> +    unsigned i;
>      FlatView *view;
>      FlatRange *fr;
> +    MemoryRegionIoeventfd *fd;
>  
>      if (listener->begin) {
>          listener->begin(listener);
> @@ -3041,10 +3075,31 @@ static void listener_add_address_space(MemoryListener *listener,
>          if (listener->region_add) {
>              listener->region_add(listener, &section);
>          }
> +
> +        /* send coalesced io add notifications */
> +        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
> +                                                        listener, as, true);
> +
>          if (fr->dirty_log_mask && listener->log_start) {
>              listener->log_start(listener, &section, 0, fr->dirty_log_mask);
>          }
>      }
> +
> +    /*
> +     * register all eventfds for this address space for the newly registered
> +     * listener.
> +     */
> +    for (i = 0; i < as->ioeventfd_nb; i++) {
> +        fd = &as->ioeventfds[i];
> +        MemoryRegionSection section = (MemoryRegionSection) {
> +            .fv = address_space_to_flatview(as),

Nitpick: I don't think it'll be anything different if we hold BQL anyway,
but.. might be good to use "view" directly here, as we're holding a
refcount there via address_space_get_flatview().

While it's not crystal clear otherwise (when without knowing BQL held) that
address_space_to_flatview() will return the same flatview.

> +            .offset_within_address_space = int128_get64(fd->addr.start),
> +            .size = fd->addr.size,
> +        };
> +        listener->eventfd_add(listener, &section,
> +                              fd->match_data, fd->data, fd->e);

Check ->eventfd_add != NULL?

> +    }
> +
>      if (listener->commit) {
>          listener->commit(listener);
>      }
> @@ -3054,8 +3109,10 @@ static void listener_add_address_space(MemoryListener *listener,
>  static void listener_del_address_space(MemoryListener *listener,
>                                         AddressSpace *as)
>  {
> +    unsigned i;
>      FlatView *view;
>      FlatRange *fr;
> +    MemoryRegionIoeventfd *fd;
>  
>      if (listener->begin) {
>          listener->begin(listener);
> @@ -3067,10 +3124,30 @@ static void listener_del_address_space(MemoryListener *listener,
>          if (fr->dirty_log_mask && listener->log_stop) {
>              listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
>          }
> +
> +        /* send coalesced io del notifications */
> +        flat_range_coalesced_io_notify_listener_add_del(fr, &section,
> +                                                        listener, as, false);
>          if (listener->region_del) {
>              listener->region_del(listener, &section);
>          }
>      }
> +
> +    /*
> +     * de-register all eventfds for this address space for the current
> +     * listener.
> +     */
> +    for (i = 0; i < as->ioeventfd_nb; i++) {
> +        fd = &as->ioeventfds[i];
> +        MemoryRegionSection section = (MemoryRegionSection) {
> +            .fv = address_space_to_flatview(as),

Same.

> +            .offset_within_address_space = int128_get64(fd->addr.start),
> +            .size = fd->addr.size,
> +        };
> +        listener->eventfd_del(listener, &section,
> +                              fd->match_data, fd->data, fd->e);

Check eventfd_del != NULL?

Thanks,

> +    }
> +
>      if (listener->commit) {
>          listener->commit(listener);
>      }
> -- 
> 2.42.0
> 

-- 
Peter Xu



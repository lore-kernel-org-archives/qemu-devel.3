Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ADCC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 15:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqsp-0004fn-5B; Thu, 27 Jun 2024 11:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqsk-0004fI-L8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqsi-0006Rw-MB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 11:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719501471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ar0ZRG0aAjpKX6refYFg19YPs2M7U5GnmUJGEB/DA9c=;
 b=Kyz0z4NR2nRkxbdccmk3Jrt/aeX+2118euUgSFI24XaNIDAFf7MRxoc+IyCKTf+KSs4eNB
 ktzIQkMrLVi/6So3Fnze8mgtPUej5G/c1v/lVLEjZWctYdbdSZbNto/QLD+W56s89IeJTX
 nonUoGaZ1/H4FJcn7zYui3j48ggY+eA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-2YpBqMjWOFOiTUlGJiViMQ-1; Thu, 27 Jun 2024 11:17:48 -0400
X-MC-Unique: 2YpBqMjWOFOiTUlGJiViMQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5c226244eadso352692eaf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 08:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719501467; x=1720106267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ar0ZRG0aAjpKX6refYFg19YPs2M7U5GnmUJGEB/DA9c=;
 b=eHW8+v43ae8SPsw71FeCx9npRKJo1kGd1s+/nttypU2F+lxLz8enNdO8Txn5HUouP+
 ucrWRx9kvxS4FNhBILeaOzE6S2ijKwWc+Yzo5Fa34tINuB5PeG/TC3fNWu3otLGFLhNr
 qPZwtGTCOas09QLGrL+o7+PHUEBuhfr6cZTeA6hYmHQUHi8Z0J1vxh1IFFBOlVyXyQeP
 ENKmvj9paLUOow6RJbqhPynTDAX2CkuM7NmiVgAsKaUsh9OUllFC5Zc3pUGloX+KZs1Y
 IY9V1lYslJL0971u3sK9Lbyq481nm07ieRgvmDgb6YmUhFzwTZGToPknXVdvew/kn0tk
 RVCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaTExoGM2YImMk2OFYCy6dlnzTJr3JJYYYcyQpbZ3O4MDd11ZLDGMf5P9AELpO6REj4FWcp/sXM6tJd8W0j0CeSDHdHlw=
X-Gm-Message-State: AOJu0Yyl+ve9NMHtyBnTmM5/TjRJUlshGxgBjxh/+LPYz1YrQxvx1uI5
 eUy4H8K3SK/l3WK1pHVaZpTZuw/arUi+LALz0r/wFwmkr6hmoHAWUqph1s8cw9taJEylrz0Tx9D
 STMcPj/tn3qywDSypGpMsoUOUW4t2Q1+S+9bkmMNM1mAJt48D7QIx
X-Received: by 2002:a05:6358:9890:b0:19f:6a64:83cd with SMTP id
 e5c5f4694b2df-1a23302d0c0mr1668064555d.1.1719501467225; 
 Thu, 27 Jun 2024 08:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAeufNoxc9+MMmQCibvpAWKRC4e8Hlu/7xkPgD2oFR8Cx3Ml0w3FyGZn1DJWGtxHFGSSHr1A==
X-Received: by 2002:a05:6358:9890:b0:19f:6a64:83cd with SMTP id
 e5c5f4694b2df-1a23302d0c0mr1668061155d.1.1719501466617; 
 Thu, 27 Jun 2024 08:17:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44641e087b5sm6729451cf.6.2024.06.27.08.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 08:17:46 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:17:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <Zn2CmGxZ0Cw8jUCB@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn15y693g0AkDbYD@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 10:40:11AM -0400, Peter Xu wrote:
> On Thu, Jun 27, 2024 at 11:27:08AM +0800, Wang, Lei wrote:
> > > Or graphically:
> > > 
> > > 1) client fills the active slot with data. Channels point to nothing
> > >    at this point:
> > >   [a]      <-- active slot
> > >   [][][][] <-- free slots, one per-channel
> > > 
> > >   [][][][] <-- channels' p->data pointers
> > > 
> > > 2) multifd_send() swaps the pointers inside the client slot. Channels
> > >    still point to nothing:
> > >   []
> > >   [a][][][]
> > > 
> > >   [][][][]
> > > 
> > > 3) multifd_send() finds an idle channel and updates its pointer:
> > 
> > It seems the action "finds an idle channel" is in step 2 rather than step 3,
> > which means the free slot is selected based on the id of the channel found, am I
> > understanding correctly?
> 
> I think you're right.
> 
> Actually I also feel like the desription here is ambiguous, even though I
> think I get what Fabiano wanted to say.
> 
> The free slot should be the first step of step 2+3, here what Fabiano
> really wanted to suggest is we move the free buffer array from multifd
> channels into the callers, then the caller can pass in whatever data to
> send.
> 
> So I think maybe it's cleaner to write it as this in code (note: I didn't
> really change the code, just some ordering and comments):
> 
> ===8<===
> @@ -710,15 +710,11 @@ static bool multifd_send(MultiFDSlots *slots)
>       */
>      active_slot = slots->active;
>      slots->active = slots->free[p->id];
> -    p->data = active_slot;
> -
> -    /*
> -     * By the next time we arrive here, the channel will certainly
> -     * have consumed the active slot. Put it back on the free list
> -     * now.
> -     */
>      slots->free[p->id] = active_slot;
>  
> +    /* Assign the current active slot to the chosen thread */
> +    p->data = active_slot;
> ===8<===
> 
> The comment I removed is slightly misleading to me too, because right now 
> active_slot contains the data hasn't yet been delivered to multifd, so
> we're "putting it back to free list" not because of it's free, but because
> we know it won't get used until the multifd send thread consumes it
> (because before that the thread will be busy, and we won't use the buffer
> if so in upcoming send()s).
> 
> And then when I'm looking at this again, I think maybe it's a slight
> overkill, and maybe we can still keep the "opaque data" managed by multifd.
> One reason might be that I don't expect the "opaque data" payload keep
> growing at all: it should really be either RAM or device state as I
> commented elsewhere in a relevant thread, after all it's a thread model
> only for migration purpose to move vmstates..
> 
> Putting it managed by multifd thread should involve less change than this
> series, but it could look like this:
> 
> typedef enum {
>     MULTIFD_PAYLOAD_RAM = 0,
>     MULTIFD_PAYLOAD_DEVICE_STATE = 1,
> } MultifdPayloadType;
> 
> typedef enum {
>     MultiFDPages_t ram_payload;
>     MultifdDeviceState_t device_payload;
> } MultifdPayload;

PS: please conditionally read "enum" as "union" throughout the previous
email of mine, sorry.

[I'll leave that to readers to decide when should do the replacement..]

> 
> struct MultiFDSendData {
>     MultifdPayloadType type;
>     MultifdPayload data;
> };
> 
> Then the "enum" makes sure the payload only consumes only the max of both
> types; a side benefit to save some memory.
> 
> I think we need to make sure MultifdDeviceState_t is generic enough so that
> it will work for mostly everything (especially normal VMSDs).  In this case
> the VFIO series should be good as that was currently defined as:
> 
> typedef struct {
>     MultiFDPacketHdr_t hdr;
> 
>     char idstr[256] QEMU_NONSTRING;
>     uint32_t instance_id;
> 
>     /* size of the next packet that contains the actual data */
>     uint32_t next_packet_size;
> } __attribute__((packed)) MultiFDPacketDeviceState_t;
> 
> IIUC that was what we need exactly with idstr+instance_id, so as to nail
> exactly at where should the "opaque device state" go to, then load it with
> a buffer-based loader when it's ready (starting from VFIO, to get rid of
> qemufile).  For VMSDs in the future if ever possible, that should be a
> modified version of vmstate_load() where it may take buffers not qemufiles.
> 
> To Maciej: please see whether above makes sense to you, and if you also
> agree please consider that with your VFIO work.
> 
> Thanks,
> 
> > 
> > >   []
> > >   [a][][][]
> > > 
> > >   [a][][][]
> > >   ^idle
> 
> -- 
> Peter Xu

-- 
Peter Xu



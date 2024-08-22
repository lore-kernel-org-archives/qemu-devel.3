Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75400C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBkE-0003YS-Aw; Thu, 22 Aug 2024 13:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shBkD-0003Xz-FB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shBkB-0001WM-4v
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724348225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABgWbAhQyWdhm4lr/ykF869ljp8O+RujTvdKN8NRyCU=;
 b=HqUWlxHvS9tuUT1FbEUFwAhHQdONDlpNAyNA5I0TdQK9bId1n8luI7AduJPl7PLsuXHlwv
 1u5ggRLxZCSTTRyK2Iy495k18ruTceAFmwc2u4xM1zIQh8oB4m7OEoIbcVF2PE+swyR2Tx
 NDhD8P28oDhdME/9ZHDGNnBhT9lFUl8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Jq3QxwF-MaSGcmB2YKtKSw-1; Thu, 22 Aug 2024 13:37:03 -0400
X-MC-Unique: Jq3QxwF-MaSGcmB2YKtKSw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bf6a974541so12525306d6.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 10:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724348223; x=1724953023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABgWbAhQyWdhm4lr/ykF869ljp8O+RujTvdKN8NRyCU=;
 b=p32GL+o/lMl9Z5B8X1strj/GBDWlLK7d9P/0Qes5eVEQPWe1vKv4/x3aFo4Iq74NB4
 5wKgdJmK9ZnQZe5KNxNc3/xcidh6TB+ffWA0bfqLSUXkfcb6R+Y65Jvf/fJfYXMtkfQY
 SUuHfRMeKPZi82TUj6+GYzRZOtfmxNrVCikYbOwBmZRQgig+kiIplhItujiB11OaTelM
 FwGWq41Ahu5zEkttfM85DM0j4esdfp6pk0uEPKqktzFHElOO0nOOxbcRAaN85LLvZQNE
 4zrP9N3Tqj4QZK/y+ob/8TyjyFPVz7ZOv64P3/To/JkVG8KeLl1elAEdDLEIl0aN8Y7n
 c70Q==
X-Gm-Message-State: AOJu0Yw30DXn1AkGRehsFnNHTvrqPgVI5CR5zx0FgBI2Pa+/raszrhPn
 FErt3J2IzfEPrnKr8fEkS4EabVPfJM0/KBSMvjVAwchalJ+ASH1MUhxYKQIZiWuMj8ozAGhCBZj
 aqgcmmegrgBeuDHshS3kTZljeulk2HPpKpx312abbli5XrE8VYe6l
X-Received: by 2002:a05:6214:3389:b0:6bf:5c67:a924 with SMTP id
 6a1803df08f44-6c1646ca8ebmr35552096d6.15.1724348222616; 
 Thu, 22 Aug 2024 10:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMPyrnyfbSUvgeRu9NMGdUOX7BAf+72kh9R1FmDHjeO+Km46yzBtClg1yvmvMM11B4LmUCKw==
X-Received: by 2002:a05:6214:3389:b0:6bf:5c67:a924 with SMTP id
 6a1803df08f44-6c1646ca8ebmr35551716d6.15.1724348222153; 
 Thu, 22 Aug 2024 10:37:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1cbb9sm9739426d6.29.2024.08.22.10.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 10:37:01 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:36:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 12/14] migration/multifd: Allow multifd sync without
 flush
Message-ID: <Zsd3O_OCbpyctm-K@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-13-farosas@suse.de> <ZsdhY2ijx9nhSdLz@x1n>
 <Zsdi432b2dobNhMj@x1n> <87ttfcxzc5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttfcxzc5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 22, 2024 at 02:05:30PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 22, 2024 at 12:03:47PM -0400, Peter Xu wrote:
> >> On Thu, Aug 01, 2024 at 09:35:14AM -0300, Fabiano Rosas wrote:
> >> > Separate the multifd sync from flushing the client data to the
> >> > channels. These two operations are closely related but not strictly
> >> > necessary to be executed together.
> >> > 
> >> > The multifd sync is intrinsic to how multifd works. The multiple
> >> > channels operate independently and may finish IO out of order in
> >> > relation to each other. This applies also between the source and
> >> > destination QEMU.
> >> > 
> >> > Flushing the data that is left in the client-owned data structures
> >> > (e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
> >> > but that is particular to how the ram migration is implemented with
> >> > several passes over dirty data.
> >> > 
> >> > Make these two routines separate, allowing future code to call the
> >> > sync by itself if needed. This also allows the usage of
> >> > multifd_ram_send to be isolated to ram code.
> >> 
> >> What's the usage of sync but not flush here?
> >
> > Oh I think I see your point.. I think flush+sync is always needed, it's
> > just that RAM may not always be the one to flush, but something else.
> > Makes sense then.
> >
> 
> I'm thinking of "flush" here as a last multifd_send() before sync. We
> need multiple multifd_send() along the migration to send the data, but
> we might not need this extra flush. It could be that there's nothing to
> flush and the code guarantees it:
> 
>  <populate MultiFDSendData>
>  multifd_send()
>  sync
> 
> Where RAM currently does:
> 
>  multifd_queue_page()
>  multifd_queue_page()
>  multifd_queue_page()
>  ...
>  multifd_queue_page()
>  multifd_send()
>  sync
> 
> Today there is a multifd_send() inside multifd_queue_page() and the
> amount sent depends on the ram.c code. At the time sync gets called,
> there could be data queued but not yet sent. Another client (not ram)
> could just produce data in a deterministic manner and match that with
> calls to multifd_send().

I hope I read it alright.. I suppose you meant we have chance to do:

  ram_send()
  vfio_send()
  flush()

Instead of:

  ram_send()
  flush()
  vfio_send()
  flush()

Am I right?

> 
> > If you want, you may touch up the commit message to clarify that.  E.g. I
> > still don't see any use case that we want to sync without a flush, that
> > part might be a bit ambiguous.
> >
> > If my understanding is correct, take this:
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 

-- 
Peter Xu



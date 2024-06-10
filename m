Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E72C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhb2-0000W4-15; Mon, 10 Jun 2024 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhaz-0000Vb-GN
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhax-00026k-Aa
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718035804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+bhupLrgx4ArV/OJQmP0KB4AgM5JV8BkrXqxjjJ3ac=;
 b=Ex6XkG+3+kDzwN9fP8T4uZf6F/bQ5no4B01mmGNPJod1UrBMCJUinAC8LqRsyxGRgveNS8
 K0yFwwlvMmpgd+kwciJzpoGvOGIRm1IIJkEjmdNx8LCGTTP+bOkDhnkFb4cJwN70QGdfxe
 Te4YCosXayO1g8dmv7xMd5scXHCCXhc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-gL5Y94CCOOq8PAi9hxqmxg-1; Mon, 10 Jun 2024 12:10:02 -0400
X-MC-Unique: gL5Y94CCOOq8PAi9hxqmxg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44026f38681so512571cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718035802; x=1718640602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+bhupLrgx4ArV/OJQmP0KB4AgM5JV8BkrXqxjjJ3ac=;
 b=gjAtVAYdBUw9Wqry1AidVQwsdv2PfHlMhlyI3x+APHLwl15VICE/iduV1HT6PVsDMz
 mA+N9lQBYLqgANaDndZciWlgmxQh8lyiqxnL0Lq4yREbBs5W0rWDeB1YjvNnhPObNGU3
 MdGyTsuq61zlONwnChxhNARbZUxmpzhY0iMArMRVvycs9EgrZE9f+iZkmsqTfTjEbSgQ
 VrRrFW6zVJmfvadHe9Lt+L7/oZc4Jxc1Hr0dVQNRC/emGHcL1wdgJSaz/4F2/2q7ReSG
 1LRqhKa9fW3MMtha43n7AEnpLsY/RZwIhHHHUYyToFInBbPgHncRhlXtWyfLy0nldT7r
 3HpA==
X-Gm-Message-State: AOJu0YyQqGJwf599UW11yl3nfwAgILMmTTRnDj8xOBjz8OEmaG/A+Zc8
 TcgTL1Z+10/Gv9gKBLNnMHzIvuQRSWTjqFBNMGOQRmUszU8LfJUBJ4hUtRocucvZE9LPMckcQmV
 zd0Z7WuJXvxi7ZYxnksAsZbPIlec1CN9Z91Ycn07DFSfunsxjm8Nc
X-Received: by 2002:a05:620a:261c:b0:797:adf9:b33f with SMTP id
 af79cd13be357-797adf9b5c3mr118822985a.4.1718035801316; 
 Mon, 10 Jun 2024 09:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqK31yZjSvmGT+n2R5ASeQnLDlQZd7b5QiMkAg5DZGKO8uI3cO1FvffhCPD1l4U0qFWlwzyA==
X-Received: by 2002:a05:620a:261c:b0:797:adf9:b33f with SMTP id
 af79cd13be357-797adf9b5c3mr118810585a.4.1718035799792; 
 Mon, 10 Jun 2024 09:09:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79555a58ca7sm222158985a.32.2024.06.10.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:09:59 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:09:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <ZmclVQw0x7KKLxmF@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y17gwq5g.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Jun 07, 2024 at 03:42:35PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 04:05:48PM -0300, Fabiano Rosas wrote:
> >> We've recently added support for direct-io with multifd, which brings
> >> performance benefits, but creates a non-uniform user interface by
> >> coupling direct-io with the multifd capability. This means that users
> >> cannot keep the direct-io flag enabled while disabling multifd.
> >> 
> >> Libvirt in particular already has support for direct-io and parallel
> >> migration separately from each other, so it would be a regression to
> >> now require both options together. It's relatively simple for QEMU to
> >> add support for direct-io migration without multifd, so let's do this
> >> in order to keep both options decoupled.
> >> 
> >> We cannot simply enable the O_DIRECT flag, however, because not all IO
> >> performed by the migration thread satisfies the alignment requirements
> >> of O_DIRECT. There are many small read & writes that add headers and
> >> synchronization flags to the stream, which at the moment are required
> >> to always be present.
> >> 
> >> Fortunately, due to fixed-ram migration there is a discernible moment
> >> where only RAM pages are written to the migration file. Enable
> >> direct-io during that moment.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Is anyone going to consume this?  How's the performance?
> 
> I don't think we have a pre-determined consumer for this. This came up
> in an internal discussion about making the interface simpler for libvirt
> and in a thread on the libvirt mailing list[1] about using O_DIRECT to
> keep the snapshot data out of the caches to avoid impacting the rest of
> the system. (I could have described this better in the commit message,
> sorry).
> 
> Quoting Daniel:
> 
>   "Note the reason for using O_DIRECT is *not* to make saving / restoring
>    the guest VM faster. Rather it is to ensure that saving/restoring a VM
>    does not trash the host I/O / buffer cache, which will negatively impact
>    performance of all the *other* concurrently running VMs."
> 
> 1- https://lore.kernel.org/r/87sez86ztq.fsf@suse.de
> 
> About performance, a quick test on a stopped 30G guest, shows
> mapped-ram=on direct-io=on it's 12% slower than mapped-ram=on
> direct-io=off.

Yes, this makes sense.

> 
> >
> > It doesn't look super fast to me if we need to enable/disable dio in each
> > loop.. then it's a matter of whether we should bother, or would it be
> > easier that we simply require multifd when direct-io=on.
> 
> AIUI, the issue here that users are already allowed to specify in
> libvirt the equivalent to direct-io and multifd independent of each
> other (bypass-cache, parallel). To start requiring both together now in
> some situations would be a regression. I confess I don't know libvirt
> code to know whether this can be worked around somehow, but as I said,
> it's a relatively simple change from the QEMU side.

Firstly, I definitely want to already avoid all the calls to either
migration_direct_io_start() or *_finish(), now we already need to
explicitly call them in three paths, and that's not intuitive and less
readable, just like the hard coded rdma codes.

I also worry we may overlook the complexity here, and pinning buffers
definitely need more thoughts on its own.  It's easier to digest when using
multifd and when QEMU only pins guest pages just like tcp-zerocopy does,
which are naturally host page size aligned, and also guaranteed to not be
freed (while reused / modified is fine here, as dirty tracking guarantees a
new page will be migrated soon again).

IMHO here the "not be freed / modified" is even more important than
"alignment": the latter is about perf, the former is about correctness.
When we do directio on random buffers, AFAIU we don't want to have the
buffer modified before flushed to disk, and that's IMHO not easy to
guarantee.

E.g., I don't think this guarantees a flush on the buffer usages:

  migration_direct_io_start()
    /* flush any potentially unaligned IO before setting O_DIRECT */
    qemu_fflush(file);

qemu_fflush() internally does writev(), and that "flush" is about "flushing
qemufile iov[] to fd", not "flushing buffers to disk".  I think it means
if we do qemu_fflush() then we modify QEMUFile.buf[IO_BUF_SIZE] we're
doomed: we will never know whether dio has happened, and which version of
buffer will be sent; I don't think it's guaranteed it will always be the
old version of the buffer.

However the issue is, QEMUFile defines qemu_fflush() as: after call, the
buf[] can be reused!  It suggests breaking things I guess in dio context.

IIUC currently mapped-ram is ok because mapped-ram is just special that it
doesn't have page headers, so it doesn't use the buf[] during iterations;
while for zeropage it uses file_bmap bitmap and that's separate too and
does not generate any byte on the wire either.

xbzrle could use that buf[], but maybe mapped-ram doesn't work anyway with
xbzrle.

Everything is just very not obvious and tricky to me.  This still looks
pretty dangerous to me.  Would migration_direct_io_finish() guarantee
something like a fdatasync()?  If so it looks safer, but still within the
start() and finish() if someone calls qemu_fflush() and reuse the buffer we
can still get hard to debug issues (as the outcome would be that we saw
corrupted migration files).

> 
> Another option which would be for libvirt to keep using multifd, but
> make it 1 channel only if --parallel is not specified. That might be
> enough to solve the interface issues. Of course, it's a different code
> altogether than the usual precopy code that gets executed when
> multifd=off, I don't know whether that could be an issue somehow.

Would there be any comment from Libvirt side?  This sounds like a good
solution if my above concern is real; as long as we always stick dio with
guest pages we'll be all fine.

Thanks,

-- 
Peter Xu



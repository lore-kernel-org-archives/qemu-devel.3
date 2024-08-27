Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9654C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1ZW-00010x-I2; Tue, 27 Aug 2024 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj1ZT-00010N-GA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj1ZR-0001HY-Fz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724785776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/1E8+rBKwc/2VH5T6HtQYLSgh6yFiIlVDmVwD9tg2Y=;
 b=Bac4U7PhWLH3houkP/Wl4dFAIufGRxAXtZsnhmbuz5+W49GPvo93Fiwlt3ukbOotZoHFps
 LI1yaEQv7Z6X2N3Gn8pUOfNjP5CWMPpwT1WOzUdmnm0pQOP8yiQ3ECdcTis7wLjNdez0uV
 BL7eyE7pr/71bMjcUkTh9g9JD8uZSNA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Tiasb79tP_mXewhSO8yocg-1; Tue, 27 Aug 2024 15:09:35 -0400
X-MC-Unique: Tiasb79tP_mXewhSO8yocg-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-70b3bf367f4so6648263a34.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 12:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724785774; x=1725390574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/1E8+rBKwc/2VH5T6HtQYLSgh6yFiIlVDmVwD9tg2Y=;
 b=sve3UaHgX2X4SfOBEJG5S/QXjnFUGFZKKXklwMS5KIrJO6F1yanP1z0Fuf48m4ddeB
 e/NDR85wKQXBYr2xP3RgWJ+OCYYgXTje4NVk8PhkuOz7JIixWcKpm+nWzlJDbuUug7NK
 HSlo6vl0H4vtIfauuyYW1JS7hpHDzoN1lie/R7x3AHYFINNL6h/CFwAhAGOR2FDjgqpF
 m0CM7Dd4WejNBAhJSAoWhYMTmKXDRGoBtiMrcd+zJ/i0MH63X1mRDu7C2eHwTVQyz5MB
 xZDhS6sIsaG9R/Pt35IsSd4wSfdJKIbvfjDnTB3KZWNMsdkMlauqIWM1xILI1PA2kT2z
 TGNw==
X-Gm-Message-State: AOJu0YxVBLloCAJ9tcNi4NekJtpoWouub5MRZZMCZC/m4QWfpTvTrI/G
 FgY0WJNfLftUCDlmpRQyRYlbiOvBkUS7bVpDFHm2edu02GSeN48PT85Yqf+DuSXjxOvML2fNmxi
 JtI2kRBXR+FOqp2sbmLlniV3XG5zN0WhfIZRPK7U9bFtPA1ct5cMI
X-Received: by 2002:a05:6830:418c:b0:700:d3b7:4ede with SMTP id
 46e09a7af769-70f4847650cmr4251144a34.27.1724785774246; 
 Tue, 27 Aug 2024 12:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXxtoGlayMb2jzSqnaVHiKlt/lM39MCujAdrnM7uhKRXp0C9bq4FAkljSvwOMRN6z59784Q==
X-Received: by 2002:a05:6830:418c:b0:700:d3b7:4ede with SMTP id
 46e09a7af769-70f4847650cmr4251126a34.27.1724785773892; 
 Tue, 27 Aug 2024 12:09:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1b7d2asm54444531cf.93.2024.08.27.12.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:09:33 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:09:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
Message-ID: <Zs4ka2-q6JJbL1KA@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
 <87mskxx0ck.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mskxx0ck.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 03:54:51PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 27, 2024 at 02:46:06PM -0300, Fabiano Rosas wrote:
> >> Add documentation clarifying the usage of the multifd methods. The
> >> general idea is that the client code calls into multifd to trigger
> >> send/recv of data and multifd then calls these hooks back from the
> >> worker threads at opportune moments so the client can process a
> >> portion of the data.
> >> 
> >> Suggested-by: Peter Xu <peterx@redhat.com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> Note that the doc is not symmetrical among send/recv because the recv
> >> side is still wonky. It doesn't give the packet to the hooks, which
> >> forces the p->normal, p->zero, etc. to be processed at the top level
> >> of the threads, where no client-specific information should be.
> >> ---
> >>  migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 70 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/migration/multifd.h b/migration/multifd.h
> >> index 13e7a88c01..ebb17bdbcf 100644
> >> --- a/migration/multifd.h
> >> +++ b/migration/multifd.h
> >> @@ -229,17 +229,81 @@ typedef struct {
> >>  } MultiFDRecvParams;
> >>  
> >>  typedef struct {
> >> -    /* Setup for sending side */
> >> +    /*
> >> +     * The send_setup, send_cleanup, send_prepare are only called on
> >> +     * the QEMU instance at the migration source.
> >> +     */
> >> +
> >> +    /*
> >> +     * Setup for sending side. Called once per channel during channel
> >> +     * setup phase.
> >> +     *
> >> +     * Must allocate p->iov. If packets are in use (default), one
> >
> > Pure thoughts: wonder whether we can assert(p->iov) that after the hook
> > returns in code to match this line.
> 
> Not worth the extra instructions in my opinion. It would crash
> immediately once the thread touches p->iov anyway.

It might still be good IMHO to have that assert(), not only to abort
earlier, but also as a code-styled comment.  Your call when resend.

PS: feel free to queue existing patches into your own tree without
resending the whole series!

> 
> >
> >> +     * extra iovec must be allocated for the packet header. Any memory
> >> +     * allocated in this hook must be released at send_cleanup.
> >> +     *
> >> +     * p->write_flags may be used for passing flags to the QIOChannel.
> >> +     *
> >> +     * p->compression_data may be used by compression methods to store
> >> +     * compression data.
> >> +     */
> >>      int (*send_setup)(MultiFDSendParams *p, Error **errp);
> >> -    /* Cleanup for sending side */
> >> +
> >> +    /*
> >> +     * Cleanup for sending side. Called once per channel during
> >> +     * channel cleanup phase. May be empty.
> >
> > Hmm, if we require p->iov allocation per-ops, then they must free it here?
> > I wonder whether we leaked it in most compressors.
> 
> Sorry, this one shouldn't have that text.

I still want to double check with you: we leaked iov[] in most compressors
here, or did I overlook something?

That's definitely more important than the doc update itself..

> 
> >
> > With that, I wonder whether we should also assert(p->iov == NULL) after
> > this one returns (squash in this same patch).
> >
> >> +     */
> >>      void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
> >> -    /* Prepare the send packet */
> >> +
> >> +    /*
> >> +     * Prepare the send packet. Called from multifd_send(), with p
> >
> > multifd_send_thread()?
> 
> No, I meant called as a result of multifd_send(), which is the function
> the client uses to trigger a send on the thread.

OK, but it's confusing.  Some rewords you mentioned below could work.

> 
> >
> >> +     * pointing to the MultiFDSendParams of a channel that is
> >> +     * currently idle.
> >> +     *
> >> +     * Must populate p->iov with the data to be sent, increment
> >> +     * p->iovs_num to match the amount of iovecs used and set
> >> +     * p->next_packet_size with the amount of data currently present
> >> +     * in p->iov.
> >> +     *
> >> +     * Must indicate whether this is a compression packet by setting
> >> +     * p->flags.
> >
> > Sigh.. I wonder whether we could avoid mentioning this, and also we avoid
> > adding new flags for new compressors, relying on libvirt guarding things.
> > Then when we have the handshakes that's something we verify there.
> >
> 
> I understand that part is not in the best shape, but we must document
> the current state. There's no problem changing this later.
> 
> Besides, there's the whole "the migration stream should be considered
> hostile" which might mean we should really be keeping these sanity check
> flags around in case something really weird happens so we don't carry on
> with a bad stream.

Yep, it's OK.

> 
> >> +     *
> >> +     * As a last step, if packets are in use (default), must prepare
> >> +     * the packet by calling multifd_send_fill_packet().
> >> +     */
> >>      int (*send_prepare)(MultiFDSendParams *p, Error **errp);
> >> -    /* Setup for receiving side */
> >> +
> >> +    /*
> >> +     * The recv_setup, recv_cleanup, recv are only called on the QEMU
> >> +     * instance at the migration destination.
> >> +     */
> >> +
> >> +    /*
> >> +     * Setup for receiving side. Called once per channel during
> >> +     * channel setup phase. May be empty.
> >> +     *
> >> +     * May allocate data structures for the receiving of data. May use
> >> +     * p->iov. Compression methods may use p->compress_data.
> >> +     */
> >>      int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
> >> -    /* Cleanup for receiving side */
> >> +
> >> +    /*
> >> +     * Cleanup for receiving side. Called once per channel during
> >> +     * channel cleanup phase. May be empty.
> >> +     */
> >>      void (*recv_cleanup)(MultiFDRecvParams *p);
> >> -    /* Read all data */
> >> +
> >> +    /*
> >> +     * Data receive method. Called from multifd_recv(), with p
> >
> > multifd_recv_thread()?
> 
> Same as before. I'll reword this somehow.
> 
> >
> >> +     * pointing to the MultiFDRecvParams of a channel that is
> >> +     * currently idle. Only called if there is data available to
> >> +     * receive.
> >> +     *
> >> +     * Must validate p->flags according to what was set at
> >> +     * send_prepare.
> >> +     *
> >> +     * Must read the data from the QIOChannel p->c.
> >> +     */
> >>      int (*recv)(MultiFDRecvParams *p, Error **errp);
> >>  } MultiFDMethods;
> >>  
> >> -- 
> >> 2.35.3
> >> 
> 

-- 
Peter Xu



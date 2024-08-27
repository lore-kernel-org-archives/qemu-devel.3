Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6765FC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 21:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj3vv-0006AD-Lb; Tue, 27 Aug 2024 17:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj3vs-000692-CK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj3vn-0008Fh-IT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 17:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724794850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5iSAuCoPUSEv2v4V6f2yG1vdpVp7BnI83tZZz9A6A3U=;
 b=QZY4Z5GaCGfbC0JeoOMTWfvSmFRq4q3f3oLnkVvY2lMZsiPnILWa876+Xjag6hConq952W
 1IAqWwoas5XcxRQNTVzQwQJ6+RhpIZUuR/7SibJZA6grjZCgZFaaH1eySBzRStc7r8Ydxx
 n+0yh6pn0wAbXfsObXtzstVnxVUgjyg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-Ob6Wcm2tOOGVcB13RbMc2A-1; Tue, 27 Aug 2024 17:40:48 -0400
X-MC-Unique: Ob6Wcm2tOOGVcB13RbMc2A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44ff816bf5aso83811521cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 14:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724794848; x=1725399648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iSAuCoPUSEv2v4V6f2yG1vdpVp7BnI83tZZz9A6A3U=;
 b=K3WUcm4Ek744Wxi4LRX32wpksOxgSMVWfUDyFzwKVaJhoWbGTMIW8mXI1HluYsvLa/
 kTTyZemRhDodcGzeJY53pduBhOIGumjD8Ei5COWVnkM1BFagtqLBnfLQgorCdgBFyqEx
 vbLv++2EgxloecQuheYm87OoOPu8D+v/qEZtH7fjH+JKBE76hNA0gtVkA8M9KfTOVEYT
 w911CAFMUBwhf7DJm6c8S1posrAf29hKKLEqOBGRV3It/zCpX8QPKMqvcaUDkfxw1ald
 ztTztSTkkI3L4mwWwz+IjJRpfzVcB62xMzQG/IIYho4HbD/v/hoju9FYIVAKGGzy/L1O
 Lp2A==
X-Gm-Message-State: AOJu0YyHCBLdY6E5T+yHLgGuXU2joTtnf8AaKTD0IURVQ/O7yn6ZMFdH
 VLfWXTnX5npgxQ3QvEj85YkKOKO5CtvwVmD45yK4WLca/mILTcJh6lRg2TFB5VlqCFP+NJP/gxR
 kGdZtg0J2wLPpppOd8H3PqKB85z5yk+itWrnOaaOxGxpDW7eQhsKR
X-Received: by 2002:a05:622a:22a9:b0:446:6282:b903 with SMTP id
 d75a77b69052e-45509c2f9bcmr151345391cf.25.1724794848118; 
 Tue, 27 Aug 2024 14:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjgiOEGtg5NbtL0F3sQ9LDao3Qfpl8rX8FoevgrXkCucLv52Q3JnSthgJRim7k7qS98XnYxA==
X-Received: by 2002:a05:622a:22a9:b0:446:6282:b903 with SMTP id
 d75a77b69052e-45509c2f9bcmr151345251cf.25.1724794847717; 
 Tue, 27 Aug 2024 14:40:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1b78absm56233381cf.86.2024.08.27.14.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 14:40:47 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:40:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
Message-ID: <Zs5H3TtkFfLFDrTw@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
 <87mskxx0ck.fsf@suse.de> <Zs4ka2-q6JJbL1KA@x1n>
 <87jzg1wza0.fsf@suse.de> <Zs4spTkGlJJuB7LT@x1n>
 <87zfoxogvr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfoxogvr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 27, 2024 at 05:22:32PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 27, 2024 at 04:17:59PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Aug 27, 2024 at 03:54:51PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Tue, Aug 27, 2024 at 02:46:06PM -0300, Fabiano Rosas wrote:
> >> >> >> Add documentation clarifying the usage of the multifd methods. The
> >> >> >> general idea is that the client code calls into multifd to trigger
> >> >> >> send/recv of data and multifd then calls these hooks back from the
> >> >> >> worker threads at opportune moments so the client can process a
> >> >> >> portion of the data.
> >> >> >> 
> >> >> >> Suggested-by: Peter Xu <peterx@redhat.com>
> >> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> >> ---
> >> >> >> Note that the doc is not symmetrical among send/recv because the recv
> >> >> >> side is still wonky. It doesn't give the packet to the hooks, which
> >> >> >> forces the p->normal, p->zero, etc. to be processed at the top level
> >> >> >> of the threads, where no client-specific information should be.
> >> >> >> ---
> >> >> >>  migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
> >> >> >>  1 file changed, 70 insertions(+), 6 deletions(-)
> >> >> >> 
> >> >> >> diff --git a/migration/multifd.h b/migration/multifd.h
> >> >> >> index 13e7a88c01..ebb17bdbcf 100644
> >> >> >> --- a/migration/multifd.h
> >> >> >> +++ b/migration/multifd.h
> >> >> >> @@ -229,17 +229,81 @@ typedef struct {
> >> >> >>  } MultiFDRecvParams;
> >> >> >>  
> >> >> >>  typedef struct {
> >> >> >> -    /* Setup for sending side */
> >> >> >> +    /*
> >> >> >> +     * The send_setup, send_cleanup, send_prepare are only called on
> >> >> >> +     * the QEMU instance at the migration source.
> >> >> >> +     */
> >> >> >> +
> >> >> >> +    /*
> >> >> >> +     * Setup for sending side. Called once per channel during channel
> >> >> >> +     * setup phase.
> >> >> >> +     *
> >> >> >> +     * Must allocate p->iov. If packets are in use (default), one
> >> >> >
> >> >> > Pure thoughts: wonder whether we can assert(p->iov) that after the hook
> >> >> > returns in code to match this line.
> >> >> 
> >> >> Not worth the extra instructions in my opinion. It would crash
> >> >> immediately once the thread touches p->iov anyway.
> >> >
> >> > It might still be good IMHO to have that assert(), not only to abort
> >> > earlier, but also as a code-styled comment.  Your call when resend.
> >> >
> >> > PS: feel free to queue existing patches into your own tree without
> >> > resending the whole series!
> >> >
> >> >> 
> >> >> >
> >> >> >> +     * extra iovec must be allocated for the packet header. Any memory
> >> >> >> +     * allocated in this hook must be released at send_cleanup.
> >> >> >> +     *
> >> >> >> +     * p->write_flags may be used for passing flags to the QIOChannel.
> >> >> >> +     *
> >> >> >> +     * p->compression_data may be used by compression methods to store
> >> >> >> +     * compression data.
> >> >> >> +     */
> >> >> >>      int (*send_setup)(MultiFDSendParams *p, Error **errp);
> >> >> >> -    /* Cleanup for sending side */
> >> >> >> +
> >> >> >> +    /*
> >> >> >> +     * Cleanup for sending side. Called once per channel during
> >> >> >> +     * channel cleanup phase. May be empty.
> >> >> >
> >> >> > Hmm, if we require p->iov allocation per-ops, then they must free it here?
> >> >> > I wonder whether we leaked it in most compressors.
> >> >> 
> >> >> Sorry, this one shouldn't have that text.
> >> >
> >> > I still want to double check with you: we leaked iov[] in most compressors
> >> > here, or did I overlook something?
> >> 
> >> They have their own send_cleanup function where p->iov is freed.
> >
> > Oh, so I guess I just accidentally stumbled upon
> > multifd_uadk_send_cleanup() when looking..
> 
> Yeah, this is a bit worrying. The reason this has not shown on valgrind
> or the asan that Peter ran recently is that uadk, qpl and soon qat are
> never enabled in a regular build. I have myself introduced compilation
> errors in those files that I only caught by accident at a later point
> (before sending to the ml).

I tried to manually install qpl and uadk just now but neither of them is
trivial to compile and install..  I hit random errors here and there in my
first shot.

OTOH, qatzip packages are around at least in Fedora repositories, so that
might be the easiest to reach.  Not sure how's that when with OpenSUSE.

Shall we perhaps draft an email and check with them? E.g., would that be
better if there's plan they would at some point provide RPMs for libraries
at some point so that we could somehow integrate that into CI routines?

> 
> >
> > I thought I looked a few more but now when I check most of them are indeed
> > there but looks like uadk is missing that.
> >
> > I think it might still be a good idea to assert(iov==NULL) after the
> > cleanup..
> 
> Should we maybe just free p->iov at the top level then?

We could, but if so it might be good to also allocate at the top level so
the hooks are paired up on these allocations/frees.

IMHO we could already always allocate iov[] to page_count+2 which is the
maximum of all compressors - currently we've got 128 pages per packet by
default, which is 128*16=2KB iov[] per channel.  Not so bad when only used
during migrations.

Or we can perhaps do send_setup(..., &iovs_needed), returns how many iovs
are needed, then multifd allocates them.

-- 
Peter Xu



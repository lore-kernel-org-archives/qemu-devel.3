Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A532C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqCi-0000FW-0X; Sun, 04 Feb 2024 23:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqCf-0000FL-Aq
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqCa-0000Cg-ST
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707105803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G/gDphNghsmQS8DPQsoFTxZLch9SQ6s2lv/gFq3TZnA=;
 b=cxmICPSbX9NOpmKdkg5JiI7Ofq9CbFnf+JtPY8LBVC32ST5V+oyj/EWEPVD+EUF26MLIXe
 JE5ywy2lFh0ceI4mSGszA45Rc0IKCIoeQRbZEWoKJrh5Vx2p1HEp0a2DPPTE20kHzkNAFW
 /a6jc06k34jVdMAu0MaST2B20z8Vk60=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-6pI_nxahMcyRPsWwt45Pkw-1; Sun, 04 Feb 2024 23:03:21 -0500
X-MC-Unique: 6pI_nxahMcyRPsWwt45Pkw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bfbf4dcca9so734064b6e.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707105801; x=1707710601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/gDphNghsmQS8DPQsoFTxZLch9SQ6s2lv/gFq3TZnA=;
 b=l9IpMx4orDrQPbATfbTICAuu+6a3tLlc5ak6mleqVKcBP8xZ86XbrJm9w8KKZ6laMT
 39Zot6jjxT/ixvZosXrLpYvObTPT4B4gUH04fhNx5EU/K+qLNueFEVdjxjdrR/eZ9gIK
 idbIz24FlVm0IyBazB7I6C8rVIaeWCU859JrWfRSCy4EGSMD2IfXCj9vQAw7BL5xw3G4
 KJsQlXvWaVmPnRW/2nbG6DzgRMUr9df/ZwikBbB6pROfPjrpZfp7zxYhy+ktzYzxVsRY
 bCIixzoA4qW7FCPhsPB86v+JUTwdIbWBSLhebLDE8X3GA4R3zFG83k0JRrsVsGIpi21y
 oEZw==
X-Gm-Message-State: AOJu0YyddGqFjo4uTFrmpkP8ZGGAQ3dAgudiGA3cdI4GJvCmAdaEH+a6
 OeGd1Iqs8x7iLq0brgn7RiUViDfseB3Cqd5AJ2s4TY9JN/oeOQr6U4kCXp35bFD+D8A0CBVbQUc
 nNqiwKCCwwNcZAmT2ZU9WrZFYDUdV0t6Ha+q5F/sa6gNieybWwJ+K
X-Received: by 2002:a05:6359:71ca:b0:178:b0c6:577b with SMTP id
 uf10-20020a05635971ca00b00178b0c6577bmr10838207rwb.2.1707105801088; 
 Sun, 04 Feb 2024 20:03:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3MXLm8nfnjSsvPdlIcVHSJ0hgbA1BzwWo/wbwv4HGkKyxSF8uLj4djHAKdMPjd4OzhxDKBg==
X-Received: by 2002:a05:6359:71ca:b0:178:b0c6:577b with SMTP id
 uf10-20020a05635971ca00b00178b0c6577bmr10838190rwb.2.1707105800715; 
 Sun, 04 Feb 2024 20:03:20 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVrRdnXWGlsETbKXgHZZjZ9QyCs3Ri8Nt+U268OP0cUBaiHZ0vRrD+wGR8f+no5IonOQhgRCZsV01GLdMyg3f+cD3gNdY6i2v0kGE++h4iIDkQVS8ksSeqhAtKHQB9LMOCSQYfQ8Mo3f6ynT77BdTEyMzVD9GR/0O79YATlwlm3AXeKHTQbdQ8BriulwQlGkvXxszKRuOTOv315VGiLxuc=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g15-20020a056a0023cf00b006d9a38fe569sm5496972pfc.89.2024.02.04.20.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 20:03:20 -0800 (PST)
Date: Mon, 5 Feb 2024 12:03:10 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 18/23] migration/multifd: Rewrite multifd_queue_page()
Message-ID: <ZcBd_hDAUKgmUAhX@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-19-peterx@redhat.com>
 <87cyteh9va.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyteh9va.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Feb 02, 2024 at 05:47:05PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > The current multifd_queue_page() is not easy to read and follow.  It is not
> > good with a few reasons:
> >
> >   - No helper at all to show what exactly does a condition mean; in short,
> >   readability is low.
> >
> >   - Rely on pages->ramblock being cleared to detect an empty queue.  It's
> >   slightly an overload of the ramblock pointer, per Fabiano [1], which I
> >   also agree.
> >
> >   - Contains a self recursion, even if not necessary..
> >
> > Rewrite this function.  We add some comments to make it even clearer on
> > what it does.
> >
> > [1] https://lore.kernel.org/r/87wmrpjzew.fsf@suse.de
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Patch looks good, but I have a question below.
> 
> > ---
> >  migration/multifd.c | 56 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 19 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 35d4e8ad1f..4ab8e6eff2 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -506,35 +506,53 @@ static bool multifd_send_pages(void)
> >      return true;
> >  }
> >  
> > +static inline bool multifd_queue_empty(MultiFDPages_t *pages)
> > +{
> > +    return pages->num == 0;
> > +}
> > +
> > +static inline bool multifd_queue_full(MultiFDPages_t *pages)
> > +{
> > +    return pages->num == pages->allocated;
> > +}
> > +
> > +static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
> > +{
> > +    pages->offset[pages->num++] = offset;
> > +}
> > +
> >  /* Returns true if enqueue successful, false otherwise */
> >  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >  {
> > -    MultiFDPages_t *pages = multifd_send_state->pages;
> > -    bool changed = false;
> > +    MultiFDPages_t *pages;
> > +
> > +retry:
> > +    pages = multifd_send_state->pages;
> >  
> > -    if (!pages->block) {
> > +    /* If the queue is empty, we can already enqueue now */
> > +    if (multifd_queue_empty(pages)) {
> >          pages->block = block;
> > +        multifd_enqueue(pages, offset);
> > +        return true;
> >      }
> >  
> > -    if (pages->block == block) {
> > -        pages->offset[pages->num] = offset;
> > -        pages->num++;
> > -
> > -        if (pages->num < pages->allocated) {
> > -            return true;
> > +    /*
> > +     * Not empty, meanwhile we need a flush.  It can because of either:
> > +     *
> > +     * (1) The page is not on the same ramblock of previous ones, or,
> > +     * (2) The queue is full.
> > +     *
> > +     * After flush, always retry.
> > +     */
> > +    if (pages->block != block || multifd_queue_full(pages)) {
> > +        if (!multifd_send_pages()) {
> > +            return false;
> >          }
> > -    } else {
> > -        changed = true;
> > -    }
> > -
> > -    if (!multifd_send_pages()) {
> > -        return false;
> > -    }
> > -
> > -    if (changed) {
> > -        return multifd_queue_page(block, offset);
> > +        goto retry;
> >      }
> >  
> > +    /* Not empty, and we still have space, do it! */
> > +    multifd_enqueue(pages, offset);
> 
> Hm, here you're missing the flush of the last group of pages of the last
> ramblock. Just like current code...
> 
> ...which means we're relying on the multifd_send_pages() at
> multifd_send_sync_main() to send the last few pages. So how can that
> work when multifd_flush_after_each_section==false? Because it skips the
> sync flag, but would also skip the last send. I'm confused.

IIUC it won't skip the final flush of the last pages.  See
find_dirty_block():

            if (migrate_multifd() &&
                !migrate_multifd_flush_after_each_section()) {
                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                int ret = multifd_send_sync_main();
                if (ret < 0) {
                    return ret;
                }
                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
                qemu_fflush(f);
            }

IMHO this should be the last flush of the pages when we loop one more
round.

Maybe what you're talking about this one (of ram_save_complete())?

    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
    }

I remember we talked about this somewhere in your "file" series,
but.. AFAIU this last RAM_SAVE_FLAG_MULTIFD_FLUSH might be redundant, it
just needs some justifications to double check I didn't miss something.

Now multifd_queue_page() is kind of lazy-mode on flushing, I think that may
make some sense (we assign job unless required, so maybe there's higher
chance that one thread is free?), but I'm not sure whether that's a huge
deal if NIC is the bandwidth, because in that case we'll wait for sender
threads anyway, and they should all be busy at any time.

However even if we flush immediately as long as full, we'd still better
check queue is empty before completion of migration for sure, to make sure
nothing is left.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B794ECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjRZ-0003Zz-HS; Mon, 22 Jun 2026 14:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjRW-0003ZX-KC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbjRU-0001wm-Lm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782153138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mWNERajQw/axXsT1s3wure3ZWoJzwTnDdheekMcHMgo=;
 b=QXl2dhGy/R+uAUYwTaEaJ3JqQDco8/Zo9uK2NrqrjqKNEbRJjCmwyLWYZTygLotMk7F0pi
 LPbB98u0I+wMBVITdMIzJ0OANt7sJKbPaBknz+YUubzL8ek8LbCxlZcn0oJFjsHeXbFfyS
 svoC0i2h/pwKqlm0cMUd8bxh9LfSs0g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-duhaCbVoNn6saMI0lCVOjg-1; Mon, 22 Jun 2026 14:32:17 -0400
X-MC-Unique: duhaCbVoNn6saMI0lCVOjg-1
X-Mimecast-MFC-AGG-ID: duhaCbVoNn6saMI0lCVOjg_1782153136
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dcfdbe9da2so60731266d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782153136; x=1782757936; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mWNERajQw/axXsT1s3wure3ZWoJzwTnDdheekMcHMgo=;
 b=oM+8s3IGgtmxSvdlnVb+UWEiA9sUdKwEQQoZAp5RqyggZp0CAnQ2NlT7ryCKRI/5wh
 pckJKFE2vsY94np0etuUlnTbrccFpA9Jyw741xBvyHA8BCOlYXO72omVTCFP1Qy/k7cK
 kHjVz47/UeX/oCjsIRDAOeO2ULPy7YeEOE9e1ue4+QfkU0U1dQqZW1twOQ5ngAfG/IVr
 nJciisBpbBLXTD2A57UelmjPMLfY7v96YDgpO8IGCTde6Z5nkYApt4gis54GSoMwOZ2m
 0hd4fb2kXxqaHz7H836nDy6KL57HtoTKY2Bk6Aj3wi0dUAc/bOopjpbo19+MMukqHsQT
 TXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782153136; x=1782757936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWNERajQw/axXsT1s3wure3ZWoJzwTnDdheekMcHMgo=;
 b=GBonsFPywWSlLKdxiwOtoLUx4lqzdZhEMcGlbbTV8bhG/gV7gI2Uet5UJf3aPSzxvH
 xs8fBz+gx+QEBgeWsuzwtCza4xqaM2t0Z1RiPtxqQqrn+G3rn06PPSlQQ2H1c2YcLS8K
 vry3pXPNIi/O3ywcCdCjJi1BuQHNk6GYyC7ohoeS7K4B6MRLEDYaFCI4r+aqAziLy2KS
 rFVsb3rVwIOqB0tRYci+SFof0OqnWykl8aQXRWXaAqdn/ENjbFKfBo13N3Iil0vCIvw8
 BdVVFrUG5gp0BqFvadhEIUkx6lwxD/uDlniCPLndOvhZz4+2k1YGU4sEohPydnFQE8Kk
 kQuA==
X-Gm-Message-State: AOJu0Yy70gMuz5vbri48ISA3pttN+6xNesNRL1kkd+oWv/qgScSLNlVj
 BveNMlJaR595OcGruajgjdTdHA4BI4WmfyG14SiF2JuvCBA3mSY0RMhigS9utbP9KWF+gkgIBHd
 HoHwVOyWndWFEaRU+SEB/1JFtwTrJlNcCAsS0kpXts+89XyI+P9xJayGr
X-Gm-Gg: AfdE7ck1Jk4keqvnr4MOhviyEFgSqTtvhg9ScDs7/Hz0zhZqhW7bTuijtP68QBtVT/x
 gsomx9uvMyaJzQjgAMebfTgyxX9bW9arhtZjnUkMIkjnSLagN9MfCvo/IchNeKdfhG9Bfn781GU
 Okm4oX4MFFSo0AHhVxwVMPYtGtEqQsvD/wQbITHZ78WZV8esLcmfiAzxIeQafHveDLTxFA2Ew8i
 PvVCBTiSj2bMNHl8DUtVpeMnkMt5jO/lkCYQwfID3sFTqP8XYb7sn8yITIcptY83qrg8jmqgD/Y
 3pyPCRg5g+bqbaWlDpV/41O2R17O17H+fKYGtmE8uk/EpjUv+coVUNoFMyXaamCaQGoLj4RxB7t
 NFtAx
X-Received: by 2002:a05:6214:d09:b0:8cc:2a92:11b6 with SMTP id
 6a1803df08f44-8de3f0c4ef2mr242347176d6.9.1782153136004; 
 Mon, 22 Jun 2026 11:32:16 -0700 (PDT)
X-Received: by 2002:a05:6214:d09:b0:8cc:2a92:11b6 with SMTP id
 6a1803df08f44-8de3f0c4ef2mr242346376d6.9.1782153135309; 
 Mon, 22 Jun 2026 11:32:15 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7f8f1464sm114212226d6.19.2026.06.22.11.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 11:32:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:32:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 2/5] migration: add support for fault thread to load
 pages from disk
Message-ID: <ajl_oz63TGnhMwvL@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-3-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618032010.88755-3-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 18, 2026 at 08:50:07AM +0530, Aadeshveer Singh wrote:
> In fast snapshot load, we would like to serve faults as soon as possible
> hence loading pages directly instead of requesting a source
> 
> Add postcopy_mapped_ram_load_page() function which serves single page
> fault by reading the snapshot file. It uses bitmap_test_and_clear_atomic
> on pending_bmap to coordinate between threads so each page is loaded
> exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> temporary page (for loading page atomically), which is then placed using
> postcopy_place_page. Zero pages are placed directly using
> postcopy_place_page_zero.
> 
> Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> instead of requesting source in case of fast snapshot load. to_src_file
> check is bypassed in fast snapshot load case as there is no source
> 
> Allocate another channel in postcopy_temp_pages_setup(like the preempt
> case), for both the fault thread and eager thread to load pages
> independently.
> 
> In case of failure to read required page crash the system using assert
> as disk failure is critical and VM cannot be recovered.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 92 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 75 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f5ef93f193..1ec20a07dd 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -949,6 +949,53 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                         pagesize);
>  }
>  
> +/*
> + * Load a page from RAMBlock at offset at given host address.
> + * Used by postcopy ram fault thread and eager thread in fast snapshot load
> + * case. rb_offset: Offset of page in RAMBlock haddr: Base of page where to load
> + * in page Channel: Used to identify between threads and use corresponding temp
> + * pages Returns 0 on success
> + */

Somehow this paragraph is not properly formatted with newlines.  If you
want to provide a full doc of the function, you can follow kernel-doc
format:

https://docs.kernel.org/doc-guide/kernel-doc.html

/**
 * function_name() - desc
 *
 * @arg1: desc for @arg1
 * @arg2: desc for @arg2
 * ...

> +static int postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> +                                         RAMBlock *rb, ram_addr_t rb_offset,
> +                                         uint64_t haddr, int channel)
> +{
> +    int ret = 0;
> +    unsigned long page;
> +    void *host = (void *)haddr;

Can drop this var.

> +    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
> +    size_t read;

Nit: can use reverse christmas tree.

> +
> +    page = rb_offset >> TARGET_PAGE_BITS;
> +
> +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> +        if (test_bit(page, rb->nonzeropages)) {
> +            /*
> +             * qemu_get_buffer_at uses preadv which is thread safe we do not
> +             * need different channels
> +             */

Slightly misleading when the two threads do not use the same "channel" (or
say, temp pages..).  Maybe what you wanted to emphasize is QEMU might have
more than one thread using this function to install pages.  In that case,
it can be put as:

               /*
                * This can happen concurrently, but it's thread-safe because
                * qemu_get_buffer_at() is thread-safe, and the caller will be
                * using different temporary buffers.
                */

> +            read = qemu_get_buffer_at(mis->from_src_file, place_source,
> +                                      TARGET_PAGE_SIZE,
> +                                      rb->pages_offset + rb_offset);
> +
> +            g_assert(read == TARGET_PAGE_SIZE);

Two things can be improved on errors:

- When an error can be reached with user input, logically we shouldn't
  assert(), assert() is only for program errors.  Here it's possible an
  user specified a broken image, then we should cleanly exit with an err
  code.

- Still better to report the error to the caller and only handle error at
  the very top caller after throwing the error to stderr.

I did suggest that we can assert on loading failures when we talked, but I
confess I was not clear on how to do, sorry.  Let's use assert() only if
it's a programming error.

Postcopy didn't do as good on error reporting, normally nowadays QEMU
suggests to use "bool function(..., Error **errp)" as function interface,
return false if failure hit.  You can do it with the new functions like
this, then return the Error** object to the top caller and do one
error_report() before exit().

Alone the way if you want to convert some postcopy code to start using
Error** it'll be even better.  Feel free to have a look at the comments at
the start of include/qapi/error.h on the suggested way to handle errors in
QEMU.

> +
> +            ret = postcopy_place_page(mis, host, place_source, rb);
> +            if (ret) {
> +                return ret;
> +            }
> +
> +        } else {
> +            /* zero page */

Nit, we can drop this comment.

> +            ret = postcopy_place_page_zero(mis, host, rb);
> +            if (ret) {
> +                return ret;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
>  /*
>   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
>   * also optional: when zero is provided, the fault accounting will be ignored.
> @@ -1320,11 +1367,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
>              break;
>          }
>  

We can leave below comments as-is, then add one line here to explain:

           /*
            * Fast snapshot load doesn't support pause and recover, because
            * it's not necessary: we can fail right away when QEMU just booted
            * with nothing to lose.
            */

> -        if (!mis->to_src_file) {
> +        if (!migrate_fast_snapshot_load() && !mis->to_src_file) {
>              /*
> -             * Possibly someone tells us that the return path is
> -             * broken already using the event. We should hold until
> -             * the channel is rebuilt.
> +             * Fast snapshot load has no to src file or in other case someone
> +             * possibly tells us that the return path is broken already using
> +             * the event. We should hold until the channel is rebuilt.
>               */
>              postcopy_pause_fault_thread(mis);
>          }
> @@ -1387,18 +1434,26 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                                                  qemu_ram_get_idstr(rb),
>                                                  rb_offset,
>                                                  msg.arg.pagefault.feat.ptid);
> +
> +            if (migrate_fast_snapshot_load()) {
> +                if (postcopy_mapped_ram_load_page(
> +                        mis, rb, rb_offset, msg.arg.pagefault.address, 1)) {

s/1/RAM_CHANNEL_POSTCOPY/?  I agree it's not ideal with the current names,
but it is still kind of suitable.

> +                    break;
> +                }

With above, we can error_report() here and exit() when error happens.

> +            } else {
>  retry:
> -            /*
> -             * Send the request to the source - we want to request one
> -             * of our host page sizes (which is >= TPS)
> -             */
> -            ret = postcopy_request_page(mis, rb, rb_offset,
> -                                        msg.arg.pagefault.address,
> -                                        msg.arg.pagefault.feat.ptid);
> -            if (ret) {
> -                /* May be network failure, try to wait for recovery */
> -                postcopy_pause_fault_thread(mis);
> -                goto retry;
> +                /*
> +                 * Send the request to the source - we want to request one
> +                 * of our host page sizes (which is >= TPS)
> +                 */
> +                ret = postcopy_request_page(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address,
> +                                            msg.arg.pagefault.feat.ptid);
> +                if (ret) {
> +                    /* May be network failure, try to wait for recovery */
> +                    postcopy_pause_fault_thread(mis);
> +                    goto retry;
> +                }
>              }
>          }
>  
> @@ -1471,8 +1526,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
>      unsigned i, channels;
>      void *temp_page;
>  
> -    if (migrate_postcopy_preempt()) {
> -        /* If preemption enabled, need extra channel for urgent requests */
> +    if (migrate_postcopy_preempt() || migrate_fast_snapshot_load()) {
> +        /*
> +         * If preemption enabled or it is fast snapshot load, need extra channel
> +         * for urgent requests/faults
> +         */
>          mis->postcopy_channels = RAM_CHANNEL_MAX;
>      } else {
>          /* Both precopy/postcopy on the same channel */
> -- 
> 2.54.0
> 

-- 
Peter Xu



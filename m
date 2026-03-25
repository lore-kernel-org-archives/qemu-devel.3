Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7107F109C02F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5QFz-0004Rb-2L; Wed, 25 Mar 2026 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5QFw-0004Qo-SM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5QFv-0006wM-1d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774452889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYjTE9Ho7x3tH6drbPxf170mSh5NQL1YDczyiwc7TaU=;
 b=Z02tFYpO7hiAmM3zhegNC1NctYLQo6YBpurEc+Rn2DMCRDh6Yo/2IXNG5YQ1gVx621rukY
 Xf0TUIfXO+sLfoM7ry9dBFAqHFGFwcr9LMx1hIPwCp7Tr9kA1q0cNF46+YwGRdTT3Al2xM
 UYzOipEuPUBYSsJVektAhUnCv/cebHA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-kmrXT-YINU-q05A9zR498w-1; Wed, 25 Mar 2026 11:34:46 -0400
X-MC-Unique: kmrXT-YINU-q05A9zR498w-1
X-Mimecast-MFC-AGG-ID: kmrXT-YINU-q05A9zR498w_1774452886
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7fc27cf7so10288685a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774452886; x=1775057686; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vYjTE9Ho7x3tH6drbPxf170mSh5NQL1YDczyiwc7TaU=;
 b=UKlsvx7E7aTDvA4HLI4/UHTCXB+ELAtRlu012Xnu4ZiuVlAs5SiVNqquhrzXGDnUhp
 ViTDCJ/1aBU7IVUWQjQ5SXMJNCdBQOBBwvvuWt7P3KzOR6HapcRpcaXkfeH8psjmXz+x
 PtZi38sFMHKIQa9eGlAdXUitMRWl7LNiBAkp5FDJSJod2TrozEAvZcOwLe2nbNWg/Mbk
 qzZZolDfPZXQ3XZI4mfn2JNbcK7KxpxgcqiWJesKpiLrvbQzW5emAVyCdKtN7vZ/TTWa
 8F8JQ1vuF5/EBb1+m6OUNsLAvyP0/FZZiFokCGyMXkd/BKmqBaJEZLZK+jBB7NcCVlH5
 B/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452886; x=1775057686;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYjTE9Ho7x3tH6drbPxf170mSh5NQL1YDczyiwc7TaU=;
 b=rJStHzsPnympeYjVR8sgkYs2WeGsMHJTyXEYR2vuHmoUcTV9cck0eYK+AYrhlufAaI
 2LQ9RVZ81rPqzRNwlPfPjDiRNxieydgArDEGrcKYbs+EhxL24SmMIhy5i9qcF1K2qiXj
 Hw6Iph9vx5yi/lcCUFNZCbDMFJRfCPn8hklHPTFa+HAzHY8BWAIFfM4Ao880CKanmtb9
 tomjUsT7oWH9FMFXK8c0W2Seibip+bBXq0A9tYjTFOgfTBn7nHba8WVy8FEosYWkMlHo
 lhHgO95WLanJ5LE+oqVGtf3bEwX22FC6cKh3Bx1CxC9sCIH47yj0a9LvBuqKu/k/0ASS
 ohiw==
X-Gm-Message-State: AOJu0YyY4iCifYbQlgpFizEqCtq4ymaNnaAdeLvU02ZM5H9Oe8HMrHda
 LKtyic5TPANrBOuWaWLfhQv+se2GNeK65vHT9wDkPh6wPTY/6bhp6CKQ34NSizONjKNcHrvPycc
 Q9cfo0TL16kRmNPRS0uslNxDgL4VtmWBa0PdT56kqQn8hv45wqIwP9cmM
X-Gm-Gg: ATEYQzyLwH3ANKZ4fqjmCED4FCEwMfO6uEneEgEZ0m6VGBO2MJEPuQPNGalUJGd8up9
 UMU01ThKq6JCdL4ideK+w6/m9GaPOhsgvpDSZlgqdIrRwpnzTI6Som2acvws75MWW7iG7Zjjz5F
 MkPpZe2MAsqQZLEHXYFsalxKZrYyRPmP+a5n6HJb+FjvKw0KXwqwKDqkQUxDlK6M2pYVyctdSpP
 ZSXudUcy/pRxsvxZ5o3p0gCDrZdT0RGxmIZpU1vekIJRRVz8flsaB/GJdVK48VQaFKaeB6EqSkv
 fHKHfemzEDiN7ri/sHM2jL0432uoTMb/ZvV+xtr7Ldb5ivAMZPPPbkSPAs4/hTCMLuYfNe6Y5iT
 ysvm9QICxPWrBZA==
X-Received: by 2002:a05:620a:31a4:b0:8cf:d565:fcb9 with SMTP id
 af79cd13be357-8d000f1f62fmr556291185a.26.1774452885556; 
 Wed, 25 Mar 2026 08:34:45 -0700 (PDT)
X-Received: by 2002:a05:620a:31a4:b0:8cf:d565:fcb9 with SMTP id
 af79cd13be357-8d000f1f62fmr556284585a.26.1774452884883; 
 Wed, 25 Mar 2026 08:34:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e52d7f4sm8969185a.45.2026.03.25.08.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 08:34:44 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:34:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v3 1/1] io: invert the return semantics of
 qio_channel_flush
Message-ID: <acQAk_bdbb1rSmw_@x1.local>
References: <20260320083950.262119-1-tejus.gk@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320083950.262119-1-tejus.gk@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 20, 2026 at 08:39:41AM +0000, Tejus GK wrote:
> With the kernel's zerocopy notification mechanism, the caller can
> determine whether
>  * All syscalls successfully used zero copy
>  * At least one syscall failed to use zero copy
> 
> But, as of now QEMU's IO channel flush function semantics are like
>  * 1 => all syscalls failed to use zero copy
>  * 0 => at least one syscall successfully used zero copy
> 
> This is not aligned with what the kernel reports, and ends up reporting
> false negatives for cases like when there's just a single successful
> zerocopy amongst a collection of deferred zero-copies during a flush.
> 
> Fix this by inverting the return semantics of the IO flush function.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

Looks good here, thanks.

One trivial thing to mention is the stat exported in QAPI will still be
some "misterious counters":

# @dirty-sync-missed-zero-copy: Number of times dirty RAM
#     synchronization could not avoid copying dirty pages.  This is
#     between 0 and @dirty-sync-count * @multifd-channels.
#     (since 7.1)

It could be a bool too if to match with the current concept of "whether any
fallback happened" and if we want to strictly avoid any magical counter
(currently the counter is neither per IO or per request), but personally
I'm fine either way. I don't think anyone will seriously consume this
counter, so maybe no reason to bother at all.

PS: above "between 0 and @dirty-sync-count * @multifd-channels" is wrong, I
believe it came from multifd_ram_flush_and_sync() invoking flush for each
channels, but we may not always invoke it per-dirty-sync.  But since
there's no good way to define this counter, I don't have a good way to fix
it either if without converting it to a bool.

> ---
>  include/io/channel-socket.h |  6 +-----
>  include/io/channel.h        |  4 ++--
>  io/channel-socket.c         | 16 ++++++++--------
>  3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index a1ef3136ea..b07cd61477 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -50,11 +50,7 @@ struct QIOChannelSocket {
>      ssize_t zero_copy_queued;
>      ssize_t zero_copy_sent;
>      bool blocking;
> -    /**
> -     * This flag indicates whether any new data was successfully sent with
> -     * zerocopy since the last qio_channel_socket_flush() call.
> -     */
> -    bool new_zero_copy_sent_success;
> +    bool zero_copy_fallback;
>  };
>  
>  
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 1b02350437..c357da5460 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -1014,8 +1014,8 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
>   * If not implemented, acts as a no-op, and returns 0.
>   *
>   * Returns -1 if any error is found,
> - *          1 if every send failed to use zero copy.
> - *          0 otherwise.
> + *          1 if at least one send failed to use zero copy.
> + *          0 if every send successfully used zero copy.
>   */
>  
>  int qio_channel_flush(QIOChannel *ioc,
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..ea2ec84108 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -72,7 +72,7 @@ qio_channel_socket_new(void)
>      sioc->zero_copy_queued = 0;
>      sioc->zero_copy_sent = 0;
>      sioc->blocking = false;
> -    sioc->new_zero_copy_sent_success = false;
> +    sioc->zero_copy_fallback = false;
>  
>      ioc = QIO_CHANNEL(sioc);
>      qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -880,9 +880,9 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>          /* No errors, count successfully finished sendmsg()*/
>          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>  
> -        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            sioc->new_zero_copy_sent_success = true;
> +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> +            /* If any sendmsg() fell back to a copy, mark fallback as true */
> +            sioc->zero_copy_fallback = true;
>          }
>      }
>  
> @@ -900,12 +900,12 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>          return ret;
>      }
>  
> -    if (sioc->new_zero_copy_sent_success) {
> -        sioc->new_zero_copy_sent_success = false;
> -        return 0;
> +    if (sioc->zero_copy_fallback) {
> +        sioc->zero_copy_fallback = false;
> +        return 1;
>      }
>  
> -    return 1;
> +    return 0;
>  }
>  
>  #endif /* QEMU_MSG_ZEROCOPY */
> -- 
> 2.43.7
> 

-- 
Peter Xu



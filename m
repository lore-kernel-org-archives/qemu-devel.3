Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B851C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 21:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2wb-0006An-6z; Mon, 05 May 2025 17:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uC2wR-000683-5T
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uC2wO-0003l2-RA
 for qemu-devel@nongnu.org; Mon, 05 May 2025 17:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746478891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPbT98V2CoRxkBusBk6JOM5uHJWvHLndD6YpeBRzqAo=;
 b=Fdr7aAy7ogc5lQOuYu5EOtBtsJVu45zivoMZZgIr5iuuRSQU6GGub49B+nPgM32kX9OhN/
 XtOV5ky80uui8+uQbkqLkHI/r7K7wsRMRteWzVejDLe6woZMYlhB/tDQnNwOV430a37D1c
 EKa5eO2rYVxkN/Yf7pO9lmHSYqh0Mqw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-08qwFoM7MN6hfHsfHMhjow-1; Mon, 05 May 2025 17:01:27 -0400
X-MC-Unique: 08qwFoM7MN6hfHsfHMhjow-1
X-Mimecast-MFC-AGG-ID: 08qwFoM7MN6hfHsfHMhjow_1746478887
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-403290c1620so4711510b6e.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 14:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746478887; x=1747083687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPbT98V2CoRxkBusBk6JOM5uHJWvHLndD6YpeBRzqAo=;
 b=O1xGlx+IECZWIFf419wqkKLF7VgDxculiPfrrjDEs1c7sSGUQVY99R35JE7utNctrO
 roiWBYg9uGzC+zlOPPk4v7K4oSA1RmBFJNLKTMXSZXMR9ZdHPXFYJa24SrkGSIo1YUCq
 G5lI6ipsLJ+Q/5WD8P9fpmTV7eqE4W617GZV8kS1R+6O+H1k5xFYR6bX4XeY8FwmOAPC
 QW5batRAi77IWQ1SAeQTL1OBPD24zT/C9Ybkqw2i8OzT9BvQjWhzUArpa4xwxcylfr34
 96iE+VezHq2+pEPvSmC/7bK4vldWRVunCOeIXrNycLF4iBPIo3TaVDSyj/Ux9THvktnt
 cr/g==
X-Gm-Message-State: AOJu0YxEOffNJ4Au2Ewaz6Jo77Z2gxHNeJYipdtyXGJOc41dBMHZwsVL
 yhlxL1q9NaWIQgQF+bjIAnI67DuMnBbbAGcqeziIh4f9D5LeTqRnWnGKnqb9cYhPzZa6C8zVnCk
 oLvblqatAGePNIbjIn6SHXzBwse/G1QsFz6tKaZagNy3yvnJ9mRXu
X-Gm-Gg: ASbGnctDnZMxIs49DSTMnVdi5O/TIMovidxrkY6CLJRdml0lha/HZErddL+AfcN5kRK
 KNKGBbWyg4kIZTtobAVrJEvVkUr/exnwn45q5FRooFM8WNxK3OsNJKu86Va1XIz6RKoA3OZ7nKT
 /9IvYQyTLHO5PC0In1srHxjAxUwvzAY6iBS/QREiXSSa3AVVcf8EY0OHRb67YorrRZySuUCRfk3
 qjF+p2zFr33ZPDHWUN+owY6D4oexRBwp+4kOLwB2z32Uv7nQwKYBV3BYx+UHRktloa/YVYD1Ux9
 8lU=
X-Received: by 2002:a05:6808:6a96:b0:401:e6c0:3112 with SMTP id
 5614622812f47-403419e01a1mr8247619b6e.15.1746478886909; 
 Mon, 05 May 2025 14:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQaCXZli82tXjWCosL8m1XCaqBg1kl8FFiabMVuw4wwO3rMkF2Y98HzITawHLf/OcM5qLung==
X-Received: by 2002:a05:6808:6a96:b0:401:e6c0:3112 with SMTP id
 5614622812f47-403419e01a1mr8247592b6e.15.1746478886603; 
 Mon, 05 May 2025 14:01:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f50f3d2ea3sm60263906d6.61.2025.05.05.14.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:01:26 -0700 (PDT)
Date: Mon, 5 May 2025 17:01:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] migration/multifd: Fix received packets tracepoint
Message-ID: <aBknIwPX0IXdcAkL@x1.local>
References: <20250416134356.29879-1-farosas@suse.de>
 <20250416134356.29879-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416134356.29879-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 16, 2025 at 10:43:55AM -0300, Fabiano Rosas wrote:
> When qatomic_fetch_inc() started being used to count the number of
> packets sent, the printing of the number of packets received stopped
> matching the number of packets sent.
> 
> Fix by moving the increment of the number of packets on the recv side
> to multifd_recv_unfill_packet().
> 
> Also change the tracepoint text because "packet num" is ambiguous for
> the sync since the packet number of the actual sync packet will be one
> less than the total number of packets seen so far.

Would this be a hint that the recv side may not really need a global
packet_num counter, at all?

On source, it needs to be there if we want to have an unified unique ID for
each multifd packet, so that when allcating a packet we need them to be
assigned properly.

On dest, it almost only receives packets, it's still unclear to me how the
recv packet_num global var could help us considering we have the per-packet
trace in trace_multifd_recv_unfill() dumping the unique ID for each..

So.. would it be of any use?  Would it be better if we remove it instead?

> 
> Fixes: 98ea497d8b ("migration/multifd: Fix MultiFDSendParams.packet_num race")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c    | 6 +-----
>  migration/trace-events | 4 ++--
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index dfb5189f0e..1a16155864 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -310,6 +310,7 @@ static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
>  
>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>  {
> +    qatomic_inc(&multifd_recv_state->packet_num);
>      p->packets_recved++;
>  
>      if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
> @@ -1222,11 +1223,6 @@ void multifd_recv_sync_main(void)
>      for (i = 0; i < thread_count; i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> -        WITH_QEMU_LOCK_GUARD(&p->mutex) {
> -            if (multifd_recv_state->packet_num < p->packet_num) {
> -                multifd_recv_state->packet_num = p->packet_num;
> -            }
> -        }
>          trace_multifd_recv_sync_main_signal(p->id);
>          qemu_sem_post(&p->sem_sync);
>      }
> diff --git a/migration/trace-events b/migration/trace-events
> index c506e11a2e..48acb126f5 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -133,7 +133,7 @@ multifd_new_send_channel_async(uint8_t id) "channel %u"
>  multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
>  multifd_recv_unfill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
>  multifd_recv_new_channel(uint8_t id) "channel %u"
> -multifd_recv_sync_main(long packet_num) "packet num %ld"
> +multifd_recv_sync_main(long packet_num) "packets before sync %ld"
>  multifd_recv_sync_main_signal(uint8_t id) "channel %u"
>  multifd_recv_sync_main_wait(uint8_t id) "iter %u"
>  multifd_recv_terminate_threads(bool error) "error %d"
> @@ -142,7 +142,7 @@ multifd_recv_thread_start(uint8_t id) "%u"
>  multifd_send_fill(uint8_t id, uint64_t packet_num, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " flags 0x%x next packet size %u"
>  multifd_send_ram_fill(uint8_t id, uint32_t normal, uint32_t zero) "channel %u normal pages %u zero pages %u"
>  multifd_send_error(uint8_t id) "channel %u"
> -multifd_send_sync_main(long packet_num) "packet num %ld"
> +multifd_send_sync_main(long packet_num) "packets before sync %ld"
>  multifd_send_sync_main_signal(uint8_t id) "channel %u"
>  multifd_send_sync_main_wait(uint8_t id) "channel %u"
>  multifd_send_terminate_threads(void) ""
> -- 
> 2.35.3
> 

-- 
Peter Xu



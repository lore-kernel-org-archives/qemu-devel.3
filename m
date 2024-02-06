Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B093C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXCGy-00055b-7o; Mon, 05 Feb 2024 22:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCGw-00055D-F1
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXCGv-0001oS-3b
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707190640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxGgKGT7JiyUvMYEHZklE1a9wolWntDHjYJxNAE5pRA=;
 b=W3sygUzFpFJ0qCgvXjjbS5zSa0Vx07Fr8t+0yb2usMXT6gvhN/pZOVsiw9iZv9tunH5WsK
 cpm+vVWj7x4tKUEgV+1B8RKC7m2b//t8gn4qjAEjF+Hd85jxHZc+UGKZlcn4ofr7hxq6zk
 a8v+unZl0WGmO6OgzDayGQjOGF/RdVQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-yw_Clzk3N1y7bqjsXa1G0g-1; Mon, 05 Feb 2024 22:37:18 -0500
X-MC-Unique: yw_Clzk3N1y7bqjsXa1G0g-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso1623336b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707190637; x=1707795437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxGgKGT7JiyUvMYEHZklE1a9wolWntDHjYJxNAE5pRA=;
 b=ldR1t92TQOBR8IcH/ahuuLa1UKmRXf7fOcTiOXICe2Zn6LrZHEUqzDB3B1wDmbaPJd
 XOm/IWB8ZNjH5de1OQjuF8UL5u9LirvnHJ5DbEp2oz63WUkUs7GJXPd6gkeNZNx/i5O4
 ar9cfc1Cyk4dY3qjfDOUmy2NRVo9YJNelnNxSgD+GCqlJWPXGpOyBWeeWliubjf/3USa
 rhIzvdK0cS759ZtDqtJSJ3Dv9gBT9RNFa55bXTdmSGPiQ4qHy55Rl9eseg5MXx9Kiwjx
 qWI8KCcrAgvkVCKwHRTqpqfWqiGW8Vbqq9CShxcq3HIYOYp1s23r0/jDHQRume9zCOsE
 ErxA==
X-Gm-Message-State: AOJu0YyJSkcGNMz4Y3w/UNQKozrhul/EvEkzMCeW+9lXldBY7aWQHMZn
 nhOXfYYu3hV2UTSz9Sl4iRqXMhnA/Ttg1+jad7WayRQj6CHLoTgMtwDBQkq6AEptrJmV/QUGL2h
 NqIGq/ZrSHUHb1UvJyXXErYIe1HOMSfqqBMZ7m0q9pmpE4dNwUhhu
X-Received: by 2002:a05:6a20:3941:b0:19e:5e16:c1e1 with SMTP id
 r1-20020a056a20394100b0019e5e16c1e1mr1625664pzg.0.1707190637648; 
 Mon, 05 Feb 2024 19:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXIes4GQjCDbar55EPRz/kRyxlfP+rMgCi2R6WrlsvoThE8REWZgFZhgOl4ywfycKZrsAHEQ==
X-Received: by 2002:a05:6a20:3941:b0:19e:5e16:c1e1 with SMTP id
 r1-20020a056a20394100b0019e5e16c1e1mr1625654pzg.0.1707190637354; 
 Mon, 05 Feb 2024 19:37:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUdbu/jlAhjuKymzKjR8Uha+MDTYSIE5wlInBxbNPiB/s3yPQZb/HMscIW7VFtwb3l10NCJh1zsjl4aDs54dvIsSkbmdmEW4gE3blC6cfbHh/ACBHQ5iN8=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e92-20020a17090a6fe500b0029604b0b7d1sm330723pjk.15.2024.02.05.19.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:37:17 -0800 (PST)
Date: Tue, 6 Feb 2024 11:37:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 6/6] migration/multifd: Add a synchronization point
 for channel creation
Message-ID: <ZcGpZ5V2YUcUXaLB@x1n>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205194929.28963-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

On Mon, Feb 05, 2024 at 04:49:29PM -0300, Fabiano Rosas wrote:
> It is possible that one of the multifd channels fails to be created at
> multifd_new_send_channel_async() while the rest of the channel
> creation tasks are still in flight.
> 
> This could lead to multifd_save_cleanup() executing the
> qemu_thread_join() loop too early and not waiting for the threads
> which haven't been created yet, leading to the freeing of resources
> that the newly created threads will try to access and crash.
> 
> Add a synchronization point after which there will be no attempts at
> thread creation and therefore calling multifd_save_cleanup() past that
> point will ensure it properly waits for the threads.
> 
> A note about performance: Prior to this patch, if a channel took too
> long to be established, other channels could finish connecting first
> and already start taking load. Now we're bounded by the
> slowest-connecting channel.
> 
> Reported-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> @@ -934,7 +936,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      MultiFDSendParams *p = opaque;
>      QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *local_err = NULL;
> -

This line removal should belong to the previous patch.  I can touch that
up.

>      bool ret;
>  
>      trace_multifd_new_send_channel_async(p->id);

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



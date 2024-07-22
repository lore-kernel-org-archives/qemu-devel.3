Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9956C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0Bl-0006ZT-6m; Mon, 22 Jul 2024 17:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW0Bj-0006Yq-Jg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW0BZ-0004g3-29
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721682187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+lkYv9DSo4QTZ2DsStSxRzi3UjzvOmYE4MSlGvrFlg=;
 b=XhhA2PM0HC1olyflX2C9ufYT17xcYRJ5vg1m0Y96hBzDeX5JNpUc6ACK4i5xAAcGrRasNU
 PCF88qk2cxZcyIIWcrIY8QZg7EeiJK8K6fhanDXLIU1he2Db7vXjVgxwqsEeBXV8+iT29x
 2+/PTFZY0didhx7bfFtxxxlFaU5P6pA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-7Ptgfgj3N_CyhMMmllyDsw-1; Mon, 22 Jul 2024 17:03:05 -0400
X-MC-Unique: 7Ptgfgj3N_CyhMMmllyDsw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b797b6b4aeso15564256d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682185; x=1722286985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+lkYv9DSo4QTZ2DsStSxRzi3UjzvOmYE4MSlGvrFlg=;
 b=lcpLJyz+NboX2nZ9eICb5MTDBXaF8Q+jWM/AFe9PjlMzsBoLN7uX4yrfZwZFO4UHdK
 WrXwFm+t/1gxu2+0jUCkQhUfb1ucHBxOz4588Lrn0FEZdLe/7vdVfKpRsA6OjAZbqozA
 YC9nZsSfWy2WEuz0yEH41zhl2ovglAdrJDgiP7kCUpayHNU00O8ROa6+THji8gy4ERA6
 ZYSZ6Ydim5zGSLqNk4a0TJHS7VKzR9GWWosU/hcyQmZov7rVrc9vY6zmD6l9bxW83n8p
 VWRwXVefT9Z6XIHVQveL1lD7Scx4L1spXlllVMZ8K7KSifNKsBBqTFSSy8MutFOM55xV
 lyrw==
X-Gm-Message-State: AOJu0YywZx2sKHdw0h6AZML5gQLz3+zDbrOHQh2qxbs4BS8a4CzMKBtY
 PCYiE/6UtORVH9yMON3DpGwydtYNa5xtCK4gQ7etma10X09Ys2d6UcLbPNddy7zJLoUP8YNczYN
 CCFkZ7jqXycRHwayvrfWvBhVBYBFPAngan1Orfcr/fa8A6lG6k3uH
X-Received: by 2002:a05:6214:3da0:b0:6b0:8202:5c4e with SMTP id
 6a1803df08f44-6b95a5ae3d5mr62173506d6.5.1721682184948; 
 Mon, 22 Jul 2024 14:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGABtK/PpDQKIaSNH79k1JN+gTxtp+PZPtBhlSiSUhBOhkkJTg2HBVa+forXnQPQh16DYVKmA==
X-Received: by 2002:a05:6214:3da0:b0:6b0:8202:5c4e with SMTP id
 6a1803df08f44-6b95a5ae3d5mr62173416d6.5.1721682184621; 
 Mon, 22 Jul 2024 14:03:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b973e4005bsm14758646d6.42.2024.07.22.14.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:03:04 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:03:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 8/9] migration/multifd: Don't send ram data during
 SYNC
Message-ID: <Zp7JBmVqMYw7rOT9@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Mon, Jul 22, 2024 at 02:59:13PM -0300, Fabiano Rosas wrote:
> Skip saving and loading any ram data in the packet in the case of a
> SYNC. This fixes a shortcoming of the current code which requires a
> reset of the MultiFDPages_t fields right after the previous
> pending_job finishes, otherwise the very next job might be a SYNC and
> multifd_send_fill_packet() will put the stale values in the packet.
> 
> By not calling multifd_ram_fill_packet(), we can stop resetting
> MultiFDPages_t in the multifd core and leave that to the client code.
> 
> Actually moving the reset function is not yet done because
> pages->num==0 is used by the client code to determine whether the
> MultiFDPages_t needs to be flushed. The subsequent patches will
> replace that with a generic flag that is not dependent on
> MultiFDPages_t.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d25b8658b2..4394ca6ade 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -438,6 +438,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
>      uint64_t packet_num;
> +    bool sync_packet = p->flags & MULTIFD_FLAG_SYNC;
>  
>      memset(packet, 0, p->packet_len);
>  
> @@ -452,7 +453,9 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>  
>      p->packets_sent++;
>  
> -    multifd_ram_fill_packet(p);
> +    if (!sync_packet) {
> +        multifd_ram_fill_packet(p);
> +    }
>  
>      trace_multifd_send(p->id, packet_num,
>                         be32_to_cpu(packet->normal_pages),
> @@ -563,7 +566,12 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      p->packet_num = be64_to_cpu(packet->packet_num);
>      p->packets_recved++;
>  
> -    ret = multifd_ram_unfill_packet(p, errp);
> +    if (p->flags & MULTIFD_FLAG_SYNC) {
> +        p->normal_num = 0;
> +        p->zero_num = 0;

Instead of this, I wonder whether we shouldn't touch those fields at all,
but:

diff --git a/migration/multifd.c b/migration/multifd.c
index 0a85951d58..55abd9a1ef 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1547,7 +1547,9 @@ static void *multifd_recv_thread(void *opaque)
             flags = p->flags;
             /* recv methods don't know how to handle the SYNC flag */
             p->flags &= ~MULTIFD_FLAG_SYNC;
-            has_data = p->normal_num || p->zero_num;
+
+            if (!(flags & MULTIFD_FLAG_SYNC))
+                has_data = p->normal_num || p->zero_num;
             qemu_mutex_unlock(&p->mutex);
         } else {
             /*

> +    } else {
> +        ret = multifd_ram_unfill_packet(p, errp);
> +    }
>  
>      trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
>                         p->flags, p->next_packet_size);
> -- 
> 2.35.3
> 

-- 
Peter Xu



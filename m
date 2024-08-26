Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F96C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 20:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sig4R-0002KO-Js; Mon, 26 Aug 2024 16:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sig4P-0002GK-1t
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sig4N-0004UR-Ar
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724703126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjdpM2nDRFvwqJN17OEmseDjgeNSu34c2JjoQgzEo8E=;
 b=CrkXG4AqeTCHBWCtgDyF+i5uB7VP0KLLE7ixbL584BJFJOazo1thNrI3B+KNPcvV1HFAkj
 kN/hT5tFpFpzMW1w1Ardh0fF5jakylQINZTxZH81+FxljBDsIvh/DvNFwsPin/lnjdr/yU
 V2jbt1wRFLD7nQIMW3nZGojtIYI7l+Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-58gv0Z5YPyy8ByjsujkyuA-1; Mon, 26 Aug 2024 16:12:04 -0400
X-MC-Unique: 58gv0Z5YPyy8ByjsujkyuA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44ffede4c8aso66529251cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724703123; x=1725307923;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjdpM2nDRFvwqJN17OEmseDjgeNSu34c2JjoQgzEo8E=;
 b=kx7HynDxEzwLLtKkmsqNVB2hAhWdcgJgE3ZvJGycF2QV45OOV2JJ1IWnORDKiEKhb7
 Av7529JblvTCsD2lpNNpDxBpJ5FeWnj623ctgtFaYcJIqTmr/YHITmKmjsZgEi005Enr
 pwJ8ttiSJkHW2cj0PzOv7aeLuVWXD3R+586NV2Ih2ijTba+FMekp8Eeo+TxjvD84/a95
 K8eza6pzJTVnGykUdrUT0YsDsRFn0BGRSfu3RoFjJ5M+WlnpJq+ZZvfjHwCrVp01jdof
 ijJ0Yd7tsbhFW8/Zf+qCjULUQj/e3TC2ZbKA/VMnI/n08sA4Z+hzAYykReHw3jtrzIFv
 feVg==
X-Gm-Message-State: AOJu0YyabXQvtf+NvKNktG2ZR1gPfKj2q60LvYPRoChFnQ6DNU17q7R3
 O46ZWQBHa8tdC6G4r+utrYOeJlzMx2bACIbgPOsdsh5bssliYQ5H6NAhLhyKfbVkO1sRoOTwzWU
 owXxSGoIUQUzuIRt+yDlZPQvALTz08HrjoMIarjFF0SLHT12p8PfFrDpqnJNS
X-Received: by 2002:a05:622a:4c87:b0:44f:8870:185f with SMTP id
 d75a77b69052e-455097b8596mr157063171cf.61.1724703123372; 
 Mon, 26 Aug 2024 13:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKrK+q2TyMqQaDng75FdPbik+e7V8aGGSakfD53KEEYyDgTOYo6cnKBoRIBoGxA9VYLZVJgw==
X-Received: by 2002:a05:622a:4c87:b0:44f:8870:185f with SMTP id
 d75a77b69052e-455097b8596mr157062921cf.61.1724703122996; 
 Mon, 26 Aug 2024 13:12:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c58e6sm45845251cf.96.2024.08.26.13.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 13:12:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 16:12:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 18/18] migration/multifd: Stop changing the packet on
 recv side
Message-ID: <ZszhkJ6Ydqr6JY98@x1n>
References: <20240826195322.16532-1-farosas@suse.de>
 <20240826195322.16532-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826195322.16532-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 26, 2024 at 04:53:22PM -0300, Fabiano Rosas wrote:
> As observed by Philippe, the multifd_ram_unfill_packet() function
> currently leaves the MultiFDPacket structure with mixed
> endianness. This is harmless, but ultimately not very clean. Aside
> from that, the packet is also written to on the recv side to ensure
> the ramblock name is null-terminated.
> 
> Stop touching the received packet and do the necessary work using
> stack variables instead.
> 
> While here tweak the error strings and fix the space before
> semicolons. Also remove the "100 times bigger" comment because it's
> just one possible explanation for a size mismatch and it doesn't even
> match the code.
> 
> CC: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd-nocomp.c | 38 ++++++++++++++++----------------------
>  migration/multifd.c        | 18 ++++++++----------
>  2 files changed, 24 insertions(+), 32 deletions(-)
> 
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index f294d1b0b2..0cbf1b88e1 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -220,33 +220,29 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      MultiFDPacket_t *packet = p->packet;
>      uint32_t page_count = multifd_ram_page_count();
>      uint32_t page_size = multifd_ram_page_size();
> +    uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
> +    const char *ramblock_name;
>      int i;
>  
> -    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> -    /*
> -     * If we received a packet that is 100 times bigger than expected
> -     * just stop migration.  It is a magic number.
> -     */
> -    if (packet->pages_alloc > page_count) {
> -        error_setg(errp, "multifd: received packet "
> -                   "with size %u and expected a size of %u",
> -                   packet->pages_alloc, page_count) ;
> +    if (pages_per_packet > page_count) {
> +        error_setg(errp, "multifd: received packet with %u pages, expected %u",
> +                   pages_per_packet, page_count);
>          return -1;
>      }
>  
>      p->normal_num = be32_to_cpu(packet->normal_pages);
> -    if (p->normal_num > packet->pages_alloc) {
> -        error_setg(errp, "multifd: received packet "
> -                   "with %u normal pages and expected maximum pages are %u",
> -                   p->normal_num, packet->pages_alloc) ;
> +    if (p->normal_num > pages_per_packet) {
> +        error_setg(errp, "multifd: received packet with %u non-zero pages, "
> +                   "which exceeds maximum expected pages %u",
> +                   p->normal_num, pages_per_packet);
>          return -1;
>      }
>  
>      p->zero_num = be32_to_cpu(packet->zero_pages);
> -    if (p->zero_num > packet->pages_alloc - p->normal_num) {
> -        error_setg(errp, "multifd: received packet "
> -                   "with %u zero pages and expected maximum zero pages are %u",
> -                   p->zero_num, packet->pages_alloc - p->normal_num) ;
> +    if (p->zero_num > pages_per_packet - p->normal_num) {
> +        error_setg(errp,
> +                   "multifd: received packet with %u zero pages, expected maximum %u",
> +                   p->zero_num, pages_per_packet - p->normal_num);
>          return -1;
>      }
>  
> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          return 0;
>      }
>  
> -    /* make sure that ramblock is 0 terminated */
> -    packet->ramblock[255] = 0;
> -    p->block = qemu_ram_block_by_name(packet->ramblock);
> +    ramblock_name = g_strndup(packet->ramblock, 255);

This one is leaked?

IMHO the "temp var for endianess" is better justified than this specific
one, where I think always null-terminating the packet->ramblock[] doesn't
sound too bad - it makes sure all future ref to packet->ramblock is safe.

> +    p->block = qemu_ram_block_by_name(ramblock_name);
>      if (!p->block) {
> -        error_setg(errp, "multifd: unknown ram block %s",
> -                   packet->ramblock);
> +        error_setg(errp, "multifd: unknown ram block %s", ramblock_name);
>          return -1;
>      }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b89715fdc2..256ecdea56 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -231,21 +231,19 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>  {
>      MultiFDPacket_t *packet = p->packet;
> +    uint32_t magic = be32_to_cpu(packet->magic);
> +    uint32_t version = be32_to_cpu(packet->version);
>      int ret = 0;
>  
> -    packet->magic = be32_to_cpu(packet->magic);
> -    if (packet->magic != MULTIFD_MAGIC) {
> -        error_setg(errp, "multifd: received packet "
> -                   "magic %x and expected magic %x",
> -                   packet->magic, MULTIFD_MAGIC);
> +    if (magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet magic %x, expected %x",
> +                   magic, MULTIFD_MAGIC);
>          return -1;
>      }
>  
> -    packet->version = be32_to_cpu(packet->version);
> -    if (packet->version != MULTIFD_VERSION) {
> -        error_setg(errp, "multifd: received packet "
> -                   "version %u and expected version %u",
> -                   packet->version, MULTIFD_VERSION);
> +    if (version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet version %u, expected %u",
> +                   version, MULTIFD_VERSION);
>          return -1;
>      }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu



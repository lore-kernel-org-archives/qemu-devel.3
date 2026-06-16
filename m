Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD488CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDF-0002ys-EZ; Tue, 16 Jun 2026 15:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZZAD-00061Y-Ro
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZZA8-0001wh-52
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781636966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t8BwlPR5zRrIQovDx6UCEVTxPsNKOlfGsm97Z3r4J+w=;
 b=LWgovhsoetuHukqBM/ib7z7P+83W63Wz+/UHh+uonk54on8JUsniGlbpqRSLeq8a+ty9mz
 4Oeu9bYCspXWZ8zop5951USgEktSOchp3aKa3/97t0Ompm2J511NY7Q72zRX3SGk/RF2P4
 ARqj1pUO0LbEwPMQ13h949VK0ApyLV8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-XounOh9rMEupFBnmrRryLA-1; Tue, 16 Jun 2026 15:09:24 -0400
X-MC-Unique: XounOh9rMEupFBnmrRryLA-1
X-Mimecast-MFC-AGG-ID: XounOh9rMEupFBnmrRryLA_1781636964
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915767b341eso478240785a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781636964; x=1782241764; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t8BwlPR5zRrIQovDx6UCEVTxPsNKOlfGsm97Z3r4J+w=;
 b=E9TaXNBoY43z9fAUXI1D1Z4Btbrzuxw6H5NK3DWw6gikqHBQoBydBbi6R8l2DP9NOn
 tHp/aZJ1Kgq5URqWB/vVu+X76Lt3KU1a4FCqfI19nj+TafPUHPpxUm/oTp+g4l2KkxEW
 ZeUOakmxX+OyJR/PB0iEhcJ2/MFe8tJMtlVMFdENJ99t75slpYaw113caMfzZD3Wjnxt
 OYj8IBOExw2dzAMhpKFHKPdLe8BOGCgohf+wXSR+1b5rThgfVgv4OiLQAOGORq5VGMPl
 KnIbnqNPu1dQy+mpQzGbOUkM550LWnXOOiIWiLMPU78iPrQH0rvFXMqYjj7Fz9vYpT+X
 ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636964; x=1782241764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8BwlPR5zRrIQovDx6UCEVTxPsNKOlfGsm97Z3r4J+w=;
 b=Uu9uZhooMAxU1ue61rKK9eC0eERc07BfElDcgqrbYvau+JwtYpKaMJEgrHuhdljWqM
 FGGjFsuSREvQXydONN9KGO9UHskN0MfwVgNpVJ1yV6fGX8C7onWRnYHVQQYcEK9Td/9A
 tUFsnp8LMN7hmeapib9SSodIPYe/PoUsT5rKw7cS9sNR/A0lT/jrAplmKI3x1JYHtE8Q
 7FmnKcwB8F0PURiRkDJGtzfwJ45vAzp7zOQsFjr6SxzVL1x/RL6lQgPgMYjRDCleOARL
 VswT2Rkl9nbVO6Z9VYxSu0CBrfEyVSeJ1LGMkcmLBi5dcImIcPWCHTxrMieazxUJafqy
 jptA==
X-Gm-Message-State: AOJu0YyVGdftIY6YgA/EGF8zv2/BAjMx1s054FE4ckXzfJAYG1tB6AQh
 +NI3qkeOtzefDCLP6BnHCvJN0bT+quxbV2MG2zIKifI3XH723vJbshjhHuert/zAcM+LHhj9Kdo
 YGMaBN5AnntH9CqEE7IZ8M6JnMisfhgOnRZ+wUkkUCIThxS3imnVU+kmw
X-Gm-Gg: Acq92OFjvkKiWl1njmXB/UWUiKkbSYt9TrdWRZ50w8i+S1PActBnjzm0huLe4K+Klps
 KHWSH1xsPOG02J7YLct4gjvSkvVoQ3pmcE1gmQ8Jt7CmcyiK5qIM7gQvu2sqWwjHxdgPBhaEe0M
 jNyTuH0hGbBJufG4WZPJ76zMrh/jpzU05L2AlcNB2fx9WyFfw+PmNFOZgKeCx2r7DhsVTjv/Wtk
 2T0n8Y8g5FIznBmS0CYsEzUnlcyvrILNW+Ss/+D11yh8EPADqtxvc9qlL0KVNNjqQ6uwG0vraNH
 zMS0ECqTUj7NXvRskTrmcxC0IKkvzVITYc56SYkjxeu2bPga1FMgdTUdMuZbjW8cl7IFoecIadI
 fymGNsOzDeapxIzA=
X-Received: by 2002:a05:620a:45a3:b0:915:87ad:d5b1 with SMTP id
 af79cd13be357-91d8b0cc3e1mr181270285a.15.1781636964001; 
 Tue, 16 Jun 2026 12:09:24 -0700 (PDT)
X-Received: by 2002:a05:620a:45a3:b0:915:87ad:d5b1 with SMTP id
 af79cd13be357-91d8b0cc3e1mr181263385a.15.1781636963343; 
 Tue, 16 Jun 2026 12:09:23 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619f05fd1sm1556006485a.11.2026.06.16.12.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:09:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:09:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration/rdma: honor blocking mode in
 QIOChannelRDMA readv
Message-ID: <ajGfYYFrhlEaklig@x1.local>
References: <20260529070408.92651-1-guobin@linux.alibaba.com>
 <20260529070408.92651-2-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529070408.92651-2-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 29, 2026 at 03:04:07PM +0800, Bin Guo wrote:
> QIOChannelRDMA's readv ignored the blocking flag set via
> io_set_blocking.  In blocking mode it returned immediately instead
> of waiting for data, unlike other QIOChannel implementations.
> 
> Loop on qemu_rdma_exchange_recv() when the channel is blocking and
> the receive buffer cannot satisfy the request.  Also remove the
> stale XXX comments about unimplemented blocking support.

Zhijian would be the best to comment on this, but based on my limited
understanding, this patch made it the other way round: the channel didn't
respect blocking mode because it always blocks, not always non-block.

> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/rdma.c | 46 +++++++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3e37a1d440..201cb9eb12 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -388,7 +388,7 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdmain;
>      RDMAContext *rdmaout;
> -    bool blocking; /* XXX we don't actually honour this yet */
> +    bool blocking;
>  };
>  
>  /*
> @@ -2710,32 +2710,29 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>              break;
>          }
>  
> -
> -        /* We've got nothing at all, so lets wait for
> -         * more to arrive
> -         */
> -        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE,
> -                                      errp);
> -
> -        if (ret < 0) {
> -            rdma->errored = true;
> -            return -1;
> -        }
> -
>          /*
> -         * SEND was received with new bytes, now try again.
> +         * We've got nothing at all, so lets wait for
> +         * more to arrive.
>           */
> -        len = qemu_rdma_fill(rdma, data, want, 0);
> -        done += len;
> -        want -= len;
> -
> -        /* Still didn't get enough, so lets just return */
> -        if (want) {
> -            if (done == 0) {
> -                return QIO_CHANNEL_ERR_BLOCK;
> -            } else {
> -                break;
> +        do {
> +            ret = qemu_rdma_exchange_recv(rdma, &head,
> +                                          RDMA_CONTROL_QEMU_FILE, errp);

IIUC this is the function that always blocks.  If to support non-blocking,
my understanding is we need to make this return immediately when no data.

Also, this is only the read path; there's also write.

I'm not sure if supporting non-blocking is trivial to RDMA..

Thanks,

> +            if (ret < 0) {
> +                rdma->errored = true;
> +                return -1;
>              }
> +
> +            /*
> +             * SEND was received with new bytes, now try again.
> +             */
> +            len = qemu_rdma_fill(rdma, data, want, 0);
> +            done += len;
> +            want -= len;
> +            data += len;
> +        } while (want && rioc->blocking);
> +
> +        if (want && done == 0) {
> +            return QIO_CHANNEL_ERR_BLOCK;
>          }
>      }
>      return done;
> @@ -2771,7 +2768,6 @@ static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
>                                           Error **errp)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
> -    /* XXX we should make readv/writev actually honour this :-) */
>      rioc->blocking = blocking;
>      return 0;
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
Peter Xu



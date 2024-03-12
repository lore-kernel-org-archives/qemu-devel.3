Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64994C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Eh-0005vO-8e; Tue, 12 Mar 2024 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk1EW-0005ta-Nr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk1EJ-0005SI-JO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710246457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrtGHgZEWuoAfoJ7/zDkQeqzxYwvGgSvqbVPZdW4Eqk=;
 b=chXVcQfY/jl8hVF0+w5YDFJ3vwQ/JYeUajcPWEWt25gnn8yUs3PsFO3PIZBKlT3lvJS+V6
 pJIaMXsdM5vUOGN0rQAAWqXEN6ZciwGRkm4dLe64O/HPZsGItY1z8jb9KvkGmPaPtonmb8
 joEAUWfjipN/FFnlNFukSQOForrffAM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Pd0HxDFDMp-2LK2wrg2bgw-1; Tue, 12 Mar 2024 08:27:36 -0400
X-MC-Unique: Pd0HxDFDMp-2LK2wrg2bgw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-22049b80172so871872fac.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710246456; x=1710851256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrtGHgZEWuoAfoJ7/zDkQeqzxYwvGgSvqbVPZdW4Eqk=;
 b=l3vfCxZ7CzcKh65dB5oRRi0e8J5I7ni8Dm04IlqOY+Fh6xSilSRzLn+cX1lMswtXKq
 bLMlysdqDW3Kcku7y82ih9q9M0YgEKghePancM+uN13g6UGtXELRayEU1s5mRSZfQqZH
 k6ri1K+MIh6hyMs9+3nWqG4AoDzivzlx0d869/L8G9t4YfVNmaVoTpA7k+jKUglvrwyf
 ylovnGgSxcMl+ex09fQ7oxO2WJk1g0l8nA/3HyD3LxT80Xf0COURgbbKy8d3NJsBaEs1
 j6Pz/H9DiXbBbWNwvoHesW0TQh6B9bi6E7vT+4FFGjtCS45XmsOVouIuOm4inXkK+mZo
 l/Wg==
X-Gm-Message-State: AOJu0Yzzh5gW2uCe4cQr/diWluOfAQXoZuEWL5eHn5lFRouu33ggsL8M
 vl4bTIuq1Nd5W4PmyG8Ej8oV4DpeFW5XmbmwEGcHrfU99m+NUiGpoVF0jCXlZNj8lWGzDPeopnr
 1u9O0ut8CX3V5JOsCiHJesmLnNHCx3mihZmPgOeBQmCohoYVJzS3I
X-Received: by 2002:a05:6870:d182:b0:221:cb1b:cc05 with SMTP id
 a2-20020a056870d18200b00221cb1bcc05mr8763818oac.0.1710246455764; 
 Tue, 12 Mar 2024 05:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGydle2Jh6+4rlo6ie3EMEslG/T5eZJtNgMjohsqWK03rpijpA/u+jOb2i8/0HJEWQG5ZATQ==
X-Received: by 2002:a05:6870:d182:b0:221:cb1b:cc05 with SMTP id
 a2-20020a056870d18200b00221cb1bcc05mr8763793oac.0.1710246455464; 
 Tue, 12 Mar 2024 05:27:35 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05620a125300b0078837b90db7sm3652857qkl.32.2024.03.12.05.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:27:35 -0700 (PDT)
Date: Tue, 12 Mar 2024 08:27:34 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Message-ID: <ZfBKNhRkAt2_7hmc@x1n>
References: <20240312120431.550054-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312120431.550054-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 01:04:31PM +0100, Cédric Le Goater wrote:
> The block .save_setup() handler calls a helper routine
> init_blk_migration() which builds a list of block devices to take into
> account for migration. When one device is found to be empty (sectors
> == 0), the loop exits and all the remaining devices are ignored. This
> is a regression introduced when bdrv_iterate() was removed.
> 
> Change that by skipping only empty devices.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Suggested: Kevin Wolf <kwolf@redhat.com>

This should be:

Suggested-by: Kevin Wolf <kwolf@redhat.com>

I think the missed "by" caused Kevin not in the cc list, I added Kevin in.

I'll hold a bit for Kevin to ACK, no repost needed just for above; I can
fix it.

Thanks,

> Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  migration/block.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..2b9054889ad2ba739828594c50cf047703757e96 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -402,7 +402,10 @@ static int init_blk_migration(QEMUFile *f)
>          }
>  
>          sectors = bdrv_nb_sectors(bs);
> -        if (sectors <= 0) {
> +        if (sectors == 0) {
> +            continue;
> +        }
> +        if (sectors < 0) {
>              ret = sectors;
>              bdrv_next_cleanup(&it);
>              goto out;
> -- 
> 2.44.0
> 
> 

-- 
Peter Xu



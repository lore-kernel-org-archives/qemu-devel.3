Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828A9D4921D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 14:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2py-0005SM-4p; Mon, 18 Nov 2024 09:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tD2pu-0005RT-Db
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tD2ps-0005BE-6R
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731940477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJcSaygYCaOVbPI8laGJRMJxxbQVGyyW+tjRprJHMTg=;
 b=EhdN2yEV51mDeFR4bnnF1lSLHiHjr0N+7KPrcGF+Vv7r6c2AUQ3IwebEjIG2pgGk68JXfr
 SgYCsy5t55F0ChNfbLbnzUGzhOcCxyEllHCgN4IGdrdTPwaQFIbolvMugz6HRUQ8V9qTyP
 45t42rDrfhgDMal4esOHe1mQ0MvYlsA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-cQmaYpT_OXOFmGLvWcFfQQ-1; Mon, 18 Nov 2024 09:34:32 -0500
X-MC-Unique: cQmaYpT_OXOFmGLvWcFfQQ-1
X-Mimecast-MFC-AGG-ID: cQmaYpT_OXOFmGLvWcFfQQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38243a4ba7cso719840f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 06:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940471; x=1732545271;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJcSaygYCaOVbPI8laGJRMJxxbQVGyyW+tjRprJHMTg=;
 b=RZKNdSdaorGIilGPhBVtKTa34jTIUDY3uLfxeqcJoKzFPwxuQMSldsRTIJq1AHSREb
 MxOpDyFaJvhaY5GIGbvj8iak2JjpP6stNOVj24ieOCJwwjw+W24iAYFMehBQGOZv0HnP
 T+rbNqrcglfXSghHTbzBhzgrNT3TNKKxTdXYQOfScYksTGzln/SB5O4KlL3MgfNSj08J
 qGp6/rk9FC1MTsO6OB+frMWLjamDz4OSJeEAgkWs+3mci7qjkuohUVEqKEjzTcqBXOlJ
 Bo5MIGmZq7L3jF5C5/u1a9hPetc7PRH8fBVdxYoW/ivvF4FszWC14qQgx/xdJ0WikEYG
 OxTg==
X-Gm-Message-State: AOJu0YwMl/RfBiBay23vFVhwan9sB/U/IXpjUwFdF4bNT0/nS5VmbEAK
 Qh9nZZtrPNQAQY1qhI+ySwpGvFMpEkyRnyXruPNUJKxdw8X+Fz0zpM/tJVLCuOTqQuIqqShz3hu
 PAPwZH9otHXYvxD20t7a3H1eYBqVP4SsKh64zwM+nqHK6oOdCy2So
X-Received: by 2002:a05:6000:184d:b0:382:4493:ff8f with SMTP id
 ffacd0b85a97d-38244940411mr4105599f8f.43.1731940471683; 
 Mon, 18 Nov 2024 06:34:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3HrzXrQwhODNNwWdRkdJOeqm1wcNgLA1QU7bpvybYBtVkjL7uBkUVDWQW2Y4jGlIt5h4G9g==
X-Received: by 2002:a05:6000:184d:b0:382:4493:ff8f with SMTP id
 ffacd0b85a97d-38244940411mr4105578f8f.43.1731940471243; 
 Mon, 18 Nov 2024 06:34:31 -0800 (PST)
Received: from fedora (nat-pool-rom-u.redhat.com. [149.6.22.211])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38233b5c3b3sm7772000f8f.19.2024.11.18.06.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:34:30 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] vpc: Read images exported from Azure correctly
In-Reply-To: <20241114141045.374575-1-vkuznets@redhat.com>
References: <20241114141045.374575-1-vkuznets@redhat.com>
Date: Mon, 18 Nov 2024 15:34:29 +0100
Message-ID: <87a5dwr4p6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> It was found that 'qemu-nbd' is not able to work with some disk images
> exported from Azure. Looking at the 512b footer (which contains VPC
> metadata):
>
> 00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
> 00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
> 00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
> 00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
> 00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
> 00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
> 00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>
> we can see that Azure uses a different 'Creator application' --
> 'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
> field to determine how it can get image size. Apparently, Azure uses 'new'
> method, just like Hyper-V.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Alternatively, we can probably make 'current_size' the default and only use
> CHS for 'vpc '/'qemu'.
> ---
>  block/vpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/vpc.c b/block/vpc.c
> index d95a204612b7..da8662402d00 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -321,6 +321,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       *      'qemu'  :  CHS              QEMU (uses disk geometry)
>       *      'qem2'  :  current_size     QEMU (uses current_size)
>       *      'win '  :  current_size     Hyper-V
> +     *      'wa\0\0':  current_size     Azure
>       *      'd2v '  :  current_size     Disk2vhd
>       *      'tap\0' :  current_size     XenServer
>       *      'CTXS'  :  current_size     XenConverter
> @@ -330,6 +331,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       *  that have CHS geometry of the maximum size.
>       */
>      use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
> +               !!strncmp(footer->creator_app, "wa", 4) &&

Stupid me forgot how strncmp() works wrt '\0' bytes, I think we're
better off doing plain memcmp() instead. I'll send v2.

>                 !!strncmp(footer->creator_app, "qem2", 4) &&
>                 !!strncmp(footer->creator_app, "d2v ", 4) &&
>                 !!strncmp(footer->creator_app, "CTXS", 4) &&

-- 
Vitaly



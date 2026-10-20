Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGWp7yu9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XvBsNv8s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJAMq-0002gh-Ms; Tue, 20 Oct 2026 09:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJAMo-0002fc-Fj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJAMm-0006IF-8n
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792504738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gVdvAAPzpUEpLB0DBPtluBhzh1p3s9Od7CtFRQOefYk=;
 b=hGWp7yu9sdUGn8dPdBZ78G+X9lC4f+as4sVxGkyhoPUruGEv6z5cvr/N5bHgNN7wj3H65M
 5d1BXbD4z1RqPg8YN5Tx6xJWMPGt1qCiD66ERwIeIBGQ553jSNDk2DW1smJivytxUAn9YA
 2a1aDlfogkd4EOmx0/V6KC6Tt5LDDRU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-D79yfZoyMiaR-OroaNOXbA-1; Tue, 20 Oct 2026 13:58:51 +0000
X-MC-Unique: D79yfZoyMiaR-OroaNOXbA-1
X-Mimecast-MFC-AGG-ID: D79yfZoyMiaR-OroaNOXbA_1792504730
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48dff112136so2411663f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792504730; x=1793109530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gVdvAAPzpUEpLB0DBPtluBhzh1p3s9Od7CtFRQOefYk=;
 b=XvBsNv8slFbUT9iDhqI8dcL6xOjd2Cl2/c/w1UtaAOZU9dhL7Pro3UK0fj0eJ8dlaA
 SPttaN6Y18fBC2ImbPzj/uHP9CsVoL1x6xWY1JB9sA0FJ5GGH8OZoh3eHg7CAWeLpVVk
 2QO6fB6NqwRZ4NT9Kb7c11nV9k6wwd0KoGEv6ot7Jpv5aucasaqmPcMY8WmIQ5R1Rfxh
 vkJkm0KdSwLlA58ApK7SnVhInNSX5EpvJltl5eJSQyowgdv4LTQaR2tBHUwIH395pM79
 OhfuwPaOdhX1TU8dJKd1OWkcbxkeIGo/WGXGNxcfKQj93rRfjRf4gfTt70SUTCnR3EcG
 eumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504730; x=1793109530;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gVdvAAPzpUEpLB0DBPtluBhzh1p3s9Od7CtFRQOefYk=;
 b=YF38y1aCb+bFkJ7a7neBn6bn8G5XRXT/flh4tDGxoGtxMqrUGtvZB1Qmch1owECKbb
 G/vbDN5uJ2Xq+o4eUH+EfIW43AFBQhArkLNOIiGLkI4bwkMjZ/vt8nMs3EJOFkSVVYeQ
 M+oQuF3tkk3b261oKiLLqN2F+zn8DtCRaxsxbUhHBcLB9/snuNaFExY9F0CFJmBxxvZO
 fpTNhRioQOdiiHMGOQXEKa66r2LPnbKPQDdIZRFnHA23xRay+aXFbAxqHOeHAU3otMoI
 f3bxYlGClqc51ExRqKistDKMdFaoOVNDETawh6WcP2Yv/UVpIWZMWhR/k02QHSadt53q
 5uEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnYc4tPIBCsI9uH3dtGKQfPJD5zA+Lf0/4wsQrxp9MKkmYJMxM5pLC+IzxFlQNETACEqYuD3i5iLjB@nongnu.org
X-Gm-Message-State: AFq9FYICEfQomV5mDSaiiPhU4LwHkR4Ldw+6K19NmK/i08OuIRLqlAVn
 ZDEUO8rY7Ak9DIKK0ibCQCDeoGDW7FOHbBvmq0xdmR4ISPxTQ+CVUqExePfKQ5+87OnAwKbkQgF
 Iw2iLmRKUXHxFbFPeg+v/jZ7o4I8AqwdAQXTzx5Uih2Y83mOSNckCNi4D
X-Gm-Gg: AYBFou2LThaoR/TwrqanouZzFdocmAe2Ws6/TauRh8BW8ZPOv0FBKEo01as1/Ko/2vm
 Q0AU2AYWb8qjHZ7XwyYj41MJ+Q/rXAp0HFt6SsOQywct+jfV2HpknrFzeAN36IzCmkvpHiTq2kj
 mFOvt4UaK1XIaJQFBADPkoCtIMNPKzDo57Dij950AxK6k9TaYw7sawBszOEHt9R4XZIBracygVQ
 abJGnALT4rZMOZEGL55OuC2iVqSr3Jv2lnSMzgigreVY4K0J4VyYsNS0EoOdoW2FzhQy5edyVHm
 B0z0vgOI4mv5re+wMMXnFGpvDFLWyn5g83Xl+R6c1CA/JIdJjRuPdShmQuVZ5G3nAyUFzgiZ
X-Received: by 2002:a05:600c:4e11:b0:4a1:811c:8069 with SMTP id
 5b1f17b1804b1-4a1d75e37fbmr222553535e9.8.1792504730001; 
 Tue, 20 Oct 2026 06:58:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e11:b0:4a1:811c:8069 with SMTP id
 5b1f17b1804b1-4a1d75e37fbmr222553155e9.8.1792504729559; 
 Tue, 20 Oct 2026 06:58:49 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.103])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca26dc8sm255770615e9.3.2026.10.20.06.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 06:58:48 -0700 (PDT)
Message-ID: <8bcef912-1471-4443-a3ab-a30099adebdc@redhat.com>
Date: Tue, 20 Oct 2026 15:58:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Print simple help text when calling "-blockdev
 help"
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20260914090036.125300-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260914090036.125300-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 14/09/2026 11.00, Thomas Huth wrote:
> Other command line options like "-chardev", "-netdev" or "-device"
> already present the user with a list of available parameters, but
> when running "-blockdev help", there is currently only an error
> message. There is already the possibility to run "-drive format=help",
> but it does not seem to be documented, so this is not very useful
> for the average user. Thus let's improve this situation by providing
> a proper list of available drivers when running QEMU with
> "-blockdev help".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Don't re-use the code from "-drive format=help" and print the
>       help in a better readable way instead

Ping?

>   include/block/block-common.h |  1 +
>   block.c                      | 15 +++++++++++++++
>   system/vl.c                  |  7 +++++--
>   3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index 895ea175413..c76a72c1220 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -583,5 +583,6 @@ char *path_combine(const char *base_path, const char *filename);
>   char *bdrv_get_full_backing_filename_from_filename(const char *backed,
>                                                      const char *backing,
>                                                      Error **errp);
> +void bdrv_show_help(void);
>   
>   #endif /* BLOCK_COMMON_H */
> diff --git a/block.c b/block.c
> index f0a6042e616..895d6db5acf 100644
> --- a/block.c
> +++ b/block.c
> @@ -524,6 +524,21 @@ bool bdrv_uses_whitelist(void)
>       return use_bdrv_whitelist;
>   }
>   
> +static void bdrv_help_format_print(void *opaque, const char *name)
> +{
> +    if (bdrv_format_is_whitelisted(name, false)) {
> +        printf("%s\n", name);
> +    } else {
> +        printf("%s (read-only)\n", name);
> +    }
> +}
> +
> +void bdrv_show_help(void)
> +{
> +      printf("Available blockdev drivers:\n");
> +      bdrv_iterate_format(bdrv_help_format_print, NULL, true);
> +}
> +
>   typedef struct CreateCo {
>       BlockDriver *drv;
>       char *filename;
> diff --git a/system/vl.c b/system/vl.c
> index 9bd7664b85c..dc93e8737cb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2960,7 +2960,10 @@ void qemu_init(int argc, char **argv)
>                             HD_OPTS);
>                   break;
>               case QEMU_OPTION_blockdev:
> -                {
> +                if (is_help_option(optarg)) {
> +                    bdrv_show_help();
> +                    exit(EXIT_SUCCESS);
> +                } else {
>                       Visitor *v;
>                       BlockdevOptionsQueueEntry *bdo;
>   
> @@ -2973,8 +2976,8 @@ void qemu_init(int argc, char **argv)
>                       visit_free(v);
>                       loc_save(&bdo->loc);
>                       QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
> -                    break;
>                   }
> +                break;
>               case QEMU_OPTION_drive:
>                   if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
>                                                optarg, false)) {



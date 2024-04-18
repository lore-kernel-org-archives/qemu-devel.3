Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29FFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTt0-0004QA-3a; Thu, 18 Apr 2024 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rxTsy-0004Ku-G9
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rxTsw-0000pX-Iw
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713454866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uJcuA8FSOvZeR+LohFdLOJ7K3BM1wnMOQsbcnznqN4=;
 b=IQ5nokjBTHgNQAno3GLUWT49TaUahWfLy19uGKs+Glr9xEcJrzaoY4RYGbqdXX1mJ0WTKv
 MJWBLffx4/P+zapXz/UfdJoWc6OFs/aDQUnaxilKjuXCCf+7d/fJKlKj4RTBomnz9E6Xjv
 C9h/qnQDJ9EXBCWgpHxwJ5twMj5Odd0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-GS3HCiy4PDqRaGcv3ZLRCQ-1; Thu, 18 Apr 2024 11:41:03 -0400
X-MC-Unique: GS3HCiy4PDqRaGcv3ZLRCQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-418f3082647so2843325e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713454862; x=1714059662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uJcuA8FSOvZeR+LohFdLOJ7K3BM1wnMOQsbcnznqN4=;
 b=n8QzXAeR1VwODZbHfUej0bStwex/OPgcSinDL8VeK8/3cC9jf0UMrdfYH/D8j7rt8N
 Ys6rKMn8x8pT/BILRio+I8UEg1TKYRzSedPtOLnDsNfvy0Iy7G2aIA0oYNi3PlMGalOa
 01eLP8J1V2WggJsFlEYnQfm17lRXRbZIfWf8yfnS5T4aNOQqgA8UGzBxOvdbfXwpeeBL
 Zrx76CgQr0uo+fFI8c3ld6YFVVMpDVzDRVVEtBbYB/Q/sFzawmw7N5bSj5p2+MNevbsG
 0XI1Pef26JeyBT9+ncqK3+lAYccIyGsGj+xlzYxHUlgok/o38mjXiQD3Wt1lTPxYwgkZ
 Z5Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUiQEkSZK6GhIoje0y3OnEUzV+ulOFei+/O2NT4LD6UYRMJLD7jx5+59xSb4yBPMV54z1CTCTK89Wbxan7O1e+eylhgnU=
X-Gm-Message-State: AOJu0YyCTK0e/WUgGF0Di1XSfhOhNIGqWa7yS0Nb8E80CNbdf2Sw56dg
 AbWuZNwLX3zAXAg2RrBcf+TnrGBIrmQ0V/NjzxBPMTxLj6RNxkuLWQeIQCnY/YhrYgPUIgip2L6
 YZO1SpeD5a4H9Tr02m66aI9knZrqjhPpLs1GD4HkN6f3prBX25GTg
X-Received: by 2002:a05:600c:524a:b0:416:8091:a39e with SMTP id
 fc10-20020a05600c524a00b004168091a39emr2550333wmb.10.1713454861817; 
 Thu, 18 Apr 2024 08:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGztL+5SjQ/4Lgp6StwjAaL4ZYzuTJlipRBc12V2M8yM4kfS0dveD7ObjeyOPiYX8RqhltqCA==
X-Received: by 2002:a05:600c:524a:b0:416:8091:a39e with SMTP id
 fc10-20020a05600c524a00b004168091a39emr2550313wmb.10.1713454861235; 
 Thu, 18 Apr 2024 08:41:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
 by smtp.gmail.com with ESMTPSA id
 e2-20020adfc842000000b00346cc85c821sm2099551wrh.89.2024.04.18.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:41:00 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:40:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: pbonzini@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user-test: no set non-blocking for cal fd less
 than 0.
Message-ID: <20240418114037-mutt-send-email-mst@kernel.org>
References: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On Thu, Apr 11, 2024 at 03:35:55PM +0800, Yuxue Liu yuxue.liu@jaguarmicro.com wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> In the scenario where vhost-user sets eventfd to -1,
> qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
> receives, it does not perform blocking operations on the descriptor
> with fd=-1, so non-blocking operations should not be performed here
> either.This is a normal use case. Calling g_unix_set_fd_nonblocking
> at this point will cause the test to interrupt.
> 
> When vhost_user_write sets the call fd to -1, it sets the number of
> fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
> be 0.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

A bit more detail here please.
When does all this happen?

> ---
>  tests/qtest/vhost-user-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index d4e437265f..7c8ef6268d 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>      case VHOST_USER_SET_VRING_KICK:
>      case VHOST_USER_SET_VRING_CALL:
>          /* consume the fd */
> -        qemu_chr_fe_get_msgfds(chr, &fd, 1);
> +        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
> +            qos_printf("call fd :%d, no set non-blocking\n", fd);
> +            break;
> +        }
>          /*
>           * This is a non-blocking eventfd.
>           * The receive function forces it to be blocking,
> -- 
> 2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0411CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5RU-0004pU-Dr; Thu, 23 May 2024 06:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA5RT-0004pI-ND
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA5RR-0006ZM-0Z
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716459175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6Vtk7M67xBsRkrpticdZfwU/5+DdQm7FbK7k49ZH1l8=;
 b=ZAgcFEmrUi2RxsstlzvwWDBNEjpv2pY4IMQECKTt6gp+G1xKLp/FMauFCk2N6OAEyXE3qa
 G1kFE4ECqM/lhxHEQblksEEmbPl2rc1i8dqDx0LHkVt2BefDmK5T2Y8RgGTLFjISo+lZtR
 od7cqYZ/7tuQSlbapf2rPgDaGZOB+1M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-a-6ZUBkAMea9hjmZQFBiZg-1; Thu, 23 May 2024 06:12:54 -0400
X-MC-Unique: a-6ZUBkAMea9hjmZQFBiZg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-574bf7a2edcso1033254a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716459172; x=1717063972;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vtk7M67xBsRkrpticdZfwU/5+DdQm7FbK7k49ZH1l8=;
 b=erryazO290HWlYjWSaRVVxv1eqaG+9VDh6d9BZ3u/geVJ0UAPShNgMlwrxWGwjw5Ah
 dsHphdgpea7whb83lc2hgKWdMU4xNxhcOVHMdm/I6p2dcFpLfHKhijV9DAsmczubph8H
 IE6jxW+/LbbkMO8wqeQbwWIlyX3u4Euqv5jbuKm/Z77IXWooC0dhS/sDGMkRRnofR3Cw
 ID3JNDLXLqXoVFyjFxLbLGouul62Imlx2cw5cb4lfrDz4sXmDbh49DAR0T0eHvq+ZiI4
 p7fdhIo3m0uD79gn3yC8Cvztpl6xKozEAAmFwopk2+9U6N0efRGXQZQhmJwuNprqAwnN
 REMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoWn0L84vgNkpceEutdgtuzumDgABDyCP2295ZrHHr1BQwZboHx2dLWlxmzdgO/rICLeuvhMUozdIkDthW6ZR1dsM2znc=
X-Gm-Message-State: AOJu0YzAbXisrJq4Hts0yV6aBBeAtjeHox7gkm0xujd65MUmXHZvk2nj
 C7347wNw1JWKc+J2ZuZZGVNPozodDdqZiqQ4zDtG0ZSKRsxFKIA6C5o8mY3ouGZn3eTFDjudlgv
 1d/hDpA7R2IKoZjxa2VOrGLjhjd55OeNAyfIvifwac2Pr/U/le2rqZcHwewBr
X-Received: by 2002:a17:906:231a:b0:a58:ea85:9114 with SMTP id
 a640c23a62f3a-a622e7315f0mr288935166b.50.1716459172194; 
 Thu, 23 May 2024 03:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWYPTam4T4AsH9TSLJnOCU2hr8pR4JDzTtFxeEMS6tR3WxeNW2BwVecGrTkEatN+XqZMq04Q==
X-Received: by 2002:a17:906:231a:b0:a58:ea85:9114 with SMTP id
 a640c23a62f3a-a622e7315f0mr288934066b.50.1716459171819; 
 Thu, 23 May 2024 03:12:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.155.52])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a61ae98df98sm551922166b.37.2024.05.23.03.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 03:12:51 -0700 (PDT)
Message-ID: <fc9c7a1e-2d25-4580-90c7-98578e8fbd9a@redhat.com>
Date: Thu, 23 May 2024 12:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: add -mcx16 flag
To: Artyom Kunakovsky <artyomkunakovsky@gmail.com>, qemu-devel@nongnu.org
References: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/22/24 21:30, Artyom Kunakovsky wrote:
> fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command
> 
> Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index a9de71d450..0c24878c86 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -298,7 +298,7 @@ endforeach
>   
>   qemu_common_flags = [
>     '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
> -  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
> +  '-fno-strict-aliasing', '-fno-common', '-fwrapv', '-mcx16' ]

-mcx16 does not exist on non-x86 hosts so this change breaks them.

QEMU's configure script knows to add -mcx16 on x86 hosts; you've added 
--cpu=unknown yourself, you have to add --extra-cflags=-mcx16 as well.

Paolo

>   qemu_cflags = []
>   qemu_ldflags = []
>   



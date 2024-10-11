Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239B1D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ9v-0000V9-Jc; Fri, 11 Oct 2024 13:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1szJ5N-0001hX-MA
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1szGRz-0004ls-Qb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 10:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728656221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lTH07NGr34ffLGTjn9ueB4VMchnCn7CqdVEcRKWdefE=;
 b=Zj1VyOImakSMbYD1q1zKfp79KJuBzOsa2wHb96DVzKBOU9HuMe8RlSxHW0UKv7BRICY3WE
 wKcjJ7uZYx4VUhbQn7DXRKe4BrhOQqvyj3/6PM2q1Z6UzAAX1JEj5S+MxFyljbSRM2pC0X
 0uy1tNzSyltbGcwjs43chpsenrMxcps=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-EPZI0UbdMpaNCGxV7sJt2Q-1; Fri, 11 Oct 2024 10:15:29 -0400
X-MC-Unique: EPZI0UbdMpaNCGxV7sJt2Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so930790f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 07:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728656129; x=1729260929;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTH07NGr34ffLGTjn9ueB4VMchnCn7CqdVEcRKWdefE=;
 b=wht/lfkVv+wH6wTbWEoZsVxySI7SpY8U7V6kB/j1tVyTbSEmBgf4lLAj0gn8fUJlnZ
 oQDCz+6a1qv+RsUeSElHHVhrqIS19s6jdHMiL44w8FXLK+EeV23w6GQ6u66eITw5c/NW
 hLtfwOHawjdarRwAqTbKcl0U5geMF3C8JDaI/cM3PQg5kGrVGTNBtEvvH/HuztXe/xEL
 e2c0jQXrhM2x5uS+oZJTX1+++mxj+612s7HMpNVUtUJ9HBInutQ8of7iGDeMbgENmlsg
 GaqSk5sIfwayTbkowmb98mz9DCGGnv41nA24Ysi8gPsmq3M5E1pS+A03KwhV3Xbewdjh
 gvDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOjNGhjWgt0nYWseqP+jFyVVxDrr7N6uOI0CVl3kGL3EGqJfR/esHABI3/2QukD4XsHCe1AmyVPKfI@nongnu.org
X-Gm-Message-State: AOJu0YzWEoZAqmEPbQzkMj4xCWkcGLUCtABlz1HYhCLViM+IsNfBoi6B
 xEmjW5xME3KxeRpUfW0im36CYn3qjPFDn5O9BEkHQA5ybruM6X7fb/hzI0gn1EjBgdu/lkM/YnT
 IIPwI/iMMc6m4lX7s0ezXp91tJb19AYfs+eW6P39oQQKuHOBcbeU9
X-Received: by 2002:adf:fd0f:0:b0:37d:4cef:538b with SMTP id
 ffacd0b85a97d-37d552073c0mr1817842f8f.26.1728656128779; 
 Fri, 11 Oct 2024 07:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlOLgJf80oVe5XtTsh/+Vx331SvtiLpk68id7BABvej0ET6hEAG9erXNlBICg8H09jxBHQZw==
X-Received: by 2002:adf:fd0f:0:b0:37d:4cef:538b with SMTP id
 ffacd0b85a97d-37d552073c0mr1817822f8f.26.1728656128391; 
 Fri, 11 Oct 2024 07:15:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78?
 ([2a01:e0a:e10:ef90:4c84:58cb:a1ef:8b78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd24asm4016313f8f.38.2024.10.11.07.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 07:15:27 -0700 (PDT)
Message-ID: <66177a00-c0a1-468a-aeb7-08d0bbd121de@redhat.com>
Date: Fri, 11 Oct 2024 16:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: A new maintainer for the qtests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
References: <20241011141344.379781-1-thuth@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20241011141344.379781-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/10/2024 16:13, Thomas Huth wrote:
> Since I blundered into becoming the maintainer of the new functional
> test  framework in QEMU (tests/functional/) recently, I need to drop
> some other duties - it's getting too much for me otherwise. Laurent
> is also quite busy with other projects nowadays, so I looked around
> for help.
> Fabiano did quite a lot of work in the qtests in the past already,
> and is also already a maintainer for migration, so I thought he
> would be a very good fit, thus I asked him whether he would be
> interested to help out with the qtests and he agreed.
> Thank you very much, Fabiano!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7a11fe601..d8e4d2d587 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3250,7 +3250,7 @@ F: tests/qtest/qmp-cmd-test.c
>   T: git https://repo.or.cz/qemu/armbru.git qapi-next
>   
>   qtest
> -M: Thomas Huth <thuth@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>
>   M: Laurent Vivier <lvivier@redhat.com>
>   R: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
> @@ -3268,7 +3268,7 @@ M: Alexander Bulekov <alxndr@bu.edu>
>   R: Paolo Bonzini <pbonzini@redhat.com>
>   R: Bandan Das <bsd@redhat.com>
>   R: Stefan Hajnoczi <stefanha@redhat.com>
> -R: Thomas Huth <thuth@redhat.com>
> +R: Fabiano Rosas <farosas@suse.de>
>   R: Darren Kenny <darren.kenny@oracle.com>
>   R: Qiuhao Li <Qiuhao.Li@outlook.com>
>   S: Maintained

Acked-by: Laurent Vivier <lvivier@redhat.com>



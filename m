Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B51CC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 15:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sec9L-0003nQ-SK; Thu, 15 Aug 2024 11:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sec9J-0003fP-Pd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sec9I-0003TZ-47
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 11:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723734743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UtZBoeDy6pn6Igte8yKhdKlXK1vxz0XXiYejF3ntn0A=;
 b=Cw2n2ypUOmtXIWKnHf45jpxlrGMYwyFZUF9EZSVVYlnU3KZk198pDzrSNlMuvwkrv2YS1z
 jMQLj4Ya6hFZlRL7PXTOpli1oacVAmDNq360dgFuT4hwD7ZzizZugm+ZoorFc9lhSGEOlE
 5zU6GP7kRRj6TWNKW/7HZ6S6Hg+Ny88=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-8eNR19alOJqHSu_hCm0Y-g-1; Thu, 15 Aug 2024 11:12:19 -0400
X-MC-Unique: 8eNR19alOJqHSu_hCm0Y-g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6bf67181889so10859076d6.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 08:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723734739; x=1724339539;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtZBoeDy6pn6Igte8yKhdKlXK1vxz0XXiYejF3ntn0A=;
 b=EszMoN88CAry2Zvc1/Mec/swFod06VTgSu0diAys/JMqWm8Zy5cbfsueZ9sBPS0QF8
 FQPIcg7ZMMgZNmoeyj8zGjT0cESVp7uSJeZdFn0nHOlx5pQ7yC7aOPgPWZ3BGe8bDm+k
 zbp+o3xqskntD67u7N361xK58UciY0/scckrjriaBAgubSSION3KxyfspzX05yXTZDRm
 NBeOxseAMCT9yapMgAAMTLXnDqUoczAvJowH811vGSE8OmHTVSRa6fj5G6EDqZl38rrl
 jm9zXFrViZtw2abqCWrVc0vuOxmsSoQM/c7jpp+rnDCpQoRGJ4F5KAjvc70RWjm+aZEs
 rVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU64rMs1sJUxE4Dy5gJr5bStSK5fB96TGhr0i/q/YV5KDmYuqDRjf+f+zXxfGoeA60zpflEEaLnM8ro7Fm5vRHixBFd9Fc=
X-Gm-Message-State: AOJu0Yza7lv/+kVqEy1JtrTOJSp+ic6hoxcFF1nSiFH+YNrGQacSAeDc
 ZyuWhn8ZyNNVcgbd6pwWIrIX6e6wJd8l08jukP+NVhHgHP+G6DuyF+2C9xkr7lsdYXw8dytxNiu
 2/XelBHacLCm64TY6tW3IwvQ8T73/58/cZ/ILi3lBda0qj9PEcjyC
X-Received: by 2002:a05:6214:3284:b0:6bf:7840:1b96 with SMTP id
 6a1803df08f44-6bf78401f0amr18781776d6.17.1723734738785; 
 Thu, 15 Aug 2024 08:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6AZiXQIqEI1YInKHrqqGRPK95LBs8jJNwx0SrDJRFmlkY8GD8XEath6t3JaGwjbK11pXBIQ==
X-Received: by 2002:a05:6214:3284:b0:6bf:7840:1b96 with SMTP id
 6a1803df08f44-6bf78401f0amr18781466d6.17.1723734738374; 
 Thu, 15 Aug 2024 08:12:18 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fe1bb00sm7142016d6.55.2024.08.15.08.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 08:12:17 -0700 (PDT)
Message-ID: <ffa64555-446d-4128-ae29-4d0b38e6d29d@redhat.com>
Date: Thu, 15 Aug 2024 17:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: add 'qemuutil' dependency for block.c
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org
References: <20240814100052.263060-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240814100052.263060-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/08/2024 12.00, Fiona Ebner wrote:
> The macro block_module_load() used by block.c is a wrapper around
> module_load(), which is implemented in util/module.c.
> 
> Fixes linking for a future binary or downstream binary that does not
> depend on 'qemuutil' directly, but does depend on 'block'.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 81ecd4bae7..efa0ac8d0b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3555,7 +3555,7 @@ if have_block
>       'blockjob.c',
>       'job.c',
>       'qemu-io-cmds.c',
> -  ))
> +  ), qemuutil)
>     if config_host_data.get('CONFIG_REPLICATION')
>       block_ss.add(files('replication.c'))
>     endif

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and CC:-ing the block maintainers, hoping that they can have a look, 
too, and finally pick up this patch.



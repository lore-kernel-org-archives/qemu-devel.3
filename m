Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2F4D2A53D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19FM-0006hQ-3W; Wed, 16 Oct 2024 14:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t19FK-0006h3-2S
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t19FI-0008H0-1y
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729105181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wiLN2wWBADL2en2HStJD/rJxGPYpp3GSwhjfqDofZpU=;
 b=EDHjhdQNdoZRX4xmj6JAR2WHYvHWrfxK3GqqHaSti08nggwYYVpQabKjQZoOwUOvY457Hj
 GtL3QClTwD6/hyQjTzxV+6APJGl0kCM4aV/f3aAFdSdruBuNyQe2pv7V3DvzRgraTvkS1I
 wqf/0thvon3M5Nbg0LUATFSM4e4t3FE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-EpYB_Y7-OQ2B2eM5izkLgQ-1; Wed, 16 Oct 2024 14:59:40 -0400
X-MC-Unique: EpYB_Y7-OQ2B2eM5izkLgQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b10e7958c6so28937185a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 11:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729105180; x=1729709980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiLN2wWBADL2en2HStJD/rJxGPYpp3GSwhjfqDofZpU=;
 b=BL+0/5t1ouoCS6BGP514j9zzUCHfs76vR+0XCjS5hWkDQQTmBQYC8pvY0m0bUqJ0vk
 wC5IHoahHeKJc7mcDMM0DXw97gM0IDijzKP3X11CWyXaPeWYEw8t6T3JLA6n7iPIFSmZ
 557060T2qqrlzEQ2gkBHX5L2nd5bDSBICNDwmhWrfCdzQV3OJ5vGlDr6RexFqcXZrrX0
 dZDwsSOaFdzagPdt7GJ2qMngbo/NNqdEP9eXhoi3JTiLxb2IYBHl9ndjPJDy/owq5KwB
 1B9GSQh7EI1LFBsYF/urmPMVcbuihzsRJ6ZIPNn4HT0dIuL9MxZ9B9ieuXhcDppEwZlU
 nIKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz13LFglBqIaprrWc4zMaRKYasLq/WCCBJn1MO5y2PrR9+IJIymDcaRidwwmDMxSueWEPCWdpi1UGB@nongnu.org
X-Gm-Message-State: AOJu0Yxaf9Lg37Ez5PYUKi7VMeAxr/mWpONQQOgi1/ACaRs+X7kbVbGl
 3Vk2iYhlx13cvhYYqz9A/Y35O6Q97syiygCkAlwBgzFmiJKrK5wCvhI+dc5aKqVJ/1OYGRMitId
 Mdq2WCV7+ucRdSW42v6+8oaZxescYc+E5ABWyMY0bxtAcuPGX7+0A
X-Received: by 2002:a05:620a:2902:b0:7b1:3bf5:1209 with SMTP id
 af79cd13be357-7b13bf518acmr871391885a.28.1729105180014; 
 Wed, 16 Oct 2024 11:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPePi7WClXWhII6mXjhTDb+u/6I4/wtAAxRjFGgF6bZ584SJuHQm245wvyJjO9iT3nrNOdJw==
X-Received: by 2002:a05:620a:2902:b0:7b1:3bf5:1209 with SMTP id
 af79cd13be357-7b13bf518acmr871389385a.28.1729105179720; 
 Wed, 16 Oct 2024 11:59:39 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136179ec0sm213805085a.59.2024.10.16.11.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:59:38 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:59:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v6 03/12] util/dsa: Implement DSA device start and stop
 logic.
Message-ID: <ZxANFz4mo5qW94xS@x1n>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <20241009234610.27039-4-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009234610.27039-4-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 09, 2024 at 04:46:01PM -0700, Yichen Wang wrote:
> diff --git a/util/meson.build b/util/meson.build
> index 5d8bef9891..3360f62923 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -88,6 +88,9 @@ if have_block or have_ga
>  endif
>  if have_block
>    util_ss.add(files('aio-wait.c'))
> +  if config_host_data.get('CONFIG_DSA_OPT')
> +    util_ss.add(files('dsa.c'))
> +  endif

It's not clear to me why this needs to be under have_block.

Since we want to make sure this file is ignored on !x86, maybe it should be
put under the "elif cpu in ['x86', 'x86_64']" section.

>    util_ss.add(files('buffer.c'))
>    util_ss.add(files('bufferiszero.c'))
>    util_ss.add(files('hbitmap.c'))
> -- 
> Yichen Wang
> 

-- 
Peter Xu



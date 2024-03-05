Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE7C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 02:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhKXC-00010N-H0; Mon, 04 Mar 2024 21:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhKXA-0000zw-ML
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rhKX8-000521-Mr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709605676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yx+HDB7baRNGz9ODJ/Z8HEIbBbg95KoMpjLQ/CG4HYI=;
 b=BFLZGvZTy3EE0HkXa5H3RTxANO/4yRRWzaJj8OJrmdlmHfZLfkEAfBsc+WZM/xmG1+oGlN
 cRtbs5VgnZIBKrYqY1NrAXxrR/IS4PCfvfI90eAaJxdYFcy3+IEF49g4pVmHAqTI1g4zf3
 fdXwpShNTJZCjZ8o+CcJVzaObDPB6tw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-2P7NenbNOf6NbQZLOWK3lA-1; Mon, 04 Mar 2024 21:27:53 -0500
X-MC-Unique: 2P7NenbNOf6NbQZLOWK3lA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5a14eae17ceso86582eaf.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 18:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709605672; x=1710210472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yx+HDB7baRNGz9ODJ/Z8HEIbBbg95KoMpjLQ/CG4HYI=;
 b=WE9gDX7P6ggcvbrzF7QeJ08erdBWHsnZj5o4j9JCrmyZg+rqIHzrakhlNHklgfgmE3
 fLo8Lk5D8jR45yswg0QWEZ6p8z9FTinru1EhdTuLr/1zQj/jD+eYUNxsT7yXB5xtJdXs
 dIiX/KjskWV39nIevs824clJBNdY8Z6oEmdxRgSH3jnhHGdmK6efZNNbrJ0Ro72UgxtH
 iA6YloK6ZEoRopuqHy36L+DrRJ3cNVVrypJ1ZV8+LoovK5Casx488EPKzHqGwL/pZr+z
 lJjTSlPYhcu2IppD7FUtxXC/DK1ARkv4NUwVUwtWVDCUSODGGjtMx7gfJIJVcY0+/fE6
 3C1g==
X-Gm-Message-State: AOJu0YxwqmaoX2CZNnEhwCqPb0S1CDNvsYyh/RZQ2X/PeEbaeTzwnIAE
 PDxWfLY12Ao9NjrO3t6ouRy57uK2w63scgAzosEnU3+i7LnVGjQQFKI1hbBWJ1IxwVMdDhPUNmc
 HRwdvQzbUHBTgswXtTBQJshSsHALJlpc8hxFk+fIszhhaP8ZbwwOt
X-Received: by 2002:a05:6820:611:b0:5a1:2cfe:1585 with SMTP id
 e17-20020a056820061100b005a12cfe1585mr6538317oow.1.1709605672710; 
 Mon, 04 Mar 2024 18:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOlqgXv0XphLZNjmY3ra6I5e+Fbgi9TxYfSjAX+EGu1ck2WnT1FJ5dELmZ5nIiqDZHLiJBfw==
X-Received: by 2002:a05:6820:611:b0:5a1:2cfe:1585 with SMTP id
 e17-20020a056820061100b005a12cfe1585mr6538293oow.1.1709605672354; 
 Mon, 04 Mar 2024 18:27:52 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u15-20020a056a00098f00b006e637a8322esm406297pfg.126.2024.03.04.18.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:27:51 -0800 (PST)
Date: Tue, 5 Mar 2024 10:27:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration/ram: add additional check
Message-ID: <ZeaDIlpWo1XXMBrZ@x1n>
References: <20240304144203.158477-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304144203.158477-1-davydov-max@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, Mar 04, 2024 at 05:42:03PM +0300, Maksim Davydov wrote:
> If a migration stream is broken, the address and flag reading can return
> zero. Thus, an irrelevant flag error will be returned instead of EIO.
> It can be fixed by additional check after the reading.
> 
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>  migration/ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 45a00b45ed..95d8b19c3b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3902,6 +3902,12 @@ static int ram_load_precopy(QEMUFile *f)
>          i++;
>  
>          addr = qemu_get_be64(f);
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            error_report("Getting RAM address failed");
> +            break;
> +        }
> +
>          flags = addr & ~TARGET_PAGE_MASK;
>          addr &= TARGET_PAGE_MASK;
>  
> -- 
> 2.34.1
> 
> 

Queued, thanks.

-- 
Peter Xu



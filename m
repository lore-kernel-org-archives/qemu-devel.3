Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34C0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzCG-0007hs-KG; Tue, 28 May 2024 11:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBzCF-0007hN-Ep
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBzCE-000775-1q
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716911824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52W1zbK9+M0gSThh9Gx/tIUOw+RBZMiUQFEVJXgAaak=;
 b=jA+0qU5U759d9urhhiFAgkZeZZBiXhsmKvjiq42eXOHnmSEU1Q0SjuPifkjgKh/fpFTYl1
 pn3MIO7OQFP/GRqjbFj77ZBFvd2cTuHOrSQTgCXT6b3GdS6+n9Bg5SkdtKteQwSsCy4vzA
 GTT9muLukJezWd80Zlw4UDY0iyvedyA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-GIFfHHGqOxmWtzyC311fiw-1; Tue, 28 May 2024 11:57:03 -0400
X-MC-Unique: GIFfHHGqOxmWtzyC311fiw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35808073fbfso652125f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911822; x=1717516622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52W1zbK9+M0gSThh9Gx/tIUOw+RBZMiUQFEVJXgAaak=;
 b=BDNi0QLciw1AN4i5Ixj6E5Mtrz+CALJ9+nIkSTdA51fGTzdVrhLCOEr1wDv7Vb6W4m
 TgW557zjoddcUmyUdAbRp/yteO0cYwuyPy3necsyaOgUv4xRX1Z8pO3RzKGxN8XzOh02
 GmlSeWSvvyJy+RmStSZlsDYHUjKu5yvBD7HCM4UMXey6bEGZd+SmJC++M6GjRi43KwtW
 BTUcsalTqud2s9oIeohrZBaqE2YYoSbfYnmMfW3a5sMx4Zr9yG1EpHpIsFm7iuxaF0mh
 vujQfgLmZSn+F+mUwAnyj7Zzv2FOd+VAXzqkBcWqqpubGjHNuZmeXDUig0FaswTFgO4z
 NUNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7o0SmnfjVq/nXckoxcFGZ3UywkArf97QWKC+PzDQHCia8bCDX9oY8UoO07C9vZqb6arQKxOM9OZCSiP9FKySzQyWH4FE=
X-Gm-Message-State: AOJu0YzC9SaMW66oWJxhRKcz0cVg5h3nHLFr7Vhrkj8AgzB3jfOLHZfM
 R0xViwfpwEzujfkpsMCcMWXA9pGcTJ9B7Qgy8bcglchfSd7P3YNKPUWbRb6n97OSCBq69+o4tot
 oKY+hWrfT9nC/fR5ZoNcizLYh1awffrD1pZD553HIWxGZV5kibeel
X-Received: by 2002:a5d:69c1:0:b0:355:230:e2d3 with SMTP id
 ffacd0b85a97d-355221811c1mr7732757f8f.20.1716911821903; 
 Tue, 28 May 2024 08:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWATgY7nYUn1IVUHgq9YmIK3HYh31ceuoV3VKBxH7iiXMicdv5DoMvKklC36pqCoq5LDPdyQ==
X-Received: by 2002:a5d:69c1:0:b0:355:230:e2d3 with SMTP id
 ffacd0b85a97d-355221811c1mr7732741f8f.20.1716911821327; 
 Tue, 28 May 2024 08:57:01 -0700 (PDT)
Received: from redhat.com ([2.55.190.148]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-356e8629abdsm9751109f8f.90.2024.05.28.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:57:00 -0700 (PDT)
Date: Tue, 28 May 2024 11:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Remove temporary
 directory inbetween
Message-ID: <20240528115641-mutt-send-email-mst@kernel.org>
References: <20240527060243.12647-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527060243.12647-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, May 27, 2024 at 08:02:43AM +0200, Thomas Huth wrote:
> We are reusing the same temporary directory for installing the headers
> of all targets, so there could be stale files here when switching from
> one target to another. Make sure to delete the folder before installing
> a new set of target headers into it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

who's merging this?

> ---
>  scripts/update-linux-headers.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 8963c39189..fbf7e119bc 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -112,6 +112,7 @@ for arch in $ARCHLIST; do
>          arch_var=ARCH
>      fi
>  
> +    rm -rf "$hdrdir"
>      make -C "$linux" O="$blddir" INSTALL_HDR_PATH="$hdrdir" $arch_var=$arch headers_install
>  
>      rm -rf "$output/linux-headers/asm-$arch"
> -- 
> 2.45.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F67D12D5A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 22:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAGg5-00017v-JN; Sun, 10 Nov 2024 17:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tAGg3-000178-JT
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 17:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tAGg0-0002bQ-2s
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 17:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731278696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xIjvb1evZiGJoTh1zaLzDup+TXMcL/omBN1Rd5jN08E=;
 b=Nzr1Aw3aK4zZT7klWD+/sFrednu8kwoxhr9Ww4nzyYsnB4J3wkG6uwWzrcCwCVO734nSLC
 bY+RrAr5RfpbR/hTV/7xiQEggIfdyZEJb11rDij4di3GJ4vEOVUEYlysk7qWPpU35re/MJ
 xjpzcR689CtRSxHl1CnVbpU20E1JAdU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-wucWo9M4NFW3VbkIMp1z8g-1; Sun, 10 Nov 2024 17:44:55 -0500
X-MC-Unique: wucWo9M4NFW3VbkIMp1z8g-1
X-Mimecast-MFC-AGG-ID: wucWo9M4NFW3VbkIMp1z8g
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99f43c4c7bso265573266b.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 14:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731278694; x=1731883494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIjvb1evZiGJoTh1zaLzDup+TXMcL/omBN1Rd5jN08E=;
 b=RB4kwAw5G+xHRjz6+Tzt0hpWiz6Ab5GvW0brWRg6pEJqRcKC5ZU9gTowRKnR1Inetx
 n5QD3uvTpM5ekh62ObBYzwg3+6ZzHuaiaGv9i6L3Q64eb3qfMVDzype+yXoQoYEgEfxb
 oiEg+h+sCN2UiXg2UPbXByf+/GyJVeUzREbw+hOJXdbOaVgqDJY40RanY0MTJE7dkSi5
 9347RO7XuJ7sbPQy3gCNha5KAlnMvpMDZ3fpSHWSPSQFWE0Bv/ElaKwqYvlaq3iM1RZ2
 w2YenaMN3CLjb2O+N4fKkIC0bmtdObofDLe9eDkEbBFIcfXO2Es6b9wAEoOxypDWdnxM
 HNwA==
X-Gm-Message-State: AOJu0YxUtIIbjhEY7p47igsx6kOd74hKUdeLPGE1fO3rzo1gkJ/BEvXl
 TcWHo7IEyMk2YA0+6D+Wc1pwyPK+qvcHd6UeDP6oSFwDQngUwIIjFF3TYoOW0AbBYU8coN+SkXb
 U6dbMbHzM9MRvKn6YQQzU8h0z4j0FD/PFyyEUttEUAYgJmKvLmupc
X-Received: by 2002:a17:907:97d4:b0:a99:fd32:11dc with SMTP id
 a640c23a62f3a-a9eeff0de9dmr1049030666b.24.1731278694065; 
 Sun, 10 Nov 2024 14:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2DhxUUJnfOo/zgfK7eTpIEaMADDho+FsMOmDO2c6R9qB6MrOGZmsWHBNYAciDzyaFVw36ew==
X-Received: by 2002:a17:907:97d4:b0:a99:fd32:11dc with SMTP id
 a640c23a62f3a-a9eeff0de9dmr1049029266b.24.1731278693692; 
 Sun, 10 Nov 2024 14:44:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:c88a:62ba:ea40:f034:5ee6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0deebabsm516710466b.153.2024.11.10.14.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 14:44:52 -0800 (PST)
Date: Sun, 10 Nov 2024 17:44:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: slp@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] hw/i386/elfboot: allocate "header" in heap
Message-ID: <20241110174359-mutt-send-email-mst@kernel.org>
References: <20241108230314.1980-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108230314.1980-1-slp@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
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

On Sat, Nov 09, 2024 at 12:03:14AM +0100, slp@redhat.com wrote:
> From: Sergio Lopez <slp@redhat.com>
> 
> In x86_load_linux(), we were using a stack-allocated array as data for
> fw_cfg_add_bytes(). Since the latter just takes a reference to the
> pointer instead of copying the data, it can happen that the contents
> have been overridden by the time the guest attempts to access them.
> 
> Instead of using the stack-allocated array, allocate some memory from
> the heap, copy the contents of the array, and use it for fw_cfg.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Wow. How did this ever work?


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo, you queueing this?

> ---
>  hw/i386/x86-common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index bc360a9ea4..d51ebad4d6 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -697,9 +697,12 @@ void x86_load_linux(X86MachineState *x86ms,
>                  strlen(kernel_cmdline) + 1);
>              fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>  
> +            setup = g_malloc(sizeof(header));
> +            memcpy(setup, header, sizeof(header));
> +
>              fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
>              fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> -                             header, sizeof(header));
> +                             setup, sizeof(header));
>  
>              /* load initrd */
>              if (initrd_filename) {
> -- 
> 2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DA4EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5Zr-0000yd-35; Tue, 10 Sep 2024 14:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so5ZT-0000iS-OP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so5ZQ-00013C-Vz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725992792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cRoEgMJfS5M5bG8vybS/0PppI1EkZSN/qb4WA5VLPz0=;
 b=Z7Y/jT+KXzlEQD4JmEiXiwxHR5pJ1RTmHjqV/vqc7OD9bXYAA4WATfmLb0SX2mwZiGm9o6
 uAHczuoRAS9HGOW9BeDRm9zWlgaylznQbGMsqG+dYHKCIUc0HGpXo+sYim+IlBcWi/YDXT
 8b2YAyxpry4FVlCaqV7xvQx4Ko3k0ZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ot0j5WinOs2lRiEzyreejg-1; Tue, 10 Sep 2024 14:26:28 -0400
X-MC-Unique: ot0j5WinOs2lRiEzyreejg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb22d396cso25793775e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992787; x=1726597587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRoEgMJfS5M5bG8vybS/0PppI1EkZSN/qb4WA5VLPz0=;
 b=tVX7YGggkmhJHLvIR/Va5OFoMxkEPZMSWC2JQZA8t02QVXikZF+RINK/MI1kI22XXp
 htllkb7AevTWpEzONLDqe9CR7obZEk6ou9XmqtnGZgAQmW6SNdMb5Tp7E6ucHdlWL549
 y6ixddntEop7B03Vn36bdZ8288c+Q8r/kiLIaoHo7xZBbkCNLEi7+CfEUcxd2YsfV+ZY
 Bw+yl+jjKHCK3fnXJ4jJm8h92pATjb1dALpwcTGi2L1yCmiMVvrTwktGv+ZMAn4NUZtL
 ++HkzvlDSSVcwGLwzGBTRRWl7s0d6uxXusaRW35Bxthy/6M9OY/vrSZUJ3tAgtQK2zi0
 mkNA==
X-Gm-Message-State: AOJu0YwnBKtY6iPZgYVY/uP6/kBz+dkoX2wSWJDXh2kq5m0aDWQk+DGf
 LT+TeD0hNpjiFetDC/HciTAxRmeDJq6UIqO+rS1P4baz2KX5uEc517u4h5NZQTxUKGCxBG/nKQR
 0aHY23CItEH841BELcs155tAboNFnpLjaawHwf2VZqvPIRHiNpRRM
X-Received: by 2002:a05:600c:4f4b:b0:42c:c92a:f157 with SMTP id
 5b1f17b1804b1-42cc92af337mr12869785e9.3.1725992787553; 
 Tue, 10 Sep 2024 11:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXfODvximhY9RUg42djZFLB/XtrIFWvQGupibD37DpSLTCtQoIMjgPsiTBkPlEtuXzLDDtw==
X-Received: by 2002:a05:600c:4f4b:b0:42c:c92a:f157 with SMTP id
 5b1f17b1804b1-42cc92af337mr12869505e9.3.1725992786901; 
 Tue, 10 Sep 2024 11:26:26 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb818b6sm121168695e9.38.2024.09.10.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 11:26:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 14:26:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v1] virtio-mem: don't warn about THP sizes on a kernel
 without THP support
Message-ID: <20240910142458-mutt-send-email-mst@kernel.org>
References: <20240910163433.2100295-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163433.2100295-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 10, 2024 at 06:34:33PM +0200, David Hildenbrand wrote:
> If the config directory in sysfs does not exist at all, we are dealing
> with a system that does not support THPs. Simply use 1 MiB block size
> then, instead of warning "Could not detect THP size, falling back to
> ..." and falling back to the default THP size.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Okay, I picked it up. But I have a question

> ---
>  hw/virtio/virtio-mem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index ef64bf1b4a..4075f3d4ce 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -88,6 +88,7 @@ static uint32_t virtio_mem_default_thp_size(void)
>  static uint32_t thp_size;
>  
>  #define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
> +#define HPAGE_PATH "/sys/kernel/mm/transparent_hugepage/"


If this code runs e.g. on windows, it will poke at cwd root with
unpredictable results.
It doesn't look like this is linux specific, did I miss anything?

>  static uint32_t virtio_mem_thp_size(void)
>  {
>      gchar *content = NULL;
> @@ -98,6 +99,12 @@ static uint32_t virtio_mem_thp_size(void)
>          return thp_size;
>      }
>  
> +    /* No THP -> no restrictions. */
> +    if (!g_file_test(HPAGE_PATH, G_FILE_TEST_EXISTS)) {
> +        thp_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
> +        return thp_size;
> +    }
> +
>      /*
>       * Try to probe the actual THP size, fallback to (sane but eventually
>       * incorrect) default sizes.
> -- 
> 2.46.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCC10A62CF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kxs-00083C-Hf; Thu, 26 Mar 2026 09:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w5kxo-0007wz-Ho
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w5kxm-0001yz-R2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774532488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TW5QzDx784PFd9FvheYnQhwmjMzgkz4DyDcRuzVDEDk=;
 b=F5tBADFqbEhIWV/yt84Iax0VQKTtxkH5G49KqknOhhRfJ3khjCzNQzOnvBJkgteVLBJj28
 ZFKLOQNQuEuxpDyC+aITT5FeQ6y5OhsB8UhTKMTydIDV9TfroipTP6mmLZY64LcrHUjFiO
 sfm0h2Ae/cv3LEHH7W3BWPFwmWBPIXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-83psG4fTPkeSk20QNI0VWg-1; Thu, 26 Mar 2026 09:41:26 -0400
X-MC-Unique: 83psG4fTPkeSk20QNI0VWg-1
X-Mimecast-MFC-AGG-ID: 83psG4fTPkeSk20QNI0VWg_1774532485
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4852cf0318dso10788515e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774532485; x=1775137285; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TW5QzDx784PFd9FvheYnQhwmjMzgkz4DyDcRuzVDEDk=;
 b=SPzHQg0jzWRQvHcfDa1wQPG9ano7GhDmERwufCQ86cWvx22xfiH6R699g1kGy2rWEe
 fXWcnTyCbGEijzJOFzjICntyFcYA3NBtcY8rZPegnxJpDhEn209+ZyUwXGuXK4WO7a55
 arRl2WGPSE7zy8g7KuST0hmXTjoNj1XKNjzU2eYM7cpZl4R2wC0hWqXYtdQ2/mX6YtFG
 HD0V6Tsi/uS9eleMEclDSEKUswiZQrYGqv4+u8iUchd1nVWwZw9+ZGm/gJ9vL3GWrpvh
 0JsHGkoEUpntZjPOPA8VLCCPxUdGUWCxrCy+j6C2l2s3ackJ5AoFZhhnKeRyvkaEs8LT
 Hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532485; x=1775137285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW5QzDx784PFd9FvheYnQhwmjMzgkz4DyDcRuzVDEDk=;
 b=PJewsSGVzRfhJV/flIkTdQI12ZvjSYRehp7RwfTdYL7nTcKDqMEkM/ixalGYdXrvd3
 3XtWYJnT84d6xmek797i1v5PrboARkzcwU1dihWscU9JRgvhwKCgJqms5TB4ddg0TjvL
 6+NsOq6hf1YRPUJeDmwy9m5LiBfhB70zmDZclWgIxu0jtg/A12hHM6XnyYeqq8yKZXlT
 RafrtwHaJOtIudckX1DHack1LeRIINbp3Ffm5jtZsIFpTF1cMlTtk1pJFv1huwc9M+Rg
 v6Kwb8S0fOv6+axEXcWijnisNANU0ZWB7tfH6KLHIaQzdkUfMBvb/O2k5uPe/tUCcZWv
 Tp3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGKRu6cIFqfS3gVlX1jz+Q8kCRojrwqEeIQKXdQPucQNyfwNLET2gkDwvIkP9MvX63hbBFaUOh+2SL@nongnu.org
X-Gm-Message-State: AOJu0YwiBPtOxmjRZ8NDTFaToUx86ej4MELpK0zcpggRUNw6quXIMIaO
 83H5SxuEjeaesvND4GS2/RWeFHA2B7ByvmAqadO8xlieibDgsNIHxW2bqG1V0CCNTg6bfwugZt1
 t7UFRIx6d7b4wD+kVzXfZs9BZK8z9+eTnRrty130UQ6p6RXhxGPsgJogq
X-Gm-Gg: ATEYQzze+DDOh4OfA55zQOySAw2cbPROCCoIYhW05qXEiTKkmdeDFe0LshZm1GGOacv
 VYSLgVFMu0AKy3vNT4m2H/+wy2FNv9O/toRno2B7yiXpbv2UQCqiGfmf/oXH7ICZ2SPCCnTV5+z
 F5w026JV/38hGsxwAvyMnB1H6gS8zifwMrWoAHIGaPu/hb9h7DUaeiUdCMQZVbooSSgeKQVvMEq
 yOhFQ75qsZkAJNlMO8aSvzDHKKvdHl99Ch7yqpNas8p2psKgER8ywbexak5fnH2eXVNUxUAFhhJ
 ZRWVPSVMtTIFJ4Z1Qf83iuAMh+03ca0UB/szri/GLanlSKACB0M0yyn3cqEkFmMGLga6kk5H005
 qKKMdXvqysFyQsPIN
X-Received: by 2002:a05:600c:3154:b0:485:9a50:3369 with SMTP id
 5b1f17b1804b1-487160846d9mr106424115e9.29.1774532485045; 
 Thu, 26 Mar 2026 06:41:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3154:b0:485:9a50:3369 with SMTP id
 5b1f17b1804b1-487160846d9mr106423625e9.29.1774532484413; 
 Thu, 26 Mar 2026 06:41:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722cb0d83sm31270075e9.13.2026.03.26.06.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 06:41:23 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:41:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] hw/acpi: correct field sequence in SPCR table
Message-ID: <20260326093653-mutt-send-email-mst@kernel.org>
References: <20260326121947.51200-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326121947.51200-1-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

the fix is correct, thanks!
something more to improve:


On Thu, Mar 26, 2026 at 01:19:47PM +0100, Heinrich Schuchardt wrote:
> On LoongArch and RISC-V invalid SPCR tables are created:
> 
> Terrminal Type : 00
> Language : 03
> 
> The correct values are:
> 
> Terrminal Type : 03
> Language : 00
> 
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
> 
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

should mention revision you are consulting.

> 
> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>


BTW I think the link to the spec should move to build_spcr.

And also:
/*      
 * Serial Port Console Redirection Table (SPCR)
 * Rev: 1.07
 */     

is probably wrong:
1.07	Fixed incorrect description in Stop Bits field. Undo accidental removal of Flow Control field. Edited formatting.

it's likely not the earliest version we adhere to.


> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 4b37405088..a999320e61 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, f->stop_bits, 1);
>      /* Flow Control */
>      build_append_int_noprefix(table_data, f->flow_control, 1);
> -    /* Language */
> -    build_append_int_noprefix(table_data, f->language, 1);
>      /* Terminal Type */
>      build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);
>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> -- 
> 2.53.0



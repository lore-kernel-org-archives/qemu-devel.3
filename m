Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234EAE64A82
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRRg-00043t-Ag; Tue, 03 Dec 2024 06:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRRY-00041S-3l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRRU-0002fH-Va
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733226707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQkSGIxzX3VxvHwHfMs8XnHAuI+Nji2BKn26CghMNBo=;
 b=hquOb6qbTk9bnVN8GZJElD8zH4S7V2BzqU8bZR5MvU3/RD1InFco/0N65d47MAWcXjHccR
 pt4cl903vgoerKibrFoJu5s1h8/7MM7fNVeKCFExFR0Dai3+KZcgMDXL9AyNg9SU1K30/+
 hHiTksKA4Fe1du2RJZTBdjqwgOpND0k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-cFDYcqlIPlW1G-HoXXyZMQ-1; Tue, 03 Dec 2024 06:51:46 -0500
X-MC-Unique: cFDYcqlIPlW1G-HoXXyZMQ-1
X-Mimecast-MFC-AGG-ID: cFDYcqlIPlW1G-HoXXyZMQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso2025499f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226705; x=1733831505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQkSGIxzX3VxvHwHfMs8XnHAuI+Nji2BKn26CghMNBo=;
 b=IpceEHKFSEk8LDDdjRHXQf2xRa2uS6qgmGVKlWFXg40G7VEbRJ45sFhe4BjD42PqJA
 Yh55Ga5mJm96cfTdf8331jAWdsuxeCwLZ6voTMeiPFKUZWZfHFXwFYC3pr3pM+DGCPU+
 vStBjDQHt2zW2fB9c13Xw5ZUKY5872q/oejPrsF7M62efOwPSqADIAYKjlMHoE8WJ2Xc
 Mh2FajOJMWXn4LJeAtXkvyCclyJfOShw9TljSS0m91SDPivYQGz/jLh+XjIksThMvXqv
 0p2SKqNMXDXzJPM2biAKdPd4QnpoKRynkIRc0/BLfZ1rQh1KQQzoFuS9+hwrJHgmctAc
 QBnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ9+6Ed1Y/Qc2uoJPVbBxFJJ4NJ7OD6IYbuTx904gHETcylqzFq4rLS13yyXqOh6Lu48iP2Ca6DvAA@nongnu.org
X-Gm-Message-State: AOJu0YzOlTpF1KCfeWIv/U7JtqrsJsP8iT+Nrt2wcUhQVA0x3XwiL62T
 KKikWU33r09XHy3EFwnpb+mS4GGGzIAnu7301BXuUAaBg3fSTqclli2GbfLLFbtfzzjBz1JUNKD
 0DtXZQAxmz0ub8E+RFEx1HF3RtuYpy8sPjYt7hVNK7N0s1XPvM71e
X-Gm-Gg: ASbGncsfb/cLKeogHRmTxsttgmrnwqoHN0k2E3T2KYBTukmT6fsXw2R+/2IrM5OPWXo
 JdSqPngDSuCcZfx8lCuF/SzcpWsXqUUfDErBSYzAvjxbFXcufYSQW9VrqFPuocdPUdLeyai2CY4
 S+iIAJbeDzjWN12Gh1JYPIGnCaSzHjwh+pZdUsFQTZ7PZEmaaa1jz+36kMp8y2gQMqhOY/n8qnl
 WgEo7Sv0DirL/pqBoV9tHBEbVhqkE4pFgn95jUjnzLLNyHicOWq6Be4dl/N/s4vw39EmKpnBj6H
 pbHsDwR8NvrGDVW2wucUzg==
X-Received: by 2002:a05:6000:154a:b0:385:e889:4270 with SMTP id
 ffacd0b85a97d-385fd4365c1mr1756242f8f.56.1733226704797; 
 Tue, 03 Dec 2024 03:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH/F3aXmuoPATMSkiaZyphdNPoumo1s4gtBFB8R5/Ts345w9Pwkm5yBSWTL+e4JXMWXxhBjg==
X-Received: by 2002:a05:6000:154a:b0:385:e889:4270 with SMTP id
 ffacd0b85a97d-385fd4365c1mr1756218f8f.56.1733226704383; 
 Tue, 03 Dec 2024 03:51:44 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e3c21ba7sm9704995f8f.53.2024.12.03.03.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:51:43 -0800 (PST)
Date: Tue, 3 Dec 2024 12:51:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
In-Reply-To: <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, 22 Nov 2024 10:11:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, CPER address location is calculated as an offset of
> the hardware_errors table. It is also badly named, as the
> offset actually used is the address where the CPER data starts,
> and not the beginning of the error source.
> 
> Move the logic which calculates such offset to a separate
> function, in preparation for a patch that will be changing the
> logic to calculate it from the HEST table.
> 
> While here, properly name the variable which stores the cper
> address.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 87fd3feedd2a..d99697b20164 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static void get_hw_error_offsets(uint64_t ghes_addr,
> +                                 uint64_t *cper_addr,
> +                                 uint64_t *read_ack_register_addr)
> +{


> +    if (!ghes_addr) {
> +        return;
> +    }

why do we need this check?

> +
> +    /*
> +     * non-HEST version supports only one source, so no need to change
> +     * the start offset based on the source ID. Also, we can't validate
> +     * the source ID, as it is stored inside the HEST table.
> +     */
> +
> +    cpu_physical_memory_read(ghes_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
        1st bits flip, and then see later

> +
> +    /*
> +     * As the current version supports only one source, the ack offset is
> +     * just sizeof(uint64_t).
> +     */
> +    *read_ack_register_addr = ghes_addr +
> +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;

if get_hw_error_offsets() isn't supposed to fail, then we do not need to initialize
above. So this hunk doesn't belong to this patch.

>      uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -389,18 +416,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      start_addr += source_id * sizeof(uint64_t);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
> +    cper_addr = le64_to_cpu(cper_addr);
                   ^^^^ 2nd bits flip turning it back to guest byte order again

suggest to keep only one of them in get_hw_error_offsets()

> +    if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
>          return;
>      }
>  
> -    read_ack_register_addr = start_addr +
> -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -421,7 +444,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }



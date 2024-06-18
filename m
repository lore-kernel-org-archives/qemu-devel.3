Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF68C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJf3T-0006ZM-5K; Tue, 18 Jun 2024 16:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJf3R-0006YZ-WE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJf3Q-0007fl-AV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718741022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ntQqLuzVO4EclV6IBzgVZIjRXGnEvOv5jbVydOcu+J0=;
 b=ev3yKmosePlLnjVIDkcCYDcuYyBxW+oSgQzc8EcsuBP+fkXl54hwb7IGfWm4FnHHcfcEvu
 Xm+tYG8lKGdZLW9eGeJbDyYgFqlVuAW/SQmL5VzhTh52f/L+iqrgzaRV9Fxnhvuq/WwMhW
 YL/RTWJb5vhJlXsPhLuoOoFfXrABLg4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-R8hgZJUKPpCEBfI9ANNW3A-1; Tue, 18 Jun 2024 16:03:40 -0400
X-MC-Unique: R8hgZJUKPpCEBfI9ANNW3A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso26395f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718741019; x=1719345819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntQqLuzVO4EclV6IBzgVZIjRXGnEvOv5jbVydOcu+J0=;
 b=NWiM7bBaEvDqG5wLjXOoHAAmJYMsnIrtgoyueFrP85VUBrn1JsXclo1V/S/OO9mWaB
 OmoE7q1YQhAj7y2Znm6HI89xlRImo57EU7LJOpZGS6lcq9mp3HBGpkPd8Yrg7rcwbXso
 vQj1Z1uB4rxxJAwGGU9md7pYlQqZt8M8udtQxqf0TkGME/NMBs+a7qu7ky/IeA8s9qbt
 pU+VSs154v+JqoaEKJ7+FQQWF/dC0ulUeFQ3lr5N1jeDxFuXgonDh184oAQyaOP/QPFH
 7ldh554Zb8w68rxOktvRcSjAVUyHne/LChqsB3ItkaltdF1dtwDHa5OxGoBkBQiB8v7S
 Kjhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyiWA30sXyb7XU5DMb9F3lYN3qLfTkWkbX+7u5LmVCR5fJRAfs0yr3vWWbPvPM13arFXPhEhF9NhwFUwB6r0dxNYtJa6I=
X-Gm-Message-State: AOJu0YyNdwkdFwBr7HqmjwdTYD7MA4ZUGw7Yzfjy5P/jRZFNkmXuMRGh
 6HORnzlBWM0hqHFe07hJsP9ki3DwpmSPv1WyNdor4ORB5qlB/pNZVZmWpWhjf+1NHxjKSHgRPWO
 i9XJUsqDwYrUFI+hbQKgVlp5yJ2tf120MwhD0QLUtRK/qnUERHSD1
X-Received: by 2002:adf:ed87:0:b0:361:bcc5:2e26 with SMTP id
 ffacd0b85a97d-363175b9043mr376350f8f.19.1718741019470; 
 Tue, 18 Jun 2024 13:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14x1Z6Y+LgREF9u2czo77/jam8eJt7KaXHci72ya4fzRXY+5TKjHug+FtkI6GgXy5hPYdmQ==
X-Received: by 2002:adf:ed87:0:b0:361:bcc5:2e26 with SMTP id
 ffacd0b85a97d-363175b9043mr376326f8f.19.1718741018771; 
 Tue, 18 Jun 2024 13:03:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36076515a80sm14838290f8f.76.2024.06.18.13.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 13:03:38 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:03:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <20240618155630-mutt-send-email-mst@kernel.org>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617223945.906996-1-nicolinc@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 03:39:45PM -0700, Nicolin Chen wrote:
> The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
> to be "the number of IDs in the range minus one". Otherwise, Linux kernel
> reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.
> 
> Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v2:
>  * Moved "-1" to the same line of id_count calculation
>  * Added "+1" to the next_range.input_base calculation
> v1:
>  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> 
>  hw/arm/virt-acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c3ccfef026..631f2c6d04 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
>  
>              AcpiIortIdMapping idmap = {
>                  .input_base = min_bus << 8,
> -                .id_count = (max_bus - min_bus + 1) << 8,
> +                /* id_count is the number of IDs in the range minus one */
> +                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
>              };
>              g_array_append_val(idmap_blob, idmap);
>          }
> @@ -298,11 +299,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>  
>              if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> +                /* id_count is the number of IDs in the range minus one */
> +                next_range.id_count = idmap->input_base -
> +                                      next_range.input_base - 1;
>                  g_array_append_val(its_idmaps, next_range);
>              }
>  
> -            next_range.input_base = idmap->input_base + idmap->id_count;
> +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
>          }


All this has to be written in the way that actually refers to the
spec. id_count is nowhere in the spec and one has to know that
in the end this is used by build_iort_id_mapping to figure out
where this comes from. Not good.

I think the best way is to fix build_iort_id_mapping:
make it subtract 1 from id_count.

Then change text from "Number of IDs" to "Number of IDs - The number of IDs in the range minus one"

You should also add the reference to IO Remapping Table document
near build_iort_id_mapping, it is currently unclear which table this
refers to.

Of couse this means the only correct use has to be tweaked so the change
to build_iort_id_mapping does not break it: 0xFFFF -> 0x10000 - but
that's good for readability, anyway.


>          /* Append the last RC -> ITS ID mapping */
> -- 
> 2.43.0



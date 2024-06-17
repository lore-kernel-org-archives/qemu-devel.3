Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C67C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9oN-0000zO-1v; Mon, 17 Jun 2024 06:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJ9oK-0000yi-VH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJ9oJ-0003Hd-GB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718620921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cam83kMeg7LJA9PMFUt3qYhC86g+Z5t8VkWEJcETwtY=;
 b=eKWv8EuKXSMSIZyuzPp5816UtK0llruNe1QLUTHBIB6wI1dZLQKGQxJERKy7i+ndIW+uhy
 9sUknq+HbSb/BM0pOx91zbznYpQWNehllTb2sMDqFKsXTZf3Q8+vqZ3IGm+PMxNXnsxdNt
 /1iP3EQ8wl1xTjUeX7A4XmisbC7evik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MzTCAgnvPgijaAxGvTGN4Q-1; Mon, 17 Jun 2024 06:42:00 -0400
X-MC-Unique: MzTCAgnvPgijaAxGvTGN4Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f1f958b7dso2301970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718620919; x=1719225719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cam83kMeg7LJA9PMFUt3qYhC86g+Z5t8VkWEJcETwtY=;
 b=XGUNUNTqaec5xUEdQrmSJll84UuMXhYHZdp387OmU5ep/Lnf9xERjVjK4s57xeq2MG
 kg8DqAaLKXyByEAWocCpTw4LcUX9YEioIBxn/EqABm5s6MY+A+ln/p5p1Z3NqbIXoMG8
 tL1SGIHcE+ZQYZ2Sc72t4hWF5sJUXEAtAS2gBo+AHM+icZUNxfvbYJNz6QQ0wl1unccs
 xROXX77WlZIVqHdinGHm1Dj8cpJyGYkQcqF2jx9ZWcJqK180vV+z1hyZLoPeNDl1bbZM
 TnoqTC3vd36TAS0/OAll1pKBK8WfzZHSBXPKQ9vY5T1l1/D4iSKx6lga8M+Q8dLrkFCm
 sDOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB2z0OomWYbxnQhp/Lo7mHNeXonbdpGKYkxX60xiaXNHbqvtBWJCXkxtL+erCtkfsZlRujLO4+1desrAEhpdI8tL3jXVA=
X-Gm-Message-State: AOJu0Yz20kW8itRmc/ia1zEwmVt+S3Ak1/mD3DXzlALWAIO53IEXpqMM
 XPOBKJQ6pQiXV3OVb/U/KjXhVyMcmN1w/XnhJaxsFxYP8kS+TZmpEBktdY+lsUz8gTx1TFmmq6/
 4ptdJb9SobdGQo+VfOwepIRwlqvr6dOc76jvxq3YmFKeR8PRdFveX
X-Received: by 2002:adf:e88b:0:b0:360:8f85:a5f1 with SMTP id
 ffacd0b85a97d-3608f85a70amr4118722f8f.5.1718620919040; 
 Mon, 17 Jun 2024 03:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqfqngjsn+8M/zfc9Qn9zbJHk58ElixIVy4SK1HHBL2qn5IfIUNNlzVBr7shBmQnO1GHi9pg==
X-Received: by 2002:adf:e88b:0:b0:360:8f85:a5f1 with SMTP id
 ffacd0b85a97d-3608f85a70amr4118701f8f.5.1718620918529; 
 Mon, 17 Jun 2024 03:41:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:741d:ed00:9efe:886c:c2d8:ae8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c790sm11599448f8f.38.2024.06.17.03.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 03:41:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 06:41:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <20240617063156-mutt-send-email-mst@kernel.org>
References: <20240613234802.828265-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613234802.828265-1-nicolinc@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jun 13, 2024 at 04:48:02PM -0700, Nicolin Chen wrote:
> The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
> to be "the number of IDs in the range minus one". Otherwise, Linux kernel
> reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.
> 
> Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c3ccfef026..b9343dde0f 100644
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
> @@ -298,7 +299,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>  
>              if (next_range.input_base < idmap->input_base) {
> +                /* id_count is the number of IDs in the range minus one */
>                  next_range.id_count = idmap->input_base - next_range.input_base;
> +                next_range.id_count -= 1;

I would just add - 1 on the previous line, instead of making it
incorrect then correcting it.

>                  g_array_append_val(its_idmaps, next_range);
>              }


But the value is used later:

            next_range.input_base = idmap->input_base + idmap->id_count;

Wouldn't that make next_range incorrect?


I also note that

static void build_iort_id_mapping(GArray *table_data, uint32_t input_base,
                                  uint32_t id_count, uint32_t out_ref)
{
    /* Table 4 ID mapping format */
    build_append_int_noprefix(table_data, input_base, 4); /* Input base */
    build_append_int_noprefix(table_data, id_count, 4); /* Number of IDs */
    build_append_int_noprefix(table_data, input_base, 4); /* Output base */
    build_append_int_noprefix(table_data, out_ref, 4); /* Output Reference */
    /* Flags */
    build_append_int_noprefix(table_data, 0 /* Single mapping (disabled) */, 4);
}


That comment 
    /* Table 4 ID mapping format */

really should be before the function and it should mention the spec
it's from - specifically the earliest spec including the relevant table.





>  
> -- 
> 2.43.0



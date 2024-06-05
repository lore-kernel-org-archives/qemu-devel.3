Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A0DC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0DD-0000zj-W8; Wed, 05 Jun 2024 19:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0DA-0000rc-No
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0D9-00067O-4P
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yz8jTDHMfEz/BGDUc0jcZQLJ8Pv4WKQiVSKM0FSCnkU=;
 b=XPkZc7Tx790DJMZCylSEjwQDohoM9JI/d4YSY0KwPmunzOBU64JztUJkZ6seSwbTu2I6o7
 ui9YSWG6NX36CPLiVtAU9lBpMfivTYp1VgyPlxRwgi2ZeO8t5C2TW9dpGmHolHNDxmoIBa
 Pxe7VZ+bFoAwxeLwqnHUcLNu4EX+KTM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-DkmOOq4wOfKpZJhddxCEPg-1; Wed, 05 Jun 2024 19:38:26 -0400
X-MC-Unique: DkmOOq4wOfKpZJhddxCEPg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ea892f8441so1905021fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630705; x=1718235505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yz8jTDHMfEz/BGDUc0jcZQLJ8Pv4WKQiVSKM0FSCnkU=;
 b=rtryUKIKIhCh0IFe3ByXM6cQulSRBvH3DzVz0B7Wf2TkFkHN3Fos76kTXATNzV7zrX
 fIl+02kKr6pUsQjL4iSNWGH5k8btEeVzqDEkavvn0APIonX0+z0YJ36KXKqC//+ds8pT
 ZLDvFWlpOYp8E3O9dlrA6h5xJIxnL1hel9GmdGYaHoPKCPVq2HDCYADSZjR3DVhynII/
 4+Ee2wY9lz2biln/Uk3sEZPGOBSZecpfUu9MyivLj+Lk4chzeZxXB2LHIncf8iaK6I59
 rypwzECgRG9xwA5bhbtvwDJC+O1C0sr4s5dFzQcF6yoRm/MF5+G7cmn01dNI6sV9aYtV
 6TIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5t3KO7j1C26WgRwkLCgL14e/Vk/sMKn8eq/DiJ+asNWW7TxZ9+UO/g88k8Oe+k2MLjyTr+cncDDGSj17MU9ocBe4SH3Y=
X-Gm-Message-State: AOJu0YwId9AqHCGxeh+BMkARk/PGnugFlLO0u2HbopYeiQue6d7OlJMq
 0Amb5/fiHGSCnF7YGZm4bUIfUvgIJ9A5QORBGRapZz0osWLXo/QAhEVRi3qNSRykY8/rn8+MDZi
 OxNu00XNdXq4aIomGnhUD0rU4C2CoXlWs5ksf4kbzSKzAz4i5+XY+
X-Received: by 2002:a05:651c:503:b0:2e9:5380:615c with SMTP id
 38308e7fff4ca-2eac79ed1ccmr27266911fa.12.1717630704876; 
 Wed, 05 Jun 2024 16:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVbIhP9pkqfy2MLhDm9ysTZOAvAKztWMN20l1VXr4b9I5STTJjNjbjbMU047kXF5BagMUrQ==
X-Received: by 2002:a05:651c:503:b0:2e9:5380:615c with SMTP id
 38308e7fff4ca-2eac79ed1ccmr27266851fa.12.1717630704364; 
 Wed, 05 Jun 2024 16:38:24 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9d06fsm104226a12.12.2024.06.05.16.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:38:23 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:38:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 ankita@nvidia.com, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
 imammedo@redhat.com, linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240605193521-mutt-send-email-mst@kernel.org>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 05, 2024 at 07:04:55PM +0100, Jonathan Cameron wrote:
> Treating the HID as an integer caused it to get bit reversed
> on big endian hosts running little endian guests.  Treat it
> as a character array instead.
> 
> Fixes hw/acpi: Generic Port Affinity Structure Support
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Richard ran the version posted in the thread on an s390 instance.
> Thanks for the help!
> 
> Difference from version in thread:
> - Instantiate i in the for loop.
> 
> Sending out now so Michael can decide whether to fold this in, or
> drop the GP series for now from his pull request (in which case
> I'll do an updated version with this and Markus' docs feedback
> folded in.)


Dropped for now.


> ---
>  include/hw/acpi/acpi_generic_initiator.h | 2 +-
>  hw/acpi/acpi_generic_initiator.c         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> index 1a899af30f..5baefda33a 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
>              uint16_t bdf;
>          };
>          struct {
> -            uint64_t hid;
> +            char hid[8];
>              uint32_t uid;
>          };
>      };

I think there is another issue:

+        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));

not nice since there is no check that 8 will hold all of
+        const char *hid = "ACPI0016";
and won't access buffer out of range.




> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 78b80dcf08..f064753b67 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
>          build_append_int_noprefix(table_data, 0, 12);
>      } else {
>          /* Device Handle - ACPI */
> -        build_append_int_noprefix(table_data, handle->hid, 8);
> +        for (int i = 0; i < sizeof(handle->hid); i++) {
> +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> +        }
>          build_append_int_noprefix(table_data, handle->uid, 4);
>          build_append_int_noprefix(table_data, 0, 4);
>      }
> -- 
> 2.39.2



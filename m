Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDAACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g0y-0000Pb-9a; Mon, 22 Sep 2025 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0g0w-0000Om-A5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0g0t-0008OX-8V
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758545485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEU8MrtyJBFH7wtLYz6lKHBkb4dkvaBABmEVzel40tw=;
 b=Ott40u/cPYuHxseivVT+xu/UB+dccNvMOG9MVM+b+M5nfCTYCnlyTjgqVmbmBAOF8Dl14H
 54BZDI55vKU5cAG8CwHnsUIebBs8/Y2jAYyne1S10WKUWXp1GRdmx405OGE1Beg5HAx7uH
 DtTUAXMT61h6LQMNJkldlYdl6FI7+VQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-JPfhLUdlNK2Ipa3t6jIo2Q-1; Mon, 22 Sep 2025 08:51:23 -0400
X-MC-Unique: JPfhLUdlNK2Ipa3t6jIo2Q-1
X-Mimecast-MFC-AGG-ID: JPfhLUdlNK2Ipa3t6jIo2Q_1758545483
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee1365964cso3398772f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545482; x=1759150282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEU8MrtyJBFH7wtLYz6lKHBkb4dkvaBABmEVzel40tw=;
 b=CjajqCr+O8uTkxaeIPZzWLrHrAZZKVAK2MJJa8awX6fD3IW3VTMG0coPVU++jxdGFW
 dHn6fomnFIpVnmACg1YnE7iFDBolTmkMpVCIAsNa4i3e7NiFrljZO6K7j9y//ayVDEst
 uJEtukC5jmvB8+oHK37q1g8Bu3CX3PlUp5ZVXRPVwJgrWhqWUdx2lWiw7mLX1zCID5KQ
 Lqj0/PhM7gjXiGkfAlemvaau4b8YHas1VQhJ0h1kBxpuoIVjLI8Hl8yyAy5DujCmxRlS
 kDIgvO3RojZ1rzbc0BEAiFkoJ+CHKNA9hSsprxFX+Vm6L0bCbuygoOzvqeWvVn8TCpPN
 mwZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCP/7t5FFf1WEl4IjTjBUv9eVEu3dR6zQ9OkR1BPMiJJueuxRo9+14yvEv1+gFT3Y5e14CWgg+3SK@nongnu.org
X-Gm-Message-State: AOJu0YyDlcfAauhEIs+QX2a+nsnyUO0S+i/kPp394ZT2FOMQIvc1ZOyC
 aSCQuHO+IClsDNQo6x5sNNM2j/RuoAHOy8Bdc6m6e07yTaIdeUj2U92U8I6vxHgWq10AaIZZyBF
 +NX8yyrkmSYwrMHEGEfWi+MH5fIJ69YXOecuExls999X8A5Rz5xFkb/9k
X-Gm-Gg: ASbGncvpF8aUz6G3bqNs1MByllmDBxrCedF1Pg5gXZpAqSN5cVfhAUABsU3bBOl+8zM
 yM8WqUFvld2LYXYzbOiuJmsX6S1FCbpXg+Pg6bO/D0CSJYZ6h5mZbOlE+dGRhpn4ec1s2xU36k5
 1wOQqfVwRGbA1u1K1Rs0fWbX+jCgBzdUrmhGBx8YMvUbPAvXNL14uoijOoB1vfUdoNUEizvR6Kz
 sMqxYLiJ9C/w5ezX/B48LzL/s86FP7nojCV3lCQ8WRHm6juazzc8QN32mWIdL1iSD2D/OkYZ7Jv
 rweU1TL6ZR5fY5MNqMK5Bt2Lqf6xrM/k56M=
X-Received: by 2002:a05:6000:1ac9:b0:3ee:1578:3181 with SMTP id
 ffacd0b85a97d-3ee87aca8edmr8850947f8f.49.1758545482506; 
 Mon, 22 Sep 2025 05:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBnJyKfbsGoT60gmGSw8lHVDLSbpKp/h3+mebPlmhY5lsdty8PTSlmG0n1AgxTfhHPmUKyNA==
X-Received: by 2002:a05:6000:1ac9:b0:3ee:1578:3181 with SMTP id
 ffacd0b85a97d-3ee87aca8edmr8850919f8f.49.1758545482036; 
 Mon, 22 Sep 2025 05:51:22 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm14362825f8f.56.2025.09.22.05.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:51:21 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:51:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Dongjiu Geng <gengdongjiu1@gmail.com>
Subject: Re: [PATCH v11 16/17] docs: hest: add new "etc/acpi_table_hest_addr"
 and update workflow
Message-ID: <20250922084913-mutt-send-email-mst@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
 <ca6ec605d255385430a923f9bf8dced717173690.1757084668.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca6ec605d255385430a923f9bf8dced717173690.1757084668.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 05, 2025 at 05:09:23PM +0200, Mauro Carvalho Chehab wrote:
> While the HEST layout didn't change, there are some internal
> changes related to how offsets are calculated and how memory error
> events are triggered.
> 
> Update specs to reflect such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index c3e9f8d9a702..3d1b85d74b70 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -89,12 +89,21 @@ Design Details
>      addresses in the "error_block_address" fields with a pointer to the
>      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>  
> -(8) QEMU defines a third and write-only fw_cfg blob which is called
> -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> -    for the firmware. The firmware will write back the start address of
> -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> +    where the error block offsets, read ack registers and CPER records are
> +    stored.
> +
> +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> +    contains a GPA for the beginning of "etc/hardware_errors".
> +
> +    Newer versions place the location at "etc/acpi_table_hest_addr",
> +    pointing to the GPA of the HEST table.
> +
> +    Using above mentioned 'fw_cfg' files, the firmware can send back the
> +    guest-side allocation addresses to QEMU. They contain a 8-byte entry.
> +    QEMU generates a single WRITE_POINTER command for the firmware. The
> +    firmware will write back the start address of either "etc/hardware_errors"
> +    or HEST table at the corresponding fw_cfg file.
>  
>  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
>      "Error Status Data Block", guest memory, and then injects platform specific
> @@ -105,8 +114,5 @@ Design Details
>       kernel, on receiving notification, guest APEI driver could read the CPER error
>       and take appropriate action.
>  
> -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> -     find out "Error Status Data Block" entry corresponding to error source. So supported
> -     source_id values should be assigned here and not be changed afterwards to make sure
> -     that guest will write error into expected "Error Status Data Block" even if guest was
> -     migrated to a newer QEMU.
> +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,

reports

> +     when a SIGBUS event is triggered.
> -- 
> 2.51.0



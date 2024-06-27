Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824D3C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoUW-0007Xt-1F; Thu, 27 Jun 2024 08:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoUT-0007X9-0i
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoUC-0000J1-H7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBm7xISxjDwLk3rw9TadeY1LhrJHrMgyAheJsxX0IGE=;
 b=IAiG5a+BX7jXeIpVrIQ0l1Ydq3vt1CdekYdTBspKtrVWItJKQsHgOchaF9MxkKqDEFva6r
 IoVA6X1TrWNJ3aOKFmiYEa17NTXmRI+yGK2JhKmjq6raGYzS1zjymOgpN4UTIwfr7yXK1u
 ZW++Z1gkOMmSvu6jyAN5criWvV3wMiE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-GuGf1INzNOScypw3u_CWEQ-1; Thu, 27 Jun 2024 08:44:21 -0400
X-MC-Unique: GuGf1INzNOScypw3u_CWEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4255f94080bso11653575e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492260; x=1720097060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBm7xISxjDwLk3rw9TadeY1LhrJHrMgyAheJsxX0IGE=;
 b=vP9Xei6yR8VWSk+kUB2l3yyMM+4MVtjrOzM62Mro5NHGnMfQ2+CzkAyh9dfBgYPvui
 JYSYS6fE2kalHwcBqAWbYfs/i6wktcozpV4Yyrtl7plhWmoMShqY3Mf0E5IgSpa0Ss42
 Pdbj9nBD/DDNYWFdbVSn6Lwxqqm6/eCCsfJ8OvcobUhTmqEGP43DRry9xgy1iFXmRpr5
 8gJRc8Q+AJmwTAXS89smpa94RkMVY5aqAfUWLRfAuIWN5vE15A975FNwvcRCJD/mYpdN
 uOSOUoU7qaxIAvhHjWzINYX+/anUNaLQb/oM4fuk4N7ejsX38v66hJ84dTFOzZl/EDmp
 kD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW8oQuj6zI+knSHoCj+EP25m8qP4WCVkf27w0nlkzQtvKGEbzYD5oOJQ/gweUYyCOjrz+3M4aEP9EBBM+aIQIF3EaQGAA=
X-Gm-Message-State: AOJu0Yx07/eBleJEYouTFT3MwQkkB6pz0NaDi4/SHhJXCpEbm/Q2n+4K
 KP/gPnZYQMZKxya/khT41l5Ihr3lorzJzZOjEHUC1pWRy757eER37yI3drg+ovIj/AOITlrpBTf
 e50YZd5r/HwRKMorkUylj1/Yo3GJeOp322Ox6ATJOdsoflbSRHcER
X-Received: by 2002:a05:600c:4652:b0:424:acf6:6068 with SMTP id
 5b1f17b1804b1-424acf6613cmr32899705e9.34.1719492260641; 
 Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKxt7tLNVMCXKX6PJ7ozexvquYD12f2guCgA7gWtFzSUp8HRAHAaVL5mfcIklI3atYlwAq0w==
X-Received: by 2002:a05:600c:4652:b0:424:acf6:6068 with SMTP id
 5b1f17b1804b1-424acf6613cmr32899405e9.34.1719492260153; 
 Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249b133b44sm65910895e9.0.2024.06.27.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:44:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:44:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 01/11] hw/acpi: Fix ordering of BDF in Generic
 Initiator PCI Device Handle.
Message-ID: <20240627144418.3f9052c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-2-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-2-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 20 Jun 2024 17:03:09 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The ordering in ACPI specification [1] has bus number in the lowest byte.
> As ACPI tables are little endian this is the reverse of the ordering
> used by PCI_BUILD_BDF().  As a minimal fix split the QEMU BDF up
> into bus and devfn and write them as single bytes in the correct
> order.
> 
> [1] ACPI Spec 6.3, Table 5.80
> 
> Fixes: 0a5b5acdf2d8 ("hw/acpi: Implement the SRAT GI affinity structure")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v3: New patch.  Note this code will go away, so this is intended for
> backporting purposes
> ---
>  hw/acpi/acpi_generic_initiator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 17b9a052f5..3d2b567999 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -92,7 +92,8 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
>  
>      /* Device Handle - PCI */
>      build_append_int_noprefix(table_data, handle->segment, 2);
> -    build_append_int_noprefix(table_data, handle->bdf, 2);
> +    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
> +    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
>      for (index = 0; index < 12; index++) {
>          build_append_int_noprefix(table_data, 0, 1);
>      }



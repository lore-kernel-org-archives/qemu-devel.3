Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705F4C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDlp-0001Tz-GD; Thu, 06 Jun 2024 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sFDln-0001TN-34
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sFDll-0004DR-D0
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717682827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBHcCC0aOQEbkk/FxhoIR6lpW/jON2WJxquJeI7WZTo=;
 b=GK5MvPTFU73vsdd0WmUJran7gYxz5Oxd9946K0uvos7JtmFwSIz/aDeDEJTqr/xJJ8n2y1
 IwLukieftOoP4Ha7kYDV/u3gq33Z0s52osvLCjKRrFOJYGlwwOqvaaZ+MWMtBoQguUr0/u
 hh7bkj+BuFKKpQFV5F/JZkMCVaJClf8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-yrT-SXKYNHagaa_mZFy8lQ-1; Thu, 06 Jun 2024 10:07:05 -0400
X-MC-Unique: yrT-SXKYNHagaa_mZFy8lQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52b98e99f0eso735059e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682817; x=1718287617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBHcCC0aOQEbkk/FxhoIR6lpW/jON2WJxquJeI7WZTo=;
 b=nRHi1GLHQtpJ93o2HdImzljK+JTYBYg+R0Tbk/foupRYFMRl2yBMMW0Ry+owPebVGP
 u3zCy6myBJCpOfGB4haMdcd0r5exAxSjKljKMYQd7QSMlDLXpEkQSt0XAWTUaN0Gk+P4
 2FzDurOq6wJoZM8LNctZsnHryQdJVZtDa3jIUQhpZs/EXd6YJHVBNg51xAEqpZjaNMqE
 NDypAzazhwsMRJ9/hk1sgpb1QXdAVg63BjBO8/4Dvk9Rf+/d5hMx3x2Frinrijr1z3xK
 13nf/wOyQX9pwoBmX+qPUkGEiNCMWIrrWDQLqP+EHhNawW5ktGLgfyCr0VI8HYWzRg9n
 hD5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVd0Dcb3P5G9a1Mcf45Wj+aJa9WvHeKpwSmhkUuW5oD310jLk8CUxJJzflllkcAAHmVUtcQ66sjPN6+1k2Nl1YfuXPteU=
X-Gm-Message-State: AOJu0Yy/bgh75vemJCTiyk9ecbwX0mTlL8pJxVmlT40ySRNRtXQ1h6LN
 vlN2ZUenDhJ5M/ZTXYMOw3J+t81h3ibS9DKyYbQOxXrVQkKxvT+q5Ae/1kaXsNkzSErXeHa8oMD
 CfNb9LqKCRoOA4zyFdUpiK6EWWeJOFYS/r9zh1/PuBAFQykzVp3OU
X-Received: by 2002:ac2:4849:0:b0:521:532d:eb38 with SMTP id
 2adb3069b0e04-52bab4f93dcmr3259536e87.63.1717682816686; 
 Thu, 06 Jun 2024 07:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJAFLjsdBKlNTdAip+7FwWJOQ+9Yin99Uippg7rK0J/TatnJ8UMFE70w9tAEZ7grWCl+WuA==
X-Received: by 2002:ac2:4849:0:b0:521:532d:eb38 with SMTP id
 2adb3069b0e04-52bab4f93dcmr3259520e87.63.1717682816251; 
 Thu, 06 Jun 2024 07:06:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d0esm1647700f8f.51.2024.06.06.07.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:06:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:06:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240606160653.27226def@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Wed, 5 Jun 2024 19:04:55 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

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
> 
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

not sure on top of what this patch applies but I have some generic comments wrt it

why PCIDeviceHandle is in header file? is there plan for it
being used outside of acpi_generic_initiator.c?


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

instead of open codding structure

it might be better to introduce helper in aml_build.c
something like 
  /* proper reference to spec as we do for other ACPI primitives */
  build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
      assert(strlen(hid) ...
      for() {
            build_append_byte()
      }          
      ...

the same applies to "Device Handle - PCI" structure

Also get rid of PCI deps in acpi_generic_initiator.c 
move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
hw/acpi/pci.c file if it has to access PCI code/structures directly
(which I'm not convinced it should, can we get/expose what it needs as QOM properties?)

btw:
build_all_acpi_generic_initiators() name doesn't match what it's doing.
it composes only one initiator entry.

>      }



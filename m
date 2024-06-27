Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27021C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMobh-0004IR-2Z; Thu, 27 Jun 2024 08:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMobc-0004Gs-0x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoba-0001pD-BU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGvNYGjLjM8OIwTle51VFi9dejDE14SsqCvTH3GKYcM=;
 b=D4DZwomXkWtXYdey7nZs0Ds6DHrOZlKc30uYu7Azttc2eFAqgeALGENvPTfCs9S+T5bdUY
 3P186Q5UeAlK2ukIUS0MdjgpNUm4ZV+qRy8K/eAfURLY+UiN0EUxJyMjD2UgwB0lc88823
 bmH1astZYYyqToXWCCC6THtXuvDe5Qg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-A06-wNhHPBeVfRyOkeAlvA-1; Thu, 27 Jun 2024 08:51:58 -0400
X-MC-Unique: A06-wNhHPBeVfRyOkeAlvA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421805fadadso54387115e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492717; x=1720097517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGvNYGjLjM8OIwTle51VFi9dejDE14SsqCvTH3GKYcM=;
 b=bbFVAnIBjoHuNXfaOSTTTKOi4B6foVA5wk0Rn6zHg+qx2Ch8myyelp1Bl9Wl1/23QC
 Kyqt3eO84Ux91KqqnyrKsSDtjWShflg0xVbIsmZH6hL2uMUQBl03OfWM6m0NWqgKIWbR
 YeZW4aqW6MtvuN95tMh7AJxb4RTUUxtCu/igvWwftIeHXoTIX2dETIqKy0ptn13a/fhK
 Z6gdLANTeoMyBBFL+cxmpPXZTMmvOIYg3oVNJtf2NTnYK7GwGPKEVN0Pp/qo5xUZJM/K
 lqJO0DmIETy7KyGjrVW/mfEPRbSOn/ozK+t3HmWgUe314+ufDGOksZvFU39vFnFbNztc
 oH9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY9/s7Yzw+2qcg/VaU8zFTPSyu5B+D/b751k8RO2RJ/jFVn3j18U5XmO+ulnoTxyz78oZvlBZ/m0IUQTzLzolrkrNAWMY=
X-Gm-Message-State: AOJu0Yz8/X3ZVi/qHseqRSsVEQY3nbgQpCKo331xr0FMm5T2LWpcPGLp
 u+zysvuMsR8KUvwS2C0bqhEdWSvP0/i1tKtZaVFQtgE50gSqmmg7q3QTkChzg0Er8X9F5HmgK5Z
 jjgS0KCI6fTQShLkITE7vP93WPvDuS775NSiOQzILRNYMyhJcZNxe
X-Received: by 2002:a05:600c:4251:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-424a6550d34mr46974545e9.19.1719492717316; 
 Thu, 27 Jun 2024 05:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3wtb7WPTnXwlztmFUbhY/EtSnUr2q1igQo2dwg2StxvIw1KRqBrc/SahmxFxNVuSK23r/OQ==
X-Received: by 2002:a05:600c:4251:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-424a6550d34mr46974345e9.19.1719492716898; 
 Thu, 27 Jun 2024 05:51:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84248afsm63616395e9.31.2024.06.27.05.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:51:56 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:51:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 09/11] bios-tables-test: Allow for new
 acpihmat-generic-x test data.
Message-ID: <20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-10-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-10-Jonathan.Cameron@huawei.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 20 Jun 2024 17:03:17 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The test to be added exercises many corners of the SRAT and HMAT table
                                      ^^^^ did you mean 'corner cases"?
> generation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: No change
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>  tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
>  tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
>  6 files changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a5aa801c99 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,6 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/APIC.acpihmat-generic-x",
> +"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
> +"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
> +"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
> diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2



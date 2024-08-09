Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1ACC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIwL-0008QW-Nd; Fri, 09 Aug 2024 02:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scIwJ-0008EZ-TD
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:17:27 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scIwI-0003qo-3y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:17:27 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7105043330aso1648143b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723184244; x=1723789044; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IAQhqbYAqGQNfBCrdps2Wqozb4sMH9lUMatyiw6pZXw=;
 b=DJAOxfNBosJ4khkKoyZCL7qFd93sS0PUc9BrZLei8Gws09sK2TLMPrx5nPApqf7wv1
 tWmCT/027a1+1wyQnttEvX7k4lb+83uq1sc5SY6GB3LVWUGUMGBErgzaZ6H/19LBgyX6
 tBL9PErtaeX8MMRqG0ziCHlPOeLAMG5FpjNlQwlIqOmDnJGBs6coIoGysXJo9MInOhuu
 oq+CRrtJf3riznQELI3xT72S15nSWdrClxdeTZ5lGPU6WrzR+BgA3nzjoF6hZpTG0b3M
 k5CvSKUrPDag3UyyJSodLSHANcbHy98+MEQ4ZrN9qcjX8e4hU6N/UR5pdMyDewq9X+Ke
 svfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723184244; x=1723789044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAQhqbYAqGQNfBCrdps2Wqozb4sMH9lUMatyiw6pZXw=;
 b=j7L0LFPGkXvRSL5kRCA028QLmLQo2a5pfzncvpkCwP/CAF8Tsi4kspHZm1eGmW0GWB
 G70FJpavee/8K7lcXH3Ms5X89M5C97BHYLFq4buzY1jQaxkS6uBVE2rpWr0X4hysyaqe
 BWlp1qtnpDsriueMbVOaCvNBOjx9Wv0BRUVzLed/utcx0eE2jinlYRkemC4WKkEifcam
 XjPQUfx6krJV59kiuhiklXIQ8Q+ZuteWRE3gZzDA/QCk23A27vAN/lk/62PYkl5xaL/i
 HuIas/aItgEV5YzpA4umUHRox5G/LoRyQ83wceZudztsfZ8vNk/xf9HZ132KgbD6lUSO
 sQZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBN8DwBkaMQQ6/erpJB8qK8CoQJ1A76sQTIsIWNFIi+UEh+foBl0N4c+wlrGjA9O9fb0b6pnXb/UvhOqENnJEF8mwB0Lw=
X-Gm-Message-State: AOJu0YxB4q4Oc7sTaSlcdextNaKgReX+jwtuUGf992P4D5JAMkqqRPzL
 GyywNR8eYjBXqMzg/RlsGLU4u67xX4K9GrYLFC5BNnAzidp9abW9oyS24okjkIk=
X-Google-Smtp-Source: AGHT+IHJ9cLoe6KeTyE+oDf0hzS7FwUq7rwTEIyRiPgf1FRU0eGY99ATfWLXqB8q1SsTCDX0UC39lg==
X-Received: by 2002:a05:6a21:458b:b0:1c6:9f28:37b7 with SMTP id
 adf61e73a8af0-1c89feeb675mr780875637.27.1723184244298; 
 Thu, 08 Aug 2024 23:17:24 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9db0341sm2155081a91.39.2024.08.08.23.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 23:17:23 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:47:17 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: alistair.francis@wdc.com, xiaobo55x@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
Message-ID: <ZrW0bVs-bhIXwR1H@sunil-laptop>
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
 <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 09, 2024 at 11:09:49AM +0800, Haibo Xu wrote:
> As per the step 5 in the process documented in bios-tables-test.c,
> generate the expected ACPI SRAT AML data file for RISC-V using the
> rebuild-expected-aml.sh script and update the
> bios-tables-test-allowed-diff.h.
> 
> This is a new file being added for the first time. Hence, iASL diff
> output is not added.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tests/data/acpi/riscv64/virt/SRAT.numamem   | Bin 0 -> 108 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..2b6467364b7673c366c9abf948142eaf60c9311f 100644
> GIT binary patch
> literal 108
> zcmWFzatz5~U|?XDb@F%i2v%^42yj*a0!E-1hz+7a7zWryU@U|<qXt~80m|Zli6H9*
> E0AFAS0RR91
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index a3e01d2eb7..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/SRAT.numamem",

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil


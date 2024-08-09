Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A30EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scIuF-00042o-NX; Fri, 09 Aug 2024 02:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scItu-0003z2-Tq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:15:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1scItt-0003Ck-29
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:14:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ff4fa918afso11775985ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723184094; x=1723788894; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k5qy/5prhvgTOwQHTkUZHocecIV6jjH4fWe50Mu90BQ=;
 b=fUYq7XXbpO7p2Jk5om9PI27k9+uPcQw1gghr52TSAw2FpcK5Cw4sN8bkuZwoiefrKI
 kf7FPNSSO+2NianTjLU0cum079WcFmT+3E4oYTdyipkuBnwn3I1EaZTDqIrp7JAhCBq+
 UZb9BJk8yuv8veOx6mc0jNO6RPv0Y6L7/ufKNxzTnsCeuNys+W/rPlB2EPqWJQAVGSs3
 nqVXGKGCfz68tBQNNLsWrHQGQFyyRjSD5k9zwwJ2KFLBNSaD7ViA55T1u0l4AB+/PqAv
 RP5z2jFhwz/Sml/5nC04mF3lAmKOMeNkDnyzQZVR8YWQ7v9brC/nNlD6xj/ChdbRDbp+
 QhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723184094; x=1723788894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5qy/5prhvgTOwQHTkUZHocecIV6jjH4fWe50Mu90BQ=;
 b=jrtQW/YpetdPsBR/0HgoUXf26S9r2ZRk0FrUSjuSmG9dMf3bAj4tmgpDGRWNIURTPh
 VkhbnIjuAh+XPfymshovd8kgeI/VVh/H3oOf+RbVHgd7c4soeFH7K3Ywl1CbgJS9DFSH
 +wQ85vZA8PIBebOeS0oyc0FJxn+8sxPkN2NYgdklhIiQS8bTnmtKFvq8rlgcEdYFxJcu
 jvUYCe9HSCCmNgU8Et6JF0UtN42co1ENzAXVcKFDVIddMxOzQ6fOI+1Lpi+niiaoM+uT
 Zsb3lT+ug1JjI5ajfVBgDu1uBki0u19jUXUWCvhkrhL1tL1lgnwowIYuDJANZtUG8eJK
 rWYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvZvZbGmzSPqTgxJpSkXjOmJy0f/esehIzpsXDonFTRXQ7dxSsWhDiBwUmHl49F5vHo+q2g6bToKKJrxMsSeYSETl1eY=
X-Gm-Message-State: AOJu0YxOa5YXKuIaQoAV6eTrout/ou/B6iZUm6h5smpHWAisVHGkdWPc
 F5FJjTYy6bDyilH9oXsDcomBl/UpYokc3moeLJ+Ly6LF9nbMegi2WRTgxriJg8Q=
X-Google-Smtp-Source: AGHT+IHvAr7Y9cdJkn0CFlslQkzs+hC7wWtanb++9wwhHiiZBTSW1xuO62qXyLpeg5re2VsCi543vw==
X-Received: by 2002:a17:902:ced2:b0:1f6:f0fe:6cc9 with SMTP id
 d9443c01a7336-200ae5f1fd6mr4553375ad.54.1723184094009; 
 Thu, 08 Aug 2024 23:14:54 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aa11csm134322995ad.272.2024.08.08.23.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 23:14:53 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:44:47 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: alistair.francis@wdc.com, xiaobo55x@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] tests/acpi: Add empty ACPI SRAT data file for RISC-V
Message-ID: <ZrWz15zqkTX3sYl_@sunil-laptop>
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x636.google.com
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

On Fri, Aug 09, 2024 at 11:09:47AM +0800, Haibo Xu wrote:
> As per process documented (steps 1-3) in bios-tables-test.c, add
> empty AML data file for RISC-V ACPI SRAT table and add the entry
> in bios-tables-test-allowed-diff.h.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tests/data/acpi/riscv64/virt/SRAT.numamem   | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem
> 
> diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a3e01d2eb7 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SRAT.numamem",

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil


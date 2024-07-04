Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCky-0002I2-1I; Wed, 03 Jul 2024 23:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCks-0002D7-8x; Wed, 03 Jul 2024 23:03:30 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCkq-0006zF-Me; Wed, 03 Jul 2024 23:03:30 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c80637d8adso169874a91.0; 
 Wed, 03 Jul 2024 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720062206; x=1720667006; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0L4DTuwrRPNNcVaHsMvS0IOC/2oVL/yrsV/EJOufk5g=;
 b=B92AFqEyQpwhJQ7YRohpJofsW+0kxVuvZvVAeZ+MhPfK/X/MN2LIMp7H/P+fwo2ExD
 M6uUiCMKYy3eCEmo0LaJPxXjoq/QHi2CxKCbSaPrRLe0pjWx57Jp24uXQOygcDqh6wJJ
 X6H/NOTsHPgheIfMO2BuwDJzSzDzNvmJLIGPfTzwlKv/INh79VfdIb874GyKZWC/VxcA
 yHxPTa3C0aBiQ5OD19hWvfhgvkXy4IhvkEkb1JpgPMPunwX3hf0TO/utAnn+dO7/AcF6
 /rsmq0B+bcMlA+XE8lyOy1gPFwH0vN9rDp++HxgzYHGbM3+fFcLlDbTaTXaJ3hdVmlQy
 +QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720062206; x=1720667006;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0L4DTuwrRPNNcVaHsMvS0IOC/2oVL/yrsV/EJOufk5g=;
 b=le3aL/a+/5hVfIWBjiGFLNRm/+rQJmU+GaaDuPptD5+S6pVNYzFcKQ5dm1m2+DtQ0b
 xK433r2UXp3toqcxRiJsgIM/k8YSIoJGC/KnbqinHdhjzbLOXBu9w1Z60JVKNiBbKKVy
 G9AA0s+MTUq1fdYWLLKBZOvuLo27B/eldZChTVa0BpJ8BZYjLr2sKgpnNOag0rwKYlUQ
 mp1JIiiW784mhH1t5WP4HcWZWSqwul4M/4gFMLatwhzPdM/xae0VLpkJS273vvr+T3Yd
 uYNnA2aUczAgU1QjVlyEU4mgNxp9cFwSeKQ/cBBC+k8dw9N1BwjFOnjOeedvnPQ9Xh5m
 j29A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Z8kIvI0aJLoCQSTWO1PKLmfWfr1VyxpLB7TG9NLkvHlXOgi1m88LmWUQH1H7ssXYpglLR+CdywvYBKwyR+PgX/FUoAMzRO68NzIVZt7nGElgrBZkp0qmai4=
X-Gm-Message-State: AOJu0YwEz1jZ+lxh/7y/02G+RZa63P8lD73qBDsAJIwE4mVmXAUj2CPA
 Ptbvm/o18ze3SHCEdhMYbmEp5XgLC9hbSvyGAtSHkfeDmYJoraUC
X-Google-Smtp-Source: AGHT+IFmipRhJvngOTgwJS6aikwhR7/qCPUyk5CyGHIhEqWOSVtFTiSBsbIzKZ7FQyDFbiMg7JV7EQ==
X-Received: by 2002:a17:90a:f184:b0:2c9:75c6:32dc with SMTP id
 98e67ed59e1d1-2c99c52aab3mr289097a91.1.1720062205745; 
 Wed, 03 Jul 2024 20:03:25 -0700 (PDT)
Received: from localhost ([1.146.95.80]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c999e22c50sm175174a91.1.2024.07.03.20.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 20:03:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 13:03:07 +1000
Message-Id: <D2GF5O8SP4Q8.38I35G35K74OG@gmail.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Shaoqin Huang" <shahuang@redhat.com>, "Zhao
 Liu" <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-4-salil.mehta@huawei.com>
In-Reply-To: <20240607115649.214622-4-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jun 7, 2024 at 9:56 PM AEST, Salil Mehta wrote:
> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp containe=
r",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(sbd, &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>  }

Could the ACPI persistent presence ARM requires be a property of
the ACPI device?

Thanks,
Nick


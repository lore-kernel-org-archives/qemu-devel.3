Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E795C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXoD-0004D0-Bx; Mon, 26 May 2025 09:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJXo4-0003xM-4L
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJXo1-0000VF-85
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748265830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52ttX2PlP14rw8iM0ZOHMjqyQ17AkL3kgDdh+hMHi78=;
 b=LUnHStJWtIKyDjLRLT62yEnPvoOEqYzC2bXlw6u9AgDOIjEBudO0MpzW1QSBJ5v+vt/nhn
 hdrwp4nKkh4kGS1p3rGl3z3YgnOqBYvegLkPP4/e/H/Ro7Kurjlz+gI0E2T1IW9yVQz3Q3
 DPeXabQaseds/3OfojqbJlfV1dBPegQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-UYbJGk67P0aLglbq2G3QDQ-1; Mon, 26 May 2025 09:23:49 -0400
X-MC-Unique: UYbJGk67P0aLglbq2G3QDQ-1
X-Mimecast-MFC-AGG-ID: UYbJGk67P0aLglbq2G3QDQ_1748265828
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so10873615e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748265828; x=1748870628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52ttX2PlP14rw8iM0ZOHMjqyQ17AkL3kgDdh+hMHi78=;
 b=sajJgt0xcLek6kMpn+Rup23kPKURXghZygS9eMEIqiwDwx2m1hmrS7y4urLhgIzE94
 pFdxzWcoY7d5p0UT4Z51gBocdXr15MdqFw29kGRj9PosQjX7MZnYQNEXTQhFqeH8gmGJ
 7W04QemKY0XLRBMzfJjXAx6tPYChEhUc0F+XDzrigCJNli5PJdgIgw+CmseDtlJIeASL
 4SNoQM6ium6/Gu8XP4aGZhMHq4pFKdsCDUQJHzgls6qbcg4MwTAVwJABmvBGL1b4I0NU
 OBd+ldneVgLg37G6YF2+zaTXb23/4eRuD3mfQJX92lkIqzil5qwIiS4OA77Dit0qPfZo
 0hIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb7qu8ibcQ4S+qgqGUXm1h9brbDa8TDw2KPjx6ypHMgH4oh53laKFnzzfSuTB2HJjUxe1LcXlU8J7B@nongnu.org
X-Gm-Message-State: AOJu0YzXpcCdGjotqnMpH86XhxTcsFYNy1yA5or/rocC8a9B/1AmPf8E
 G4Qko/kTkWnzuCCpugnWNhdX0Ci4J75zhnoAa67IHAqhrst8SQJxKj+sdZgXbO5TmDzPJapqBma
 dXBz/RoqxUA37qCjrv1MPs9jC/Sbm7hoTG2AIev5oB2xM3PHBY6jL7+Nm
X-Gm-Gg: ASbGncucio6bMOSBAjfY8sGH8I7OCTJBMvHAMszAO6kUSH2bRqonqsHWL73S4ui56Ig
 GMCmROn6FmJX3sk4melE/jwv2/cJnGf1cJcyCpSKdwZQx35Ce4Rq7T6rcPEYqBLJn3NptaCyM9D
 h/j1HkLwq8XAFJXKDbRsEZYr/MSpW+ivwTNFWEjsVj6Fat8qIAYrf8rxYSTFMTyMNGgKIDVw5Vb
 aJiD7wFHM8Y3P19IZGeA4+eytnA2xI/neyovBKuA4f49/V/ryk78jd7ZgiouU7JNFRG7pExnT6B
 EyJJ9UMsL7oMtPbg6pS5BkBqMIdYr8vPTQra7iDRZ66J2i4pyWp4U5pIyEc=
X-Received: by 2002:a05:600c:5605:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-44c91dcc11fmr62152125e9.18.1748265828161; 
 Mon, 26 May 2025 06:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN/goh4iRXis+Yqmt8rhy6FkufdFGJBUTkYRV2xYUbpwwBakYDY5rupjMAS7HFv7ZHUMPJCQ==
X-Received: by 2002:a05:600c:5605:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-44c91dcc11fmr62151885e9.18.1748265827703; 
 Mon, 26 May 2025 06:23:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142f1sm236841685e9.31.2025.05.26.06.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 06:23:46 -0700 (PDT)
Message-ID: <a6cbf985-4bea-40ff-b12c-8f459249f570@redhat.com>
Date: Mon, 26 May 2025 15:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-3-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250526053123.1434204-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/26/25 7:31 AM, Gustavo Romero wrote:
> ACPI PCI hotplug is now turned on by default so we need to change the
> existing tests to keep it off. However, even setting the ACPI PCI
> hotplug off in the existing tests, there will be changes in the ACPI
> tables because the _OSC method was modified, hence in the next patch of
> this series the blobs are updated accordingly.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/qtest/bios-tables-test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec435..216941dbb5 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>      };
>  
>      data.variant = ".memhp";
> -    test_acpi_one(" -machine nvdimm=on"
> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>                    " -cpu cortex-a57"
>                    " -m 256M,slots=3,maxmem=1G"
>                    " -object memory-backend-ram,id=ram0,size=128M"
> @@ -1775,7 +1775,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>       * to solve the conflicts.
>       */
>      data.variant = ".pxb";
> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> +    test_acpi_one(" -machine acpi-pcihp=off"
> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>                    " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>                    " -drive file="
>                    "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> @@ -1846,7 +1847,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  
>      data.variant = ".acpihmatvirt";
>  
> -    test_acpi_one(" -machine hmat=on"
> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>                    " -cpu cortex-a57"
>                    " -smp 4,sockets=2"
>                    " -m 384M"
> @@ -2123,6 +2124,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>      data.smbios_cpu_max_speed = 2900;
>      data.smbios_cpu_curr_speed = 2700;
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>      free_test_data(&data);
>  }
> @@ -2142,6 +2144,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>      free_test_data(&data);
>  }
> @@ -2227,6 +2230,7 @@ static void test_acpi_aarch64_virt_viot(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-device virtio-iommu-pci", &data);
>      free_test_data(&data);
I think this is also meaningful that this gets inserted in the ACPI PCI
hotplug series before it acpi pci hp becomes the new default (of course
if you agree on that)

Cheers

Eric
>  }



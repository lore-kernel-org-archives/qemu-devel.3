Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18619C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 11:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1l7E-00074p-MJ; Mon, 07 Apr 2025 07:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1l7A-00073z-Pw
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1l77-0004wM-GT
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 07:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744027079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfCd/rfuyo4t21RXrxy75FbjT51rAw+UXob9nloqexM=;
 b=WPae3E6nKFeYYKwBoBbVBg1SHqET2bNo4PrGMJlfOH5nmYjCmmmnEmXTlohevnfJAXgNSF
 76+vbB/QrTPcSWAjUiyCx18OG+BwJf6gVRHlOKMHcmphv3fGasucXp3f0qSV8FKurOq725
 i6q9N/0TKZZirlqX+XpTrfh7TPh32bQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-bw7jsJPcN7eX6NTEg-IVUA-1; Mon, 07 Apr 2025 07:57:58 -0400
X-MC-Unique: bw7jsJPcN7eX6NTEg-IVUA-1
X-Mimecast-MFC-AGG-ID: bw7jsJPcN7eX6NTEg-IVUA_1744027077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso54033255e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 04:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744027077; x=1744631877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfCd/rfuyo4t21RXrxy75FbjT51rAw+UXob9nloqexM=;
 b=PwVqujkShsNpNqlgXXFaYRDIs5/nuJL3aU3xZO3g//LWGVLuSmf/pigKbqdwTg/JHG
 KeIKU9zOv6EBLLwRzBNZWHL33A3na0qYTviX3OZVsvfsfGqgPv+50SUsqdb0uIGGB/Pc
 FVnf0fd15fHjlfnR2Nx0gKiR+/T5ufMJguk2BegMy0+9uxaWMdDMl7mRf29NmuU6BtzI
 j+1BztqFjEgODVeZ20av5u6PIlyEPdNuRPxbSonmdD/yiqz1nBF+NzF5zpxpTgYr2u7W
 gr1jz1PzSFmGOD5F3C1eENchjfdASbnJhXNMNF07WCajW648YZt6+/FNxmztMamT6zgj
 AU2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV34il8pocU76h93fvk3FLYF1y/MS5xM2YxsQWEsdJAZ8ULqNXcoxixuYyXkw6jtCBQSfEbLB5lWKYn@nongnu.org
X-Gm-Message-State: AOJu0YwpvxdIOveqPrKi+Nn50nC9fcBACqnwv8SWxf6i0XAhJETYXqT0
 KXqxpHPPZevrypC4vXEhT9rp/0OAWd6AcRHtP6BstMcGm+8nHU78BK8ZDxjrIz/qCWhzOegBkJz
 WPTroYvRiw86ISqs84jz1CS0CXk+nPas7gvGV3DowalptF1BEaQtZ
X-Gm-Gg: ASbGncuFjG4OROBd4YTNxEz9WWSe2ObGB1C+0D4yp1iTR0N5Ya90ULqY7+kX6JBdFJg
 hUuG91dMfqScEqpsAiZA7arv3BHaTpsYxOaJsl15cAJrgI2n82dpQUkAPiTmvu2T4jYTAEzb6qs
 WeF4Kt7ZavQtDrFYKix1sqaZ1U1VQF+TfjYoAh9W9NxjfaYPHdy10JkvXrYOC97uEtglR4XehlG
 VTl7M1rD4szTmgnnNFKhZOTxzhshTt/OFYrQixkgQa4pvIZFMOpm44RVqhjMXyXDlOnlwYY1c7I
 Scy2f/fPccOCECMdXfmnqCQXqOPonVPQcdurTiZk7Q8ujccUE/7YQ27iIC/P/94=
X-Received: by 2002:a05:600c:35c2:b0:43d:2313:7b54 with SMTP id
 5b1f17b1804b1-43ed0b48208mr102185485e9.3.1744027076790; 
 Mon, 07 Apr 2025 04:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbOsSmyK6AREb+gv1wmSe0LWAx1G2wdm+v/1ylXSGgQD1rBcHEJ8XETs5diyCpdVBU+fjh6w==
X-Received: by 2002:a05:600c:35c2:b0:43d:2313:7b54 with SMTP id
 5b1f17b1804b1-43ed0b48208mr102185295e9.3.1744027076455; 
 Mon, 07 Apr 2025 04:57:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36699e0sm128003355e9.35.2025.04.07.04.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 04:57:55 -0700 (PDT)
Message-ID: <8dec4e22-4a7f-4016-83c4-e39eba4203a2@redhat.com>
Date: Mon, 7 Apr 2025 13:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 2/9] hw/intc/gicv3_its: Do not check
 its_class_name() for NULL
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-3-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250403204029.47958-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/3/25 10:40 PM, Philippe Mathieu-Daudé wrote:
> Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"),
> its_class_name() single implementation doesn't return NULL
> anymore. Update the prototype docstring, and remove the
> pointless checks.
>
> Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/intc/arm_gicv3_its_common.h | 2 +-
>  hw/arm/virt-acpi-build.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
> index 7dc712b38d2..3c7b543b018 100644
> --- a/include/hw/intc/arm_gicv3_its_common.h
> +++ b/include/hw/intc/arm_gicv3_its_common.h
> @@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
>   * Return the ITS class name to use depending on whether KVM acceleration
>   * and KVM CAP_SIGNAL_MSI are supported
>   *
> - * Returns: class name to use or NULL
> + * Returns: class name to use
>   */
>  const char *its_class_name(void);
>  
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e1786..9b7fc99f170 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -741,7 +741,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                            memmap[VIRT_HIGH_GIC_REDIST2].size);
>          }
>  
> -        if (its_class_name() && !vmc->no_its) {
> +        if (!vmc->no_its) {
>              /*
>               * ACPI spec, Revision 6.0 Errata A
>               * (original 6.0 definition has invalid Length)
> @@ -973,7 +973,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                            vms->oem_table_id);
>      }
>  
> -    if (its_class_name() && !vmc->no_its) {
> +    if (!vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_iort(tables_blob, tables->linker, vms);
>      }



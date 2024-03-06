Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CDDC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhu48-0004DE-QX; Wed, 06 Mar 2024 11:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhu47-00044A-D6
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhu45-000516-Ln
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709742260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AeZZRlg1U/vwkr/sKYo3DPV+nCx3HdNirL3eM+WCUy4=;
 b=CvfCSJPJvgqSQC7N5BPPrYOEX70l46Ja3lHuq65agniIYzQTROF/bdMKRouKNV3ecvkGj3
 BsxHlzO22eKg6ZzA8BEGwaQF5Uhk8fggc14o3sssY9Sy1cHTwBpj7K21+qXSlWTTKuUDuV
 DjQBSNzCi290Wnvp0BCrfQ/ulhwppYw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-DWo2zj9vNXyw4Mk97bnCsA-1; Wed, 06 Mar 2024 11:24:18 -0500
X-MC-Unique: DWo2zj9vNXyw4Mk97bnCsA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso565394866b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742258; x=1710347058;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AeZZRlg1U/vwkr/sKYo3DPV+nCx3HdNirL3eM+WCUy4=;
 b=b07UW2af1sTJeWv8DYCLH2/OCdwQzWsozktKIpzX8ipSgh+jmS721dG8BeFGYeCK9p
 u7hq8RWg8eueZGSKLHKuNbQoSJ+v3uMsvN//JiaQFG/J8+1dbyPUF7UYJEzcwAZHHqpp
 eXB5NOYXap9AZhWyF23JcWOaY1HuJXbVm3Jeec+tw7wNBEAmyPAlrmsqJ4PoVyXdAyR1
 Aky+ahNKhpU3kr18iyKialfmFcVDdadaxoe+aqkNi/Bmx8IXkrAkvRTR2zwSzyyIhcnC
 xksnSA/EzaolpmcFo14ag/ktdkUJV9l6+kVGlvYuRM3Xt8bUg9oHzR8w9tekV+Gq+thA
 oJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfr5B+KBl1jwwc971QUrJDnavo+8hKmwaGxpdZ+V9OSaoXuH+/zfcQm9ZA3ublP6AIEoHGU+rrvdZQG4KIHL3TTgyiR3w=
X-Gm-Message-State: AOJu0YwMJePnHh6djp1wxu30qjtgqSB7h2loeUAMjQYNhN2zs9endqCB
 j7SfMX9y5N8/Agd1QoYaulL1gOGkpK0DoqpRK4dionghakQPYnZ2xfRu2jLzns6bWzKlE96RIht
 uNf9ZJpCywRTSW0dAkeQ5fsQoc4niQj+Pl+KZlRhgazIZVQfO3Pgq
X-Received: by 2002:a17:906:57d4:b0:a45:a2cc:eb8b with SMTP id
 u20-20020a17090657d400b00a45a2cceb8bmr4147726ejr.13.1709742257701; 
 Wed, 06 Mar 2024 08:24:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXVo8ajrCuPeqNatq8PDMHBz0IDnfV09zuPdbYX2YloKtOMpJrQxcUJe0gjqzzlzgV7knvXw==
X-Received: by 2002:a17:906:57d4:b0:a45:a2cc:eb8b with SMTP id
 u20-20020a17090657d400b00a45a2cceb8bmr4147700ejr.13.1709742257233; 
 Wed, 06 Mar 2024 08:24:17 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170906194a00b00a43491ff7e4sm7245309eje.111.2024.03.06.08.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:24:16 -0800 (PST)
Message-ID: <2e68cd45-0ef3-4835-a5c7-98f5c4210e4d@redhat.com>
Date: Wed, 6 Mar 2024 17:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 05/18] hw/i386/acpi: Remove
 PCMachineClass::legacy_acpi_table_size
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20240305134221.30924-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
> PCMachineClass::legacy_acpi_table_size was only used by the
> pc-i440fx-2.0 machine, which got removed. Remove it and simplify
> acpi_build().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h |  1 -
>   hw/i386/acpi-build.c | 60 +++++++++-----------------------------------
>   2 files changed, 12 insertions(+), 49 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 3360ca2307..758d670a36 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -103,7 +103,6 @@ struct PCMachineClass {
>       /* ACPI compat: */
>       bool has_acpi_build;
>       bool rsdp_in_ram;
> -    int legacy_acpi_table_size;
>       unsigned acpi_data_size;
>       int pci_root_uid;
>   
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 15242b9096..8c7fad92e9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2496,13 +2496,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       X86MachineState *x86ms = X86_MACHINE(machine);
>       DeviceState *iommu = pcms->iommu;
>       GArray *table_offsets;
> -    unsigned facs, dsdt, rsdt, fadt;
> +    unsigned facs, dsdt, rsdt;
>       AcpiPmInfo pm;
>       AcpiMiscInfo misc;
>       AcpiMcfgInfo mcfg;
>       Range pci_hole = {}, pci_hole64 = {};
>       uint8_t *u;
> -    size_t aml_len = 0;
>       GArray *tables_blob = tables->table_data;
>       AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
>       Object *vmgenid_dev;
> @@ -2548,19 +2547,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       build_dsdt(tables_blob, tables->linker, &pm, &misc,
>                  &pci_hole, &pci_hole64, machine);
>   
> -    /* Count the size of the DSDT and SSDT, we will need it for legacy
> -     * sizing of ACPI tables.
> -     */
> -    aml_len += tables_blob->len - dsdt;
> -
>       /* ACPI tables pointed to by RSDT */
> -    fadt = tables_blob->len;
>       acpi_add_table(table_offsets, tables_blob);
>       pm.fadt.facs_tbl_offset = &facs;
>       pm.fadt.dsdt_tbl_offset = &dsdt;
>       pm.fadt.xdsdt_tbl_offset = &dsdt;
>       build_fadt(tables_blob, tables->linker, &pm.fadt, oem_id, oem_table_id);
> -    aml_len += tables_blob->len - fadt;
>   
>       acpi_add_table(table_offsets, tables_blob);
>       acpi_build_madt(tables_blob, tables->linker, x86ms,
> @@ -2691,49 +2683,21 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>        * too simple to be enough.  4k turned out to be too small an
>        * alignment very soon, and in fact it is almost impossible to
>        * keep the table size stable for all (max_cpus, max_memory_slots)
> -     * combinations.  So the table size is always 64k for pc-i440fx-2.1
> -     * and we give an error if the table grows beyond that limit.
> -     *
> -     * We still have the problem of migrating from "-M pc-i440fx-2.0".  For
> -     * that, we exploit the fact that QEMU 2.1 generates _smaller_ tables
> -     * than 2.0 and we can always pad the smaller tables with zeros.  We can
> -     * then use the exact size of the 2.0 tables.
> +     * combinations.
>        *
>        * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.

I think you could remove this "All this is for ..." sentence now, too?

  Thomas


>        */
> -    if (pcmc->legacy_acpi_table_size) {
> -        /* Subtracting aml_len gives the size of fixed tables.  Then add the
> -         * size of the PIIX4 DSDT/SSDT in QEMU 2.0.
> -         */
> -        int legacy_aml_len =
> -            pcmc->legacy_acpi_table_size +
> -            ACPI_BUILD_LEGACY_CPU_AML_SIZE * x86ms->apic_id_limit;
> -        int legacy_table_size =
> -            ROUND_UP(tables_blob->len - aml_len + legacy_aml_len,
> -                     ACPI_BUILD_ALIGN_SIZE);
> -        if ((tables_blob->len > legacy_table_size) &&
> -            !pcmc->resizable_acpi_blob) {
> -            /* Should happen only with PCI bridges and -M pc-i440fx-2.0.  */
> -            warn_report("ACPI table size %u exceeds %d bytes,"
> -                        " migration may not work",
> -                        tables_blob->len, legacy_table_size);
> -            error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.\n");
> -        }
> -        g_array_set_size(tables_blob, legacy_table_size);
> -    } else {
> -        /* Make sure we have a buffer in case we need to resize the tables. */
> -        if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> -            !pcmc->resizable_acpi_blob) {
> -            /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
> -            warn_report("ACPI table size %u exceeds %d bytes,"
> -                        " migration may not work",
> -                        tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> -            error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                         " or PCI bridges.\n");
> -        }
> -        acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
> +    /* Make sure we have a buffer in case we need to resize the tables. */
> +    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> +        !pcmc->resizable_acpi_blob) {
> +        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
> +        warn_report("ACPI table size %u exceeds %d bytes,"
> +                    " migration may not work",
> +                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> +        error_printf("Try removing CPUs, NUMA nodes, memory slots"
> +                     " or PCI bridges.\n");
>       }
> +    acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
>   
>       acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
>   



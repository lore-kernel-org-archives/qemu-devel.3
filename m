Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FB7C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKWz-0002ig-U7; Wed, 11 Jun 2025 08:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKWv-0002c2-O9
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKWs-0008VQ-EO
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749644764;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mwzh7faMG7zQ0TsEOvtyyX6YaFnGx7PDRU43RXr67pk=;
 b=jJ8N0C7SQbemz24geT2AQd1JyprWyAhtQI01AZRrLQiZ3G+O/mDUyPUK+MGx09ZYYA2InM
 JEeXhykFXae2bgjmjm0kJ7uZvwxk87r6NT6DoTEww4PwXHZdhs15iLEwj4SErlt1g4qsSR
 wmVQPcBI8p5+ffcFvrqSGfNbZNgw2Pg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-cmkCVqdsPTqvrQOufbUJdw-1; Wed, 11 Jun 2025 08:26:02 -0400
X-MC-Unique: cmkCVqdsPTqvrQOufbUJdw-1
X-Mimecast-MFC-AGG-ID: cmkCVqdsPTqvrQOufbUJdw_1749644762
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so45270225e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749644761; x=1750249561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mwzh7faMG7zQ0TsEOvtyyX6YaFnGx7PDRU43RXr67pk=;
 b=DADCtw3G4r78rr05g1GlJ16ItMbTteQVVqIMav/Llx+K385Hb+TJilgWDE7yFyaUoo
 T1CQb9wr8KSFS02ImHxfGeESUtTDXV9UKhP7b06AzYq0F6rA5a9dwNrDsUop8eBkgGT+
 EoKw35mxbXFACmUBQuF9koUuXr/hgq7jLiJBx7V2CIccfjn9cEf8uRIELYjDRRzrBGrZ
 hWHz1sZjoPJBieM/F9BwrZ2+nz/0R7r1i9dvQkx21bX0Qz7r1uLGgMCEjRUezTZly0SK
 9zu8wPnpU5yYwx9mUqnIt+N0u5EzuLh/z17YuWwn0l9huqmB2gfRyJQEdCLnYjMECmDl
 VVTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIxy4nkTXJvAMKCtkkeip7ZqbPkIqt8hmSlpCFajulXAGEUGqzzAbfhc4r9SjE44JveF1c2ZPrpIYU@nongnu.org
X-Gm-Message-State: AOJu0YwLMmPsyvS7KyHVVLOxlyLRWqUQ6Qde9gl1z/3Guitdzt0zny3n
 x9vLqNaHNxBXdW11sQtwj8Kfmc0Hq26HAMf2wojXjmvUYDGDe76zsmCvQcaW0GkW7aeU9Sh9JzI
 BrB59HQHTcONaYzsFCIYx21nlTld98Ttiqk7sMKJjdWKNLXB8gkEaUFlk
X-Gm-Gg: ASbGncvcScilYvHQ+rKmi4nrOhxVraGuGOHMj7aIatYW2+RZXhgdtZFVwJEuiOBh1hZ
 YUcemoer7R6ekvYfTa50cWC9WtsvY2AtAiPjvM1KP68hTxVcKuERHDn1POvfHhpKrDqNhbl0e6i
 muYbs2JfSsMBmQeQcYc1Xown1y+mhLIm0w9W2/Ok/uLuSm7k5cYtwuIGpjpBZiR/yqVph5I4t2g
 7DwmoTDgLQ3w69Lpv4vCT+ixLrUKtO4R639x93GPZN17VtKrGisOT5KHKwPz7Ly+dhF/IhVkjLb
 uS8QtJWwz5fnOMJoVyT5B8guZg4of8/Ge/n3M9pH8SWSV5vdl2mpbLNdc6KJqBsD9HX47A==
X-Received: by 2002:a05:600c:c8a:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4532487a36cmr29459045e9.4.1749644761495; 
 Wed, 11 Jun 2025 05:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL160mk6CsnVfWy5nijPGd0Q6xhqPbvq/7sYnH6Gq2ZIpFEyxpiSwH/6wU2Hz8K8KytXZrww==
X-Received: by 2002:a05:600c:c8a:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4532487a36cmr29458585e9.4.1749644761010; 
 Wed, 11 Jun 2025 05:26:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532518ac9asm19629335e9.23.2025.06.11.05.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 05:26:00 -0700 (PDT)
Message-ID: <38b4d37f-e70c-4494-96ee-02fe97aec4fd@redhat.com>
Date: Wed, 11 Jun 2025 14:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-10-eric.auger@redhat.com>
 <20250530110505.00007430@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530110505.00007430@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 5/30/25 12:05 PM, Jonathan Cameron wrote:
> On Tue, 27 May 2025 09:40:11 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> gpex build_host_bridge_osc() and x86 originated
>> build_pci_host_bridge_osc_method() are mostly identical.
>>
>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
>> is same as Local0.
>>
>> So let gpex code reuse build_pci_host_bridge_osc_method()
>> and remove build_host_bridge_osc().
>>
>> The disassembled DSDT difference is given below:
>>
>>   * Original Table Header:
>>   *     Signature        "DSDT"
>> - *     Length           0x00001A4F (6735)
>> + *     Length           0x00001A35 (6709)
>>   *     Revision         0x02
>> - *     Checksum         0xBF
>> + *     Checksum         0xDD
>>   *     OEM ID           "BOCHS "
>>   *     OEM Table ID     "BXPC    "
>>   *     OEM Revision     0x00000001 (1)
>> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>>                  {
>>                      CreateDWordField (Arg3, 0x04, CDW2)
>>                      CreateDWordField (Arg3, 0x08, CDW3)
>> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
>> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> -                    CTRL &= 0x1F
>> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> +                    Local0 &= 0x1F
>>                      If ((Arg1 != One))
>>                      {
>>                          CDW1 |= 0x08
>>                      }
>>
>> -                    If ((CDW3 != CTRL))
>> +                    If ((CDW3 != Local0))
>>                      {
>>                          CDW1 |= 0x10
>>                      }
>>
>> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
>> -                    Return (Arg3)
>> +                    CDW3 = Local0
>>                  }
>>                  Else
>>                  {
>>                      CDW1 |= 0x04
>> -                    Return (Arg3)
>>                  }
>> +
>> +                Return (Arg3)
>>              }
>>
>>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - move in the dsdt.dsl diff in the commit message and remove useless
>>   info (Gustavi, Michael)
>> ---
>>  hw/pci-host/gpex-acpi.c | 60 +++--------------------------------------
>>  1 file changed, 4 insertions(+), 56 deletions(-)
>>
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index f1ab30f3d5..98c9868c3f 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -50,60 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>>      }
>>  }
>>  
>> -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>> -{
>> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>> -
>> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>> -    aml_append(method,
>> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>> -
>> -    /* PCI Firmware Specification 3.0
>> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
>> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
>> -     * identified by the Universal Unique IDentifier (UUID)
>> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
>> -     */
>> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
>> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>> -    aml_append(ifctx,
>> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
>> -    aml_append(ifctx,
>> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>> -
>> -    /*
>> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
>> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
>> -     */
>> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
>> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
>> -               aml_name("CTRL")));
>> -
>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>> -                              aml_name("CDW1")));
>> -    aml_append(ifctx, ifctx1);
>> -
>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>> -                              aml_name("CDW1")));
>> -    aml_append(ifctx, ifctx1);
>> -
>> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
>> -    aml_append(ifctx, aml_return(aml_arg(3)));
>> -    aml_append(method, ifctx);
>> -
>> -    elsectx = aml_else();
>> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>> -                               aml_name("CDW1")));
>> -    aml_append(elsectx, aml_return(aml_arg(3)));
>> -    aml_append(method, elsectx);
>> -    return method;
>> -}
>> -
>> -static Aml *build_host_bridge_dsm(void)
>> +static Aml *build_pci_host_bridge_dsm_method(void)
>>  {
>>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>>      Aml *UUID, *ifctx, *ifctx1, *buf;
>> @@ -134,8 +81,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
>>      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>>      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> This is where they become unused I think...

Indeed.

This means that I need to regenerate the reference blobs accordingly
(for Gustavo's awarness).

Eric
>
>>      /* Declare an _OSC (OS Control Handoff) method */
>> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
>> -    aml_append(dev, build_host_bridge_dsm());
>> +    aml_append(dev,
>> +               build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
>> +    aml_append(dev, build_pci_host_bridge_dsm_method());
>>  }
>>  
>>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)



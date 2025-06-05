Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F812C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNE3U-0000te-OQ; Thu, 05 Jun 2025 13:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uNE3P-0000t8-Pc
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uNE3M-0001lW-KL
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 13:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749143215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s15N0T4/xnYnO7RKr5aWAWdsH88cqDAnX2oSjGhvUi0=;
 b=eK22pm8k3S6/sW20f9q5kIXeOiPvkYLWC1QQYT7B/e0ocmQeeXhbJlKiKzMuBDhvlLsP4K
 Srwi7uahJYVTRQ61NcnLGDrFSX3ykAsFIHIeaqz2DlDylCBBrvVrt13SSMXN03dxaTnQdq
 wbpAJT9H7go0ujL8vxL9nGUkOWhrFlQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-WRc3i1CTOBa93oUx4Hs8Lw-1; Thu, 05 Jun 2025 13:06:52 -0400
X-MC-Unique: WRc3i1CTOBa93oUx4Hs8Lw-1
X-Mimecast-MFC-AGG-ID: WRc3i1CTOBa93oUx4Hs8Lw_1749143210
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso819864f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 10:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749143210; x=1749748010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s15N0T4/xnYnO7RKr5aWAWdsH88cqDAnX2oSjGhvUi0=;
 b=KJeDuTmZschJwNvU3UWD7pv/co01oC2BK+aAVbMY7bQW2SC/E8Yk9jUWmGm//LIXPA
 jWZ0BcLCljf+oGWDrj9W+KULJAaJZ50VaR/s/YdbkZtu/us0K2PDRD7svl+FLT5ZAArI
 3emXBfDUR/RR3yzPyF5EFVqfhrSKvO1P/xK4s4dHUOoSLSxTeLW2crvUbHhi0i2ZRQYt
 e0JkiuZsuBhN3pI1kiWNcr9uLHf7lsQmJBhlxDIxJ6b8Ybs0y3AuKiG+Y4rljys6GJpX
 FldgQcMEJlyYucYrjgxFz5guk7Cm0+3XmQ3amR5IvGohXrrkf8WNK9Jun6EkoQd/mpQ/
 Tb6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtqs5HKjtVr26jR3DMZ+2Nu7vlG3SywclMFHgM/L5b2lNBJIkqlMU9jAtEks8aNEos8k0OKcvvJh/n@nongnu.org
X-Gm-Message-State: AOJu0Yx9vcnPCImgDCW7UBHgrxsUzKu//gMAMsNdwWrvrxLl90w8r6YM
 ES2aB7B9D5yf3chz7ns/FeOG0voSQc/v4xFWeE/39Cc626Y3JLvrs+FjPuQC0xLLRCtArIgKmlh
 ElzA0145rg/eUynGEWj/jd8sOvI8gj/zhhuEwIZgbUQT1hAETt5GIxE2E
X-Gm-Gg: ASbGnctb9fhEu2HM/QPo33bW27DWWbigZaadb7898lca1kwsXzNNf8HYn34sVvwm/nc
 MLx9xfIoUhzEW4sHmCgoS2dTqOI+G9psWmtL5tkD/7EByNrPBI5ZuyzaLRkWMieipppuSyqQU9v
 TUj6WggzLbWTc6E8FsrKxfQ4qYa2rm/zXT+Sfy8uFoqmdwClEhIddHqA/+arwJQD64gRHIq3Tdt
 Olnpg0wdUAZIxHKujoAoYtCpGjTw/LTfrEJdY1fqFCgyuTbpB4EnePvRcZQqJ667R7uOZzu8Udi
 gwGFNyz2h5nMfCq1H+MCthEDJPpFQEQYAEB+K3wUElw66bMfTrfJyE5Rbus=
X-Received: by 2002:a5d:5f51:0:b0:3a4:e667:9242 with SMTP id
 ffacd0b85a97d-3a51d8f60famr7209317f8f.3.1749143209720; 
 Thu, 05 Jun 2025 10:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE18Cic9dlXErikMrRIYjk6Jf/utDhUA0fzFvmn7s3YNyPtrjgWUmTgeXSL7FcFfoyOdpdRdw==
X-Received: by 2002:a5d:5f51:0:b0:3a4:e667:9242 with SMTP id
 ffacd0b85a97d-3a51d8f60famr7209248f8f.3.1749143209095; 
 Thu, 05 Jun 2025 10:06:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f9816ccfsm31408505e9.15.2025.06.05.10.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 10:06:47 -0700 (PDT)
Message-ID: <7033bbc1-2f65-4cf6-a64d-df0bace9a555@redhat.com>
Date: Thu, 5 Jun 2025 19:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/25] hw/i386/acpi-build: Introduce
 build_append_pcihp_resources() helper
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-12-eric.auger@redhat.com>
 <20250530111719.00005714@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530111719.00005714@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

Hi Jonathan,

On 5/30/25 12:17 PM, Jonathan Cameron wrote:
> On Tue, 27 May 2025 09:40:13 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Extract the code that reserves resources for ACPI PCI hotplug
>> into a new helper named build_append_pcihp_resources() and
>> move it to pcihp.c. We will reuse it on ARM.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Trivial comment inline.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> ---
>>  include/hw/acpi/pcihp.h |  2 ++
>>  hw/acpi/pcihp.c         | 20 ++++++++++++++++++++
>>  hw/i386/acpi-build.c    | 15 ++-------------
>>  3 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>> index 971451e8ea..8a46a414cc 100644
>> --- a/include/hw/acpi/pcihp.h
>> +++ b/include/hw/acpi/pcihp.h
>> @@ -75,6 +75,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>  
>>  void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
>>  void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
>> +void build_append_pcihp_resources(Aml *table,
>> +                                  uint64_t io_addr, uint64_t io_len);
>>  
>>  /* Called on reset */
>>  void acpi_pcihp_reset(AcpiPciHpState *s);
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index e0260f67e6..fb54c31f77 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -685,6 +685,26 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>>      aml_append(table, scope);
>>  }
>>  
>> +/* Reserve PCIHP resources */
>> +void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
>> +                                  uint64_t io_addr, uint64_t io_len)
>> +{
>> +    Aml *dev, *crs;
>> +
>> +    dev = aml_device("PHPR");
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
>> +    aml_append(dev,
>> +               aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
>> +    /* device present, functioning, decoding, not shown in UI */
>> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
>> +    crs = aml_resource_template();
>> +    aml_append(crs,
>> +        aml_io(AML_DECODE16, io_addr, io_addr, 1, io_len)
>> +    );
> Trivial but this doesn't match local style.  It is even inconsistent with
> the _UID line above.
>> +    aml_append(crs,
>> +               aml_io(AML_DECODE16, io_addr, io_addr, 1, io_len));
> maybe?

definivitely. Will be fixed in next version

Thanks!

Eric
>
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +    aml_append(scope, dev);
>> +}
>> +
>>  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>      .name = "acpi_pcihp_pci_status",
>>      .version_id = 1,
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 91945f716c..52cef834ed 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1432,19 +1432,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>  
>>      /* reserve PCIHP resources */
>>      if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>> -        dev = aml_device("PHPR");
>> -        aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
>> -        aml_append(dev,
>> -            aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
>> -        /* device present, functioning, decoding, not shown in UI */
>> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
>> -        crs = aml_resource_template();
>> -        aml_append(crs,
>> -            aml_io(AML_DECODE16, pm->pcihp_io_base, pm->pcihp_io_base, 1,
>> -                   pm->pcihp_io_len)
>> -        );
>> -        aml_append(dev, aml_name_decl("_CRS", crs));
>> -        aml_append(scope, dev);
>> +        build_append_pcihp_resources(scope,
>> +                                      pm->pcihp_io_base, pm->pcihp_io_len);
>>      }
>>      aml_append(dsdt, scope);
>>  



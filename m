Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781E9D2F011
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkj2u-0000w7-C5; Tue, 27 Jan 2026 08:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkj2k-0000s2-Tu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vkj2i-0005vx-5F
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769520218;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inL7IgFEA5miArJVDHdrdgZLnWIEE2zg4a0hQzkzyfg=;
 b=AE+4s1hYyYKZyTQX4sBwaZsM/92bryelEdqb/HOmx2ktluKGGDdNiRdHw4xv4081u2MbPJ
 dsjSOJOrlKQwSO4rsw0RRp6uePirL1R5xQfhJBOMpuyaJGs2Hgd9ijyw2hPZ0aglVGQbHA
 pLEI4cRxS4sewQBh/T55YayUmS2rkYk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-7TIgwm6HOP-ETbA57rphWw-1; Tue, 27 Jan 2026 08:23:37 -0500
X-MC-Unique: 7TIgwm6HOP-ETbA57rphWw-1
X-Mimecast-MFC-AGG-ID: 7TIgwm6HOP-ETbA57rphWw_1769520216
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801e9e7159so45534905e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769520216; x=1770125016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inL7IgFEA5miArJVDHdrdgZLnWIEE2zg4a0hQzkzyfg=;
 b=Zdfh3UUtlkEbmcsqnoFzhSjclWMVZSHN7MyCo4iOP+UVrfr/O6WlK7rDnfOHlGCE0G
 T0CP9j5/YFEbb4BdA19hCfssHRFKENt2cEibc+2GPhm6P0woR2akx8jllhbiyStEC0Fo
 xQZ4aABINw1ULh8oPF4S6grFceXhYJJs30NWbLmipqqIGZP5F6QUQspz0Fchk6UhixSc
 sPmlmTGnG9w4fd/WtbHDRku8LHA57tgpthMzaikREoe3STakuKR+0kW+ORMs1ZnZi2W3
 gfh2B1zmB8WyZR54rNqnLtWsAn9F/LyvuJ/wBIeAN8iTwaMDpW1MxQhwwpunSiX78WEt
 hcfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHxiXVFS0vs+GPwOd3+EpzyeM+LZBpMET2/MWqSLcWoE+SVFb5Ccs6jroAyro9vMDh90/k85KdogOr@nongnu.org
X-Gm-Message-State: AOJu0YxeTmRXAgUJBTHF5AOlg8omizBnd6Yr7EpjclWx2S8SbIMftqBZ
 hOK07ROUTfVFC7b8EKMYuXDOTIbntxRbDmkCQgMNkJeoCnQx/ahvEdyBW97ahFFEY3D5vXZNWIH
 X13QBaUIt6gyYPff7Jc6EJX9fpj81yoLupU6liaCfP9hJF+V4Zv/LaG5H
X-Gm-Gg: AZuq6aJz1GavR1XRFyBXxzwBslNAmYGmaAA3Gbv6j4MuS/mNmZXxPaotYGXoTTCRTB4
 2D2Ay4SKgIIwvmHas9PRIJsUHxH6yhIxGa5big1d3fJG7NyHF9plXRUCqcDA4Xuxkkpbqe0TlDq
 Tlgf7IlrocLvU4DgPtHrRoJGVSca2PdFGLOcj9S5KQHt2FjxlUKJpCFEco9Oz6xlBXUNfqGf8MW
 6RVd5w02k0EtnpV4fT6NjzG4isugmqBD8qcsVRxKVNl3eZpmbKhPeXZvOk1OXpcpMWhP1DSJZPY
 AvPSpDRZSkihGuyyWFbMRggSvUo9AQaYdZcutmtMTo0Hv32yoT8xASeH93YxaSmimodMXUr8ZMv
 9u+O5nSnMRh6WygSK/OLTsS/zWrd+9A5ncfp10pkd52R5pi++B3RFZEDiIA==
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr16471975e9.36.1769520215696; 
 Tue, 27 Jan 2026 05:23:35 -0800 (PST)
X-Received: by 2002:a05:600c:e40b:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4806a5bef0fmr16471565e9.36.1769520215199; 
 Tue, 27 Jan 2026 05:23:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm63499945e9.12.2026.01.27.05.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 05:23:34 -0800 (PST)
Message-ID: <26e22c1c-09bc-4e6e-9859-bc8092b8ca7a@redhat.com>
Date: Tue, 27 Jan 2026 14:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/16] hw/arm/tegra241-cmdqv: Map VINTF Page0 into
 guest
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-7-skolothumtho@nvidia.com>
 <58f0ca59-b08c-44cd-b469-f152271c14f6@redhat.com>
 <aXgBD/N+aOVNlcGb@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aXgBD/N+aOVNlcGb@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Nicolin,

On 1/27/26 1:04 AM, Nicolin Chen wrote:
> On Mon, Jan 26, 2026 at 02:48:55PM +0100, Eric Auger wrote:
>
>>> +    name = g_strdup_printf("%s vcmdq", memory_region_name(&cmdqv->mmio_cmdqv));
>>> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vcmdq_page,
>>> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
>>> +                                      name, 0x10000, cmdqv->vcmdq_page0);
>>> +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv, 0x10000,
>>> +                                        &cmdqv->mmio_vcmdq_page, 1);
>>> +    g_free(name);
>>> +
>>> +    name = g_strdup_printf("%s vintf", memory_region_name(&cmdqv->mmio_cmdqv));
>>> +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page,
>>> +                                      memory_region_owner(&cmdqv->mmio_cmdqv),
>>> +                                      name, 0x10000, cmdqv->vcmdq_page0);
>> I don't get why we need/have 2 RAM devices pointing to the same @ptr
>> = cmdqv->vcmdq_page0. Is 0x10000 ~ VCMDQ_REG_PAGE_SIZE?
> The first one is for "vcmdq" and the second one is for "vintf".
> Explaining below...
>
>> The names of the MRs are quite confusing: If my understanding is correct
>> we have;
>>
>> cmdqv->mmio_cmdqv (0x50000 sized) which as the container for the 2 subregions.
>> Then within that one we have 2 subregions, one at offset 0x10000 (mmio_vcmdq_page
>> ), one at offset 0x30000 (cmdqv->mmio_vintf_page).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c?h=v6.19-rc7#n19
> It's defined in the kernel driver (yea, we should clarify in the
> QEMU code as well).
>
> So, the MMIO regions look like this:
>  1st 64 KB page -- Global CMDQV registers
>  2nd 64 KB page -- Global VCMDQ registers Page0 (mmap)
>  3rd 64 KB page -- Global VCMDQ registers Page1 (trap)
>  4th 64 KB page -- VINTF0 Logical VCMDQ registers Page0 (mmap)
>  5th 64 KB page -- VINTF0 Logical VCMDQ registers Page1 (trap)

This kind of layout representation is really helpful
>
> In real hardware, there will be 6th 64KB and beyond, for VINTF1
> and others. But, we're omitting here in QEMU as only VINTF0 will
> be supported -- kernel only exposes one VINTF per VM as well.
> (Yes, we should clarify this too.)
OK
>
>> I have difficulties to link that with the commit message
>>
>> "Tegra241 CMDQV assigns each VINTF a 128KB MMIO region split into two
>> 64 KB pages:
>>  - Page0: guest accessible control/status registers for all VCMDQs
>>  - Page1:configuration registers  ../.."
>> Those 2 pages, are they part of  mmio_vcmdq_page?
> Not exactly. Both the global VCMDQ region and VINTF region have
> their own pages (at 0x10000 and 0x30000).
>
> Here, it duplicates the mapping to 0x10000 (Global VCMDQ page0)
> and 0x30000 (VINTF0 page0) for simplification, because we only
> support VINTF0 in this case.
so Global VCMDQ registers Page0 and VINTF0 Logical VCMDQ registers Page0
are basically the same?

I would recommend to use cmdqv->mmio_vcmdq_page0 and
cmdqv->mmio_vintf_page0 to avoid any misunderstanding
>
> There is a little catch in this implementation. The real physical
> mapping between a global VCMDQ and a logical VCMDQ happens when
> QEMU calls HW_QUEUE ioctl. So, the mmap'd page0 doesn't have any
> real VCMDQ backing up the emulated VCMDQ. So, perhaps QEMU should
> trap the page0 and delay the memory_region_init_ram_device_ptr()
> until the HW_QUEUE ioctl is done?
might be safer indeed.
>
> There might be also a corner case: when the kernel exposes two
> physical VCMDQs, but the guest OS only uses one, i.e. QEMU only
> allocates one HW_QUEUE for VCMDQ0 but doesn't allocate VCMDQ1.
> In such a case, the VTINF0 page0 should be able to control the
> logical VCMDQ0 only, while the global page0 should control both.

you lost me. Need to look at the kernel or spec ;-)
>
> We are getting away this corner case with any guest OS running
> Linux kernel because it only accesses VTINF pages. But likely we
> should do something about it..
>
>> Then you talk about 0x30000 :VINTF register I guess this is the second cmdqv->mmio_vintf_page
>>
>> Well I am confused at this stage of the reading.
>>
>> Also without any spec, this is difficult to understand. Is there any public doc?
> It seems that Red Hat can get the doc under NDA..
OK thanks

Eric
>
> Thanks
> Nicolin
>



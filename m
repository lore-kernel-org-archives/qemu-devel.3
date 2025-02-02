Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCACC02192
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 16:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tecmW-0005z0-Cv; Sun, 02 Feb 2025 11:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tecmU-0005uu-DC
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:25:10 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tecmS-000486-8x
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 11:25:10 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so4560428a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738513506; x=1739118306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDGs3A5PbDb6I6EK0zQqr4IH2sKrmEodmoflaupHqy0=;
 b=bOx3WkECZ7I+d6cr2RrcqUGL3GK2oG62bMshb6KG3EtjBt0Gt7mgsKKGXqVi4VcB0e
 X9LkJtXV2ltjm9LaaJ+myNjVAErmpp+gVhq5LLJT1mcigkyzG9y/Oi1V22Y1Hm1t1p5j
 l3qXRyoe2NogtM4nh3j3wC/OarNln+pcaVrEc9MI+3/g3uQAVUKkrPh3lzGec0nr5D/d
 3Kpj1XiLYzeCGeNbLQ4D/lQdUOpNcV5uygt/JFnzKzIPItQd2RlV0fVC2BXUBiYtHhgv
 MKC5gw6rXr3OJQ6qOMl54sEHuPdxqDqk/bxqSTQ1pnoMsAiC4va56QCDNyBXMzn2XF3S
 D7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738513506; x=1739118306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDGs3A5PbDb6I6EK0zQqr4IH2sKrmEodmoflaupHqy0=;
 b=kn3hcLFwSn74LS+99pgOHIPsi2dXB0eNfs1Fltltk2mlp6K/GHkN3F+zdxyQWt8olr
 pX3rXvLoQ87I4tfdfG1Ac1dG+V41CRBcAUk4RCzOqb9bhjquVTJr5spqce6RJT+5m2+3
 JQ6gjHEeOf9ZSu8fgOex7EresubQz7Ajz8sCj02ro1DlJz0r0aNv2YGB7+cE7yjCRy7O
 oKn7bDxpBJvAKMaHGb+aCo0f66XaHeodfjc+QULuQm1gfegBJS4kw7mQxWhgmFP98ybr
 WET/SQEdMhn7KJZUxlS2eeb90lWTS8kvkbabFV3qtpXKbRjbP2gXFguuKaV9aNyLDAON
 ZcmQ==
X-Gm-Message-State: AOJu0YwApX9MuLcE6sNGh0gPl9TqWJR76DDvsy3v/iiwDHu5sdbMfwWR
 SB2yLOaZciDdVHtG5s0Sk33wRnxy59BhXznk+BaRW763IXGPuAA=
X-Gm-Gg: ASbGnctgVO4m+j01QQ3IUZk4JWX5a8s/pYNGxAToD9nxvxIr8H1TjTkauVPZO9TmZLl
 I45V1EhKNvmXbmXimHH5VRdS3A25CKezR7S7LOr9mnSZaen0aTQYXQXZRAscIlmjgZcWPfxh4iE
 8ezOluYt1O4KEHn/+Udpj6yPfBrFBNBXpYd36NWK07MnrKGbI1OJXTVmMzBUpITBabglRBSlG1G
 CIJBnaKq9mkjTyBfxpfOY463CQvr/0j29N10E8otKGLMESdq8DH5h8kI02MG86iRtSpYndsSUzy
 S8fls5Rm3T2A5xWmcSdAmA==
X-Google-Smtp-Source: AGHT+IGcflJsbcHwd9hStZsb82ZUMwMerj9n6/WmHc2OHeknvudNKScSECBDMvyO7wsUHT0AiWOfKA==
X-Received: by 2002:a17:90b:1f8c:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2f83ab8c371mr26462329a91.1.1738513506073; 
 Sun, 02 Feb 2025 08:25:06 -0800 (PST)
Received: from [192.168.0.163] ([116.232.67.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f8489ae78dsm7316344a91.16.2025.02.02.08.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 08:25:05 -0800 (PST)
Message-ID: <bedb349f-d570-40b6-b0b8-8f85e54859d9@gmail.com>
Date: Mon, 3 Feb 2025 00:24:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] vfio/igd: refactor vfio_probe_igd_bar4_quirk()
 into pci config quirk
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-4-tomitamoeko@gmail.com>
 <009cbf4b-ae21-4bdc-a288-251a6167ff34@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <009cbf4b-ae21-4bdc-a288-251a6167ff34@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
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

On 1/31/25 17:14, Cédric Le Goater wrote:
> Hello Tomita,
> 
> On 1/24/25 20:12, Tomita Moeko wrote:
>> The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk() was
>> removed in previous change, leaving the function not matching its name,
>> so move it into the newly introduced vfio_config_quirk_setup(). There
>> is no functional change in this commit. If any failure occurs, the
>> function simply returns and proceeds.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>   hw/vfio/igd.c        | 31 +++++++++++++++++--------------
>>   hw/vfio/pci-quirks.c |  6 +++++-
>>   hw/vfio/pci.h        |  2 +-
>>   3 files changed, 23 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index ca3a32f4f2..376a26fbae 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -359,7 +359,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>   }
>>   -void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>> +                                 Error **errp G_GNUC_UNUSED)
> 
> Adding an 'Error **' parameter is in improvement indeed. All the error_report
> of this routine need to be converted too.

Sorry I missed this mail previously.

Originally this function simply return and continue on error, I prefer
keeping current behavior until legacy mode was finally removed, as I
described in my reply to Alex. At that point, this function will
terminate and report on error.
 
>>   {
>>       g_autofree struct vfio_region_info *rom = NULL;
>>       g_autofree struct vfio_region_info *opregion = NULL;
>> @@ -378,10 +379,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>        * PCI bus address.
>>        */
>>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) || nr != 4 ||
>> +        !vfio_is_vga(vdev) ||
>>           &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>                                          0, PCI_DEVFN(0x2, 0))) {
>> -        return;
>> +        return true;
>>       }
>>         /*
>> @@ -395,7 +396,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>                                              "vfio-pci-igd-lpc-bridge")) {
>>           error_report("IGD device %s cannot support legacy mode due to existing "
>>                        "devices at address 1f.0", vdev->vbasedev.name);
>> -        return;
>> +        return true;
> 
> if there is an error_report, why is this returning true ? It should be false.

Please see my comment above
  
>>       }
>>         /*
>> @@ -407,7 +408,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (gen == -1) {
>>           error_report("IGD device %s is unsupported in legacy mode, "
>>                        "try SandyBridge or newer", vdev->vbasedev.name);
>> -        return;
>> +        return true;
> 
> same here and else where.
> 
>>       }
>>         /*
>> @@ -420,7 +421,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if ((ret || !rom->size) && !vdev->pdev.romfile) {
>>           error_report("IGD device %s has no ROM, legacy mode disabled",
>>                        vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         /*
>> @@ -431,7 +432,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>           error_report("IGD device %s hotplugged, ROM disabled, "
>>                        "legacy mode disabled", vdev->vbasedev.name);
>>           vdev->rom_read_failed = true;
>> -        return;
>> +        return true;
>>       }
>>         /*
>> @@ -444,7 +445,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (ret) {
>>           error_report("IGD device %s does not support OpRegion access,"
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         ret = vfio_get_dev_region_info(&vdev->vbasedev,
>> @@ -453,7 +454,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (ret) {
>>           error_report("IGD device %s does not support host bridge access,"
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         ret = vfio_get_dev_region_info(&vdev->vbasedev,
>> @@ -462,7 +463,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (ret) {
>>           error_report("IGD device %s does not support LPC bridge access,"
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
>> @@ -476,7 +477,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>           error_report("IGD device %s failed to enable VGA access, "
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         /* Create our LPC/ISA bridge */
>> @@ -484,7 +485,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (ret) {
>>           error_report("IGD device %s failed to create LPC bridge, "
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         /* Stuff some host values into the VM PCI host bridge */
>> @@ -492,14 +493,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>       if (ret) {
>>           error_report("IGD device %s failed to modify host bridge, "
>>                        "legacy mode disabled", vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         /* Setup OpRegion access */
>>       if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>>           error_append_hint(&err, "IGD legacy mode disabled\n");
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> -        return;
>> +        return true;
>>       }
>>         /*
>> @@ -561,4 +562,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>         trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
>>                                       (ggms_size + gms_size) / MiB);
>> +
>> +    return true;
>>   }
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index c40e3ca88f..b8379cb512 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -1169,6 +1169,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>>    */
>>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>>   {
>> +#ifdef CONFIG_VFIO_IGD
> 
> oh. We try to avoid such ifdef in QEMU. Only very specific and high level
> configs are discarded at compile time (KVM, LINUX, etc).

This ifdef has been in QEMU code, for only building igd-related code
into x86 target (VFIO_IGD is only seleted when PC_PCI=on, and I440FX/
Q35 selests PC_PCI). IMO using the ifdef here is reasonable, as IGD
quirks is a part of vfio-pci, but using QOM in furure would be a
good direction.

> One way to adress this case, would be to use QOM. Example below :
> 
>  
> Declare a base class :
>         #define TYPE_VFIO_PCI_QUIRK_PROVIDER "vfio-pci-quirk-provider"
>         OBJECT_DECLARE_TYPE(VFIOPCIQuirkProvider, VFIOPCIQuirkProviderClass,
>                         VFIO_PCI_QUIRK_PROVIDER)
>         struct VFIOPCIQuirkProviderClass {
>         ObjectClass parent;
>             bool (*probe)(VFIOPCIDevice *vdev, Error **errp);
>         bool (*setup)(VFIOPCIDevice *vdev, Error **errp);
>     };
>         static const TypeInfo vfio_pci_quirk_info = {
>         .name = TYPE_VFIO_PCI_QUIRK_PROVIDER,
>         .parent = TYPE_OBJECT,
>         .class_size = sizeof(VFIOPCIQuirkClass),
>         .abstract = true,
>     };
>         static void register_vfio_pci_quirk_type(void)
>     {
>         type_register_static(&vfio_pci_quirk_info);
>     }
>         type_init(register_vfio_pci_quirk_type)
> 
> 
> Declare one for IGD
>         static void vfio_pci_quirk_igd_class_init(ObjectClass *klass, void *data)
>     {
>         VFIOPCIQuirkClass* vpqc = VFIO_PCI_QUIRK_PROVIDER_CLASS(klass);
>             vpqc->setup = vfio_probe_igd_quirk_probe;
>         vpqc->probe = vfio_probe_igd_quirk_probe;
>     }
>         static const TypeInfo vfio_pci_quirk_igd_info = {
>         .name = TYPE_VFIO_PCI_QUIRK_PROVIDER "-igd",
>         .parent = TYPE_VFIO_PCI_QUIRK_PROVIDER,
>         .class_init = vfio_pci_quirk_igd_class_init,
>         .class_size = sizeof(VFIOPCIQuirkClass),
>     };
>         static void vfio_pci_quirk_igd_register_types(void)
>     {
>         type_register_static(&vfio_pci_quirk_igd_info);
>     }
>         type_init(vfio_pci_quirk_igd_register_types)
> 
> 
> and in the common part, loop on all the classes to probe and setup :
> 
> 
>     static void vfio_pci_quirk_class_foreach(ObjectClass *klass, void *opaque)
>     {
>         VFIOPCIQuirkProviderClass* vpqc = VFIO_PCI_QUIRK_PROVIDER_CLASS(klass);
>         Error *local_err = NULL;
>             vpqc->setup(opaque, &local_err);
>     }
>         bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>     {
>         object_class_foreach(vfio_pci_quirk_class_foreach,
>                              TYPE_VFIO_PCI_QUIRK_PROVIDER, false, vdev);
>        ...
> 
> 
> 
> 
> Thanks,
> 
> C.
> 
> 



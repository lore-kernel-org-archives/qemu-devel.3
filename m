Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26899C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 17:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u413u-0003aP-3Z; Sun, 13 Apr 2025 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u413s-0003Zv-Fu
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 13:24:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u413q-0008OY-OL
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 13:24:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3370535b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Apr 2025 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744565041; x=1745169841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KmXB2H1rBZgOB3oqplc1tov82wcgpNXEkBi6ePdcs/A=;
 b=H8SzmOM59xGjRG71asBOjSaIiWzcoPiCiTYJZ6I2LLXZde8AuVb9vHjTmtOLg+PNn+
 Vxq9k2ikqIbqgyysftZ/kvVhIEIMfjCB+JMzzWralLWvEIuBMZWp8QMwwuWAP68Cc3pg
 IsJB29XBV9ZOgotUeMcQKgQz520j3J8sFRWn8lWTkgdHg9pbOii8OUZidussa+xH56o1
 IST/PO6PT0TPf+og6Ap4cCsnGrWcHBIbW464phKqIMHsUlQ+LIiUZcFsmQYPQqUJbEle
 NlqnzhUa8pEmiuBIBTmdC04b3Ii708BdnfVjvsLGkqmkrVeQlw3dcvbfG3bJl17ksZzQ
 Rvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744565041; x=1745169841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmXB2H1rBZgOB3oqplc1tov82wcgpNXEkBi6ePdcs/A=;
 b=qxY6n3GGi1ifZYaGh+YAZl2XWWuj1B/cFdn6XiZihN3Tg2s/YxUhTuUnyWfeNqKjYB
 o8Q+BZsrWGvK7vCHuE3WUmrA0rU+uwLEhELrunpFtnowi11+k1+eCAGyII7sl0ROlJby
 1Z+MpUT+w6sQA95fuaA9Yz7XjxO9yw9MSF3Ksvq1GFV4zgIwFsAQgI/dDnMRegnQuYsL
 wJDnjVdZXGHcxjapyqbV6fx86OhsheBFFc03HN8SBQxrRccTZgSJ1r18sUulmdBeJx5I
 665c4T9dLPogBzt5tPlm0FTqaAx5UZzW1VGOJt9yZQjcFDTeYTOLC260uQvAbBSaPN8G
 nIjg==
X-Gm-Message-State: AOJu0Yw2rtlJfQ5Kaa8DUWSpd9p8tAZOYvhw7wOLZvnwlXcCpE5NOcj1
 XLdtF8O9P/ZrE12DDhyd/HBlnB0sdVMbEtKEwM6u/JKUvNjuvxaRLpIgGouxQA==
X-Gm-Gg: ASbGncsB4VStMdEteLDYaVhSXJ193EGOdi7GflvHCB9VPO+HYQ0MXmI4IfOeZRRPKtP
 x8pmiGohgPJY7yo6FUYCfY/VAiTWqDw0v1igbt9k9NHyIc3YnkWMOq/nMFsoML2TH0f0Udj2wJd
 sxn/n6U0f2Y+qs5g2aP3SHFihXnlax/c/AcDwaonFoK+DrvV5aYW12RgdEMlwokKMxuygOwvwxM
 cLk+8eGLCC1ZqZDdwj8whgvuRupQQKRWH1o4bIDaNCwulX001FQeJWT4LWj1zF0MnlZZX1gwWh6
 xbRsvq+H1ctdJ5epsPWzZmVbUTi6ICkioX9Q3Tl9lH9qXldkDSI4a4FX
X-Google-Smtp-Source: AGHT+IFIra//n2wZTxQE338rqx5uF1oDMQTf50h6VCZgL5DUfjZYMiH2DO21ErKMieYVz/gWu2j7IQ==
X-Received: by 2002:a05:6a20:4f92:b0:201:85f4:ad0a with SMTP id
 adf61e73a8af0-20185f4bb86mr9469004637.30.1744565041118; 
 Sun, 13 Apr 2025 10:24:01 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21e14e9sm5175378b3a.77.2025.04.13.10.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Apr 2025 10:24:00 -0700 (PDT)
Message-ID: <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
Date: Mon, 14 Apr 2025 01:23:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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


On 4/10/25 15:34, Cédric Le Goater wrote:
> + Corvin
> 
> On 4/9/25 19:18, Alex Williamson wrote:
>> On Wed, 26 Mar 2025 01:22:39 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> So far, all Intel VGA adapters, including discrete GPUs like A770 and
>>> B580, were treated as IGD devices. While this had no functional impact,
>>> a error about "unsupported IGD device" will be printed when passthrough
>>> Intel discrete GPUs.
>>>
>>> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
>>> address when probing.
>>>
>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>> ---
>>>   hw/vfio/igd.c | 23 +++++++++--------------
>>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>> index 265fffc2aa..ff250017b0 100644
>>> --- a/hw/vfio/igd.c
>>> +++ b/hw/vfio/igd.c
>>> @@ -53,6 +53,13 @@
>>>    * headless setup is desired, the OpRegion gets in the way of that.
>>>    */
>>>   +static bool vfio_is_igd(VFIOPCIDevice *vdev)
>>> +{
>>> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
>>> +           vfio_is_vga(vdev) &&
>>> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
>>> +}
>>
>> vfio-pci devices can also be specified via sysfsdev= rather than host=,
>> so at a minimum I think we'd need to test against vdev->vbasedev.name,
>> as other callers of vfio_pci_host_match do.  For example building a
>> local PCIHostDeviceAddress and comparing it to name.  This is also not
>> foolproof though if we start taking advantage of devices passed by fd.
>>
>> Could we instead rely PCIe capabilities?  A discrete GPU should
>> identify as either an endpoint or legacy endpoint and IGD should
>> identify as a root complex integrated endpoint, or maybe older versions
>> would lack the PCIe capability altogether.
> 
> Maintaining a list of PCI IDs for Intel GPU devices as Corvin was
> proposing in [1] is not a viable solution ?
> 
> Thanks,
> 
> C.
> 
> [1] https://lore.kernel.org/qemu-devel/20250206121341.118337-1-corvin.koehne@gmail.com/

I checked Intel doc, probably maintaining an device ID list is the only
possible way. But given that intel is moving to xe driver, generation
becomes unclear, I'd like to propose a list with quirk flags for igd.

static const struct igd_device igd_devices[] = {
    INTEL_SNB_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM_QUIRK),
    INTEL_TGL_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM64_QUIRK),
}

Matching in the list is more time consuming than current switch-case,
it's better to have a new field to cache it.

I will go with Corvin's first 2 patches with reordering suggested by
Cornelia.

Thanks,
Moeko
  
>> Also I think the comments that were dropped below are still valid and
>> useful to transfer to this new helper.  I think those are actually
>> referring to the guest address of 00:02.0 though, which should maybe be
>> a test as well.  Thanks,
>>
>> Alex
>>
>>> +
>>>   /*
>>>    * This presumes the device is already known to be an Intel VGA device, so we
>>>    * take liberties in which device ID bits match which generation.  This should
>>> @@ -427,13 +434,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>       VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>>>       int gen;
>>>   -    /*
>>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>>> -     * consider enabling legacy mode. Some driver have dependencies on the PCI
>>> -     * bus address.
>>> -     */
>>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>> -        !vfio_is_vga(vdev) || nr != 0) {
>>> +    if (nr != 0 || !vfio_is_igd(vdev)) {
>>>           return;
>>>       }
>>>   @@ -490,13 +491,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>>       bool legacy_mode_enabled = false;
>>>       Error *err = NULL;
>>>   -    /*
>>> -     * This must be an Intel VGA device at address 00:02.0 for us to even
>>> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
>>> -     * PCI bus address.
>>> -     */
>>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>> -        !vfio_is_vga(vdev)) {
>>> +    if (!vfio_is_igd(vdev)) {
>>>           return true;
>>>       }
>>>   
>>
> 


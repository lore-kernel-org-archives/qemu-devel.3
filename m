Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6D3CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSKE-0004k6-Hg; Mon, 08 Jun 2026 01:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWQJr-0000vO-Su
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 23:06:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWQJo-0001ue-Sc
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 23:06:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c0b7ca8831so6480415ad.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 20:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780887987; x=1781492787; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VihIZYqXJ47hfgfaZiAVQZ6qxV5+jy2L+m9f1MSJO8=;
 b=eu5s14pzVrYqVbMOA2uRPjDGtiV0zffYiokHvNo6/tUWx2euIMzGwYLo9QGm8Od1DP
 t7dobh999uzOnSz8jffL80sD8BIQ/BxGHesbdaqwTSmSpj7jReCFw1eDqSGqgx3eTcqO
 esJXNW53Ye/RoXxKk22cb6q2C3/iKJzF029oblpK+5JJBxRX4WUjOEPXNnWuMavtN3C3
 Srt9F+upIrhvh1JI6R4AH2DTLUqEdLDo5KIjMWveOnRy4zy5iIPCPPSjHx/UHBoAOzmv
 HvN4wCEEfYoQkRBjqfNS/z6PX3Icv1AYYBsXYKQABX+cv6kmkRQW5wQDYPdxMr/3Ys3v
 5dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780887987; x=1781492787;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VihIZYqXJ47hfgfaZiAVQZ6qxV5+jy2L+m9f1MSJO8=;
 b=GvCBhEpP0cC67TgEZolPEV0fKhhD7/FgGzzSxlgmUPECAFrHnY+TqV+4tqEV5TagJm
 krNrj5ELj1OX8m0DvAixcj2qleHBATI/uzTHqBPOR1Dwxj+wCiq3wwwggvyMBXXiReDZ
 C3h+kjWLqXctI7rui8vNsqzJVjPnQiKP4ss5XajUw96z3TUpJowoNFeNh+FKjktKpfdY
 h2m30Gr+i5K3IjqAmIqrChMnYtkCBHaFa2dMTY3E8NKF4tV6IVxSP/pcoSMwdTMy01p2
 GXRs1VWw6zmIKe8tbS3aPkrzZyM3spIqf5t81hogAbs2d/289w5XNPjeIJ+hLNtVuVWv
 zDjQ==
X-Gm-Message-State: AOJu0YzK8NZ7X4+NZ3kt9gLxdp2RMYfnOo+I/a/D/HcBVGx+VdbIEsNv
 Vysekg1HlVbpcI/irK5HQStpGjpcX5Mr1tExKZV+JQ3xdnC7nQaEVNbW9AwFVq/0rik=
X-Gm-Gg: Acq92OFX3suTISDBnRr8rBtuG8QD7FIwWwo5v+fHNuII9yOp0mVygeq8PjxSCAhjLT4
 8igEhUBsxHhXq350hFg2r+IZmDW3F/8InRBVV5ZEk3gMB0CFZiF53+P+cnK28BbZwSmye1twtTp
 wv2m7NILh+1uq6SksgsYMgjHUt7Vt7SbPl8XyeSKBDEWkWc/ZZ5n7rTro/Bo5sWY3R/1U72Vljg
 YOaqoGHkSOKvf6DoPop5MOVUYtckaK+UswyCDKVkhzwI6qoh05ivwDjzBMDTucZnp2As7yeom2d
 WDz5chM0Kb86SI3scQ1Ym0KQLnbS9RoAuddPxxX4r2Q1vI78CZ/ZDmgU+/jVqDxLjtqPOaVs9By
 4Azz1O2RRK4HQYR2PGY4iVpbLS2euJSBdXE6n0FgX/yvYs6Z5CJfVop0rzHrnuG6RIWWyI9mt2f
 3sk8GkTN4TP0a7U7W3UMUg4DuiBklpteos4aZPXTKfVC0iHiwZnqlfZhl5DqqmZJ0dHbJ96LWTh
 uzd62uXc5iXzMk1ZYLFu2JnzKEndw==
X-Received: by 2002:a17:90b:562d:b0:35d:ab8b:abe6 with SMTP id
 98e67ed59e1d1-370f028684cmr6147849a91.4.1780887986646; 
 Sun, 07 Jun 2026 20:06:26 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:f845:f2b5:520f:1724:a6dd?
 ([2001:4490:484d:f845:f2b5:520f:1724:a6dd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df034a2csm14038535a12.3.2026.06.07.20.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 20:06:26 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------QTHUKPRgY24l1bhPjq0hw6zF"
Message-ID: <389aab42-bc75-4b7a-b94f-bc29a33e8a7a@gmail.com>
Date: Mon, 8 Jun 2026 08:36:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex@shazbot.org>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
 <20260603173355.36121-7-tomitamoeko@gmail.com>
 <20260605160224.32405a42@shazbot.org>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260605160224.32405a42@shazbot.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Jun 2026 01:15:00 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------QTHUKPRgY24l1bhPjq0hw6zF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, as these patches fixes legacy mode grabled grub screen they add 
regression to UEFI guest where monitor won't woke up until grub timeout.

CMD used : -device 
vfio-pci,host=00:02.0,id=igpu,addr=2.0,x-igd-legacy-mode=off,x-igd-lpc=on,romfile=/home/maan/QemuVMs/MyGopRomfiles/InteligdGopHD4600.rom 


romfile is patched with intelgopdriver.efi from VfioIgdPkg repo.

Here is what i915 logs say in guest with patched qemu :
[   10.823656] i915 0000:00:02.0: [drm] Found haswell (device ID 0412) 
integrated display version 7.00 stepping N/A
[   10.824300] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   10.824763] i915 0000:00:02.0: vgaarb: deactivate vga console
[   10.824867] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   10.824871] i915 0000:00:02.0: [drm] DMAR active, disabling use of 
stolen memory
[   10.832111] i915 0000:00:02.0: Invalid PCI ROM header signature: 
expecting 0xaa55, got 0x0000
[   10.832118] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)
[   10.832154] i915 0000:00:02.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   10.842837] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[   10.850377] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[   11.678013] fbcon: i915drmfb (fb0) is primary device
[   11.748610] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device

So look like VBT table is not expose to guest.

These are the logs of stock qemu with working grub and all :
[   28.945622] i915 0000:00:02.0: [drm] Found haswell (device ID 0412) 
integrated display version 7.00 stepping N/A
[   28.946393] i915 0000:00:02.0: [drm] VT-d active for gfx access
[   28.961770] i915 0000:00:02.0: vgaarb: deactivate vga console
[   28.961830] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[   28.961833] i915 0000:00:02.0: [drm] DMAR active, disabling use of 
stolen memory
[   29.016673] i915 0000:00:02.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   29.051910] i915 0000:00:02.0: [drm] Registered 3 planes with drm panic
[   29.055360] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[   29.903202] fbcon: i915drmfb (fb0) is primary device
[   29.990056] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device

Regards,
K S Maan

On 6/6/26 3:32 AM, Alex Williamson wrote:
> On Thu,  4 Jun 2026 01:33:54 +0800
> Tomita Moeko<tomitamoeko@gmail.com> wrote:
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 17437ae18d..e00f6f8315 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>   
>>       return vfio_pci_igd_config_quirk(vdev, errp);
>>   }
>> +
>> +/*
>> + * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
>> + * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
>> + * used to get BDSM value when programming the initial GTT.
>> + *   xx xx xx xx           v: .long ?                  # saved value
>> + *   66 53                    push  %ebx
>> + *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
>> + *   74 07                    je    1f                 # if zero, go compute
>> + *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
>> + *   eb 0f                    jmp   2f
>> + *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
>> + *   e8 xx xx                 call  pci_read_cfg_word
>> + *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
>> + *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
>> + *   66 5b                 2：pop   %ebx
>> + *   c3                       ret
>> + * When running the VBIOS in guest, saved value still reflects the host stolen
>> + * memory base address, which is not correct in guest. So we need to patch the
>> + * VBIOS to clear the saved value.
>> + *
>> + * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
>> + * anchors the match to the routine. Both `cs:` displacements must reference
>> + * the same offset.
>> + */
> Neat, cool quirk.
>
>> +static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
>> +                                     uint16_t *bdsm_offset)
>> +{
>> +    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
>> +    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
>> +    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
>> +    size_t i;
>> +    bool found = false;
>> +
>> +    if (rom_size < 19) {
>> +        return -ENOENT;
>> +    }
>> +
>> +    for (i = 0; i + 19 <= rom_size; i++) {
>> +        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
>> +            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
>> +            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
>> +            continue;
>> +        }
>> +
>> +        /* same saved value address? */
>> +        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
>> +            continue;
>> +        }
>> +
>> +        if (found) {
>> +            return -EEXIST;
>> +        }
>> +
>> +        *bdsm_offset = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
> This needs a bounds check to make sure it's still within the ROM,
> either here or before the memset().
>
>> +        found = true;
>> +    }
>> +
>> +    if (!found) {
>> +        return -ENOENT;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
>> +{
>> +    int ret, gen;
>> +    uint16_t pcir_offset, bdsm_offset = 0;
>> +    uint8_t checksum;
>> +
>> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> +        !vfio_is_vga(vdev) || !vdev->vga) {
>> +        return;
>> +    }
>> +
>> +    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
>> +    gen = igd_gen(vdev);
>> +    if (gen < 6 || gen > 9) {
>> +        return;
>> +    }
>> +
>> +    if (pci_get_word(vdev->rom) != 0xaa55) {
>> +        return;
>> +    }
>> +
>> +    /* Must be a legacy ROM */
>> +    pcir_offset = pci_get_word(vdev->rom + 0x18);
>> +    if (pcir_offset >= vdev->rom_size ||
> This gates the below test to pcir_offset + 0x14, so should be:
>
>         if (pcir_offset + 0x14 >= vdev->rom_size ||
>
>> +        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
>> +        pci_get_byte(vdev->rom + pcir_offset + 0x14) != 0x00) {
>> +        return;
>> +    }
>> +
>> +    ret = igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size, &bdsm_offset);
>> +    if (ret < 0) {
>> +        return;
>> +    }
>> +
>> +    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));
>> +
>> +    checksum = pci_rom_calculate_checksum(vdev->rom, vdev->rom_size);
>> +    ((uint8_t *)vdev->rom)[6] = checksum;
> If updated per previous recommendation, this becomes:
>
> 	((uint8_t *)vdev->rom)[6] -= checksum;
>
> Thanks,
> Alex
>
--------------QTHUKPRgY24l1bhPjq0hw6zF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Hi,
        as these patches fixes legacy mode grabled grub screen they add
        regression to UEFI guest where monitor won't woke up until grub
        timeout.</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">CMD
        used : -device vfio-pci,host=00:02.0,id=igpu,</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">addr=2.0,x-igd-legacy-mode=</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">off,x-igd-lpc=on,romfile=/</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">home/maan/QemuVMs/</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">MyGopRomfiles/</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">InteligdGopHD4600.rom </span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">romfile
        is patched with intelgopdriver.efi from </span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">VfioIgdPkg repo.</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Here
        is what i915 logs say in guest with patched qemu :</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.823656] i915 0000:00:02.0: [drm] Found haswell (device ID
        0412) integrated display version 7.00 stepping N/A</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.824300] i915 0000:00:02.0: [drm] VT-d active for gfx access</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.824763] i915 0000:00:02.0: vgaarb: deactivate vga console</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.824867] i915 0000:00:02.0: [drm] Using Transparent
        Hugepages</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.824871] i915 0000:00:02.0: [drm] DMAR active, disabling use
        of stolen memory</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.832111] i915 0000:00:02.0: Invalid PCI ROM header
        signature: expecting 0xaa55, got 0x0000</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.832118] i915 0000:00:02.0: [drm] Failed to find VBIOS
        tables (VBT)</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.832154] i915 0000:00:02.0: vgaarb: VGA decodes changed:
        olddecodes=io+mem,decodes=io+</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">mem:owns=io+mem</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.842837] i915 0000:00:02.0: [drm] Registered 3 planes with
        drm panic</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          10.850377] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on
        minor 0</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          11.678013] fbcon: i915drmfb (fb0) is primary device</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          11.748610] i915 0000:00:02.0: [drm] fb0: i915drmfb frame
        buffer device</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">So
        look like VBT table is not expose to guest.</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">These
        are the logs of stock qemu with working grub and all :</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          28.945622] i915 0000:00:02.0: [drm] Found haswell (device ID
        0412) integrated display version 7.00 stepping N/A</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          28.946393] i915 0000:00:02.0: [drm] VT-d active for gfx access</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          28.961770] i915 0000:00:02.0: vgaarb: deactivate vga console</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          28.961830] i915 0000:00:02.0: [drm] Using Transparent
        Hugepages</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          28.961833] i915 0000:00:02.0: [drm] DMAR active, disabling use
        of stolen memory</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          29.016673] i915 0000:00:02.0: vgaarb: VGA decodes changed:
        olddecodes=io+mem,decodes=io+</span><wbr
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">mem:owns=io+mem</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          29.051910] i915 0000:00:02.0: [drm] Registered 3 planes with
        drm panic</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          29.055360] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on
        minor 1</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          29.903202] fbcon: i915drmfb (fb0) is primary device</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[
          29.990056] i915 0000:00:02.0: [drm] fb0: i915drmfb frame
        buffer device</span><br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <br
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Regards,</span><br
style="color: rgb(34, 34, 34); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; font-family: &quot;Google Sans&quot;, Arial, sans-serif; font-size: 16px; margin: 0px; border-bottom: 0px rgb(230, 232, 240);">
      <span
style="color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">K
        S Maan</span></p>
    <div class="moz-cite-prefix">On 6/6/26 3:32 AM, Alex Williamson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260605160224.32405a42@shazbot.org">
      <pre wrap="" class="moz-quote-pre">On Thu,  4 Jun 2026 01:33:54 +0800
Tomita Moeko <a class="moz-txt-link-rfc2396E" href="mailto:tomitamoeko@gmail.com">&lt;tomitamoeko@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 17437ae18d..e00f6f8315 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     return vfio_pci_igd_config_quirk(vdev, errp);
 }
+
+/*
+ * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
+ * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
+ * used to get BDSM value when programming the initial GTT.
+ *   xx xx xx xx           v: .long ?                  # saved value
+ *   66 53                    push  %ebx
+ *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
+ *   74 07                    je    1f                 # if zero, go compute
+ *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
+ *   eb 0f                    jmp   2f
+ *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
+ *   e8 xx xx                 call  pci_read_cfg_word
+ *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
+ *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
+ *   66 5b                 2：pop   %ebx
+ *   c3                       ret
+ * When running the VBIOS in guest, saved value still reflects the host stolen
+ * memory base address, which is not correct in guest. So we need to patch the
+ * VBIOS to clear the saved value.
+ *
+ * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
+ * anchors the match to the routine. Both `cs:` displacements must reference
+ * the same offset.
+ */
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Neat, cool quirk.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
+                                     uint16_t *bdsm_offset)
+{
+    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
+    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
+    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
+    size_t i;
+    bool found = false;
+
+    if (rom_size &lt; 19) {
+        return -ENOENT;
+    }
+
+    for (i = 0; i + 19 &lt;= rom_size; i++) {
+        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
+            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
+            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
+            continue;
+        }
+
+        /* same saved value address? */
+        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
+            continue;
+        }
+
+        if (found) {
+            return -EEXIST;
+        }
+
+        *bdsm_offset = rom[i + 4] | ((uint16_t)rom[i + 5] &lt;&lt; 8);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This needs a bounds check to make sure it's still within the ROM,
either here or before the memset().

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+        found = true;
+    }
+
+    if (!found) {
+        return -ENOENT;
+    }
+
+    return 0;
+}
+
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    int ret, gen;
+    uint16_t pcir_offset, bdsm_offset = 0;
+    uint8_t checksum;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || !vdev-&gt;vga) {
+        return;
+    }
+
+    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
+    gen = igd_gen(vdev);
+    if (gen &lt; 6 || gen &gt; 9) {
+        return;
+    }
+
+    if (pci_get_word(vdev-&gt;rom) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(vdev-&gt;rom + 0x18);
+    if (pcir_offset &gt;= vdev-&gt;rom_size ||
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This gates the below test to pcir_offset + 0x14, so should be:

       if (pcir_offset + 0x14 &gt;= vdev-&gt;rom_size ||

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+        memcmp(vdev-&gt;rom + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(vdev-&gt;rom + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    ret = igd_vbios_find_saved_bdsm(vdev-&gt;rom, vdev-&gt;rom_size, &amp;bdsm_offset);
+    if (ret &lt; 0) {
+        return;
+    }
+
+    memset(vdev-&gt;rom + bdsm_offset, 0, sizeof(uint32_t));
+
+    checksum = pci_rom_calculate_checksum(vdev-&gt;rom, vdev-&gt;rom_size);
+    ((uint8_t *)vdev-&gt;rom)[6] = checksum;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
If updated per previous recommendation, this becomes:

	((uint8_t *)vdev-&gt;rom)[6] -= checksum;

Thanks,
Alex

</pre>
    </blockquote>
  </body>
</html>

--------------QTHUKPRgY24l1bhPjq0hw6zF--


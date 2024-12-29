Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B45FE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 16:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRwNp-0007Bm-Hn; Sun, 29 Dec 2024 11:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tRwNn-0007BU-0z
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:43:15 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tRwNk-0001ib-UK
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:43:14 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-2eec9b3a1bbso8590160a91.3
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735490591; x=1736095391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U3dlPpSgxmz+XnuTv5cF2griZUkpubHrgLxx0XRsO64=;
 b=VNRWYFkUifBJxX2XZ5hC2OfhQzG6/3iTIY/cQ3iNJNsyd+GrTKqsmaQtZUFdE6iOB1
 SeFk6HUX9zl9IjoVbCz6rQrB1xVLkJqeqTrxge+oPJc7Nfcx/jwV9jluHiYEbxjFkL0c
 Xwjm5geBxhHsnZdOYtzvy+n3JUs4IPbhtKGHkBxbmMJBoQATj2r6yPVUhrRbYCMFcwv8
 cYk3mLuLHObmNwa+Ef0Dru0fA81czqCpxBalmcMJPyhLjEBQTWuRXK6q7JuphjnTqF//
 cFNcS8ZNSxGdhWSSY/8yIUGykdwl9b8zj90zxv+cBab4Isa8v+O2MzQnh6LfbWDGMTk9
 2p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735490591; x=1736095391;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3dlPpSgxmz+XnuTv5cF2griZUkpubHrgLxx0XRsO64=;
 b=VAgekK95aKyRUjz7eE1UMQjvPy3Me9JGSQt98tgAFzWWrLfOkEZ0hICPnMXNLDsaV9
 vQjwGeQnZGtkRiUpTDs2co1aMvTCpitVIzcnb+avVLyWcWus/j2q2vwQ5R8eGa3MGqIp
 NKQGdXEmADdZLNNySJcd4hJVa0USqOe0o51moldUbkntN53O+jNNmaKTLd+Cuk0jylSe
 iBLh0mTygD8Oktp2SPetqlWyyHngLK/zBuXuFfxLXP5/sORoa0DKw6U9QszR2i+9VdOj
 y/pmW4wuO8VUxByDa8VAxJGY37tkzrU+Rj//Reg321Eclq+I4TL2Xq2wl5nZ4k7zp5uO
 4DDA==
X-Gm-Message-State: AOJu0YzpkZytMsSXINU+Z6Ib/czeqKSbcAfAZKfEX1aqRD3AXA5ktHue
 PqFSvSoi90HU9rsZThGLm6b6LnwcXGabJ7eB+lMl6NhOGTS/pG9tXSAjCyyO2w==
X-Gm-Gg: ASbGncu9YqDV08bVzQfOQZWKx5EWy45TdxxbA63Q3Dp0o7MTc0Gvz3BbyB5wmYsbosQ
 wAC0Yx0Ajyie34po6sEy9PcAw//mTubouiW6ioan5NKr+jKi33wV422kwCt0LDFwohXST9tYeqg
 TdUlj5/HVpZuwOijdtbRJ4n44d/RI5/OPCs9WRKwYx+C9g1nrplIBmORSbo3YsCay62+CT5q+Gi
 UGrUhhoXVM4/IObe6PE41Lq6QSc/NNcW6RGCWYHAorzXYtkngyFwfKZGQ777g==
X-Google-Smtp-Source: AGHT+IFh4m3fcqNllSFblUjQOrtlzh8nGPVC2jSqY1C286v/nkKvMHKbj0N4JUBa4oNbWdCMUMnIUw==
X-Received: by 2002:a17:90b:2d88:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2f452def1d1mr53442725a91.5.1735490591038; 
 Sun, 29 Dec 2024 08:43:11 -0800 (PST)
Received: from [192.168.0.163] ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26e7ecsm21156476a91.50.2024.12.29.08.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 08:43:10 -0800 (PST)
Message-ID: <b373a030-5ccf-418c-9213-865ddc6748fd@gmail.com>
Date: Mon, 30 Dec 2024 00:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] vfio/igd: Enable legacy mode on more devices
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203131205.1391d69a.alex.williamson@redhat.com>
 <84168744-f82b-494f-93a6-ca334e6cc98c@gmail.com>
Content-Language: en-US
In-Reply-To: <84168744-f82b-494f-93a6-ca334e6cc98c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/4/24 23:08, Tomita Moeko wrote:
> On 12/4/24 04:12, Alex Williamson wrote:
>> On Tue,  3 Dec 2024 21:35:39 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> This patchset extends the support of legacy mode igd passthrough to
>>> all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
>>> Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
>>> in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
>>> driver will read this MMIO register).
>>>
>>> It also replaces magic numbers with macros to improve readability,
>>> and aligns behavior (BDSM registor mirroring and GGMS calculation for
>>> gen7) with i915 driver to avoid possible issues.
>>>
>>> The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
>>> stolen memory size to zero") is also added back so that data stolen
>>> memory size can be specified for guest. It is tested that GMS may
>>> related to framebuffer size, a small GMS value may cause display issues
>>> like blackscreen. It can be changed by DVMT Pre-allocated option in
>>> host BIOS, but not all BIOS comes with this option. Having it in QEMU
>>> helps resolves such issues.
>>>
>>> This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
>>> with custom OVMF firmware [1] and IntelGopDriver extracted from host
>>> bios. IGD device works well in both Windows and Linux guests, and
>>> scored 726 in 3DMark Time Spy Graphics on Windows guest.
>>>
>>> [1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/
>>>
>>> Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
>>> is not working on Gen11+ devices in my experiments. There is no hints
>>> about that in old commit message and mailing list. It would be greatly
>>> appreciated if someone shares the background.
>>
>> The quirks related to BAR4 access are generally for the vBIOS, we
>> wouldn't expect guest OS level drivers to use them.  IIRC this is
>> handling moving the stolen memory from the HPA to the GPA when the
>> vBIOS is writing the GTT.
> 
> Got it. I'm wondering why vBIOS still writes HPA instead of GPA when
> it's in virtual machine, maybe the address is hardcoded?
> 
>> Maybe that brings up an interesting topic.  Traditionally "legacy mode"
>> IGD assignment has been only for 440fx machines with SeaBIOS and last I
>> was aware edk2 wasn't willing to accept the same hack for the BDSM as
>> we had put into SeaBIOS, instead indicating that it should be
>> implemented in the device ROM.  Your branch in [1] above seems to
>> indicate edk2 does now have assigned IGD specific code.
>>
>> Are these patches developing full stack support of these new devices,
>> from BIOS hand-off, through pre-boot environments, and through to guest
>> OS drivers, or are we only concerned that the guest OS level driver
>> lights up a display?
> 
> Yes these patches provide a complete legacy mode passthrough solution,
> from EFI DXE phase to guest OS, but the EFI part requires specific
> changes in edk2.
> 
>> If you're using q35 and OVMF then you must be operating in the realm of
>> the mythical "Universal Pass-through" mode that I thought Intel had
>> abandoned.  It seems like we need an update to docs/igd-assign.txt as
>> it's likely very out of date based on recent improvements here and by
>> Corvin.
> 
> Actually the only machine supports legacy mode is i440fx, windows driver
> checks the vendor and device id of LPC bridge device at 00:1f.0, if it
> doesn't match, display driver won't work [1]. On q35 machine, there is
> already a emulated ICH9 LPC at 00.1f.0. Previous there was a try in
> modifying the id, but it breaks functionality [2].
> 
> [1] https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/lpc.c#L519
> [2] https://lore.kernel.org/all/1457080913-30018-1-git-send-email-kraxel@redhat.com/
> 
> I had a try "Univerisal Pass-through" mode as igd-assign.txt with my
> UHD 770. On linux guest, it works just as a normal gpu, except there
> is no display output before i915 driver loaded. Even the device's vbdf
> is not 00:02.0, and i915 log shows the DSM is 0M, it works perfectly.
> intel_gpu_top shows igpu is working when I am playing a youtube video.
> 
> I also tried setting primary gpu in bios to discrete gpu, which makes
> the pci class code of igpu changed from 0x030000 (VGA compatible 
> controller) to 0x308000 (Display controller), it can still output to
> monitor connected to it on Linux guest. All with a simple
>     -device vfio-pci,host=00:02.0,id=hostdev0
> 
> But for windows guest, I never had any luck. I attached a virtio-gpu to
> it, with intel grahics drivers installed in guest. If igd is not at
> 00:02.0 or gop driver is not provided, windows BSOD immediately on boot

After further investigation of the i915 kernel driver and additional
testing, I found out the root cause is the VBT inside opregion. VBT
seems to contain configs like how the igd output (Intel call it DVO) is
mapped to physical ports. If VBT is not present, i915 driver is able to
mock one (in drivers/gpu/drm/i915/display/intel_bios.c:init_vbt_missing_defaults).
However, windows driver can't, reporting error 43 in device manager or
BSOD. Adding x-igd-opregion=on makes windows guest happy with the UPT
mode. My previous success on linux was just luck, my platform doesn't
has much difference with intel default configuration. OpRegion should
be a must for igd passthrough.

The PCI class code difference is only about whether the device is
chosen as the primary output in BIOS and is mapped to host VGA memory
range or not. The class code change is also observed on intel discrete
GPUs like A750. Both mode can have OpRegion present. Currently kernel
side only probes OpRegion when igd is in VGA class code. I submitted
a patch [1] to enable the probe for display controller mode, both
linux and windows guests can have output to monitor in this mode.  

Probably legacy mode means VGA support at first?

[1] https://lore.kernel.org/linux-kernel/20241229155140.7434-1-tomitamoeko@gmail.com/

>> Also, are you proposing the noted edk2 change upstream?  It seems like
>> edk2 would need some sort of device version detection to know whether
>> to use a 32 or 64-bit BDSM value.  Thanks,
>>
>> Alex
> 
> I'm afraid the answer is no, these edk2 changes are not fully open
> source as they were taken from inten directly [3], except the last
> patch. (It seems intel uses a modified qemu as "etc/igd-dsm-base"
> used in patch 5 doesn't exist in qemu, probably they are creating
> a identical GPA->HPA mapping for igd?).
> 
> One of these intel edk2 patches is also included in a edk2 bug [4] and
> markd as hack.
> 
> Besides these edk changes, GOP driver is also needed. Intel never
> released them to public. Even acrn hypervisor developed by intel says
> "Fetch the VBT and GOP drivers from the board manufacturer". The only
> way for users to get it seems to be using tools like "UEFI BIOS
> Updater" to extract driver from host bios image, or try the luck by
> downloading the gop driver shared on internet.
> 
> After having the GOP driver, a virtual rom for igd device in qemu
> can be created by
>     EfiRom -f 0x8086 -i <device_id> -e IgdAssignmentDxe.efi \
>     PlatformGOPPolicy.efi IntelGopDriver.efi
> IgdAssignementDxe.efi and PlatformGOPPolicy.efi are built with the
> edk2 changes.
> 
> I'm not sure whether this can be added to official document.
> 
> [3] https://eci.intel.com/docs/3.0/components/kvm-hypervisor.html#build-ovmf-fd-for-kvm
> [4] https://bugzilla.tianocore.org/show_bug.cgi?id=935
> 
>>> Changelog:
>>> v2:
>>> * Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
>>> * Fixed conditions when calculating GGMS size.
>>> * Added Gemini Lake and Comet Lake device ids.
>>> * Splited mirroring register declaration macro into a new patch.
>>> * Minor fixes.
>>> Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/
>>>
>>> Tomita Moeko (9):
>>>   vfio/igd: remove unsupported device ids
>>>   vfio/igd: align generation with i915 kernel driver
>>>   vfio/igd: canonicalize memory size calculations
>>>   vfio/igd: add Gemini Lake and Comet Lake device ids
>>>   vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
>>>   vfio/igd: add macro for declaring mirrored registers
>>>   vfio/igd: emulate GGC register in mmio bar0
>>>   vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
>>>   vfio/igd: add x-igd-gms option back to set DSM region size for guest
>>>
>>>  hw/vfio/igd.c | 248 ++++++++++++++++++++++++++++++--------------------
>>>  1 file changed, 151 insertions(+), 97 deletions(-)
>>>
>>


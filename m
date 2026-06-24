Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46618CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcH64-0005Jw-2R; Wed, 24 Jun 2026 02:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcH61-0005Jj-SS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcH5z-0002xx-Tp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782282502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1Bj+iDpJIM8j4zLFnpipNbIleBUYnLF0njZwTWLS1DU=;
 b=L0nHmhpw9H6c3lRSCCkPq/h2/NzxgnFHjrFxPApJxx1+54uPBI9A4Jn7pVmi3k6ee/5SgA
 JUwutNyKZJAVpkujCzou8TzPda98UFqOszs97pWpTh3MGzHhzz4m7++euP9dT8AecM0CaW
 zW3p6B9YbkdN4/yXLm34nFhlTyHK0Hs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-tWgIE0jWPBOYR8IOw3wF4w-1; Wed, 24 Jun 2026 02:28:21 -0400
X-MC-Unique: tWgIE0jWPBOYR8IOw3wF4w-1
X-Mimecast-MFC-AGG-ID: tWgIE0jWPBOYR8IOw3wF4w_1782282500
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-463aaa77ffeso405636f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782282500; x=1782887300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1Bj+iDpJIM8j4zLFnpipNbIleBUYnLF0njZwTWLS1DU=;
 b=mqDYFFKQzI8wz8YBnYWwkkUHjZOhasg2u0jxcOyhHikWs2AmuBWKg/mxUu759RqgNA
 Ac7YLltQip2GePDgiLCK1ODB3+WFpuNnoRrn+EM+MRDpwdMpfFNrKyw9148GJFOsORsC
 yeTn6jZANwAngU7YNkP8LvXn3kHBQVTxAjBvnJLt0hS3MEVooryM54pgxeWjFfYD/Mz/
 GsjkE8ci8NuK+uICH5Z3kPm9xw+fwk52Uj0dO+zctfkH8Lr5v4MxaVZ/J7Ygy/9W7G9C
 cN7GDvaK/U1wXVE75n/z9TBQWW4VvNKjtyFqkVIF0BUfenoFChJvJnvbIpA/6UASSHv0
 MgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782282500; x=1782887300;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Bj+iDpJIM8j4zLFnpipNbIleBUYnLF0njZwTWLS1DU=;
 b=oZ4Rpwt+QDm0faq4cqyymoFVjm6eCvrHREc1c+7NLAVj9z6lxKCXQSdRlP6J8laJmE
 eJmE2p9YweTRpzmyCqvjSY1ZjWDuS9KUPH63i0vZEs4TQMYD6gnKjYFOSyKwDeYBMM+s
 ctwBvvxz6h9xePJD2ikDIpq9Okk5+WIh7RWUPsAZBh89n79qsCtNvLc05DTno90SlbHc
 j/ICE8F8Fw76rCRj6RGhRZkBHQ3L7ihusLqP0z2fPq+++7H2+xXjzLchjL4dYgqmh7Vp
 vOdpRnHZKIcsZff09R78MjnG4t+od/rwujqS4l8kTjUvZUnZeSL5AoqvcqKwj5axepC5
 TNdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK5+lBKzeixYTnTUMB57LlRr8SKSHd+5576Gr6pyLcGhCAqaf8R3WAYcC2sPYcTmgJZisRwqEKCuQE@nongnu.org
X-Gm-Message-State: AOJu0Yz00/ZY1ERxvBLfUsKitcfrNQUwKMeUioBoGBY/SpniG5kkSGmG
 Ahjwxi3GuzYtbyo9PP+tnceKzNIePyOJ5cVHDH3wFaOPUpIuzVxPHQ/ucJpM1oCL50YFfog4J6k
 9GAMsjA1Z4R/b+xqrFkh+KwepwbLXoi+9yYygY6YrH+H2ZSFl4M7G7tx2
X-Gm-Gg: AfdE7ckFUahbd9uTsigqTUZxaySnXswOivm6aL3p4DywzHDSTWki/xRp98fApiTVfE5
 9/3y0P8lRdcXaoOcayO7srTzeXPLZwWIAseZeN9t5X9q6uj+plLmqBXr+2yUzjInW1CeYuXwWUO
 8pjsNHWIvP7tuQgl2lTsuCIL2bLjZnL4rvNagrIAGtkMMQ7I0BZ6nf5aH0/DMGhOO00pNjN5Lgv
 s6FqvnzRqBpekP4BiFHuALAMJDhDS4WtZImLmTGkHUA8Vyc5q16UgFg2OVR7CVTBZAINMKgtoLk
 Rw/C9Wjlk5puzF27urnOOt7ZhEqNCGNWOoaKUhkZHukB3vqE+I2WDmpH/HBmXvbBetk1zd5YGQV
 9JkZIoJZlgxLhNV5RycsDQaXRNMHaitaqw2TuAnFJrcyrFXjrrww6h1I=
X-Received: by 2002:a05:6000:4007:b0:452:8286:86bf with SMTP id
 ffacd0b85a97d-46c09ec8318mr2808520f8f.1.1782282499908; 
 Tue, 23 Jun 2026 23:28:19 -0700 (PDT)
X-Received: by 2002:a05:6000:4007:b0:452:8286:86bf with SMTP id
 ffacd0b85a97d-46c09ec8318mr2808469f8f.1.1782282499337; 
 Tue, 23 Jun 2026 23:28:19 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6?
 ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c6csm4112999f8f.14.2026.06.23.23.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 23:28:18 -0700 (PDT)
Message-ID: <463baf73-6d03-4ae4-84be-97a0dc6ea4c5@redhat.com>
Date: Wed, 24 Jun 2026 08:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, K S Maan <kirandeepmaan45@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Michael,

 From a VFIO perspective, this series seems ready. However it does
impact the PCI subsystem. QEMU will now calculate and correct the
checksum of a ROM of any PCI devices and it's a behavior change.

Could you please have a quick look and possibly ack ?

Thanks,

C.

On 6/17/26 12:06, Tomita Moeko wrote:
> This series fixes the regression that on IGD passthrough with legacy
> BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
> (which uses standard VGA output routines), starting from QEMU 10.0.
> Though the kernel i915 driver still works, it reports an error about
> the initial GTT programmed by VBIOS is using invalid address.
> 
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
> 
> With the help of AI disassembling the VBIOS image dumped from host, it
> is found that the VBIOS itself implements a routine like:
> 
>      uint32_t get_BDSM() {
>          static uint32_t saved = 0;
>          if (saved != 0) {
>              return saved;
>          }
>          return read_pci_config(BDSM_REG);
>      }
> 
> And the saved value is not cleared after initialization. Given that IGD
> devices don't have a real ROM BAR, the VBIOS image read by default from
> host is actually the VBIOS shadow RAM region, containing host-side
> modifications like the saved BDSM value above during POST. When the
> image is executed in guest, it still uses the saved host BDSM (HPA)
> instead of the value programmed by SeaBIOS in config space (GPA). This
> address mismatch leads to the garbled screen and i915 error.
> 
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
> to guest, a ROM quirk clearing the saved value in VBIOS image is
> introduced to fix the issue.
> 
> During debugging, it is also found that IGD VBIOS ROM doesn't always
> match the actual IGD device ID, due to the fact that IGD of the same
> CPU family has multiple device IDs but shares the same ROM image.
> However, SeaBIOS checks the device ID strictly and refuses to run if
> IDs does not match. Currently only the default path, reading ROM from
> kernel patches the device ID, but the romfile path doesn't. So the ROM
> ID patching logic is also refactored in this patch series to also handle
> the romfile path.
> 
> These changes are tested on Haswell platform with legacy BIOS boot, by
> K S Maan. Thanks to K S Maan for continuous help on locating and testing
> the issue!
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> 
> Changelog:
> v3:
> * Refactor ROM checksum calculation and patching logic as Alex's comment
> * Fix boundary checks as comments in v2.
> Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t
> 
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
> 
> Tomita Moeko (7):
>    hw/pci: Recalculate option ROM checksum before patching ID
>    hw/pci: Skip EFI option ROM in pci_patch_ids()
>    hw/pci: Introduce rom_need_patch_id flag in PCIDevice
>    hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
>    vfio/igd: Toggle rom_need_patch_id flag on IGD devices
>    vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
> 
>   hw/pci/pci.c                |  57 ++++++++++------
>   hw/vfio/igd-stubs.c         |   5 ++
>   hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
>   hw/vfio/pci-quirks.c        |   5 ++
>   hw/vfio/pci.c               |  33 ++-------
>   hw/vfio/pci.h               |   3 +
>   hw/vfio/trace-events        |   1 +
>   include/hw/pci/pci.h        |   3 +
>   include/hw/pci/pci_device.h |   1 +
>   9 files changed, 186 insertions(+), 54 deletions(-)
> 



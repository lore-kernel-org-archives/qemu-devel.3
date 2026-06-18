Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7889FCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa6mA-0007FM-Nj; Thu, 18 Jun 2026 03:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wa6m8-0007F8-VN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:02:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wa6m6-000128-QM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 03:02:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8452f5d0ec7so12518b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781766173; x=1782370973; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/OxzKDIke/mxOvJ5kbFclYQTapU++tTH17VFjS14Gg=;
 b=iOypvSPlTYKFle5TIn2motbqH4ypWnCSuIRMoIRrQfO+KB+dmrDEmkJAF7wKezfDpW
 oGLMzMA0Akv9C3kBAtwzy6P3FoiEA9dVY2D2uAghAC7gn86TvrjuVvlXutA55S61rr35
 DGm7WF1lRzXTAlH76us5JYKWwqbRA+npHwS2GxZpLwCdfuAWQLXDE1oY3iYKJNOcvVtR
 TpLX0T0ARZU4Itx8uEnTS5Lq2FzgRHiQqJT5NZdxsfAHXNfOlkkSsmc9LBJ7DJgABiT9
 q8/HUBHF4LQyLpRL3Wltknzxz9rO07PQXxoa2DOpRX4mI8bdX1vlf2P5F05WRz56DXqX
 82Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781766173; x=1782370973;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/OxzKDIke/mxOvJ5kbFclYQTapU++tTH17VFjS14Gg=;
 b=SnVJLa2eeP01pux/X9/54r015hWOyd2cQjYsErc9Ox2PHVgMJ1NJfGK3Vz8EH+Mrp6
 mssg5Wmdi31p8chQMn1+P7JXMBUipdyR8qwxSBOHfJNSUWszb7QYBy66hvtpZUBMruf3
 AZo6zk5owIzswgq3Hw4X6MbXhuKnulY86vagMll1N1kdTi76ihLK9cnWV/9yqqJmarLg
 kjPNnIVsZfMi1BaeX9p6hxU9AHsWnvALZQk9Oq1nvfGCb6eJwMBg6heVfsNB+H5qrPmu
 sfgUK6AS6Esr5ZXGUqERjWgHkjLspUNFylmE68MuxfnGHDCwKKNMsB1CutsLsP2+YfTD
 2Hew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jvhVrrDzzKjiEjYg87/ctPyTCl/QcD4zY1rsxBKUorQBnlr1krQf1NKLrJR1jhYU/YGhAq+we7PNC@nongnu.org
X-Gm-Message-State: AOJu0Yx5XKdt0aMEjvEIHbEnyZtPHf2OyyBHMxSwcroEiRnLixkiVjMy
 JmqFHk5LLxhSwL/xfWKptsfHujRb6R0U93TSZmNIcV8lgvLs5/syl9dw
X-Gm-Gg: AfdE7ckwpFQ4yoZNaNsVBOvdo6SkeBisqj30PdeU9NXSgnQ02jxXtaM53NVKqaHYyLy
 ZHkUuSu/N68J9dST59H08wVYCbETAE98rbshMZCDq1hoS03hiVb7VPwjRChphIN4klJL5UiDW7T
 2fQKJCRwGMD0eU+tAeRQFKVsdQm9GgKs3aayOkcAIfyoN5x1J464Rm3domJCHORrs3/dxBtY4c6
 WYIUXSzqQXqZfaVXXzpnJP40eKsqcofrhjjCjnpQ5n8BokRo8UV70NAjwkni/IgRcseKebpmcPt
 Dh7fnaTxMfPvR43pzyh3UfrefSxj895fQc6qILje0dieJWxX/Ng3CIOI/456uYJ11kSICtQcu0Y
 OiXljIHwCAtGWbwhle44I1KUNRVTBrDubMUnDNPu6nz9QowH5zg5d9FQBVn8QAZEzCKfbZroNpP
 JL/qeVWiDB21tYIoNV5ODk3AyP5RM=
X-Received: by 2002:a05:6a00:14ce:b0:83e:f208:b11d with SMTP id
 d2e1a72fcca58-8453b2402afmr1253290b3a.6.1781766172647; 
 Thu, 18 Jun 2026 00:02:52 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:4939::71? ([2001:4490:484d:4939::71])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b02268bsm21724461b3a.46.2026.06.18.00.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 00:02:52 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------BTr5z1Z5snyws60VMQJouIXd"
Message-ID: <9268e0d9-c62b-4b9e-9d7b-d15bb4ecbdde@gmail.com>
Date: Thu, 18 Jun 2026 12:32:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------BTr5z1Z5snyws60VMQJouIXd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: K S Maan<kirandeepmaan45@gmail.com>

On 6/17/26 3:36 PM, Tomita Moeko wrote:
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
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan<kirandeepmaan45@gmail.com>
>
> Changelog:
> v3:
> * Refactor ROM checksum calculation and patching logic as Alex's comment
> * Fix boundary checks as comments in v2.
> Link:https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t
>
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link:https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
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
--------------BTr5z1Z5snyws60VMQJouIXd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre
style="overflow-wrap: anywhere; font-size: 13px; font-family: monospace; background: rgb(0, 0, 0); color: rgb(204, 204, 204); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Tested-by: K S Maan <a class="moz-txt-link-rfc2396E" href="mailto:kirandeepmaan45@gmail.com">&lt;kirandeepmaan45@gmail.com&gt;</a></pre>
    <div class="moz-cite-prefix">On 6/17/26 3:36 PM, Tomita Moeko wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260617100646.28326-1-tomitamoeko@gmail.com">
      <pre wrap="" class="moz-quote-pre">This series fixes the regression that on IGD passthrough with legacy
BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
(which uses standard VGA output routines), starting from QEMU 10.0.
Though the kernel i915 driver still works, it reports an error about
the initial GTT programmed by VBIOS is using invalid address.

i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])

With the help of AI disassembling the VBIOS image dumped from host, it
is found that the VBIOS itself implements a routine like:

    uint32_t get_BDSM() {
        static uint32_t saved = 0;
        if (saved != 0) {
            return saved;
        }
        return read_pci_config(BDSM_REG);
    }

And the saved value is not cleared after initialization. Given that IGD
devices don't have a real ROM BAR, the VBIOS image read by default from
host is actually the VBIOS shadow RAM region, containing host-side
modifications like the saved BDSM value above during POST. When the
image is executed in guest, it still uses the saved host BDSM (HPA)
instead of the value programmed by SeaBIOS in config space (GPA). This
address mismatch leads to the garbled screen and i915 error.

The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
to guest, a ROM quirk clearing the saved value in VBIOS image is
introduced to fix the issue.

During debugging, it is also found that IGD VBIOS ROM doesn't always
match the actual IGD device ID, due to the fact that IGD of the same
CPU family has multiple device IDs but shares the same ROM image.
However, SeaBIOS checks the device ID strictly and refuses to run if
IDs does not match. Currently only the default path, reading ROM from
kernel patches the device ID, but the romfile path doesn't. So the ROM
ID patching logic is also refactored in this patch series to also handle
the romfile path.

These changes are tested on Haswell platform with legacy BIOS boot, by
K S Maan. Thanks to K S Maan for continuous help on locating and testing
the issue!

Resolves: <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/work_items/3093">https://gitlab.com/qemu-project/qemu/-/work_items/3093</a>
Reported-by: K S Maan <a class="moz-txt-link-rfc2396E" href="mailto:kirandeepmaan45@gmail.com">&lt;kirandeepmaan45@gmail.com&gt;</a>

Changelog:
v3:
* Refactor ROM checksum calculation and patching logic as Alex's comment
* Fix boundary checks as comments in v2.
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t">https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t</a>

v2:
* New patch 2/7 to fix regression with EFI option ROMs
* Refine logic in ROM ID and checksum patching
* Reorder patch 4 and 5 for cleaner bisection
* Address comments from v1
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t">https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t</a>

Tomita Moeko (7):
  hw/pci: Recalculate option ROM checksum before patching ID
  hw/pci: Skip EFI option ROM in pci_patch_ids()
  hw/pci: Introduce rom_need_patch_id flag in PCIDevice
  hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
  vfio/igd: Toggle rom_need_patch_id flag on IGD devices
  vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |  57 ++++++++++------
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |  33 ++-------
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci.h        |   3 +
 include/hw/pci/pci_device.h |   1 +
 9 files changed, 186 insertions(+), 54 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

--------------BTr5z1Z5snyws60VMQJouIXd--


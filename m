Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F357DC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8hlF-0007NW-9o; Mon, 21 Sep 2026 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x8hlE-0007NO-6w
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:25:00 -0400
Received: from mail-pj2-x00.google.com ([2607:f8b0:4864:39::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x8hlC-00031E-Bt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:24:59 -0400
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-39b2ad83680so1388101a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790011496; x=1790616296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UXflAh2RucVWJUi4MrFRr1Khjdw5VpbmcboKwc0RgOw=;
 b=BMNQg4+AjAXK1eNWvlF3ncA2DXZcyKcprx/3Lr4/jxEHJ/oSycV9rYSx1XjXPSLWsc
 jh5Hb3629aQfexbjJjg+wKi5c9UJftpD3q13uBOTKJPEfzJeWjVmLLEDMR5KTTWUTLbO
 PuQ0OGjNLIOOg4DXyRqFcOwLezbWkYH1GzpN1tY+IOjlxGnCgLVsVRoWND0iKORPehcz
 21EeV9CDxdT7MLmRSTj0wI6Y6mxwNosbLGjFF97KgaaWfYOTtpHLev0TkXxdjk9FSU/P
 HuJPOVRr9zvCcIdw4BEtgVER1La4GHjHoksYtXgur8XQc8BvNKtMfMv5vPWKngHSvqR6
 DbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011496; x=1790616296;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UXflAh2RucVWJUi4MrFRr1Khjdw5VpbmcboKwc0RgOw=;
 b=QTWuigbBwldqKuDRTCijowH3t1flkv0WHJ+WoAd5I9KC28DXTEgY2/YKkawbSQN66f
 XTtF65J2PAswwgJua+fe/yyRjoo9HUmRRM68g9VNn2O7tF1C5IO9agH9t8IzpW5TbPpg
 IvMPcofwsdq8iiFqXBqkjj5wc293L/jWlUyQZF9YHdEzfK0w80RYqTuR+/UHoboOr8Ta
 Zu7wHtWqZgV7uX+vYKeOM3cMf+q5m56tcXEGG0t4YFVdrOk2jV+gcyM5ZBG2FBMNqLl/
 E3K8reHD0+BCyHACu9iBoZNYFqBunYwIT8v7+4qzPpGyULAB7EFjpcesDy2dMhfCOGNe
 D3Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5VBkpM8ZEZZqRUr+nBuyRfTzwD62RVGWEWwAaAhejgYQ2vEptdjucS+Dn/mWPhu3t/IALLtel7Lbj@nongnu.org
X-Gm-Message-State: AFuF++l69wvFkQInpPUJlf/Zf+9temkxcX/qP2nqkkH68u05LprEQast
 ReUXBsXhv2WrjVAl7xkm00wWMdFMNu0YNJAxex+7/JkNLXYzbHs7c7s=
X-Gm-Gg: AYBFou3oaetQgO+2nK370uRj0uswTDinZuhiuomIqeM4e+uybww+8W7Kc7S9jtRuGtU
 /VtSC2AFP4m5gSzb77YNAndbegnHnl0UuP9R3bolXn+g6VXA0DAVRSd2RIjWDCObJ2iT7ySxPTr
 S9/YUxc28grawXdFrwRr9IZ39x1s8z2KlYC2aEM17242wtYzVERIHYjen0ZJjjNKI6fUR3RCKD0
 yH4+j7+fitO4LCHg51knK3glA4gypwL3rmiwMGubq4SUZXgwHnD0LMgcVr0v5wUOZkL/WG2TASd
 /7GlYm3KRi+FhNRpxXpx4KndtnsOdlmh8buyuuP64k8wC03sKVlV8jOFPEBCK18Wz9EXiK2E+L9
 MtzFSMSA6PyrQbIxduaTpoTA0el/y9pUWU+inKQ3KrM1Gd8wYM71et2QyzzcO59wcnAY2OAWubG
 aLTegT5AeHQ/DxIvZZvsb22BFBxzawcEha3dt74XJheQoWXwhUHw/aDCsDuo4OZSy2dNK/Ob9Er
 4qI0x0mJs82fmPhEUvgJNQO6RLHej8VZICFkvtx5QYF2tJZmiUzap4=
X-Received: by 2002:a17:90a:c089:b0:39e:6c68:155a with SMTP id
 98e67ed59e1d1-39e6c683333mr9006779a91.34.1790011496316; 
 Mon, 21 Sep 2026 10:24:56 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:2c98:278a:784b:d214?
 ([2408:820c:8ffa:c0f0:2c98:278a:784b:d214])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a02625615dsm5386521a91.2.2026.09.21.10.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 10:24:55 -0700 (PDT)
Message-ID: <8d0de268-e9ef-471e-9a32-ead628d75713@gmail.com>
Date: Tue, 22 Sep 2026 01:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, bosheng.xue@intel.com,
 junjie.cao@intel.com
References: <20260921073809.2658872-1-yuan1.wang@intel.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260921073809.2658872-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x00.google.com
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

On 2026-09-21 15:38, Yuan Wang wrote:
> Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
> detect whether direct framebuffer access via DSM is available.
> 
> In a VFIO passthrough VM, the guest cannot access the host DSM memory
> region via such a pointer. If the guest GOP enables that path, it may
> hand off a DSM-based framebuffer address that the guest cannot actually
> use.
> 
> Intercept reads from the detection register and return 0 so the guest
> does not enable the DSM-based path and instead keeps using the standard
> BAR-based framebuffer address.
> 
> Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> Changes:
> v3:
> - Emulated register 0x138914 to return 0x0, which signals the guest
>   GOP driver to fall back to BAR-based mapping since DSM is
>   unavailable in the VM.
> 
> v2:
> - Resending because the v1 patch was sent with an incorrect future
>   system timestamp due to an unsynchronized local clock. No code
>   changes.
> 
> Notes:
> MTL/ARL device IDs remain in igd_gen().
> This is required because vfio_probe_igd_bar0_quirk() checks the
> generation before installing BAR0 quirks, and the 0x138914 quirk
> is added afterward.
> Meanwhile, we also plan to remove the bdsm-size check in the OVMF
> offline patches.
> ---
>  hw/vfio/igd.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 413a49aae9..f6a2eab805 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>      case 0x4C00:    /* Rocket Lake */
>      case 0x4600:    /* Alder Lake */
>      case 0xA700:    /* Raptor Lake */
> +    case 0x7D00:    /* Meteor Lake / Arrow Lake */
> +    case 0xB600:    /* Meteor Lake */
>          return 12;
>      }
>  

0xB600 is for Arrow Lake according to include/drm/intel/pciids.h.

    #define INTEL_ARL_S_IDS(MACRO__, ...) \
        MACRO__(0x7D67, ## __VA_ARGS__), \
        MACRO__(0xB640, ## __VA_ARGS__)


Meteor Lake is Gen 12.70, while igd_gen() only tracks the major generation.
Here Meteor/Arrow Lake and existing devices are all Gen 12, but different
quirks are applied, making it look a bit awkward.

Maybe the generation could be extended to 4 digits, or use flags instead.

    case 0x4600:    /* Alder Lake */
    case 0xA700:    /* Raptor Lake */
        return 1200;
        return IGD_FLAG_GMCH_GEN8 | IGD_FLAG_GMS_GEN9 | IGD_FLAG_QUIRK_BDSM_GEN11;
    case 0x7D00:    /* Meteor Lake / Arrow Lake */
    case 0xB600:    /* Arrow Lake */
        return 1270;
        return IGD_FLAG_QUIRK_MMIO_138914;

Anyway, this is outside the scope of this patch, just a note for possible
future cleanup.

> @@ -454,10 +456,32 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>  
>  #define IGD_GGC_MMIO_OFFSET     0x108040
>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
> +#define IGD_BDSM_ACCESS         0x138914

nit: perhaps rename this to IGD_MTL_PCODE_STOLEN_ACCESS to match i915.

> +
> +#define IGD_IS_MTL_OR_ARL(vdev) \
> +    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
> +     (((vdev)->device_id & 0xff00) == 0xb600))
> +
> +static uint64_t vfio_igd_bdsm_access_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void vfio_igd_bdsm_access_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps vfio_igd_bdsm_access_quirk = {
> +    .read = vfio_igd_bdsm_access_read,
> +    .write = vfio_igd_bdsm_access_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
>  
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
> -    VFIOQuirk *ggc_quirk, *bdsm_quirk;
> +    VFIOQuirk *ggc_quirk, *bdsm_quirk, *bdsm_access_quirk;
>      VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
>      int gen;
>  
> @@ -472,6 +496,23 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>          return;
>      }
>  
> +    /*
> +     * MTL/ARL guests must keep using the BAR-based framebuffer address.
> +     * Return 0 at 0x138914 so GOP stays on the standard access path in the VM.
> +     */
> +    if (IGD_IS_MTL_OR_ARL(vdev)) {
> +        bdsm_access_quirk = vfio_quirk_alloc(1);
> +        memory_region_init_io(bdsm_access_quirk->mem, OBJECT(vdev),
> +                              &vfio_igd_bdsm_access_quirk, vdev,
> +                              "vfio-igd-bdsm-access-quirk", 4);
> +        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                            IGD_BDSM_ACCESS,
> +                                            bdsm_access_quirk->mem,
> +                                            1);
> +
> +        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_access_quirk, next);
> +    }
> +
>      if (vdev->igd_gms) {
>          ggc_quirk = vfio_quirk_alloc(1);
>          ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));

Overall it looks good to me, with the minor nits above.

Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>

Thanks,
Moeko




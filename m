Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DE2C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmt1d-0007zN-8E; Thu, 23 Jul 2026 08:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmt1T-0007y2-EC
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:59:35 -0400
Received: from mail-oi2-x04.google.com ([2607:f8b0:4864:32::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmt1R-0003FO-EM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:59:35 -0400
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-49ec9d117f2so48879b6e.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784811561; x=1785416361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HnDz+RRGFbRJF2KyXMK4b0dfxuXcFwcqC1G0tz01EkY=;
 b=ia1D3CaVtCKc8ksOkgyV1RUOavbWIgFXhXPOODdeRvG1yykTrf3T7yDKZpb0d74nyg
 N7iBiE3bbGfOgldpNkI9HGHLorfCxqKXCTHffTmbmgDLg531HVfLI2V4f/pGNFfvCvsf
 P3rGxWhoaEv9Jdl7lbvhtFl7nVLv7YMyXsu4QMQZeFV1hKp/k6Il/PWROvm+dR0CwQCM
 Bhhtq2srKQIZsdtab9aaONK9CDdY7Q7K9QkHeSsLOE6tmiawo6SvGlyx0cGDR7Anta6s
 jphTWCpyCmUI0Tt656R3+gzwgpB7cR6d3UEjcTGG/G+yHtZvFYYnORKZwG65eqdpom3P
 xRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784811561; x=1785416361;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnDz+RRGFbRJF2KyXMK4b0dfxuXcFwcqC1G0tz01EkY=;
 b=j7+OirKjVjVmELRpvL42RFnPXSU+lcVBoWqXV8wSGE3R+ZbnGqbhyBfp6GVPQgWyHT
 7mMuEN95u5PALzw1XaVSrYvqZOzyjDQDgCLUXlPICfXQy61Qni9CltYcU5DbKVqHn1MC
 6e8ZzO/nypgPDSIhimyfrWI2gDbGSUmJ8Cp8o9DR9EyCthwLw7T2VWyCcYOlV6PeLScs
 7JS40b5cz2BGq6nhimsqF3x7Z5zjDJlmqGQu7aTWv4IexGTXvA9TXlLheZsItyE3TvyY
 rAsuNttC42kgq2M817v4DqK3JElp1fxISRzoB/YU0fVzOUzbo1TrGBwGulD3gvciahdO
 9/cA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHIupvajnlmqAZAg76yaPmSQVmL7z/R4m7yVI4gaPkOkJ4R6jSkAH6RashIOhoN4CWZiLaOpAHkHgt@nongnu.org
X-Gm-Message-State: AOJu0YyYOuzIsHRJ/o7F4Dap2qOIxgMtTlVC/oqrjQyOV1FUiBtmAZVc
 hKSX6FKmSO3QHMjT1qVhd2GTirqAYdkvqyMyGeucllm369aDl3ECSHE=
X-Gm-Gg: AR+sD124E5sdvl0fkNjewg/8GRY9y0m7vf26tlgVLz1gnWYwjFA3BFfAUISmJEulNxv
 bEGSotOXxbwyzy2UIJY5Ap7e+2nRPZ2DR0Xw63ucBJG3e9S+463KggoojKJZA1Mj1m0cn6RbclQ
 vkaE8l8WafS9Cbx9daajMF4LtWeZ/m4XOnqcyhCJoxbNbZ+v41CSA7DD0R/0Qx8TYEALWeNJjFf
 ccYvS6AMTC9bSCxE9NsFn8SQfOoshqOZcDBJ/J5vAEMXxpgbmOnRaQiZ/w+4u9Oi/FxavA6b5Wl
 6rHHiawBAF48nypFDkR+5im7E0LJ8iaryxdjZttYWkurBlfp1AUrGuJ0u1RMwJmXHQsOd8nzTpF
 TItIaQq1T6dyjSC98rQ303OloSwgLhOWJRWCGXvCbVWlerRqlh574ag/+7lAEeJzO7AcNeNbBZm
 tD/BusoUYVxH/qYdb4Y1elIH6bW5Wvwx0Ds/sROhvYTjjtkYYucQaJ2/Gj8Q==
X-Received: by 2002:a05:6808:150e:b0:4a0:93e4:e15b with SMTP id
 5614622812f47-4ab3544e310mr1500250b6e.24.1784811560913; 
 Thu, 23 Jul 2026 05:59:20 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a?
 ([2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0f2c96easm2949318b6e.17.2026.07.23.05.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 05:59:20 -0700 (PDT)
Message-ID: <e7b38b86-fde1-400d-ae5f-5b2ad0b4cb6e@gmail.com>
Date: Thu, 23 Jul 2026 20:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
To: mike.malyshev@gmail.com, qemu-devel@nongnu.org, alex@shazbot.org
Cc: clg@redhat.com, corvin.koehne@gmail.com
References: <20260717084942.1555442-1-mike.malyshev@gmail.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260717084942.1555442-1-mike.malyshev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::4;
 envelope-from=tomitamoeko@gmail.com; helo=mail-oi2-x04.google.com
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

Hi, Mike

On 2026-07-17 16:49, mike.malyshev@gmail.com wrote:
> From: Mikhail Malyshev <mike.malyshev@gmail.com>
> 
> On some hosts the firmware POST modeset leaves the display data buffer
> (DBUF) powered, so the passed-through iGPU's DBUF_CTL registers read
> back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent leftover that
> never occurs under GVT, which emulates the register so POWER_STATE
> follows POWER_REQUEST.
> 
> A guest display driver samples POWER_STATE to determine which DBUF
> slices are already enabled; seeing the stale "powered" bit it never
> issues POWER_REQUEST, so DBUF actually powers down, the plane FIFO
> underruns, and scanout is corrupted (vertical stripes) until a full
> modeset (e.g. a display sleep/wake) re-requests power.

Just wondering if this aimed to solve some kind of "CPU pipe A FIFO
underrun" error. If possible, could you please paste some log? The i915
driver seems to only read POWER_STATE in gen9_dbuf_slice_set(), and a
warning should be printed if there is an inconsisitency.

> 
> Present a consistent view like GVT: trap the DBUF_CTL slice registers
> (S1..S4, only as many as the generation exposes) in BAR0 and clear
> POWER_STATE on read whenever POWER_REQUEST is not set.  Writes pass
> straight through to the device.
> 
> Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
> ---
>  hw/vfio/igd.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e091f21b6a..ebe957f69d 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -455,6 +455,96 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>  #define IGD_GGC_MMIO_OFFSET     0x108040
>  #define IGD_BDSM_MMIO_OFFSET    0x1080C0
>  
> +/*
> + * IGD BAR0 DBUF_CTL sanitize quirk.
> + *
> + * On hosts where the firmware POST modeset left the display engine powered,
> + * DBUF_CTL reads back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent
> + * leftover that never occurs under GVT (which emulates the register so STATE
> + * follows REQUEST).  A passed-through guest driver samples POWER_STATE to
> + * decide which DBUF slices are already enabled, sees this stale "powered"
> + * bit, and therefore never issues POWER_REQUEST.  DBUF then powers down, the
> + * plane FIFO underruns, and scanout is corrupted until a full modeset (e.g.
> + * a display sleep/wake) re-requests power.
> + *
> + * Present a consistent view like GVT: intercept DBUF_CTL reads and clear

Here GVT means the GVT-g (kvmgt) driver under drivers/gpu/drm/i915/gvt, right?
Please correct me if I am wrong.

> + * POWER_STATE whenever POWER_REQUEST is not set.  Writes pass straight
> + * through to the device.
> + */
> +#define IGD_DBUF_POWER_REQUEST  (1u << 31)
> +#define IGD_DBUF_POWER_STATE    (1u << 30)
> +
> +/*
> + * DBUF_CTL slice registers within BAR0, in slice order (i915 numbers these
> + * S1..S4).  How many slices exist is generation-dependent, so only the first
> + * igd_dbuf_ctl_nslices(gen) entries are real DBUF_CTL registers on a given
> + * part; the rest are unrelated registers and must not be trapped.
> + */
> +static const uint32_t igd_dbuf_ctl_offsets[] = {
> +    0x45008, /* S1 */ 0x44FE8, /* S2 */ 0x44300, /* S3 */ 0x44304, /* S4 */
> +};
> +
> +/*
> + * DBUF slice count by generation, matching i915 dbuf.slice_mask:
> + * gen9/10 = 1 (S1), gen11 = 2 (S1-S2), gen12+ = 4 (S1-S4).
> + *
> + * Within gen12 the slice count is actually per-platform, not per-gen: ADL-P /
> + * RPL-P / DG2 expose 4 slices, but TGL / RKL / ADL-S have only 2.  We return 4
> + * for all gen12+ (igd_gen() can't distinguish them), so on a <4-slice gen12
> + * part S3/S4 (0x44300/0x44304) are over-trapped.  This is harmless in practice:
> + * the read handler only mutates a value when POWER_REQUEST=0 && POWER_STATE=1,
> + * which whatever register lives at those offsets is very unlikely to present.
> + * A fully-correct count would have to key off the PCI device ID.
> + */
> +static int igd_dbuf_ctl_nslices(int gen)
> +{
> +    if (gen <= 10) {
> +        return 1;
> +    }
> +    if (gen == 11) {
> +        return 2;
> +    }
> +    return 4;
> +}
> +
> +typedef struct IGDDbufCtlQuirk {
> +    VFIOPCIDevice *vdev;
> +    uint32_t bar_offset;    /* offset within BAR0 MMIO */
> +    uint8_t bar;
> +} IGDDbufCtlQuirk;
> +
> +static uint64_t igd_dbuf_ctl_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    IGDDbufCtlQuirk *q = opaque;
> +    VFIOPCIDevice *vdev = q->vdev;
> +    uint64_t val = vfio_region_read(&vdev->bars[q->bar].region,
> +                                    addr + q->bar_offset, size);
> +
> +    if (size == 4 && !(val & IGD_DBUF_POWER_REQUEST) &&
> +        (val & IGD_DBUF_POWER_STATE)) {
> +        val &= ~(uint64_t)IGD_DBUF_POWER_STATE;
> +        error_report_once("IGD quirk: DBUF_CTL@0x%x cleared stale "
> +                          "POWER_STATE (POWER_REQUEST=0)", q->bar_offset);
> +    }
> +    return val;
> +}
> +
> +static void igd_dbuf_ctl_write(void *opaque, hwaddr addr,
> +                               uint64_t data, unsigned size)
> +{
> +    IGDDbufCtlQuirk *q = opaque;
> +    VFIOPCIDevice *vdev = q->vdev;
> +
> +    vfio_region_write(&vdev->bars[q->bar].region,
> +                      addr + q->bar_offset, data, size);
> +}
> +
> +static const MemoryRegionOps igd_dbuf_ctl_ops = {
> +    .read = igd_dbuf_ctl_read,
> +    .write = igd_dbuf_ctl_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOQuirk *ggc_quirk, *bdsm_quirk;
> @@ -507,6 +597,32 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>                                          1);
>  
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
> +
> +    /*
> +     * DBUF_CTL sanitize quirk (gen9+): trap the DBUF_CTL slice registers so
> +     * POWER_STATE is reported consistently with POWER_REQUEST (see
> +     * igd_dbuf_ctl_read()).  Only trap slices that actually exist on this
> +     * generation -- the remaining offsets are unrelated registers.
> +     */
> +    if (gen >= 9) {
> +        int i, nslices = igd_dbuf_ctl_nslices(gen);
> +
> +        for (i = 0; i < nslices; i++) {
> +            VFIOQuirk *dquirk = vfio_quirk_alloc(1);
> +            IGDDbufCtlQuirk *dq = dquirk->data = g_malloc0(sizeof(*dq));

IGDDbufCtlQuirk *dq = g_malloc0(sizeof(*dq));
dquirk->data = dq;

would have better readability.

A `vfio_quirk_alloc(nslices)` might also be better here?

> +
> +            dq->vdev = vdev;
> +            dq->bar = nr;
> +            dq->bar_offset = igd_dbuf_ctl_offsets[i];
> +            memory_region_init_io(&dquirk->mem[0], OBJECT(vdev),
> +                                  &igd_dbuf_ctl_ops, dq,
> +                                  "vfio-igd-dbuf-ctl-quirk", 4);
> +            memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                                igd_dbuf_ctl_offsets[i],
> +                                                &dquirk->mem[0], 1);
> +            QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, dquirk, next);
> +        }
> +    }
>  }
>  
>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)

Thanks,
Moeko



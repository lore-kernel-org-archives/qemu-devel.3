Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9954DC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEpf-00024q-E8; Fri, 24 Jul 2026 08:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnEpK-0001ll-51
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:16:35 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wnEpH-0003ig-TC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:16:29 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso124751a91.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784895385; x=1785500185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lhz2Arr2Uylok40GSoWksVw7OiSrcITuklGyAh9r2oY=;
 b=jisEvQi9NzUbG1eDsBNwiWC942JvPVhfMrcp2bHTvg2/hYFQmr5eNzaq/OEB8KesC2
 5+mc5Xpe9eqbG7e/1GQSAZ+2Tw2FET5tPjaykzgIHs00AHi+sS6PK8MxpQUvVczAW09e
 znMzafHlgG5vzuLYMrpdtbsPh/9cqI5eVITIh3Uq4AXS4L+V8u2IiSQuaj+MnnzFh1jZ
 UloYMOgzS1o1H5yFNdt5semq90PAfYEj75bvJuuTS/8mkbIcoRH2rEzeM2+64ZgcQHrp
 sMZbdxP/g0J7jHYWxYDBaVzSF1gIsRw2fHKSCPLkgC4or6iZqEeoaYq42mCRbO8O3rQj
 fYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895385; x=1785500185;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lhz2Arr2Uylok40GSoWksVw7OiSrcITuklGyAh9r2oY=;
 b=gqYZHKinTLwUMJeyXl0gSQjpH07QUsQu7mzQXCHkt6SeijrD99ut8jzen/4mYKNVBa
 V1/FxjqR6bEaf4Iy2YaySW5KkVWIupzA8mxSsdiuaFw6s7HXANFkwbsHZDUUU4OlsFS9
 clWVRkwPo+E4noz1s/FiwrfBBoi3OboiKvTmqmoTeb8VE7jW1F9rYqyG/WwBAEn8brxL
 P5HKhg+Jp44m1ikmHK6LTwhHHhVbfJtIZnuaOaI8QP76zXIinmE3zSzb+wE6ij466ps3
 HE+WyIIVuHObr+rRplzgAC/pA86hzd/M3YJ7krMPVYaJZoi9f7imRMEd+mVDc6LCbASC
 d+ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqxp7JdoKZBN+zuMcgAaH568SxKX2K3BQOXDCrb3hEi+MVq4bQhAAgxWXmS1VRFsSQeYxdXfl8lCMUP@nongnu.org
X-Gm-Message-State: AOJu0YyLLKQgGHiqqdWBGK66lVZZ26n4kGtO2SdpIOSBegpYnju2VIo4
 sbi1gpS3YZjMaetWkh9u3b+iSsi7QE8IqK2iksk3UjU17N0Nv+naWYA+T5goxBb2RQ==
X-Gm-Gg: AR+sD100+4Et2sdOHghwcW3o1pADQ2njgNachH9SCQmK9zp9a0sSb/go+VHPsbNxhC1
 KR42c8PGEN+ruRMNmmEWZCCekCa3sWQbsoBVClOioIqMEqiH0EaQT8IsKmEMQfwjsR/Sm0A+O9V
 5TOtfijNfA9BPQyQjOhqIKwd7ZylO6aB2SXGGKDa0WSf7uyRfkWtKhmNlrVb2d9y2JL6qt7NvL0
 WkeC/jzOsQba7spBC6ujDaWBQONsQV6mhioAxlKpDwxCE3KsyRfBAMZKTbQnkUlZEIkGe+p4tBr
 Yp6gUeToBSp3+ld3tavnRcAJ6+YT8dXIBzSnQ0/lJ/p5sYsMqS7qdNe8h8h0fkkBuX315dbO3WJ
 8J4MQupp5bIy2CQCynp/VlROgfu7g7aGeEqucUTLgMegju9n6gpdsMxIx7ely3mmihMzXtfccLW
 Moyw1RS7FEHbnXJ3lmRm8JNFMk3WX/0cOqq27gxqzB6l/tzsqBzCq2lrEgiQ==
X-Received: by 2002:a17:90b:4c8c:b0:38e:47e0:3ddd with SMTP id
 98e67ed59e1d1-38ec65da07emr7244995a91.34.1784895385365; 
 Fri, 24 Jul 2026 05:16:25 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a?
 ([2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13014d27sm26598579c88.4.2026.07.24.05.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 05:16:24 -0700 (PDT)
Message-ID: <c26d9e50-16ce-49ff-926a-ea64683668b1@gmail.com>
Date: Fri, 24 Jul 2026 20:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
To: mike.malyshev@gmail.com, qemu-devel@nongnu.org, alex@shazbot.org
References: <20027e4f-5a4d-4842-a60d-cd83a5755cff@gmail.com>
 <20260724102959.1043264-1-mike.malyshev@gmail.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260724102959.1043264-1-mike.malyshev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x01.google.com
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

Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>

Thank you for your contribution!

On 2026-07-24 18:29, mike.malyshev@gmail.com wrote:
> From: Mikhail Malyshev <mike.malyshev@gmail.com>
> 
> On some hosts the firmware POST modeset leaves the display data buffer
> (DBUF) powered, so the passed-through iGPU's DBUF_CTL registers read
> back POWER_STATE=1 while POWER_REQUEST=0 -- an inconsistent leftover that
> never occurs under GVT-g, which emulates the register so POWER_STATE
> follows POWER_REQUEST.
> 
> This was observed with a Windows guest (Intel KMD) on QEMU 9.1; a
> Linux/i915 guest was not tested.  On the first-boot modeset the guest
> driver samples POWER_STATE to decide which DBUF slices are already
> enabled, sees the stale "powered" bit, and therefore never issues
> POWER_REQUEST.  DBUF then powers down, the plane FIFO underruns, and
> scanout is corrupted (vertical stripes) until a full modeset (e.g. a
> display sleep/wake) re-requests power.
> 
> The programming is a single inconsistent read-modify-write.  Traced with
> x-no-mmap=on so every BAR0 access is visible:
> 
>   read  0x45008 = 0x4040c000   STATE=1, REQUEST=0 (stale leftover)
>   write 0x45008 = 0x4043c000   RMW: tracker bits only; REQUEST still 0
>   read  0x45008 = 0x0043c000   STATE=0: DBUF powered down -> underrun
> 
> The driver sees STATE=1, assumes the slice is already powered, and leaves
> REQUEST clear.  Only after a display sleep/wake does it set REQUEST, which
> is why sleep/wake repairs the display:
> 
>   write 0x45008 = 0x8043c000   REQUEST=1
>   read  0x45008 = 0xc043c000   STATE follows -> powered, scanout clean
> 
> The same pattern occurs on the other slice registers (0x44fe8, 0x44300,
> 0x44304).
> 
> Present a consistent view like GVT-g: trap the DBUF_CTL slice registers
> (S1..S4, only as many as the generation exposes) in BAR0 and clear
> POWER_STATE on read whenever POWER_REQUEST is not set.  Writes pass
> straight through to the device.
> 
> Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
> ---
> 
> Changes in v2:
> - Expand the commit message with the traced read-modify-write sequence
>   that shows POWER_REQUEST is never set on first boot (Tomita Moeko).
> - Collapse the per-slice quirk allocations into a single
>   vfio_quirk_alloc(nslices) with one mem[] entry per slice, backed by a
>   single IGDDbufCtlQuirk array (Tomita Moeko).
> - Split the quirk allocation onto its own line for readability (Tomita
>   Moeko).
>  hw/vfio/igd.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 413a49aae9..5e6160763c 100644
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
> + * leftover that never occurs under GVT-g (which emulates the register so
> + * STATE follows REQUEST).  A passed-through guest driver samples POWER_STATE
> + * to decide which DBUF slices are already enabled, sees this stale "powered"
> + * bit, and therefore never issues POWER_REQUEST.  DBUF then powers down, the
> + * plane FIFO underruns, and scanout is corrupted until a full modeset (e.g.
> + * a display sleep/wake) re-requests power.
> + *
> + * Present a consistent view like GVT-g: intercept DBUF_CTL reads and clear
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
> @@ -507,6 +597,35 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
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
> +        VFIOQuirk *dbuf_quirk = vfio_quirk_alloc(nslices);
> +        IGDDbufCtlQuirk *dq;
> +
> +        dq = g_new0(IGDDbufCtlQuirk, nslices);
> +        dbuf_quirk->data = dq;
> +
> +        for (i = 0; i < nslices; i++) {
> +            dq[i].vdev = vdev;
> +            dq[i].bar = nr;
> +            dq[i].bar_offset = igd_dbuf_ctl_offsets[i];
> +            memory_region_init_io(&dbuf_quirk->mem[i], OBJECT(vdev),
> +                                  &igd_dbuf_ctl_ops, &dq[i],
> +                                  "vfio-igd-dbuf-ctl-quirk", 4);
> +            memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> +                                                igd_dbuf_ctl_offsets[i],
> +                                                &dbuf_quirk->mem[i], 1);
> +        }
> +
> +        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, dbuf_quirk, next);
> +    }
>  }
>  
>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)



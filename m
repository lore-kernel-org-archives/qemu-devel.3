Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6FFCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4oN-0000mU-Bn; Thu, 04 Jun 2026 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4oL-0000m7-NO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV4oJ-0005Oq-La
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780566982;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ac0HkQKW+RX66sL+t5akZQf6TIbWOSrh4Pl5Ay2MsFg=;
 b=CS/M+KI5WdppxPxcqGlaTfSOovcsZUfFqETQ1AFP1qmFLNPxUbtG1SHn/5viLWne04XBXY
 I4Zc5O0dnlg3bFlSa8xW48dSO3Xym8LNzAoeEgc9vCAZIF7GH92X/MerthRtPhOCZr/34v
 b6Jq4XWBcYJYjvXxPBcyL3VbWeSJTPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-gOwdFcmdNMuxRlvM1_9zvQ-1; Thu, 04 Jun 2026 05:56:21 -0400
X-MC-Unique: gOwdFcmdNMuxRlvM1_9zvQ-1
X-Mimecast-MFC-AGG-ID: gOwdFcmdNMuxRlvM1_9zvQ_1780566980
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460198535bcso357690f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566980; x=1781171780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ac0HkQKW+RX66sL+t5akZQf6TIbWOSrh4Pl5Ay2MsFg=;
 b=ODkP6flJ9gJNA2bYo08LRgY4YtutPxduuSKxaSjsVte4gcT06V4BU8zEr6TqydXZ3J
 WFclbctRHd6VQ4MmTiHgB7ivExkpZl92K8QhAIwkCDrjdaKXNw1lFF1N2/s3ic/m20FR
 tO/Ckm9xJohAfdBEJphPcqUWnyudiP6zqX4Ef9KBexgX6/l8mjl5EH/FWrKHiXf09dzl
 mrpPRwnW24XcKri4IkFKqlCqqnKrV4oi1tzkoRbJBHncUkIZHBEC8EFjQGqFH0Ry1Qlb
 iM8/M6HQigjpJJtuQ69lItBeLfF5cIu8qwHwc5/0PUImfzXWbqPFsmCTjMVNUhERV5Hz
 X+lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GEOq2lLs/wEX+g5tbAjog0tTwyR5fu8Xp6mEsyet4qrh/9yCbOtA9wQzxi64140oB4CNqj5nuwqo2@nongnu.org
X-Gm-Message-State: AOJu0Yym1ZHK+gc9Jx8TWekr1HLvemVB2HlylJdS9ZYAXaEr/u6NEEDK
 f88cZ/KG2Wx7rjI5ktbs0phW5q72z9YbOHe1G66ejcAWdwCsE/P6EAjFkSWoEQyrmZ7Ol5OaIR9
 x+JCxG04kjuSJ+5IZwUh691wiuXub7GL8L1qMobBPv2eNN59FTfbQpx+P
X-Gm-Gg: Acq92OGO1RLmEADv2he7cTJYgk9ISoCEF/a9VZFj2HgxrWbW58XCh4N+SfDm7EFQzhL
 uJf40STQtTK+So7Ts282y7aebrn27M7iGEwFxo+ZmYQ2QYWFsIaIzGwvADzDRGzi12qjxqffWYi
 yNXLi0NU//c/89AC+8DSiEQBq/s27N0QBSYuTVj4YzY8cBS2yQB074u04upI9Dx33U/sfteK+rr
 +iVmsUnr03MSlfyI6u/kTL/VTiFgvHrigVk4+7dZ7ROIcxOvygMIiNIM4/4WP5rb6A5XilvcUq/
 Kq7Un52X+qtETQtCtDaJPc03NzQT3InM3WTA52dpWVZyV/gAd1JQig8a0quPU0jmFhnwed5A1j6
 8zN0+MmvWcCmYKSq0uSYBOPQQpuKCzBi2MFBa1LlR2qnKqMZ2un59JZhPOpcQyxPh9AvBtz4B4S
 X4HTh5
X-Received: by 2002:a05:6000:2401:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-46021760f85mr11482495f8f.36.1780566979658; 
 Thu, 04 Jun 2026 02:56:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2401:b0:43b:5097:6f62 with SMTP id
 ffacd0b85a97d-46021760f85mr11482437f8f.36.1780566979224; 
 Thu, 04 Jun 2026 02:56:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm15073960f8f.9.2026.06.04.02.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 02:56:18 -0700 (PDT)
Message-ID: <d3ab357a-a0f2-48c8-b458-b5263220e09c@redhat.com>
Date: Thu, 4 Jun 2026 11:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-20-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-20-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> hw/arm/tegra241-cmdqv: Use mmap'd VINTF Page 0 as VCMDQ backing
the title is double here.
By the way may I suggest
hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 for mapped vcmdqs direct view

to emphasize this relates the direct view and only for mapped vcmdqs
>
> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page 0 register
> accesses through the mmap'd VINTF Page 0 backing once a hardware
> queue has been allocated for the VCMDQ.
>
> The two QEMU-trapped Page 0 apertures (direct at 0x10000, VINTF at
> 0x30000) are hardware aliases of the same underlying registers. A
> subsequent patch installs the VINTF aperture as a RAM-device into
> guest MMIO; in this patch both remain QEMU-trapped.
>
> The direct VCMDQ aperture stays QEMU-trapped (rather than aliased
> to the VINTF mmap) so that writes to an unallocated VCMDQ remain
> well-defined. The CMDQV architecture allows software to program a
> VCMDQ through the direct aperture without first allocating it to a
> VINTF; aliasing to the VINTF mmap would route those writes into
> unallocated logical slots where the hardware silently drops them.
>
> A VCMDQ Page 0 access is served from one of two sources:
>
>   - Cache-backed: no hw_queue is allocated for the VCMDQ
>     (HW_QUEUE_ALLOC has not yet succeeded). Both apertures use
>     QEMU's register cache.
>
>   - HW-backed: HW_QUEUE_ALLOC has succeeded. Both apertures access
>     the registers directly through the mmap'd VINTF Page 0.
>
> tegra241_cmdqv_sync_vcmdq() copies any cached writes (CONS_INDX,
> PROD_INDX, CONFIG, GERRORN) into the mmap'd page on the cache-to-HW
> transition so the guest's earlier register state survives.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 54d95f4e4e..dce7089697 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -39,6 +39,47 @@ static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
>      }
>  }
>  
> +/*
> + * Return a pointer into the mmap'd VINTF page0 for the VCMDQ Page 0
> + * register at @offset0 in VCMDQ slot @index, or NULL when the VCMDQ
> + * has no hw_queue allocated or the VINTF page0 is not mmap'd.
> + */
> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
> +                                                 int index, hwaddr offset0)
> +{
> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
> +        return NULL;
> +    }
> +    return (uint32_t *)(cmdqv->vintf_page0 +
> +                        (index * CMDQV_VCMDQ_STRIDE) +
> +                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
> +}
> +
> +/*
> + * Flush cached register writes into the mmap'd VINTF page0 after a
> + * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
> + * the cache-to-hardware transition.
> + */
> +static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
> +{
> +    uint32_t *ptr;
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
> +    if (!ptr) {
> +        return;
> +    }
> +    *ptr = cmdqv->vcmdq_cons_indx[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
> +    *ptr = cmdqv->vcmdq_prod_indx[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
> +    *ptr = cmdqv->vcmdq_config[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
> +    *ptr = cmdqv->vcmdq_gerrorn[index];
> +}
> +
>  /*
>   * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
>   *
> @@ -95,6 +136,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>      cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
>      cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>  
> +    /* Pre-alloc cached writes survive the cache-to-hardware transition. */
what about the opposite transition?
> +    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
> +
>      return true;
>  }
>  
> @@ -113,13 +157,22 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
> + * from the VINTF page0 backing. Otherwise, fall back to the cache.
>   */
>  static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                                                  hwaddr offset0, int index,
>                                                  bool direct)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
>      uint64_t val = 0;
>  
> +    if (ptr) {
shouldn't you test "direct" as well? I know that later on this is will
be backed by another mr but I think this would be clearer.
> +        val = *ptr;
> +        goto out;
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          val = cmdqv->vcmdq_cons_indx[index];
> @@ -144,6 +197,7 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                        "%s unhandled read access at 0x%" PRIx64 "\n",
>                        __func__, offset0);
>      }
> +out:
>      trace_tegra241_cmdqv_read_vcmdq_page0(index, direct ? "direct" : "vi",
>                                            offset0, val);
>      return val;
> @@ -220,11 +274,29 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>   *
>   * Page 0 registers are all 32-bit; this helper is only called for 4-byte
>   * writes.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
> + * to the VINTF page0 backing. Otherwise, update the cache.
>   */
>  static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                                               hwaddr offset0, int index,
>                                               uint32_t value, bool direct)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
same here?
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_GERRORN:
> +            *ptr = value;
> +            goto out;
> +        default:
> +            break;
> +        }
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          cmdqv->vcmdq_cons_indx[index] = value;
> @@ -255,6 +327,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                        "%s unhandled write access at 0x%" PRIx64 "\n",
>                        __func__, offset0);
>      }
> +out:
>      trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
by the way could be interesting to log in the trace event that mmapped
was used instead of cache regs.

besides this looks good to me

Thanks

Eric
>                                             offset0, value);
>  }



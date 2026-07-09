Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32850C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whq5k-0003RA-Qo; Thu, 09 Jul 2026 10:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1whq5i-0003Qj-EL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1whq5g-0005JM-JR
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783608663;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3PTVKaHvig/lQzC6J1Sm0xHuPhGe+BAov25dQoJsUY=;
 b=gXOcvcm7xwXIA/uNlVWWWZ8zJ4UU0hV9l0+7FC9k1wag+T2s/xHTx6xC9mH4W50+yHsf8j
 wgtD6lgHLOmz5v0Tt3SrypaWFEFMKjEB8sCZOTzLyTZ0PTQhedFnwHoVNgRD7WS7QgFPI+
 RUa10UMmNfM920AQclkkPHNqY/q6vak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-NjC5FQeYMIi8VMJBVkNf-A-1; Thu, 09 Jul 2026 10:51:01 -0400
X-MC-Unique: NjC5FQeYMIi8VMJBVkNf-A-1
X-Mimecast-MFC-AGG-ID: NjC5FQeYMIi8VMJBVkNf-A_1783608660
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c1bc7a70so17655715e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783608660; x=1784213460;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u3PTVKaHvig/lQzC6J1Sm0xHuPhGe+BAov25dQoJsUY=;
 b=q3Gpt36tMbX0IzwMztIt2vopevmDnBacHQYbVpe91BJl4/BVhy0qHcNjV02Fx62H9P
 Rmu7tzZca/uSs729WLJhWyaWN2lNyXavxzb0m4+PwesAyRn2SydpV2q84aKt+w3uFkVd
 jAiYVDGX/9Xb2j733cs7UadrRs9B1f6DhSQutUOTTTRdbqCq/tNkXhpnsHTHioVAQOdB
 B0UPRG9gLC7Q0oMgM+EaThrmYoMxLLoOLdUAF/txVIxv1F5SSRkxcfzn6I9bhjSPDNaB
 Gbh5KVKC7zDOKzUBlgtlbGHI0uv0sO0h0fBgEqU85qqLr1lBJw6l0Y+XvgHbZyjoK3io
 WPZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU2eO/lFG8Ir4YdMBSORT8zs5lCqF2dOZwrY1jeVcPf/zRywbw0o7eOQO6+0tM3RvtHrHFw7xnbkB7@nongnu.org
X-Gm-Message-State: AOJu0YzryIsAcsdvFc7SjAEU3rX2aUFnLeGJa+8CbKmq8BERCzejTGEj
 f7DLkOh4vmprbMn9IvUUF1p8RL2iHJZxBjeotCJztAN6uEuQkgzieLVvrrTuFjzECi6JqcAN7FX
 FRiL4yo64tuMPz0AoaDw7vsEONzrIFYSQszDooHjMDx/tkfgAn7uZtWmPLhlXEE9l
X-Gm-Gg: AfdE7cktlNoaEWhH9va+haKlRzAktCJLofpIkJ1xtwEmtFpZ3Jux3zxMszvuh1jATKP
 NBpY0P4/QIrJQrT2/e+7mW/Vx1xm6JmHjdJLejhqUCDhrnf7fRieS+G31a3yF1kURGrzGqexZwp
 mafR4LI+XjRjM3HbxZFJQwQjXl+cKnss3W9Q9RKeNFLInYOcy0yTiGkH4RmKdpC0xzApgWvDICe
 i10dIOcXKY83zzzjvskSSHTcXZuPgCk3Neyn6insrH0FhwUcJVw9IR90XSe1HpwcSsTqI7MZd0V
 GoLXEaABWo+xyQWC8qchD1H8oQZQwUQDiaZc4QOj+azII8q06MYbFkRW2yThI+VA/KvfpWrmZ9Y
 l7AYcZ0ggNnTVJzenGpu5qa/4g8A5i1eSiXEsYM/LMUCnZ2u6KXUUHqZWDe2q6w==
X-Received: by 2002:a05:600c:8b05:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493e68a0db4mr75737515e9.14.1783608659885; 
 Thu, 09 Jul 2026 07:50:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493e68a0db4mr75737205e9.14.1783608659426; 
 Thu, 09 Jul 2026 07:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3?
 ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6240fsm105823165e9.2.2026.07.09.07.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:50:58 -0700 (PDT)
Message-ID: <5161e394-4f41-4fe4-af83-1c0993758442@redhat.com>
Date: Thu, 9 Jul 2026 16:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com
References: <20260707112450.111178-1-skolothumtho@nvidia.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260707112450.111178-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/7/26 1:24 PM, Shameer Kolothum wrote:
> When a guest hits a command error, the hardware sets GERROR and the guest
> acknowledges it by writing GERRORN to match. These registers use toggle
> semantics, and since GERROR is read-only, both GERROR and GERRORN may
> remain set after an error has been handled. As long as they stay equal
> there is no pending error, so a subsequent VM is unaffected.
>
> When a new VM starts, QEMU allocates the hardware VCMDQ and flushes its
> cached GERRORN of zero, while the hardware may still have both GERROR and
> GERRORN set from an error the previous guest acknowledged. This makes them
> differ again, so the hardware sees a pending error and stall the VCMDQ,
> leading to CMD_SYNC timeouts.
>
> Do not sync GERRORN when allocating a hardware VCMDQ.

One question: I see cmdqv->vcmdq_gerror[index] is likely to be set in
tegra241_cmdqv_setup_vcmdq(). Don't we have a risk to silence one
pre-existing error?

Thanks

Eric

>
> Fixes: 1d0f77535417 ("hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0")
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 29c488e0e4..fe88bec41f 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -212,7 +212,9 @@ static inline uint32_t *tegra241_cmdqv_vintf_lvcmdq_ptr(Tegra241CMDQV *cmdqv,
>  /*
>   * Flush cached register writes into the mmap'd host VINTF page0 after a
>   * successful HW_QUEUE_ALLOC, so the guest's earlier writes survive
> - * the cache-to-hardware transition.
> + * the cache-to-hardware transition. GERRORN is intentionally not synced,
> + * as overwriting it with the cached value could recreate a GERROR != GERRORN
> + * mismatch and stall the VCMDQ.
>   */
>  static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
>  {
> @@ -229,9 +231,6 @@ static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
>  
>      ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
>      *ptr = cmdqv->vcmdq_config[index];
> -
> -    ptr = tegra241_cmdqv_vintf_lvcmdq_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
> -    *ptr = cmdqv->vcmdq_gerrorn[index];
>  }
>  
>  /*



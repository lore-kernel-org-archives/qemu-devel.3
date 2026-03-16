Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9BBF013C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22RG-0000de-IM; Mon, 16 Mar 2026 03:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22R5-0000cO-7p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w22R2-0002We-Ne
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773646337;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPpac4uw5QrTsHWMhi00oGUv1rgw3Ge7wuT6TDLT/+E=;
 b=cJZ75aQqZgBh1/jgtV+6cG+dJisDO4gBjErTGH0atvTN1H86usNZw2Fg0CAnkyx0r4Vqt+
 wAB0gXWPwkhDEhJX8U+SfziB87qSTmwplXcOmsngws/Iu/jXKUeQRC83SO3ku/II/ElYu2
 Uz7WpONQgWzYjO4w+HBgPm28ddmYa3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-tyNYT6flP-athD4aN7cM1w-1; Mon, 16 Mar 2026 03:32:14 -0400
X-MC-Unique: tyNYT6flP-athD4aN7cM1w-1
X-Mimecast-MFC-AGG-ID: tyNYT6flP-athD4aN7cM1w_1773646333
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so49040385e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 00:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773646333; x=1774251133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPpac4uw5QrTsHWMhi00oGUv1rgw3Ge7wuT6TDLT/+E=;
 b=MGXYOzh12nLHg0gBV0CDjA4V8m1RdO3DkSGQYkdlconxwSAwkNTptjXb2fgGJvv/gV
 eWswx2CtLOW/zaQ2+40FTNnQIFyQZpIYsbwUfV5yECBNrkS5nyoAKFn1nVoYAk3+jq+P
 trWffohGassE0NkmZRGe7pfQiJEwJQL2QbnN6W2VYNw5KcHuIsq1khPPR2XheU+ArOcW
 XFgJH0m5KAsQrPinUWYhIrcJyVbPKhlKDDiEqtKlEZ5hpTvtfBiBlD61cE9/6tsURzzM
 OaZiEw+Jec3lgr7lmLES8BVzhIeHxvzsuwZS7Fit2RLX7bUUv2M1O7u+QOvHwaWeSEW/
 LrTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcO1rMzdpt0SXPRjslFtrEp+PmXycS6znML5pWD338Hw03qMpSWMiIkNVLzln2SR8UKBSjd27sySYd@nongnu.org
X-Gm-Message-State: AOJu0Yxo0Ske7SK1Zf/MZBxRWwQGUQJngUF04WmliRk3pmsDZo9/UDYH
 WHyLZGb4C9UR+66JoJPfGvOjaBctJV+VbnTIBknNGiVCPTv3ry6jsKqrrA6v2pjltmNy9r3SwaI
 pYT0nSmjkjB1GgaVXrudgiaggTIoXW64FsgNg6nAd0XDphJX+v7r/iRjO
X-Gm-Gg: ATEYQzwVGyTNzaD7UWM1naXcjcDsGR05p5+SoUAVqMfhA9MNnd16Iif16TkyylmiYq4
 bgicRUs7yOzH8fEFpUkcZ7QK09kRUMExh47WMcFcO5fr6hAYjRTYYQstDnAUv7K51JgCQ+K//d4
 XRsqzlDessA3Qfk2a07QawmdjMCu1NVK7jwwJaUHOWaY2SFnjxVCWn/LrbgvsOo94UAQUxOxldS
 XGFE8E7xwXq5YcWPDLo6SeOeA7r4FPs0Bw1F/5bQDupiPklFCOiDeEvAHCMBzD8EMdKyyLkmJf7
 Fo4uq6uVm/X6zvS8fU6lULMwXikbT1w7emJTtTG5Pa1u75U8y7Dp5UoZieJ2F5VSKLq636+Te0w
 B2pdZbS68S0pJm6Xxm02VHH8sCZi9DZpHa7yaykExpKSiKfOmXsdgpqhnnRaJKm+vT78FfA==
X-Received: by 2002:a05:6000:1acd:b0:439:ddc0:4bf1 with SMTP id
 ffacd0b85a97d-43a04dcbf4cmr21432865f8f.55.1773646332993; 
 Mon, 16 Mar 2026 00:32:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1acd:b0:439:ddc0:4bf1 with SMTP id
 ffacd0b85a97d-43a04dcbf4cmr21432826f8f.55.1773646332530; 
 Mon, 16 Mar 2026 00:32:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b899sm39019297f8f.23.2026.03.16.00.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 00:32:11 -0700 (PDT)
Message-ID: <6ec20b09-e64b-4d78-927b-80feabf9adbf@redhat.com>
Date: Mon, 16 Mar 2026 08:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/arm/smmuv3-accel: Check ATS compatibility
 between host and guest
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-2-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260312210328.2016191-2-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Nathan, 

On 3/12/26 10:03 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
> bit in IDR0 and fail the compatibility check if ATS support is opted as
> enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Miss
Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 17306cd04b..fe78ce69a5 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -101,6 +101,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                     smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>          return false;
>      }
> +    /* Check ATS value opted is compatible with Host SMMUv3 */
> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
> +                   " Services");
I think you can keep it on the same line. Checkpatch will just issue a
warning.
> +        return false;
> +    }
>  
>      /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>      if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
Otherwise
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric



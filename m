Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD7ECCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G6B-00059Q-Mn; Mon, 29 Sep 2025 11:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3G60-0004zu-Hn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3G5u-0008UU-EG
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160834;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJwwsZ4PeOFhxIj0vGOV2eVKMNRmcVDOuZNnwZpc+H0=;
 b=Uykdxr45wjbu8CTqs0tHkIRqlaeGPpadZFxGcRQoH78p/aTKbBwMXqG50AxWitOxWmp/4h
 o9VFmE+oVTgcGhkOD2WUMFMly9Eg0qFub6379Q8qzFXOnckqTAxc8nNA0tPdO61OwzP17f
 8dzxPPZY91oAtvUugt+x74ZelRqvhDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-xLZhkUgsNE2rYfYOibHyUg-1; Mon, 29 Sep 2025 11:47:11 -0400
X-MC-Unique: xLZhkUgsNE2rYfYOibHyUg-1
X-Mimecast-MFC-AGG-ID: xLZhkUgsNE2rYfYOibHyUg_1759160830
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so3742570f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160830; x=1759765630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJwwsZ4PeOFhxIj0vGOV2eVKMNRmcVDOuZNnwZpc+H0=;
 b=TeEirwQC8XNG6Qj2hZ142vANVqvNIE4uAx22xUl5XC0a3KtRGHeClGcqXNEdLZDtDO
 /HNX/Nkgzf2/egdNjmREf0jboIMecoAthFnkwCT+4EL25I2sAgdB4RVjk9KLYWXxw5PR
 td6N/sJywxRVG7/HDjYx9XeXrG0MUrfbAu7IEkxG8QbE/7spXorpbqqu4BqPDRfR93p/
 bU4IRfE8P6aEprYqHz+jSDiRVgEbHqppbPO+8G/GYrCe26pa2YSSvH5/Ty5ZFop1tp7X
 ZqQkzNxUu0otXUOnJnpzqYLSND0U2Un9Pr5zUxlgVlgO0ZLo7fc0yv+X+B7Ys4iw2xET
 hlLA==
X-Gm-Message-State: AOJu0YwVfZWopZEX9bLij9O4rXbE8uOH9q0L/pZe73N54kHIcxtC/rbY
 Ls64Lfp+QK23t8KSHWh131+Xtb3yNSqygkbuiePoV5BOKNEuhgg6bmqAlvm3IbnZnXBG13utY9t
 mRg/JALepR5xjdlne+SgkPSrsM2yHydIOgORiff+FQtFv4CasiQnXjGYM
X-Gm-Gg: ASbGnctF/y2cr4pSKSwu9wWq8h+VFyXAkKRyoLRCJUhUWSDCIPLYHm91KSpJERBEuG2
 kVsoCybLlAFrbkXcVMzQjC0oPCR3gF+DuwsbDuxficntHlGBiP2A2mBXc/elLQxlro4DQUKtWpY
 QMb1JlK98+o4pNRBd6hSnOM8N6TwmevukhYJJ4bUVgw30wh7ONk4oMJ0fzrTYXOWXJKPZiIOe+g
 nb+p94/LxuDX7GJpo+R9T3b95rMq6suUjgiNlLKBhU8GMJgYJE64PdHxjk953H/IuIsXOeDw8A5
 rVmRutdiz8EzonPlYhvG075VHwYqv0UYlgvZ5IlWfqlkgwmGxx4dhzXK+8Zw5t2p/l/VLptGY7I
 4RzRrOWLmg2E=
X-Received: by 2002:a05:6000:220e:b0:3ea:9042:e682 with SMTP id
 ffacd0b85a97d-40e469db815mr17215334f8f.11.1759160829670; 
 Mon, 29 Sep 2025 08:47:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdX1o5k3+ciOFUlNyT0PhyDjGAgvaRjI1bcRNVMQAmH987rLmKwzVdyCW3tXaDlRuvQUijmg==
X-Received: by 2002:a05:6000:220e:b0:3ea:9042:e682 with SMTP id
 ffacd0b85a97d-40e469db815mr17215304f8f.11.1759160829247; 
 Mon, 29 Sep 2025 08:47:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2bf35sm18955389f8f.53.2025.09.29.08.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:47:08 -0700 (PDT)
Message-ID: <00a61c3b-c233-4d40-938b-6d06342e22cf@redhat.com>
Date: Mon, 29 Sep 2025 17:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] hw/arm/smmuv3: Optional Secure bank migration
 via subsections
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926033013.1099304-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250926033013.1099304-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/26/25 5:30 AM, Tao Tang wrote:
> My apologies, resending patches 13-14/14 to fix a threading mistake from
> my previous attempt.
>
> Introduce a generic vmstate_smmuv3_bank that serializes a single SMMUv3
> bank (registers and queues). Add a 'smmuv3/bank_s' subsection guarded by
> secure_impl and a new 'migrate-secure-bank' property; when enabled, the S
> bank is migrated. Add a 'smmuv3/gbpa_secure' subsection which is only sent
> when GBPA differs from its reset value.
>
> This keeps the existing migration stream unchanged by default and remains
> backward compatible: older QEMUs can ignore unknown subsections, and with
> 'migrate-secure-bank' defaulting to off, the stream is identical to before.
>
> This also prepares for future RME extensions (Realm/Root) by reusing the
> bank subsection pattern.
>
> Usage:
>   -global arm-smmuv3,secure-impl=on,migrate-secure-bank=on
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c         | 70 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  2 files changed, 71 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 80fbc25cf5..2a1e80d179 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2450,6 +2450,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>      },
>  };
>
> +static const VMStateDescription vmstate_smmuv3_bank = {
I would name this vmstate_smmuv3_secure_bank
> +    .name = "smmuv3_bank",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(features, SMMUv3RegBank),
> +        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
> +        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
> +        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
> +        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
> +        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
> +        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
> +        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
> +        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
> +        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
> +        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
> +        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
> +                       vmstate_smmuv3_queue, SMMUQueue),
> +        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
> +                       vmstate_smmuv3_queue, SMMUQueue),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static bool smmuv3_secure_bank_needed(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    return s->secure_impl && s->migrate_secure_bank;
why is it needed to check s->migrate_secure_bank?
> +}
> +
> +static const VMStateDescription vmstate_smmuv3_bank_s = {
> +    .name = "smmuv3/bank_s",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_secure_bank_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(bank[SMMU_SEC_IDX_S], SMMUv3State, 0,
> +                       vmstate_smmuv3_bank, SMMUv3RegBank),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static bool smmuv3_gbpa_needed(void *opaque)
>  {
>      SMMUv3State *s = opaque;
> @@ -2469,6 +2516,25 @@ static const VMStateDescription vmstate_gbpa = {
>      }
>  };
>
> +static bool smmuv3_gbpa_secure_needed(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    return s->secure_impl && s->migrate_secure_bank &&
same
> +           s->bank[SMMU_SEC_IDX_S].gbpa != SMMU_GBPA_RESET_VAL;
> +}
> +
> +static const VMStateDescription vmstate_gbpa_secure = {
> +    .name = "smmuv3/gbpa_secure",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_gbpa_secure_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(bank[SMMU_SEC_IDX_S].gbpa, SMMUv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_smmuv3 = {
>      .name = "smmuv3",
>      .version_id = 1,
> @@ -2502,6 +2568,8 @@ static const VMStateDescription vmstate_smmuv3 = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gbpa,
> +        &vmstate_smmuv3_bank_s,
> +        &vmstate_gbpa_secure,
>          NULL
>      }
>  };
> @@ -2521,6 +2589,8 @@ static const Property smmuv3_properties[] = {
>       * Defaults to false (0)
>       */
>      DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
> +    DEFINE_PROP_BOOL("migrate-secure-bank", SMMUv3State,
> +                     migrate_secure_bank, false),
I don't get why you need another migrate_secure_bank prop. You need to
migrate the subsection if secure_impl is implemented, don't you?
>  };
>
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 572f15251e..5ffb609fa2 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -71,6 +71,7 @@ struct SMMUv3State {
>      QemuMutex mutex;
>      char *stage;
>      bool secure_impl;
> +    bool migrate_secure_bank;
>  };
>
>  typedef enum {
> --
> 2.34.1
>
Eric



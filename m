Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C4CD1170E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTPn-000078-1z; Tue, 02 Dec 2025 11:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQTPl-0008Uc-2P
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQTPi-0000pX-EX
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764693571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4/AYtEB34watU7mzWhvt/la20zD/AOTq45orngLKcw=;
 b=BzEN9uZCGvAUEw7EqfvGlZm3QyxdmuOdQGeJf6lkuhgYDzBQoE4I0VKPj6PUZ9zD5Ok5pR
 h3gXViCSxgbUFJQFWO+CklFIGAQQPr9Q4xV2PMJdIvaoUWdxsvHmTLLoofeqTovx7Tl2CI
 m0V5HsjvOVtDZyXSSsqhNNndGkrE13E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_Us6Hpo6NOGqwJMzCnkXOw-1; Tue, 02 Dec 2025 11:39:27 -0500
X-MC-Unique: _Us6Hpo6NOGqwJMzCnkXOw-1
X-Mimecast-MFC-AGG-ID: _Us6Hpo6NOGqwJMzCnkXOw_1764693567
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee3296e984so97820571cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764693567; x=1765298367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4/AYtEB34watU7mzWhvt/la20zD/AOTq45orngLKcw=;
 b=dCyYParc9HsPuwDkhAKibAuAMGU7AJPPSkLSpho6YRp4JBbo/wJlMa6h8XFGW+PHyZ
 9RnQCNBd8juBQ3eb2372ZtVjpHKnEu3VhuIhPakX59RD4VSmCbfQbhl9gGIwxeqOom2n
 U5CrKjw3XgN2mif+o3d8j7MnsBWfkOBybTaCNKdfFOuVOrZm4x+3+YFvFeHTyV6kw9lW
 X8/YwgZCs2k0nYYNQRfYn/4OsNye3snS4HC2OjXcaqwnat855JFfgvrHaQ1dbN9MqPif
 nLD64bUbfaH3znQXRsGdg/jqeMleuRIxRERkJgNSZ8LrMKgnjKJGxsn/vB+EOVsf3KF4
 VTnw==
X-Gm-Message-State: AOJu0Yyoq/ma2Z9Tt4vCO/ssEvJVR+ZObvwSaeVVApQCVzugJC6UMCNU
 uTUAg+zz8pix0YrHfEoYxKnucSaDVgpJOvFk9BH1ZbWwEpVrlxxmJp+tc/GdtmbpUFMwz+3QMdO
 2yYZIH/0wgUBH3IRxs2C7/VCmvrPXeoA8LwZWf/gMJuF8+Ln5ZQ8yb5RE
X-Gm-Gg: ASbGnctvAvPmERQixHJUK+aARXt5cBAGaZEc7vdg7crC6zHXwGnSLICNtHODcl1RsOz
 Nko2LiawD2jnt05Hh1Oodp9oA6ctq+y9sMHD2ynJx63aJ65hjsYaJuCL3Lnbd9QQgrYn73plxmM
 B7bE5hClwmpacAndb2L4HXKgCTb5yvhb5qTSCoX3FlWOaxFmk/wiKfwXxDlh+1/GOd1cP0VmCdA
 CJP90zgojd0NfFasqa08/lKv35WN5MBsdPWLqz4GgbmEm8ak0BU2Euz6dDuABRkSxKQGtf1vEJo
 NX16qeymw08UZqeZGWzVq9vZUwCBIEwkjS3uJzp8Ql3C1Y8VHGjnvuq/0Q0KGEuZn42BusEDzNa
 QW93tfTIrJ8Q5oU4zCNHlVg6Y9k4kvLRUdk3/bl3zJDXHUSAPMjUgkoa7zg==
X-Received: by 2002:a05:622a:11c5:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-4ee5895c017mr605466371cf.83.1764693566843; 
 Tue, 02 Dec 2025 08:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgmonitC+FW3bwYhVpB8TRJ+JaQ3KljMFVU8AhHBQGjhc7jkmiqUxuEWaGp/6vQco2kAkH/g==
X-Received: by 2002:a05:622a:11c5:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-4ee5895c017mr605465671cf.83.1764693566310; 
 Tue, 02 Dec 2025 08:39:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd341f0ecsm95033051cf.16.2025.12.02.08.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 08:39:25 -0800 (PST)
Message-ID: <2ba17310-e032-44f6-a17f-a8f5b9dec003@redhat.com>
Date: Tue, 2 Dec 2025 17:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 21/21] hw/arm/smmuv3: Add secure migration and enable
 secure state
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151611.4131627-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151611.4131627-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/12/25 5:16 PM, Tao Tang wrote:
> Introduce a bool secure_impl field to SMMUv3State and expose it as
> a secure-impl device property. The introduction of this property is the
> culminating step that activates the entire secure access data path,
> tying together all previously merged logic to provide full support for
> secure state accesses.
>
> Add live migration support for the SMMUv3 secure register bank.
>
> To correctly migrate the secure state, the migration logic must know
> if the secure functionality is enabled. To facilitate this, a bool
> secure_impl field is introduced and exposed as the secure-impl device
> property. This property is introduced at the point it is first
> required—for migration—and serves as the final piece of the series.
>
> The introduction of this property also completes and activates the
> entire secure access data path, tying together all previously merged
> logic to provide full support for secure state accesses.
>
> Usage:
>     -global arm-smmuv3,secure-impl=true
>
> When this property is enabled, the capability is advertised to the
> guest via the S_IDR1.SECURE_IMPL bit.
>
> The migration is implemented as follows:
>
> - A new vmstate_smmuv3_secure_bank, referenced by the smmuv3/bank_s
> subsection, serializes the secure bank's registers and queues.
>
> - A companion smmuv3/gbpa_secure subsection mirrors the non-secure
> GBPA handling, migrating the register only if its value diverges
> from the reset default.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c         | 75 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  1 +
>  2 files changed, 76 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0b366895ec..ce41a12a36 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -337,6 +337,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>  
>      memset(sbk->idr, 0, sizeof(sbk->idr));
>      sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, SMMU_IDR1_SIDSIZE);
> +    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, SECURE_IMPL, s->secure_impl);
>      sbk->gbpa = SMMU_GBPA_RESET_VAL;
>      sbk->cmdq.entry_size = sizeof(struct Cmd);
>      sbk->eventq.entry_size = sizeof(struct Evt);
> @@ -2452,6 +2453,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>      },
>  };
>  
> +static const VMStateDescription vmstate_smmuv3_secure_bank = {
> +    .name = "smmuv3_secure_bank",
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
> +    return s->secure_impl;
> +}
> +
> +static const VMStateDescription vmstate_smmuv3_bank_s = {
> +    .name = "smmuv3/bank_s",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_secure_bank_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
> +                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static bool smmuv3_gbpa_needed(void *opaque)
>  {
>      SMMUv3State *s = opaque;
> @@ -2472,6 +2520,25 @@ static const VMStateDescription vmstate_gbpa = {
>      }
>  };
>  
> +static bool smmuv3_gbpa_secure_needed(void *opaque)
I don't think you need that subsection. You can directly put this in the
secure subsection one. This was needed for NS to avoid breaking
migration but here you shall not need it.

Thanks

Eric
> +{
> +    SMMUv3State *s = opaque;
> +
> +    return s->secure_impl &&
> +           s->bank[SMMU_SEC_SID_S].gbpa != SMMU_GBPA_RESET_VAL;
> +}
> +
> +static const VMStateDescription vmstate_gbpa_secure = {
> +    .name = "smmuv3/gbpa_secure",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_gbpa_secure_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(bank[SMMU_SEC_SID_S].gbpa, SMMUv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_smmuv3 = {
>      .name = "smmuv3",
>      .version_id = 1,
> @@ -2506,6 +2573,8 @@ static const VMStateDescription vmstate_smmuv3 = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gbpa,
> +        &vmstate_smmuv3_bank_s,
> +        &vmstate_gbpa_secure,
>          NULL
>      }
>  };
> @@ -2519,6 +2588,12 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    /*
> +     * SECURE_IMPL field in S_IDR1 register.
> +     * Indicates whether secure state is implemented.
> +     * Defaults to false (0)
> +     */
> +    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index e9012fcdb0..8fec3f8edb 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,6 +69,7 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +    bool secure_impl;
>  };
>  
>  typedef enum {



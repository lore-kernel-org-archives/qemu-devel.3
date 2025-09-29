Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A9FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 07:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v38Yt-00075n-DV; Mon, 29 Sep 2025 03:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v38Yq-00075X-70
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v38Ya-00070E-9x
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 03:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759131855;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xC9hEtA6blUhJOUDh7+3CLP3UjSE9qgp9tZjGnOb3jw=;
 b=LGHZEinArIZ4mehWVvLuKGM7lQVDbNeS9H9YQ238oKSigLM4wCA6IItJlyK5PGBm2NBVHW
 K1UKy4J4Hh53AvhgtEiEbJqyyTM7HrN9G7mmubqHPuLJh9IZXN0/ww0ERudK5UBeB4/8Vc
 gxZDUaHEmcHaN3dfNX07a8+jqfEp63I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-27kfNqyJNKK0McqHYl9i5Q-1; Mon, 29 Sep 2025 03:44:14 -0400
X-MC-Unique: 27kfNqyJNKK0McqHYl9i5Q-1
X-Mimecast-MFC-AGG-ID: 27kfNqyJNKK0McqHYl9i5Q_1759131853
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e303235e8so30870795e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 00:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759131853; x=1759736653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xC9hEtA6blUhJOUDh7+3CLP3UjSE9qgp9tZjGnOb3jw=;
 b=F7zWm/d+1Zds/u9nU/JgOoA8hFyaOSd1oUBsZiLfqnFyYsjg+XDDnrgBYfZkHi48H+
 TVBKK3z6fBKBZiO89G0VC0dUMAXr1k4tFtDw+4uZ/5bfhKlf8yFyE5GShR6YQOQ9qdnG
 t/CBb9hZOV6oTFfiBJ5NKPh6VtXnWXlziBRLjn7B9p6XCFsztDLT8+RynYAlokbFv+Ia
 2hUM9jfFSildWRE8njEkRiekdurlsntqsQ0oBGbszAi70LeP+2+hPjYzSe1ugxDhkk6o
 BQNPba8YFk1aDIQfxxZUGplZFpsOUKRjsTwe/iibfOA9hY8xUFXwdwGKLmi+fUYVzZ+O
 lR4w==
X-Gm-Message-State: AOJu0Yx+7SXCtRLuA9TCKw6XKsAUFA2tfVa4QBDKqmPh6KbjIooT2SHz
 zy/yPyrknUZs9zQ3U2DcRpNHCFoZaxXAFNZ9qVAVWROtSKxjVkbIi+o41t+cINkn7s0I7kJpfES
 zukzrNlBqb6BsTblGyFKm+sRFh9m3Y55Ptbt0QFkXnFlvd7+eXukRnijk
X-Gm-Gg: ASbGncu+EayUBKknueLK6GXpVEQrkNUhAK2xn0VVoPN1rYMhsiG1gaLG0VJARTl+sf6
 IXNBMAm3pJx+R2W1KbKE2UnFB9WLN3HKhhsdEjsAKNa/uCzZsHcLYMRkn9Hyu39GE0Iq08+S5w3
 N80BMOM+/79stkjmUuE/1oAgI9Q1OPlAMQS0s0h7QRKvvyBFo9pazlFwkNdyjVqa3sghKMwxtdI
 VL7cSBcoNBZq/3qSFq3qVl1LLKZHmMw1htXqGUvpBSqKMNJdTXhfxLz/lDg6rhmghwrW5QvyYEq
 uST+7q+dEec/ucvYCJ/ppBV8WS+AiZLp9Mdh8b71u8hXjyGe6iyZy942DJ5eEfJWOQECRcxV14N
 v1ZORAINmm4A=
X-Received: by 2002:a05:600c:3f0e:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e36ba93b7mr148864735e9.15.1759131852628; 
 Mon, 29 Sep 2025 00:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGJMwcCHcViwtgTgCZNzN2VdzxlU3JcNLD1tiE5ojp4bnl4w9Mj10L6YUJvwfWGkCC+3DQsw==
X-Received: by 2002:a05:600c:3f0e:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e36ba93b7mr148864495e9.15.1759131852128; 
 Mon, 29 Sep 2025 00:44:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56ee6b19sm2174465e9.0.2025.09.29.00.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 00:44:11 -0700 (PDT)
Message-ID: <9ea1fc2a-8280-4a31-92b9-4870bf2bf940@redhat.com>
Date: Mon, 29 Sep 2025 09:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] hw/arm/smmuv3: Add separate address space for
 secure SMMU accesses
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-7-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-7-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/25/25 6:26 PM, Tao Tang wrote:
> According to the Arm architecture, SMMU-originated memory accesses,
> such as fetching commands or writing events for a secure stream, must
> target the Secure Physical Address (PA) space. The existing model sends
> all DMA to the global address_space_memory.
>
> This patch introduces the infrastructure to differentiate between secure
> and non-secure memory accesses. A weak global symbol,
> arm_secure_address_space, is added, which can be provided by the
> machine model to represent the Secure PA space.
>
> A new helper, smmu_get_address_space(), selects the target address
> space based on the is_secure context. All internal DMA calls
> (dma_memory_read/write) are updated to use this helper. Additionally,
> the attrs.secure bit is set on transactions targeting the secure
> address space.
The last sentence does not seem to be implemented in that patch?
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         |  8 ++++++++
>  hw/arm/virt.c                |  5 +++++
>  include/hw/arm/smmu-common.h | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 62a7612184..24db448683 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,14 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +/* Global state for secure address space availability */
> +bool arm_secure_as_available;
> +
> +void smmu_enable_secure_address_space(void)
> +{
> +    arm_secure_as_available = true;
> +}
> +
>  /* IOTLB Management */
>  
>  static guint smmu_iotlb_key_hash(gconstpointer v)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 02209fadcf..805d9aadb7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -92,6 +92,8 @@
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
>  
> +AddressSpace arm_secure_address_space;
> +
>  static GlobalProperty arm_virt_compat[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>  };
> @@ -2243,6 +2245,9 @@ static void machvirt_init(MachineState *machine)
>          memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                             UINT64_MAX);
>          memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> +        address_space_init(&arm_secure_address_space, secure_sysmem,
> +                           "secure-memory-space");
> +        smmu_enable_secure_address_space();
>      }
>  
>      firmware_loaded = virt_firmware_init(vms, sysmem,
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 3df82b83eb..cd61c5e126 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -53,6 +53,26 @@ typedef enum SMMUSecurityIndex {
>      SMMU_SEC_IDX_NUM,
>  } SMMUSecurityIndex;
>  
> +extern AddressSpace __attribute__((weak)) arm_secure_address_space;
> +extern bool arm_secure_as_available;
> +void smmu_enable_secure_address_space(void);
> +
> +static inline AddressSpace *smmu_get_address_space(SMMUSecurityIndex sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_IDX_S:
> +    {
> +        if (arm_secure_as_available) {
> +            return &arm_secure_address_space;
> +        }
don't you want to return NULL or at least emit an error in case
!arm_secure_as_available. When adding Realm support this will avoid to
return NS AS.
> +    }
> +    QEMU_FALLTHROUGH;
> +    case SMMU_SEC_IDX_NS:
> +    default:
Maybe return an error here in case of other value than NS
> +        return &address_space_memory;
> +    }
> +}
> +
>  /*
>   * Page table walk error types
>   */
Thanks

Eric



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947A7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqc2-0003cT-6E; Tue, 26 May 2026 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqby-0003Yq-8h
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wRqbw-00035x-Eq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779797414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csEOSBTG2KZbG+8hsbMcouVzgTZMLxCUZ30OYvJTSz8=;
 b=cYUSuBtogESEHVjFnycyUNNKLQtGFee3EE277aP70uaAfQ6RTVcPrLE1GqopZipEZw30Jv
 33Y+Q8Azx3WzkmTGSmWn5DWxZ85LtQbe5SREcKCJSUWHazAwi2pAhjYNiIUGuFCpBYOPov
 wh0qQzMeWiR71JY670Q5sN+6vjF+/EI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-HT2Rcwa0OKelkwfhorRX4A-1; Tue, 26 May 2026 08:10:11 -0400
X-MC-Unique: HT2Rcwa0OKelkwfhorRX4A-1
X-Mimecast-MFC-AGG-ID: HT2Rcwa0OKelkwfhorRX4A_1779797410
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so32745295e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797410; x=1780402210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csEOSBTG2KZbG+8hsbMcouVzgTZMLxCUZ30OYvJTSz8=;
 b=OsOSCaP3AeXxF/QOgTA1gj9vfzIh8q0n+wHSLxCWupn/bi1bRJrQU4lI/mlcs4U3vu
 ABbAhwZhsTxF9b/F+cHjbqe0HdeVp7T93gLbB4bw6iZXR083frBO303fjKvjj7EeXsTF
 Y8kyYmPRIUtTqpiFkzMzUVrmjSodok2aG/lp0t4AkJLEJvYTpM9fzUMngQCWoRKThhnx
 u5w8A+1t5UTaqdqoB9yAQnm1nHNGB5/x6zq+Wd0BYSKh1sEW9ynCsUpxRSl42dbQpsE9
 DKjZ2377aUPA0xZVOdYD7x/JtYBhgNi4qHG7EHj9t+BZ4jyjxFcGnQDwgFCfeGExI/PA
 RBsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qri4Ng+O7OimAbVpp948qpyqzYj+BHGZFzAnZmQcbUL9CTUG/Z3mc253QycWzlv3kjF9+yPJOx83f@nongnu.org
X-Gm-Message-State: AOJu0YydO6SEsPjbt5LYEUgg3RqbsDP43/vNFuv+ncxEo36VF7NII4um
 kw5nLLmwHJO15PTvoY8CvTG8cALmZVNFNExvRD0vwF+RqWkB29xJdQbWPCGx2xjiCgT3Elw0ABd
 9cqMm+y9zGxYmTBog0znK7cGPX6e+cD8Dt+KbS8MxcFa0gD57QLqY8YWi
X-Gm-Gg: Acq92OGMHXbj6EEAMxkzPVqISfxnnDo4lvlef7YtUDwJCkJnld8T/f9UD5GJetf8rRH
 wvLElrCbVIqj/OlZ0I9S0x8eb8tz+7KPjggsSpR2i67sThetKRp9q8jqY8MKLtQb7ZTrwT2WPhK
 OzV2gL+xxLJCcZaoPPcypIFTnKMVO/e3HD9j5ACATvAcYMXjuO0OsQu7U3D4BPoFR5dycgc+Ngq
 ZtWPgdPjyQI/HppVTH4e9ZWSla92kg7Vz7T6O1P6p1hx6pwOWNNAEZ9CKsILCXY75RizYChY6D9
 SI0z4HVtKulLV+e+Vy/txRZpiSOu4FnnjHXDWCRk83whgyqbrvhNbKEbvgLGpDx87dx/IITV33F
 D8dOeetLPK70oTGT7mRG/IQ820MtMg1qrDJPNHPy9mjcsFeMRFHPY0fN/DOvtrrZ8pnifWg==
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr171169175e9.2.1779797410124; 
 Tue, 26 May 2026 05:10:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr171168195e9.2.1779797409600; 
 Tue, 26 May 2026 05:10:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm569761115e9.1.2026.05.26.05.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:10:09 -0700 (PDT)
Message-ID: <2fc4efe0-7177-40b6-8c8e-e3a99de140e3@redhat.com>
Date: Tue, 26 May 2026 14:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/32] hw/arm/smmuv3: Add cmdqv property for SMMUv3
 device
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-33-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-33-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
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



On 5/19/26 12:37 PM, Shameer Kolothum wrote:
> Introduce a "cmdqv" property to enable Tegra241 CMDQV support.
> This is only enabled for accelerated SMMUv3 devices.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  qemu-options.hx | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 763b86c417..8c13489a5c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1994,6 +1994,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>                         "bits if accel=on");
>              return false;
>          }
> +        if (s->cmdqv == ON_OFF_AUTO_ON) {
> +            error_setg(errp, "cmdqv can only be enabled if accel=on");
> +            return false;
> +        }
>          return true;
>      }
>  
> @@ -2144,6 +2148,7 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2188,6 +2193,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "A value of 0 disables SubstreamID support. A value greater "
>          "than 0 is required to enable PASID support.");
> +    object_class_property_set_description(klass, "cmdqv",
> +        "Enable/disable CMDQV support (for accel=on). "
> +        "Valid values are on, off, and auto. Defaults to auto.");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 46b02a1bb3..c8b8f4e69a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1329,6 +1329,14 @@ SRST
>          - With accel=on, auto means the value is automatically derived from the host SMMU.
>          - With accel=off, auto is resolved to 0.
>  
> +    ``cmdqv=on|off|auto`` (default: auto)
> +        Enable hardware Command Queue Virtualization (CMDQV) for the
> +        SMMUv3 command queue. Currently only the NVIDIA Tegra241 CMDQV
> +        implementation is supported.
> +
> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
> +        - With accel=off, auto is resolved to 'off'.
> +
>  ``-device amd-iommu[,option=...]``
>      Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
>      Only available with ``-machine q35``, it supports the following options:



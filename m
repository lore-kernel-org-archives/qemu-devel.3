Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90751C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ot1-0006yQ-NJ; Tue, 01 Sep 2026 09:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1Ot0-0006xD-KP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:50:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1Osy-0000ck-Rq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:50:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a5dce0aacdso10792a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788270647; x=1788875447; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w1A1WCRaTO6XWDVWypaDnCjJUiERAFWVMWOwYivUinI=;
 b=mfrRfDf0E1Ie1Yg3HvzjB/76HXfD6/w5oB7EjFK/BkCLAcof2SzzyKtMur/1hBcOIt
 kXfKnl299sn9BnLcvvDWAxOVUDLAPaHa6UNmAjdRfiwoSVLWqcxzdnbrQE0GC0o1KFjt
 dLisiMbEMmRBeX7/UVHUvW2iX9t6KQjIUPgm3+LUW3M5gpk9gNNtWGHdqryKeTCzGaZx
 UJAAxJ1BL7ymZFOaycXBjfpElF4cNZeefPWguB9VJgoCC33YqzUdP+2pcAfsjEevPYgC
 DO8rnnhOyW3lHjrHXgDaLb+e1ldHoOjinMO9ZeycE0FtUhB8VKdA/4j9D7DZIMPPH1xH
 aVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270647; x=1788875447;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w1A1WCRaTO6XWDVWypaDnCjJUiERAFWVMWOwYivUinI=;
 b=SohkLIkzjijtQPFeosxQboYYH5Z3VX3S769blsIe6NNtaAp3szwyeLnEvQAQveLZaS
 LeHLE4zGuPJP6PGQ839PxYdy/eom9o23UWbSxUg6w7qaPlKJjBpNw6Hc7xGudyrTJL/Q
 x1SfzVQ+0reUS39WISMtTAe1UcC3GKVC54GrnRyUqP8Q9ROQnPcn3p3YBEunITytpFUs
 yoxPbE+P1blq+Vtnc+rKCHjugbSkOuIzt1VDFvuBaEwAo7Uhq/cfq9zvtaWvqnrvE566
 mPOLCT59EIuVqoyVAn3qSDTm6GrrOOAlNI9n0D89ohOoX6OMxru91dOeubOdrkexVzuT
 dJZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPUE6tZ/tLrx/4dmDZTFQHebi+hF3oFQGUmMo2SrTINdEx1+1EQtSxWzwojSoXI5Ob9EWKCcipZKwC@nongnu.org
X-Gm-Message-State: AFuF++lT5ZiglUukUlSeLIhsYbKqvnecAYIQzASf+R5dE/IbRF8US+R9
 JW0W5cJO9mK5zDLdtz90roGAFkJEAb8q4NIlDmT62Smib/B5fvkb1R4xcNp35L6mcyeaB5u6N6m
 Wa8wc/g==
X-Gm-Gg: AYBFou3jY/R4hxSdieZObM3N1l5toTqbbGJqid1lgeMZ/cToMrw8+isXSyBCKbxfqSs
 dIao76muCb1yNjEanC1bYkOso+1NoHSP0KZebZnroFwwtQviQtSMhZuYuPHgIyuIcgXqO4k4XuG
 3jUCl/EXpJ6ApGLaMgKEIaMILq4Nx2ox+Wn4XZb69Vkwhp4UH17KmwwT7qIPvxrPpJmTD8UVWyH
 fiQR+YvpSwr1v7jNyv+y00l2cZUHHVLX1uqMrAIoLc6t6ryJ/BRYRL1sBX93l1iI2wUgpoRvcKC
 6rdgMeItb/a5GW/KM7P6LjII91iC+ZZ5Fo2bLTrhRNIco3wb78nXdcr72qLDnXypN6D8hy0LKHb
 sNFPZ9hZQiIrV3owUpjnes8L8iwEk+P+OAZEt7c1Ye9cqgS8UzfnJNm+lSMV6O2BTMsmuX6ueTO
 5XXyix0jUmKFhKczgD8Q3XdvSbgzxK1uEZezUKYeQu7svsTLPfIYfWMx/32+Tkr26mJA3iCIoiU
 jswbnZipKqzmVHsGZNARdkCKRy5iQ==
X-Received: by 2002:a05:6402:a5cb:10b0:6a3:7084:fcaa with SMTP id
 4fb4d7f45d1cf-6a66d8dca0amr18958a12.3.1788270646756; 
 Tue, 01 Sep 2026 06:50:46 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1fa3ddsm584103366b.45.2026.09.01.06.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:50:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:50:41 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 05/28] hw/arm/smmu-common: Add security-aware address
 space selector
Message-ID: <apbYMUlZCCrEmgwq@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162410.2805113-5-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=smostafa@google.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:24:10AM +0800, Tao Tang wrote:
> Introduce SMMU_SEC_SID_S to represent SEC_SID == 1, meaning Secure. And
> then provide smmu_get_address_space, a SMMU instance-based address space
> selector. The helper returns the per-device memory or secure-memory
> AddressSpace selected by SEC_SID.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  hw/arm/smmu-common.c         | 15 +++++++++++++++
>  include/hw/arm/smmu-common.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 8e40ba603d3..54a6a9f4d62 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,21 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_SID_NS:
> +        return &s->memory_as;
> +    case SMMU_SEC_SID_S:
> +        g_assert(s->secure_memory);
> +        g_assert(s->secure_memory_as.root);
> +        return &s->secure_memory_as;
> +    case SMMU_SEC_SID_NUM:
> +        g_assert_not_reached();
> +    }
> +    g_assert_not_reached();
> +}
> +
>  /* IOTLB Management */
>  
>  static guint smmu_iotlb_key_hash(gconstpointer v)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 6ea40f6b074..9d6e2d3038f 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -43,6 +43,7 @@
>  /* StreamID Security state */
>  typedef enum SMMUSecSID {
>      SMMU_SEC_SID_NS = 0,
> +    SMMU_SEC_SID_S,
>      SMMU_SEC_SID_NUM,
>  } SMMUSecSID;
>  
> @@ -188,6 +189,8 @@ struct SMMUBaseClass {
>  #define TYPE_ARM_SMMU "arm-smmu"
>  OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>  
> +AddressSpace *smmu_get_address_space(SMMUState *s, SMMUSecSID sec_sid);
> +
>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>  
> -- 
> 2.34.1
> 


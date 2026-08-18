Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E411C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKgv-0007ED-Lg; Tue, 18 Aug 2026 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwKgt-0007DB-9t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:21:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwKgr-0000FV-GJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:21:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4998590d392so48927155e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787062880; x=1787667680; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iW1x2T4ow/KALArrlvmWQ5RLnDxMISOdqKzDbu4KUE4=;
 b=HHaqFC5Flv0sE/VYrqbwEyUB+bKZxb13QbWBoAmTRmiSSPYHTfzo72f7vELY0hGmY0
 fZXR+gLuGrF0A4G77c88t/uTcpAx5lwwRh//clIsYSDrwOUkismYbAxVd5WnfJLNH2SJ
 z0N9gWYDv1AuVQZ8tqQZVY4Mo8lLhExFfJRnx/iTOMt9GXcCGEBO5iXwRrWGGoMAZe8z
 HGtSTnjdihIWWQD6fSveMYV803aycIKhTBr65CYpIuPdkQvLuBOlZd94nK+l2ArdkzaX
 aBSdtgpMkWcAAENUAuPxV1yYwN/Q9yTyHsrBLpfer1+W2gkBs1lvMEmkJbhyBmYg4zYq
 Asuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062880; x=1787667680;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iW1x2T4ow/KALArrlvmWQ5RLnDxMISOdqKzDbu4KUE4=;
 b=XZWIZwoyzxms4stvrNjValEftIFUsyKZ7j/2cFO37k0jozjey41dWxC+VSefdfio3o
 t1VDnrerfj9pZafSZbmk44LcjucR+Ym8+vRuMYX70vRSwX6fTTF+9OhcbWw5+ZQc6lqe
 qgVKZjm4W1Y/qqTxXL8R31FMgFTVszBUn7VoIx66ZC1j5ilJR6MBmgAqy+dgdvVNyJu0
 5y9gzMHkZ/wRHoqQYLr99YVryGg7nutEmF5DpTiWlU64dDJnHhSjxOTrOaerXBRfYJPv
 +ciy2gPcNhDlrO2u5x38b8Iyne2WZAd6aDSHe6E8fQve8DAxPfTp3UvobC2HWCVUcRvF
 +jrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM0ZV0syK5wixfXX8mFIe1CiM1UKimZPRu5ugtwx/7YNb9izINvmRy1VexLM5wQZ9KHfw76ycEofJk@nongnu.org
X-Gm-Message-State: AOJu0Yx6Q3/9Q28iBO4kUDeBhgJyxkDafKaIqb0MOKjeC0MD5t4p9z4V
 dZLG0CzAYloC71Q7kQ/o+8JbLbv35P43j0WuHuhJPUhxF9FWBtIU5xt7ruCmRuBUx+E=
X-Gm-Gg: AR+sD12rD59mgykjwswpSgIKSzKxWObjOLGRk2wtY7FYm+EkPUS9NmJ9Ept84YSHNH0
 B98R6/wjgF//k+Z2SnitCIcdnW+ED6rdNPnG3y9iSUQKiYyYPrJfzUw4lkTJgoZG0Wfx9y8K3Fa
 i0804rn/qh4rHRpCq2AgHlXGVQU8xHNOFjYmeMiMo14aROZM8DKFQmEVszRSFwk1JfJKIxbskGv
 TUaAWQwUx261Yex1WQ5/NDTP6SwpspPlQEZ0UCfjw8+ngS4blsfkUAdxyYSjPLRa0B6kVgA15j9
 JUw93AlduHE3qwoSXsxJZXf78ytwyYxD1RvMW+HXfL1rH8h2o84ig1vO4iE8Z1C4b1oac8r1bWg
 kTPUCZ274sJm8MHyi+t1byrmurdRbcM1GnXI0jvJNNefKj18mOY+PnoN/2wfARl1j2ksIIzmvBU
 t31Svxzso7lmvJrxVSuKiV6FWFGUX+0tBCiXwRLXNTKkNirQw0ooTFGJuDEZUskw==
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id
 5b1f17b1804b1-4999fb3f78bmr159851135e9.8.1787062879454; 
 Tue, 18 Aug 2026 07:21:19 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:c289:2687:e46c:f7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm284909685e9.6.2026.08.18.07.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:21:18 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:21:17 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 01/28] hw/arm/smmuv3: Introduce secure registers
Message-ID: <aoRqXelVsDKu8xNM@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162410.2805113-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Aug 14, 2026 at 12:24:06AM +0800, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers for managing
> Secure transactions and contexts.
> 
> This patch introduces the definitions for these secure registers within
> the SMMUv3 device model internal header.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Link: https://lore.kernel.org/qemu-devel/759ec110-365f-488b-802d-c7bb1efe30bc@redhat.com/
> ---
>  include/hw/arm/smmuv3-common.h | 71 +++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 4609975edf9..ec442a85586 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -269,7 +269,7 @@ REG32(CD_5, 20)
>      ((sel) ? ((cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, NSCFG1, (v))) : \
>               ((cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, NSCFG0, (v))))
>  
> -/* MMIO Registers */
> +/* MMIO Registers. Shared by Non-secure/Realm/Root states. */
>  
>  REG32(IDR0,                0x0)
>      FIELD(IDR0, S2P,         0 , 1)
> @@ -353,6 +353,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
>  #define SMMU_CR0_RESERVED 0xFFFFFA20
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>  
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)
> @@ -411,6 +412,74 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +#define SMMU_SECURE_REG_START 0x8000 /* Start of secure-only registers */
> +
> +REG32(S_IDR0,               0x8000)
> +    FIELD(S_IDR0, MSI,         13, 1)
> +    FIELD(S_IDR0, STALL_MODEL, 24, 2)
> +REG32(S_IDR1,               0x8004)
> +    FIELD(S_IDR1, S_SIDSIZE,          0 , 6)
> +    FIELD(S_IDR1, SEL2,               29, 1)
> +    FIELD(S_IDR1, SECURE_IMPL,        31, 1)
> +
> +REG32(S_IDR2,               0x8008)
> +REG32(S_IDR3,               0x800c)
> +REG32(S_IDR4,               0x8010)
> +
> +REG32(S_CR0,                0x8020)
> +    FIELD(S_CR0, SMMUEN,      0, 1)
> +    FIELD(S_CR0, EVENTQEN,    2, 1)
> +    FIELD(S_CR0, CMDQEN,      3, 1)
> +
> +REG32(S_CR0ACK,             0x8024)
> +REG32(S_CR1,                0x8028)
> +REG32(S_CR2,                0x802c)
> +
> +REG32(S_INIT,               0x803c)
> +    FIELD(S_INIT, INV_ALL,    0, 1)
> +
> +REG32(S_GBPA,               0x8044)
> +    FIELD(S_GBPA, ABORT,     20, 1)
> +    FIELD(S_GBPA, UPDATE,    31, 1)
> +
> +REG32(S_IRQ_CTRL,           0x8050)
> +    FIELD(S_IRQ_CTRL, GERROR_IRQEN,    0, 1)
> +    FIELD(S_IRQ_CTRL, EVENTQ_IRQEN,    2, 1)
> +
> +REG32(S_IRQ_CTRLACK,        0x8054)
> +
> +REG32(S_GERROR,             0x8060)
> +    FIELD(S_GERROR, CMDQ_ERR,          0, 1)
> +
> +#define SMMU_GERROR_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
> +#define SMMU_GERROR_IRQ_CFG2_RESERVED   0x000000000000003F
> +
> +#define SMMU_STRTAB_BASE_RESERVED       0x40FFFFFFFFFFFFC0
> +#define SMMU_QUEUE_BASE_RESERVED        0x40FFFFFFFFFFFFFF
> +#define SMMU_EVENTQ_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
> +
> +REG32(S_GERRORN,            0x8064)
> +REG64(S_GERROR_IRQ_CFG0,    0x8068)
> +REG32(S_GERROR_IRQ_CFG1,    0x8070)
> +REG32(S_GERROR_IRQ_CFG2,    0x8074)
> +REG64(S_STRTAB_BASE,        0x8080)
> +REG32(S_STRTAB_BASE_CFG,    0x8088)
> +    FIELD(S_STRTAB_BASE_CFG, LOG2SIZE, 0, 6)
> +    FIELD(S_STRTAB_BASE_CFG, SPLIT,    6, 5)
> +    FIELD(S_STRTAB_BASE_CFG, FMT,     16, 2)
> +
> +REG64(S_CMDQ_BASE,          0x8090)
> +REG32(S_CMDQ_PROD,          0x8098)
> +REG32(S_CMDQ_CONS,          0x809c)
> +    FIELD(S_CMDQ_CONS, ERR,           24, 7)
> +
> +REG64(S_EVENTQ_BASE,        0x80a0)
> +REG32(S_EVENTQ_PROD,        0x80a8)
> +REG32(S_EVENTQ_CONS,        0x80ac)
> +REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
> +REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
> +REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
> +
>  /* Commands */
>  
>  typedef enum SMMUCommandType {
> -- 
> 2.34.1

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>



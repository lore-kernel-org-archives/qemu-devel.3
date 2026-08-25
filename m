Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2690C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyq8l-0002nT-JY; Tue, 25 Aug 2026 08:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wyq8k-0002nD-Kv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:20:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wyq8i-0005x1-JF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:20:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so21547525e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787660427; x=1788265227; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ejFp3dmc3VLYD3MlC883OMJGVfdC/fpo+ilkNBBuIQU=;
 b=XCwXPOVJ/HmEOzmftZ/Bra6V8//ayYGlgCfi65gcV+r0Ke1ysbGkFWZHRKD0fkzviA
 zbix6JhV08PPshs3sLiEzS2jRjD+9GCYiWBual6pRsFzkyWppSQsJlTc88YGhQvOaLiE
 NEVcy733ott9CDfHV5QpYbT5xlLzVzb9qTdAKDXosstR2G/LOHt9X9MdYxScLFB47Sjv
 ZEczOymMlvucpl91m2769x4l1taBV5ol+idPUi6WtsmiYj01d2r6TIaBQ7DdaP/KFzeN
 FzkNqD87Eg4zgrSBi9y5G+eMTUPqTVB6EPyjmu1aGDUMRAqCZ9mqYdJFt108jxKbSb+L
 /cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660427; x=1788265227;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ejFp3dmc3VLYD3MlC883OMJGVfdC/fpo+ilkNBBuIQU=;
 b=qYkKWKX9mmwBaR/eIe3FpiH3ZNljijmwR7dGzRVe9BeG1CaYzGJ2vZroNqGT19ai1h
 I6w23XE+7+gk2GwlDjdz5PI9tOOpBMNVsfLDxTmY+4GYRokMfA5fQjfrp4Cptks0gEaG
 sK6aukPWnrMjVOYWX8yUtB6uOgsoLttr9xdMX5BkjGEU3rQRdcxi0C7d29ycV4czbuz/
 C/fwdO3UhuKPjUP6I8enicoIPqGxPXM8w2RHVt8wUHMKWAAJZVZRebz7J7eYIwZZMA0Y
 vUFk24iLP3XsZK13K+pwGfsGMrIVabAdkOUavVOgrYqe2DKr/AnPDcGLdWtzh03bf0ub
 uHyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1bGBkrjyl0B7kAPKeoYR323RRnYssAjAI+H+IFpTE4sRRqx717ilZTc4YJWSgOw3y08bI1EytOPtA@nongnu.org
X-Gm-Message-State: AFuF++nz4qZnWdkfwJby+3HIUqn+WpFTllT7jpS+9ELWvrO5uz4g34C+
 TVN47DfDkRhd0v47yCKPWBzzRhQmf2pGyUVOw5EuPErJB3u6ExsaEzMJ12+hYxjn/no=
X-Gm-Gg: AR+sD11uMjS1rgWacvqLBb/yRiTcKXtDf/EUTHlFEDxNwHchUoCsmIQNyki2iTenOeg
 8DDQ/NU1YAQS0Nl7UaYKXnlRIaHUvWoMXSjrQMLH3dS/rhFbXmcWB5RUKPasZb7NaadrN52lAe+
 J7fg8wrgwrlk+xoQtRx46J8M2QYl8YVVrouXkAvj8/7EKyGMYHyihilyUju4E5wy/VisdEwa0D1
 MD/6wOQ3fsO5VzZ3oMPH5TenY7W5cE0HoW+EKmONJKLtlQHe950D62w0oDZfZgsiDiV3/QPZ32K
 9jV9Zuh/lGXFWHJ3m/y0LTsWjmhpoxW9uJBaml9ysJ6oNFECxin1ts7e89Vvi1beQUTvfCUBMRJ
 nIMn5G3Dugc5Hpz3ZdzqIBBwRc3mLjAZVv/GUvyAGiSdKRU7O+7j0ewam5p8BY8IZBc22zAjPss
 Wm9T4ayotCFaRh3Wz+SklElYTAHB0j7T+9tsi50LdJJk4XG9MFI3L/7qepXrcFltw=
X-Received: by 2002:a05:600c:548c:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499c19f514emr282212415e9.14.1787660426815; 
 Tue, 25 Aug 2026 05:20:26 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:8679:ff59:1b3a:5e93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d6364720sm28618395e9.12.2026.08.25.05.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:20:26 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:20:24 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 23/28] hw/pci: Add sec-sid property to PCIDevice
Message-ID: <ao2IiIW427gRN7Cq@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:21:45AM +0800, Tao Tang wrote:
> Arm SMMUv3 uses a SEC_SID (StreamID Security state) to determine the
> security state of the programming interface that controls a transaction.
> The architecture explicitly states that the association between a device
> and its SEC_SID is a system-defined property, not something derived from
> the physical address space.
> 
> We need a way to represent this system-defined SEC_SID for PCI devices
> if we want to implement SMMU's Secure state. So that SMMUv3 can select
> the correct register bank and configuration when handling their streams.
> 
> This patch adds a new char *sec_sid field to PCIDevice, together with
> a "sec-sid" QOM property. The property is intended to carry the
> platform-defined SEC_SID for the device; for now only Non-secure and
> Secure security states are supported.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/pci/pci.c                | 7 +++++++
>  include/hw/pci/pci_device.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d3191609e28..b86135af96d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -104,6 +104,13 @@ static const Property pci_props[] = {
>      DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>      DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>                      QEMU_PCIE_EXT_TAG_BITNR, true),
> +
> +    /*
> +     * System-defined, statically configured SEC_SID for this PCI device, used
> +     * by Arm SMMU. Only support "non-secure" and "secure" security states.
> +     */
> +    DEFINE_PROP_STRING("sec-sid", PCIDevice, sec_sid),
> +
>      { .name = "busnr", .info = &prop_pci_busnr },
>  };
>  
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 5cac6e16886..6e6c49fdd19 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -187,6 +187,9 @@ struct PCIDevice {
>      uint32_t max_bounce_buffer_size;
>  
>      char *sriov_pf;
> +
> +    /* Arm SMMU SEC_SID */
> +    char *sec_sid;
>  };
>  
>  static inline int pci_intx(PCIDevice *pci_dev)
> -- 
> 2.34.1

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>



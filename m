Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C2C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 00:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfqfV-0007xm-Uj; Thu, 29 Feb 2024 19:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfqfS-0007va-Uq
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:22:26 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfqfQ-0006Cx-AW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 19:22:25 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so1454387b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 16:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709252542; x=1709857342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qz4r3dXCMksTCt4HIh2SSUhoXbYDl44npX8gMtiNOjo=;
 b=eHUkpj3/FuK49b8TtTTKlQj7dg/xdLkUjsiOoclnTBNYbb2uyg+o14Ysgfp4ojeSHg
 0vq9kWt+DE0EQ0VXMQSiNbbpGDfcUAYySii/MTfgRgZam/u/XSZPs5ocJ1ADl/f/7cRo
 KhCxs7hmFqkiNuxcQtWUKZJtivB59JHFyZi16pdewMKQt8jLIJsqahTQ6mLYqJ7kd+ab
 RAFmFlMxmkt5i2oGfl7vOoG0oELkVOVJ71OMkvE4CGKJ4YZ+ogBgf0I6uGqkpKgpmEYt
 V7pkXR3ZtAzlN6WpyRtHNAl4z2mN5k5VvRS2Nu0hDUmZRKIRHOEvL8cdB1omXyV93Jd3
 ELTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709252542; x=1709857342;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qz4r3dXCMksTCt4HIh2SSUhoXbYDl44npX8gMtiNOjo=;
 b=h2fLCJzSfIb4SmQlKP25wtPdK0uNXLCuChycRW2yiyqq07giCHiePy9S81yUQICRw2
 D28loLfUnlkuYW98ifcEAnxGIRycujx1G8mz5EJDzXgGeDCLycyzI24xsEJKjDQeMRLy
 4INSvMFUabmOBn8ZRsTogAL2Hf0Pzl/DyMOAxX2ooUVMn59PVShoRjNkhckkwtDkGIgU
 kMZZPwGr3zTyxfJl8pW10QFaCtDG4XzHASq1IKTCcx1PaoxZVqxr3zZGsl9A5fFADSPs
 QzXmtJE0cmsWsy3SHbMMY8kEL7dnL0mHnYStCQgyA1YTC9Dk3HwbOK+C4Yv5zq9hXJAZ
 IEeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8uV1UNiNIvIm1KKYSL5W24pXCzWHKLJsN0GpqPdhy0DO4AFO2wQSGawWgVNXHOUFp0Wc/OJ5Lu+sLAyADoXrzVUTwtL4=
X-Gm-Message-State: AOJu0YyrVpwdRLIswbkQM8EkucaQnsdWVKYciRMBK8NLOMrvbDoUFH9Y
 fg6uK5SVe7F6sygMtQIl2HQ01Jf6xcrBM/kE7SyxorApI7iCSxUqJeKf73XegBQ=
X-Google-Smtp-Source: AGHT+IHH79s2GzMui9x9Aj0ah8R5rqz6tTTTyD8AK1VQutqXsidkxuFkl+niqXP6WHNwnkMpplq5Qw==
X-Received: by 2002:a05:6a00:841:b0:6e4:f678:f694 with SMTP id
 q1-20020a056a00084100b006e4f678f694mr330209pfk.19.1709252542405; 
 Thu, 29 Feb 2024 16:22:22 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 i13-20020aa787cd000000b006e4762b5f3bsm1891523pfo.172.2024.02.29.16.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 16:22:21 -0800 (PST)
Message-ID: <657b22f4-c717-4288-86f3-a5226c926664@linaro.org>
Date: Thu, 29 Feb 2024 14:22:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 19/22] hw/intc/arm_gicv3: Report the NMI interrupt
 in gicv3_cpuif_update()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240229131039.1868904-1-ruanjinjie@huawei.com>
 <20240229131039.1868904-20-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240229131039.1868904-20-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/29/24 03:10, Jinjie Ruan via wrote:
> In CPU Interface, if the IRQ has the superpriority property, report
> NMI to the corresponding PE.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v4:
> - Swap the ordering of the IFs.
> v3:
> - Remove handling nmi_is_irq flag.
> ---
>   hw/intc/arm_gicv3_cpuif.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


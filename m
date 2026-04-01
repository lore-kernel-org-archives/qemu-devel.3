Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B171D3515C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sG8-0004HW-Bt; Wed, 01 Apr 2026 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sG6-0004Gx-BT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:53:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sG4-0000pu-Pk
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:53:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so1374679f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775037187; x=1775641987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=teKZBEftrAzjFZ430okLdJuqStKsAdQLuOYWShmOBjA=;
 b=o1tdoka7gwORK4ZPZ5MXeZFqHJ8yBhcjwWmJP0HTGW5gticYfm8N0KTFZKL81JHjF1
 IP8V7pVo+DxMsluk7j+8hLmLsJvCTqam12f8lTk0D7HO6xgZ4t2hMwXC4ynDNgot8Z/i
 JWFwvS/MVR+w9SoaLnEKjoZeaetME4f7YUV+RXgbjALhbygViSEkvmNz3fFwYTFlggCH
 I07HEnZE8162JnEBICCUwXn21qp88jG/1kR6ezZ0I+pYDfRrZ+L4vZi3Yp5cuDhyJ4Qj
 RuID4y4CBtNCObh6QD7dsJJ9NJip4Qi9l7LkvWkyGhBAx3wpxYKrkX3+4dkuca1ecVuf
 Epuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775037187; x=1775641987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teKZBEftrAzjFZ430okLdJuqStKsAdQLuOYWShmOBjA=;
 b=Qb3nISBbx9Q//ET5ygYLwKwiX1jvzBXuT6Lo5NUu6XpiA/jPOFMLjLVwyga/aZXoIH
 Ev/u9dCOxK9Il8rDGQHwsJWfzmQtTUGaXJZ6LtJTF8qdeT9RF2mz+U/mUkVWH8rKrXYE
 TPAtzrfiIVmKt4X2aTPVp1WVkVzU5ncf2DSBqWXXci6rPXu/OpVm0lGTbw5L8BjiNsqg
 WaV4p7uFKiVFsqXNaQSFt9/YcNRwTLI72AphFXpRRquy8bDGPm3apPbKzGEawlFVz8An
 fA9hgjJP4IO4fdvXSB72HoXvsSYjuEQGMsPwqjYjFBvMGyQiR+hYMQSd8hDD7pbDnMMK
 refA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbAgsSfEyBNpE4WmmAAlr/bcdWT10krsZ5jKv4fbGtXWKdXBLHsfdDqaUJP3EH+aZwFS4c5M4A+BgW@nongnu.org
X-Gm-Message-State: AOJu0YwXHPn1sPT4ysnLcS35A4JIY9sncFp4N21NElr//oCIfLHEz3Ri
 GElgSLoSE+SAMALG4rc+xwiyhlRIxxABCx2KwWyV1KKLh1ghDD/D/z3wVJdU4DNe5TE=
X-Gm-Gg: ATEYQzxXBiHg0YVF6gf9/R2DVywuJ9nOMlpeGY1LNtmxIAVnyM/0OdxFGiX28cAKDAS
 LASJJ1tIDJUp0CtFV120qKPNHQE0grvCnrUUlCp+p5ZMASfn+/EtWutIO/4o4gc/QYz+/1/XqFP
 yXWyeZEiVbDg4uCL0YLZFg47b18fm9Vlsfxo7JVTpVcbFM3VUxcHxA123P5e1tk2OYXVnqx5u5t
 mTgeEXh2/PzD9dr01WsYrGElwBesII+8MxdtjPFkip4dRlHBctpDlo7Zj99uweYGRgZYajuiw4g
 67ABXH09G39DuLhXDLnjVR/dxSzGcgzx5G0E+Aeoqx7GchDtSbKupQGSPT0En3S/jv7xOoKnY5a
 Dv05JrV0v4E5hX5lgfBNYgFQhiGOTOQ1VVJ3abaLdmFkwTa3b9kATetHqHie8nJ2Nc3HDo2HtUl
 0LZgASjN52rLawGQTX2Hx9F+i3HVbGc7+WbvquOp0xo7ztUlsqy+57Py/ad1ZlwRnZqw==
X-Received: by 2002:a5d:64e7:0:b0:43c:fed2:bb72 with SMTP id
 ffacd0b85a97d-43d15094320mr5466871f8f.19.1775037187285; 
 Wed, 01 Apr 2026 02:53:07 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf245e2f6sm35755062f8f.18.2026.04.01.02.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:53:06 -0700 (PDT)
Message-ID: <e24d03ba-d6cb-4b2d-bc50-643a584a674c@linaro.org>
Date: Wed, 1 Apr 2026 11:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Rename all the idev and idevc variables to hiod
 and hiodc
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, yi.l.liu@intel.com, qemu-arm@nongnu.org
References: <20260401080354.1347212-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401080354.1347212-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/4/26 10:03, Zhenzhong Duan wrote:
> We used idev and idevc naming for HostIOMMUDeviceIOMMUFD and corresponding
> class variables which followed the iommufd_device naming in linux kernel.
> 
> This is mixed with the hiod naming for base type HostIOMMUDevice. Rename
> HostIOMMUDeviceIOMMUFD* to hiodi* for consistency in QEMU.
> 
> No functional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/arm/smmuv3-accel.h       |  2 +-
>   include/system/iommufd.h    | 12 ++---
>   backends/iommufd.c          | 26 +++++------
>   hw/arm/smmuv3-accel.c       | 93 +++++++++++++++++++------------------
>   hw/i386/intel_iommu_accel.c | 44 +++++++++---------
>   hw/vfio/container-legacy.c  | 10 ++--
>   hw/vfio/iommufd.c           | 24 +++++-----
>   7 files changed, 107 insertions(+), 104 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E184C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBIH-0002Wh-I8; Thu, 08 Feb 2024 15:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBIE-0002WL-Ac
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:46:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBIC-0000La-69
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:46:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d944e8f367so1900745ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707425203; x=1708030003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kMFou9y1MTKo7lAsqnHGORdputed2+bXafYqaWwrGSU=;
 b=aNH1wPkE50+lSVMtihtP+Vj5InS4TRFY8sggvj/ve6Y0GF96MVbS6vRDhjM23c1RLq
 fLz37z+tRvUukVg7CvvAfKlarYN04iAB9ffJjW2gqhPLXTqunqkY9cwV5Y38/NMQ+gnx
 b5VcSFUGwD1FbTcPirzA5RG9Q+xoAq+g7r6LcgRRzMRoMt3vW66YTVUHBd/Gs+eKwvN2
 juY0DZgRx2EQDILb6xCscmbWs2mYDLhWnz6GT9abZvZz3eykrW/gfykg2c5rGhTVT4/w
 ujFuOTZQeW6g2FKR7Q1OKklKy97JlG2r3806nu4RawinRQhLCXVMe61LP/5uA5/eKiIa
 vBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707425203; x=1708030003;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMFou9y1MTKo7lAsqnHGORdputed2+bXafYqaWwrGSU=;
 b=oovbm5dDX1/iMI1fdK3BaSG6FJTTswG8Dky3WzNMiBgG7/PJm7XvWDSOt+R+pU4zU8
 RH5aKVilav5e1tsixGa9tb3txhlo1XlkE5RG281KFg7gf68+Wib7AVjzTUmiDa0dzB5B
 UjAaH/Zg73W2BYhsSmXmqhS2IDzUho66WoaWcSGc0rOCJqujcPc9+2azjHKR9nP4UoBf
 +QlfejUwd/KfNrKsyRp/aOds9pSmhRfqB68VWFCoYXNI81CdGlR5z6CdfiQbhIiwTMGb
 I19QHtyL9y2EYPbCSGHM1IeTqwGTKlwJ9C9Q+Rd9VSNWjurcAAHBxCThPs8MGZ1AMdH1
 85EA==
X-Gm-Message-State: AOJu0YwlTbcjILFOX+pTeVFG68l0rPLcDDEu/w361b3A+mdOAYMzw9DP
 XWN7iMDe9VpaC2+ZqldLnMuMiKwE5jmIlyBgEyuJ89ZOye6SacNqV/r50K9W6sE=
X-Google-Smtp-Source: AGHT+IGWo5twID+HbaWvVceWDRCSWdnOu8XrfdO1caR5SmUh0j77zmXXmOWIyj7OEJJkKTgliq8iMg==
X-Received: by 2002:a17:90a:fd96:b0:296:3cc5:9253 with SMTP id
 cx22-20020a17090afd9600b002963cc59253mr454205pjb.32.1707425202946; 
 Thu, 08 Feb 2024 12:46:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVCAZKFj5MGCeOR9eAdWy+tjZQDpECU7bzFN4DpwYiiq0T2+zYjIOs0gKu+4F3YvdEDRpucTBM60P2M4K8P+/HR/V86IZA=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 st12-20020a17090b1fcc00b002970242eacfsm226796pjb.19.2024.02.08.12.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:46:42 -0800 (PST)
Message-ID: <d5e05483-980f-4470-8bef-7c721256470b@linaro.org>
Date: Thu, 8 Feb 2024 10:46:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] hw/pci-host/astro: Implement Hard Fail and Soft
 Fail mode
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-6-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The Astro/Elroy chip can work in either Hard-Fail or Soft-Fail mode.
> 
> Hard fail means the system bus will send an HPMC (=crash) to the
> processor, soft fail means the system bus will ignore timeouts of
> MMIO-reads or MMIO-writes and return -1ULL.
> 
> The HF mode is controlled by a bit in the status register and is usually
> programmed by the OS. Return the corresponing values based on the current
> value of that bit.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/pci-host/astro.c         | 23 +++++++++++++++++------
>   include/hw/pci-host/astro.h |  2 ++
>   2 files changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


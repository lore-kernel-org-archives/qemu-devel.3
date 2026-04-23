Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961AAF589D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFupj-00035W-7u; Thu, 23 Apr 2026 10:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFupQ-0002yO-7O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:14:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFupO-0006Pq-Lw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 10:14:51 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so3851396f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776953689; x=1777558489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tgGst3GsAqo7NxVMYrgp/LR47Hsmmdv2GAKoO1dd7dU=;
 b=OGZT94mBAPta4ldrDN+7ExPaJ0JOYMf/4RqNDTBVA8cS86W/UGnrAO3YOcKo4GhB4s
 WS6nUu3nASse1TsUEyHVdf2sQvWqdmaXKmuubW5nTCMYWpYWDHqAGGlgSB7l7LQpplxC
 y+5JTesfLjXtgZtF29Yn/l0F6Ne2GO4WL+8C/IQ0350gsNkvtVolSzKxjxZe351nf88j
 XFDsqaP4DAs9LHzWTBnKgdfz0m27bMl5rGHH1fRXy/0XnceKT7q/RO84HCmYWOHfCKlP
 fc4jOznQ5bQ4SvYB+dmJkYTu3XR34KNrTDRua5H4ZQi7pSpwKbYvmUfeagf6ZT+QvBe3
 cxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776953689; x=1777558489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgGst3GsAqo7NxVMYrgp/LR47Hsmmdv2GAKoO1dd7dU=;
 b=jARGwT80VMiV4LP1gr/p5NCDywXbc5qKHLlt9JEKvu8alrUO+FmSlOFAdunp19gTPE
 JolZIG1/N+0XtJnl3doG9fmueVx+VsgMSg6bEaG/lNpLzh6FWvmyBhqm5FCxdJ7X0y/R
 VVV8FBuBn7WsgIJkAyvljgHamRnTGEMXC6XUKNX5NVzpV2g8Uhpw5SBJOlDi9quQzNjY
 BPGAWqMo4VyY8Hab8H4fN7J+ZFgBH26cA1vPeWhhS8m6Xcb5ywOuWWVnkzRtyLdxZjXf
 TT+x4s5C9IpZ31vdfTD0t4UV/CXKjwh+TlYKXloTFjj3oI4/w5xNpB7ZcAz7F0zrC6oM
 GiDQ==
X-Gm-Message-State: AOJu0YzWP8MIKOtGhvp96O1GDy6EViLKTE+Ty5dVzaKSEzeV/i9cmNgJ
 MRKerPLGBqiVCTfgD6r9KJIzsvtWaUnDBfNevcVrJgOmMxzlzGjWnhY2UJraYoiX88dz6RPo7s5
 KwEiG7cw=
X-Gm-Gg: AeBDieuDZAq7eH+gEFhB2jw2Y+Brh5322khOEarb7SM9hjn1tn+R1YmRj/nfC3+vJDZ
 6T6/wLAyKulq1kwAgDTSSMWwBdBo89yIHcUBSE5faPa0z//z3PbTbbfADp8KF6FxEOtzFvhER+Q
 fy3zAyMry2gouzfXRwngWns+zCJ2FNRcOjeWb0nrS+NikjbmCMP8sEOR6w5qEYX3lEH2BG5zB/J
 HsdcfxFXKGiCwaqVqIdPpO2BVNwNZ1eDph79fSwR37BWrZjT8NsX+I3r/gAQP+kOs9DWvUuElaT
 W879znlP9w6AAS6ZyAKTM3XIrt3s2/VS8zKrZFXnh8C5pUh32/edkZeDnLJN8uEZDX/vnqJpamY
 ulybATtbDNCqTZ1XHhlfGey/Pc6uUNdysKYfb592VtQGRdbsVWCPDaMugJtGq2tFkEwe2T/vHLn
 2XxC1rYpjVn+ERFKD8zxP4JbkTdmP0uGnjA61Kmjybn5w29FzmPEDBzqjZzc7Bug==
X-Received: by 2002:a05:6000:2087:b0:43d:6787:9933 with SMTP id
 ffacd0b85a97d-43fe3dcae81mr43282618f8f.13.1776953688832; 
 Thu, 23 Apr 2026 07:14:48 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm53323093f8f.4.2026.04.23.07.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 07:14:48 -0700 (PDT)
Message-ID: <bccaa3f9-c993-45ab-9b97-e6e9625f946a@linaro.org>
Date: Thu, 23 Apr 2026 16:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Leverage 128-bit vector type in VLL / VSTL
 opcodes
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260423141245.51344-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423141245.51344-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 23/4/26 16:12, Philippe Mathieu-Daudé wrote:
> The access is unaligned, we can easily replace the 2
> consecutive 64-bit calls by a single 128-bit one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20260423135035.50126-1-philmd@linaro.org>
> ---
>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>   target/s390x/tcg/vec_helper.c | 23 ++++++++++-------------
>   2 files changed, 22 insertions(+), 13 deletions(-)


> @@ -198,7 +196,7 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
>   void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
>                     uint64_t bytes)
>   {
> -    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);

Oops, mis-rebase.



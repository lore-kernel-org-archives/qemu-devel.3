Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B9BFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICJ9-0003fG-Ul; Wed, 29 Apr 2026 17:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICJ8-0003f7-Us
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:18:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wICJ7-0005pU-3s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:18:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35fc2b18363so209299a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777497535; x=1778102335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tttFjNJDScdOZ7d6FSNF16frydDmhALEyz/A74P/348=;
 b=QpnoXdb1m6NCRCMUdVTJ51vgFZICE8AMK2mXSGuxA11mOChC0GT175atBjcfZUVUZi
 RQFPDMg4j/4ngZmht+vkWKLVKqk6ELNIN1J1Vy4vYzJLEbarP+nFM+rNNpX4cuZY7wB8
 4NFjBRLZ0GoWf3FCoJEHuWq6+ww8hOQzxCIWUJhxIrIf2C5UIwON90CWEBUobJAiCziS
 RJ3qDGonLT6AbSC9tvI7N8TIRUG6Y9bzmh6jTgMnC1gqpFp75LJRr5aemuSOD/WoJLyb
 No8rrBqbSQ9LWN1lDmVabPojgYxUF7suMzXrRzcA84RJoG87+LyYhGr7fJooVceAY1Gr
 SGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777497535; x=1778102335;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tttFjNJDScdOZ7d6FSNF16frydDmhALEyz/A74P/348=;
 b=Qe2whHG8dQ9GIAnqeIJULDxTBOgzv+yjInabRVPd/vuPNXRAOiNE1geNopf+VZQYDQ
 klaWbYkYXL01q+CNfK5E7JNIFRFzyIfbYSKwJ3oZrGxzHrWGrYLP9jVCx2zprl1yE4X3
 eZcVl+98+Lj+ty40zuHq/zvxNwfI766+mgqrTgTYxEPMRLcIjuFHsBfRPzx2aM3OK+ZS
 4iPozusEy8nO9IbnnYnZFsR8Vo/TM0p6kb6OEDoyN42fDT9f+9aqmfys/uj3qFfQJU+u
 S87ctb/Z2waI44P7giyYMZoYfnxmofPEAc7YLr3uAETyCVqAvucCUGSHiG50rRqLgflp
 WBag==
X-Gm-Message-State: AOJu0YyS/CzpPWElX9Qo9R9MMPCe0Z8hLBu+Dfa1ib7y740zFi7g+reg
 wAb6Tge4Eg3pScKez5BQcXCYrtazDL6f8v5bI6BN/MzzWLlviGQbmof82/4RdWMTL2k9C9ar3kE
 VeaaNAow=
X-Gm-Gg: AeBDievxFT+jTLDX65+84jmt4/XfGSm0opxwj76wp/o5IvX208YbJw0NGt+8ORmT2pd
 aRa6zHNAEVb6BxTfF17xjIeynF/zyaoKZSyaA2Ccz1IpVpdiLGEyKCYCTOK6Q0dnqBel0iqm8w/
 BUGJuAU264M3M7+FyIVlq1dfLPretFIGflusHDwwhCtKq7o2QK5lNMa2MSCUmSPGnTyLL/KPz7d
 BGK5LagnOToXae5kybSuisMkSuRK7wQHhH6lRJyZL0whUTkgvFyTGSKTODta4lXx+6MHpuH/pos
 qcvJuWIgqEBCM3m4SGDEVKSLCizbGJxH3uz2is81QH5o2kcgwV9eLHOm0+DiBeRTQ6vYqJht2ut
 PlFXaKJPPM7Vdvpmvu55kWuV4tU01YyzRgn/Zdqcvt7wclnwXLohFRfmhaxAKUNoU+/7GlRCAdu
 XM30k89PDEswLRAHlQG8Ikb598xad/cfvoJBV78cAn4PUep0UO17JH
X-Received: by 2002:a17:90b:2803:b0:35f:b6d3:da7a with SMTP id
 98e67ed59e1d1-364c306430dmr2858a91.15.1777497535150; 
 Wed, 29 Apr 2026 14:18:55 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd64f219dsm2935065a12.18.2026.04.29.14.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:18:54 -0700 (PDT)
Message-ID: <97129d63-fe70-41f5-a103-61a7f6fd51d7@linaro.org>
Date: Thu, 30 Apr 2026 07:18:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/or1k: fix gen_mulu using signed multiply for
 unsigned operation
To: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
 <20260429170519.2137725-2-joel@airwebreathe.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260429170519.2137725-2-joel@airwebreathe.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 4/30/26 03:03, joel--- via qemu development wrote:
> From: Joel Holdsworth <jholdsworth@nvidia.com>
> 
> gen_mulu() uses tcg_gen_muls2_i32 (signed widening multiply) but it
> implements the l.mulu instruction which is an unsigned multiply.  The
> low 32-bit result is the same either way, but the high word written to
> cpu_sr_cy (used for carry/overflow detection) will be incorrect when
> the sign bits of the operands differ.
> 
> Switch to tcg_gen_mulu2_i32 so the carry flag is computed correctly.
> 
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>   target/or1k/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/or1k/translate.c b/target/or1k/translate.c
> index eb4485312f..1602e204fe 100644
> --- a/target/or1k/translate.c
> +++ b/target/or1k/translate.c
> @@ -269,7 +269,7 @@ static void gen_mul(DisasContext *dc, TCGv_i32 dest,
>   static void gen_mulu(DisasContext *dc, TCGv_i32 dest,
>                        TCGv_i32 srca, TCGv_i32 srcb)
>   {
> -    tcg_gen_muls2_i32(dest, cpu_sr_cy, srca, srcb);
> +    tcg_gen_mulu2_i32(dest, cpu_sr_cy, srca, srcb);
>       tcg_gen_setcondi_i32(TCG_COND_NE, cpu_sr_cy, cpu_sr_cy, 0);
>   
>       gen_ove_cy(dc);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


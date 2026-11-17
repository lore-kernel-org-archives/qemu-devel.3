Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6751606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i0bjPb2i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOgz-0003UV-LV; Tue, 17 Nov 2026 14:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOgx-0003U5-O7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:18:07 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOgw-0003Yg-3P
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:18:07 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3b3a5c9130bso54533a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943084; x=1795547884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5X5NKVFdAgJ7t6i8D8u7su2ychxPuvXSTqcPROeyhg=;
 b=i0bjPb2i98T1zxTNqN7yTkZJ1mb9J8ooBqQkShSfSw2vksf4MEDYnFizOPG3hnLu5/
 pIs/sGaAJx1Gee4+0sKCtJYylJkuTjygw1JoZQzAvO5i/oKdvardSPeWAEaQdFjKWklA
 9M75qWJEOLBHJXJVsx2cMCk4Q52Pw9jBGjGuxppkk+Te7HzZ0qRSdBnttfHwSZhVHFbv
 Sqyi3/Vw/JWjaaUbrNCG+AkUO57U3fdbjS5DP/fT4ZVjFpvJtN/2d7UcmnVhNameZoPw
 QIvlVDqzjVlYtHIpVaR1LS8xFLVwhRiawAzB8dOsxo5uNHv6qq5cGKUcusR1g8aLcW3/
 JQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943084; x=1795547884;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O5X5NKVFdAgJ7t6i8D8u7su2ychxPuvXSTqcPROeyhg=;
 b=lrhFiDJHHWwAOfMI6u9Jyuz4Z/ksFROZ0i6xqFEELR9aGxJVxIrgEUmOcOxlFD2uKF
 uEelU3ePABb42YPo9OULN5uCaKoSxjKG6OdrKo2FbleIj0L2pOMwc0mrLOX/RBgCFRAe
 e3lGaUh9BscvfqPLvoXFjRm2GqZX7Pq4qvbVEtvr0/fwP71s0fNM3U7RpXk+qvZiC/x4
 KNEp+8tBx6F5OYp7AahggZTPFZ7HkEhajpF1JjigeqWqiWTmOCzTWT1g68OA7wbjuLTz
 q4PP71zZHuOZeC9ZLbMXotY6NSAZTFvikbHUA9CFnIsJUjSf2KRxiREaC9eLsPzGMJpR
 OYJg==
X-Gm-Message-State: APuU4Z+iR5+2NKxP2SMS5G+kxBGVOskXK8OSprHpOK9xKSjXrzfiDbsp
 l/mFI7BZ7JP/S/hx8uAH5I5nxf+K3uhpZez13O/9dwfpYDmE6jzxkLM0vKYdSfzfruK6qvNQk/Z
 JiqNn
X-Gm-Gg: AZFdTZe3ESYIWH0k1ZHhNCMJblzMp3buEwKWYDg8RcYple6YYmOe//TnraFfNjkAuq6
 Az95yc5q4W/CkBpJ0CUOAC1lcFp+Pru0IEK4KpkbkqxOEIIO034aqb5mO4onYq6XFgHKNrkzlPr
 8QKQdQ714iRZ4Vp4QFwXGH9lF5s00ujX4Gk0lZlEyRuSwfi/cO4UWTL263Oz0en7/LY39mo3AR9
 hx+s1jbUvGy8QfPWqPSfTZK3hqND9Yjz89A8aZhU845vm17W/YruP/SSIRPYG/gEIgd2qOuBarD
 mt0N2QuI7beCBn4Bq5pgcNFgdugiJvu5jb2AI/laAl+bsqVywb9+kmDwSB241RLSp8NDDRp3K0u
 9hHHJesR8ocsYBqN5LyEaM/ThMHD4oiGoDzx2ODBob3vlQ6/521Lgxg/FxaOlTjHJKbHCQtFali
 LsUXfy1TtOV6ifTxIbCdKmIc7k06afHw5RB3b6DGBIrbDeS+wovdA2FGKzZ3AqVV/UK880TiPms
 64mD+lG7/CnCdy+JVG4Ae1ceiYgKMfydNvl0JpFtVGTe3KFByDVT9GTQuFPCYJ0uSKxwrP7tdwv
 NP4VW8QywQ1OUJWXlTh0u2JgCvjkO03H3Kw3/Fktn6muJvms/I3JJKEicto/FadlZU9v2GQ=
X-Received: by 2002:a17:90b:1649:b0:3b3:a9a4:8c9a with SMTP id
 98e67ed59e1d1-3b3d064200emr409983a91.1.1794943084274; 
 Tue, 17 Nov 2026 11:18:04 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac254ba6sm5296598a91.4.2026.11.17.11.18.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:18:03 -0800 (PST)
Message-ID: <eea3dea3-5a85-4b9e-a74d-17f3d5c56296@linaro.org>
Date: Tue, 17 Nov 2026 11:18:02 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/19] target/mips: Fix nanoMIPS BEQC16/BNEC16 corner cases
To: qemu-devel@nongnu.org
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-14-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> BNEC[16] with identical registers is never taken, so it is a NOP.
> gen_compute_branch_nm() instead wrote $ra and skipped the next
> 4 bytes as if it were a MIPS branch-and-link-likely.
> 
> Also raise Reserved Instruction on NMS cores, where the 16-bit
> forms are not available.
> 
> Fixes: 764371d24c51 ("target/mips: Add emulation of nanoMIPS 16-bit branch")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
> index f9dc573dbb01..25d57e75a0b0 100644
> --- a/target/mips/tcg/nanomips_translate.c.inc
> +++ b/target/mips/tcg/nanomips_translate.c.inc
> @@ -4756,6 +4756,10 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
>                   /* P16.BRI */
>                   uint32_t opc = extract32(ctx->opcode, 4, 3) <
>                                  extract32(ctx->opcode, 7, 3) ? OPC_BEQ : OPC_BNE;
> +                check_nms(ctx);
> +                if (rs == rt) {
> +                    break;
> +                }
>                   gen_compute_branch_nm(ctx, opc, 2, rs, rt,
>                                         extract32(ctx->opcode, 0, 4) << 1);
>               }

Surely not.  BNE x,x is never taken, but BEQ x,x is.


r~


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C9606A338
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Kv8fhlr5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTObR-0001PJ-Vs; Tue, 17 Nov 2026 14:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTObQ-0001PB-P3
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:12:24 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTObP-0004eO-1d
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:12:24 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso20839a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942741; x=1795547541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L9fDlQeRnZ1xI5oeh3haZPs8dZ6XNN0WbJpKX2eufag=;
 b=Kv8fhlr5/C3NymHJ/iplwrjBsnFND5onnAh6MDfIrhKRUaSInqPI6UZq9Te4gx7iQ/
 /2RyMfT8IwujVkcC241M+GwICCIw3McDeDXBLYAxbPK3scPGruEDTe+gOhmFlyi3DzMF
 OldPHBSicmNviRzFlUauMtv8uJtlgY3AJXgiMTDrHTvNW318hbPChwrOrj33I/iXHMdh
 FOtZr8BDZJagceJUtgCCRSRYCB6liGsUM1CcCC0ghDdIEoc7gysz5YsNCImQQ7NlSgLq
 cHUWGmZJi5FcurXSssbKHW/5nYF9r7+OeQvNGWftfCIhCJAnwvrhkJRKq/LBIrhEv4ep
 LBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942741; x=1795547541;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L9fDlQeRnZ1xI5oeh3haZPs8dZ6XNN0WbJpKX2eufag=;
 b=OTv8hFwFNnuyXZKhUrBRtrKVdrpO+LO23rrTJdIXB7I+sRg7hS/cHmpc1+o8Q6CCL2
 R5PEeIYrouilJf8OsgOTmTV3LDY5Uz4nvvkkfiXcIc/qSxrex/uFFQ7MGCguVi/4tnns
 5Luc69C+fgkT3dgBgRWp2BOYSJAS1mVZAT+Zzb1F9gyy9tSWVO3ZdHrr8/vqzBn8+hNG
 tnbgpOKxQCevsbMpsARRq134OnzaOtC8uPGpSURH3PcFlIuzExZjLnzUfQTMtNtTegsE
 hWaOtYxgC/EJsIC6wTeBxr43OZ9tmqF+Q73Az4Wg2JZWAfylz2mRfCkEHdO4zmFPwiiB
 A+7A==
X-Forwarded-Encrypted: i=1;
 AL+hErF7wF9E4FwpPPgywXia2GMbEdHNeLfdSEKCiM6x4pN3aWqkQjV+qWtYrDIlkCRr+rWCHeDGfqIJ993r@nongnu.org
X-Gm-Message-State: APuU4Z/IPMjey+X5GEgG6gNVilumSY+T2rVykfflAtIZIpksecHLji9g
 ccuMiSFvTV2e2IG/M1aoUuUhhqRdZcGFq4uFq8d/600npFvreO2a1Wwy5juWWUOEmfk=
X-Gm-Gg: AZFdTZdPmLvY+u+qagKp176gBZ95J3aLcNl6v4CinCSd1jzM91NHEQTwJKEhWa8PkTw
 BjC3lMopLSWXHditvZGilP7ATzVVvrD6nd8VBoUl28sWJMelcEivNQJt3/MTJ4wjvZL3pRNVK2o
 fwVd+l+W+1KDnu+RWKrq73LSuDC09+AYr2LxKhuAIdK7WmgdXrX1qsqCD5qSKrXCQ76f+f+XYu3
 bZyfa5PgQCAIkY40WaJEM+HAHItKNwF5WumoONyjSwB7TmEgQSPs3Gh5tTKkWBqHTb+ArkLltsm
 Y3H+V93ySOruHEN6Ze6tvKbUTLA7yLqhxJM622ZMe3DLS/M+wJo3tluToawsLj0hz7La41hQVGq
 6eHcwzbopaztgec48KtfKGG90bZ1R/gk/xDE0mCPMIyW3ZZ0qnkv8fU/3RW6JEUnyax6gq3W+Ew
 AXTZjgkR3E7LRTHR0/PxXocoqw7pAbpbliHvj82N5G8eX1+jJDmwFHeY3SzeKVw+FAEJGi+XAf/
 tA2v+p1QYvnpONAG+igG5RqX5rJ7DdQnNKlR+XJhU2Rx6Gh84xvm5D7ZTQK8TgFgjU2nijldeNn
 4vdqzTUWKAWC4bGRRUbp8fCTDL6fH7clp35Xo1Af9Z1HXxHJxM1iYuOt8qGF+BEllgVa/pE=
X-Received: by 2002:a17:90b:3f88:b0:3ac:a203:e0a1 with SMTP id
 98e67ed59e1d1-3b3d07a9f77mr358500a91.37.1794942741262; 
 Tue, 17 Nov 2026 11:12:21 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abb786f7sm5283193a91.1.2026.11.17.11.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:12:20 -0800 (PST)
Message-ID: <224749bf-2ff8-4311-a19c-8a92721cf8c7@linaro.org>
Date: Tue, 17 Nov 2026 11:12:19 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] target/mips: Add the NMS check to the nanoMIPS
 CACHE instruction
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> CACHE and CACHEE share pseudo-code raising Reserved Instruction on
> NMS cores without caches, but only CACHEE performed that check.
> See MD01247 rev 01.01, "CACHE/CACHEE" (printed page 63).
> 
> Fixes: 8f1d9b6d6397 ("target/mips: Add emulation of nanoMIPS 32-bit LD/ST")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
> index c883b5514f1c..20e96f2ad9be 100644
> --- a/target/mips/tcg/nanomips_translate.c.inc
> +++ b/target/mips/tcg/nanomips_translate.c.inc
> @@ -4131,6 +4131,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>                       }
>                       break;
>                   case NM_CACHE:
> +                    check_nms_dl_il_sl_tl_l2c(ctx);
>                       check_cp0_enabled(ctx);
>                       if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
>                           gen_cache_operation(ctx, rt, rs, s);

Also missing check_eva.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


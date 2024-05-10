Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C3AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Tmf-0005Mz-PW; Fri, 10 May 2024 13:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tme-0005LE-7B
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:11:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tmc-0000aJ-IJ
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:11:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59a64db066so599373366b.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715361104; x=1715965904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+lZvMQP6JgIkW2wdYSv73LvqD6PGHdalTtkumdKMCU=;
 b=FC6+EzDuBsg72XwEr7kVS561O8Ldwvnl3VtFos89dIE3vpv8Jl2pKsHlBbUjRVgmKk
 l1hbDxhEemm2UTDENn3I2t+fGhyOZdZHIFec+WiRXERVJOi/2TlwvlpNxt0GNunwL9mI
 LkECCsDt3qWbsKFLBzHGjqOgK9R1dQ6nkT3gybYXWVnaJ+H+9+0tHaSbbQjWzJha8XJ2
 17r7KTL1KZsl7G1l34vuoVF4wOhD2MKno0P/SaH5wxZcrKJEVRFQL+21ohb5gaJ5vpXA
 CWLehYOviVxjs8NZO5tc0Jyzm92VSPu9tFmONXL59b/4UzSc0f2HjXIztAIUgQMKi3Bj
 86Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715361104; x=1715965904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+lZvMQP6JgIkW2wdYSv73LvqD6PGHdalTtkumdKMCU=;
 b=n9Tk/mZI/1VYKKDOd6Dv3tGBzs8JyF5xlzK0OP/KQfsNew1LsVp+7aSrNmIUM+rzA/
 MKOyhs2df7WC1lmYdZ1u2k0VhQfO7NHoq+DGAMzEtvpuf4RgCyJZFarFIi0DCYONR81Z
 /xeA6NbBgfRZV77MKW1i3EcDBdk8NQnZa2CWpHfgQGQiKUobzQmGdzdoE+QiXr3Vs7R4
 D9Gf3g3TKKqA8Td6loHaWJbEK0wKvy8CbOFw6sb7M5kqqqRhictjV5efsRRnthdlRzRt
 f2X1XhLHB1c69dhOcCGN/x3x+l/6RYCfvnEYzCqXt4OUm+LNMtcVHCsQA6GuH7UOtp1Q
 oAUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCks84FD7ALg6cmIURoNCZidWofCXZINVy5+E5+H7tW2YFxId3TiPKy6+/P28Lbrd9222uvfjPfzLYhm7lN4vRxVAilWg=
X-Gm-Message-State: AOJu0YxfGe7679Sn75LqI97b3twOZH8wqKGJLIRbyPou4uIhhR86ZmhO
 RZtoZwC3s2M/K4zKyC4VppfmKBtsZCIQnXRUlgUITKBsFAQ5ADwMY2KSGMIh84Y=
X-Google-Smtp-Source: AGHT+IH3gc0r6EIrTWK4dEqLUJk0s0Cx/NP76lyLUlhy7+6o+rG5AgYWPTb3t/c5eaDyEdVV2InDJg==
X-Received: by 2002:a17:906:f1ca:b0:a52:2486:299f with SMTP id
 a640c23a62f3a-a5a2d67864amr214749466b.71.1715361103631; 
 Fri, 10 May 2024 10:11:43 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891fefsm203605466b.62.2024.05.10.10.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:11:43 -0700 (PDT)
Message-ID: <3161bfc0-b43c-475c-ae3f-2c0a2c73fbd1@linaro.org>
Date: Fri, 10 May 2024 19:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/41] target/sparc: Implement FPMIN, FPMAX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-38-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 14 ++++++++++++++
>   target/sparc/insns.decode | 14 ++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 5f1982cecc..8eda190233 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -5053,6 +5053,20 @@ TRANS(FSRL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shrv)
>   TRANS(FSRA16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sarv)
>   TRANS(FSRA32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sarv)
>   
> +TRANS(FPMIN8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smin)
> +TRANS(FPMIN16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smin)
> +TRANS(FPMIN32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smin)
> +TRANS(FPMINU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umin)
> +TRANS(FPMINU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umin)
> +TRANS(FPMINU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umin)
> +
> +TRANS(FPMAX8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smax)
> +TRANS(FPMAX16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smax)
> +TRANS(FPMAX32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smax)
> +TRANS(FPMAXU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umax)
> +TRANS(FPMAXU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umax)
> +TRANS(FPMAXU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umax)

Easy peasy :P

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



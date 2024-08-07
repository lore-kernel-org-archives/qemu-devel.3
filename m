Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DA1C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXHt-0002Zu-4R; Tue, 06 Aug 2024 23:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXHq-0002YC-QP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:24:30 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXHo-0000iU-MX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:24:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb566d528aso997661a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723001067; x=1723605867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7dymT6GWY/85YLKq5GM6+U4tgPID53RbIfh95rNKFSo=;
 b=WEPWNfKiF7+H2rt2LQ+WVEkfC/SGr27ZPFsVimBLeTgcYhb51clbAIr5d3uVetNJUH
 Etfr3SmwP/VjwnhuNijbLjrQ9BpqM88PM81onoNZKaiBIjce3MsPTs3r53iguo1hwNq+
 mttpFPxzKluJbiKJZybVTBTbHT9lPTbTAuSgNt5Em6uhI30elgGgVpWEkq9axRUz6dip
 ckjoNf6LzaKlVQ0wdjC3K/4zA2jEntTVChMoDFaIhPgOF/dFX+JKd3rjqlC/QrAeZ7OJ
 /2MfVB4RZUykyzmQAUiOkEW7Y0UH65XZ7fQkq3VMy4BrQQTtu1BVuoJbuKpyiyv+tT5c
 ibug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723001067; x=1723605867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7dymT6GWY/85YLKq5GM6+U4tgPID53RbIfh95rNKFSo=;
 b=w9uGS/cEdhZ8y7Mb+DCzfCOQuugwJ+29yCHdP5Eiv6WWOJxHQjn0bGw0mDVXk+f04Y
 8Vu2PV1kuRZy50b4lM60ZvxJaAqMG4R/XiGR6YfZa3IyXDFj+5yZi73xZD+kKE5TxR6A
 PSyulgpR4Gz4bVzSCNRLFTvVcJvrH3YKSkrhpvhZJ2GPRc3JfX+Ycsf5xj4HuzQ+2FC3
 byf8IWkxYReN1YqKTwEc+rhMpFxqtJerW4DuJ2GM+vZYELxt/lRJ9zLruK/ieVEoYJBr
 tb7/RnSkPidpfxY8fDZ9mLLMr8m6wKmrEeE4yZdKKnSktzqNmyaQTab8jBfkTkRoKC2j
 MCag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaSQ7NLIGrV1Q/ZXzsvpEzrIB94f24w4SGQjFTTGerufsM0IjyIyT/zmbbylygaS9RcGKuNRSxq3Ioni0w1EMyGbCW1H8=
X-Gm-Message-State: AOJu0Yyc0SBD+g0zBD6vM2jyJbShZLMvuFlhCo4/Ee6iWDfLHfu2kiaQ
 jcT6DpNnEsov8E4qoWTMxNJiWqlTm6GrpZCVuzFx/evgGFTWIy2VNtYX/XB8kzc=
X-Google-Smtp-Source: AGHT+IFWxNV5aEZDS18vv142Cp4+TUlu/vHqy+GHjYaqb2j1WR3JsfI0Vhq+ElSSLAVwoZHq6lKrzg==
X-Received: by 2002:a17:90a:2e17:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2cff9449532mr21059971a91.14.1723001066636; 
 Tue, 06 Aug 2024 20:24:26 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b36a4e0fsm291675a91.3.2024.08.06.20.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:24:26 -0700 (PDT)
Message-ID: <e2488c82-564d-4042-a985-a308feb68bef@linaro.org>
Date: Wed, 7 Aug 2024 13:24:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/20] disas/riscv: enable disassembly for zicfiss
 instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-17-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-17-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> +                        /* if zicfiss enabled and mop5 is shadow stack */
> +                        if (dec->cfg->ext_zicfiss &&
> +                            ((imm_mop5 & 0b11100) == 0b11100)) {
> +                                /* rs1=0 means ssrdp */
> +                                if ((inst & (0b011111 << 15)) == 0) {
> +                                    op = rv_op_ssrdp;
> +                                    }
> +                                /* rd=0 means sspopchk */
> +                                if ((inst & (0b011111 << 7)) == 0) {
> +                                    op = rv_op_sspopchk;
> +                                }
> +                        }

sspopchk are only rs1=1 or rs1=5.
Similarly for sspush and rs2.


r~


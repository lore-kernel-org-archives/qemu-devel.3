Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D76DCD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMtI-00042z-1H; Wed, 10 Jun 2026 13:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMtA-00041N-Ez
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:38:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMt6-0000Ss-MY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:38:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36b7b7b7a80so59822a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781113121; x=1781717921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R94zidZChU5oxcsGfuOOFS3E/QKBSZsAj5wY3vMl6OE=;
 b=e+Px6GEFWZyE3KryIFjOOY3mrnXwmz4LCTnBfRVdWkT2EOYJytO5335gmKzp45KnXR
 cTPRm/ubK5hQHEfz+M/SIp2KPuveeiICzNB9XWhkBTXVorYBljQ2ZAnum0QgIW9hPVKw
 JtTbEXpCHk6ouTTCGK01K8sfIw4e2bCWUZu16uaf9XmJnrr/+JyIcL2DrweayTofMzYc
 OzXcsK3veEnZ7h2faaCZw1T4ggZh7p0F+/TC+j3dXNZfnkDDngmK2MRVkEtwoHuhG0jZ
 BwXOS6uhe1EDdfZpfMEh3EmRu3dZLEumDZ7w8/FR4tcfjsM1xZuN+RixWdV+MkgNHvLW
 4zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781113121; x=1781717921;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R94zidZChU5oxcsGfuOOFS3E/QKBSZsAj5wY3vMl6OE=;
 b=SjeoU9oRKBLVWF+kO1omFTQard7tOwfzZzKM++ef44z74gEewEgfhoxpuLmCVjUuf9
 v0Ym4qKB28lq196UiZUv1xcvto9tNRSm9f8WwHCI+0xvEjn6mP1ubQco9J0swS5qIvd1
 O+wf/Mk3slaeB2rRjpNFJ/kwvRRQX58sF9z47pPMPcT9y29aDgb1h/7/pnWrDTprSrgh
 6behfbQkv22+GzRs28L5HHRowqxsNm5xb/1SnKpygzcVVVK62tsQVnGmZZJwlxiNSU5J
 qxETvd6ADDVLbb6IeGIAab8S859VcImkfmqfg1gid5k4DAEivEUHldTaOkeq4K25DGq5
 lQcA==
X-Gm-Message-State: AOJu0YylwRFKc2mk2k1d2TAJbYA7BzAlIDhtOntWT3o6tcHtrVMq+kFK
 M/gt8CbVc1cVNDOQK87pu8CURWULWQ4uDg03dBhqbbfMzH7/IEJIwryIBPITH6FP2r4u6W+2byS
 FuP4Rhto=
X-Gm-Gg: Acq92OHXOA3Y6WMK1bqf6RHTpjeTCB8CNQAtsRMx8GnLMd4ASFbKJ1h3MdfASEDR0RI
 vxpHUwYN7pkhQMx0LpmWICQsoE/0SkvJatzcwnid81SStrdjRHI22721RzNelqY+YJ42mIMv4ZO
 mj/Y7RBYOV4/cT5orwmo0w8rzuQPJY+Op8Korp945musXH695lPmI7A3dEbeMViitTy3ZuGxSaQ
 mrdGZ2xOCc6W/GnjM/H9g8YjIVCc+y4QF9Y3odTHmsALR47e3t2qj0gM6t5ntZYoDhUwuC7VKqz
 zldL896hJOTZf6vTbKlZPfXXmbK9MHZIvCMaisKJUMn3k1hOnHDu3+MMZpIOnvOgA1p1t6o7OUF
 Y1VE5U3OFWJ0YRnB2U+d/LAAbekDDWlvtfRLkmFwurEHkV7XVMXCc9ShneekwD5wbzOgNU7n5oo
 9AmE4hdnlxZMetSNyhMrtphOK/pwUwomK0u8EjT+ApkhJUx0FwCETuGYb8GQ==
X-Received: by 2002:a17:903:990:b0:2bf:1845:baf5 with SMTP id
 d9443c01a7336-2c1ec918402mr220134035ad.12.1781113120766; 
 Wed, 10 Jun 2026 10:38:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f84335sm252397975ad.19.2026.06.10.10.38.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:38:40 -0700 (PDT)
Message-ID: <cd4a6a8a-d081-4c41-8e9a-6fbfc7d9b1af@linaro.org>
Date: Wed, 10 Jun 2026 10:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
To: qemu-devel@nongnu.org
References: <20260610152648.677463-1-mattst88@gmail.com>
 <20260610152648.677463-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260610152648.677463-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 6/10/26 08:25, Matt Turner wrote:
> +    {
> +        abi_ulong xtregs_addr;
> +
> +        __get_user(xtregs_addr, &sc->sc_xtregs);
> +        if (xtregs_addr) {
> +            if (xtensa_option_enabled(env->config,
> +                                      XTENSA_OPTION_DFP_COPROCESSOR)) {
> +                uint32_t fcr, fsr;
> +
> +                for (i = 0; i < 16; ++i) {
> +                    __get_user(env->fregs[i].f64, &frame->xtregs.dfp.f[i]);
> +                }
> +                __get_user(fcr, &frame->xtregs.dfp.fcr);
> +                __get_user(fsr, &frame->xtregs.dfp.fsr);
> +                cpu_set_fcr(env, fcr);
> +                cpu_set_fsr(env, fsr);
> +            } else if (xtensa_option_enabled(env->config,
> +                                             XTENSA_OPTION_FP_COPROCESSOR)) {
> +                uint32_t fcr, fsr;
> +
> +                for (i = 0; i < 16; ++i) {
> +                    __get_user(env->fregs[i].f32[FP_F32_LOW], &frame->xtregs.fp.f[i]);
> +                }
> +                __get_user(fcr, &frame->xtregs.fp.fcr);
> +                __get_user(fsr, &frame->xtregs.fp.fsr);
> +                cpu_set_fcr(env, fcr);
> +                cpu_set_fsr(env, fsr);
> +            }
> +        }
> +    }

Unlike setup_sigcontext, where you know you're writing into target_rt_sigframe, here 
you're reading from an arbitrary address.  You need to lock the new region.


r~


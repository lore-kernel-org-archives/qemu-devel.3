Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDACE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMprj-0000Hg-Rq; Sun, 15 Dec 2024 09:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMprh-0000GO-KW
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:45:01 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMprb-0000TL-C2
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:45:01 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb98b3b63dso813974b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734273893; x=1734878693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gR1JMZiBBAJp5g27+96U0czdnIZqsbNED8IuwANJUdQ=;
 b=Y5p1iJpBr6VNAMD2zLYdm3gFSO/jwR/Iyh1etKhQQY2wDOHqGJrz/eupd9l+jnX61K
 LEHOfn/GH9pnm423NKSlKIy7VCpEgduHRnngqnewcy4b3MD2n5CJ14F0yOAOYIYgCdYn
 XJLaLyE9A9g65jtRBh9bRPE/pwsj0lWrPxI98RPYVNL0j3ve028KhTFjzt1Tsd4c/Vwj
 heqY9LVnnxynBm/wGDvFfnYeIxCUpIIuVsd//MjX34c5mWTbz1rewNDDaV8rOd7Y+syc
 bPCTIyNVBaoJbUVBAkfqMat8epfBYQr60JdSN3qq4ukp588it/vGfTMSEcxhzGSChpK6
 sf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734273893; x=1734878693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gR1JMZiBBAJp5g27+96U0czdnIZqsbNED8IuwANJUdQ=;
 b=RZqV3wP6OAb153SnX5fufe5ahmfLZrGpsdtfBHkeWu18Qa2sWYio1FUzSQOUf9uUTE
 msBI7t7EHLqsBe29C3jtyXy2DKAHo6uHLZ/eJSWMiO5qlIrguq6yu/aTyO0tY5GOSUsw
 vPThAlrs8bSOKlOq+w0ifwf1CIANNukSWaJN2Ig8vmaIszaXgAqGpaBtP/DhOtCQZVME
 Yl0VsNFQAqf/2dQLsHCmQt5KPEylm59T/SBCCBuiA8UMGfsq21kY/Fun84a2yvaNFwOr
 WyZX0LguJEnjCITOFGxl4YKvZAKQPgxGN2QvAGeNgPYBPZ30DHWlMWI9x2iqQjF6XbHv
 DWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJwa6QqWoJbu7sZOuRX2gxBnoEzOn48CtAxEDihsymb2IDqtGhcUFBZNtExBwHLMjjJzijYfrJOXT8@nongnu.org
X-Gm-Message-State: AOJu0YxPuRENFK1wkjSxPORyHFpsLo5tUmiEYDauTiTu8px3dyCkpD3a
 LQiOnPXdpUDA+VDmmwtCfJ96trcZqY0/BIbIqRTzjGs1CWm0597jz9CEVI/DlmE=
X-Gm-Gg: ASbGncuv6iSjF1jHrkZRcEFRA67T2tQ397RYARKNlq86/D8d7mhFpNjSR9iBG66NkIm
 j2ICcyem0zgW17mNrGtWQQtxGePFtcS4X4W40+AO9mQo1p08bnPkPLilqlh5CGi2n9C7/veQcsN
 91h4Kdfra2NBje7TC6t1tbyIxInvJQcywWDl1mriJYoNXbojjrbx6TC++lF2jn9Q6e2E2dCd4cH
 QegayTtXFZMakLAKSuEkhd7UU9yl3ukj1Jh0oub2xVQ32AMvSRKPD+sRDPeE2/m1EnGtAYqv2Cx
 5+MsdIbh/yI7rhTvj8llKnOD6vbKfWrFijs=
X-Google-Smtp-Source: AGHT+IHrEC8vdr7icRyNhwY3itYv5qzBAuaWKys+4s255ON7qANTwtORiu/Gi1dH9ozIqXCum4zeFQ==
X-Received: by 2002:a05:6808:1590:b0:3e7:c7c1:e6cf with SMTP id
 5614622812f47-3eba699e95amr4728126b6e.43.1734273893522; 
 Sun, 15 Dec 2024 06:44:53 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb48ce93esm1017896b6e.36.2024.12.15.06.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:44:53 -0800 (PST)
Message-ID: <98175648-fd1e-470d-a8e4-a6053cc3c35f@linaro.org>
Date: Sun, 15 Dec 2024 08:44:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/i386: make cc_op handling more explicit for
 repeated string instructions.
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
>       fn(s, ot);
>       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
> +    gen_update_cc_op(s);
> +
> +    /* Leave if REP condition fails.  */
>       if (is_repz_nz) {
>           int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
> -        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
> +        gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);

The comment in gen_jcc would still seem to apply:

     CCPrepare cc = gen_prepare_cc(s, b, NULL);

     /*
      * Note that this must be _after_ gen_prepare_cc, because it
      * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
      */
     gen_update_cc_op(s);

via any path through gen_prepare_cc that reaches gen_compute_eflags.

However!  Because this is JCC_Z, we will never call gen_compute_eflags, we will always go 
through the gen_prepare_eflags_z, which doesn't have the same problem.

This subtlety deserves a comment and maybe an assert.  Perhaps

     gen_jcc_noeob(...);
     assert(!s->cc_op_dirty);


r~


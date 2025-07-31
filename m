Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E35BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZsX-0008HA-Rv; Thu, 31 Jul 2025 16:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYHI-0006gh-Fp
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:45:21 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYHG-0006ai-KF
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:45:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-31eb744f568so674519a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753987517; x=1754592317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pvy5z+5j/jMqX6Zslu0wVy82+5aTyBNotJkzDRoVQ34=;
 b=ZJOd5NJbXTmx3weDuXRJU0qcpTDI4IaxryjuhhY/K8m09hxXDnBwSXZ2AWqEn2b0dq
 av+9pDbDfkCYNqiDL/te5Lhkk+Q7N+wViLt1a2l37uVCBagPGLjaaTEKrZD/Z1wVc2QL
 Je9VWcAhMTm7rbEcJig/0hbx9FH75lxxOc3gdtkaUMgjIpy4VYY7HLGanY1FcFd/Bmvv
 ZUcZ2YfPaLnc3NnthnTe5Qpb4hIckLNPpBhRnOd65o5ZQq5RXiE3PH8vm06zrqfcjKMy
 BHjfqFRlPyjcKhTf1SMQxbVdRaxgLIPjpzai7lldV073V44dJfe8VoMoDxBdfCmEhV+/
 XeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753987517; x=1754592317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pvy5z+5j/jMqX6Zslu0wVy82+5aTyBNotJkzDRoVQ34=;
 b=HbHd6l99l9x9sGZbfDM2QSUUFCgqMCjZKARIulN89xlXtEK25yzecXU3zmGpIxynP5
 4I1UqEPnxMzHMdG5WbJbq+D9NvzPWjhyQQkJWwoeXMCub/qCb4QOkua6GDAsBT+XuxEW
 /Mq1JQAc67oqltXMuOx8b6g45Grn1/7L6GvQ6l/cH8yiamwd+G/t1+wXE+m4oL+htPh3
 udiKzwbmri/pUNBcUmYDS/tGDvCpfdKuwVSBtCFqYmszX9ooxR3Z/37X4Gtw8rVnNqdl
 /mnlzgyxz3b+/kq3esjV72mmBPDMMnrPgu5isfE4tPJ0IDbnnME003mB3Dv6owBRXsmg
 5VAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2qxzDSmJRuSJTpApRx42cA7vDZtrBp/L5PFfhx4gsNcM/B50jlBb3RKCui5Nl55qNKs20ihPE6NDp@nongnu.org
X-Gm-Message-State: AOJu0YzysIpjLVK8OHUrv1F5sjZhvyHmkrrJ+hjirMGB9C7hLPggnH39
 Bgzf2j+ElU5Ui1Wtnh+BWxfdYfFwisY/Jt/enZEJ6Lgrt62B5wJhRzoLDNwb5ffCx1w=
X-Gm-Gg: ASbGncshplW/bnCVROBo4dUqChrG5BDhHw1h1mJjClXN1YIBhTcuI3tOlOldbO5oOnG
 uhdxIAAq0C4X2h72kv1C+ac9LdbiCMfg6f6t/lMLz+QwCI22U5OCeB3YEoKj5qBIXaYaN1YMNpC
 Bl7UEAKDzuyMuPiGZeZS793LnG07MrspbVKuG8Gz/rsjS276+UeUDweTI07QnNDAFFm5gMTqThJ
 nQOMRzAwrxyYWcOZHv08Pk2/pXaKL6bZYx93pGmZDhDL2aDn05yroYoiuwNwdYk36IJocquN1Yz
 BzZobrUzeu8KLT6kM7MTyPE3bPz7O6W/b/I7CqW445+fwFtFAmJdq+3/to7XZXx38sGczKcmnDI
 pO9bTdUpvDQAoOcnvTPQFOo8FTTROOr9W3hscyFH+uNfugw==
X-Google-Smtp-Source: AGHT+IEoTMM1C3WJ3WXJtYLga664fFOucPQuDYZiEUyJBEUGakmTng/CMVW1g1mZumradOuGkeiP4A==
X-Received: by 2002:a17:90b:57e6:b0:31f:313b:4d23 with SMTP id
 98e67ed59e1d1-31f5e3809e4mr12308335a91.20.1753987516840; 
 Thu, 31 Jul 2025 11:45:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f30fd6dc1sm3671198a91.3.2025.07.31.11.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:45:16 -0700 (PDT)
Message-ID: <e88e893a-8274-4e37-b282-c7315eff0307@linaro.org>
Date: Thu, 31 Jul 2025 11:45:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/82] target/arm: Add GCS cpregs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-45-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Add isar_feature_aa64_gcs.
> Enable SCR_GCSEN in scr_write.
> Enable HCRX_GCSEN in hcrx_write.
> Default HCRX_GCSEN on if EL2 disabled.
> Add the GCSCR* and GCSPR* registers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h       |  2 +
>   target/arm/cpu-features.h |  5 +++
>   target/arm/cpu.h          | 12 ++++++
>   target/arm/internals.h    |  3 ++
>   target/arm/cpregs-gcs.c   | 79 +++++++++++++++++++++++++++++++++++++++
>   target/arm/cpu.c          |  3 ++
>   target/arm/helper.c       | 10 +++++
>   target/arm/meson.build    |  2 +
>   8 files changed, 116 insertions(+)
>   create mode 100644 target/arm/cpregs-gcs.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



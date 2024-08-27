Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DEFC5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sikBN-00023v-F2; Mon, 26 Aug 2024 20:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikBL-0001xI-Ap
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:35:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikBJ-0000qt-LY
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:35:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2021537a8e6so43939445ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724718931; x=1725323731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iTrGe8t+lRAPQ3RUHKo6pUDPHqKQ08vcf/xIukjFfgE=;
 b=aiKmY9ftTxHbXtGUTZeFzt8JnDxCHTwA42u6VfjKg/ONjCEuqYGQ4bjAetHsiFwcrw
 Aa6/4us1veNKPat5VBisBp1KKlEj/AoOMZHC95TYMwVh80PtGd9EpfowaQQR4McDgKAV
 WdCDRKJYCB/zjUZcNCpIg+cRdojoLv1TmabETdO0cubE0stWbs/EkxBq56X7WEM1vhOJ
 Z4N/NQOBsbramKGOqtk3HyD/JpQ83JFmWx4x/a5cQcURERkESVxovYKdrSCcrbj9GhEP
 esR2EWCp6jMd7jFX4rFmvrzgh1JZL/e7Ggk4eXue/KfVLEN0EDb3lJTTBD/9XYSGujdr
 LQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724718931; x=1725323731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iTrGe8t+lRAPQ3RUHKo6pUDPHqKQ08vcf/xIukjFfgE=;
 b=ZJOxT/Au3WW1euze8siGgs81XXVq4A+6rz+ktjTxhdnbMlqOB3QM8VhT8TvsOWegip
 AWKYXXRO0oKLzc5KxtqRgc54X4rtcJbTM2FzdGee6YmcS2uNZCwQX7eO3dGMqkIXbAzN
 dgRYGOpA7aZFFyDh0bjs29qG5HR0Xep6wLKosrBIp3yAmOiQTDcaDGAJj4sJaEsO5JyS
 7BuHaBgeHVLOAkbOuUVmh/n+J6yZQZf64pOF+dQYiuFFv3yMIGRPVQzNleEKR9N0S2iv
 pNCeQpAQJsfjI3dwpsZOqgTohbHI9U5cqsUMxQfFgOuQpzmc6uwrrEqjqncSHL5wuKTT
 qBQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXCPBG5gvAIshEAB3nay40NlOWSy0rm46kagXIFRUVrj9ziiRF18+kclUyksQ3kTmshbK1D8g2KS+u@nongnu.org
X-Gm-Message-State: AOJu0YwJ/oyPSbhBiJ5XKZlHVY46KDLQSBVbJWbbB0vyMBJmYOXAM0Vw
 Y3T4HJUDFI4mZAAV1XRoVG4/D7dGnwGUxuvsq4Ve9/ATIlTtbava9xuAJBVG8q0=
X-Google-Smtp-Source: AGHT+IH3n2uuOb3hsl0S2OMBQ3UTxUio307msBGPotruf9bNRhgXit97kzcR9rPGEbVYUptvF0G92Q==
X-Received: by 2002:a17:902:db05:b0:1fd:9b96:32f5 with SMTP id
 d9443c01a7336-2039e4b4c40mr145533695ad.31.1724718930913; 
 Mon, 26 Aug 2024 17:35:30 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385be0f63sm72415245ad.279.2024.08.26.17.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 17:35:30 -0700 (PDT)
Message-ID: <f088d72f-9394-4743-a17b-f69166a2b839@linaro.org>
Date: Tue, 27 Aug 2024 10:35:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/17] target/riscv: update `decode_save_opc` to store
 extra word2
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-14-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826152949.294506-14-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/27/24 01:29, Deepak Gupta wrote:
> Extra word 2 is stored during tcg compile and `decode_save_opc` needs
> additional argument in order to pass the value. This will be used during
> unwind to get extra information about instruction like how to massage
> exceptions. Updated all callsites as well.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> ---
>   target/riscv/insn_trans/trans_privileged.c.inc |  8 ++++----
>   target/riscv/insn_trans/trans_rva.c.inc        |  4 ++--
>   target/riscv/insn_trans/trans_rvd.c.inc        |  4 ++--
>   target/riscv/insn_trans/trans_rvf.c.inc        |  4 ++--
>   target/riscv/insn_trans/trans_rvh.c.inc        |  8 ++++----
>   target/riscv/insn_trans/trans_rvi.c.inc        |  6 +++---
>   target/riscv/insn_trans/trans_rvvk.c.inc       | 10 +++++-----
>   target/riscv/insn_trans/trans_rvzacas.c.inc    |  4 ++--
>   target/riscv/insn_trans/trans_rvzfh.c.inc      |  4 ++--
>   target/riscv/insn_trans/trans_svinval.c.inc    |  6 +++---
>   target/riscv/translate.c                       | 11 ++++++-----
>   11 files changed, 35 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


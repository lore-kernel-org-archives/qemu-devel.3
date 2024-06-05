Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F90C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEldI-0001V9-QG; Wed, 05 Jun 2024 04:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEldH-0001Ux-36
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:04:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEldC-0007AW-9k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:04:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35dcd34a69bso5012365f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717574664; x=1718179464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tEh9sVpS0nkOk1g0MmjcMytjukZ4EFSRfe//4H/DzaA=;
 b=UVGYDgdZjQpSIBUopzPSofxFI5hudiifE2gLojioKGJ5CWlu7Er2gFWQia5UB/fsox
 6cBp94qOK4zf2cvzs4Zk3ZNAXsMUawg02D4M9TeT/84x4dhVbp0HehERfQLWJDUB5Z8N
 9Fc/DqnwRo+oT9/ZlwNahv7RudaBYayWXPmMRjNfidArKbUoVCrgD3Ori8P0PfVwH9L5
 zmTIOmIfX73T6rZyNv9bI8uMYpnCTgXU4RP+BWo7gWNpuJYNHRZwgCVf27L6AxzdQlPD
 MK2H2nln4MFLPQG4b9J7m0djzv74qBEuZhI4CmLDkon0Xpnik2IJfHbAdo5KAywuljOv
 uy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574664; x=1718179464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEh9sVpS0nkOk1g0MmjcMytjukZ4EFSRfe//4H/DzaA=;
 b=UKSrJaP+Q6cHzWfyzKNBEEVv+ePL3VSlxcSmkBHQOLWcNZ1N3wqV/Cg6eBzVnk3phZ
 wX5lEU88B1qBjECiKX4Z+lrqEhIo+o4+CDANbB/88i9TKf1TPwTasNzCCgYgnbtuJgY9
 NpLbZJHJ1NA4hX9BnAGzA5yMsuD3MDBeXszKabs0BjFp6gnqlod5BT6NS02y/rqiyAxS
 uKv3OW5+whK9yiitPyZRsB2NLjRCanSEC8s4ovUwPYKIALYnP4E2epRbvF34LupBFsm4
 kl6Y6sP+1qCpV7GnWaCIw0bkr9kIL1f5y/kC+3Zt5wKX16kY5pQQ2mAi7cJmv0GqJarJ
 Dc/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2qrWzezFUJOHGrTNBwjKJlxm8fslzkrD5AUc2dD1a/lI26COSLbiKtrVQn72dQcIn0i9IGEDGT+mDRzRUL/Y7+WgtmCg=
X-Gm-Message-State: AOJu0YykrNcs5GrVIQ9KdUoQLHdPoXz+EMPMzCvB1rojU1G1l08MeueT
 Cw1yAkupylRPON+f2/GUr6y2ry2SzGIJIiMyaiF3+7Twspfpso3QmVHOFIiA7Zs=
X-Google-Smtp-Source: AGHT+IGE3uvOA3A5VE5P8o0yukenCkkkozmr7PYN7RPYvgwiDI7Ksc2sGUKYuefMTk+LDL0nWrvsQg==
X-Received: by 2002:adf:f246:0:b0:354:f1de:33eb with SMTP id
 ffacd0b85a97d-35e84070ec8mr1342924f8f.26.1717574664206; 
 Wed, 05 Jun 2024 01:04:24 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cad5bsm13766039f8f.38.2024.06.05.01.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 01:04:23 -0700 (PDT)
Message-ID: <f533d72d-b0a4-4212-9381-bc12e886d921@linaro.org>
Date: Wed, 5 Jun 2024 10:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/37] target/sparc: Implement FPADDS, FPSUBS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode |  9 +++++
>   target/sparc/translate.c  | 82 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)


> +static void gen_op_fpadds16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    TCGv_i32 t[2];
> +
> +    for (int i = 0; i < 2; i++) {
> +        TCGv_i32 u = tcg_temp_new_i32();
> +        TCGv_i32 v = tcg_temp_new_i32();
> +
> +        tcg_gen_sextract_i32(u, src1, i * 16, 16);
> +        tcg_gen_sextract_i32(v, src2, i * 16, 16);
> +        tcg_gen_add_i32(u, u, v);
> +        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
> +        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
> +        t[i] = u;
> +    }
> +    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
> +}
> +
> +static void gen_op_fpsubs16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
> +{
> +    TCGv_i32 t[2];
> +
> +    for (int i = 0; i < 2; i++) {
> +        TCGv_i32 u = tcg_temp_new_i32();
> +        TCGv_i32 v = tcg_temp_new_i32();
> +
> +        tcg_gen_sextract_i32(u, src1, i * 16, 16);
> +        tcg_gen_sextract_i32(v, src2, i * 16, 16);
> +        tcg_gen_sub_i32(u, u, v);

I wondered about passing add/sub functions as argument, but well...

> +        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
> +        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
> +        t[i] = u;
> +    }
> +    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



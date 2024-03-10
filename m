Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB3BC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 07:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjDoe-0007k5-6P; Sun, 10 Mar 2024 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDoa-0007j6-R3
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:41:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDoZ-0008Pe-BW
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:41:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso25292425ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 23:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710056505; x=1710661305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yT8n7hViftibxzRJ/aOMANn3BMVrVHS7W7Ne2nLAaO0=;
 b=HkgLSmJFtuWH5TSBDNcmjnH9t206vIgAB+k6w7AxImx3Ha4rz85DhbSWWoN+IuBrbE
 Be9QBXkbCtlb6OZ60zvRN01hXYstsqEWRY0kp/akoLcSz2rHNfyHRHeXZ9qT1wkI00eY
 NiMmRbXk+/2qMcKuneHVgVDHJGuZFbDS+C/2mOC8m7L0bKP13iEIkq/QmcW+4hy5zQF6
 PC5KNOEXhAijymrV9Txf0HqG6Z1G1OZumM5xac1q2QeqvZGkT45GVcDp5ErFq5SN0TVG
 Kjbj2Kh513YpoQK/nJSrhhKSXxwr79Di4yppjirSzKBVHvYVnJxwsFX2vyrhcBRle1m7
 nKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710056505; x=1710661305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yT8n7hViftibxzRJ/aOMANn3BMVrVHS7W7Ne2nLAaO0=;
 b=wP7dEjSkCq4zrXpb7z8IXLNanaXmTDcOgcVgsdN8mIDaMQ1f6GgUOEJU8dGjJF94qd
 t68ItGUKfTK4Lm00/f9M+ksfyOZc6zTHM4VM6z+kw1MR4c2UQE2/6cW9MIcxMBHbTcpF
 99AlCcHqgN4bN39akgDERfnENn9rpy/6SEUgouPf+jGkcs85hAFqSIPExrxaqCrwWbSF
 ac6FUJYR/pYD45fPwK9SvMt6hXAzcqXmDEl94atO13R7rDIvid7yF7Wu36fthSk6UDLX
 vaLNN8pFbhwlw9LtNTvS7llMpLfwEsp4G0I0quG6Nymd4eNMX0igCN9o5SvIfUz8rVvO
 bPLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUky5eNJMb+FxnTDodydAF5r1I2QF6EOAyhvPmjMu9hiWJVw3hhEqrf1K+Sp3NjaR5RCbYEHjpd8OW1+XYEvudYy3WPPvE=
X-Gm-Message-State: AOJu0YzpbjETyWEtjZm5Wj1TeYqz2JkZeoe+Pb06VEvQ+d2sQr1PJfOm
 zDXmlBEdML3HaU6eP+pDYJ0XrC/Vaj4jB0GTH3l7mpgTkAZ7HVfHdScsqYCmpDMxa/Eg3QpIRCh
 G
X-Google-Smtp-Source: AGHT+IHVHNcZZQpQ8hRl0OBGeRarSd6qs5M1RI7Csj//88U81bb/VoZF3p/ExIDyl7YJ3nOOypgrBw==
X-Received: by 2002:a17:902:b596:b0:1dc:1379:2152 with SMTP id
 a22-20020a170902b59600b001dc13792152mr2280156pls.56.1710056505416; 
 Sat, 09 Mar 2024 23:41:45 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y15-20020a17090264cf00b001d9b537ad0bsm2316216pli.275.2024.03.09.23.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 23:41:45 -0800 (PST)
Message-ID: <888ec29d-4c93-4a3a-8882-3db690ae0f40@linaro.org>
Date: Sat, 9 Mar 2024 21:41:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] target/riscv/vector_helper.c: update tail with
 vext_set_tail_elems_1s()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-5-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309204347.174251-5-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/9/24 10:43, Daniel Henrique Barboza wrote:
> Change all code that updates tail elems to use vext_set_tail_elems_1s()
> instead of vext_set_elems_1s().
> 
> Setting 'env->vstart=0' needs to be the very last thing a helper does
> because env->vstart is being checked by vext_set_tail_elems_1s().

I did wonder if it would be worth doing the vstart = 0 in vext_set_tail_elems_1s, allowing 
that to be the very last thing in each helper, and could be tail called.

> 
> A side effect of this change is that a lot of 'vta' local variables got
> unused. The reason is that 'vta' was being fetched to be used with
> vext_set_elems_1s() but vext_set_tail_elems_1s() doesn't use it - 'vta' is
> retrieve inside the helper using 'desc'.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


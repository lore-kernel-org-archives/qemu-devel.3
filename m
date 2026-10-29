Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E23606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pZIvDWyn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMS6U-00032B-Lk; Thu, 29 Oct 2026 11:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS6L-00031e-7S
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:31:37 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMS6J-0004vP-6b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:31:36 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6aa9606ddadso1813175eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793287893; x=1793892693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=feWzZ3dysl4/i8dAhhjhkmkOOKaTR30wLgTTRkSePKg=;
 b=pZIvDWynzZ26j7U8ui3o6PPRGI5FwM9DXk7LmbJQIhAEZ+kAAxKnHJFOL2DpyxLUz/
 lxZmF+p8eJeDcmB1UMeMyFuR40Cl4mCKGjbT3pdKHj3/8KRmVW6iAZB/EK7Mb6F4EU0t
 wZ9sTKZvsye9S6Jn+JZI+3ZfMzf9BOyXS6mNUIRgp7tInQcfRCray75pDgFvUa4hcLyq
 e/eX8mxIGXaOWdxo4TR3MKYeBTSdLaCbZ/1IRZVHBMURbBJ2FILIAcOHURp8ZEACt6K6
 DOt5xdGSsnWrFixHtuMFCaI7Ya3+zxCNsjgmalvRVFpN+Y9idc50YqKfApaY87GTx+2l
 YfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287893; x=1793892693;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=feWzZ3dysl4/i8dAhhjhkmkOOKaTR30wLgTTRkSePKg=;
 b=ZL4y1aayL21DnwCk107XMFagQItpk8DecJI2Awd6uqTWl210+I49wQgvUO3+vnc6jp
 qs6JaLyRHxNGldQKyBECbXq59BJsOxqH/pPOTi+CQh1SFi419+qIDWEFGCCP9ZNF7Rth
 1Z9JodGM8Nf+NGe33Zidzy019tO/VcKfLLucZmtPti4Y4UzyGnbhpn3mue0oIfTBoZSI
 VLob+7fVrNusczWVCqehl60mpyW+6SH/QljZZCAVkOl+hbKolX/ADQFmpOUj5hZp+eoR
 8NsCb1eGaUfBGQb2mWIqq3FW9i2nb0MosvPnypysJsxqlFe/ozyRVXQvWgX9rWouHFEv
 2dCw==
X-Gm-Message-State: AFq9FYIy0LnqRRDlDH/3V+n1GwQfspnmKnQRvcwMnmLa0rpuGc77Vkk2
 fPtNPVIaW9sbWJJp4TJdZ5TbaRZ/yvQpfv5K23ILMTzzUenqTFrtMl6n7uvk74UEtx0Mgkac5yM
 hx5bj
X-Gm-Gg: AYBFou1JxwWev3P9zy2Tz5Ieub11fnKB2TXlCVHgasC8B3M2sONV8fhacM9J7IphMLK
 NJm4WyQD2o0D4yEYlaFEuFYOA4XQxMiORYOHf0/xlwQeDG51O7Dtb+QR3P6AgesV0X9Z45+dEod
 1ipYFaLLQeYgAFWspD5eJ0kzh1NUHD4oXYyYu53VPYl6e1DMzIHZ/AnfxUgxp37uiHatXmWHgzq
 5l8osoBzCpM576kTzSGg98BgGUbfii9ZQDsJj1l7f1CnKdkisbVdG+JjA+wA9IABV4ZfMQnew64
 4R4gj/gvioJ8wIhvMRa0NBDupUWGBw56LSUFXle6vqDcKCZbfhnbv9pHAQS7jOWC54CVuCUjq7B
 tZ7HXA5qkXEJtL8cETFpb1EyvaItMUMFCQ1Z4bbQ/hbNPpl6NYAigCWGvmhJPfwapx5jrxa+/n2
 BN+VSYfQGNsq9UhvR2GyOxJW9rCLdqDljyZ3ogBKH1R6WK4mxuDO4ePGmKshMsJV/OyHc7Ut4GY
 bHRfQsSVAh4CMmsSH1jfO92W/wNu4B5/pv9HRyByi//vRpwbBPKsdHC9psjEnlnhNZzAri20Vct
 1ElTIbk5ofMmkDgNDNEu49I6znbc/32qYKcMpbwAi5+V
X-Received: by 2002:a05:6820:1613:b0:70b:9808:a78f with SMTP id
 006d021491bc7-713eee477e5mr3457756eaf.51.1793287893187; 
 Thu, 29 Oct 2026 08:31:33 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d33e369e1sm106421a34.3.2026.10.29.08.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:31:32 -0700 (PDT)
Message-ID: <e07ae51c-0f89-4322-a8e1-487d685b69da@linaro.org>
Date: Thu, 29 Oct 2026 10:31:31 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/tcg: Allow tests to report results with TAP
To: qemu-devel@nongnu.org
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
 <20261029152009.19812-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029152009.19812-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 10/29/26 10:20, Philippe Mathieu-Daudé wrote:
> @@ -519,7 +519,9 @@ foreach target, plan: tcg_tests
>           skip_test = 'gdb not available for ' + gdb_arch
>         endif
>   
> +      test_protocol = 'protocol' in setup ? setup['protocol'] : 'exitcode'
>         if skip_test != ''
> +        test_protocol = 'exitcode'
>           # still declare test, but skip it and print reason
>           cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
>         endif

While this isn't wrong, is it less confusing to use else/elif than 
overwrite test_protocol?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


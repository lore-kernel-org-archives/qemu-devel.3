Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDF4D2F35C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkHV-0004cy-5W; Tue, 13 Jan 2026 14:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkHK-0004CP-CK
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:42:12 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkHI-0003y5-QA
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:42:10 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81f46b5e2ccso1559737b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768333327; x=1768938127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ly+4wIDnh1wyizKTgIQbwIDSlIs2Mul4wuPn+jtfmow=;
 b=SeYaLNRCn7Q4GvugCKkzyYpBOdRlqEXBtzyQE8Upfkt/yAqahWE17MvvHaoW9BoR1P
 +nd/wFMC9n9XHEqyXbkdt9tnofRH1RDdaf+SLDnSBAchn9dNHL/4zkd+/mUyAJB4gZ5x
 XT3jXeYLza7b29qGCQPSbb/vyW2qdgnoX0NpR5UZMehiTfRcEhzeYVDq2hJeAiPzYhcx
 G0EbEkMDA12Ybpk2Hp/5LZ4gSo/V9HSpT37hkUV6V2BPOblWaM2xWgJotaw8SVBauyIq
 w1V25qoEUpPzLLhxuwRwAh0GvCljcG90m5P+6bZ8jvoEboc5QbeQyo151rggdni/TtlE
 V4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333327; x=1768938127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ly+4wIDnh1wyizKTgIQbwIDSlIs2Mul4wuPn+jtfmow=;
 b=fZTCiDrSSLgcewfdy5GgNOkAKPEwne6LuMzioq67h65SFwURrlthwdMXAdEVovqdpm
 d8P01WqZL1onfPJSJtvVlr5Fuclvyi8HsoDINALkshUvZnEUtZhcSkJiBe/tuwDCvGje
 3GI4Adb2ASTjQ0GpWYL8k16rKKWpFqXB/bu75vPFo6KT/cmwldo3WAZ57zEZK4kqre3Q
 OKEc/gpUf5as4dyXWeaFf7ZD0BXY0eaLwjHLS/LkClc72yd60rRrczrTO55tE9wxTmpn
 cLDzSAxdMwJmsY7uplKVOSIIl/ko4fN1Np0W0TtVCq6YXK89iIuKdhDg+0H/Lk1u+k5/
 4QVg==
X-Gm-Message-State: AOJu0YxA8cpHtq8EDpahdMLUF6+sbmKrD7w07VaIOB6beVi6H2IlfLeM
 4rc1k8xHtIJGmQ7EU1qdDLvljks6OEoHDHRiqhaE1aENJ8FFYrsUONRbgw2mzwvha/NouRh8/z3
 uGyeHURA=
X-Gm-Gg: AY/fxX7qzFxRPRmgERFYxBSauJWqDcDTS9jHenZDVhBnGaW5GABUqUNo9XqjZNY7j1K
 f+1TEWvyl0qfRPwJJYQg53xgLyLcQZt0YWzHTmrMlt0BnWRttdQ2McoHzyt5Nl0pRJFiBhnBzo+
 AKsCiGd+1+6veebWFiM961Cb+DZ5GH3EEVDxGjms1Z1HfX62bkkwnjitoTDdRdN9fJ9hqBlURX6
 HUzzqacO2OusIhrK6igFolmbeeDNXKsnlVXfEjQUL0lrqDcUQH5R4JyaFvJ+2XOqVdbzgawDadO
 tXayuCb4ySpMNvx/UaQzMypFXGtG2yl2vZxhl5z/EFwdLdHY8ojGgomQaVRSlP9DwsErCT1J3c1
 KmrU5csOJjHCBaOTedkA61LymVCjd5Tg6SZzu30CYC4H+kij1nqqYIwQraxays2oZaIiFeBeMqK
 LpAjDy1U2EJnoXxpDFqREF4rCEVD1OQpj2GZpYpZ49LiR9gkXLAOKWLBUaJsFfThm3cbY=
X-Received: by 2002:a05:6a00:4149:b0:81f:4e8d:794b with SMTP id
 d2e1a72fcca58-81f81d404dcmr29259b3a.23.1768333327213; 
 Tue, 13 Jan 2026 11:42:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e8010sm21664245b3a.52.2026.01.13.11.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 11:42:06 -0800 (PST)
Message-ID: <39a32c0e-e498-4d27-8614-86869a4f8f01@linaro.org>
Date: Tue, 13 Jan 2026 11:42:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, alex.bennee@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/13/26 11:40 AM, Pierrick Bouvier wrote:
> This caused a failure with program using openat2, where O_LARGEFILE was
> replaced by O_NOFOLLOW.
> This issue is only visible when QEMU is compiled with musl libc, where
> O_LARGEFILE is different from 0 (vs glibc).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
> index efdf6e5f058..55ab788a7ce 100644
> --- a/linux-user/aarch64/target_fcntl.h
> +++ b/linux-user/aarch64/target_fcntl.h
> @@ -11,6 +11,7 @@
>   #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>   #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>   #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
> +#define TARGET_O_LARGEFILE     0400000
>   
>   #include "../generic/fcntl.h"
>   #endif

This is a good candidate for all stable branches as well.

Regards,
Pierrick


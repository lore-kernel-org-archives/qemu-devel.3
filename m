Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41BAC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxXi-0006ie-GT; Tue, 13 Feb 2024 13:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxXh-0006iD-3E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:30:05 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxXf-0001v7-Di
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:30:04 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e10746c6f4so145010b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849002; x=1708453802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7hNp6J5yi58PBR0PvGLHykylmlUjV9R+ng9U9iQiFpE=;
 b=F6z0gHpGYbU+nRCBWb/Sk0TIHb+V06WsdAr1AZZwJT6s+LUho4FWkQbCxSGkowwPn/
 KEjEl1SPIhruSIekKlMK5ihU4EMbndrkNlffkPYS9LNojUw2iERp4aSFlglqIcdjDh37
 xnIGp9ynZbYnUZJ0btgYw3ZjSzx1zi7c+ozj6IRvJ26E5lERjSA/TyN3qrJ/v5TSk7XC
 46uxKK0cndfxD2XeiCVIecyIuRe8PgcIoFR7GYeXc+R6F3sp3nGkGD59ZcLfNZSMDk/T
 SeFhZhP6XoTi8+bBUdKL8sNqfX2b88Fmf6qsoR5v6D10uQ3xKuO/STmTRg87oz+Xomhg
 Maaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849002; x=1708453802;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7hNp6J5yi58PBR0PvGLHykylmlUjV9R+ng9U9iQiFpE=;
 b=od0BrdPlyqKa1wsbqRQzjl+4OoUEh8aTiZBuigzWd/xUJR8meAVd3aNSpwVYzQY08q
 f0FY7LTZsa7cpT4OIy9DKf0V9c2bH74KkSVRrWuFiMDFPpL0OFevFTGJPoxKwHf2A6uS
 A1iQvaYjXcEe8xsETA9bVg3X62D+xoy6YecowN9cyUFh2goEQzN6kM+V7vX+58btwwrV
 Rnea3nOuXEPTP0iBEClN1YBRCm9JeG5BgY1iZgepa0sHrGujzXUTXcouCrUh3i0KoNbW
 nbAiWvKm80wOGu9fk75aJE7q5wMWba5nXZlQMn/A33bYkOG+iXFgyyXGUdYzeGIO2+VC
 KsuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7q9XZcIPXqHU7fBfJA+mv20VdCvl5NwGLCFqQ/NhTNT8JMLJ2r+od/17NomCM2hIksrH8NXqId7MSWWWZzCfXVbwk7k0=
X-Gm-Message-State: AOJu0YyYaYtAvMghJ4Rt9cW6J8CPpfziJT+1VqQa+UA/fNBe/BBBwFxu
 vv/GOkVoP8DDXGFCeSqm7aUTigbyVfndO8R/hzGDucVCNyReTJoHFON65v5ASgyE4HVI1cJZOIM
 D
X-Google-Smtp-Source: AGHT+IExdHNA/KzG7hfX2bxz2cZbMjr7n3xgDDXkBX4sgcPQ2abEn7q20dFNAMV58ugUAa0Rq0ICWA==
X-Received: by 2002:a05:6a20:9f05:b0:19e:9a59:20df with SMTP id
 mk5-20020a056a209f0500b0019e9a5920dfmr556919pzb.9.1707849001758; 
 Tue, 13 Feb 2024 10:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV8/SBQG53VdVBSBPKF0Yu+KGbKQGF54CN/HmWtUTiWX1wrSbnCiL5gHc494Vf6o08gE7wrFct8kntmKCp2q4jCm+inkRY=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 s25-20020a639259000000b005dc4a7994b9sm2650173pgn.60.2024.02.13.10.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:30:01 -0800 (PST)
Message-ID: <e7e8863c-8fd8-44b7-8596-323eb9319080@linaro.org>
Date: Tue, 13 Feb 2024 08:29:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/18] plugins: define qemu_plugin_u64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> +uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
> +{
> +    uint64_t total = 0;
> +    for (int i = 0; i < qemu_plugin_num_vcpus(); ++i) {
> +        total += qemu_plugin_u64_get(entry, i);
> +    }

Avoid complex loop bounds whenever possible.

   for (int i = 0, n = qemu_plugin_num_vcpus(); i < n; ++i)

or

   for (int i = qemu_plugin_num_vcpus() - 1; i >= 0; --i)

With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


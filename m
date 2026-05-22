Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85317CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRyF-0003I8-Tz; Fri, 22 May 2026 11:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRy8-0003Fd-05
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:39:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRy6-0000eu-8c
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:39:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8353fd1cb5fso3698559b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464361; x=1780069161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N5oVGdDKIgWbA5iV19VHEbX3gKufr/FhGA+ctVKziRk=;
 b=wmx/FK0MnlehAGPYlwIn5SEdGVjG7WYlpPEDY9L+IjtB8I5Sh2tjHHECsGDVNOb5cS
 JsYiN6Oi5yFt1Md/qBeNH6vYp7sXR2qpTxpqngEmd4DVRKkMXI1O2vJuM7SWHHkiujio
 jFAmmEXuuyU7q1rjEYaQxRpi/9u7m95CS26f3DSe7KO9echaGOlCgJtHKZUokFRw7OzK
 cW3J0TpmCb60Gw8SDAnc10AJrFXUgLJ4P+Xfiiwd2s+p4b50fs8NNpVzINNXSLI0JT4F
 OLX7UemPrX6gOeuND1Gnw+yfMAONxbWWg8rSgVwkj//sPa6RGt7eOU1FTeFYnWS5xFac
 FBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464361; x=1780069161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5oVGdDKIgWbA5iV19VHEbX3gKufr/FhGA+ctVKziRk=;
 b=kzEzUbm52Y+4WvlwXBnARFnvCsn8YXqi+k7msCIOoAtCh/jN7fRuvq0jQsZoU5T1ru
 FN2txm7C0PKh3KQuWF32eAtI0gMKqwTJWAe6hsVqvF6g9eWciCo0BjYtOAoTyzP+n47z
 h1bOdi5xH4Lp1KaLet15oSGxwUoNZclzg/9He7nEKOh5Z1T3018jdxoXPlEM0oCTpWpV
 QzesCZLThSadm5MkJdhwrHQFQlB3G9hd9h+6+shjzjRozypqL2+7fXh5opZZonzTRlxk
 9iUnHvP54k/PCetwuYURturdLX1wZF/n5sFSHutzhI4vgDCnJ+szwDNN4yr/dKhF0j6c
 2yMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MbGx79v2y7gFxEZBVs4Mj67zzSnUw6Z49NORF4Hpy4yUUyt+ehfW/FeNPn86AyNCr1Qm2/7j8E5Yd@nongnu.org
X-Gm-Message-State: AOJu0YxvhdAgb+6S1gmsG4GGTrzRU9tQspHkn+MFSKQeCyCKBG4txF/M
 /yBaljzZPhnDV7bk/jws05QLThPr2/tbc/FsUG++pZOSlet6vulpWE9q1dpr73lczjZZnnAbsNr
 NMn/E
X-Gm-Gg: Acq92OHDzA/HjRE1xm5U0hl1IXb9a4i+itLKdaC34vFBLvrcjw2NLU2KN1EZypxRLp0
 fip4gI4MSEtgIonz2wk4lbLLZEcUxfhvsM9iM0OOgP8uKebDeoZYdReMdEo2rM43Ek0pCRsTMRA
 /AfMqyoU/hF/GkY5H1nyHldcpP6HR79YSIuLo+3xznXiN8DtwJi394JUgJn86u+KeqdEaHobAji
 tTkOyo+YpETC0VbPLvkk8p4AO1V68iG45SnS5OqFdxRN+VRviL/syZfD9FKbO1cMydI2RM6n2gi
 xGKMG15eHmsdjG6nUN07CDzBR/vyBLxcyiNNdDXQV09SSo+PsV7ys+UCK1SiCM44I7zVesWpL9R
 6gF3JFM0+ES1rjO9qzC9FjP6Y0fOUxJWOtHJHhCynZB3l/Yeo8R+6U5xrdrApdD9CODClcV9XjX
 AhL2nxJ1NfYmRY9dDNqouuBI4o1Z8AahxpoSlqHs4Y
X-Received: by 2002:a05:6a00:bc8a:b0:82f:39df:dd54 with SMTP id
 d2e1a72fcca58-8414b40f5c6mr6764660b3a.8.1779464360675; 
 Fri, 22 May 2026 08:39:20 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fe0bb8sm2121580b3a.51.2026.05.22.08.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:39:20 -0700 (PDT)
Message-ID: <7013faf4-7dd1-4573-8790-026ce08de180@linaro.org>
Date: Fri, 22 May 2026 08:39:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/22] target/mips: decode Octeon block-cipher COP2
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-19-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-19-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/21/26 22:20, James Hilliard wrote:
> Add explicit decodetree entries and translator bindings for the Octeon
> AES, SMS4, 3DES, KASUMI, and Camellia COP2 operation selectors.  These
> selectors consume or update engine state, so keep them as per-operation
> helper calls while the simple block-cipher register moves remain direct
> TCG loads and stores from the earlier register-selector patch.
> 
> This completes the block-cipher selector coverage without reintroducing a
> generic runtime selector dispatch path.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> 
> ---
> Changes v9 -> v10:
>    - Split AES, SMS4, 3DES, KASUMI, and Camellia selector decode out of
>      the monolithic Octeon COP2 selector decode patch.
>    - Kept block-cipher operation selectors helper-backed while simple
>      register moves remain direct TCG transfers.
> ---
>   target/mips/tcg/octeon.decode      | 17 +++++++++++++++++
>   target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
>   2 files changed, 34 insertions(+)



Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


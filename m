Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E361EF99F3
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5Z8-0005W4-DT; Fri, 13 Feb 2026 21:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Z6-0005VW-J2
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:39:24 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Z4-0003Re-Tq
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:39:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aadc18f230so10500415ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771036760; x=1771641560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGrKHsjxOMm7239XBXF+U/qBdVaFf0fldyfwUB5FB9A=;
 b=wvdz85YnDCagYDtf5SrThfq5/PtwHt7NWtYbXCiQ9NTVOm2Wyec/PuMLldQaieTV/b
 Iu01+ZoIBiCM0kCNiFP5ZNbFUutoPEy2FhYKzwBo5vycYNVVxJI/zpfknoBKBJIocdaC
 T/Fqm00RlVmKJVhIvVXbulACyc0tPn69JVchV6/TQNPYVZQv1rSx//ocyjdRjKuh0Qzr
 2KTGgxRqX4ptOySSQh4ewhENjD88XVHw/9GWhNxoMwfcS7LZ20boKtBaLTNXUwX0SuBS
 ltzJuU0kFBHcUGCNRwhasf9n+yUVZyT3rvtHkgSRPYo1JvDtzgpgtHOhFnUQhi0ih6ge
 zV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771036760; x=1771641560;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGrKHsjxOMm7239XBXF+U/qBdVaFf0fldyfwUB5FB9A=;
 b=OJoc2cujB5QPHS05EAh3HGjpNHp5p/UFJliZ03hOjslSEFZhVEiGNQ43gAZN7QDdhY
 GEwPTiXCfc/vollBrz3XBCOjS5MCdkxZh3AW7iKgpqarg7cHs56XM0mCfIMpoLaHB9QE
 zlqI8Xk1KIzPQZ9+j3xMsrKPD1+UOUnwKK+WCKwMV7b40Ysgat7yRIVmhJtt+PGRTB9W
 Ui3E+MCzfYe9eRROKdKyZPTHjQ8hS/PLDzeuZeYlyMCv5+0kzS7/FgDQPCwjOJtAb5hp
 nJgwnJ8eLGnT3K92U1n1cNbReWSgnKieTi58CRQEg4PwTvB1UqF2qi+lOU/NHyL6sts2
 SnmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1xbo+jtJR2pTj2AcDVKNuJi7kt015Qu49JgFAVd8cqK8tDZJbH7ALAL3QvpvkJmJmbx4ltPF8yBFP@nongnu.org
X-Gm-Message-State: AOJu0Yx58ipCbatwwNAEgNSp1+i1lzriEX7hwQTggbl3STjebaZIuAFG
 ZhZjtW1TdeaBBT23Kool/Ng5KJzC0PczSWOcvuqV2S7HU0lUTncfIBh4DqUDCpYWhBA=
X-Gm-Gg: AZuq6aLOyETWRRhR7WR1Iob429fwHBvW+TPvZXNW27xEO1mJT9RvVmD6Fxouv6wEkgf
 nte7V/TBWGTCE2vDxgx2nRyrMyN1VeSpgHdLF8x82GfGHijcYjMYZWNp0KpgpzZeNjNrP5ugBiZ
 Goiankx2oFlIbhNYkgsF8p44wIqqfVY+q8hnTwJdWbUcuzmRCDc5QC3U7UrgmuiAiK8OmW/Ji5r
 AneSPdgDnKlrlDPpvKjv2T/RWX5HSndKfti6FXvu5jRfZqFWsgzJ0jMUDMr5BbBw+ZyQLxXsI/w
 BaUQwx2mg8todB69w98c6/NBgjObF5Vtq0hWHzXBAleurAOwoXiimOSFjn0IALxYTdqaPgsHNaK
 AESMJVAeI3QMkvW3OFhFZiEaS0NDBB7vx2rxqSKOie0+Oxghf5fAtH6laE1jo2r/g5h5orpSjZ8
 Lw4m9dGhTc2yMr9Qj2uwKKZPOhpAAsTH8BKpVIE4OAD/87O36MNkLbAdvNo3Hoy/bzsKiW
X-Received: by 2002:a17:903:2f03:b0:2aa:f43d:7c42 with SMTP id
 d9443c01a7336-2ad17493e13mr12688205ad.24.1771036760419; 
 Fri, 13 Feb 2026 18:39:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662e6d098sm13292437a91.8.2026.02.13.18.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:39:19 -0800 (PST)
Message-ID: <390f5a90-b3f6-4652-9096-2d2666f72df9@linaro.org>
Date: Fri, 13 Feb 2026 18:39:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] system/globals: Build as common code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214021240.58657-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/13/26 6:12 PM, Philippe Mathieu-Daudé wrote:
> Now than all targets have the graphic dimension variables
> initialized the same way, we can move them to the common
> file unit, having them built once. Remove the now empty
> globals-target.c file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/globals-target.c | 14 --------------
>   system/globals.c        |  3 +++
>   system/meson.build      |  4 ----
>   3 files changed, 3 insertions(+), 18 deletions(-)
>   delete mode 100644 system/globals-target.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


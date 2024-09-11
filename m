Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54998EE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE98-0004kW-6F; Tue, 10 Sep 2024 23:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE96-0004eJ-MP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE95-0001mw-3b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d87176316eso340531a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025753; x=1726630553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XK3sjSkFNsUQpzlg9gnA7jUuE8i1vCwqaYqntTIaaRo=;
 b=vjnCgGWzUiAxru/h/u3mMeQKRiuLNHOrKxcON6/MFj/KneeDkeghNUWvOnSCX1lfJb
 lDguhjZjj6byIly7+dNUUezd8IDvWEfh8aeF7wmwH+XL4CsywO1wjy1DMxIZC8rfrRiv
 +uJ/2G6sFNNvJMvkqzmHnYM4Tv+fl9SpsyjuQwC9Y3T95pTKPi3ywj32vlOoi23yk5C9
 kjzIdI5+/GB3SrBWAH2xb9zK1J9pKyRK4ORc5pRX+ISEWFXwPVFNs2eHy3lqzD2QnFiH
 bWGg/uWaV8gWKYGHiVnn6A7/+eKGaEEHyjxfcxtC8SDTi5n9NKGY2y1V9LbyffMpg/jt
 p7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025753; x=1726630553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XK3sjSkFNsUQpzlg9gnA7jUuE8i1vCwqaYqntTIaaRo=;
 b=uNGqyPtL5RPdvA3vtto45a8XPN52Etj9vkZpXmMmph3+uJKBkircUJhh08wPXz3G5a
 mffs+Iqkf3IoLEo2L/nHREsOoFtwquEPpKQFiP4VKvU7xG3eZv5hbbYpaMfQ2p+g+o+C
 8Exk+lPIj/zFE6N0JSzNhi8vyoZDDVatUshQte1MFqUkJ6p7L1aJ11g8ai4RpNt+aCcg
 Xa91G9GY6VfHY5D6DE+qXRAhWDFMzwdTvrtSCcAVNVm1qGo+Duvw/+Vpnm5uZcVbpOoY
 WDY2AiBR1slgasUppg/YjU9KaXMIde4W2hwrsqxucGfK2O52AVZh0lcLCg+KRYiKMSim
 zSbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqsbmIr2yHyqJzvEnlZCyi2wvFjRNWYn7sMScDnr6SeLtUSPOAc3+MrAlPyiQM06emGwBK4MrWbnYP@nongnu.org
X-Gm-Message-State: AOJu0YwdJwN6dEuRSiB+2v4NnAMxkCkCyvAfhlRIjTKm9rz8H5NBA0NQ
 qZUExpwlbUILadozLWEJPIk2mksQnnIDFg1p8Fvfth/UWMRyP4nw0prbdKp4Mhg=
X-Google-Smtp-Source: AGHT+IFSEgRGlEa/APA3PWHKd3jHoefBuLS8whCltxIuWfB1KEfwhNG1Li0ZqBPPt/2JpzCg6JvSdg==
X-Received: by 2002:a17:90a:708e:b0:2d8:89ff:db1a with SMTP id
 98e67ed59e1d1-2db67198e57mr7757834a91.8.1726025753556; 
 Tue, 10 Sep 2024 20:35:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04136b9fsm7274877a91.9.2024.09.10.20.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:35:53 -0700 (PDT)
Message-ID: <0fc1d027-a3d8-4988-8c2f-227c4bdf8279@linaro.org>
Date: Tue, 10 Sep 2024 20:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/39] scripts/checkpatch.pl: emit error when using
 assert(false)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-40-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-40-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   scripts/checkpatch.pl | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 65b6f46f905..fa9c12230eb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3102,6 +3102,9 @@ sub process {
>   		if ($line =~ /\b(g_)?assert\(0\)/) {
>   			ERROR("use g_assert_not_reached() instead of assert(0)\n" . $herecurr);
>   		}
> +		if ($line =~ /\b(g_)?assert\(false\)/) {
> +			ERROR("use g_assert_not_reached() instead of assert(false)\n" . $herecurr);
> +		}
>   		if ($line =~ /\bstrerrorname_np\(/) {
>   			ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);
>   		}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


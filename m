Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D4106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0w9E-0003eU-1A; Fri, 13 Mar 2026 02:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0w96-0003dQ-PV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:37:16 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0w95-0004a2-81
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:37:16 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-899ed41208fso15399816d6.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383833; x=1773988633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U+zGbVUbYb+KgnV8UDUP34UIuyZOMtozyi88KAmOy3s=;
 b=ZpFV6dU7dWspCl3cwq8YL9Q578LlRXmlzuTaTNa7an9eAxmGgAsU4j8ZHKMDceAMs/
 oHgOFddq2O1lkK5WxYESAAdU1MFTfXuG0HgbPfSc2aZUw8pR04oJ0yq2yY9Q/vxMDn8y
 knuS/jhqIuCuBLgzSrEr1pdcgdDjwbqB4QpktM9x9osi5dxMi+t32kJ/GVFkzDSy4H2L
 lhKxa6tywnERfvncCxb02Quwnj3yJHEa+WGojkxuYSZqxYewRMWNjRu246G18m3K2Qv/
 PzDP8SdWUzDd23qkMc1RqYWshdt5HMWRFzy4VnCMEnJviNaV0ONGx8p5Gw71BwTvk2Y3
 D1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383833; x=1773988633;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+zGbVUbYb+KgnV8UDUP34UIuyZOMtozyi88KAmOy3s=;
 b=U55hHaCojvf0/lR9xKlMq7VxOMTu2Mwl1ZFzoVxF5h1VXNc/GPJKWnpkOhuhH677cR
 RFTmgBX5Q9gAxIrEaylkKgm5aguBxLtcKRuuOmMLrTFDlHG1JXICHa2ePoI+BuoaEuej
 KoJSUOI2RRzmkqpk+HtplnoxwwPU9I/w5YXrmZTwVWUOCcaZWZFlZLWE7GIaFVByw92D
 uUD95M1JDBvZ1LpwNiTX3ghag2XE3+aOCsGcmGAAYcYVAip0cEaROtwZquI0k0dq7hvL
 KTZVVJKAfmLc5mKoUKO0JzHrbwtLV7NYOXgM2ukgYueM+Wfz/fExtSD3jlK8NasRqdsi
 mhGA==
X-Gm-Message-State: AOJu0YwhZ/eN4Dyab6+nwUBcY8yiptqTzDBuX9IhGOzM+iIWkpbV7HzL
 CFshYkTBLYDKOkQP+s4WDCjdZe0z6k+4WhlWJExUt2QVbssJvDMDzp1IJOcs6xdGdYq7GL725cx
 zW1QiB1s=
X-Gm-Gg: ATEYQzzWv/5v8NsYEyL2G+WFXCpCJUCrTRFm3JToTRopZosWOFgHMAgoKQ1gw68FBhB
 DSVUTp6gtYFwv4Kco2Teu+bbU3aEj8+Ih0pxMKxve4NsiKw5ElyuYJfyr/k222fmNM8rtsQbTt8
 meTd82wEYCLeIpAq1Z/5rOhQaxQj7aRPt2Vkm9PfSweV0hrMHrjUsecbnQEdBcbqllSkbi3h25o
 J6CMmVzSeWvl9M0AbPzQW9jo3IsedQdPx/z+IAv3QlSHzXZnOn0adkQ2B3bLqtCZltqjW6Lvp0Y
 AUV7yyfQB7uBDWHiuwhWQATJgNwFIaXYMRAxGa01jRd9qIUfHGgx4rwuZfjQ0OMAPvto8HclrgT
 kEIun5V0NDoCagbugOc23AVWLCHtsdEF4MZZDaYTmX+vUe6L5U7OJT/CYL4OCLj9JD0G9L1txZ0
 W4dRd3YYUdYcRUz4lqcsz1/cbW8JWaLthZo1ZQMFnxgUJW7/4u1r6ITbCY3FnvwsLhwite
X-Received: by 2002:ac8:5d51:0:b0:509:1ffc:c538 with SMTP id
 d75a77b69052e-50957c9fe1bmr25706771cf.19.1773383833441; 
 Thu, 12 Mar 2026 23:37:13 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939ec56d0sm54261711cf.11.2026.03.12.23.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 23:37:13 -0700 (PDT)
Message-ID: <e7f90dee-6450-4247-9352-1cd8f8cfaced@linaro.org>
Date: Thu, 12 Mar 2026 23:37:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace.c: fix depth for exit events
To: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Honggyu Kim <honggyu.kp@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf35.google.com
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

On 3/12/26 11:34 PM, Pierrick Bouvier wrote:
> Uftrace plugin was recording wrong depth for exit events, resulting in
> incoherent traces, especially for partial ones.
> 
> Thanks to Honggyu Kim, one of the original author of uftrace, who
> spotted the issue.
> https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index e3c65a1c930..f974090e23e 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -817,7 +817,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>       if (fp == caller.frame_pointer) {
>           /* return */
>           CallstackEntry e = callstack_pop(cs);
> -        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
> +        /* uftrace convention is to use same depth as entry */
> +        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs) + 1);
>           return;
>       }
>   

This is good candidate for stable releases also.

Thanks,
Pierrick



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC63107BCCC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15O9-00058u-1E; Fri, 13 Mar 2026 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Nx-0004z4-Mn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:29:13 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Nt-000082-Sg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:29:12 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35a07ed3ebdso1155366a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419347; x=1774024147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJGfAaKCa4+12kY7zRyPrThowxrGISoCHNgC7NCbPKw=;
 b=n6B6Tjp50aXZWRIw5gmK3bQJdqcmcgdW3TzO4DkmD2iMCHufIucileypjmUiQZmyjP
 i/oxcaNTyVBS7WUZOhXE3FvidLHdpq7Lc6yQcae8yb8iLDSQZlY2u2srb/IIAY+OvnT3
 GLXqsYTIl+GVa+/TNyPlaWeQgMZMquNufU9v4OenNXPbJP+tHNgcz04RTUigGab4UGF7
 LpJnapEu4y59xXsUyxUKKlRx8TMSPen71FmKSXe2WMFn7VgVu1I3tqm+W1CzhD3WqTin
 CL7xDqc4Em4fZSKsbi7OQSHALUp6QFgVeq9e+XihaaZOd7Qeb61/uWDWzBVIH2TCMybx
 OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419347; x=1774024147;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJGfAaKCa4+12kY7zRyPrThowxrGISoCHNgC7NCbPKw=;
 b=IoAZ38UQRzqm6L8EYTN+KEFozE4P1jsBWLtKvsJuj3al22D5gx5pP6Hwuy1mqgExPk
 rtWN5/JSZP5SgaZMOoHL/hUIWqIHl5FkXV1oIdfUqmT94qWimf/rvkmc1pzn7BWa+Y7W
 oYMyZyGI9HWkYdHdrXKPZddpulG0fhxgACdSbIl31sQI9YrALqkaDhNxycDeRWc6iu18
 rl780aejeR23+1ResOKfW03aEnUmbaBK8Nu9VzQbBWoS8eU+YulYSjHoXWgom2jtNyd5
 PJ2R/3U0Dw4nJecEIfQMxBWotyFYkULp15/B0r9GVcjQxKjKQJMN6N+p/RH2qvEeU4As
 Lgtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMLHGVxorCM3gkhIaRiRsUYwU/eqZhgzaKPffc1Hg0Xm7uKTTPefPk0BNuDj+ePnHUE97NgUl1zsoV@nongnu.org
X-Gm-Message-State: AOJu0YzUVdlG5v6IhkMOOOr6SMoD6yzePgLYluS3IOg1QXoTsqh0S5PC
 aGBAsU0i0pU5vwpdmmy+r7iVKMF14ur6an29f5FG5vWrrAv+7UPvD3rO7+s4BfLaQSA=
X-Gm-Gg: ATEYQzzUFW6sIi/mD/qA8VDQ/zzg1Goqztio/GHvFKBRyw/Eiwc04XGiukHX18/1Ipy
 jqxin5bcNbuQejoxKGBBhKCvVhM9n96pibQkEia3jyv1zu4EPcJnlrsGT3t7lsL9s1nSsm1Ngod
 HMK4ccTHLfDHd6TmRHDpnk5nYA6GenXNbxuoNh+DuR0q8kDV6Pn6gnd3Fcz4RXrwKLdWs//GLp/
 w23O1Ca5vOVHAPGS2Dy0sx1gI/njkecZLxZ195KJh4IkWH9Mez/JbzmSBRX03GSfGRtateDBiIK
 TnNRFVAWCF/Iyex+JirQc+16zudGdDGuahqYdk2hcYGqXSSxIbeqK7VKj3LzUkKqNOA/c53iEbe
 5heX4z+l+70byoRW8VASLL5UtVHM6Cvxe1QwWdbi/FQKiPJ+6apo2N5e7ay5J0lzw28sp20jSs9
 wofJBfqkDxxSulqCgPpJJYweRzPeaRXaureZjpJv31pSMigta0NIeYLvugYEGe02S0XlPg
X-Received: by 2002:a17:90a:d44e:b0:359:8812:7c01 with SMTP id
 98e67ed59e1d1-35a220d2afdmr3272798a91.28.1773419346719; 
 Fri, 13 Mar 2026 09:29:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece62c4f9sm27219935ad.38.2026.03.13.09.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:29:06 -0700 (PDT)
Message-ID: <eabb7163-8821-4336-8337-fbedfad934f4@linaro.org>
Date: Fri, 13 Mar 2026 09:29:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/38] target-info: Include 'exec/cpu-defs.h' explicitly
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "exec/target_long.h" header is indirectly included, pulled
> via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
> we'd get when removing the latter:
> 
>    ../target-info-stub.c:39:23: error: use of undeclared identifier 'TARGET_PAGE_BITS'
>       39 |     .page_bits_init = TARGET_PAGE_BITS,
>          |                       ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target-info-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


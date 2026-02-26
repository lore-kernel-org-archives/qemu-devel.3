Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B85FD9E1B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjmM-0006oT-RX; Thu, 26 Feb 2026 17:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjmJ-0006o4-3t
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:24:15 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjmH-0006EM-Kg
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:24:14 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8273eb7798eso536959b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144652; x=1772749452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tiCUiuTRNWhXdlzOvXrPZGAO/tBoo26Z9cd6ud0bBnQ=;
 b=TauN+btLvLnlZB3uXTK86m1EG58VhLmd0hi9L6UjjVCRbCibOcjwbhSM+AJjkHMu82
 GPuFYyTp90UQuSUtQFWovZiQ1mL0qw14BjPyfHMgOnNSyUmbwrP+h8Pc1BN7Dev/NBe5
 kaNWVrneyG4nZhSxEWNXDYFp0dPtVUwEL2lYvFaI2wiQgbq2Ff13rQLEMaw4MSC43m1+
 ub99JgjtwaO915JgTvaew+tXpGI7FKwx+bVDrJbsFE63mkUCEqE/UafXQhA4WwQ4jJgy
 AQZaLv+JxPk1BleKysxsrr+G5rvhcMeixGQEZ6iH5Vl6qDKMsAO2IV/Y+7+4DzFN2DkT
 vQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144652; x=1772749452;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiCUiuTRNWhXdlzOvXrPZGAO/tBoo26Z9cd6ud0bBnQ=;
 b=Lc7VScmrCSf7QWPjNJ3kEmymUKPG1QwSizrhGGjGTVZmoqI8LQXoeOE65TwBCFH3QX
 0JtYc8m+5OLyeEZ46bqnSl08DG+xKRxIjaMKv50E1xfm7f1RXWg73XxXxu+64mzf3AGx
 RxNs7cQSN/DOIxBk+FmVnfB5t+3OcxRhKHCACZ548BziH4NG37izUNR95ck0tQTVciEe
 Uf5SYTsGG+pPxkhuZNZXrBVBpi7UOAYFbFqClpwa0zj1aKCKaJls+oTjWc/zmRMQE3j/
 X8AUy2Z89ZXAbDL/nMkIbpYZ8r23qd4K7YvMdY1JJXw3gRoPHY1etnPP06LpKxp5J44X
 pp6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFUGt/Jfj6JbDUknGeTvFqxZFCq4dYPC3VVWeDvcxArpEEZqY2uRC2Fa0n20GiHXsts4HYoNVqYqBL@nongnu.org
X-Gm-Message-State: AOJu0YzSJKYsjJCIWSQwGqstGiYKJgp5DEAZu702yzuDmqbRIZdPfejq
 gaMSVlYEUd23jLtDBW6+v04Tv5Xve1GCI1dVxZvrAqZvCxP4kRvQvw9EbRiqAEYvSGY=
X-Gm-Gg: ATEYQzx2WsGeO3KRrgge1Jm2hVgk/E3Tm4QKgAJWEeGZr6/nB/Dr47bKB/r5Lp0JW3w
 3J4qo72EsGeqU7xrwqOb6dFquEPZs3+7noO3YjP6BSJ5mRxZM5W7eq51wfdecZ63hewBJSvmdYF
 U1K8P9DzED0IY++1SPgjhO5jV3SSNlpj5ZDcBCpU/ci8uNA2ZKl2vCWJPGxdlQXtf7lkzgpHf7d
 ojwuSLIylV4YICZmpGwKHQ+gUUnZHycTmMBatC+2RYifW117NSzzt+F0i/PbEFN0wE0o+PQNsO6
 7HZQ75MN3Pe2sxF8wcqzMDyJCXXeglg+9iEDpl1Mzct93HSLjCk9WKOSHBtNyM68QYB2vtPKJyf
 QS2KWDMWIobWQy0Y24mY7GawOdjnvsRIvZnNXX4eHt/BdIBw/vhBiH+van7V92IqINYLhYzNuY4
 VI0ntaZU0BDf3EqPtpe7cUwV6iq/mZ1UgGLqGFcuJKl8GcZBQA2qKipHuvCWNoccb2DlVC
X-Received: by 2002:a05:6a21:7481:b0:364:783:8c0f with SMTP id
 adf61e73a8af0-395c3ae7fc2mr672528637.33.1772144651980; 
 Thu, 26 Feb 2026 14:24:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70fa806295sm2916595a12.16.2026.02.26.14.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:24:11 -0800 (PST)
Message-ID: <2ebd23a1-56be-40cb-9fe1-43f839733feb@linaro.org>
Date: Thu, 26 Feb 2026 14:24:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] system/memory: Allow mtree_print_mr() to display
 distinct address width
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> mtree_print_mr() display addresses using 16 chars on 64-bit
> binaries, and 8 chars on 32-bit ones. Some MR / AS don't
> always benefit of 16 chars, for example the ISA I/O region
> fits in 16 bits, and displaying 12 extra '0' in 64-bit
> binaries isn't really a good user experience.
> 
> Add an extra @width argument to mtree_print_mr(). Next
> commit will make use of it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 48 +++++++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


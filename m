Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D8C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIvu-0001Yp-Hg; Wed, 12 Mar 2025 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsIvg-0001XC-Pb
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:03:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsIvd-0004uV-Pi
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:03:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so8578965e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741773787; x=1742378587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zb2IlpQC1aPCPt9c1rMelh0CumzxoDpBmP6xUGm83DM=;
 b=M8DRJj2qPC8rhxLTo6oNo3mHO3+cEXP/hoOkmsttHGDmzt2oOVrZQ6UCUMMgYpKa6D
 Ek94sYA61WbX9X5ooRQiIg3BlgC3CIMsd12Qn4Vh3WcDrpvKUlkaQB+WhyiyuiQU349W
 yuttXaGrkzF0sfBU6LaWFLdtnUOJWO/l79TEmDZhsgiZoNtUfwcCHijdrb5U6QOTxGHM
 5RJjWJxel+E7Tv9FDV50C014q0UUDeI39Yv/u/1t+T9GUxAv+gnc9k/Wbni5tJSaz/Gd
 Dlw/CNKGZQuWlqqMIJsAC9Qhid28eT+J+r3hRQOnnNiOiNHRzUywBKELrAuonZbnUg4A
 2bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741773787; x=1742378587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zb2IlpQC1aPCPt9c1rMelh0CumzxoDpBmP6xUGm83DM=;
 b=NimgY0M0YoHqHlduHodDAG9uFfKDjhf43ebvJ5I35Cxmbm7wsLsaCwzyI9hC6pK+KQ
 u40hIh9ko/qBS7En6doaghtlobv6OfQfQ3Cc8lpfcGlc2hohgQrJpkMA6YzUSS4aak5F
 mXxkBQmC7iPjyF455qewXE4KGVv8beFeHz5iYLQtIMUJLFrZokQknRZHylD33bYDXF3s
 sotcC0KOhRcgwJshHiaQXyvaN+k3voww8ceAhR8DKtK1D03XQWav4Mc0LPa6fSD+L76C
 Wdw+ypPtVYAYTWahcPLaB4cU8haMOWkZiZHD1Q6pdbfE1hdtSSZvDBDQMXQx05qAvvEv
 Zfwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgbZk4LEakXsBib+a9j4QbzVEpaVmrmhX/xcK3C0QWgGVrg0/kO3L/FUvDiVE93ItxnliIL85yjdwC@nongnu.org
X-Gm-Message-State: AOJu0YyyRMvCuKnfOyqsEQo8TNuKnDaHqMnMQNmkhscqGbmbzm2Pli9r
 epJviplXs/QibgWy8UzmIKp7kGIPFI/XzVV6SiEDfu/c2kjdV7iZVgRIaXAiGVg=
X-Gm-Gg: ASbGncuw4Fof/KhUVFM1H4pY8L0Pa34wnZ3rM6rxT1DoJM10ls7hY+gkHE4+X07y/AE
 vIaz02/YtlaVlwGJC1pXDlUG3idS71Ls2ZyH9QRNH9c/DX07rHYVQYAIaCZFEm8IQ+o2qpJIP7y
 wudZA7y3q5bYDzZH50s9YmEb61E8bCV2BIET9aKnInkFVniEVyh6MP03wBSvRHRIWPbVXoj5RNJ
 0EOxo30YlXhHDxlaNKOzTIZFOrjqLePiXJM4bsl2B3nfoi8vGRvxaSnlFDirKxbskdvafNhr0J0
 5F+4wiai9qxhMivzVTkDprGEMfr1eZpkNB/wufVHUomL+jaryAZMvKdhsd5r8ZZRpXol6P8LZzs
 tFdXN/Q==
X-Google-Smtp-Source: AGHT+IHPcu8AsRzRXcc20GvN+UZDrefN/pfBIUk3rHmTaW7lXBAJ9RsbImjySiWse0w9czeRHCCB4g==
X-Received: by 2002:a05:600c:4fce:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-43d07fd485emr32713735e9.9.1741773787247; 
 Wed, 12 Mar 2025 03:03:07 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a7310e1sm16204915e9.6.2025.03.12.03.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:03:06 -0700 (PDT)
Message-ID: <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
Date: Wed, 12 Mar 2025 11:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Giving your own patches your Reviewed-by
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Bibo Mao <maobibo@loongson.cn>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Yi Liu
 <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <878qpamvk6.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878qpamvk6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Markus,

(Cc'ing Yi, Clément and Zhenzhong for commit eda4c9b5b3c)

On 12/3/25 10:45, Markus Armbruster wrote:
> I stumbled over commits that carry the author's Reviewed-by.
> 
> There may be cases where the recorded author isn't the lone author, and
> the recorded author did some meaningful review of the patch's parts that
> are not theirs.  Mind that we do need all authors to provide their
> Signed-off-by.
> 
> When the only Signed-off-by is from the recorded author, and there's
> also their Reviewed-by, the Reviewed-by is almost certainly bogus.
> 
> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
> help reduce the accident rate :)
> 
> Here's my quick & sloppy search for potentially problematic uses of
> Reviewed-by:
> 
> $ git-log --since 'two years ago' | awk -F: '/^commit / { commit=$0 } /^Author: / { guy=$2 } /^    Reviewed-by: / { if ($2 == guy) { print commit; print guy } }'


Explaining some commits where I'm mentioned:

commit 1e0d4eb4ee7c909323bffc39bc348eb3174b426b
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Fri Apr 12 00:33:30 2024 -0700

     backends/tpm: Use qemu_hexdump_line() to avoid sprintf()

     sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
     Using qemu_hexdump_line() both fixes the deprecation warning and
     simplifies the code base.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
     [rth: Keep the linebreaks every 16 bytes]
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Message-ID: <20240412073346.458116-12-richard.henderson@linaro.org>
     [PMD: Rebased]


I posted a patch with my S-o-b; Richard took it, improved and reposted
it with his S-o-b; I reviewed Richard's changes (and eventually merged).

commit 0fe4cac5dda1028c22ec3a6997e1b9155a768004
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Jul 17 18:29:40 2023 +0200

     target/mips: Avoid shift by negative number in page_table_walk_refill()

     Coverity points out that in page_table_walk_refill() we can
     shift by a negative number, which is undefined behaviour
     (CID 1452918, 1452920, 1452922).  We already catch the
     negative directory_shift and leaf_shift as being a "bail
     out early" case, but not until we've already used them to
     calculated some offset values.

     The shifts can be negative only if ptew > 1, so make the
     bail-out-early check look directly at that, and only
     calculate the shift amounts and the offsets based on them
     after we have done that check. This allows
     us to simplify the expressions used to calculate the
     shift amounts, use an unsigned type, and avoids the
     undefined behaviour.

     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
     [PMD: Check for ptew > 1, use unsigned type]
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
     Message-Id: <20230717213504.24777-3-philmd@linaro.org>

Peter posted the first patch, I reworked it and reposted,
Peter reviewed my changes.

commit c4380f7bcdcb68fdfca876db366782a807fab8f7
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jan 18 21:06:30 2024 +0100

     target/arm: Create arm_cpu_mp_affinity

     Wrapper to return the mp affinity bits from the cpu.

     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Message-id: 20240118200643.29037-10-philmd@linaro.org
     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Is this workflow making sense and accepted? Otherwise what should
we change? Maybe clarify along with the tags; or including all
Message-Id could make this easier to track?

Regards,

Phil.


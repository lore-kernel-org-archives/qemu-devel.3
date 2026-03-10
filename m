Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9018FD88C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05j6-00014i-4d; Tue, 10 Mar 2026 18:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w05j5-00014Y-2k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:38:55 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w05j3-0008F6-7V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:38:54 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cd80bea5f3so202798385a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773182331; x=1773787131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VVuh0zteikdaa4vdy1JDWbjePEwYa5yC8aEI4/2lVnw=;
 b=z7rUJvPcqiClEtDZWpP+6WzWePRzvLvdZL2ct0aXpUwFofx/L0CpbRzq/YULDRTGpb
 +V8Y8+SS4yTJ7D55u+FbplW8ebFGRSm9ZfGocV3daafpvae3+iR12rjUNTQmCg9ckDXL
 hoj0MLRgczbT6TafZRVqHPkUKm3DHEwWgTUXXPOIpcTOG85TJv48yDPrLfWgBAV9Bhhy
 ObGK6LIxcJmAiyejlB3J8uVvbMJ59WtnMUZInrES3HLwF1fTSxPzbAikgHhdQZR2QzNl
 2eZSSOefTvcdSQNvo3k5xyYhgx7w/yyAdysuVls0bsp3gUgROTxZhRaznkWKDvMHYbW9
 dlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773182331; x=1773787131;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVuh0zteikdaa4vdy1JDWbjePEwYa5yC8aEI4/2lVnw=;
 b=GLa7IeDST0BA3cE8OgiuW8CEcaZts7LYwKe1f1S/1gFsyZqntiCCcFgU4UGC+5ilOV
 g78i1HkGGhBEaQWWPveSl/aTWI7jviSt4BMdankbrH5SC9yDh/hCdwR+QDoa41zc8bV5
 gMVrpn9nwWpyQygw+o/ZqYSgSI3DBwmgK948hTH+NC7FmjYQBaIFZGS0XbjN02sPZ6ZQ
 kzD3zCP+QtLqv8mJVieptHX77T65M7bdwgoR4zsrxRVNf0THTtsOslx5bu5/f0wKLXi7
 Bh1vupp3XGiVyrICCSwdje7pFO6wfycBd4bTWPWqz8Ncr/QoE4Ns1+nMOmw0dDnsomSG
 3SyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt3dUVpbc0IEOPvZCtjtUy0cLBfw2ZvaJwtc/ORpG3UBbj19idbvelnyMpfOUi0Qt6aTiZ0O6WZopU@nongnu.org
X-Gm-Message-State: AOJu0Ywo4NeHAJkb5ZW0fDi3UnfHmj/dhGSwO1lt9UkIF6Wr8EPwGzQi
 gsSwCZjKuXGR3xY/Eu1SXCNRptul+nbJej1vpJ3bSHYPT3s5GHmwC7clqDwvTKQAEgM=
X-Gm-Gg: ATEYQzxSiPHIE2uagwaoAl+K2NdD1pi4IEp4gH+C6KU4vz0h6MVRqD7jgMqo+IwPrnv
 z58QK9H89xji2rMh/5Rcp2RBzNDQZbd14KnktYSTr2qhj2hjkO+JF3TKetwnIKeE5n4E2tjDlnr
 TN5dnu0iF6oVNCneMAmY0OP63mceuI97SYiR3zOqwUwQZF1D8Y+ktb2VboyYbar54xKvbzCJRxs
 RDSl4GRwQrnGNL6FuAlTMkIoeWPexg5eMjL5KgRvzpSm0JzsjnDOTnN9uw6IsQIPdyOejMitRO1
 3Q09H041ur5o2yNa/CtcPlToUGXfifKAnNPoL/x2h3TBhtFTeOrCdHeq1LveiHzK++TRH6+7b1K
 gz867elChciJTkNBGP+oQ1CYrIiFt8JZ8jZVhLj1tCjURbcozO82d9zDiUXFMhLJQGvUcML7Cum
 4oatL8j6WKTraXritDIQuHPuZa/PihDYi59QiGRz7lo/r1PgSMu/vlXWLEgSYpILwN13bS
X-Received: by 2002:a05:620a:198c:b0:8cd:968c:bd21 with SMTP id
 af79cd13be357-8cda1a2d899mr77078585a.52.1773182330912; 
 Tue, 10 Mar 2026 15:38:50 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21348e2sm16467185a.35.2026.03.10.15.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 15:38:50 -0700 (PDT)
Message-ID: <c7581613-13f6-4ee8-9d5d-9b1b92b40bf4@linaro.org>
Date: Tue, 10 Mar 2026 15:38:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] gdbstub: Consider GDBFeature::base_reg in
 gdb_register_coprocessor()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310215916.55815-1-philmd@linaro.org>
 <20260310215916.55815-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310215916.55815-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
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

On 3/10/26 2:59 PM, Philippe Mathieu-Daudé wrote:
> When a feature XML file provides a "regnum=" tag to indicate
> the registers base index, respect it, as it might not be the
> same as our current number of registered entries, in particular
> when there are gaps.
> 
> This fixes a bug with the "power-fpu.xml" file [*] which was
> loaded at index 70 while the base register is 71. This latent
> bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
> CPUClass::gdb_num_core_regs value").
> 
> [*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c    | 6 ++++++
>   gdbstub/trace-events | 1 +
>   2 files changed, 7 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


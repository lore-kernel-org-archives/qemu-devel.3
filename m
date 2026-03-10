Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C440FD4F31
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0377-0001sK-9Z; Tue, 10 Mar 2026 15:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0373-0001mQ-As
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:51:29 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0371-0001F0-K9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 15:51:29 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50912a097b0so15503501cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773172286; x=1773777086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0YWfTTk1YvoVP92vpdvEp4UfhEvVHinI+8r1sG4Kwo=;
 b=BRTRO2GLOt520zXmEqUb1PSTGdNz24srk0uBGPiDag+ae76OmyVo3G9FDZNrrgPcfY
 d4PGmIAm4UOAI+ZDjNVK1rqyXzEhsHzi7dC5vVpTYLUiy9LHA0t5F5QNXVF4HqK/8Nb8
 p9zuk6tNiRhXTs4+lwAlX4cd0+TjzowteVCYuArTHX1G5IkRMZnYuEVJbwTxOBHyAFKv
 rzBVSfw2yYhe3Q2UtG/szUf1AuOZVwzYDR961e8QsQfGZ02mSSA6X3CrBeRCD6dny/aY
 r2F9sYONYBf5ZG/p3KB4pzxYThz1wJuCd150XN4MqBqjzPuL58UVdYoocE4jAIFJJkT2
 h+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773172286; x=1773777086;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0YWfTTk1YvoVP92vpdvEp4UfhEvVHinI+8r1sG4Kwo=;
 b=lgCHJPef7yp1xZ1S8vUOMyB91riapDRejGmwW7Ln5/NVUWQF8ljRuZ3YwcZ2J8ajHN
 4lH+CBW52/i3Z5EYfrPCvS6BBQggLCkIAl6SaUvaqrAtsQbKkwvYzCQ/i1oMfyX6NRGH
 aOVb8VOK9KEbXys4HVnjWvNNWXlnTjR2s5XaZXdxPlF3NbYiVM4Ga/9od74ELJQep02X
 fSqIyIKLUEA+Z2YRrynEqtzKw4gDNra6WSx5DiHk6GLRHZtVJcq/s0zqHhiS5PoAhsFg
 b5Uh5U5gcs9D0QghWKzbC0s8lJN/5T0y5Inm6U/tJY37fsrGUO61BjLQJ5PYHXLKXca+
 FhJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Uq06L5a9e3pOejlxSIL5JEU/DMdThR6BxqZmS5ejoaMWgsJbjzJa9W8oc8Z4f3No/L5OhaAfCMBj@nongnu.org
X-Gm-Message-State: AOJu0YxzG/iJL2z8PTedACtNnzU4YH7CB328l86H3VXP7LaNmMrP6V4f
 TQGrmk9zR3pIuH+HPuNqR9oXSBDk8Zvkl3P48NeUIsaWoj8111ip67FKN3W1nxPc7jU=
X-Gm-Gg: ATEYQzxICfVDll357zV9BU05cil6GFE8Piw3kPS99vtiWvz52S99NDeFueZgXTzJlEj
 N94DuV25kjR6NM1CF+szcMvrMXT/jwNll2biA9xlE6ElX3AdFfoAtxKBRzemXus3aO6hq4R24kO
 IPxLuCJgWAPFIsRmGyv+PsJVHQJPs9mZCrhkQZ5kdhmtJrCYA0bRiOlQFyZip8ZvwSJwJxeMrqr
 EzLmCPIG7n2QwDXiqjQByGIGtIw86c4RzqIDcceyjQRwtezW4jmtx03lxjSE/dAxcAGBXrlfrgu
 Njxlm/60YXOEN/1KcZOF5FvPJnLzGA1fQmYkpjr1nGa9zr97JbsvBrxKkhPV4n53AEos4yGKRKF
 RJd67bCILRQ8jPawUOcZrny7FmLPEbugKqk/0VuI2kDJ2H8SCb3VeJJzIvxe4Kv8VO8arnsWVdP
 epjqxUy6i2O5Bzw0uQB7KN5JP5s8727W9uyJlbA8bM4Z4A0TJJO/dqzL/6Zlbh7cT2R/Jb
X-Received: by 2002:ac8:5895:0:b0:509:1987:7628 with SMTP id
 d75a77b69052e-509198780f8mr110659481cf.53.1773172285942; 
 Tue, 10 Mar 2026 12:51:25 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65d03c74sm622816d6.43.2026.03.10.12.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 12:51:25 -0700 (PDT)
Message-ID: <b9e1d09a-5812-4a1c-87a9-4780379edf06@linaro.org>
Date: Tue, 10 Mar 2026 12:51:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] gdbstub: Add trace events for around XML parsing
 / generation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Chao Liu <chao.liu.zevorn@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org
References: <20260310155329.48772-1-philmd@linaro.org>
 <20260310155329.48772-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310155329.48772-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x82a.google.com
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

On 3/10/26 8:53 AM, Philippe Mathieu-Daudé wrote:
> Add trace events to help follow how the various files in
> gdb-xml/ are parsed or generated at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c    | 10 ++++++++++
>   gdbstub/trace-events |  5 +++++
>   2 files changed, 15 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


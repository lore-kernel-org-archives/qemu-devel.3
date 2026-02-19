Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECA0E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7u3-000120-J3; Thu, 19 Feb 2026 12:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7tk-0000jx-DM
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:33:11 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7te-0004Qh-23
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:33:03 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82318b640beso628735b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522380; x=1772127180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4h3HibQvAwN5u2mtvk+dGXoQar8H69XXEs4IatX8SX4=;
 b=yADnB5PrzGteHyGmbMOKD/X8F0yT+4Bb8tATCmvKJ24B9r8jY/kAk1QiRXpRk3ravC
 JMkN7zVzhqRXFINX/ke+kBfzpjLXQ512dR1luwpyA+pSb64QVnB+YcW5zNrq4ZftSiGN
 9uVlTaOnc/y7R1SgdFnYVgdjFB44Vx+fnAJS7ogBAZPL2OUukiBZ7nJn3TF4RgrzB4iC
 Hc3r1QJ5wh098eqsKeK3AT0ZNd1naopTWUQeKShzADfykEXd9oTR0YpfbGVFs2yW6aYz
 +2A9hyviPpFmrjb0md6yCWeNYKJbDSRt2n+Zdf2KQC82MdjgJEEF2CSenquMdR271eTC
 9aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522380; x=1772127180;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4h3HibQvAwN5u2mtvk+dGXoQar8H69XXEs4IatX8SX4=;
 b=uUCZk40AKavE09fjfjFNE1YLPMIu9pPJFNbVZkS3hvrzmuSvFopwJBABwEKyhZpLQ4
 SPAExBYGHHEgwZsclP9RPyKmypajKWB0EcH7qbm/wYRfL2TAimEZ/wbUu2WAw4YvV4/t
 5URK7vasW7XARN1YYJqOwTRnBZWx7sa8Ad0zs6x7TP/f+z2rHGIbZWdbAE6RC+XClBiE
 9wwODzho4jJOQYFVwswaz2ZtwNBvbWR8NYNUKKONQhwYOfn+7p7F3zozuU6TE0PyNczn
 O7AWrkDgKwlS6x3AgRsXXMEIZfiUNb/iEqLrHXfCl6ROjm/jNBOVk1jgPhFICeLsv7BI
 Vbzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwHEvb3a2QA2O5HHg5hRxCPKYanX8xdCdjQC4cp9lnOOc/07XYqOqEMTedLdXKF+0u0pmPW5HLlTD8@nongnu.org
X-Gm-Message-State: AOJu0YxHPFwpOOhnHCnVX17GAbyohOBdj4IJakI5ALJsUTYbH9sUcnQC
 vX9wlShWHwkqN0A9vlu4Tf7Hpf8k3DiUn/44bapwNppUeXmDZwUAYfbrEPr/KXXLUL8=
X-Gm-Gg: AZuq6aIsDn6HAyAlwFb3HOeBmrCFZbYVx5uCOeF7YIFqZFUIyjz54Z5Q3UioMrIw2Wz
 SJchhoouUwTkXDGMTIdIWv2U1/qgJKSFSifHvwm0pXKFr/WbjGvJ7nY/pjqrUz6+zYUdbfk9Rto
 MxUKScMZ8fquF5xveP3bRrg1j29jMKBVnOnxXMcqJBBCmuJywKSVSg9jvl6mqtZ/91l8OF6vSLQ
 CvVO39BA9lkfWXeGUe5zRiNpg8yJ25uj28SboXdrDOIe4Bq17NLssf0uLmsXUnW5vEOQBgI6a5k
 A4ZDchDzKVjyBkyhTam5wKGS2zQUthsBIdr39lQ1BghiCQbOtif7CIuQQz7fyZdMHv3LF8gWOOm
 XiOHkqMdY6MU9HJDyYsO2IwTAuNK3bGy9BZJaxkFmjuDl//vB83Xy9uKV0RIM2JWWfUYPWZRm0g
 TyggHHKzu/aR2xsr2Vi4/rdeQooGNpt5Dmz8POmr8vh/h4cf3kZ04TXjiZ4LYKxif6k3xA
X-Received: by 2002:a05:6a00:1393:b0:824:a1c9:8a30 with SMTP id
 d2e1a72fcca58-825274ca22amr6051547b3a.23.1771522380116; 
 Thu, 19 Feb 2026 09:33:00 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69ba2sm21057084b3a.38.2026.02.19.09.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:32:59 -0800 (PST)
Message-ID: <678d57c8-2ee4-42e9-882f-492c6d73c2a5@linaro.org>
Date: Thu, 19 Feb 2026 09:32:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/14] hw/alpha: add a reset function for the
 clipper machine
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-13-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/19/26 9:18 AM, Alex Bennée wrote:
> Once this is setup we can move CPU reset to a 3-phase reset handler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/alpha/dp264.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


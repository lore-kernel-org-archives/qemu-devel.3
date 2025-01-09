Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF47E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1OP-0007lh-Qz; Thu, 09 Jan 2025 17:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1OO-0007lQ-LA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:52:44 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1ON-0007ZM-4v
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:52:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43635796b48so9685295e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463160; x=1737067960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L4x0Ney0XL5kAAz7H+lNWguFlVxeUA+D4Aa1APK53TI=;
 b=mkbE9FgokuzDNNpe2yXbgNCo7yfg3OhmD1h52jGVEZbDPsTyO+T3+AL3jfwCPqpbYi
 ZTRhk5tzsuZ54keWSdL2r7yUUHkvhnzhXSc9VZktRL456GXoqmeh21t+VsluURk/NDgO
 vERMYzIWawS63eHp85SpJxQBfiTVHD++lfI+WJO+rnJQQN9ZnE8ndN0nyZqpxaEtQjGH
 NXnQdAK2giR5Dn+JsR2YH9SjfaBLtw4cqQT9031+iuKlLfPr3ZJBtF6E8tx5BYVxQCmg
 HjMxMUtyzbkhexHCytWy7TWcDl/l11f9B2Ed4P+uD6b9XMdFkfWXDWgM8X3rvZNkbzS+
 j8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463160; x=1737067960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4x0Ney0XL5kAAz7H+lNWguFlVxeUA+D4Aa1APK53TI=;
 b=nulvEZr9SbVsW28BTXSJHZRPRogG4fvmyO+L5gLBkMmBkMcGcwu/e82eMI+ZHynY7l
 HK2FNB5o0ubywvsRkmtFcRH2XvEW7gGj0ZmF7lggsb0OY9nO3lwncuAV1OymhQhB5tXB
 nW2eCBrvARsgvByBRPQ6cOah7AFLnOQzkslq+oes+/qRCuCU++lLnL/sL4drPMAdY6LE
 +QP/eLYwfnlgcStUaL0SNJSx0ThC9bPwQ92j2orUyD0rO7z6SgPDkn/6v7ZME+2U9jdf
 m2rHCE72VbL5WaLLhk7B+uwqpQKLhf3bDUG5YD2GBsWLhiUbB2m5NhjkZG1pPMQ9D9dg
 jS9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrFA6oNSkUSREbnSUE693+3CMo9Oxh+RGQCKvFnRVGTTtJFG5UrRDOok+dTFaUMuB/QT5rkyri7vLv@nongnu.org
X-Gm-Message-State: AOJu0Yxku1P/btnHZDOcWsHKek7SzUe55/CyXnDEGC+1C6AmLCuIngTp
 /99W12Zcbj/VZo+x3kSG3mpENeLL2vANz1x0FB+x2QJeZrBU8xs9lvse42WdaBhtR0kRm2/ogF5
 w4tM=
X-Gm-Gg: ASbGncsQMN5I193ChcDqzj9ONYyaNGuNrkSh7S4j/jC/xt15D3K22saNScfryqVSPFg
 HFu/70BgqMJqa5hNx7WWB8iqNrIzStRtDesJzi5zklDLFUynchVg+229NBQ3jMjofMDyA3t7Ksn
 dH1pv/PvkJRDm82izJYX+ojtbgOzSvM3G5ltwj2MVW3dRtmAXuJoZNRVhrVWkWIZxwmUH/qTgd2
 an9MRLf982rnCjuCy2dUy91LA8gQWNW66OafiPiBFaY9/xmUPcp+ZR9tsCOzgLQIuKtiJ0b//tF
 lCa8PoXhvYAsrvfKIaWS3Sn3Vx0=
X-Google-Smtp-Source: AGHT+IETwvkqYi1aywUY+JfsbNI4ea0zbrXWeL7SVVHQqytu/Wh7E0+YhhOgO7pFyPDtGr3Q0TcC7w==
X-Received: by 2002:a05:600c:2282:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-436e880fc75mr43338445e9.3.1736463160019; 
 Thu, 09 Jan 2025 14:52:40 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c596sm2912467f8f.51.2025.01.09.14.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:52:39 -0800 (PST)
Message-ID: <9ebaa5e0-da62-47ee-9a81-a6bbc47789b8@linaro.org>
Date: Thu, 9 Jan 2025 23:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/81] tcg/ppc: Fold the ext{8,16,32}[us] cases into
 {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-41-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Accept byte and word extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target-has.h | 16 ++++++++++++++--
>   tcg/ppc/tcg-target.c.inc | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



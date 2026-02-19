Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C872E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7sZ-0007vH-77; Thu, 19 Feb 2026 12:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7sS-0007m3-2P
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:31:49 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7sQ-000451-E6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:31:47 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso573422b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522305; x=1772127105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ze15iokcwaIKDohSzkco/vRCp1bHaZV8tiEcxWb7ZzE=;
 b=zHx6p5tRq3sJVsiZtPT4ZD7IorfmZYyjTF9zrdw6pkyledzAVmwwtZavNRzWiGF2Ks
 cE93uGcygbO4OdkbSirb3r1kjMgQcHX/OvIWoH5lp3eOap6jA5TVhK+fdXBQ4MI7GlDl
 vODhDWUVgND5LQ03kd1sLuKbBMKZs15KDSG+oPHzBIdwKvZFnSVaWTN7BTH5z6JZfGHp
 I6RmRUO7XU+0hx8F5bUaNAU59S7H6a3yFpcoSW/j3/9mrnslA7MzXyaoqr/9YhG5hAed
 XhTJXilgmYZRmzz10RLm7x0QjFltP9By3+Bti3Razerd1sWe19ZceXC0MDR0wP437aOo
 VnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522305; x=1772127105;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ze15iokcwaIKDohSzkco/vRCp1bHaZV8tiEcxWb7ZzE=;
 b=jvFvETnwWha0ThvMUedQZyngsmNQMkjTfNtoiboP7Zqs1K+gGjafWm5JKDxc0xerD6
 8pBVSE9gf/yMaZCsPX25oGw0d84rC0IUegwWtuT6lAQugwlINlZRdhBk+wSBJXp6ZKec
 ABt4FzmV8KEz3be1JfqEaiK+0+OtC3AJAVRC8PhXviwn/mIcDsfvwt+idXm+pIn5qqnQ
 DzM18xsCiie7f/kp1oLQDjbqNka8B0CiL8i6bpGBAAqrZ7Tp4DmRcJcEPRZ2NpQ22Q2Y
 UAWc/D/2uKFD+FiatoOXejb++qYomp8RYbJUHf1b8MHvTJbuejxFGGXj2agU9jWDKJdg
 JTgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI4FeAY4Qwj760H/sZ0M8+1pRAEPuoUxFfp5xKfrq5PdAdYucCMFhlQktHRPKbEPnc+4SVVs5A3CdR@nongnu.org
X-Gm-Message-State: AOJu0YzxJZSSC1TVpKW/xqwNSZa6hlZYBiUi9CSWO9t3khEFj5PRYrpd
 L3dtxrAf+HEy1dIT2GLow7Vw0DDNjw0cCetnBXThQHmSeEK+gv5CaUHytd4H0anfXsM=
X-Gm-Gg: AZuq6aLyTzX/7HWeaO83hBEeqsNobqNeIqCd3tYmPKPmhuY94197T6QUnPHNSMMy96S
 H4LhvIBfQM6e4bd2QVcll1mqUvkAXmSrb/mmeOO9faw5CzNPgv8eU9Y3rCKcFK47KNf1KCVNnQ2
 ZVjmr12ivsOAFnINmHTehO2jM7XS2p78Hg2jNJ6MmF0PyOP7n5wzgNa3ZTLLdLtQR6l++Z6G3eE
 v1zm6xgBvLR7lUJgbn0j+hLgMZHGiCmtO+0CUqqQ9dKD+VSghwHFdnSP0PPDBna1xjX8Tba2gd4
 GO4o6ezoUzjfJCrb+lPWrrhevOKqxs3enBPakO5eLccjjfOYFRbc67EWOArebkyS9j70DoXjwIG
 8+ZP8ofC9hBt1NG3Ws28WSOp9/KDR2Y/db0llhbBxLHWvi9ILijYUsXkkG+Vv2+fY0wpdiVmkU8
 gvqmxPbZw7KXPkOsSUasm2d71DVuDzfw4cczq2u6z2k2aUvDToldSXdAg/dHKacU77tVAw
X-Received: by 2002:a05:6a00:4650:b0:821:80bf:591f with SMTP id
 d2e1a72fcca58-82527722f02mr5333788b3a.67.1771522304893; 
 Thu, 19 Feb 2026 09:31:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb55adsm19817317b3a.62.2026.02.19.09.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:31:44 -0800 (PST)
Message-ID: <c8cca8ca-599d-42df-a7b5-10f7b4f63b83@linaro.org>
Date: Thu, 19 Feb 2026 09:31:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/14] hw/mips: drop cpu_reset in mips_cpu_realizefn
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
 <20260219171810.602667-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
> We will always do a cpu_reset during mips_cpu_reset_hold().
> 
> Message-ID: <20260108143423.1378674-10-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/mips/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


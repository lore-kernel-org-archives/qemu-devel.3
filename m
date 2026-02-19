Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20270C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBKf-0001r6-Ck; Thu, 19 Feb 2026 16:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBKM-0001iX-Ec
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:53 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBKI-0004Uc-H8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:12:49 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-826c49b7628so395831b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535565; x=1772140365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NCx/F4otiQ1f2ydz1d5LUPMb3yR7xomc5n3L0qYI8BA=;
 b=BKUJpb/qt4VTMP/W5JAF3HgSlasvZsZVEQtmn9RzQ72t2aZEMYaUYsWf/Rcf3oHKKY
 IpFebzBHP2dZOjHfgZjINdaDJwol0MS7KamXOHfNq31CyS42DBFGqg87Xuc5e5iOKMfl
 S8qxzz/DNEHQjfYxElFDgyKkGCXNZxYo6gQEg8fNUrqqiDy58wkO3exRiNktJcjEGbXw
 gKKzc0N+3MS9rVLb1UXA5itUKLPZhWha9HI0LagRlpv6Em/nKNAZVVgyJFIoeCYpbMWY
 IAedpXBf0UPgeyBk4khQEe0nCoCHsA97wIIaY2WzFq033CI7dQbYQq+1iVhdrcIOxbdl
 vh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535565; x=1772140365;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCx/F4otiQ1f2ydz1d5LUPMb3yR7xomc5n3L0qYI8BA=;
 b=S75mVkC3JJQYKrFrYA2Jg7NEjS/VD0ZBeVnVTn7WfVg52Y7nGBdIZzYABWiBO441UM
 sqvlkcf0MpySROjc4ak9DHRru9s2wSqVpdogDuOEs4eoRtutS0PyaCFUQ8kQ4WMGK5J3
 MO0wl+uFGw7LLrI7P6kmYCBZRgcLyhVf7akwIMxp32BrDa2n4aJZW7TkCfIJkyUAv7XK
 K1bK0HcjiiQ30cfrE3K48R46vV/yCbb+9tSKGR1wP82REDlB9joJr3wOR4ZrldCaVdlo
 KPxb+eXff1atquR8z789AX5uRQo8PvqUKNoYc8ZlUaW3+Qu7mFdZwC8bAYhMENmcAXCx
 ejyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQwMRjFIhoe2DMlYvDIrQf77pBNkFZqv2CeVY9uhVvAxCZi/beXm1+BCJqC2HN3fnyc8H5GYBdDX9L@nongnu.org
X-Gm-Message-State: AOJu0YwC5bdRLnLX/TjynezLxxnLN1Y/+frcXMFZjTqR4/jhhzKlyUmS
 aQCNdc5HorFKAO80VrjlLo629qHHf0evPonGuSKyzdaFFIDDGY6swcbwqGTd+H4/Vn0=
X-Gm-Gg: AZuq6aIZhhrcs8CxNE+acYvR479lXPsaR7pLnFtjZvOFk2QO9iCLKXXlV2+CBzGz6cL
 vP9o8nFVz15BDRjVokH2MalX+0fS2nAc0pE345mSVzapJ9fMEf1J3umdDPWOr2IaFd2NBWYELhj
 b+33yjqRhVSv9iqo2ccaQRtd2SYFICC1KyIGRc7dCUznzcerOPaDVrZf3Jd2oq24EOEYu2GB614
 Erdl5wddiAjvi3dPtyx6jFFS1mk7lfZHOIQSSxsKI5y75LKsFmwdp1HONf1KNVSJTyR4MzBzK0+
 W65WROaS47VJUTO6HtjE4sx2bHvFF6VcbcAzVVmToUVUL31lc7iNJ0CdENFQ4Sv907KJsrNDNU2
 ePdI3c4XInrwSOAY6EhTrYp1GyKGb51X2YarnVAbyST74gdyswR6VoqFLWlqAU9+m8AmRdlLt5F
 n1ufWFesgA+Qg+KMGFNahkYEgXC8J9LIe5wRmboWzPKP+jKFX9jGSlnmBL7itC4INQlhxI
X-Received: by 2002:a17:90a:e70b:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-35844f85dcemr16244654a91.24.1771535564631; 
 Thu, 19 Feb 2026 13:12:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3589d80d3adsm926572a91.2.2026.02.19.13.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:12:44 -0800 (PST)
Message-ID: <200fa5b3-1e87-4103-bede-861b83a4ba79@linaro.org>
Date: Thu, 19 Feb 2026 13:12:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/50] target/sparc: Expose gdbstub registers to
 sparc32plus target
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/sparc32plus-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


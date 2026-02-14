Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD4EF99EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5Tt-0002pI-QO; Fri, 13 Feb 2026 21:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Tr-0002od-IL
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:33:59 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Tn-0002td-IW
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:33:57 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c6e191c4b8fso510430a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771036434; x=1771641234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrqsZ96sXH/PBUUYiDJ6hV1Ic1tF9NO1G/MOy4VSVHE=;
 b=t9A4jrqRjw6nTLeBRCIFQuCQvamDt9JlPVZXTEQy0Yof/1uIoLa6usiNX9CiH/0tna
 jsio8xQJHpRw7AotbqyKTN0Gq+Ib+GZKbOXTzxUWZfFipX4YbCyY1VoehMHeXxB4h4vk
 81HGQbNI5+3cJ8JsnXH4qDQzna9NHpHdzPIHslpgcEL7yDgam7WRHTDAdfesC5H3HcWi
 pTcg0j8kYEtSzK9WsSWYBTxhf9QHAt8mXAYAXmbGB6J6AXmnZ87OxqOOokxIba50waoX
 SXrdxbpYrF6QifMfst8bQxVcGSgSapebomFz81xG5/y3iF7GmfWJSGFxdqOP2Ss1A7z7
 SyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771036434; x=1771641234;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LrqsZ96sXH/PBUUYiDJ6hV1Ic1tF9NO1G/MOy4VSVHE=;
 b=fGuccbJUP0q82bF8waPnRnxAeerkB2YlZqTIwnrIB6b2Y3+40GIj1wvj/Yql4WlcI+
 XV2hvqE0JdwM3Mlr+OB9k5h8JVbsE6rRK1ZkpMg0gbheRhNJch4f6fLbnwT3/Eeudez4
 k/B2ZUrXvXPuxBoXOvCm+0EhqL9rM6oJn1Y80qS5kpna4G7jR6BPO9zJqAO7XQMyCa6F
 dUBUI5giTvXwKisJJXzAqyNbGh/Ej/lvrI67yTQFroI3L4nl9VuT6KalwWf43lzY1JGw
 0KyQ2YJyKoLVoT3p1LMsLpNtQVTLTiHVxS0PHGBPfjG3S5b9FYdbJyzFXIFd3B4r02RF
 QoiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW0Ze2LPaXqPJpYs2JU0arM9T2r+cyJuKdAeU+kqquDDEtT9KGOEfVnAsCg1siWb6iqx5mBPYHCikm@nongnu.org
X-Gm-Message-State: AOJu0Yyb27PY8IBlElf3HrgIvw3SwCY6ciFGkxWf7sAH7RtdwdMbL86K
 Ti4Mfo4FxLpXrFrkbPFm3cPey1zItALVYJA4AmvXIdnjYP9raYKJON0nG0m4j09XQxo=
X-Gm-Gg: AZuq6aK/0YcfvjX2SspOC9mee/oGrTFgcj986k257/ny7UUTZxJj9yusXPK2bToUdqs
 blLkoIZmmwJ1d2urW89h+fI0ki6zAKYT0ZbvMUuqKE3rNG+/TqRtX+MEb+HhvuJNTjEGtn2LdpZ
 D/yrYxJKX2p/ZRqiUFMDzJvq0G0tiLwURNXcKlE0jDzn8mNtv6g1i7s44NgvEklYcjLH67hHi7T
 31DI3UQ5qKhZiGxN+bO0m0A2Q/K8Aa8+LdvrqxVXSqbhNVICUWaV/DXO7+kwlyOZIHhEXno4FZ1
 uc8J5YMttunQKR5PkqqyuxIieGzkuaELv6keMQpKHJIZvCLx/UGwberI4jNnfAYkJtJ/hpH+1Gl
 Bn19YZSSj4Ib7fsWXOLBT4ib2IaECiHG8XnJLmxf7KdnlsgkQw6kfs8cgaaO+7sLFqW2mMCvMN0
 nsTBDm/YpzoRKOeDNi2SZNTrcT7+NFEGautNkU3AYMJLj+pEzHYb53XOa1zpgCX5FV/Nq8
X-Received: by 2002:a17:902:d50e:b0:2aa:ea8e:f118 with SMTP id
 d9443c01a7336-2ad1740c234mr14613665ad.3.1771036433698; 
 Fri, 13 Feb 2026 18:33:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a713e8bsm5389515ad.28.2026.02.13.18.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:33:53 -0800 (PST)
Message-ID: <7f662318-ffdc-41e4-abdb-213093094570@linaro.org>
Date: Fri, 13 Feb 2026 18:33:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/m68k/q800: Use MacFbMode fields in
 q800_machine_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214021240.58657-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 2/13/26 6:12 PM, Philippe Mathieu-Daudé wrote:
> Once the Mac Frame Buffer device is realized on the NuBus,
> its MacFbMode might be different of the global graphic_depth
> and graphic_width globals. Prefer the device MacFbMode fields
> to initialize the BootInfo structure.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


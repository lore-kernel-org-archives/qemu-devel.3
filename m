Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457FFCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHyb-0001e3-Gg; Fri, 08 May 2026 05:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHya-0001dl-8j
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:58:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHyY-0001I7-PK
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:58:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so1354630f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778234309; x=1778839109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QfbK2VF0E2TRM4xm7ql7n4x7T93/X5Bwha9wgCMZVCc=;
 b=ZVrHXyaLq+GrTMCfgBhe6WWuRGN3Q2ieevzRlj1YgoEmEElatx1vAWoQhhQo/QvhP9
 +zWspcCUFi+CLT+RIed9z6CAUhBVsHrfUwsvxsT9NYlrWZGmjCqgpZXxSxRI/sbkE6pS
 3BD9+WzGFozhr1g4pJcWgMY0YTmy+c3kxYQRCccNJYbvde1HmqSAvdqBtYX3fqA4+Ikn
 6MYM6ZAMhWXaQqq5yACgPXO9hsRzyQ6uepbKTIGWJxbC/1voEyZUptpG+G1ecct7wJ07
 qbF8On0Abmm2KNyEW5IQ2zAD++hvB2rZxc3pdNh3d7w1F9WYcrrESJVDUdpALD/czx1k
 O6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234309; x=1778839109;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QfbK2VF0E2TRM4xm7ql7n4x7T93/X5Bwha9wgCMZVCc=;
 b=KAAJyzZlUbi5DT3FMZ0U4P+WLllL3YTfGMNIAaphzeTIlcg9jdfoWEyYu6prevr+3j
 2O18fPw5+lZyW76KgLERJEOj38GnNPkuRIfmL3cw5h5IDitUn+Bi+6NZQVkvwgmwQOSg
 /NNqiLKbjRsFvwDYl67o8DVdfZrOgi7Vo1/ioldP/BccLmhC6Rg7HfuH3vlXN64ofIiO
 OTco/eaIQcCz72DcHQScVe2yePEMMv4N1gQI/XNQHAhwMu7Ud7hDTi7jXNlcE+7IDVQW
 t45DqcFrcSrFN9hLCzHuWDUuAssozyGKdoa2Q4uEdWQ7GKs36fqdIJyFIa+28WsRSB51
 GsXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/d354IiG3W/MZIbVgIXa6RzS8mPjG7cGT9gWpNdKpdyA6Ra3VNtYSogEocXw8H2MzFxUPCl6OpcjrM@nongnu.org
X-Gm-Message-State: AOJu0Yyk78od9VyskL0pfDuBsKQHtTq1zmM9JRPSqFs9UDzZiBEm1WPF
 b5VVSXEwl43wb+0U6aVnukJWKBpjgGNor4Lk+0kGXvww6QUxyjlkmrXLWrITBegv4K4=
X-Gm-Gg: Acq92OHYP4b3ZYHghm+1AeyCKfnD9NzWOXORwtSgK7YjZ7iCX5XqUfCHdNPzwHPf314
 6Zcs2Yd+BQDUK1ttr9LPmY4WxK0O5WmhQwS2kLOCyzmT6Umj6h5bZQxrW/1bi6f0zmMxKz/CGeA
 /YFJTGO8snE0Dg4bKxzfz3tsubv3aqT3LcbsIrmFoixXzR3yTLCp1EhHGEQgLh20mCm5lZXpGkA
 8xFImWILJiYT/QSb+d7DVxoad1I2lrjbTbqzqhrYYP5n+tshOt78yxMVni2vWprQleAVwDQuHLX
 dT0wwQYJr1iyW3uTOgGF92gpDjiuxV83ip47KgqHqjnFc6pcbheYmRw6uTLGTx5vYKlVI94RJYj
 Y0DmKMTfgqIzVvZTc8cEjIoPxCy9IaSxnhpO6ZYcDyAZPo4L22W/4iHE/K5KwpSWIukSC/WyVGY
 IzmnGZF2D2Cm1wDXJAJVCMRrK5qROTIu/UzahDvsf5IXFb9mXYD5VfGec4u28fEmhIOdbseA==
X-Received: by 2002:adf:e649:0:b0:452:712a:91e with SMTP id
 ffacd0b85a97d-452712a096fmr10617803f8f.2.1778234308666; 
 Fri, 08 May 2026 02:58:28 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bb87bsm3181968f8f.2.2026.05.08.02.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:58:28 -0700 (PDT)
Message-ID: <5df68871-f226-4c37-8baf-d8eadfaf7239@linaro.org>
Date: Fri, 8 May 2026 11:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] fpu: Use accessors for ftz_before_rounding
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Drop FloatFTZDetection and use #defines, like we do for
> tininess_before_rounding.  Rename get_float_ftz_detection
> to get_ftz_before_rounding and move to softfloat.c, as
> there are no external users.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 10 ++--------
>   include/fpu/softfloat-types.h   |  8 +++-----
>   fpu/softfloat-parts.c.inc       |  5 ++---
>   fpu/softfloat-specialize.c.inc  |  5 +++++
>   4 files changed, 12 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


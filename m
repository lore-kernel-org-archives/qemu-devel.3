Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD11EC01B4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bng-0007dt-QX; Mon, 23 Mar 2026 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bnc-0007de-CT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:42:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bna-00015P-Ot
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:42:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso30315025e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774258933; x=1774863733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4I4I0s+rqXYeHNKmHxLy33Y6zWfwUGPzCUfNsaTljRo=;
 b=A2cf9LQN7RNn/Doqccs3V8mqKrTvxzXvhD/vgAo7695eI1S0TzQPY8Qq6+QcelVVcm
 HJAEk+DT6W5i9UH1yp9OULc9c6SHvbMIZ+tfC9qQqnTFgrLNjVZ1GXoQmEOJ02aNDjRI
 y+9XnvRZUwXPTmPPwqiQde1aQE13r8qWh/ITvtar54y3ONrALzA/ssWY03BK67SkxwwD
 xsM7Z9+DyyBjfIH7mA7hLK2z7Z+ZUnn4TIQtfjckICS1AwA59f5E5B1LHt2An2fGUNsK
 JLqIj70h/Uo6OXMB3S6HSxqw0TXyA38Op5tpiy3vPklE9be0Fy8cTFfE0zRyaZLxHXqY
 pZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774258933; x=1774863733;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4I4I0s+rqXYeHNKmHxLy33Y6zWfwUGPzCUfNsaTljRo=;
 b=MN9DFdLnRv5OpvhSyHgk1E+7pERZj4Epnmtz7Ya1p+o99voSu7sEy/6BBtcpZTaQBM
 uSyUnY92LanAjNYQ84HQ8G+wINdNeSObLTHLJ1E4SbjtUBY1f7n0/OtxsyxDvXVYxu9D
 BUA+FsB323jNGs9uxXb45jAtoSwC4dHtJPxefMB8pTbP/FSH4QrqfJTz1q5I/tUuFQKt
 h9B+tZ84I8eQJt2i3KMt63mv9paThwrBhLwGDa/Ggshw71GrgR0wfeSRHgQtWkG7YbgN
 PSx7+zxMe4+wejAD1U+Z3iEfLLsioNeTy8qvAIRevQHTB02KmwDl/IIsmqNP5tYAepQh
 bVOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWasAA5fNT8uZA+Nxkyx9svP9dvTmH9hbExouTk+gAbVajKdguPBEHYkIZA2gGMHL0X+Fj5zDQ/IUM/@nongnu.org
X-Gm-Message-State: AOJu0Yw80l2PY/nH1kV/Yomkmqh+WwYBtb/CHCGdQDBvBlLVICVV0n/1
 lVwcNCU6Pyp0uuEt3w2wxq1rVGeUZ0hx2MRQSyIs9rRNGnAC5szfClbDS/pP9n7G2d9IYY9kzVF
 JCovEyGPASg==
X-Gm-Gg: ATEYQzyCmOVPqkhja/Ed8wfRrRtOYMtN9JWPvkXSmIwKb6adrKWsRmXRB4msnmsl4lR
 HbdIlUwOI1QqEGOjjNvyJwiQU5bQtqrsIIVDvMmfCVru+fktIcTnFAU/OVbjFnPCjzD/bzsyTc8
 z6b0pH8qqHtLdZxojlhA8/LnUf2712HJQK9zFdQvhZxDDcT5oTrqrNcdJuPUpMVeqHdE7X/Qyyx
 OhithRLzlXPkqpoovY6S8LOJyUXTpYGmtEVcRRxoSo85WEPdTiRX1ZwO3NcCI7T4kNkZaF2vuBX
 3hzGIyn7NIrUykQE8TzHON0BUKskwvKQbAsVPQt8dZq3tO0cKR7ltdEzuvJkLiOWxTvrVv54hFV
 JqOsHG2aZCR3d6bhnCOFpQHTMVLkipIwu6G142zxVP4L9r7RxAY8VNeHyAve7qVVuMSZXSToCPx
 dqZM97FWTA2RhFZdXRJ4AZ3HTlVByoEwHLCdRlhhRf4kYYUw4V7OIV15AKEhoCj5EjAQ==
X-Received: by 2002:a05:600c:630d:b0:485:364e:934e with SMTP id
 5b1f17b1804b1-486ff02c698mr173982405e9.21.1774258932603; 
 Mon, 23 Mar 2026 02:42:12 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4a74sm332184745e9.12.2026.03.23.02.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:42:11 -0700 (PDT)
Message-ID: <08186662-ad0c-4845-8444-4c3474ab1a23@linaro.org>
Date: Mon, 23 Mar 2026 10:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Monitor address printing
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <e4f35870-7b04-c9f3-300f-909599a199fe@eik.bme.hu>
 <32d3d036-77dd-414e-9cf5-45044c98069f@linaro.org>
 <e9df395a-388e-4ba5-8b24-268b0e91c06f@linaro.org>
In-Reply-To: <e9df395a-388e-4ba5-8b24-268b0e91c06f@linaro.org>
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

On 23/3/26 10:35, Philippe Mathieu-Daudé wrote:
> On 23/3/26 10:00, Philippe Mathieu-Daudé wrote:
>> On 23/3/26 00:38, BALATON Zoltan wrote:
>>> Hello,
>>>
>>> Noticed that now addresses are printed with a lot of leading zeros in 
>>> monitor:
>>>
>>> $ qemu-system-ppc -monitor stdio -S
>>> QEMU 10.2.90 monitor - type 'help' for more information
>>> (qemu) x/x 0
>>> 0000000000000000000000000000000000000000000000000000000000000000: 
>>> 0x00000000
>>> (qemu) x/x 0xfff00000
>>> 00000000000000000000000000000000000000000000000000000000fff00000: 
>>> 0x60000000
>>
>> Likely commit 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr
>> argument in memory_dump()").
>>
> 
> Thanks for the report, I'll post a patch with a fix similar to:
> 
> -- >8 --
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index bad034937a9..59d49b00f7b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -537,9 +537,11 @@ static void memory_dump(Monitor *mon, int count, 
> int format, int wsize,
>       uint8_t buf[16];
>       uint64_t v;
>       CPUState *cs = mon_get_cpu(mon);
> -    const unsigned int addr_width = is_physical ? 8 : 
> (target_long_bits() * 2);
> +    const unsigned int addr_width = is_physical ? 8 : 
> (target_long_bits() / 4);
>       const bool big_endian = target_big_endian();
> ---

Dave had it right during review btw ;)
https://lore.kernel.org/qemu-devel/aUyC6HNv8KftowlQ@gallifrey/


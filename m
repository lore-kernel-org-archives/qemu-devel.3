Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF2D232EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Ua-00004w-Kv; Fri, 09 Jan 2026 03:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7U7-0008JS-MS
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:04:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7U4-0006Vi-F7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:04:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so28778555e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767945875; x=1768550675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtR9o52JoeHq671emtG6E3mnwhjbEV/0XPoRRZEMdqA=;
 b=Wdo/Zg2M2PRfb9jebFpg8r5189yFt6Rvz2XDiEIuzNS42zojk6E8I+ksC6v02zCmKP
 oGYe5zbih7BcgC1Yfol+1thFaeqXsbc2/MPwtg4qKt/xWu7mRL+0Zuq/t5xHbRnk8E96
 EEWu4S9BtU8BzeAbFes6BffIT05KvW2yKmQWRl2NoSvcWskoIUx0kwx9Rq4sHqVk18mO
 Z+0rZ7eod/kpseltstujUstZA3/64qdoFvsu3lIaabTziyMGoe6lQyz/NzNrTu1A28mU
 gZJqnrUY0Skao1GvmxXJXUVD7wkiFG2iSUxqZ66jkNBo5wN2xzczPKGtBW6N6ENbPP4g
 mkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767945875; x=1768550675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FtR9o52JoeHq671emtG6E3mnwhjbEV/0XPoRRZEMdqA=;
 b=MdokK1+1l09i7EgXBflFz2ei7CxfDThWNun8K8L3IOwWlczKRBLHsuGGte/i7E5MhU
 pPBptaaopUF3IsL/mX/7gFAEQjpAS44txV/JbFd1yvFU/A9/2xuimq1lilwPnaw2xqTM
 qcrEUqYmaSg0SKtH190K9bWUbubYhqrLpegprGLCoC5/kPXv83ZV3hr1NsyKLXGsZfNR
 8q1YuVa9liqdadBdt3BNFoc+V8Bn+srq45ByWWncO0K5WaW0EIvhnvZbaz9sSNTqEjfC
 lXjESSkqv0iQtPEStBKTmDGM9mrwStlyDgjWilQYaaSVm7aKOWckYthrXYIdCnuohfPy
 /vtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8cAEH3Bv9+yA4Jyy3ydZ7V8Twb9JiOf6NQMDgea2yWLENuzNWUzcqbySWMxTPLCVPo/OVs2I/L+/@nongnu.org
X-Gm-Message-State: AOJu0Yz9/vanldWilsIl19y3XoDx1+BW+bR4i9amTbIK8VvLRwLLmegN
 SHn2IxoHia4iXgslQpFG8KvPdXBVzWn9ell4WXTZyH63zmw/axo4aCF9sC6yhtWyCPs=
X-Gm-Gg: AY/fxX6bA0LZ4VCHu843QInXBoPXSvxvDaXFVOxeA72I1yJTGE4H8l5Ke5TrHv9O6Hz
 EWHKsyw9EGQ9R3VnhuRoiImkrXmQ5fm4TOBYSrjudKsJFLIrG8ti4JeZe0zZ7YpTuVl38baH289
 M38TaDl1kCyJF3nUlyb4WNDDw5d2sExxzeYVr9NBb+3bQXbAyjqL9LI3Q356EpgJNVheB81Ud+4
 LYJlYmydt93c8eb9EMr6jbiR7AY8+nXYAkuikhZzDETrp8hRliw9Ba8VCasOwlo24077Vrw4RLX
 LaFgSiZqaFWZOOf+3salY685yrc9ezA1aaKZGEceWeUbB1Ye6joPMoJ11uDA/tJlKOIrhWDnTtn
 mcBRcsi7o0jOrN4l657V//49biiVML1sJdE8rcdzEwB4d3Ry4/E2QuSjJz0bRbcgucZEAfBM0wA
 UeD1ICLa25Nuogu8vw0lOHK+82iFiNVKFcWDlSl1miG5LGFooV745ol2xuxSabc+fh
X-Google-Smtp-Source: AGHT+IEDJBlT/SImkMU0O+VlEN93etqd+EV2fLtKeOe6m9xswtoHSX+xdPavj8MrqGMU9KJa7FXe3w==
X-Received: by 2002:a05:600c:3114:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d84b32f3fmr102246335e9.21.1767945875063; 
 Fri, 09 Jan 2026 00:04:35 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm200050635e9.7.2026.01.09.00.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:04:34 -0800 (PST)
Message-ID: <8648daf2-f652-4275-be63-d3f5b22c088b@linaro.org>
Date: Fri, 9 Jan 2026 09:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/29] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-17-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> We need to stub a64_translate_init and gen_a64_update_pc.
> At this point, we don't need to do anything for aarch64_translator_ops
> since it's just an external symbol.
> 
> We can now include target/arm/tcg/translate.h from common code, since
> all target specific bits have been removed, or can be specialized with
> specific defines.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 10 ----------
>   target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>   target/arm/tcg/meson.build |  1 +
>   3 files changed, 18 insertions(+), 10 deletions(-)
>   create mode 100644 target/arm/tcg/stubs32.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



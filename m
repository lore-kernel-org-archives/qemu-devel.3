Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2CFCD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXcp-0005TE-Uv; Wed, 06 May 2026 04:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXco-0005T1-Dj
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:28:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKXcm-0003R2-Ri
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:28:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso5981195e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778056135; x=1778660935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dj/sJn/cCNciG3g6jaqaADtqvlnQaV0hsMfSHiNUHzY=;
 b=mZcV+xvr/7g35kFw+hA/eGuAgCrtMfyCtX5jtgKEYIT3qRpmzJj0rVlwBSb20+82oA
 LLoyQgU2hFsK6h6T7Yh3IfkJJmpaG6ljhIX4M+b50hVJFPJJN41zE6aPBsvCciRSNUFn
 kN0vpFcY4GcmKhuEmZ2o/61n2r2UXBakSDsi95rUhvT5uSgScex7rdwC6c+ERISjfZqH
 meBlibT6F+Trcb5xhVjDmh/Q5akSA+wDNUbRUbrmM5Wfkz4WEiYdMUFVXBwhS49wPuwu
 BT9oT+A0FAXSyY9vaQ8CPQkL3u1twUky6mYKDsUv/8fpnQzBT37u7eTlMLu2THSi+MWD
 lC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778056135; x=1778660935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dj/sJn/cCNciG3g6jaqaADtqvlnQaV0hsMfSHiNUHzY=;
 b=PIjKvjZNKlxaRPzHkDyXId9yQ6eqjWT+uDx4A98gzPuaY/0VTiRnRw+9B9ShUG9MF7
 AhMdYEcdBoCVOA5GgF20ySm8Jhqcfznv3O0IgjNKAjyAsD1Ek03Q/v9FhCd/DT6UrEck
 MfmR2NQA3hKjkMHkp8WlOTQUDpj1fithAyGJVeJs38zIVvp2GmYJJH97g8SNG4t+OSsr
 CKvXtbYfsFGEXGyEBtdbv8B1Dyut/Kj7b22CsdzSEuq6TISzmEERcWA0bFm4bcKHrWef
 KOARcytRpW6PC+ctQb4HGUnWG6IIX7EK2jmrlUTLS85X8UrPk2UGkSFxQM94HOoAwoKU
 1/6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aF+EO1ARtzOoxbxSzFB77webbZoRTEOXkMjDnv70/eFLvuxavRS5wIdhwEW4/8WVzoZVGpq2XcHTe@nongnu.org
X-Gm-Message-State: AOJu0Yyr80fN0y8H9VL8e+BurZ2GWzoJ65/Spmb1Ft3AiS7mzYKzpjR+
 Nn6udI/cil7hFH1bWief3Lx6I4RwdK/QovwmGlbs6LMFABsS63o+dMr235XS1kg6rQw=
X-Gm-Gg: AeBDieuNB7cm/ppsH9zY1z/FE9HjBniZI6yDAamHUVjVliYzkKFX/QX9dVy2ldG/tPd
 2slBLv52ZhCPwHMYBIMGRtD8wkbsGzinOS7plV+9+fVUoDAEB+SFsRMA5xobX7CamcAhW4hzkmO
 bWNjoQGxhC4cEiyemELZr+ki7oY3WeNjEAuYmFT0uezCQi2tH1tPMx9AVnGgQoq0qTToFrIbZSp
 SCrxYOIJgSUW/cmC0XvPFB4377IYMQ6FyHMFJ2mBDj/vKXlC8FDVr3sf2FLIluJ7cEuUlxhdj3w
 xVEU7ou9+bFm5vgRwNHY3xysD3dviXiKGTDVYOZ3GIfyH+2a3OH/CM+z93g0w7KeTSJb792WtEm
 GYK+TXFLc/rrZ6kKnyLBzqu4LmIPV4I7qkdStrg+WHmk9fE5NCHHBuLkzqeQX4rE6LoJNLCMZMn
 LcEMHwXx0gYqY0RyUwQys1pENM5QTh5LMK41H8ZgtjzfhnBg6DhwEKVdB3P8UyUwvlmTKkk0YQU
 o/B
X-Received: by 2002:a05:600c:a10d:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48e5226be99mr24157365e9.1.1778056134919; 
 Wed, 06 May 2026 01:28:54 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53826022sm32572575e9.0.2026.05.06.01.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:28:53 -0700 (PDT)
Message-ID: <fd8b3cbc-165b-444a-8acb-958b5e04f51e@linaro.org>
Date: Wed, 6 May 2026 10:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark struct ip6_header as QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
References: <20260505201324.932323-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505201324.932323-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/5/26 22:13, Peter Maydell wrote:
> The ip6_header is often used by network devices to examine structures in
> packet data, and it's not guaranteed to be aligned. This manifests as
> errors from the clang sanitizer like this one:
> 
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/net/rocker/rocker_of_dpa.c:321:37
> ../../hw/net/rocker/rocker_of_dpa.c:730:33: runtime error: member access within misaligned address 0x742970fe7ecd for type 'struct ip6_header', which requires 4 byte alignment
> 0x742970fe7ecd: note: pointer points here
>   00 00 02 81 00 60 00  00 00 00 38 3a ff fe 80  00 00 00 00 00 00 00 00  00 00 00 00 00 02 ff 02  00
>               ^
> 
> Fix this by marking the ip6_header struct as QEMU_PACKED, the way we
> have done to handle similar problems involving tcp_header, ip_header,
> etc.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Found this one while I was working on a rocker bug.
> 
>   include/net/eth.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


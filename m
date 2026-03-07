Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F1F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 20:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyygD-0003n2-Le; Sat, 07 Mar 2026 15:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyyg7-0003gD-Nb
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 15:55:15 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyyg5-0003Ts-Kz
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 15:55:15 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c7384f5a9cdso1521143a12.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772916911; x=1773521711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nRov57uF3DY3LCioLU5FoWuqQdQRfPLEcApoOBTgEY=;
 b=Iv8DnH8S1BoDOr5XyBD6bXZZMCIJatBKLtOeF8FIdPzKXMej9BZyMvnScXYjSoGC1m
 53/sqYDjWG2c//eQTmmqZ9RA1XdJ5fyA6gkl0u36glE8WeQnhrSu+uw0xmfGBkejo4hV
 QwLVk2ENwwoRvHj8kRksRD226cX5ceLKy59neOjFOhwFOf7AN4TS4XWuIbGiJItFta2Q
 OL7rK+jsv18vBuLBcdNg+DbipQInZe8nnBsWvc9bOPKKAUplWueIeUribUY2z3xkoZrg
 Q86rSpyzcdpoqaPNxMp0O2syywb8KOWv5DtgO6NZW6DtgJRAHItMditZ/bfZiesGBmlW
 37yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772916911; x=1773521711;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nRov57uF3DY3LCioLU5FoWuqQdQRfPLEcApoOBTgEY=;
 b=Mm9z61j97V4VtIEfPqAnJie1F77yZQEKC22nxqlBeDOc6zU37lhNOWkH9IVHwHyw5r
 P/7LgGH4y2X9zG1a24gWl9Gi3XsNBHl7QCTBGhHhAKzwXEc+sjhoVwFzc7apPQjcAaSt
 aRKT9Rc+WY7cSZXnoWAVUScavTC6RMiNVR4YT7xDsTQQmFSFYE9HXtl38JKBlJQhCIjJ
 uCRsnAyjef/V3BLnWG8nY04pb9SOqXeMrOFBKoMqAiJ5j1PupEfD5vlFWwpUvo5e18LI
 OQv2hniQLqZ6eT1fBSznK6SnC+kdZy6yBoFt690CUgdKv40yxuEUSHukax9+c/cFRKmq
 GOmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKOnxQQCa68hA3PgENhxBvsNu8UQvPX66yxpT+/hzsu1vDHrJZzIwGD8wwCQozwRPa9kpodVikJ/VI@nongnu.org
X-Gm-Message-State: AOJu0YzkibC4WWD8BmuPmS3wTd06qK4UqqhWzH6+/PPodWFtJpZB556T
 S4YqS5AgLmc0Twm/OgTqbL59b09Dj33zrF4I0MsbLxXegOLmCe5xmks1XYbqMv5yRfs=
X-Gm-Gg: ATEYQzy46zLCnrHIrp1vZ7b9hPuvwG3BuIbDW54iTiQkyWGmHmf2Mcnnl29nqfuyutZ
 cjDNDc8iEZfRqOGzrsAXGCOzSQ002oW87VStMaLmfiIlf8VdJcmigytdSgPdii3Y+GZCUVJ6Q24
 0sL5UMwR8Oi9cCJJL+RiEAfLQF4VgDlgW4H82rsq8DeAWZBOOr+Un10ViZonXfjio1VITB5vU/1
 y5KyjG4RzoAhJ506VzD47SqIpRtKIaH1qWYeoNMB/ZfndmGoori4+c8asoH/Mv5l3tvvfzBJjKL
 7FrdFUDRJgvg63HO7eoTrDZWtpEWthAcgtOz+Kv/AJq4zxFrkH6xGDTPYKQUS396DPQVrEr4xT5
 ftQFkZES321e9dKFk/N9bZWZwGnQ44Ct2sOVMDuum7XLM0yxwkol52dHzvn4rsFhKq+GFYcx8jO
 K1Np5efuxFDo77Jhv59uXzu0uu2/yQJ6zGesU8e12FLiafp5H2QUAmdFjMnTB53FyhilL4
X-Received: by 2002:a17:903:1a24:b0:2ae:4ef4:1415 with SMTP id
 d9443c01a7336-2ae8238544emr61827075ad.13.1772916911132; 
 Sat, 07 Mar 2026 12:55:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f8baa3sm64532765ad.65.2026.03.07.12.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 12:55:10 -0800 (PST)
Message-ID: <6af9bdab-aa6f-4d0e-a1c2-245c1b7fdd46@linaro.org>
Date: Sat, 7 Mar 2026 12:55:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Check if file is NULL
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 3/6/26 7:22 PM, Akihiko Odaki wrote:
> The file pointer can be NULL when e.g., opening the file failed.
> vcpu_interval_exec() already implements a NULL-pointer check, but
> plugin_exit() misses it. Handle the condition by adding the missing
> check to plugin_exit().
> 
> Fixes: 0d279bec0f14 ("contrib/plugins: Add a plugin to generate basic block vectors")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   contrib/plugins/bbv.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


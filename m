Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592CCCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSf3D-0001RO-RB; Thu, 28 May 2026 14:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSf3B-0001Qq-Vb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:01:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSf39-0008BF-Cj
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:01:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8413ac3d82fso6813272b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779991300; x=1780596100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fzgjeemnAiidT+SnZJ7VlcMlk26SKaLD1NoVx0lySho=;
 b=OuUnndv9f2Kpc3XPsBeGEdKvrU6xuPSnaoBqbXbVPyjTkdrUl2mAANsR6yRc7l4A5r
 RrRphx59XH6FPM15jx7fqt1MbIG9BOlbq9j8YFh9WG1cQJV7K+sQS28Qajy69TvcQEqA
 pB+/Ti9sP9CuF54hRua3d9psECm1SkbjyEGerxc6LCmMHWxEPHTxvXBqT65qOi68qha9
 OI4EJLVj4oHjpR1smSsR5TF/ahrAW/QMhiJDjtgSXeeKbfVM2WT6VypQ6xiErOPThk7Q
 VE+KdnHsa4QTTu5j0dCA/l57fes7Azg8WSgHTRKMyrKeetxAmZ1wAq+pBC28fvrgw8JS
 pgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779991300; x=1780596100;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzgjeemnAiidT+SnZJ7VlcMlk26SKaLD1NoVx0lySho=;
 b=sBPrntxEjFlnxI92m+Cl1HykdVvAs4Tggq6IP+0tjc0kkPWY/vFQSsykBBrK7yNeop
 p+U4EACvpxmjwGceS/D31hI+7suQMsY1D7xCXXRjdSms/AcoOxkfdvnptX9g95RSB65v
 uLnmhZChTBMC7UzU5iimKkQ/dlz0uzu6W31voLSBDEPTV5wHResmQR+CHZBbaLKngwnx
 Yn4z9mTVrzylGxr4GOS1hLZjZMod2RG2e8B/2fKRBLwSmOusQIuIuw71eEmFSNIrRvWj
 /rl3w/PLkHYWibuqRQHjfah+OFznNY7GUhioPCblaGN1aW1VM9WNmMHN18zEfK5UxHfz
 8YXQ==
X-Gm-Message-State: AOJu0Yy4ztGrTbHgjCeA9/O6GNIX0/6zQGlHQm02+aORuYDwWbw4ezQI
 rN8IQ+XxcPfgCIi3BZ1VfVlsI+EYwcYy3Is6v7tPcfZk/0gTvEgvkysnI6Q61H05VlI=
X-Gm-Gg: Acq92OHuxzQNvw4NI2GHH5Hnf6KcZES037y8BPNIpJohIE4xJXHbcfhih3HBnCJ06QU
 qmDC4EBBlnuJmWBB/m0UViW8GK+YX63Ck6S32yyjbNySP8NexwQA6xqqdelUb1EiDRm3J5/L3Sa
 UODgeODXJkc7DjJzGsuUuZs4pkmGcsmTFFW/frtIcPKGSIviv3cZl4Dk0sHy7QqbOGEydp+klLw
 0etnOLEBv9Ezkbi8PrSRjfxbs2Kt2TRMyd0XcoTltyM350y14Y4/oqmSv446nUk9wAgWuSESh3e
 NiuA55PThms9NMxfVMWx5P9P+//W3YBRWYFvutTR1MfiLv6SKdo6AIb/L/m/wDIRMn2eGUBIWWI
 g6sVNGH7nH6jT762EiF8WxS2GmT53JKUNctusPhIw7A/Fv7+b+3OTWyfckA4NuY/MrWCf886LS6
 ZKup1ZxsxiV03gb5ldLhpwkYqiWVamsO4bQikbaIgRxyah7Ps=
X-Received: by 2002:a05:6a20:430e:b0:3a3:a55f:407c with SMTP id
 adf61e73a8af0-3b328cad3aemr31639544637.16.1779991299407; 
 Thu, 28 May 2026 11:01:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d7307596sm6412163b3a.59.2026.05.28.11.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:01:38 -0700 (PDT)
Message-ID: <c9ad6399-6892-4d23-8848-5b97a8d04cf9@linaro.org>
Date: Thu, 28 May 2026 11:01:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/64] target/arm: Introduce arm_init_fp_status
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260522220306.235200-1-richard.henderson@linaro.org>
 <20260522220306.235200-25-richard.henderson@linaro.org>
 <CAFEAcA9xvc6BUY2LqAS1akZHpyouRchcmZAs6DVbQhkdoFsq8g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9xvc6BUY2LqAS1akZHpyouRchcmZAs6DVbQhkdoFsq8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/26/26 03:35, Peter Maydell wrote:
> I think the use of these boolean arguments leaves this looking
> less readable than what we had here before, unfortunately
> (now you have to go look at the function prototype to figure
> out what "false, false, true" means, whereas direct calls
> to "set_default_nan_mode()" or "set_flush_to_zero()" are
> immediately clear about what they're setting.)
> 
> I think it would be clearer to have an arm_init_fp_status()
> which doesn't take any arguments and which we use on every
> fp_status[] element, before then calling the functions that
> override the necessary settings from that default.

Ok, done.

r~


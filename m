Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2pP-00053t-Q4; Wed, 02 Jul 2025 15:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2pI-0004tb-Ey
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:09:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2p6-0005IT-3y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:08:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so185322f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751483321; x=1752088121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqzwsQuF+hA+/Ra6Uay0cU3gg8J90sgGEoBS99xCqhM=;
 b=X+Sez77Uz2EXGGuCLmtBx2azMWVsKNft3Dqo8t3pPto36E8glAMyyk/zhmRWs54i/S
 uRTPLLE9oWe2WqXNJ8z6t5xagp8X+//z6WR25WpRyPNMWdhSF3kf4NCLojshcFiCfAC5
 sSERm2bbRZGqkOQr0C1g0/accJywhe0JQthLUralBT12ZNBOEZPspn5dxD62B2o9X98V
 O/4rW5cO63mKaoS8wrpMPdEkf50MRXrMMrLzbnWw5vbzRcU6FwMBQjv+HHAwyiMRdChu
 m8K4WyMovZ+vB+OoUD8skuWpVH2xcu+mP3J/ejFyzr93lurm+bAqfe2lgVVBJjIvHfDU
 xFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751483321; x=1752088121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gqzwsQuF+hA+/Ra6Uay0cU3gg8J90sgGEoBS99xCqhM=;
 b=aMF+Ud1I6ZHDdXecFYpnsoAyJ5qrO7/TQN1LoCs8sVTc78wxhWMagEzV2htp7n355Y
 DVg9RUogoqbLkRrcc+fE12l+F5gAoTuQ/zXuyKs6W7KJW71wM9Lyfu6Fgf4jrlGp8p8H
 9+c2XVkTOK24XX13gGw2KWlR/jMWkuAlfEK9vGskOwgOpkkUD+/bLBaQa7Z52xyskIaW
 2PjtA/Y5DfZCrF3At5fRQ6yb+Q49ZpI1jkeFacgr06EIZFbb6MsW4sI/o6R2FP64GKRX
 Km4EybPjejGsBbkrYa4rAib/uZrYOzPzexh5LKTrO1BeXouetozWTMrvOsTtpMmMBGkw
 SK/w==
X-Gm-Message-State: AOJu0YwUDj2gSeJTFkY524zZpfm2nd072NnVWiTSbDE2cPePDS1v0YVP
 i3BqNWf7HkmE00f66xewBoaTsxPOWsMZQ3uPUbEoHcgWIBas5fowuqwovNTI1k6VP9AgdRgU3nY
 SM8e+
X-Gm-Gg: ASbGncuOcHrTXSNjG3xaD/hCMbpX9U5FjObNP5J4UpghqZBfUy7xzwx7ERTJ0dMNaBG
 IFcz0hICP2ZUnnkjJrUHxl/moswWY8P0rBXrSyyc4WFihXTebU3rlDtzPryR7nLNnSB9y2qVtUz
 nTMQkfZGPnTsHjEwevJ+EqIksBd3DSuZPh+52zeOHQLPKOePitQI2VeBnyKTTZ+7/AKqBwWaOUU
 Kj4ujIts7cv0qRj0lTUc+dFf/V0V2JFihnlo3UqIwEt9Dm6CXZaw+pdo4FkHeDhoSVpKdqF4Zkf
 c/BOT8q4bckq8tpu1eG/VRBnTBftBrFPAymA9ufI4UVpPeNvwYtMs6+/bxQ3SycGtw4a0wbrIqY
 zyBYTLoukSI59sJNDTLUmO+sBpscSDg==
X-Google-Smtp-Source: AGHT+IF5OrX8IuTMQgGtpyckKlaVOOBU70E35B0cpL4vVRYvFdZ3zY0+aOl8esvn3dKyDGTpSVwVmw==
X-Received: by 2002:a05:6000:25c8:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3b342fd41c1mr61195f8f.12.1751483321484; 
 Wed, 02 Jul 2025 12:08:41 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9966919sm6311305e9.7.2025.07.02.12.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 12:08:41 -0700 (PDT)
Message-ID: <e97a765f-0cb1-499b-92bf-f7af8acc0f0a@linaro.org>
Date: Wed, 2 Jul 2025 21:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/65] accel: Preparatory cleanups for split-accel
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/7/25 20:52, Philippe Mathieu-Daudé wrote:
> Missing review: 22-23, 57-59, 63

and 56!

> 
> Since v3:
> - Addressed Richard's review comments
> 
> Few changes needed before being able to add the
> split acceleration:
> 
> - few method docstring added
> - remove pointless stubs
> - propagate soon required AccelState argument
> - try to reduce current_accel() uses
> - move declarations AccelClass <-> AccelOpsClass
> - display model name in 'info cpus'
> - add 'info accel' command to QMP/HMP
> - make accel_create_vcpu_thread() more generic
> - introduce hwaccel_enabled()
> 
> I plan to send a PR once fully reviewed.
> 
> Regards,
> 
> Phil.


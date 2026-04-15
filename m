Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FBAF428DA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6pv-0001xx-Fe; Wed, 15 Apr 2026 16:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6pt-0001wX-CT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:27:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6pr-0006FY-H0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:27:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so4663336f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284862; x=1776889662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NU+AXEjsac782dkezHvHDjXEPt9JVPm6uRyENh42VoI=;
 b=QB6NbVyTQu9o/Pvs4lFJEKwrCu+ZjNhlmJtUJQ2XxDt57sTfKPN502E+3RF2ednCEf
 r67nkG36+XZ9fl+9nJdnz4gqe3vRLbVxtl2tMAJnliAOPjlyBaxx5TxuyPtb750UEwWT
 DvSgk4GWA8TIcODzloSCgkpERZ3x00liedolB9/E0aM9Gx43ufApJaVhci7q4RQQF0de
 ySq9x5P2QOZIu8/Ehyl6GLd5j2nrQKl+XoSd+G41rXm1V7Hp4Uj+hWFSu0NulUiKtD44
 +LZSTTrGy0QTSpewhbEsGL5b6YUHjO+YZOC+L8cpc5guJ+95OTcCxgnN1xl1Pm59u1wj
 pYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284862; x=1776889662;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NU+AXEjsac782dkezHvHDjXEPt9JVPm6uRyENh42VoI=;
 b=BPNVUI/+IXociKCbia1KqblJCxaEzfR/cai05Yy0PkC2ujsYj0XVo38oRm6IMsSIuM
 0SyABNtuPcM4f9L7/LG216uxRWR3BbgIfFIJFKUgrq3gUfH5teTmRkBQV23sCGvTVFE4
 Ulp6RBhb4buqSYrMzV7QVuj7z8AjNph2P0DJwJTFr+EQOpUxgRhQdZIQQR0pkZRZz1fJ
 Dmp8Kjk2EJHJFRPkFuldNyE761JAEEFsdnFjQBIZMaMKvtCY72eTLbflEqWIHmhZ+2Rv
 I1vWjXT9fvJGtZ3obCS6ixQ6gaeOp+R6rqYxuZ3pdUUyMWSvhq7CED7wGrYXZJ/e7DQn
 O6WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eeF2NyxrsFeiOrVu4lJu0wRj9xDKAH3PRdQpObQlxLhSawJO+d8uDLFQkMES2y10Jk4T9uFDjOPG8@nongnu.org
X-Gm-Message-State: AOJu0YzTsuud6gmF1HMWZB/CQ8z246WI+Ws3dQcPbIliy75WnSgR61ck
 XD05lPQ7dc22TER6lJ0F0kzyVn7ev16oJJsPmfxmCFR1NF6WZiYYfjy5ucshjIeRbp1lZywvHgy
 s9WOA3yA=
X-Gm-Gg: AeBDiesyha+pzKRj3lXO9kBRHv+zRmlzabBkZxbuUOBabpsTLOPRqP9z6HRGi4bpHGl
 fOjhm8nNcxnWXpwqA+aK7eCsrnym9kIVq/IwmpQ0lX6iqlPY5DYM1j+nrADknaDNxwxodQeWkSw
 KgF1UBseIQ0Gst+J1O4Yi/0WMuVLUc3S4tYOYjVeynMDaVLRXoRxRcXSxkqH2X0RvNVC0MNl8No
 W/wQoO1goOBuJErHu97IQ+RYvjHD9YiFhCFJpDU5Es30mAyp28Pj7+pPWC7DhR9n7h1S/bjEunc
 Uqo3vm6/XVD0VB7sYdgqUUoWAxDxvup+yytaDKNMGVoMoEGPwyuj/i5k0Q38k4rkx/PH/vc7Z6c
 5kmf1vnAQ2JfY7/s89VbtNGqeEbD1BqCxzdC525ZcDGtaNpRlEsuqRS2MuC1vUVTluiDi+2tT7S
 iMNlOCsjsDa334s4Po2xt+BUEbHWa4LDZ9Wbs3tY6Pfjho0txTlBtSSjmNMSn7XECrmw==
X-Received: by 2002:a5d:5f44:0:b0:439:ca9b:1f61 with SMTP id
 ffacd0b85a97d-43d6428a2a2mr33196619f8f.17.1776284861515; 
 Wed, 15 Apr 2026 13:27:41 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3566c4sm7311017f8f.12.2026.04.15.13.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 13:27:39 -0700 (PDT)
Message-ID: <64c0c47c-680f-44b9-b174-bcb2f62893db@linaro.org>
Date: Wed, 15 Apr 2026 22:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts: mkemmc.sh: Fix output pollution on missing
 images
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <b9d603b7396719f38e03cd969a4ac1b48f5ea96a.1776231967.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <b9d603b7396719f38e03cd969a4ac1b48f5ea96a.1776231967.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 15/4/26 07:46, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reorder the redirections so that the 2>/dev/null can actually take
> effect.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   scripts/mkemmc.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


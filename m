Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A5D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 18:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf0K4-0004Fz-Us; Sun, 11 Jan 2026 13:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vf0Js-00049f-RP
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 13:37:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vf0Jq-00062s-5r
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 13:37:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so39617355ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768156658; x=1768761458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MrcFz3CqcvUyhYF+owPDGEDGy70S6fo78YKmsjpdahs=;
 b=jbCFGzHKO2YoEqDrYTx6Oa1/u45mqlg5zAAfM3RNNCrT7gP250W/btRjR67vzgU3ja
 jlbqFmcCUu/3/bahWWjwur+fHTzWna/kD1Yu87j98FsW/W9MnvlC/RuqfvoT1RcA6sJI
 Ws5Rs0+lgkDJuH8F0ANhn6vCfEQLR+PU3d7AiP9BLSfO+seHcbB1ZJX+qZdO/+R1Mrcc
 vNrSuuE3l5+2esole0EPEW7WTkwIi2VlbVwj1ILPSq3uc6bxMx5+g682907fGnG67blK
 bMEymZH5zsBVV4tY2bmHR7xH2xLsKhP2Yxvi2Ie04muxOxepR32vNVTLayN2VBcRzrtl
 8a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768156658; x=1768761458;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MrcFz3CqcvUyhYF+owPDGEDGy70S6fo78YKmsjpdahs=;
 b=SSclK+YO5vW27piXKdoPvF1HwzDPyGoOwmkzyaUsgR8YkrWc8k3cxKSrDfJ9OOYZGm
 ADyUskQ3Mw/t+/QPq52ZfpkImZOMv62ho8bn7TAV5cJ7Vy74gOVfudh8xLM5OHRREONW
 8QAX/eN5NV2LCPvf1+KgptzdO79bRtHWgrgUiK8EHXdm7AWnBx2NNd8vMHAJU6EXCx9O
 ksAi8DgovKUN9xXYgHMKi2G0USnqamDSbSZh9nv97g6Ln1mv6rXJS193VyQxK/qzZ/z4
 PAuFZGUtn8IAfWTrtBf2Si1mtN9aTZpUIbxgLuhcGatqmkaKHQMgVN5HYLrUUV73ddfL
 U/5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGA4cyq7AqbyJToEaiwDI0pwyOVX3eSdAJEQflhhhbfAf1uBn3Kc+lh0LpopAvUT9co2ik+ZRwjMOx@nongnu.org
X-Gm-Message-State: AOJu0Ywh9T7V1fk/WWjecjYy3ouMJcGux8FNbrm8ZQagPomy9sLy8SXy
 b0lQLtpOofbOYzx1hnf4t4vwv07Af+iurtI0khdMVg5yNt6A2wIaVfP9/MoVx7njeHk=
X-Gm-Gg: AY/fxX79M51ZcE5ZODlx/4YSlCjWkZ4+WGKJCFBuHdy5AKkYEoZbisWfnPyJQBA2iWP
 +7en1jAKxhQbOi45kppC9kF5qH7yErFeaS207urlCbUKWx6Uhu7qVaX09meQGi6lU7rWnMRARP/
 dxvjfsyKTzIwjMIk9PKodO1MSxoUMK4OFf/fKQeiyiwywbfrnyawgu9p+PlB+mOz+dfDTQRC42V
 lFyqPuAw7XJCr4tpKHiJDikZIl9yLFpOzILNYY3yPzumBx7c5NHUaSuT9eBoTiDbFngObft4KPu
 Rvh/6xvyl7LvBehNe7TBv/29s/GP58Ou9ogxr5Y6TsMpJpHXealFnoWFUE9Dx7bQlFgg9euPghj
 h4Opil8rQ3MlrV5UnQTF+EpO5qc+IvtRTiBp4JVUNBbIduF0+drwHFOxdCirHJmiaPzZJbYsaEd
 TAvMPpaMSVBuZw33GjwuhYxY6rqsZ9bEb+UIn8VkXraIv2FYsROixp8iWK
X-Google-Smtp-Source: AGHT+IHkbJgU0TBJlinRq+unb4oivq/ad9uRJqBTh6OhWMRb4wUFhc1zueY50wfocXOpHVkQfxKNNg==
X-Received: by 2002:a17:903:1108:b0:2a0:9ca7:7405 with SMTP id
 d9443c01a7336-2a3ee491c15mr142706355ad.36.1768156658048; 
 Sun, 11 Jan 2026 10:37:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c5bsm155920905ad.58.2026.01.11.10.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 10:37:37 -0800 (PST)
Message-ID: <de2f6b6d-3160-4b5c-af21-2b5c673aee92@linaro.org>
Date: Sun, 11 Jan 2026 10:37:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix a_mask computation for orc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260111071137.433005-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20260111071137.433005-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/10/26 11:11 PM, Richard Henderson wrote:
> In computing a_mask, for or, we remove the bits from t1->o_mask
> which are known to be zero.  For orc, the bits known to be zero
> are the inverse of those known to be one.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: cc4033ee47c ("tcg/optimize: Build and use zero, one and affected bits in fold_orc")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


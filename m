Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145A1EE01FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCHj-0000lY-Ox; Tue, 10 Sep 2024 21:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCHh-0000kf-Se
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:36:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCHg-0004p0-AH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:36:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2da4ea973bdso1046145a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726018598; x=1726623398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f7JdlX8Ro1Ip0m44HnOgr48s1zLp9cIUjO0yV0L1pUM=;
 b=wcu0Mtk//imBZKdh2DSTgfioErpcEdCQJKjs0Fv1W50yBuHB/4dwJA6qYHASJJLTEZ
 CSxCUlmdEeqOdgA87W49JrsKkLx+3vInFkHTrr0kvOM5hWOzo9PciMpWhYkvaka99TOq
 huweC1R9Gefp3H+7F0kLT+X8POVv2S/4fL9eb4mddsgyMbiuePFw7rRf928TOM2szRUS
 xD2LA5D9svAI1ud4r5RA00WwM+69hpuVc8wNBSoRlJCFzrvyCOKYbrKeHwMYO5oowkjz
 YvzSj212cYJ4Xsch8Q+pLwNB0epGvJmf+srJdGb7t7mppt7NTsVdz/52Urzp+HntF85F
 RCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726018598; x=1726623398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7JdlX8Ro1Ip0m44HnOgr48s1zLp9cIUjO0yV0L1pUM=;
 b=PbZd6S1cur8gDYnnFbsC56uENaSNw9zZILrFqikqNlqUFKrvVZQH60X5LkG3la3nZj
 rVPJY/dAvT/sRaeH1bkivE3gLSdEYga7t0yPrxWxXxDaxo5mWNM7Dl9pJxHJsvbhl0s7
 eQmw6yTB25Gt2juTgJjtddUf0UQqtceocp/JHwiDnQhuufi1ngBHNaSADVLkwwc3mUEf
 i4inWti8Q7HnGJH/F4pEh6LCJoDQ+3gb750b8CVDUg8HCDYMoWOEGuW31I8eubAbXVzn
 +g/1SAJYQgy3/UeChTyXvr/bRBVJ89+hMnukHx/RkKYr/AMFXg2X7pCEXFvKbMwFtfs8
 WBsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9s6dryGAwGJVPVmGvhO+sBYRWHItNrK64va1xCBjv0xW0zFlhD3r26dPhh5QoNCahMV+bmO88S5P+@nongnu.org
X-Gm-Message-State: AOJu0Yxse3nLROu1vKzJzVeBFg6KQa0dsHNuoaHCXfjNBpFO+OueUmAB
 uSSXWF9/hkB9qAz5pVCrsZSwCksWTJ70Jdj1fmwQbs8XCDH1B8WJLDuQP1upABI=
X-Google-Smtp-Source: AGHT+IF8ZYaqoOPhWhxtmFWbhq2urq4H/a0eESCjcAsdIBcCbUweRzVUHNJDdcMUuP9alplsrz9SGw==
X-Received: by 2002:a17:90b:17c1:b0:2da:da86:8239 with SMTP id
 98e67ed59e1d1-2db8305af48mr1632714a91.28.1726018598262; 
 Tue, 10 Sep 2024 18:36:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc04041csm9209344a91.27.2024.09.10.18.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 18:36:37 -0700 (PDT)
Message-ID: <2a97859f-efa8-4ee0-a0c5-ee19aa3680f4@linaro.org>
Date: Tue, 10 Sep 2024 18:36:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   docs/spin/aio_notify_accept.promela | 6 +++---
>   docs/spin/aio_notify_bug.promela    | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


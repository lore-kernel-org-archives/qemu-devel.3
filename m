Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ACFC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 06:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTygV-0006Yg-F1; Sun, 28 Jan 2024 01:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTygQ-0006Y7-4m
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 01:30:25 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTygO-00055l-BD
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 01:30:21 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bd562d17dcso1473046b6e.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706423419; x=1707028219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrCclvvyblaeYwJnl7EDYdfN8Fn413BfYU4kW0ONyUA=;
 b=X1X95zq5ByIQC/Xzfh39TUAxF89jArL8aYsD0umn7tCGIpSBT4FWhTp8gxS+KI7tUM
 WITeB7yKwv9ttLpxI4ROmBEvb301+Im6vPEcGbfiPKq3wnS1gcEpatBRfke/LEEQhgkF
 J5wxFuu657zm4Xy3b1wMlgEfrnrTYcM3y8XnpKtNJRhSHz2A9gYSPgB9Hb4YUO0WIAYQ
 rl8dkC9XYendIli+0Uvnze8fW+cepEEewL9fzPHZpl75PW58ImkeX0/mliRqX7SWsDR1
 LJzylPTAZbJ7FNE4Xs25SQ4sBqbAjyp1LYmOI1y26WDOowA/kme9pg0PiJWbKM0C4YL6
 UIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706423419; x=1707028219;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MrCclvvyblaeYwJnl7EDYdfN8Fn413BfYU4kW0ONyUA=;
 b=fAkmQWaUzVlZfxAtzBsaZ0ssOldlI3fuGSsKrr9IA335vxSxBLZJiy/K0GTECS2FLp
 FCSQfHW+/XEewiwGMEldJF7wI1C2Pglc5QN6eNUPhzA3FzgXnRDU1IRz+C36j3alAgbe
 932FDeMlOVe3UyXr+Wp/SPb49Dj2yDpvSG1mRPD0Y+FbFZ07XHLJxT49WFpeoSG3mvV2
 9AqRpK9586cRD875tp0MILHV/+UwpL2H8Wonjovg+HFlBCQjsEigIQU2EAltfT61byZA
 ieY7jMgBaS343vGUhuLg+gvL89hrZr+th1wwjEd350fW3oGJYFJPJ6WAjn1Z5bh21Fla
 3cXA==
X-Gm-Message-State: AOJu0Ywg8a1VDNu8h6fGXmrEiJalD4JkqmrYcVWXEKMFxR2IKxB9iS8t
 xZ4hZ+aFPt2lGbyj9jxipJuqdbTier5U/Joej749Jhum9clq/cLlIxYVM/6FgM5l44UW2iO11WT
 mF7M=
X-Google-Smtp-Source: AGHT+IGsDxtxFYDATtohUvJc1XDQID5s5WThcpy+fe4j3hBM0vnGWpCkQaFb/NVAlvcQIoanF4dmVA==
X-Received: by 2002:a05:6808:1409:b0:3bd:ce3d:cd23 with SMTP id
 w9-20020a056808140900b003bdce3dcd23mr4070063oiv.5.1706423418840; 
 Sat, 27 Jan 2024 22:30:18 -0800 (PST)
Received: from [192.168.198.227]
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 z24-20020a631918000000b005d68962e1a7sm3768036pgl.24.2024.01.27.22.30.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 22:30:18 -0800 (PST)
Message-ID: <b36e9682-aaef-48d7-8c17-97b60c7e3c46@linaro.org>
Date: Sun, 28 Jan 2024 16:30:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] tcg patch queue, pre-pull
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240128044213.316480-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/24 14:41, Richard Henderson wrote:
>    target: Uninline cpu_mmu_index()
>    target: Uninline cpu_get_tb_cpu_state()

Dropping these two for now.  The cpu_get_tb_cpu_state patch fails s390x --disable-tcg. 
Both changes will be re-worked to introduce TCGCPUOps hooks immediately.


r~


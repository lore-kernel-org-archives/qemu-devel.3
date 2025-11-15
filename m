Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01067CEB2C5
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 12:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKFHt-0007kh-GS; Sat, 15 Nov 2025 07:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFHr-0007ji-N1
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:21:51 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKFHq-0001xa-3z
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 07:21:51 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4711810948aso19629405e9.2
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763209308; x=1763814108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwl9MUQNIEhNXyj5+uubExWIsscNCW2R8U4mZiQJF0E=;
 b=Ryz0p5OddOsvRl4/I0b0nO9o2qos6XKSglrjJD4sp2BA3ksLJbVaTXWz3ppr9rKxZs
 5wplNzm7ZsI13NA6a/II0RP3Zz5bCAnOM/4lgdERbqE+8UCAKN68Tk6UanAauC846eSO
 F/o+SQoLgvDXeZJX5z7/1Hsh1wAAjirr08pG5Nr1acsmMSdGQZ6S6Ik9ReB23xr5wxrt
 Nt2Gx0dAYgROLJzCJGtWWlFdrCNw4xiHnHM9p67I7Fvbp/q0V/OFs+u+FjM3rBQPUPbe
 GEsIjk6UuW1nILycj8heBxluk5gvS3RZbTmmjFcHFIZIyUVgsmQ9UF0Mce50mfVTps7m
 XC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763209308; x=1763814108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwl9MUQNIEhNXyj5+uubExWIsscNCW2R8U4mZiQJF0E=;
 b=hBrvrAOKFuE/P41Yfo0XbdH5osSx/bfv5cpcdhgVlqmLcRdOoq8EnNFnfq4ceD8dyZ
 EiN6E22ufYsJK4QUfEY/jPTP8b8/LmtMx3x8ne/EomHo+D7/yIA/IzitG3yxyy30bTuB
 Bza6T8ViLSpm/A95UTzZCbwqPr82S+b6CeS+6KXbVCkdZbKP6Q/ZYxVCe/I6wZ9tS4SV
 ljxxl/HpiD9lGx57mHv33Ypy0a+1cvMF/Y7cv/R43u9j9uwh/n8D5DivbxXYw9UGXIhf
 iVjSgXeU3/MkYrAMmveAgIW3LVfiU5F23bhy3WYkLkSFWl+O40mOMqTd2XRCQmDJH3xj
 wZ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW35TqE3w9n1J+E6mKMIy39Cx9qNOw7pfKC2QkROysPkjvXU1GrOG1B60I99XSCDXNMFuMwGlQiXUt@nongnu.org
X-Gm-Message-State: AOJu0YwtiSetE/LD5ldNbdsUsurbru0bRMOKEZ+1foomDwTDlJszZa8O
 hQfDE7Dqc/mnKMhN5hYxnTUOIrdkqsVc9MocfawzrbYf32k54aog+3/phx6rESFzTbw=
X-Gm-Gg: ASbGncvvYEYYgOq9TM/X72mEQSYCnjtIBD3ADs3UE88FHmEhXOlXAaVWE+e910tFMTf
 Pcrethhh8GB/gcATdVg3Fon4Zg3icRxa7oPg5HDzxMTk4oqz31drveaPriK2hC/LBQYXtRvMOTF
 GyEL1jnAv1uGdxt11eAij2+0+2MZRhmCievW9TGXj1mUq+MtB608OcOZXtnsgi3FLVvyN/FWeFD
 50eVNxCG+blkBPS77UvD6jT2omXAWG1DP/iE9s83VT3qWNNGjp+G6fA0NjoVzkZPhcP7YOuEyq2
 mzvD5B//uabR+KBBMkjs4/NlTXg+TOP29MYpqLZ/t+nq2CyxXHnOFTrO0uTUHSr2nyQ/CH71pvK
 1MbOB9AUi+krDQaiCOWOL5yGktlD/1l5hqYcs2JeSGxWuZhripAGIPyBiMaSnPLxdEe47CT6vJc
 uVEQNGMnL1IZpyyRQWyfB9LA39+BI1edtiVMvi+7S+trN+nLhzFvtLReSlmhX2P2hkZ8Zk4+w=
X-Google-Smtp-Source: AGHT+IGKCniVLWusipVhgA1/w145W2pzCfPCTf9k7EFCCtFjP3KdyoHzoM1JQ8X7mDffrZDRVg6pjA==
X-Received: by 2002:a05:600c:35c1:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-4778fe1170fmr71465795e9.0.1763209308271; 
 Sat, 15 Nov 2025 04:21:48 -0800 (PST)
Received: from [192.168.8.105] (115.red-2-141-104.dynamicip.rima-tde.net.
 [2.141.104.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477981347f1sm16202625e9.6.2025.11.15.04.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 04:21:47 -0800 (PST)
Message-ID: <492728c8-32f6-4e27-b879-e5f296eef8d3@linaro.org>
Date: Sat, 15 Nov 2025 13:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature
 bits
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
 <20251112092048.450090-4-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251112092048.450090-4-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/12/25 10:17, Jim MacArthur wrote:
> +    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
> +        : [x1] "=r" (idreg));
> +    if ((idreg & 0xF00) == 0x100) {

This should be != 0, just like in isar_feature_aa64_asid2.


r~


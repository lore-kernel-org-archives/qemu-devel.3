Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B70FC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp98v-0003FU-IV; Fri, 13 Sep 2024 12:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sp98s-00035W-Qv
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:27:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sp98p-00086W-Rj
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:27:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so2444569b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244845; x=1726849645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YoSm0Etri+zSW70lkI72O4NbskD5YrQTqqRlYI+Rcqg=;
 b=kRB/IlYBmJz5VvYtLh2K6Rfl1mDQVlTqS27LUstEY33d7GUCWmBOJYkhBr4pCf9Qrk
 2nBMHQG3h1SCVRcDbbC8gY9VhTpzU4aQzTBKaFR1CdQICyci1ewxEMPTRJPv+MnX7KkP
 PDLd75/U+7QOOBBkNoGwRfg8cjSBmFtKqJsVwyhCaTjo4Rq7o022d87Mpxpejs1k+w4l
 RQxGF96bdhAjJNchykb0BRcBWnuvj3VCvJrGNVx4zWBXw10e8vJYmKmc8crGbxxi+3WX
 WlZguhvdXZUg5OJxHt/rpQiksw9FYBfb5PjWMNlxH7ZQ7FGoKgo4FiUt9G3P9hvhFxa5
 HoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244845; x=1726849645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YoSm0Etri+zSW70lkI72O4NbskD5YrQTqqRlYI+Rcqg=;
 b=LFd85FMph0MAvRwHRcsyhXX+gZxS7I+QyKK0REgrq3hdfonahiVCMpr651Ly1hbktY
 xCX24REq/K8OO4wQQsB8rclEuA7YsFuG8Wnq0bQxTbtNd74nS6V+CZKjPb6a7hSrEuDv
 86HkSBI5IJV/XinmZ6DBdhEbRiOG1Mo9BBpedf58hZFPKvnvZT76wGSxnFlXoH3hflgF
 CM+IDk6hEbVtSN7cvN9H9Km4WIZQ98YNCo2RhXDouj2H2zmMDFTiM34f/yqPXjcVfiy0
 tWLPQfrgpw6EiWmSmgOpyvEh4l5CXXlst/rr0e+Lk+c5mtMQeyV8bcJs+PGGug4DeeQh
 zMiw==
X-Gm-Message-State: AOJu0Yz/zCESxoH3PjDaXZreSGv3VF1YL4zSdkyFD1cXbXtuLCtTyE+A
 +CE8zsMVjvLAS+kITzvdre1ESkn99nBOR7b9++eI/BQeI//CKosYBNCLp6fEuUM=
X-Google-Smtp-Source: AGHT+IHRJ5ZSHOoLhafVpdV3281jkzWnwqwICaTRflPfgUMeHqyfY3+UsfuI7pdKAjImiMn5pBsR5Q==
X-Received: by 2002:a05:6a00:3e27:b0:714:228d:e9f2 with SMTP id
 d2e1a72fcca58-719263a954amr10827891b3a.3.1726244844486; 
 Fri, 13 Sep 2024 09:27:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090af3cbsm6293953b3a.168.2024.09.13.09.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 09:27:23 -0700 (PDT)
Message-ID: <69ebf16e-dd3d-4dfb-be81-5034e8fe781f@linaro.org>
Date: Fri, 13 Sep 2024 09:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <f7f1cb70-08f8-48aa-9db7-cc7a119a4234@linaro.org>
 <87jzffrgw0.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87jzffrgw0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/13/24 03:23, Alex Bennée wrote:
>> Note that the branch is X < 0 (unsigned), which is always false, and
>> thus the branch is optimized away.
> 
> I'm obviously missing something reading this. How can TCG know the state
> of the scoreboard variables and optimise away the branch?

0 < 0 is of course false.

r~


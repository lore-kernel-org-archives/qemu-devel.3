Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E96CEFC38
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syEMW-0003tN-06; Tue, 08 Oct 2024 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syEMU-0003tC-HM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:51:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syEMR-0003rM-1j
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 13:51:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-207115e3056so54625375ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728409861; x=1729014661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u61rbn9oStn0Woo0fYr3gUc00N9GLwZAKPF4sc2tom4=;
 b=obamuF+J+f058XzMajvlaHWqj7RKmJyS8h5F8Z9yePkC6KHw2taHKW7q2VHI6pkU0z
 dEWB73C5R5FdjJPID+lc+adKJejyxdaBPvoLMhk8jaCsL05TJq0exRzmfXOhHHaL9TgF
 OXulqYIqMJCeVQalK3ojVkUBgMhmf1Ev2Z6xYP7R9CDW6zIZTgjoXt6k2E1i5oytFPHw
 Elt2zN8hBB6rzoDssgH58habuvnTfZg83oLtAj0Qg96jjbErDWhxcL0Z711WRQ7IDddq
 89MoepDIokwlwSdVBt6wMiUj3jjKQlx4EbFvAMeflVIb6YCqZhesSBcDc4VuaT8YRQbL
 NfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728409861; x=1729014661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u61rbn9oStn0Woo0fYr3gUc00N9GLwZAKPF4sc2tom4=;
 b=jPEepetaWizDaYyMKQCzKHE+5XYATaqy5CWrpZWpniyVwxYbKmVwK6IcSdbeO9ZnNz
 gcKdyShWFoL5C9StGUQ3Kfbt+PtD+SiTuQ4/F6/4zhPp4HTaL3KR0Rhb3ZT97b5wPB84
 qLPlMRFcX2DSXgChH6W/3YqgpMFaFz5l//HkRRiWH3ogSVPaaJY+ndeHqZw6FSxU1K4c
 Wtv+1SJB+kcpJt91Ne8zIgTsa9ZMg2EmxcfcszppyXZfF4UH1juToDWto1YySEGkBJz6
 5XfvfdlitjQSxC/khXjGoieil6a4HUfErc/UO04TCecV0TVQI79JoAIlaIhtW2wRIBv4
 TEDg==
X-Gm-Message-State: AOJu0Yx5MJ0sW0eMP6bZ6GvKWSFd5yqH/wXXuBrqItOPG3cyuv9k1rDR
 gBo5h3SBGJdF3nAZ9QaOw4O1/djBUDECz3Ea2m6Q/uOH1VhhC2hZIWNhCFcSegKH1TBjKYl2if5
 V
X-Google-Smtp-Source: AGHT+IH/gmp29kQkCW1MHpP2Fw7IWUdIixZZ3svn3bgb1FIgQf5uLSMcvXEpVcoiw4XJJPN6VTBMxQ==
X-Received: by 2002:a17:903:1c2:b0:20b:51c2:d789 with SMTP id
 d9443c01a7336-20bfdfef83emr245455255ad.16.1728409861117; 
 Tue, 08 Oct 2024 10:51:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cbf62sm58642245ad.89.2024.10.08.10.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 10:51:00 -0700 (PDT)
Message-ID: <fc414fcd-3e83-4cbb-ab81-77922b4d3c64@linaro.org>
Date: Tue, 8 Oct 2024 10:50:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] target/arm: Pass MemOp to
 get_phys_addr_with_space_nogpc
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-15-richard.henderson@linaro.org>
 <CAFEAcA9B1OsYgChehuz7uRgP-=Mbh=4zSK+owJz+BoBvA4Cnvg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9B1OsYgChehuz7uRgP-=Mbh=4zSK+owJz+BoBvA4Cnvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/8/24 07:35, Peter Maydell wrote:
>> -    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
>> -                                         &res, &fi);
>> +    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
>> +                                         mmu_idx, ss, &res, &fi);
> 
> 0 is the correct thing here, because AT operations are effectively
> assuming an aligned address (cf AArch64.AT() setting "aligned = true"
> in the Arm ARM pseudocode).
> 
> Is there a way to write this as something other than "0" as
> an indication of "we've definitely thought about this callsite
> and it's not just 0 for back-compat behaviour" ? Otherwise we
> could add a brief comment.

Nothing other than 0 is leaping to mind.
The documentation for @memop includes "... or 0 for none".

Perhaps

   /* This is a translation not a memory reference, so "memop = none = 0". */


r~


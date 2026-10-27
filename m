Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9176606E7D6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sNnvqn7i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf0n-0001OX-K6; Tue, 27 Oct 2026 07:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLf0k-0001OP-1l
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:06:35 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLf0g-0002GD-Lq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:06:32 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-54cd7de2d42so2360384b6e.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793099189; x=1793703989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Z2oZvPIKBVby8NnxBGRFYV6KQSqtJxwKK5DnAwS4Wo=;
 b=sNnvqn7iTq6sy5Ysb4pgmtre6505/Z+bwDnUx0h4e3Sg3QZgH95FnaXrmK4zp8Wscq
 SBd4j1Z6e0w5N6rONRTMeHqnmzLe15kj9d1NPOAKXU2sviCqI0mden39MPDtQ9fu2X6x
 bNDo7jqaY29sD4ot5zxe6JY2xACYC4sTef3tT410083Q1ognXlMq19k0V/WE86jIZWQP
 53oE3CdRGDGpxZHvZBZKBVr79IqJF0UohtjGG57e82pboWr9psLUAfAEHzinHjDYPZkP
 +dJH6jBpl4kEoEn/SKwmHCCKxB+/rf44uOGrTt+57K9DXDeZ1WmIU4w+Zup3CX/GLqlU
 ksxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099189; x=1793703989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Z2oZvPIKBVby8NnxBGRFYV6KQSqtJxwKK5DnAwS4Wo=;
 b=GCif4D39FIlGt7Q2JbINZrEZxF/GX32YD8NrF3E+VDjszY6SnhuwHgmM/1NpFUTor+
 7/X4X7UrcnRoiepQlWo24WRLO/G76DwOX2LmpGu9Rxt0zuOy0Bak3kdT6P7i0hpdr0Mz
 UNcWh+1s8+WJ+dC/FlaWRkD1e8xMMdVQ+6MhrX4vNBjRZAcLJl8uOMO7W34PfRa+3PgK
 eVV2TMlcBVl9e/jrr35mzMWzR2WrA0GgsG3HxojMBM3xq6a5qYBnYxPb/+ngud5/pza2
 OlRh6/MvR+qsS8pauS3PjeED2kPuKNGVmfrUVQN61aVakseUOx8ZnwyElTefNwmIt12X
 OHBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxHNuaTS/O56H/AFmqkhw92rDWVD7eSDCqSSQsfA62hHs+PRGJMhsFNZsl/wOnRkuaGUWfIKuaQu6R@nongnu.org
X-Gm-Message-State: AFq9FYKtinKGaV/3RcRVhVhMlhWNCqPqZqXFkbYEBqPbLNOQQvbLDFbq
 eDUMZ9F1HyskXC6Zra1ndntQpGr9fN5zJ3zi2zMVQYtfk8c5nbCzs+7sEsVMRQQKCas=
X-Gm-Gg: AYBFou2P+ejFTeFbqn6za+a25V6Pw6iPcd0TJA6a/csUlAZX/ELw3fC9O0g6OLN+b9r
 MyPCiAM2vrEHnO8+GopzKt/bi2VX2OvuzbWg/cEV+aCxheS2ESmmYrwxNZBELQBwVW8ljuwmk6+
 1RJk8nSqkaOVA2U8zBuWJmc487slttzQrCiU3bQLMW6jOWAjCmJlQjjusLGMjhdrTnfLHUiAJxq
 Jraj/qKiZOIbYe9MTmXzjFpiKrJUqXRjX3K+iN0NUX5eD5tmb8NY0t8vocsIUEGb4+SSlWraYLV
 PCHsspA8G4hQGc4cZyuGf0J++Heo3aiGseaCFndoEWGYYrICdQAaU08gUY6N/ijhbfIoE47ajO4
 tJeY9Cc+kGbF0Zz1K5g8ORRF0BBilbDBPdsuG+sRV69lPToKNxRl7Kfvy/O4RhFTziHNkFJKMsU
 WMdaZn+M0LQooOKfic7cpQLEHWjesN3JTSLGwaLmZ9OA0Bh3VECAKCRbZ5MdzJnvEnNlGeO0Wl+
 5xeI/fQ7ploCNEgrhmiNCskLLUrhfAJ8hFHbp6CJIe9qcpP2SYKvGSnvnhl+mPTtEdzV31kppLt
 GQCMn5nHFW5jVZ7U
X-Received: by 2002:a05:6808:4f2c:b0:4ec:7639:2ad with SMTP id
 5614622812f47-55c002307b5mr5870865b6e.13.1793099188599; 
 Tue, 27 Oct 2026 04:06:28 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0429c932sm7629911b6e.7.2026.10.27.04.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:06:27 -0700 (PDT)
Message-ID: <60fc7388-5884-4c38-a2ca-5a09a78d4627@linaro.org>
Date: Tue, 27 Oct 2026 06:06:24 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/41] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027032927.3055166-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 22:28, Brian Cain wrote:
> The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:
> 
>    Merge tag 'samuel-thibault' ofhttps://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261026
> 
> for you to fetch changes up to f6beebf1bb08b43d9bb8248ae49fbb9bbd4006d5:
> 
>    hw/intc/hex-l2vic: find the next pending irq a word at a time (2026-10-26 18:28:35 -0700)
> 
> v3: added "serialize config table as little endian" fix for test
> failure in "ubuntu-24.04-s390x-all-system".
> 
> ----------------------------------------------------------------
> hexagon: v85, DSP machines, singlestep, bugfixes
> 
> - v85 scalar: atomics, CFI/_rb, vector stack
> - new DSP machines: SM8975 NSP, SA8797P NSP0, SC8480XP NSP0, SA8775P CDSP0,
> QCS6490 CDSP.
> - bugfixes:
>      - coverity, ubsan findings in semihosting, decoder
>      - handling framekey w/dealloc_return
> - handle singlestep exception
> - performance improvements: TLB flush, l2vic
> - test coverage
> - MTTCG fixes: enabling MTTCG exposed races in lock/interrupts and ciad.

Not sure what's going on, but there are new python failures in 
functional testing:

https://gitlab.com/qemu-project/qemu/-/jobs/17499788773
https://gitlab.com/qemu-project/qemu/-/jobs/17499572582

As a warning, I'm now going to merge Pierrick's tcg helper patch set, 
which conflicts with this patch set, so you'll need to fix that up too.


r~


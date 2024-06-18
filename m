Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53816C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQSs-000328-Aq; Tue, 18 Jun 2024 00:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQSq-00031X-H4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:29:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQSo-0006lx-Jf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:28:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-705d9f4cd7bso2845726b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684937; x=1719289737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hpWqMVsk2mYNzlQvBPMthfWw2lqV8Yljj6zoWzTXeFk=;
 b=aXTzZHblbgoIq4UPekbRsSIcNjN4AiEqLq+of7FaK/roFFFCn82Ix3/e8R+sFtt63u
 5afOijctZaCXL+7Fqg2HPNlZYh/GjDtPr8Yfv61/S2OioBNu0FdIvPb+5ZWy2RXNfP4A
 tj+7TnZf9U+JeTadWVikH154mKR2RZa9uK1bqBO5JkBcx+MRAOYUeqPZda5gpR4Vj3WI
 rwgIKV9byRRp6cWLto3UPNjNLPsVdUgoZ3dsUbx2qGTin//n8RLdP4Vnf9s2vJqXlvdd
 jmT9MtYoz1o8ZDQ8u6seXWExn85EB0hQsRHcfL6y3whVAte8OPEpn/iSEUR7hQ9xdSJj
 m3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684937; x=1719289737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hpWqMVsk2mYNzlQvBPMthfWw2lqV8Yljj6zoWzTXeFk=;
 b=jtcl4xfkxVJl0BHUG8xWxxJyAGTqdMzo6CvktB1+5Lr4WCFlA77wvD2jQ8u4B3y/Hz
 HVf494873HX/fcW8gV7LSevpJG9U6rb7X9B8nd+yh6EktGwceo2Dor31N6fhSbIigFz2
 KEOAvXw/Tj/X6/R2JCYcRLlLXZx4LSg11wEw92dnsSUqi5t9gQxlkdace5JLWLxtDZU9
 iCp6dkpZnFPHCU0kGMmviC4qeFsN8jkkCkjYLJMedrMNC+kYGwKqqg5gfzn4AHLQf/BP
 w36UNJ0qy3I6KWMOZtyHyzRxuuFx4OFl3oVwmsnOyLLiOpdwtbxrfN9B4MGKgy1URl1r
 dOng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu9zswahnCio7LQF9Id2cvRe0NYY/1OetYORTRjxj3ytkP+IbPZiaP8ehz/BvQG1fVAI/hxAvUxDb5ou74+cMs3mMuX64=
X-Gm-Message-State: AOJu0YzIaWg7KG/nVHlN25DSheXg/4YliYZkhqNUqvL+y3puSA4XZg+f
 FPZLFHi85RXjCeAX7XuRD3KDDSluhjMvVGem+TskBeRJ1GsTbHBCzxlcI2agTN8=
X-Google-Smtp-Source: AGHT+IGFdacNxSojCgcSz2l3kCP1oI+KzAYbTbzM3x08uH77jFStoaM8U8LDNJ2lCPRtV2Uzd7K2lQ==
X-Received: by 2002:a05:6a21:1a7:b0:1b2:47f9:3814 with SMTP id
 adf61e73a8af0-1bae7e1caffmr12395353637.2.1718684937203; 
 Mon, 17 Jun 2024 21:28:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c53d95c103sm1474044a91.32.2024.06.17.21.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:28:56 -0700 (PDT)
Message-ID: <248b8ea2-c27a-4b27-b58b-8ecbb0e47919@linaro.org>
Date: Mon, 17 Jun 2024 21:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] Managing CPU register for BSD-USER
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Sean Bruno <sbruno@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-6-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-6-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Added structure for storing register states
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Sean Bruno<sbruno@freebsd.org>
> ---
>   bsd-user/aarch64/target_syscall.h | 51 +++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_syscall.h

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~


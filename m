Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0393D1A424
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 21:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szNZH-0006L6-4f; Fri, 11 Oct 2024 17:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szNZB-0006Kn-O3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 17:52:59 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szNZA-0001JA-7f
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 17:52:57 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fadb636abaso23758671fa.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728683574; x=1729288374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GqicGy4X2Nik+ueLm8W3LZkfkEggenXYhF38B2nMHgM=;
 b=K2KSTqqpM2LbJQQIlrVxEpuUdlUvXcJwcwa21vQStV5Uc8Ga+j+kPXcuScdUA9dJef
 6ylmFcimayzbLBLF8NH4ArbtW4fZ9z45aqy9pmPlKMxqk7eVEksPKTn3b63YGrvGZxrL
 ohOazJ039l3TrmwFs3aaK4XajUcf9cthu3FkhoWyV5GSUd+/GrIfEazca6wzXNrZUlfQ
 g0645rp/m9BEW32XFTlbrHZ9BNLdHCo08WUorgNmvMSEZ7VqpKU1l0uLfl96KHCnqFyg
 iZvtn36YUCYZzyWShSxwaMrzH/INeJ6RctdAXhEOxrtdGsd14njZbpOoREX8j06Qelg1
 ZWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728683574; x=1729288374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GqicGy4X2Nik+ueLm8W3LZkfkEggenXYhF38B2nMHgM=;
 b=t1gV0CB9aA1FcLzj8WMLDnPRzN0sbOGZg6NQ1hppLoFAGXC1i8xUGf5w7eN8tMbY36
 teYM+mmiw0WZ9fWtZSl3oiqAPHdUX5A6jlYBbPEzs9dCZyxeXuUJIqalcpvB2cf5mTkH
 T95OH0iYAJ56tFIKL+D+7H+Qib21gU2oBKTm+N83B/Uo1OTy74Q1TDmAgp/q9lcOcaTy
 0FFW8zsKI6o6QL9pesfRd4koRB5b4Z80s1xcrlWMw5tWX6uCJGluJzAbu1EuKvgFW23b
 A6z2hjBRjDrVSVBI94o5aJOoM0ODRqmmXLoEcKnfJterDoVnfcHUFh6o7BJtkYg5eImB
 /0Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcazoKlr8miKOpPxUKKyzVevffAPW21VWUcjoYkZqUdXuHQdGjAkgOzVEM7vbdCkbpZ0PXwys1RiK4@nongnu.org
X-Gm-Message-State: AOJu0YzXWkXODHB9scRli4NKSXYxXFvnY0yztk9mW5Z+yv0qhUj9twvF
 ArJNrc4zbbWDCPSlPcXi61NnLUupm76cJH9BJ/6yGLnGWOKcAMdnUVth031GL1w=
X-Google-Smtp-Source: AGHT+IG+2rom/WUih1K0CKXCDr9oUg2vYb0xkx67Onvxjxf2l9OVrxLiYHbBmRpkGJaWdSt7srBfww==
X-Received: by 2002:a05:651c:210c:b0:2fa:d059:af2 with SMTP id
 38308e7fff4ca-2fb32b417bbmr20298581fa.39.1728683573942; 
 Fri, 11 Oct 2024 14:52:53 -0700 (PDT)
Received: from [192.168.222.92] ([91.209.212.130])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fb40ed0207sm222431fa.49.2024.10.11.14.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 14:52:52 -0700 (PDT)
Message-ID: <c9946598-69f0-496d-b9f7-1d85261eff03@linaro.org>
Date: Fri, 11 Oct 2024 18:52:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: A new maintainer for the qtests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
References: <20241011141344.379781-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241011141344.379781-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 11/10/24 11:13, Thomas Huth wrote:
> Since I blundered into becoming the maintainer of the new functional
> test  framework in QEMU (tests/functional/) recently, I need to drop
> some other duties - it's getting too much for me otherwise. Laurent
> is also quite busy with other projects nowadays, so I looked around
> for help.
> Fabiano did quite a lot of work in the qtests in the past already,
> and is also already a maintainer for migration, so I thought he
> would be a very good fit, thus I asked him whether he would be
> interested to help out with the qtests and he agreed.
> Thank you very much, Fabiano!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



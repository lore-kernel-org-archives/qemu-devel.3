Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E68CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHqb-0004fC-3i; Fri, 08 May 2026 05:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHqY-0004f0-RW
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHqX-0007tj-4K
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:50:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ad135063so15790945e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233811; x=1778838611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fxH9Zn382+vNYkIOQOfOUPhkfxGXAej9EKNcWZDWhK0=;
 b=OkfOifOp073uo2ZUqRn4vjGjxCDOgini4L8cVqcwffPAXuQSRYWCJ6k72vzGCf1hc+
 9kUKx2zoLdGJsoLP/xkO6Xznifrs8VSMurxMZGSIuvxYGhsJB7TAv9axBchtYctlNOey
 razjhxPzc/9yDCRFvIWIo3K9v9W+LXhi65RDNyHDj6empldf3keJXBbOmujO+y4Kb6xB
 M8Hbcwk+i1FQMWcwQl8Dch3Zh7DbzimBHgK1IXhGUiH+2g0ZtguGM7uhvLSkML/AJ+sC
 Zll0BseAZiKxSE9KDkU1hN+cHQ0w+OrcJYjOKAfS/lK3EOHjHSSS4FEIWtz5fU7cqSgy
 ideA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233811; x=1778838611;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fxH9Zn382+vNYkIOQOfOUPhkfxGXAej9EKNcWZDWhK0=;
 b=mmfSyTFrv5xBJFAh6jcHEx17PuiCEnNXDxdOuYnqwh1HT4xYU0l4y0UppPporFkH8Y
 mi04acSAbmBsBY8EOaK/Js+Fn9hJvtu+oY/mYd9KplEiI0D0ADh/+XDoP4Ri4Y6qbrWR
 8CBl7pD3+Pg5gjzRE3TGxCBNZU21h7M+keXa2o0hPINPj3lP+O/lOP45TV5uE6TLL0wT
 J5feBiuXFW0CIxBZwQ7k0I2UtrThWFwD9uUNVAiosslOje0slEw4FXSOaNM6wj+NDd5T
 SAoh5OctR7es5JlItYJQqZCd97J7ZiHmDhB1/IhhcyeZh1Q5NTpJ223UtZxfvvDBf9Q0
 /kJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kVR3jcKSv1rbAwDGFjP4YtDcvdwHLkVz6eaY9MU4HRSD+AO8W/3G3iTClI1eCP5dV4HjEUHNMsI+w@nongnu.org
X-Gm-Message-State: AOJu0YylGu353Rr/gb1Hv/tshXt7gwqXr/msL+uO1Dq8lOTEM/ZB4MH0
 wGv2JnapbiV2JZBbf2+Q7HiO/ep/HgPBGwqXpoAGEQ0GBkb+zbTZfBLYwiq9vpBRcQY=
X-Gm-Gg: AeBDieu8gqWpQv6kf1ncKJ2WLV9xS25AnVBUunlNXxJVvZA1TCk0uPDoSFqXI4JnNHx
 RWW0YVLzt90tOYolcaquY9/5RaNM6eF9KHG3/EdzLrjlY67vVXTz+Gk1ujOd/8S6HDSmeCyoAZh
 18gFvy4exEp2uuMSdAYt9rVyrTQLtV0KGtgHhIfQeBjuQxPLJSGJ9ympfrmOKBGEfg2tn/xu/KL
 fm/tzykDaskhCppLHVnpAMCLQf23Bjt413nq4YiIAe9kOx8U0un0zLjL3LPJyz5xBPerqDXyv58
 Eh4pS7MKxhzberpy4WAcXtFx8uVwFmBe/okr+6poNhIvHuz3/MFdQeUqqa5NgaDqVYof207qJVP
 W+5p7ur07eWziqSwy4Kq8jhby5CkR40Neh4LP/o4sUMOvF3FBdmkEwZKStDlpNymX9SXjKck9eN
 yCmdTJJm45Etb7JTPZUZ9cp4CnmdMpLpyCITP2u/FyXnlYJX8jzHoOcG6IzWmiiSGs+yzulPxCp
 NHF1yJw
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48e51e21378mr203489825e9.12.1778233811153; 
 Fri, 08 May 2026 02:50:11 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6428e2bbsm29238565e9.0.2026.05.08.02.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:50:10 -0700 (PDT)
Message-ID: <8809d6ea-8648-40b4-8c90-b4ac6a54dc48@linaro.org>
Date: Fri, 8 May 2026 11:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] fpu: Add accessors for rebias_{underflow,overflow}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 10 ++++++++++
>   target/ppc/cpu.c                |  4 ++--
>   fpu/softfloat-parts.c.inc       |  4 ++--
>   fpu/softfloat-specialize.c.inc  | 10 ++++++++++
>   4 files changed, 24 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


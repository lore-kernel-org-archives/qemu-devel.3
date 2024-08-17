Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 00:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf77y-00008m-K8; Fri, 16 Aug 2024 20:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf77v-00007o-Fr
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:17:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf77u-00042C-19
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:17:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-202146e9538so7413755ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 17:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723853820; x=1724458620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+smS3V05s5eWuvLPAQ5vrnyr59tDdVA+fGI337pmeCE=;
 b=XYtwWew4lBKtHEimZ2+gm3NRZncKFHDBSm84Fast+TfoJWsvGDx6GfnsNVicAxPN4d
 kwzUmdK2NvwcwMcswbPbNLoagqztGef/jUSf+0pkVPoN2n92grtZeIpEA9+2AQdfew+m
 U+pTllODiK+biEod5SiCgD476Khm18pQjA60qynFSb6xmt0Lg1fDdBYMj784TveJSYiW
 D4Uc4yPyAU+5yJO+AOUasJxpflfC5Z6Ka556s2+jEOR5EVhfod8CX422CVig9gwQugnF
 CtANYCb+Q8Wa2FSZRqyVxgk5CvkHE2QU6gDMkhjCcz9rufHXZPhfIIjWv73OqrU/9ORl
 DdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723853820; x=1724458620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+smS3V05s5eWuvLPAQ5vrnyr59tDdVA+fGI337pmeCE=;
 b=a12J5OfhWNhVpMsmgOqG7V/+YUDbPlYaW0P0djc6YOHdy6L1qSztfycrnnef+mmwMm
 kcvGropjxFCU9nF5frgIlaEnV0WxAI2xkX5fVEGxwEiEXm7zG76Xd0wD1r3oy2OY+yxu
 H2WiO6huTpqe86Xey+KbChGjMY1/TIZOukwlMEranG13M1WfJquIXXBuA94ZQPV9HqKJ
 PADLi71IqykvBnxoKNHSzFdHib3nXL/GMAi6U/ZtJzlkV9tQlPdKRYqHAuxhSU1/OyTU
 1UQe+xtC8b03DNhquZbIE8B564dyt359pTq2BrJdPAroKgHJwZAnL6seX0WIhHeSsBiV
 wAxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtXMz6mjgRH8cIDrHD/Md6D9RApbPi34YYIpJXw737fulxSNrU3qe8VOTqWFr0l+5oTJrcWs32GZOpMRgJ9yEHndzzm68=
X-Gm-Message-State: AOJu0YzLAIW9etJCm7i+5xFqPdI4DpHpxF3YnfywxozoQGhEhqdqzYdI
 HZ0GVGvwpJjQ5HxI925HQMCMr+LY+2oWLZHUTxVhN77BqC+0fvxEt1YHtTPIghg=
X-Google-Smtp-Source: AGHT+IGvMUccN0ysHQ9Nz1KeHOz1ajXQhvQyrGxIUmBD50E9MMiE/gLzBjG3djLgFPtx/RfjqKmI9Q==
X-Received: by 2002:a17:902:e84a:b0:201:f2a4:cf94 with SMTP id
 d9443c01a7336-20203eb5532mr51712465ad.29.1723853820017; 
 Fri, 16 Aug 2024 17:17:00 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f022c72bsm30659735ad.0.2024.08.16.17.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 17:16:59 -0700 (PDT)
Message-ID: <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
Date: Sat, 17 Aug 2024 10:16:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
To: Carl Hauser <chauser@pullman.com>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/17/24 09:48, Carl Hauser wrote:
> netbsd panics in the kernel trap handler; unfortunately it does not include the fsr in the 
> panic message, but I expect it will be the same as on Solaris.

Ok, I have reproduced this with netbsd 9.3.
I'll have a look.


r~


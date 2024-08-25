Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67173C5320E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 12:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siC8G-0004gj-Pi; Sun, 25 Aug 2024 08:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siC8F-0004fl-9O
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 08:14:07 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1siC8D-0003Sb-KQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 08:14:06 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-81f94ce22f2so131825339f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724588044; x=1725192844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbToXCrbajlrJ7hi8Rhhm4AB0nfPJ7yL41Ygg1MUy2w=;
 b=IugYCywWW8DxPgzB1ApxQWB6wcNAEJmagN6dMr+keeGm4jtaUs6nsnK3YYAJsa7n4V
 BFg3j4mJW6oUYK774SIwLc4xQQA3dJW6w5eimfqAUVfdQPrug6z7ErGZLmwbn0gJXFY2
 BvZaFZH5nTI1pG+0J7u73fjZIoW8CQpVN6xGLBdnU/dIKPxsyWN9UpS2MdLkGhlLoJO6
 BzG3yyp1mJHXS3dofv02iSquaGRtZ3Q11i4UhbPlbobJzfucXTyUXCETApns9LKfHUYd
 BjlqNc4bTYaZNJHmm5YZqZ35rL9QnO7BycP7+U9rABJBehU90Ujwjrbb9fuo9U24M2hC
 vMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724588044; x=1725192844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbToXCrbajlrJ7hi8Rhhm4AB0nfPJ7yL41Ygg1MUy2w=;
 b=unBLu6v2eg0E/LMvGI7bIHF3LZI7wUS2uWYQS3XDtKjFsPf1aey6aOZzRjICyPn+mV
 E78PhdMCM45m/Vmo8yOCBqQQbXdWExoFL8CMwasmz1buFkAOJ4u0x6GYkGFHbNWIRDAV
 cUmYZAYHz+kK6N2qrN1vvDCGmq4xl7exhkpLJLa5gCddCw+tSvd7MT8wMphj0JDdIFYj
 kX4QmTKnb7y5s9tpvkk1xB0CV7bRV4Cct0aBdVjzsmZ84Zf/il9T++M3IMIYiq4fBf+o
 IlyoJRmziCAqOBn4Lxf7NtuZ/weajXnl6unYtwsMCSo0piM/ESrNr+h+RilICa2CEViA
 O6Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlPkxZ/mio2KmRXc2Pb0jTdSN2BZxP5O30TDZE0JxNz/4sVfUduofMiKRLr5VtsQWVUm8u9O/rU1o4@nongnu.org
X-Gm-Message-State: AOJu0YytbcaZh5AZEslx0m9jjoES69+hktGyNut1e5mIFDYvrftMaoI3
 QpASYd4Hx3xMwqZ54xy1JUBhwWMIrm+Yyzg+9BADVa0LLG2kDs5dxxJLSmFL+NQ=
X-Google-Smtp-Source: AGHT+IH+fX3KCEYRtkdDcBZhmz4dWnAZyRsqTrMIqur+e6AqKwY9Y7Bqo9uY8OVibJh3+ho4JxjrBw==
X-Received: by 2002:a05:6602:6185:b0:824:d4da:3c3d with SMTP id
 ca18e2360f4ac-82787360804mr902086739f.12.1724588043594; 
 Sun, 25 Aug 2024 05:14:03 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.160.182])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5bd94sm1750062173.42.2024.08.25.05.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 05:14:03 -0700 (PDT)
Message-ID: <f9bfe251-fc5c-4ffc-9842-a13d6fbe8b66@linaro.org>
Date: Sun, 25 Aug 2024 22:13:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240822162323.706382-1-peter.maydell@linaro.org>
 <795d0c95-9bbe-43f5-bcd4-edcbe00cddc9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <795d0c95-9bbe-43f5-bcd4-edcbe00cddc9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2d.google.com
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

On 8/23/24 16:42, Philippe Mathieu-Daudé wrote:
>>   static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
>>   {
>> -    char *nodename;
>> +    const char *intc_nodename = "/intc";
>> +    const char *its_nodename = "/intc/its";
> 
> Should we use static qualifiers?'

No.  The real object is the string literal.  The local variable simply allows multiple 
references within the function.


r~


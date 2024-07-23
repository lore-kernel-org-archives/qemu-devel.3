Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26204C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCcb-0001ME-SG; Tue, 23 Jul 2024 06:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWCca-0001GN-4p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:19:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWCcY-0001fB-7q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:19:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so46172865e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721729988; x=1722334788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RXbM+2aBEKg5pmzO9xgk4zyjj1sLqXQjFSrW605Iy2M=;
 b=CP+z0/+NPZkiM8gW6bfeINyUmKl8UViBZUbEpOA4tk+UPWmXh+ukZeJYe4zSHFPDl/
 lXd/R/nPDsjnqy2aXmNYM08u0b/yQhkEcY8m+lJjTYw73lIZhF8BhsaxsCCVzS/P3PZT
 AptIRz2yHkuMkkEhfjb+Lz30bMqyfpkoFsQdlH9MykFT+HufwfYcVCDgeOv10lJf3ciN
 Y+297vQjI6vMT6Kn9tKtvtcBnt3JmZlyEf6mnR01TuX6BG48rU3dORUZ3Q9l3m2xonId
 O2kkGz1yyILU8oFYljxNznAVfLFEzAODJZtSTOXH95qNepeIDKHwATyaUdZjE+SDD47J
 z8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729988; x=1722334788;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXbM+2aBEKg5pmzO9xgk4zyjj1sLqXQjFSrW605Iy2M=;
 b=kRUaTc7QZp5RqV99wqEprNuc5KS8EgB4MrPPx0LMI/kzvMQl6/MABZf0BBpyeoOfeE
 Z2cvnYrnP/qDlqGF40X9LM1TWYXRCvHsiwL3yZ/EF9OVBqjhYwWfqAQ+BaGSOVcLITg/
 a9umlaPy8xCRfkE7FoUIm5JN2mOexMF9cgFG2tx60MvnuXgs/ahGHY7kkuv7m7nnCZ13
 X0MoRk2GI/Ds9iVJiBrpXmjZbIRORfOz6zInK8A1NKf76hFMiZcvklknt/Hl/hg9dbaB
 GmRcvxjcw7p97mgJCS5LxmjxE+dx+26SdfY9eRuI9xhjTbRpdix5xoIKB5m6EvIxTLfR
 unDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu2UmQ0pqA3ZJHPR85WsVhG5jyk9co+eZIu99hfO+hkvE3HLrYTqsdtGF4umj+7yyiq4Yj7nyoolz3eGqRb+yGLzMTxLc=
X-Gm-Message-State: AOJu0YwWAawFOB2hwkl2Cwj9vJsbVsIhmXxeotD4T3QwcB5CIfhEO5GH
 OLDrGdLeSBZiSPfaicEgz/4Hk09Hgw+FJP+863Rrnk7wgb2QtkEroFGNSDE+6rM=
X-Google-Smtp-Source: AGHT+IF0rNBmIpzpyDs7u1DI9yFbQ3SgDAiMpmWGXLoMi+OYICNNGkvIMebtAw63VqGg6jpwYY5wZQ==
X-Received: by 2002:adf:e382:0:b0:367:9d4e:8861 with SMTP id
 ffacd0b85a97d-369bb2d475bmr6973099f8f.57.1721729988394; 
 Tue, 23 Jul 2024 03:19:48 -0700 (PDT)
Received: from [192.168.203.175] (5.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bab0sm11141498f8f.44.2024.07.23.03.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 03:19:47 -0700 (PDT)
Message-ID: <1ca32405-41e1-423e-81e3-07e8569911c1@linaro.org>
Date: Tue, 23 Jul 2024 12:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
 <7c2c14e9-d6eb-4a8d-bb87-57ec289756d4@linaro.org>
Content-Language: en-US
In-Reply-To: <7c2c14e9-d6eb-4a8d-bb87-57ec289756d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/7/24 15:04, Philippe Mathieu-Daudé wrote:
> On 19/7/24 14:56, Jiaxun Yang wrote:
>>
>>
>> 在2024年7月18日七月 下午9:32，Philippe Mathieu-Daudé写道：
>>> Since v4:
>>> - Fix build failure due to rebase (Song)
>>> - Loongarch -> LoongArch (Song)
>>> - Added Song's tags
>>>
>>> Since v3:
>>> - Use DEFINE_TYPES() macro (unreviewed patch #1)
>>> - Update MAINTAINERS
>>> - Added Bibo's tags
>>
>> For the whole series:
>>
>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Yeah!
> 
>> Thanks! Tested on MIPS loongson3-virt with 2, 4 CPUs, all working fine.
>>
>> I'll get this covered by CI later.
> 
> Thanks,
> 
> I'm queuing this series.

Due to pre-existing bug I have to drop this series :(

See 
https://lore.kernel.org/qemu-devel/492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org/.


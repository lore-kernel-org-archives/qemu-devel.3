Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4783C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv3j-0002pS-LD; Tue, 13 Feb 2024 10:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv3e-0002gu-6I
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:54 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv3Z-0005VG-0E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:52 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-785d5fa8169so170271485a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839443; x=1708444243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zr3mehn/xZ0OaAXl/DQ0wynxpLmisZ0EuMbAySZB6LE=;
 b=GjtP9ldb8OBP6uej/HY6yf6zvh4rSuSp/l+Ze6R19xL55/yAaaDbyiRpHmc+Xszatr
 HQDC8Ai/6hbjqmPkjVhN4Yo01WJv8yzp4v/HJpsksUtuWyxBsVIntnSKPivDonF7bW3/
 hB0Qcs7xApspJIPU+JkpZE3jiAbpJEKwycK3ONM8JZvoqftF8VWwJU9INYrnMOI8IEHn
 AiQxfIzfsIFpLkb97G56wXfWEubNqPlslsiuLHqDWQZxGGLq/24uDtd4r7CLe15PyM+5
 x1dLHu4XFJGY4qRZGGgY5LjlXeKpjby2EqsR4aOeXOpwJayKAMD8MtpLg69UkbIwZK0T
 ndaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839443; x=1708444243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr3mehn/xZ0OaAXl/DQ0wynxpLmisZ0EuMbAySZB6LE=;
 b=okFPteRrSNdMyEw/XiWXockA33PzGK+LQlqO8uLdSEcGvmZcRgpgLeI4rqp4sUkokS
 XJhV8GVoTNSmjjK7eGewi8H/Jhtlyo0C9UDNa+ciqasjBlZlKe3k4mnCa+C3QZG9NYil
 NZxc9mVwAs8oU+0/sNj0Cls0wW9S2+Y2ERbTdotGRIQ3RTA5AfuN00eJxxVjJWkY0Sdf
 3Df1FRcBX+QC/p1cNXiw7M8Wy3PFEba3RQEnuh0Wqmc6gFWQ0wCqI8xTSthc3NesJpAo
 QqqNKkHy5+VxtAXvPFxNY+avL6cfKxCmUpC31M1ndWU0HDTvUpR9UfDMWIQkcNFUW+x5
 Z3QQ==
X-Gm-Message-State: AOJu0YzNxyotBzLq17kbh30ubITOIRvuMZmqwP0cgRJuj7NYERWgioH5
 BuQkzU3dgJ9As5PBnTIC15aBXOqX7CHFh7ILJDYAeFelkia8B17pL+S7etT7k/4=
X-Google-Smtp-Source: AGHT+IF6UOZgUGzX72okWIR7sh7LTHdIW6/f0EKYoEKGzQHfAe91/iWMXsqI8Eqi5Kj6pSjbPI5UZw==
X-Received: by 2002:a05:620a:29d1:b0:785:d69d:ee37 with SMTP id
 s17-20020a05620a29d100b00785d69dee37mr7280962qkp.29.1707839442907; 
 Tue, 13 Feb 2024 07:50:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU/+2G3j0oDQNyFNmxnxZXAhboCu1hQuAVgyx4cVJcf2kVPi3C2o8ByMJzo3lJmDynPGxBCNOVuHtKM7OqKuWlhAJURtXs4imVqEywBvqz3vgnADyHGlUuQy5bpthIyhICq72PcbTjIGVNspECKe5PftwZRjKyQCSiwDvk7NVZHQGzkN3ZHXmbg/kwkDH64YQRq
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a05620a0ecb00b007840b13c58esm3058425qkm.63.2024.02.13.07.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 07:50:42 -0800 (PST)
Message-ID: <cde94c81-c3bf-42f3-9bc8-e9214ed84d51@linaro.org>
Date: Tue, 13 Feb 2024 16:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/arm/stellaris: Convert I2C controller to
 Resettable interface
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-3-philmd@linaro.org>
 <CAFEAcA_e3QOvfvJScUgtmjGacKZX1OHyY5a-BWSAhNURyO2Rgg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_e3QOvfvJScUgtmjGacKZX1OHyY5a-BWSAhNURyO2Rgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/2/24 17:24, Peter Maydell wrote:
> On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/stellaris.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)


>> @@ -658,8 +661,6 @@ static void stellaris_i2c_init(Object *obj)
>>       memory_region_init_io(&s->iomem, obj, &stellaris_i2c_ops, s,
>>                             "i2c", 0x1000);
>>       sysbus_init_mmio(sbd, &s->iomem);
>> -    /* ??? For now we only implement the master interface.  */
> 
> I'm not 100%, but I think this comment is a general one,
> not reset specific, so it should stay in the init function.
> 
>> -    stellaris_i2c_reset(s);
>>   }
> 
> I think that the i2c_end_transfer() should be in the
> "enter" phase, and the clearing of the state fields in
> "hold", and then the stellaris_i2c_update() call in "exit".

Indeed.

> Though usually we don't bother to do an update in reset
> if it's just "device has reset and now its outbound IRQ
> line is not set", so we could alternatively just delete that.

I'll let that as an possible cleanup on top.

Thanks for the review,

Phil.


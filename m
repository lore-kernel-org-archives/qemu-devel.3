Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91171C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOff-0008S0-08; Thu, 21 Mar 2024 16:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOfc-0008RY-28
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:05:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnOfZ-0004vx-IR
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:05:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dffa5e3f2dso8903505ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711051544; x=1711656344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oXsgPRvYcJa1+warAPat/C1xp9DpRWqucg86mkp4crE=;
 b=JzmfB+NPGd/N1jVMSvVxJtbxORnvgZMQxaehZ+w8Pc0sIV+YseUs0mPnsUY/XCJ1+7
 moVwNoWEZzRTsi2QCmUwwNEEb8Lx6hK+IEhdz0ku4PtDTluOaxO+vAJVab/vBTN6/pFt
 JZ6FjVZtTcypX8VaTvXq7Li/2lKME5+C+B/gEaShESOpTVnJcsYBznpvwWY1pRf8U9TQ
 7cpCHvyANAR1Mseoqs6XnMeeeUfAxBrrmLqjgAyYkPls29cRRKSqeTVBXhP1QsZ5H9uc
 YU1M3NIfbGPfO1rqKQiTNmCSGXbnqShb64MT9HyTj8btkljIdLTakYZPQX0dm3CgxLGx
 apJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711051544; x=1711656344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXsgPRvYcJa1+warAPat/C1xp9DpRWqucg86mkp4crE=;
 b=LCz2WXBQ18QRVDzToQ7VdHZ078K74c80Pa4zlKfazZRv2YtACOYz3P0rq/aKvQPX6v
 dVgWj44PAZCcJd47pSmghKHDF8Sk52WsInVeWxiDbFVRQXW1upZ8kiEULWaanueXFV+W
 XvxE13yaXXK2iq9dwErhESoj9C1019x3z+fffvFKSANoglFgEReStex45yniupHYqa/L
 XhyQ2mMpNTB+/uBVBmK3a/a+Dnb5LM5xmcEI3qL29eDA/vqBYvFjkewp1dB0R1p/ru6g
 ZpVEeHDdSxBUAkC/DJgqL/pRb/8NcsVQDkH4VtVZKuv253T5X0ylkKKCJA0oe684C615
 34qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX47B+7bSqCUumLCqjUun3uoksAqllCqpWiYltE4sLFhlMZvf0Dr1udBe74dtUEsUrbL2tIffCFWrchdy/qr8HePk5Ge+w=
X-Gm-Message-State: AOJu0YyJ4FPL1CHUoU4LgJjh7cogEWFdkEx5bhk6h70/XVgy3q4M8+zz
 ofHY+mwa1rgzSfOQPnc3CTo+4br8D4OCzdPUUYcHWXOiS993JYq+fwkpq9vMGoE=
X-Google-Smtp-Source: AGHT+IGn46ya0n4kTZe2z0M7jzQ3e461OVgDl7dpc9MEdzkXiMvGQNnZVtyUSieFvGBa0dYzjBj/RA==
X-Received: by 2002:a17:902:7847:b0:1df:ff90:5d43 with SMTP id
 e7-20020a170902784700b001dfff905d43mr465244pln.6.1711051544152; 
 Thu, 21 Mar 2024 13:05:44 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a11-20020a170902eccb00b001dee1e0beddsm232159plh.246.2024.03.21.13.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 13:05:43 -0700 (PDT)
Message-ID: <4334d475-2089-4268-a2ef-3492d70c7b76@linaro.org>
Date: Thu, 21 Mar 2024 10:05:41 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hppa: Fix B,GATE for wide mode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org
References: <20240321192813.371526-1-richard.henderson@linaro.org>
 <20240321192813.371526-3-richard.henderson@linaro.org>
 <ff49230b-0ab0-4a40-b499-4f072d883f75@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ff49230b-0ab0-4a40-b499-4f072d883f75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/21/24 09:34, Philippe Mathieu-Daudé wrote:
> On 21/3/24 20:28, Richard Henderson wrote:
>> Do not clobber the high bits of the address by using a 32-bit deposit.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/hppa/translate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 1766a63001..f875d76a23 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
>>           }
>>           /* No change for non-gateway pages or for priv decrease.  */
>>           if (type >= 4 && type - 4 < ctx->privilege) {
>> -            dest = deposit32(dest, 0, 2, type - 4);
>> +            dest = deposit64(dest, 0, 2, type - 4);
>>           }
>>       } else {
>>           dest &= -4;  /* priv = 0 */
> 
> Fixes: 43e056522f ("target/hppa: Implement B,GATE insn")

Certainly not.  That predates hppa64 support by years.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D7610AB80A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5q6X-0001hR-Tj; Thu, 26 Mar 2026 15:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5q6W-0001h5-ET
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:10:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5q6U-0000kJ-L2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:10:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso8552495ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774552248; x=1775157048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9mEKlZaOo1SmTr2/JJZnOTnoaPq9KrV/DOdGDyVTKz0=;
 b=Rmfy8901gu+QZ8FbwFjgbxgrI8NQFeq5g+kwzJeCdcGa+Ta2SxTIHKvUQJtN/UDs0m
 tWsQy3u55kkhpkYcTn4/iC4M75KkIrATBBlyMuWdWslpRsT1dirTe9HpvQAn37oLiXPK
 D9mvWuUUWvH9AsumeUihgxubvM90aOUGU1hqSYT8LENjRp900zpYZOJ9TSik8BIB9Yyd
 eIt2pcaUuHFvG1sbRV3rI3gr28aHEUiwdTKCe8xg7O/uq1FcFSGzL4hPWGbfgX2SUuqq
 uVTaKmwK7uoXyusxQ/zxzsmYB3eqSEjwrS3X3KDu3Q1KXUIroY2VYw23cyzdIvMj/yKT
 Pj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774552248; x=1775157048;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mEKlZaOo1SmTr2/JJZnOTnoaPq9KrV/DOdGDyVTKz0=;
 b=YkxkLfLDyp9X4rw9LoNQq0eEFzXlvd0YVlW4sRMg/vXSIlnHMLoOzcr1yMW4Gw4YP3
 LqLW7G/l53x/TFdtuS4hTV/K8fnrICUc1bIZJ0WGzFKxW7T7XjWIMv1HvFZwWiXHY3FN
 CdVVZRImzu0ez/UhvWku5btnolVFnB+MTOzRelKzhvQ7/z3/p3DaL70jXXXRZMM7eQts
 TA28F6sYZc+XaK/51A5esI7S9XzKfNoYBcYpb79EE2LvSaKSzsIM18ExwzT3mGTkGyUP
 RMD64qtre8i4JY5aSdikl3TS2QwmHbb83KHi+2oSa6liF0whF9l91UV3F8zhsVVGqoLQ
 YFiQ==
X-Gm-Message-State: AOJu0YwWP6sUdXHQLDAyOKbwcGpeviIYab8Cqx7qDB+VH9Bbu5ooGtv0
 q8dULSjFy9qq+C8ZXJruQwJpHrCKNj7ymJCfLkahD+FpODOvMyUmgpRZ/j0P7ImshDM=
X-Gm-Gg: ATEYQzwwn7ShCAJTjUAAvVitLvgBxCJOjOvBbKVXCJ+bFAkmwaVsDu/0N84H1gIshwl
 PbbF+3fQGPbOpKlekiiE8QD/rQBsQQHL6IIVfOJMi4C7R2JjjmUBr0fh6X/AHnrTTAy+IK92JgB
 iCNOwrLJ6IjwFK7eJw5DfL2T/57vANicmJFTp4/qlhbnBP5e5DxZ4bk1dvffFPPtbBytCp4dZfO
 6yrK5hck7EVvlrvr42SLQ3EJWDVN1VLa/aIEryX514wZildOhKMvqwQvpeE2l4wOQ+olZbb4Okp
 tF0rbHWlgecgZzfeyb9suqq7G/+G0SUkAEeV9Srv0yyMI6We2eE+3ynq1g8kloagaweMjUfdk9N
 G3ki3Xlxn+57ULMz+jvP0DOBZrKE7r1AU0r0WTJ0gj9X1jCr7s7qqylTJEqOmjjdJhtU+EAmKOW
 W8ENkxo/jjE9WdYEGt9Mih/wRslvzx/oHLGONyrzEB8QdeOUeeCgzw46j1XBvwnNgxPyDQ
X-Received: by 2002:a17:903:3884:b0:2ae:57e6:616c with SMTP id
 d9443c01a7336-2b0b0989326mr87202945ad.3.1774552248102; 
 Thu, 26 Mar 2026 12:10:48 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7a9deesm36532765ad.28.2026.03.26.12.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 12:10:47 -0700 (PDT)
Message-ID: <efe2b0d0-4bab-488d-9fed-0b73dce24ecf@linaro.org>
Date: Thu, 26 Mar 2026 12:10:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/i386: emulate: make unmapped GPA warnings a
 trace
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260326183628.79281-1-mohamed@unpredictable.fr>
 <20260326183628.79281-3-mohamed@unpredictable.fr>
 <b1115dab-4f72-4c8a-8d81-3c24b3475faf@linaro.org>
 <6BB391D1-719D-45C5-B0F3-2CDBA65CC1E1@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <6BB391D1-719D-45C5-B0F3-2CDBA65CC1E1@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/26/26 11:53 AM, Mohamed Mediouni wrote:
> 
> 
>> On 26. Mar 2026, at 19:46, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/26/26 11:36 AM, Mohamed Mediouni wrote:
>>> Some guest OSes trigger them way too often.
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   meson.build                      | 1 +
>>>   target/i386/emulate/trace-events | 2 ++
>>>   target/i386/emulate/trace.h      | 2 ++
>>>   target/i386/emulate/x86_mmu.c    | 5 +++--
>>>   4 files changed, 8 insertions(+), 2 deletions(-)
>>>   create mode 100644 target/i386/emulate/trace-events
>>>   create mode 100644 target/i386/emulate/trace.h
>>
>> To justify the change, it could help if you could add a better commit description explaining:
>> - which OSes are concerned (older windows?)
>> - analysis why they do such a thing (at least see some QEMU backtraces when this happen).
> Hello,
> 
> Neither Windows or Linux are concerned by this one, but the
> ReactOS install ISO - among some other more rare OSes - trigger it.
> 
> Intriguingly, the ReactOS live ISO doesn’t trigger it.
>

Might be a good idea to report that to them, as it seems like something 
wrong is going on, which was the point of having this (loud) warning in 
the first place.

>>
>>  From what I see, this code is triggered either from hvf, or when running an ins instruction, so you could explain which scenario you're covering.
> 
> WHPX has been moved to target/i386/emulate for 11.0, it’s no
> longer using winhvemulation.
> 
> And that means that it’s a load bearing path through which
> load/stores on every MMIO access by an emulated instruction
> goes through. And even reading part of the instruction itself
> if Hyper-V doesn’t give a complete one.
>

I see.

In this case, maybe a better compromise than using custom trace events 
would be to make it visible when using -d guest_errors.
The problem is that custom trace events are hidden for users, and except 
if you know it exists, it's impossible to guess it's there.

On the opposite, -d guest_errors can be discovered by someone curious 
with `qemu-system-x86_64 -d help`, and it's the same flag for all 
architectures.

> Thanks,
> -Mohamed
> 

Regards,
Pierrick


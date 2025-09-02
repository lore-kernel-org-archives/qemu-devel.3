Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5205CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO7V-0004uk-7D; Tue, 02 Sep 2025 06:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utO7S-0004sL-DM
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:20:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utO7Q-0007jp-0w
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:20:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b88bff3ebso14475285e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808401; x=1757413201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qwrNycWtfMUjffVw8IYCiuiZsm2VCrORDjwl8LHKnTM=;
 b=ID16dhTW6MbZgxKBoucmSXJn0Qyy4H3mcJjzlHzgJH8etl5VNTmHwF0p41sJloKubK
 +StxKwHW/pybnEaFlXzJkHGYXQwgYUfBIW8HFRDz3b3iZIwc3/U8v9yfi3vbnuuWzdoW
 0RUYPjknjXLqEsSL5suJW+XUBW/6CfCDyjm37o7SRSKIwF4kjN2YdAnusOkod49ZHj7a
 oTdLUMyLhennkfYw7JJHYbF9x0ds+NIZqSNBMZXo/Su8twJrvQYLicXFjl1939XY4fE1
 W2mCmxU6rTkIR1HCgkOkN2W3yJMPoz5ZlwxrSFra0OEgotVk7scRnt5C+ugCj0CoWz85
 VC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808401; x=1757413201;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwrNycWtfMUjffVw8IYCiuiZsm2VCrORDjwl8LHKnTM=;
 b=HWkpTl6/Gd/v0n7wZ1RgY/9d03tJdAOz/IynGV6j4dzzmFCTpk0maAfqIWs0vC7xE7
 nGoCFxuadiTX/7SlPcRdWIKfYJhXCdOIk7YpkK8RWXflW4/MQT+jIB3gtlTBDEtlMAjV
 nTV9HmGKPSTIy0nqLje8TqFqG8Ob3ZK5bxKMCYmolSvWUDmuWg2LOhB1fR3evMRXPYv4
 TwltpBnY1yfIyWTK27lFvJqi/Kp5WbDpTv2GFcIKWlRqF5vBkgakwlkSohoiCrUjvrG4
 0dZdOAWnvu756uR0A1J1FSi1+VU3lJJA8UKpuL5tRjrAKybFZnHdVgV4zqdwEld2qc42
 Ft8Q==
X-Gm-Message-State: AOJu0Yy1Ea7PONx+7IlimyLy9nIX7QMF8tC1bk9FMkUL0Cu6FCYap0B4
 Rd5xbiTUSiZh5hdeKDQilU87YJIiWtzZsBFtI+vKI3K5xU6odu+n9+eGWQNQAh3cUj4=
X-Gm-Gg: ASbGncuCyk/fozhQsr14qV/88v+6cdDAOjgwtKi7KBP5QZkODtZ5F2bvgin1ChqoxYR
 cqGED90m3/9tSXHKkKKQ0u1zNemS0AnJkvfAVOY8zviycSDtp/prHArV/SZTmTnwUsiX5bOGcoH
 S6SqwxSlYfOpyw6kOvTEuhgYvTx8Y8EwNQ/GTMsZ3lACwS0CoSM8d2bRlMfEJlC3nwan58O7CA8
 XVS6keX9Kx0XUZHMB/NNzSDj9gvcNwNhp65Ea6cFZ6Kyz9p7KpiTiXBcl6eqFv++QHRV3JWwObB
 Zn2Ygg6G4g64ujarIIf4XItzaYrmzCoG51uEJXKmB/9owLnLEXLVA/yL/2HAJzbjBXlXcBYUdx3
 Gwv7uJIbK5PYWtNBObGn60TWCgCXo3Avzfeoix62t/bvbbImGk9TDJVtgI5TpTWNh7c5uN9g=
X-Google-Smtp-Source: AGHT+IEj+wTnB55wZE35ENwaD4Cln8YXlNEu4EHCUbBlJdeevWB3/a5kGOe9VYn7+JQvHJG54hVR7g==
X-Received: by 2002:a05:600c:3543:b0:45b:87b6:1f65 with SMTP id
 5b1f17b1804b1-45b87b62146mr72699465e9.21.1756808400907; 
 Tue, 02 Sep 2025 03:20:00 -0700 (PDT)
Received: from [10.20.0.233] (151-0-205-164.ip282.fastwebnet.it.
 [151.0.205.164]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6fe5sm273488315e9.5.2025.09.02.03.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:20:00 -0700 (PDT)
Message-ID: <d1e98178-8d47-4ed5-8024-a6c4c603235b@linaro.org>
Date: Tue, 2 Sep 2025 12:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] util: add API to fetch the current thread name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-8-berrange@redhat.com>
 <2fbc5525-cf8c-4d3a-ac2e-97d2764fc5f4@linaro.org>
 <aLVeCs5QHtAJJLiY@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aLVeCs5QHtAJJLiY@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/1/25 18:49, Daniel P. Berrangé wrote:
> On Sun, Aug 31, 2025 at 08:14:21AM +1000, Richard Henderson wrote:
>> On 8/30/25 04:03, Daniel P. Berrangé wrote:
>>> +#ifndef PTHREAD_MAX_NAMELEN_NP
>>> +#define PTHREAD_MAX_NAMELEN_NP 16
>>> +#endif
>>> +
>>> +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];
>>
>> If you're going to have this...
>>
>>> +static __thread char namebuf[64];
>>
>> ... or this, why not just remember the name from when we set it?
>>
>> You could even store a pointer instead of a larger number of characters.
>> I'll note that all of the names we actually pass to qemu_thread_create are
>> string literals, and that we don't actually need to do any memory allocation
>> at all with them.
> 
> I was thinking about the possibility there will be threads running that
> were not created using qemu_thread_start, given that libraries use threads
> behind the scenes and I can't rule out possibility that such threads call
> back into QEMU code.

Good point.


r~


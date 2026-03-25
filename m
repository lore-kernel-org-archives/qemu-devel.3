Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38455109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q4x-00010i-Hv; Wed, 25 Mar 2026 11:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Q4w-00010X-Hl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:23:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Q4u-0003VW-VT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:23:30 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso14092a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774452207; x=1775057007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IEvqtXtu5WYMfAnPM1Nc3Y6VTJAQWZJCVsG9msmNfF8=;
 b=koSHRitZOnSKN13+c7qG5a5GzOhH2cZHwP/Y71/TMCskrkT30i6A2kMfaMOpqtWj7v
 08PQemJ2gecZ/b4dB6WDFlBdXPHj9cfr1JOJ6DTmvOeKEV5Cc1K4qBTDrSB93aGfiTA1
 k74Ewh0o6Uaq4MxXaP55BFJ5p3nmaKnMONyGbFY+NGd0FDa7XaTMIS0Nl7g0COoVGbJ/
 qaYHhvy+iWZDZbY4wOnY8e17YOAL/tHfuluqj0Zg9N5sOCJNvV54u1OTLdrhq5FAVdf2
 hQs31TZti/RkGzFChMW7Cm70+nC7vgI20SXiSKIIMzpXOHfZyebh7yLNLf6nY4ex074D
 Gzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452207; x=1775057007;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IEvqtXtu5WYMfAnPM1Nc3Y6VTJAQWZJCVsG9msmNfF8=;
 b=HTTsnxk/y2WkO+SaigvKjDPDU4aP2T5eX4poCHM7pjcoRksqe5ENtTnGo+EKCUaseP
 jmdLSkcvidtjX1k2/u70J1USwRqPTAdMYYv5+tr3N6oIj39f5u2rvzcRJ4R0ARYJk6p0
 fJsFFATVPUQ6th8fWcWvzKUPVNulfYJeMBCLe4ib6A7/VSvaLrAVc920hYJdEhkEF97S
 JKyPMvBJDnv4NB2JL14hkp6FtdfzjKmVx8X5MlVWTuDiTJ2o1asr3hyHcT3oA9UrPQHs
 O3z0Oeja12NCipCQQ3w7HliByeNk3yIqISVU/Sugv35u1QP+apKtf4HxxondOkVZJmhV
 2FcA==
X-Gm-Message-State: AOJu0YyL7WHZtPEb5cQqQNfdx5P1UpislSS5gJkY+n1gJ/6sEAV9dGEV
 rqW8vmvxALVJBlC/M+9SiRmpI5FVhn6tZjj7tSQxkfWxhypSNaRV+l0LywRDTiES+0//a26Cp6v
 RYbOaAXg=
X-Gm-Gg: ATEYQzy00dl/n/QKBxqwlF9oJUyFhZ5smadIEDTN5mOomhlRGhEjOYzuhcHEpkrG4jg
 76RN6LA5+LjvrxgLRz65p7IuOqOMLNlAmCnBUXNdU6I0ciIuYnuniWek+iMBiBqreIdocg/MItt
 zt4LOSTCaYISyQ1Hj2L898lYKDjYg8Cn+zn6epeqTJH9xEHolTjNJ4WY93z2/1O3vhvMUiKmEws
 eeVbOou6TjMiH4wwUPV2hwKbfqmdxYZFqgRNu9i+3LYvFOsol6g9OAls6s2uav6EBE2WcQtDoe8
 QOo9ODZuubAtofgLH2snrbnvzGXCf+Gm0GnqJMHP0e6zs+N+wF9tP02CS/L+nCt8JdZsAhU9s8Y
 6FUnpRBCfqjktZcjxHtoniKPA3eXvwhngO01Jprssa+3zwkQ7/N6zW61Xvqt1RWQy8Hv1CXH8TZ
 5Q8khMbHRxB33MbEkiagyQIKyigAq2zLW1WNNzpZGGzwrId1VyDSP3zse9zA2VeB7k2wqm
X-Received: by 2002:a05:6a21:6da6:b0:39b:9644:6e94 with SMTP id
 adf61e73a8af0-39c4abb5319mr4212647637.9.1774452206795; 
 Wed, 25 Mar 2026 08:23:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c763ef3a0aasm10561407a12.10.2026.03.25.08.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:23:26 -0700 (PDT)
Message-ID: <cf58712c-1509-4b78-99d0-1fbf45215a71@linaro.org>
Date: Wed, 25 Mar 2026 08:23:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] include/plugins/qemu-plugin.h: add note about
 endianness of value returned by qemu_plugin_mem_get_value
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
 <20260325024252.3369186-3-pierrick.bouvier@linaro.org>
 <87wlz02b2d.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87wlz02b2d.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 3/25/26 8:17 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/plugins/qemu-plugin.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>> index 2ce7a7fb6c3..4eb1d2cd85c 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -374,7 +374,8 @@ enum qemu_plugin_mem_value_type {
>>    *
>>    * @type: the memory access size
>>    * @data: the value accessed during the memory operation (value after
>> - *        read/write)
>> + *        read/write). It's directly stored following host endianness, so no
>> + *        further swap is needed.
>>    */
>>   typedef struct {
>>       enum qemu_plugin_mem_value_type type;
>> @@ -682,7 +683,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
>>    * qemu_plugin_mem_get_value() - return last value loaded/stored
>>    * @info: opaque memory transaction handle
>>    *
>> - * Returns: memory value
>> + * Returns: memory value in host-endian order (no further swap is necessary).
>>    */
>>   QEMU_PLUGIN_API
>>   qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t info);
> 
> I'd be tempted to fold this into the change that makes it happen in 1/3.
> 

It was already supposed to be the behavior (x64 host did the right thing 
by accident since it skips swap operation and rely on moveb), and other 
host architectures had a bug that went unnoticed until recently.

Regards,
Pierrick


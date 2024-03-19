Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D32C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgw8-0005uT-Gx; Tue, 19 Mar 2024 17:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgw7-0005uK-TF
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:23:55 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmgw5-0001Nk-Fk
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:23:54 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so1987725a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710883432; x=1711488232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbS8kPywRHQkQaOR5Q3Njr2Z7CBXzgrVkCPiIEwnsgw=;
 b=anDmaHfS0AQYNeKPdVPp4tQWKLQYLB5umD7Yk72g8bMxI8mqucpoxOWHaWPK73U58m
 1ER1T94z5cpGHBOegNakee4lDChx8rYaqGoTjTVJ2yl4E9s6UvH7T6a40+DvxcZoSTDb
 EkZHu8VW5oc+7muTMvgsbqmOiHmoKL0lG/x48OfBG2fid3DutOldTjZKbRG3+ZS1yOJS
 Thl7GAmge96NlT4zjo4oTsSip7iMCiuhe7KE+8w0UlJD2yH8ra3jBl9sauuFFBexSvJD
 Piis18rdzflDnFa6HP+JLUSHgxntUtygkMQMVeFq+qqIuSCBpND092T2VNjJfrzPlqzz
 GZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710883432; x=1711488232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbS8kPywRHQkQaOR5Q3Njr2Z7CBXzgrVkCPiIEwnsgw=;
 b=MJBO1N0URrDz/ewP6XqAyZqumC58jSYXZY/POZie+fCkK0xuZGKwdKalRWtjb/C3zi
 PQSoT7JLI9jn1XcWJeoXBnfr0tClJedmEHMBjyMl5BdbfWDjt2KUgszN+E8G5YPdMZyQ
 CaRbCHZXB/skg5K1G8Y/tRCUGIXI4AzFbaRcWrHs+Q0poCIPc6dpBspzUp39qyEwQLWd
 2/Wwy0hTRgE8GUMwxlEc80Xc1mLo+lCbAUDW9rbqzgV0iVwUXD9JZoQlBw19Ft6cBsMx
 7ag7L+ADifZLZyJRM9VcVf98g01l2w2BO9FSnWetjkcjEKGR5wxu0uubkUOCOlVipkB5
 M/HQ==
X-Gm-Message-State: AOJu0YznuoZC9gyUP33JOzqPHWXisvzgi5qCvqeVZ41AYHYVDvOOsvY/
 D6rus+GeGSSxZ1R466t/NfogPAdemqQT2HONKTyDMHvVDJCLBCaESVQbuHJ/uOw=
X-Google-Smtp-Source: AGHT+IGPTE/ilDYal19v6ndiN3L6kZ8Y3rbckTaNjb/ubLUYvEh9GicssGTs++ACK/yoE21YP7KxJA==
X-Received: by 2002:a17:90b:314e:b0:29f:be68:5cf6 with SMTP id
 ip14-20020a17090b314e00b0029fbe685cf6mr4604854pjb.12.1710883431708; 
 Tue, 19 Mar 2024 14:23:51 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 sn3-20020a17090b2e8300b0029fefd2df97sm13352pjb.32.2024.03.19.14.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 14:23:51 -0700 (PDT)
Message-ID: <0ba7a725-ca38-4180-a25d-7d6267dd3819@linaro.org>
Date: Tue, 19 Mar 2024 11:23:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] tcg: Add TCGContext.emit_before_op
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-2-richard.henderson@linaro.org>
 <871q865ndw.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <871q865ndw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 3/19/24 04:04, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Allow operations to be emitted via normal expanders
>> into the middle of the opcode stream.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg.h |  1 +
>>   tcg/tcg.c         | 14 ++++++++++++--
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
>> index 451f3fec41..e9d05f40b0 100644
>> --- a/include/tcg/tcg.h
>> +++ b/include/tcg/tcg.h
>> @@ -552,6 +552,7 @@ struct TCGContext {
>>   
>>       QTAILQ_HEAD(, TCGOp) ops, free_ops;
>>       QSIMPLEQ_HEAD(, TCGLabel) labels;
>> +    TCGOp *emit_before_op;
> 
> Could we add some kdoc comments to the TCGContext describing what each
> variables is for. Is this just a list of ops to emit before the current
> instruction emulation? Is it cleared between instruction boundaries?

It's not a list, it's an insertion point.
Nothing automatic about it; manually controlled by plugin-gen.c.
(I believe it will be useful for cleanup in tcg/optimize.c as well.)


r~



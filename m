Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6F3C25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJnT-0007lO-7A; Sun, 26 May 2024 15:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJnR-0007XB-Oa
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:44:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJnP-0007wC-KO
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:44:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8e9878514so2009581b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752682; x=1717357482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5MQNqz5RGi7F65bnPi1uv+YvAT96M9RHvewQHAatV0=;
 b=D8lT90O4BxNnNPZs8e2yw5rlYZYLlCV4fnRhwAXUSNcPMgmOrfOZZQ4gxTQ3sZGQX3
 dB4AQyE0/CkWgvxJYSGd5ByGPrqSozZPQEZdU9lISPL0Yd0mnSC34D6e0HuX3gTiL4T8
 +AWNvv8csTOFYkEvIGyuNP6ykJK+TPkhHgiAK4CM5UUHTvCdHT/Cx+RmPGFSAlYwD4vj
 1S/wvCDOkRgyQtB+pk/Hanr6Xn8g23UAdLqLNtkq4YFdp+1xWkDsOJ36qPisczxhDebC
 rIxcPYNV7Xeaxadi7QLk45J7VpGZLL9v9Hmtri1/n2cbnVcUtEYoSDDGZzJS/Q/VjnP9
 FRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752682; x=1717357482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b5MQNqz5RGi7F65bnPi1uv+YvAT96M9RHvewQHAatV0=;
 b=Fd3jv0WJikqtaRJp3Gb3/GOYKWZCC4BwmRbbisrv472lxRX9GA0WB/t6QHmA1BCwna
 AVZT0i8uHUogBqJe+6U0DPl/1Bbm5MK+wAsyagAAwoOzT3iRAs1i1ryZ4kXTeEpwNZgH
 V0IndSsc48AFQ1L9Tuy3WNCwfZzkd0EtZXHIx/VQJnQD2aZr6bPXVJSovwHuDxWoPfG/
 mHxbcmjPaz8qKID0IBg3GSTlMopx67Un+0Dd5435P9cC596uB16iTmFBtrMgqWu+VLQJ
 Q9tIPzegxxax5+ZZpF8g+chaQpV/IxNBcFc2ZZ+H5ssetkPRSpEgGqWWKzRi9AvqTPmf
 1MWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWrH1N2qKArLllXE4J6u4JA0XdQ4GD86GzJBsmQM6g4lfTEDfic8xfJFqWVuQH0+TWlj1G9QTQRpfO1rw46xZbAKTb6JU=
X-Gm-Message-State: AOJu0YzZu+ioLwd90Q7tWKkRgMovDgAUrQoKSvXwKs/+qRG3HIdAQNxi
 J8Fsqhfeif+2yyrdjb5bzoF7iqL1hLVaDKLvF1MisReutWgGR0u/Vn0Evs0cffk=
X-Google-Smtp-Source: AGHT+IHX9jjf2Wt37FdhMCg6DEyhs2k3IrLo0iMpQ/VWh4U2qx35CCZyUJFUV9gXzSBJ05gjc4+usw==
X-Received: by 2002:a05:6a20:96c1:b0:1af:f38e:85e with SMTP id
 adf61e73a8af0-1b212dfe7famr6753033637.45.1716752682023; 
 Sun, 26 May 2024 12:44:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe64e0sm3754911b3a.160.2024.05.26.12.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 12:44:41 -0700 (PDT)
Message-ID: <10e876de-b973-4016-9155-960383d46297@linaro.org>
Date: Sun, 26 May 2024 12:44:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
To: David Hildenbrand <david@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-s390x@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-2-npiggin@gmail.com>
 <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/26/24 08:53, David Hildenbrand wrote:
> Am 25.05.24 um 15:12 schrieb Nicholas Piggin:
>> The flic pending state is not migrated, so if the machine is migrated
>> while an interrupt is pending, it can be lost. This shows up in
>> qtest migration test, an extint is pending (due to console writes?)
>> and the CPU waits via s390_cpu_set_psw and expects the interrupt to
>> wake it. However when the flic pending state is lost, s390_cpu_has_int
>> returns false, so s390_cpu_exec_interrupt falls through to halting
>> again.
>>
>> Fix this by migrating pending. This prevents the qtest from hanging.
>> Does service_param need to be migrated? Or the IO lists?
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/intc/s390_flic.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index 6771645699..b70cf2295a 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -369,6 +369,7 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT8(simm, QEMUS390FLICState),
>>           VMSTATE_UINT8(nimm, QEMUS390FLICState),
>> +        VMSTATE_UINT32(pending, QEMUS390FLICState),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> 
> Likely you have to handle this using QEMU compat machines.

Well, since existing migration is broken, I don't think you have to preserve 
compatibility.  But you do have to bump the version number.


r~



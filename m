Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4154BC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 19:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvM8C-00086Z-FE; Fri, 12 Apr 2024 15:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM83-000863-28
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 15:00:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvM80-0003LT-DE
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 15:00:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed054f282aso1050486b3a.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712948398; x=1713553198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t/k0TNiHldkMmv37B0HHpihpSzZ1wa+uIG/r15WdVz8=;
 b=wlwWykQTQXIpZD0w2e3GYeZu7kO44RXOX5i9LUmXqj0CcuIAzOMYAQQqzhNvqAipvR
 eUVcGGHzZzHzTjfzTfxF+ARsMUOLoNukmyUZB6teriF+ANBX+mlwz9PJkQDWAXReM9tg
 ziaxI1MAjCPpt/LuFL02Lz9AePGoq69+hkEZYLykZStbmiWb3fx9MGittruTbBSyPw44
 Ds2Tsf3OPkCvN3EfPb2JY338nXToMP2ElF5VdbV1f66EsRVHhu/ipyXg810qUpBra/jB
 b8jpfkmdjDqKetypiaoPuBucEj7e1t6B6s8WR5kJ+2UuYIkbCW0SjVMTVUl1UUS897wQ
 Xinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712948398; x=1713553198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t/k0TNiHldkMmv37B0HHpihpSzZ1wa+uIG/r15WdVz8=;
 b=RHl7ReHFSUlhlIrv7GmGG79JJ9njctpIIuei/hofEw9s9Q65rsTigA1vgpDA+ABnkS
 UPo+J+NPmm3WqUaNER2BL/gAoAjacpkVFZ9x2v7LLti6QBEMJ6hlIe20/fK89U0wAGZ+
 phLeTveNz6RcJP7Z96cWroHBvrDwe21a+H0gZEkmncjXejK7pLsh0DJVwcNReUeflw5C
 1M61p/Hqjs9y8TQ0ZffrJ2UMFLNbzmz2l4vNSBKV+g7DFU+Vy9pa7Xy/wFWC3xZWmHGh
 lX9z7jaP5alFxWNAiYK6j50ypeplMUZh1GgNQKTy6IJ7fldvbFfP2Z3EY7ldukOlna4W
 lHBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqndzqs4/mIyG8gP2+PEGsBYILsMMpfAP0R0uMpciLlWY89vp0tBJeiX5KNP4tOHkyLbvTMiI3sNWPYWB+8aMX0WbJs/g=
X-Gm-Message-State: AOJu0YwAQct7Y+M3K3+EhAsB5G3bOhHcfhrdBIQYdO+KbB+OIch6UhV8
 y0f+leRCfJ/ccCiPRa7Pfgzbg3Ip6Sgm79oiyqsy9v/AzZ6Qd5K3rWS/2JyZee9cakXkfTW1SvU
 G
X-Google-Smtp-Source: AGHT+IEpUxOSFDpy67a+kXTpUr/yU7xbhL457tCHnwnoGoV1y447L/nrcFyg8QtqP4jo7cexhQuicA==
X-Received: by 2002:a05:6a20:3251:b0:1a7:5614:a8a0 with SMTP id
 hm17-20020a056a20325100b001a75614a8a0mr3699578pzc.44.1712948398551; 
 Fri, 12 Apr 2024 11:59:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a056a004f4b00b006e6529c7d75sm3216351pfb.3.2024.04.12.11.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 11:59:58 -0700 (PDT)
Message-ID: <738c7ce6-7c09-45fd-ba00-d3f74e1812b2@linaro.org>
Date: Fri, 12 Apr 2024 11:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] util/hexdump: Use a GString for qemu_hexdump_line
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-4-richard.henderson@linaro.org>
 <698cc16f-cfb4-47a8-86fe-e4c8a6faecb6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <698cc16f-cfb4-47a8-86fe-e4c8a6faecb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/12/24 10:41, Philippe Mathieu-Daudé wrote:
>> -void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
>> +GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
>>   {
>> -    const char *buf = bufptr;
>> -    int i, c;
>> +    const uint8_t *buf = vbuf;
>> +    size_t i;
>> -    if (len > QEMU_HEXDUMP_LINE_BYTES) {
>> -        len = QEMU_HEXDUMP_LINE_BYTES;
>> +    if (str == NULL) {
>> +        /* Estimate the length of the output to avoid reallocs. */
>> +        i = len * 3 + len / 4;
>> +        str = g_string_sized_new(i + 1);
>>       }
> 
> [*]
>           else {
>             g_string_truncate(str, 0);
>           }
> 
...
>> @@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
>>       *line = '\0';
>>   }
>> +#define QEMU_HEXDUMP_LINE_BYTES 16
>>   #define QEMU_HEXDUMP_LINE_WIDTH \
>>       (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
>>   void qemu_hexdump(FILE *fp, const char *prefix,
>>                     const void *bufptr, size_t size)
>>   {
>> -    char line[QEMU_HEXDUMP_LINE_LEN];
>> +    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
>>       char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
>>       size_t b, len;
>>       for (b = 0; b < size; b += len) {
>>           len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
>> -        qemu_hexdump_line(line, bufptr + b, len);
>> +        g_string_truncate(str, 0);
> 
> Shouldn't we truncate in [*] ?

The usage in tpm puts several lines together in one string,
adding \n in between, for output in one go.


r~



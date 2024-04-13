Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B911FC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 09:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvZwv-0000p0-1U; Sat, 13 Apr 2024 05:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvZwq-0000oj-Dw
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 05:45:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvZwo-0002EP-8j
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 05:45:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so1271819f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713001520; x=1713606320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8lQyvOIXIQtSSJ1mj11GqLV9b0OUGzRHH59YmkPn8g=;
 b=lgSi4PE2I9MNrHbphfVYN4maveCVRD8xeeBovDg6gJuTKqo4gMvgbe4/T1wF/WdZto
 rn2rWjaSm6Bgp07RB9ZsQRZm4O3tIwO/ji85FpoUijYJJhaydf77uUlMFaN6Pke/01ms
 kzYcatn0CNaF8rpsD0gyi44qTtN5dAOqdOdLRu83jPhyGaDsjIQp+9/ObQf0ynkhg9QX
 4ccRVc3IPjbG1rHbWdtKxWGzQO7anDWwrZ6MFkqavRazhQq7GqvhqotCRyP+3nsTBkp4
 87j3BYLG0zRQHUO319QvCLdDWVjv4LT+F0Ox3Tary0USYCjv1GMV0OdA9OqNcIAERu6j
 kvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713001520; x=1713606320;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T8lQyvOIXIQtSSJ1mj11GqLV9b0OUGzRHH59YmkPn8g=;
 b=elGQDNUPM7l2degLCxl//KAzGiQyYSvpLnJHWtV4s/bqiDvmrQKCsB81+2wLjffFKY
 g+amDDedkdEj11s45c3lW395TGFTKuheCZi84HtCmFGwddoxt26tgAY4g3JckhtmSWuz
 SPMlQ27Qrr9acR3ymT8AGxjweoKwgR+W623ARwT9DxZCmtJ8qECe5ygO0T+06kqPXfFR
 E5K0XKEmSHMx8ySWuoOcK5bM1RA9aCo6GdeJEaxIfJsewuV9PhRSmt+fPiv1fjQ9ojqo
 BWKpmVXN5kbqtTN77D41rOvEvE5Q5VyjA0mDn33SexsVtjA/7b+6JQE3chfTo5iVx/Rx
 4CbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiyHx7w5HfswFwQXolNOr1GBgbL7Ed05J68i3UsadixHCZrcf8bcqT7Taf3XaO93f8WzIaUAoyBiJe/1a5Q7X/lia04T8=
X-Gm-Message-State: AOJu0YxmLyYrEyeH87xa+HRTCKa08qe2Vhdw4nxBBYiOQIrblnZWpOEy
 ZPLgR4ooAT9dY6BnBBR/8WE+Pw3bMiH836/RB0g9wKPMqQXcz1UMqqp+eL/ukkklWRwEoi3FPbr
 P
X-Google-Smtp-Source: AGHT+IGZyf4V2FQ4ge7JTXio3xtbJTrt+rCJBcdMwFn6q8k89WmOg3KQXHzViJyw6xgI5JqjYZjiWA==
X-Received: by 2002:a5d:5908:0:b0:345:fa50:ba8e with SMTP id
 v8-20020a5d5908000000b00345fa50ba8emr2991494wrd.37.1713001520579; 
 Sat, 13 Apr 2024 02:45:20 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 j18-20020a5d6052000000b00343d1d09550sm6191097wrt.60.2024.04.13.02.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 02:45:19 -0700 (PDT)
Message-ID: <41518f9c-2e29-4d24-806e-b89e5d4ab278@linaro.org>
Date: Sat, 13 Apr 2024 11:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] util/hexdump: Use a GString for qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-4-richard.henderson@linaro.org>
 <698cc16f-cfb4-47a8-86fe-e4c8a6faecb6@linaro.org>
 <738c7ce6-7c09-45fd-ba00-d3f74e1812b2@linaro.org>
Content-Language: en-US
Cc: Stefan Hajnoczi <stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <738c7ce6-7c09-45fd-ba00-d3f74e1812b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 12/4/24 20:59, Richard Henderson wrote:
> On 4/12/24 10:41, Philippe Mathieu-Daudé wrote:
>>> -void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
>>> +GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
>>>   {
>>> -    const char *buf = bufptr;
>>> -    int i, c;
>>> +    const uint8_t *buf = vbuf;
>>> +    size_t i;
>>> -    if (len > QEMU_HEXDUMP_LINE_BYTES) {
>>> -        len = QEMU_HEXDUMP_LINE_BYTES;
>>> +    if (str == NULL) {
>>> +        /* Estimate the length of the output to avoid reallocs. */
>>> +        i = len * 3 + len / 4;
>>> +        str = g_string_sized_new(i + 1);
>>>       }
>>
>> [*]
>>           else {
>>             g_string_truncate(str, 0);
>>           }
>>
> ...
>>> @@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void 
>>> *bufptr, size_t len)
>>>       *line = '\0';
>>>   }
>>> +#define QEMU_HEXDUMP_LINE_BYTES 16
>>>   #define QEMU_HEXDUMP_LINE_WIDTH \
>>>       (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
>>>   void qemu_hexdump(FILE *fp, const char *prefix,
>>>                     const void *bufptr, size_t size)
>>>   {
>>> -    char line[QEMU_HEXDUMP_LINE_LEN];
>>> +    g_autoptr(GString) str = 
>>> g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
>>>       char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
>>>       size_t b, len;
>>>       for (b = 0; b < size; b += len) {
>>>           len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
>>> -        qemu_hexdump_line(line, bufptr + b, len);
>>> +        g_string_truncate(str, 0);
>>
>> Shouldn't we truncate in [*] ?
> 
> The usage in tpm puts several lines together in one string,
> adding \n in between, for output in one go.

I see the trace_tpm_util_show_buffer() call. However this
isn't a recommended use of the tracing API (Cc'ing Stefan).
It breaks the "log" backend output, and is sub-optimal for
all other backends.

IMHO the TPM buffer should be traced by multiple calls of
(offset, hexbuf) instead.

Regards,

Phil.


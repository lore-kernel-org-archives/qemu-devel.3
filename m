Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26589D29C50
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhu8j-0006hv-6l; Mon, 19 Jan 2026 13:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhu8c-0006ew-RO
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:38:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhu8a-000342-Tt
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:38:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so4214829f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768847883; x=1769452683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vvAa72HCui2qh4jjkzSYOddRiUrfbhguBCMPxAeHkEM=;
 b=U7X3mcm7htUJ03lFYcmd5xn1f+ElgMYeS//yBVUl49p+z32tTdATYAfshFp6XLEgpw
 8WE8JiebPuoTPygPKtiZYxERZcnHpTUC4+aC4SYT6lgaSjHuzf7olBGZ9nyGi0O0gdvP
 nMve6/KUYdAP2gaB2RpMSLteppJ7JoPfKkvv67U9584lWLDqub0g9m6mpopvN+0pj9Uc
 dR/zQ1O2OC3ksw/F1vnEQ89e/CFvKenH9CLbNcRcx1ZvPXQAWak1w/nurC0VyRDlFcCf
 wfMGqqWuDSlN9Q3LPD6DU7mtBBi/Eoc7Aago8nCkRon4amTg/0UVQIKZ8hhFXMh4rhIr
 ogjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768847883; x=1769452683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvAa72HCui2qh4jjkzSYOddRiUrfbhguBCMPxAeHkEM=;
 b=L1Q4lI2w/z/d+5jbdutQjzVouQ0aNIKX9A5RPqZ7KjWYLVPeuc9ZZIDMlqPLX53XhX
 UWcB8Zn98absr60sNqEE7bYBon4TUU3flZ4nB9c1eBgQb5w3ipjvRmL11keFDfZdD/Eq
 uwuiXEIGz08UKZTdJNgyTQibCBL0qnr2kpVtip0ZlTLwXChB6Pl3trmuyrDcMkHAOwtR
 yYuQjILow5myBurPpF2bjgfSQVEIlLFbAtsyieGndk1Za8VDt6h6oDO2QuigkJczUsJR
 bgJqPzEdqvPi6MYE9G1mxnB8tSibV7mZLsWoUyQw2Fvm4q1EwITeeyiIWQAJrgF0X3Av
 VDWA==
X-Gm-Message-State: AOJu0YwQpbf/LQ8ZCcEe1k08brKEqmK06NE8UD4JWd5Fg8/59Rh4vLT0
 BA8Fw/rEGOfMsUxFwuxUXjN+UHV7OM+JaGhrjoiEwPpVYILa5pCR2kFXMzSr0oURGYw=
X-Gm-Gg: AZuq6aJ/ZOnvZpUwG4ZXQghkhK1QOl40JoXJFLNTIBjmdV/JGPt00LDnjpBKxcRzAam
 eYU/RHoipPunKnY0PcUYQ2Cy46D8p5dqdqLsB8KFFl2amsJBD8BWqIVwdmDCXwpH/45q/sthbnb
 sW2eMenzuXMSih+imTvHSCCKwQZHG4Me62lYRS4BuKGoYd8NYfOaeogcEACrcqZlVFW8cqDH5zi
 xxqYv2w7pix3lzmBJAXxR8CYkHKZJswuRrkFQ24q5AUWpfWtJqH39n2TPq6Kc1g1/frSPLgbWKh
 bqUIygH9vNl3DLd0LsVJ0u0dSdNNAVrGnxPDGgQi8xI0MpRNI/N/hAI09RBgdwVK/siHlwceyiI
 ykgp9K9aQjS8htcZGbZS92qMTJVK+GW6qi5LtQ1Iw5/ce+i180xyv+HloQprycLtna8805isYz8
 ecLjtnT3feWcb4pqOhMQr/HTd20J8zIiiqsiWqKvD42RYl0dwxEzjmz2SYEVD84gyK
X-Received: by 2002:a05:6000:24c6:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-43569980c46mr16471550f8f.24.1768847882543; 
 Mon, 19 Jan 2026 10:38:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm25553806f8f.10.2026.01.19.10.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 10:38:02 -0800 (PST)
Message-ID: <0a7dfd69-26df-407e-a8cb-543dcefab685@linaro.org>
Date: Mon, 19 Jan 2026 19:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
 <8259d920-32bc-41a7-94b9-cd1af9783b6e@yandex-team.ru>
 <05340117-a75b-4d64-98fe-8868b7bfb5c5@linaro.org>
 <1192488b-51d9-4024-8f76-3b2dd85b3d3c@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1192488b-51d9-4024-8f76-3b2dd85b3d3c@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 19/1/26 18:26, Vladimir Sementsov-Ogievskiy wrote:
> On 19.01.26 19:31, Philippe Mathieu-Daudé wrote:
>> On 19/1/26 16:42, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi! Isn't this patch lost?
>>>
>>> On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
>>>> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Test, that fix in previous commit make sense.
>>>>>
>>>>> To not break compilation when we build without
>>>>> 'block', move hexdump.c out of "if have_block"
>>>>> in meson.build.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex- 
>>>>> team.ru>
>>>>> ---
>>>>>
>>>>> v3: change meson.build to compile hexdump.c always
>>>>>
>>>>>   tests/unit/test-cutils.c | 43 +++++++++++++++++++++++++++++++++++ 
>>>>> +++++
>>>>>   util/meson.build         |  2 +-
>>>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>>>> index 227acc5995..24fef16a7f 100644
>>>>> --- a/tests/unit/test-cutils.c
>>>>> +++ b/tests/unit/test-cutils.c
>>>>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>>>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>>>>   }
>>>>> +static void test_qemu_hexdump_alignment(void)
>>>>> +{
>>>>> +    /*
>>>>> +     * Test that ASCII part is properly aligned for incomplete lines.
>>>>> +     * This test catches the bug that was fixed in previous commit
>>>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>>>> +     *
>>>>> +     * We use data that is not aligned to 16 bytes, so last line
>>>>> +     * is incomplete.
>>>>> +     */
>>>>> +    const uint8_t data[] = {
>>>>> +        /* First line: 16 bytes */
>>>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello 
>>>>> Wo" */
>>>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! 
>>>>> Thi" */
>>>>> +        /* Second line: 5 bytes (incomplete) */
>>>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is 
>>>>> " */
>>>>> +    };
>>>>> +    char *output = NULL;
>>>>> +    size_t size;
>>>>> +    FILE *stream = open_memstream(&output, &size);
>>>>> +
>>>>> +    g_assert_nonnull(stream);
>>>>> +
>>>>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>>>>> +    fclose(stream);
>>>>> +
>>>>> +    g_assert_nonnull(output);
>>>>> +
>>>>> +    /* We expect proper alignment of "s is" part on the second 
>>>>> line */
>>>>> +    const char *expected =
>>>>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 
>>>>> 68 69   Hello World! Thi\n"
>>>>> +        "test: 0010: 73 20 69 73 
>>>>> 20                                      s is \n";
>>>>
>>>> Thanks, queued wrapping the long lines to pass checkpatch.pl,
>>>> as in:
>>>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- 
>>>> philmd@linaro.org/
>>
>> I have it tagged but there is still a meson issue. I should revisit
>> but it is low in my priority queue.

Found it, see that pipeline:
https://gitlab.com/philmd/qemu/-/pipelines/2238533614

configuring with:  '../configure' ... '--disable-system'
...
FAILED: tests/unit/test-cutils
/usr/bin/ld: tests/unit/test-cutils.p/test-cutils.c.o: in function 
`test_qemu_hexdump_alignment':
test-cutils.c:(.text+0x71): undefined reference to `qemu_hexdump'
collect2: error: ld returned 1 exit status



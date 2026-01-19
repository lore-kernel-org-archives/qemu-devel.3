Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0CBD29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuw8-0000An-Je; Mon, 19 Jan 2026 14:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhuw4-000068-4Y
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:29:13 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhuw2-0004Ox-2P
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:29:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso2916557f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768850948; x=1769455748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZRoVmET53lUMHQew4L6Cg5SpHVi/7gSxtz1ilje+48w=;
 b=mPy3ttUZk7pABXo96+6G47bkCZDbWTVAzpWou2mMrvxl6vOYzeqt1AsISkpvRXGTc5
 ROBjMsYPoFZSJd+sXqoYQLM5p5MeEAr7qcs8wQtQ/i3dMIEPuXbjSmTIY9rsiEEHmlyM
 ddKWmC9TMDdViPN9c1lXx3knLwHxFHfBE51AqBfB/j0U+QvaYlrByHPBMAufQSICl6oz
 DVWF86kvu6uHMhSh2FoDNhAxi4FJQHSSdYzBELmdTTZphU3kWMaWrUvQqPAeQ9X8gTRW
 SOsBflAtMTjMxeospDOq0kvwnfbPa73iXxNi3c7d796s2OzgEYQ6q4MPh9QCz1nkrL89
 +Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768850948; x=1769455748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRoVmET53lUMHQew4L6Cg5SpHVi/7gSxtz1ilje+48w=;
 b=eECR7pwbNJ/qoDf4vJj6Sv8l6bncs50A3kKJAb4E44hnLz/Qd5Xb6i43gwoEpexvk5
 bNbGA9K6Yg+pfCeAsp3y0CSNHENDSt1suZYpFQ1NX/UgkdplFyL3Mia2kIC0ekYckY/v
 Vm2Djr15PPDtk4eGAs+VjCkJFFJYRMjPSEOGBw2yLzo0nXSO89fCqFt4YrPfjoD5uYTk
 vmfzcECi9TSote5BaOBV7wReaLSzEdbubv9p+rLfhcKEb9oMuNgK7QkZ4xDuUhqijYwj
 HP6Nt/9y3ncyuQyq7yU7SGQbQixYmf1gSNHXr9mMCvQfSgsmAiKetScarlgldIB9wbKj
 521A==
X-Gm-Message-State: AOJu0YzYmjSM8lPIFiGLHv+tsvV4eU6L0c3NXaRWImkB92K/9IBlSpu0
 JksjmNibc4Wsf2qJdA/skxj+6m/+OQn8hYNyztoh94iN8rkDEB0vbW5GAfO3kt+ElZQ=
X-Gm-Gg: AZuq6aKj6S6d+ZuZ8yAzdHBAAKbIY7fPQyiXBdX5HQ2MTT9J30KqK7V9WWc19FwCzfF
 FLP0yJU0bVxyzpeMBh7IaqDzYrg5SWgbqTWbfM4WPCgw3yzRCBkXOD9hRpSnvzIljbUGWATzgK0
 Cc80nU3dk54T5ZmH1PRi9pdtULrMjr5CKIvxFMQGZJoCUHH+uZH5POZk+mQ8cii8gSTkSKuc0Gw
 SlqRxOOsAapFs7+nmsZGEmDfGAWIDfhDxeJNGagWitoQRY0ih10o5odeaX9+rpWjGV4eykHxRV8
 jFpqmHqQd57Vr/+lKp7KyDrrkj4Zs2dOtE2p1K+g1GfzoUtyuh5EQUhAU+MK+/5C56f5vRimpWO
 UpNkKhJMkWl5J3aRf6elD86nEZQaQX/MdZsTbrVP4ZEg3bVVJnhvBt0XWRuWkLVGRZN/I0Umv8v
 +gwCa4TMmq9yKnrSo1EVbc4KYZOvrdx37g6OOn+rTSN52HCR4MFbRRlB/OzqGrFSez
X-Received: by 2002:a05:6000:4021:b0:431:488:b9a8 with SMTP id
 ffacd0b85a97d-4356a05373dmr15576828f8f.33.1768850947669; 
 Mon, 19 Jan 2026 11:29:07 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm25875301f8f.6.2026.01.19.11.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 11:29:07 -0800 (PST)
Message-ID: <e0a6625d-1b3d-4fd8-90d8-8bb996e2f259@linaro.org>
Date: Mon, 19 Jan 2026 20:29:06 +0100
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
 <0a7dfd69-26df-407e-a8cb-543dcefab685@linaro.org>
 <db1f4846-afef-42f5-9181-9c25406be863@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <db1f4846-afef-42f5-9181-9c25406be863@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 19/1/26 20:18, Vladimir Sementsov-Ogievskiy wrote:
> On 19.01.26 21:38, Philippe Mathieu-Daudé wrote:
>> On 19/1/26 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>> On 19.01.26 19:31, Philippe Mathieu-Daudé wrote:
>>>> On 19/1/26 16:42, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi! Isn't this patch lost?
>>>>>
>>>>> On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
>>>>>> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Test, that fix in previous commit make sense.
>>>>>>>
>>>>>>> To not break compilation when we build without
>>>>>>> 'block', move hexdump.c out of "if have_block"
>>>>>>> in meson.build.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex- 
>>>>>>> team.ru>
>>>>>>> ---
>>>>>>>
>>>>>>> v3: change meson.build to compile hexdump.c always
>>>>>>>
>>>>>>>   tests/unit/test-cutils.c | 43 +++++++++++++++++++++++++++++++++ 
>>>>>>> ++ +++++
>>>>>>>   util/meson.build         |  2 +-
>>>>>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>>>>>> index 227acc5995..24fef16a7f 100644
>>>>>>> --- a/tests/unit/test-cutils.c
>>>>>>> +++ b/tests/unit/test-cutils.c
>>>>>>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>>>>>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>>>>>>   }
>>>>>>> +static void test_qemu_hexdump_alignment(void)
>>>>>>> +{
>>>>>>> +    /*
>>>>>>> +     * Test that ASCII part is properly aligned for incomplete 
>>>>>>> lines.
>>>>>>> +     * This test catches the bug that was fixed in previous commit
>>>>>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>>>>>> +     *
>>>>>>> +     * We use data that is not aligned to 16 bytes, so last line
>>>>>>> +     * is incomplete.
>>>>>>> +     */
>>>>>>> +    const uint8_t data[] = {
>>>>>>> +        /* First line: 16 bytes */
>>>>>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* 
>>>>>>> "Hello Wo" */
>>>>>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* 
>>>>>>> "rld! Thi" */
>>>>>>> +        /* Second line: 5 bytes (incomplete) */
>>>>>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s 
>>>>>>> is " */
>>>>>>> +    };
>>>>>>> +    char *output = NULL;
>>>>>>> +    size_t size;
>>>>>>> +    FILE *stream = open_memstream(&output, &size);
>>>>>>> +
>>>>>>> +    g_assert_nonnull(stream);
>>>>>>> +
>>>>>>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>>>>>>> +    fclose(stream);
>>>>>>> +
>>>>>>> +    g_assert_nonnull(output);
>>>>>>> +
>>>>>>> +    /* We expect proper alignment of "s is" part on the second 
>>>>>>> line */
>>>>>>> +    const char *expected =
>>>>>>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 
>>>>>>> 54 68 69   Hello World! Thi\n"
>>>>>>> +        "test: 0010: 73 20 69 73 
>>>>>>> 20                                      s is \n";
>>>>>>
>>>>>> Thanks, queued wrapping the long lines to pass checkpatch.pl,
>>>>>> as in:
>>>>>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- 
>>>>>> philmd@linaro.org/
>>>>
>>>> I have it tagged but there is still a meson issue. I should revisit
>>>> but it is low in my priority queue.
>>
>> Found it, see that pipeline:
>> https://gitlab.com/philmd/qemu/-/pipelines/2238533614
> 
> This build contains previous version of the patch. v3 should fix it.

Doh sorry, maybe I tested v2 then, I don't remember :(

> 
>>
>> configuring with:  '../configure' ... '--disable-system'
>> ...
>> FAILED: tests/unit/test-cutils
>> /usr/bin/ld: tests/unit/test-cutils.p/test-cutils.c.o: in function 
>> `test_qemu_hexdump_alignment':
>> test-cutils.c:(.text+0x71): undefined reference to `qemu_hexdump'
>> collect2: error: ld returned 1 exit status
>>
> 
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE39CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEkr-0002B2-4i; Tue, 20 Jan 2026 11:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viEkl-00026V-L9
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:38:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viEkj-0004CC-O1
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:38:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-435903c4040so517157f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768927126; x=1769531926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOQpS+7kpDE2DLN2Ov3GqiaZO45MI7IaTtWQAR7z5W8=;
 b=cRAYHxWe+BG159rMkqtrlN1b+RFEPYabX8ZbwXVkhDIZZPxy1u41wvieaNIvYpHCLi
 1EvUE574LMUPJfNgUZ38JKDdW81Hn4iv2sV5yIWYnzFj7pYQv45ijdmCG8WA/u55luEO
 mNU0BU0+jyBtHC9jJraSPGk45oWRU1rZZXlzk9PKy/jxl60jLtBbdMvF1O4hBfIsFfY+
 J5W1XjfJhmypsvabZfPEPchSgdkpiSZjPkzA1V2r+4MaTBTmPgGn8eFPcMFeKiVcFnWy
 muSKe25EHXhMvoj1j8PwDftYqti2c1YUGVgRIUHcBf9xqc7sQkzjSX+4KvOnwRvk04mz
 mzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927126; x=1769531926;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IOQpS+7kpDE2DLN2Ov3GqiaZO45MI7IaTtWQAR7z5W8=;
 b=fJNzxi0oLYb9C1UOhq3xhwih65FrH0Con/6ZOdIucenUKZoLXByA6M+diTAtPY7/Ej
 Of7d5gbOem760Tnx6D5AoURpmynr70BP+6XPg8dYW7IsmlVLIWnKAqn1DSczAg6WYp6B
 ZbYiwot+LATugZRetBlbN7vM77yFb8lPju1iTH55XJtLF55jqEwL0SU41Hs2knyKYoLc
 kADSB+7nLMekATBMRMjpAVvczEdn+dYVmgP96l7jbhino2EaFhyIy1ejC0KaGqwc6WUg
 f7FGtHHByZ6aehXB1xMDISHNuBqVZX5h0gHrBKw4Yv/uV6qsyobxfEZyapwaPvRUgk4P
 7SFw==
X-Gm-Message-State: AOJu0YwDFBT+sg/YjYznLMPalHywFbMD7F32Ods0xj/BJPGqNVNUa0ek
 ZDsj+IlVc2owwKuWwx7dWE691WNSCNNKhO83yxRNXESArWl3XPByTNmqjMR4D0T1hTY=
X-Gm-Gg: AZuq6aJ1saghWmg4n8CN2r7ShdpUXaBkcFOP6W1E7SGIfzdH58VCcoTDlBzlSPz7FkM
 2hLJgLK1dOzOgQFiYg1C41jXKcNOBelDCiwjgkV2p+eXRIRALV1Z5DVUxPuFK2QgzNFTY0Ld2tq
 dG1ECeXEaX6BozktsM/00EYDVjkATGiBseAk7MJSJvsfTUf1jvVlON94lTNhydvtA8wSA2FG8j5
 AN6ji+19Xf0qaz6boHmikVT8gzrvgI3maelMYSzPC2LH+9xgfQaF871BeMXi56UAbyeiOIDm+L+
 BhyOk0gpebEGQRwoR+rAPwZlCBpCKc3w6KqxllK7ywOkL0+b7O/gXwyEBQswD9PmDOa3gLhyXx3
 so6SyqhFzjjoEuUrBWdL2eexGYoJno2wKFfZN7muDAb+x6UrwniyvkPGh7LwnetDhMEJr9Qya+l
 Tv6wBYjilSdSmLWw0E9LwNMYU/nuT9fBpzIUReTswKhy3FlQYvXJiS0Q==
X-Received: by 2002:a05:6000:288c:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-4356a02c594mr19440339f8f.14.1768927126355; 
 Tue, 20 Jan 2026 08:38:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597719d1fsm703550f8f.23.2026.01.20.08.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 08:38:45 -0800 (PST)
Message-ID: <a4135018-6673-4414-a900-7a35b5882aab@linaro.org>
Date: Tue, 20 Jan 2026 17:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
 <e0a6625d-1b3d-4fd8-90d8-8bb996e2f259@linaro.org>
In-Reply-To: <e0a6625d-1b3d-4fd8-90d8-8bb996e2f259@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 19/1/26 20:29, Philippe Mathieu-Daudé wrote:
> On 19/1/26 20:18, Vladimir Sementsov-Ogievskiy wrote:
>> On 19.01.26 21:38, Philippe Mathieu-Daudé wrote:
>>> On 19/1/26 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 19.01.26 19:31, Philippe Mathieu-Daudé wrote:
>>>>> On 19/1/26 16:42, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Hi! Isn't this patch lost?
>>>>>>
>>>>>> On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
>>>>>>> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> Test, that fix in previous commit make sense.
>>>>>>>>
>>>>>>>> To not break compilation when we build without
>>>>>>>> 'block', move hexdump.c out of "if have_block"
>>>>>>>> in meson.build.
>>>>>>>>
>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex- 
>>>>>>>> team.ru>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> v3: change meson.build to compile hexdump.c always
>>>>>>>>
>>>>>>>>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++ 
>>>>>>>> + ++ +++++
>>>>>>>>   util/meson.build         |  2 +-
>>>>>>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>>>>>>> index 227acc5995..24fef16a7f 100644
>>>>>>>> --- a/tests/unit/test-cutils.c
>>>>>>>> +++ b/tests/unit/test-cutils.c
>>>>>>>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>>>>>>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>>>>>>>   }
>>>>>>>> +static void test_qemu_hexdump_alignment(void)
>>>>>>>> +{
>>>>>>>> +    /*
>>>>>>>> +     * Test that ASCII part is properly aligned for incomplete 
>>>>>>>> lines.
>>>>>>>> +     * This test catches the bug that was fixed in previous commit
>>>>>>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>>>>>>> +     *
>>>>>>>> +     * We use data that is not aligned to 16 bytes, so last line
>>>>>>>> +     * is incomplete.
>>>>>>>> +     */
>>>>>>>> +    const uint8_t data[] = {
>>>>>>>> +        /* First line: 16 bytes */
>>>>>>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* 
>>>>>>>> "Hello Wo" */
>>>>>>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* 
>>>>>>>> "rld! Thi" */
>>>>>>>> +        /* Second line: 5 bytes (incomplete) */
>>>>>>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s 
>>>>>>>> is " */
>>>>>>>> +    };
>>>>>>>> +    char *output = NULL;
>>>>>>>> +    size_t size;
>>>>>>>> +    FILE *stream = open_memstream(&output, &size);
>>>>>>>> +
>>>>>>>> +    g_assert_nonnull(stream);
>>>>>>>> +
>>>>>>>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>>>>>>>> +    fclose(stream);
>>>>>>>> +
>>>>>>>> +    g_assert_nonnull(output);
>>>>>>>> +
>>>>>>>> +    /* We expect proper alignment of "s is" part on the second 
>>>>>>>> line */
>>>>>>>> +    const char *expected =
>>>>>>>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 
>>>>>>>> 54 68 69   Hello World! Thi\n"
>>>>>>>> +        "test: 0010: 73 20 69 73 
>>>>>>>> 20                                      s is \n";
>>>>>>>
>>>>>>> Thanks, queued wrapping the long lines to pass checkpatch.pl,
>>>>>>> as in:
>>>>>>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- 
>>>>>>> philmd@linaro.org/
>>>>>
>>>>> I have it tagged but there is still a meson issue. I should revisit
>>>>> but it is low in my priority queue.
>>>
>>> Found it, see that pipeline:
>>> https://gitlab.com/philmd/qemu/-/pipelines/2238533614
>>
>> This build contains previous version of the patch. v3 should fix it.
> 
> Doh sorry, maybe I tested v2 then, I don't remember :(

On MinGW (v3):

../tests/unit/test-cutils.c: In function 'test_qemu_hexdump_alignment':
../tests/unit/test-cutils.c:3648:20: error: implicit declaration of 
function 'open_memstream' [-Wimplicit-function-declaration]
  3648 |     FILE *stream = open_memstream(&output, &size);
       |                    ^~~~~~~~~~~~~~

> 
>>
>>>
>>> configuring with:  '../configure' ... '--disable-system'
>>> ...
>>> FAILED: tests/unit/test-cutils
>>> /usr/bin/ld: tests/unit/test-cutils.p/test-cutils.c.o: in function 
>>> `test_qemu_hexdump_alignment':
>>> test-cutils.c:(.text+0x71): undefined reference to `qemu_hexdump'
>>> collect2: error: ld returned 1 exit status
>>>
>>
>>
> 



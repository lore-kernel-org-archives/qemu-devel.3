Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E2DC52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvNL-0006FJ-61; Thu, 08 Aug 2024 01:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvNJ-0006Cu-Ne
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:07:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvNI-0001Xf-1m
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:07:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ff67158052so4811525ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723093662; x=1723698462; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqHhc5kG1t+EAEGN0cO4xdif80gU2DAe8cOdIcoHGUQ=;
 b=NKOttQ93alK4K/0e4wrK8nNE7l5L1ER9fp9n+1HtjfoYcuqbHkQnT7L1Q97tghLuZy
 OEQuQ9f3ohTqVCnGIvKQIabhkPbl2LWzwlI3dHUenoArQB9Gnengyy6Dc5G5Pz5yqinD
 DMoidGcPbOrx/15vGzxpDlxjpVkHeSDoKU4vaVcj/VE1fgSfjaSaD+1Br9THU1tpvIOk
 kBYKCs+ifIlmbt3AtnTe2g4dHl6+9R9EqcQPiqk4wnI/I4h+lkRn5II0BVV/se1Fcl8D
 C4kesqXG9n5MN0+mzsL17TVRhNrVyvcRXKdfx24FOCZKix0IsdegANmn8QVLpeH0sKES
 h3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723093662; x=1723698462;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JqHhc5kG1t+EAEGN0cO4xdif80gU2DAe8cOdIcoHGUQ=;
 b=wisl08jLeA0b6n59lYJjD7MkGkKZ2IyBpEQI7Cd2e1gve1Gy5e9aEzqW2MVDeop2xm
 cODaFoscPycvDreGe/BzT/OwRIZkrFJC1R+BnqsJpQNiHYIozUObvuHs/b4zns5fGBBN
 r2gYDrlHxU1Fx/exi1hOEDiFhB1ybjMsOFvz0axQOuP0fgBWaTb2MSGEPtLUBQ1JX+Hu
 lrTocuFA1lS5V8tEm2Pw+LSICIZQ3sHSIbT3NIVWff+fsiw8eEAo4fxjjjhvRKuMklVr
 Kbn1W6Ckp/QWnV0rbD5yD5BG5++V8xLVokSlDuZvnuxijv1JQpVkn31zOsHs5DxDrSx0
 KBLQ==
X-Gm-Message-State: AOJu0YwQDRPCFYffq0K4lGUqfToTPewr7J7COoD0Pp+e4gmYwrzu+l3B
 Kl7J5bDYl57Dqwita7D8oQZgD8gMMNLKmCqz9xkhdzXGI+jPnCibp5KpZN7W0a5JQ2mxP46YxWt
 9
X-Google-Smtp-Source: AGHT+IFJnW9BjBiEF3WPDPY7Ru2Khmnwr52VZlamyzXGqglsWBhQOL55qGrno+9gfp0AYeK/FHdtDA==
X-Received: by 2002:a17:902:e5c3:b0:1fd:6b87:2147 with SMTP id
 d9443c01a7336-20095228bc5mr10861535ad.6.1723093662525; 
 Wed, 07 Aug 2024 22:07:42 -0700 (PDT)
Received: from [192.168.0.103] ([187.75.36.187])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f62e7asm115448115ad.115.2024.08.07.22.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 22:07:42 -0700 (PDT)
Subject: Re: [PATCH 3/4] tests/guest-debug: Support passing arguments to the
 GDB test script
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-4-gustavo.romero@linaro.org>
 <87jzh9mcly.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <e7a68dce-4dc3-b052-c44f-9b729bf298a8@linaro.org>
Date: Thu, 8 Aug 2024 02:07:39 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87jzh9mcly.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.732,
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

Hi Alex,

On 7/25/24 5:38 PM, Alex Bennée wrote:
> Gustavo Romero <gustavo.romero@linaro.org> writes:
> 
>> This commit adds a new option to run-test.py, --test-args, which can
>> be used to pass arguments to the GDB test script specified by the --test
>> option. The arguments passed are in the key=value form, and multiple
>> pairs can be passed, separated by a space. For example:
>>
>> run-test.py [...] --test <GDB_TEST_SCRIPT> --test-args v0="string" v1=10
>>
>> The 'v0' and 'v1' variables will then be available in the GDB test
>> script, like this:
>>
>> print(v0)
>> print(v1)
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/guest-debug/run-test.py | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
>> index 368ff8a890..63b55fb8bd 100755
>> --- a/tests/guest-debug/run-test.py
>> +++ b/tests/guest-debug/run-test.py
>> @@ -27,6 +27,7 @@ def get_args():
>>       parser.add_argument("--binary", help="Binary to debug",
>>                           required=True)
>>       parser.add_argument("--test", help="GDB test script")
>> +    parser.add_argument("--test-args", help="Arguments to GDB test script")
>>       parser.add_argument("--gdb", help="The gdb binary to use",
>>                           default=None)
>>       parser.add_argument("--gdb-args", help="Additional gdb
>> arguments")
> 
> I might be easier to do:
> 
>      parser.add_argument('test_args', nargs='*',
>                          help="Additional args for test. "
>                          "You should precede with -- "
>                          "to avoid confusion with flags for runner script")
> 
> 
>> @@ -91,6 +92,9 @@ def log(output, msg):
>>       gdb_cmd += " -ex 'target remote %s'" % (socket_name)
>>       # finally the test script itself
>>       if args.test:
>> +        if args.test_args:
>> +            test_args = args.test_args.replace(" ",";")
>> +            gdb_cmd += f" -ex 'py {test_args}'"
>>           gdb_cmd += " -x %s" % (args.test)
As we discussed, -ex 'py [...]' just allow setting variables in Python,
so it won't understand plain argparse'd arguments. For instance, if we
do 'run-test.py [...] -- --mode=system' this will fail because
"--mode-system" not a valid Python syntax. Moreover, there isn't another
way to pass args to the GDB Python scripts afaict.

But since that's a nice idea (to be able to parse args in the GDB Python
scripts) I found a workaround. It's possible to set the sys.argv in the
script env. So -ex "py sys.argv=['--mode=user', '--arg1=1', '--arg2=2', ...]",
for instance, correctly sets the argv and make argparse work normally in
the script. Thus I used that approach to address your suggestion. Please
see v2.


Cheers,
Gustavo


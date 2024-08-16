Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A655C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0bg-0006Bh-Vj; Fri, 16 Aug 2024 13:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf0bQ-0005x6-Dc
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:19:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sf0bN-0000GB-BK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:19:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428243f928fso22654785e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723828739; x=1724433539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pk5pJCx1Mg4qUNM+2OSBCTnTMZcygvo7xWYEstkfisY=;
 b=rfbgQL6eRgd4O4LGceW/QTnLHSPPNj9atd+lmPwBwJcQTrhCWhgOaGa+6CK6UcJDeE
 xxjqhsi3gnLWsjh0kdqbqvEvK8iyrTRKTY9Q1bOMN6hJUgYVdAUsVfv4V5Z6/fOs/5so
 Ur4lCPFx3Ibn2auCegd3FocLa+D9CBenYdobR1mKtza/qu0x9LWHgyxunNm4fve4nRtg
 mUILzXkzdAkZbZ4OwGqlqtuESH1MI6F6vxlx5q9IgaTLmO87s74zh5YpIqOA+6IWMdFW
 UUXSVvUZrGBf7VkhpN9j3b3x0j7pjbxcEr0DLJRHQ2xwSO87V/KF7Yy2UQtprR552Mna
 XVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828739; x=1724433539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pk5pJCx1Mg4qUNM+2OSBCTnTMZcygvo7xWYEstkfisY=;
 b=i0j8avUtWMrqR4ejYfE+qg81o5syVJeruSvm8FVU0L0H3iFJPPVcGL2PSBOlOWuCY8
 vyMXH5GRITEP3u9qzSP4gsL962+/7c0ZwD56//q4cYKZbktxhT5MtbhuOMH+wPHguL9G
 lhHoJKmQEgahVEwgYbbu6JvjuedbU3s6V2JcCrQdX0ja7K4n5jQ0AFbJbGg92eTI6Tye
 jWAbW8JLQU6ZJLJO4nk8/zzjmCG2Xtp+ywmfyIAb7UZuJqkWbvjPJr1QVXCine2E5t2s
 LUTDZ5wvVGpqnyyTdxiSYErDnRIhKvTQt3LYEi6+LYUhr0x+Ltw9jZtGeGfkizZ1fH1q
 jT6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2N+GjfUD/e08vPF1Ofr8Y69uso4RLFwkc4v5MeOmYUEWRRSE8NimBSR1bl7mFw9+RBLK0EKjM6ppLfbeMN51n3zde1f0=
X-Gm-Message-State: AOJu0Yy2/seuVHt2df/Byjf3uYc1Sm7c0Q92vb3nm8xoV3M4nSCd7Blp
 ccPi8L7ON93yLZuGSHc/M6yGdKtbmq07tgE0z76HktmBgj4Cm917AwkZcIOiVDs=
X-Google-Smtp-Source: AGHT+IGc46zC5ZrPOSin6XvK5isTzApnuOjwHVhs3Vroz8gxgsgbdnp12OjvQVeDY80OD4b4f1vGCA==
X-Received: by 2002:a5d:69cc:0:b0:368:3782:c2b3 with SMTP id
 ffacd0b85a97d-3719464ddbfmr2786442f8f.29.1723828739210; 
 Fri, 16 Aug 2024 10:18:59 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded19627sm80745615e9.5.2024.08.16.10.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 10:18:58 -0700 (PDT)
Message-ID: <3abd50a8-6add-4406-ba21-ddd0c73965ed@linaro.org>
Date: Fri, 16 Aug 2024 19:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2
 job
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>
References: <20240816153747.319161-1-thuth@redhat.com>
 <8d07931c-444e-4030-ac7c-b81ad2d3bac4@linaro.org>
 <ac16ccfe-65fa-4de4-95a1-7b2d2379c893@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ac16ccfe-65fa-4de4-95a1-7b2d2379c893@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 16/8/24 18:40, Thomas Huth wrote:
> On 16/08/2024 18.34, Philippe Mathieu-Daudé wrote:
>> On 16/8/24 17:37, Thomas Huth wrote:
>>> The qtests are broken since a while in the MSYS2 job in the gitlab-CI,
>>> likely due to some changes in the MSYS2 environment. So far nobody has
>>> neither a clue what's going wrong here, nor an idea how to fix this
>>> (in fact most QEMU developers even don't have a Windows environment
>>> available for properly analyzing this problem), so let's disable the
>>> qtests here again to get at least the test coverage for the compilation
>>> and unit tests back to the CI.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .gitlab-ci.d/windows.yml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
>>> index a83f23a786..9f3112f010 100644
>>> --- a/.gitlab-ci.d/windows.yml
>>> +++ b/.gitlab-ci.d/windows.yml
>>> @@ -23,6 +23,8 @@ msys2-64bit:
>>>       # for this job, because otherwise the build could not complete 
>>> within
>>>       # the project timeout.
>>>       CONFIGURE_ARGS:  --target-list=sparc-softmmu 
>>> --without-default-devices -Ddebug=false -Doptimization=0
>>> +    # The qtests are broken in the msys2 job on gitlab, so disable 
>>> them:
>>> +    TEST_ARGS: --no-suite qtest
>>
>> Then building system emulation is pointless, isn't it?
> 
> We're still running the unit tests and some others.

I tried to configure with '--disable-system' and the same tests
are run:

[1107/1109] Linking target tests/unit/test-vmstate.exe
[1108/1109] Linking target tests/unit/test-yank.exe
[1109/1109] Linking target tests/unit/test-qdev-global-props.exe
/c/Users/Administrator/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 
1  --num-processes 1 --print-errorlogs  --suite unit
  1/93 qemu:unit / test-crypto-block                   OK 
0.22s   1 subtests passed
  2/93 qemu:unit / test-aio-multithread                OK 
6.94s   5 subtests passed
  3/93 qemu:unit / test-replication                    OK 
1.55s   8 subtests passed
  4/93 qemu:unit / test-bufferiszero                   OK 
9.70s   1 subtests passed
  5/93 qemu:unit / check-block-qdict                   OK 
0.09s   10 subtests passed
  6/93 qemu:unit / check-qdict                         OK 
0.06s   15 subtests passed
  7/93 qemu:unit / check-qnum                          OK 
0.08s   8 subtests passed
  8/93 qemu:unit / check-qstring                       OK 
0.08s   4 subtests passed
  9/93 qemu:unit / check-qlist                         OK 
0.06s   4 subtests passed
10/93 qemu:unit / check-qnull                         OK 
0.06s   2 subtests passed
11/93 qemu:unit / check-qobject                       OK 
0.08s   7 subtests passed
12/93 qemu:unit / check-qjson                         OK 
0.31s   31 subtests passed
13/93 qemu:unit / check-qlit                          OK 
0.09s   2 subtests passed
14/93 qemu:unit / test-error-report                   OK 
0.42s   6 subtests passed
15/93 qemu:unit / test-qobject-output-visitor         OK 
0.09s   16 subtests passed
16/93 qemu:unit / test-clone-visitor                  OK 
0.06s   7 subtests passed
17/93 qemu:unit / test-qobject-input-visitor          OK 
0.08s   42 subtests passed
18/93 qemu:unit / test-forward-visitor                OK 
0.08s   7 subtests passed
19/93 qemu:unit / test-string-input-visitor           OK 
0.11s   8 subtests passed
20/93 qemu:unit / test-string-output-visitor          OK 
0.08s   14 subtests passed
21/93 qemu:unit / test-visitor-serialization          OK 
0.08s   156 subtests passed
22/93 qemu:unit / test-bitmap                         OK 
0.08s   2 subtests passed
23/93 qemu:unit / test-resv-mem                       OK 
0.09s   3 subtests passed
24/93 qemu:unit / test-x86-topo                       OK 
0.06s   1 subtests passed
25/93 qemu:unit / test-cutils                         OK 
0.08s   179 subtests passed
26/93 qemu:unit / test-div128                         OK 
0.08s   2 subtests passed
27/93 qemu:unit / test-shift128                       OK 
0.06s   2 subtests passed
28/93 qemu:unit / test-mul64                          OK 
0.08s   2 subtests passed
29/93 qemu:unit / test-int128                         OK 
0.08s   11 subtests passed
30/93 qemu:unit / rcutorture                          OK 
2.34s   2 subtests passed
31/93 qemu:unit / test-rcu-list                       OK 
4.20s   3 subtests passed
32/93 qemu:unit / test-rcu-simpleq                    OK 
4.20s   3 subtests passed
33/93 qemu:unit / test-rcu-tailq                      OK 
4.20s   3 subtests passed
34/93 qemu:unit / test-rcu-slist                      OK 
4.20s   3 subtests passed
35/93 qemu:unit / test-qdist                          OK 
0.09s   8 subtests passed
36/93 qemu:unit / test-qht                            OK 
1.94s   2 subtests passed
37/93 qemu:unit / test-qtree                          OK 
0.09s   4 subtests passed
38/93 qemu:unit / test-bitops                         OK 
0.08s   6 subtests passed
39/93 qemu:unit / test-bitcnt                         OK 
0.06s   4 subtests passed
40/93 qemu:unit / test-qgraph                         OK 
0.06s   23 subtests passed
41/93 qemu:unit / check-qom-interface                 OK 
0.09s   2 subtests passed
42/93 qemu:unit / check-qom-proplist                  OK 
0.08s   9 subtests passed
43/93 qemu:unit / test-qemu-opts                      OK 
0.06s   19 subtests passed
44/93 qemu:unit / test-keyval                         OK 
0.08s   13 subtests passed
45/93 qemu:unit / test-logging                        OK 
0.17s   4 subtests passed
46/93 qemu:unit / test-qapi-util                      OK 
0.06s   2 subtests passed
47/93 qemu:unit / test-interval-tree                  OK 
0.08s   6 subtests passed
48/93 qemu:unit / test-qmp-event                      OK 
0.16s   6 subtests passed
49/93 qemu:unit / test-coroutine                      OK 
0.28s   12 subtests passed
50/93 qemu:unit / test-aio                            OK 
3.88s   27 subtests passed
51/93 qemu:unit / test-throttle                       OK 
0.33s   17 subtests passed
52/93 qemu:unit / test-thread-pool                    OK 
4.34s   6 subtests passed
53/93 qemu:unit / test-hbitmap                        OK 
0.55s   40 subtests passed
54/93 qemu:unit / test-bdrv-drain                     OK 
1.67s   30 subtests passed
55/93 qemu:unit / test-bdrv-graph-mod                 OK 
0.31s   5 subtests passed
56/93 qemu:unit / test-blockjob                       OK 
0.33s   8 subtests passed
57/93 qemu:unit / test-blockjob-txn                   OK 
0.42s   7 subtests passed
58/93 qemu:unit / test-block-backend                  OK 
0.31s   2 subtests passed
59/93 qemu:unit / test-block-iothread                 OK 
0.41s   22 subtests passed
60/93 qemu:unit / test-write-threshold                OK 
0.33s   2 subtests passed
61/93 qemu:unit / test-crypto-hash                    OK 
0.08s   5 subtests passed
62/93 qemu:unit / test-crypto-hmac                    OK 
0.08s   4 subtests passed
63/93 qemu:unit / test-crypto-cipher                  OK 
0.09s   17 subtests passed
64/93 qemu:unit / test-crypto-akcipher                OK 
0.09s   16 subtests passed
65/93 qemu:unit / test-crypto-secret                  OK 
0.11s   16 subtests passed
66/93 qemu:unit / test-crypto-der                     OK 
0.08s   4 subtests passed
67/93 qemu:unit / test-authz-simple                   OK 
0.08s   1 subtests passed
68/93 qemu:unit / test-authz-list                     OK 
0.08s   6 subtests passed
69/93 qemu:unit / test-authz-listfile                 OK 
0.16s   5 subtests passed
70/93 qemu:unit / test-io-task                        OK 
0.33s   5 subtests passed
71/93 qemu:unit / test-io-channel-socket              OK 
0.33s   8 subtests passed
72/93 qemu:unit / test-io-channel-file                OK 
0.20s   3 subtests passed
73/93 qemu:unit / test-io-channel-command             SKIP 
0.19s   0 subtests passed
74/93 qemu:unit / test-io-channel-buffer              OK 
0.17s   1 subtests passed
75/93 qemu:unit / test-io-channel-null                OK 
0.19s   1 subtests passed
76/93 qemu:unit / test-crypto-ivgen                   OK 
0.19s   9 subtests passed
77/93 qemu:unit / test-crypto-afsplit                 OK 
0.20s   4 subtests passed
78/93 qemu:unit / test-timed-average                  OK 
0.14s   1 subtests passed
79/93 qemu:unit / test-uuid                           OK 
0.08s   6 subtests passed
80/93 qemu:unit / ptimer-test                         OK 
0.09s   576 subtests passed
81/93 qemu:unit / test-iov                            OK 
0.08s   6 subtests passed
82/93 qemu:unit / test-opts-visitor                   OK 
0.14s   33 subtests passed
83/93 qemu:unit / test-xs-node                        OK 
0.08s   7 subtests passed
84/93 qemu:unit / test-virtio-dmabuf                  OK 
0.08s   5 subtests passed
85/93 qemu:unit / test-qmp-cmds                       OK 
0.16s   10 subtests passed
86/93 qemu:unit / test-xbzrle                         OK 
0.31s   6 subtests passed
87/93 qemu:unit / test-util-sockets                   OK 
0.16s   2 subtests passed
88/93 qemu:unit / test-base64                         OK 
0.08s   4 subtests passed
89/93 qemu:unit / test-smp-parse                      OK 
0.09s   10 subtests passed
90/93 qemu:unit / test-vmstate                        OK 
0.22s   23 subtests passed
91/93 qemu:unit / test-yank                           OK 
0.20s   6 subtests passed
92/93 qemu:unit / test-qdev-global-props              OK 
0.33s   4 subtests passed
93/93 qemu:unit / xml-preprocess                      OK               0.53s

Ok:                 92
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            1
Timeout:            0

Full log written to C:/Users/Administrator/qemu/build/meson-logs/testlog.txt

Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
#

>> Could we at least test the block tools? qemu-img seems to work:
>>
>> # ./qemu-img.exe --help
>> qemu-img version 9.0.92 (v9.1.0-rc2)
>> Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
>> usage: qemu-img [standard options] command [command options]
>> QEMU disk image utility
>>
>>      '-h', '--help'       display this help and exit
>>      '-V', '--version'    output version information and exit
>> ...
>>
>> It doesn't work currently:
> ...
>> Administrator@FOOBAR UCRT64 /c/Users/Administrator/qemu/build
>> # make check-block
>> make: *** No rule to make target 'check-block'.  Stop.
> 
> check-block never worked on Windows as far as I know, it's disabled in 
> the meson.build there:
> 
> if not have_tools or host_os == 'windows'
>    subdir_done()
> endif

Ah OK, thanks.

> 
>   Thomas
> 



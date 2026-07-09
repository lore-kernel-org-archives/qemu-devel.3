Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whdac-0006YK-B5; Wed, 08 Jul 2026 21:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whdaa-0006Vc-OT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:30:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whdaY-0003LA-KA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 21:30:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668N8f5f024586
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 01:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W6Lur6vE7H0R1m1/RIfSb+sY2IqdWe6pYNww3ihyFxI=; b=dUI4ANmHOKQ+uh/m
 A+A8S4shiQwlwdulIrTj2KRqONgCIxc8utr2vYx9TDtf4E2vmn6zAxr0Q+3uN4ES
 l55uCfoXZpv67ks9o/fbFJQRJpvRlJX5owTo3pc2ecg4NkgM9KMBSUE1TqgJUto+
 +rdrLZBer27dLDaMScnQEn3aC7sf6H4EdHd6EbUNyvnlFj0qKjxL+L5+sfjshNjQ
 6SiG1c9NrucqSwFC0+g1XiLSpIw+grFbNmNa++Wh0yrA3yPFGe/axpmfDIHlEHXV
 oW4RM2Nt4goygpeqVQwRGWYHB5Jekh4+/ewMKRdMlvMaP8wkNkC10dZRHpaKGxGw
 kcSwjw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv46vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:30:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso17621455ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783560602; x=1784165402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6Lur6vE7H0R1m1/RIfSb+sY2IqdWe6pYNww3ihyFxI=;
 b=Y6K/74jjNzPGHPHcezTSScjkGpR/0sBwrkXjjJxVC1W/iqvI7QlKzwbqU3zae3lA7D
 /XVdFIetPv1uPdn5f341GXC/ER68Xm7s6o31RxzV0Vlh/8PK1ygVOP0W6MFbPss86wKh
 Jr+e9uHnpGKuG3pf19TbVxjLYukTWIlfp3tFfVh1SU5uICRLP8XaGSVdBknXsdNJ5+ka
 UVf+gVgNFw3RghbccqScUYJMrIalo1X13tJPdv1OCjuKDrMDfGQi67nXv4RW9wiRhzmk
 dj3qoMgVYNTECL7laWQP4it1gas1jC0Uq+FAeK/mLu1MIgNSFtxhK0lqK7q7J3DoqCO2
 sucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560602; x=1784165402;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6Lur6vE7H0R1m1/RIfSb+sY2IqdWe6pYNww3ihyFxI=;
 b=Ep2d5z04PBGap2GZq9OIAAuSX7C1YP/wVVPP/Wkid7AsJVfqwMc83l6lLp3tLrdo20
 JlDuYkPxT1ngcB9q+sWVGXCE+URiHzJSclgMUsjYIK/TcRUnOwlNbCBkHkurPAF4wMhQ
 BYV+45OwSgR7Z+S/yWzqq2bPW0XlYVEKpOiA9bISvazCrxTzW0Kq5zip1R3fh7UytvZZ
 h+LGCbDKMZ0eBGnibJ0G4ndusWoxRaXKjBo7MxBRA9fi/+v5V86fwgSv3o/pz9xXM3TI
 AcrqzHDArkb3jRY4/rlmaN7Tz6yMGRgIk6b0XQ4mpDmBgHcbyBr3C6HfQpH7xHpWZ80X
 6/+w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3vw4IVtKQNo9nirBI+Yii/Hf6Tx4E2qIuiFSpqlMcS5uNtRGvXRYeDVjA64R7RNy82IA5/WQ3lCLW@nongnu.org
X-Gm-Message-State: AOJu0YxEuGQd1tPoNPewwM+02HAtIxJsSZAQVt6/Wm7FA1tlIpYEY+iB
 HvpgN52MwNK71E1OYuH13B8h/GZAkmeFzKgiWbQDx2Ci8XFsZbmw0NhZ95TzVT5az2E0fI1ygCP
 CmUd2qXhlmYTKlfcJNqZQKrW8AcEc2LW3Bc8BPvGqe8kk6gSCklF9BgIIug==
X-Gm-Gg: AfdE7cl9sgPXC8kVFgEZje6+rAXYKoz0tMfndpG7XYZm9bW0jsUeK4Zyz/Jl/rQuZpb
 J7wtAz/7MYzWHCz2207+PgJxhjRJnwqXh1WWDaIijswjQBo1/DfREvqPCukyOW3a+ZKNImZP/1i
 UOCIFsHjd9/2c6TQ5av8IhdIpvUzHw0KnALJ2nZRUf3CAjs3r1F2odrRgXWr+B/Zb2oYbOpSzFU
 tglbUg3gd2CW96zr89uz5MpZbAYcGCvR/1FaZHC7U3v3syKgfRgV0W54su6+sRidHJeAH0Qi08U
 6M6TPsPYpK0oiK4seWVz1UDRo1rNmEnU10hJK/9u36Ei3XgZHy3lkXCsLpX4Sc+E2JSB/pwU4Gf
 bhBezwrx6py0t4xBM0O0q9dUa2E2s5P5qTdnVH4Iy3Ef8Jwf1E0694MwZD4o6f/iXc/WAMWbltG
 AWdF0=
X-Received: by 2002:a17:90b:2685:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-3893fb711c5mr4782468a91.7.1783560602398; 
 Wed, 08 Jul 2026 18:30:02 -0700 (PDT)
X-Received: by 2002:a17:90b:2685:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-3893fb711c5mr4782431a91.7.1783560601752; 
 Wed, 08 Jul 2026 18:30:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm17998878eec.21.2026.07.08.18.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 18:30:01 -0700 (PDT)
Message-ID: <2c33043b-da8e-4b3f-8f17-c574b4632fcb@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 18:29:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260708152043.251537-1-functioner@sjtu.edu.cn>
 <20260708152043.251537-3-functioner@sjtu.edu.cn>
 <6abd4f15-03b5-4036-a016-74269e87c36a@oss.qualcomm.com>
 <f6600480-2cac-4708-8a3d-b2c69d454196@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f6600480-2cac-4708-8a3d-b2c69d454196@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4ef99b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=PegA-BAZdFu16Kc378cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxMiBTYWx0ZWRfX4YeXVoqD0Dj4
 t//YhSTPdxjKC4yaAkvRo0KJ0aupWSpurOHwHv+Cj8Q8yXk5KopdcS6vJNb2D4C7F2cnSLjNZw3
 hL7cSgJgAabY4GZ8LkQY8woh8XvdIMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxMiBTYWx0ZWRfX25LN7miCaBHN
 4eRQHqJU88MhuEgdLL23BF6iovQBBkl6KvgaJAdD8JZ5n1lIu/S+6zxiBgxfMqnvmtdpBIBmSVt
 myNWFddJbq88Trp7LPivJBagICo8vq9ZbI1IlfaU/Kgby4Np4dYw3ZRBPHCrI6tIajRvt52I9F7
 X8TJqdexkZUdxuj+mo1uRe3u6abdRJsnIUyZlXKn41Ss3fPs65D/+ncOn6Ky356BWxhLAFguSMx
 +7qfYbJv1Y+YAZjoCAcapoDLaOUxmg8s7kfztkYjK5/2WV+A7Gn30SGAN4EjC3WEEQVGuormagz
 fNcoMZBIpN2HRlseVBD9YxoMSAxGfW3/JYRvs+zWepmixjczjhwOv7BOUG7BmpnlxosY5YjxqPb
 2h3/9/bvvsDRr+8tKjc/hyZzaeRR43l/DYvuvNjywl58x1Y0USlATWIVg8LnH76FXrmP0vP1DWu
 akmLflp4HJnIFLuVo0A==
X-Proofpoint-ORIG-GUID: Smh6ISgW07dk7PWY0dGZ3LQB3vYDUUvJ
X-Proofpoint-GUID: Smh6ISgW07dk7PWY0dGZ3LQB3vYDUUvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, LOTS_OF_MONEY=0.001,
 MONEY_NOHTML=1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/8/2026 5:27 PM, Ziyang Zhang wrote:
> Hi Pierrick,
> 
> On Wed, 8 Jul 2026 16:55:19 -0700, Pierrick Bouvier wrote:
>>> +A minimal end-to-end example wraps a one-function library,
>>> ``libhello.so``,
>>> +declared by ``hello.h``:
>>> +
>>> +.. code-block:: c
>>> +
>>> +   void hello(const char *name, int lucky);
>>> +
>>
>> Please include full files for example:
>> hello.h, hello.c and main.c calling hello function.
>>
>> Also, please include compiler commands for libhello.so and main.
>> You can give a full example assuming it run on a x86_64 host.
> Good idea. I will get it done in v8.
> 
>> I could not get it to work.
>> Following all the steps, the error message is:
>>
>> [GRT] failed to load host runtime
>> qemu: uncaught target signal 6 (Aborted) - core dumped
>> Aborted
> On the error. [GRT] failed to load host runtime is the host side (QEMU)
> failing to dlopen the Lorelei host runtime, which means $DEVKIT/lib was
> not on the host LD_LIBRARY_PATH, for example if $DEVKIT was not set in
> the shell that ran the command. -L only points QEMU at the guest's
> loader and libc, so it is unrelated.
> 
> I reproduced it: dropping just $DEVKIT/lib from the host LD_LIBRARY_PATH
> gives exactly that message and the abort. The real fix is making the
> example self-contained so nothing stays implicit, which is what v8 does.
>

I paid attention to follow steps correctly, but maybe I missed
something. Please see here a full dump of my env and commands:

$ git status
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        a.out
        hello.c
        hello.h
        libhello.so
        lorelei-devkit-x86_64-1.0.4.0.tar.xz
        lorelei-devkit-x86_64/
        main.c
        thunks/

nothing added to commit but untracked files present (use "git add" to track)
$ ldd a.out
        linux-vdso.so.1 (0x00007f5855c3a000)
        libhello.so => not found
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f5855a0a000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f5855c3c000)
$ LD_LIBRARY_PATH=./ ldd a.out
        linux-vdso.so.1 (0x00007fef23831000)
        libhello.so => ./libhello.so (0x00007fef2381f000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fef235fc000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fef23833000)
$ env | grep DEVKIT
DEVKIT=/home/user/.work/qemu/lorelei-devkit-x86_64
$ tree thunks/
thunks/
├── lib
│   └── x86_64-LoreHTL
│       └── libhello_HTL.so
└── x86_64
    └── lib
        └── x86_64-LoreGTL
            └── libhello.so

6 directories, 2 files
$ LORELEI_THUNK_PATH=thunks LD_LIBRARY_PATH=$DEVKIT/lib:. \
build/qemu-x86_64 -plugin build/contrib/plugins/libdlcall.so \
-L $DEVKIT/x86_64/sysroot \
 -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64/lib/x86_64-LoreGTL\
./a.out
[GRT] failed to load host runtime
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted

Any idea what could be missing?

>> We talked about not overriding sysroot, so please remove -L part.
>> Also, Why do current dir is passed in LD_LIBRARY_PATH?
> In this example it assumes that the host libhello.so is in the current
> directory, which must be able to be found in LD_LIBRARY_PATH.
> 
>>> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, controls what the
>>> emulated
>>> +program loads:
>>> +
>>> +* ``$DEVKIT/x86_64/lib`` contains the guest runtime support shipped
>>> with the
>>> +  devkit.
>>> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` contains the generated guest
>>> +  ``libhello.so`` thunk, used in place of an ordinary guest library.
>>> +
>>> +The host ``LD_LIBRARY_PATH`` controls what the plugin and host thunk
>>> load:
>>> +
>>> +* ``$DEVKIT/lib`` contains the host runtime support shipped with the
>>> devkit.
>>> +* ``.`` is the current directory, where the host's own
>>> ``libhello.so`` is
>>> +  located.
>>> +
>>> +See the runnable
>>> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/
>>> hello>`_
>>> +(minimal) and
>>> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/demo>`_
>>> +(variadic functions and a callback that reenters the guest)
>>> examples, and
>>> +`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk
>>> trees and
>>> +the runtime environment they expect.
>>> +
>>> +.. list-table:: Dynamic Linking Call arguments
>>> +  :widths: 20 80
>>> +  :header-rows: 1
>>> +
>>> +  * - Option
>>> +    - Description
>>> +  * - syscall_num=N
>>> +    - The magic syscall number the guest issues (default 4096). Must
>>> be high
>>> +      enough not to clash with a real syscall.
>>> +
>>>   Other emulation features
>>>   ------------------------
>>>   
>>
>> Regards,
>> Pierrick
> 
> It looks unexplained today only because the walkthrough never shows
> building it. v8 will.
> 
> v8 will also include the full hello.h, hello.c and main.c, plus the cc
> and clang commands for libhello.so and main, as one runnable x86_64
> sequence.


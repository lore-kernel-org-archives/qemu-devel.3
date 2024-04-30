Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD65C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sU1-0004EX-56; Tue, 30 Apr 2024 14:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1sTm-00045O-7B
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:45:27 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1sTk-0005Fo-18
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:45:25 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5709cb80b03so6404208a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714502722; x=1715107522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iYQwJAFdL14STKzkgelDC/k6xF13mYMYEtfTTgH1ucI=;
 b=jXFwUA/Q0/oimnObMED8L2LxJVfZ4SmvgwZw3lkMcXkwYCJxHfdbzq0YvFLsTu9i5C
 /RWtguTZJP02KZUNy7jsgUMiOmHU65Kxt/8JlD9nxi0ZIBrf9+2ZrQ7B60APZAF0q1rA
 kkT8CN4lbw6ulGM8CGKJNDs8hCmdMIbAuo41LniblmFNU7pRoB406xJenSD6H2C90FWB
 /uNmbffR+OzL2aQxnQnL5m+UlHyozz/Kx0nY5lCMU/KhuUxssUriCBkemZW1cxex+S54
 qLiQKE4rvgGzfoDv2Z1MB0TzQWGBYi+gxzwt55OhND+k9bm/v3kVj4ShFuztBeolHenc
 7fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714502722; x=1715107522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iYQwJAFdL14STKzkgelDC/k6xF13mYMYEtfTTgH1ucI=;
 b=Gg9KdlKymn2KU+27JmvYOzpxeWwswj0d/iiobRnU0r5Ougql1Fawl86MkvlGo8S7KP
 K9mFmbvbe00d9KY/CbRBzu9o512Pr3R/+YEJNlaX/OqX2ojmR3FhpCfHmT+2QXGff25J
 Qa1/G0+tRQg1Lea3UjmBV16TkNpBhxCplDheeZahEzb+5BPCuxkLKyhnIL1Ma10BcuMC
 Pjm4Xidy/MuHQbOPTOtannUvKW0q21ECLolF5bboCGdIkyOdsNSIo5zygJ16kK27cIo+
 6Wpw1PiuSbr+d6Q9fBj4E5xK+T4leYCpT60/ftmSmC65+R/BJiwegbUZ6hrRV5eK/WXY
 fPCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXJRWIZIlVnNXDCW9HNHAJlnMTIoy6ZiHO9CXROgGcLaOER0XeuU646eDsXdhVSsx3NPElo6SNVDWURz181w7segJqwqI=
X-Gm-Message-State: AOJu0YxJc0xEEaC6iz9EPOcPBFQYef2joTeuCVGCXJH/H3EtHXNbTbpz
 qL5K2sqLf21h8mxy2WCtJIirIM5I8Dy0V3U9dUhB3EQYXvIJa9jQeDvFlOq/FJk=
X-Google-Smtp-Source: AGHT+IFabM1jnfPMIUfLuCWZv+8aWlvcVTWyCG25DH6nr05cZqDcMtkWugC6xyTlzLZIfQb35n4A0w==
X-Received: by 2002:a17:906:710:b0:a52:362f:be1a with SMTP id
 y16-20020a170906071000b00a52362fbe1amr351172ejb.18.1714502722332; 
 Tue, 30 Apr 2024 11:45:22 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 bk2-20020a170907360200b00a55a8ec5879sm11805002ejc.116.2024.04.30.11.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 11:45:21 -0700 (PDT)
Message-ID: <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
Date: Tue, 30 Apr 2024 20:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
 <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Hi Ilya,

On 30/4/24 19:55, Ilya Leoshkevich wrote:
> On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé wrote:
>> Missing WASM testing by Ilya (branch available at
>> https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)
> 
> Hmm, it dies very early now:
> 
>    # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47
> 
>    Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
>    0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, errp=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>    217             cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
> 
>    (gdb) bt
>    #0  0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, errp=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>    #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0, errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:284
>    #2  0x000055555563f76b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:510
>    #3  0x000055555564363d in property_set_bool (obj=0x5555557c28c0, v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
>    #4  0x0000555555646b9b in object_property_set (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/object.c:1471
>    #5  0x000055555564a43f in object_property_set_qobject (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=0x5555557a7a90, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
>    #6  0x0000555555647204 in object_property_set_bool (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
>        at ../home/iii/myrepos/qemu/qom/object.c:1541
>    #7  0x000055555564025c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:291
>    #8  0x000055555559bbb4 in cpu_create (typename=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:61
>    #9  0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, envp=<optimized out>) at ../home/iii/myrepos/qemu/linux-user/main.c:811
> 
>    (gdb) p cpu
>    $1 = (CPUState *) 0x5555557c28c0
>    (gdb) p cpu->accel
>    $2 = (AccelCPUState *) 0x0
> 
> Configured with: '/home/iii/myrepos/qemu/configure' '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp' '--disable-fdt' '--disable-capstone' '--disable-docs'
> 
> If you don't see what can be wrong here right away, I can debug this.

Useful enough I guess, but I'll ask you to test again later.

Does it work without the last patch?

Is it possible to share component_fuzz_util-d10a3a6b4ad8af47?

Thanks for the testing,

Phil.


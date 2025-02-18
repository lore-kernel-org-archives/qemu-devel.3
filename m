Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C22C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHCQ-0004xD-GG; Tue, 18 Feb 2025 01:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkHCF-0004uE-CQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:35:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tkHCC-0005IM-CE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739860501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x5AhtQ12gH8aBCtU16EhV/9L7NlWQ+Hp7XX+wS4vcjM=;
 b=K10RU+ymUG2y9cULph4JuUJna3rE/wtm95Bcr7HNs9DGu7AHNq9bSMhPxb4emoM1Slob3h
 IZgaZQm8ufsGJKQnaeyq2uXqcC15J+fWExeFzC2cEiKzOtOh93scu4gbHQOgNeTV+ACRtn
 wYiWYDLIoVPuAngdugQrf9mXJX6K/n4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-poiVdFiwMFeDDqSGkj-wxQ-1; Tue, 18 Feb 2025 01:34:58 -0500
X-MC-Unique: poiVdFiwMFeDDqSGkj-wxQ-1
X-Mimecast-MFC-AGG-ID: poiVdFiwMFeDDqSGkj-wxQ_1739860497
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso40718355e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 22:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739860497; x=1740465297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5AhtQ12gH8aBCtU16EhV/9L7NlWQ+Hp7XX+wS4vcjM=;
 b=U//Cu+Lv9w9DOw2EzQ6sdBazQvtxTUT4dl4LXmJzWhicqKQxzoFRuZIqgGE6vfZ2uM
 ipPTryonRDtgTcGkJcA1A/uWIkHdwPkDwc8+lZitkIeAIDMxYxslknCnPTgXuJbydiOH
 S8CHoC4lqUeLLim2mqClPzmrq3/RL/MifffykrfwLOsruKsGgAznytJtiN5Rpdt2HZV7
 HFCSChNCoAryXBq4A7GWzNiCy/E7xcnhWddJ9R/6fb1dRPh9dTCefd3ZtBei+Q1SqYHC
 1ql5Bxx/SerZAl6gstyM2lelog0fl5fHS5ioSmUNZcWpzgvtRvT88MiP2RD4eGIb2knV
 9Yuw==
X-Gm-Message-State: AOJu0YzEeLJQ1Yo5diYjt/4cD1VPOlTuyYn1H5RU/nv4pGGCW8WbvtJf
 jQcN3S8NQ2L58TAXDU/2+gv1CVPCNeIL8/SodBFXm6gXwzo3NBc/RW5zP8dEMJdYZ095SItOkd8
 zhxJRMnrk9P7kbKXLOJCu+fiMxckqk2einj2ZEXv3TgG1WIyw1RAr
X-Gm-Gg: ASbGncuGLUWrTUdBN6xbWmY8NH22wrLZioewIXhoZ/eIj9Qtdy9pDiQ00UBErGbgIlH
 e4FN0MTTOs3Wh4aUJwAEaAcn52/vu8PJ9FRUh+3heWxJvhdPZrs5eDCy2L6oGJZ3Mme/kXokbQ/
 UEKSkUY6X/rUqmACyN8JedngkGu5V1upDWSFAns+sG+VMwbZ4mp6P/KaTh1KphU5v6ZFBLzigYk
 hCpluMOwjag7reNa7SJPdsc/Vh2TMiP46bSmNxSnMKq8NYHKfAIOKlq7fJBG+utV0823e7OQGlY
 gG4kaoGDEysKSjudhUtiMRAQxWHY9yEyfGDt
X-Received: by 2002:a05:600c:1910:b0:439:96aa:e502 with SMTP id
 5b1f17b1804b1-43996aae68amr3182655e9.12.1739860497283; 
 Mon, 17 Feb 2025 22:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxINo9OVYzVxnB39Sku8KHCuIQ8/pkmEA+NAPaRNTubF7xuEfqIJKpy2lSK+Jc8hWn0e/IIw==
X-Received: by 2002:a05:600c:1910:b0:439:96aa:e502 with SMTP id
 5b1f17b1804b1-43996aae68amr3182435e9.12.1739860496843; 
 Mon, 17 Feb 2025 22:34:56 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b824dsm171358935e9.34.2025.02.17.22.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 22:34:55 -0800 (PST)
Message-ID: <6d1cad85-4824-4912-b209-60a8070c59af@redhat.com>
Date: Tue, 18 Feb 2025 07:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/32] tests/functional: extend test_aarch64_virt with
 vulkan test
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:Virt" <qemu-arm@nongnu.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-24-alex.bennee@linaro.org>
 <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8Kf4eF-nxEsxhPZnV3pwU+9kXLq1zXDi61ODQEQXaAYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/02/2025 17.30, Peter Maydell wrote:
> On Fri, 10 Jan 2025 at 13:23, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Now that we have virtio-gpu Vulkan support, let's add a test for it.
>> Currently this is using images build by buildroot:
>>
>>    https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>
> 
> Hi; this test currently fails for me with a clang sanitizer
> build (ubuntu 24.04 host). It seems to run weston in the guest,
> which fails with:
> 
> 2025-02-17 16:11:10,218: [16:11:10.672] Command line: weston -B
> headless --renderer gl --shell kiosk -- vkmark -b:duration=1.0
> 2025-02-17 16:11:10,224: [16:11:10.675] OS: Linux, 6.11.10, #2 SMP Thu
> Dec  5 16:27:12 GMT 2024, aarch64
> 2025-02-17 16:11:10,225: [16:11:10.680] Flight recorder: enabled
> 2025-02-17 16:11:10,226: [16:11:10.681] warning: XDG_RUNTIME_DIR
> "/tmp" is not configured
> 2025-02-17 16:11:10,226: correctly.  Unix access mode must be 0700
> (current mode is 0777),
> 2025-02-17 16:11:10,226: and must be owned by the user UID 0 (current
> owner is UID 0).
> 2025-02-17 16:11:10,227: Refer to your distribution on how to get it, or
> 2025-02-17 16:11:10,227:
> http://www.freedesktop.org/wiki/Specifications/basedir-spec
> 2025-02-17 16:11:10,228: on how to implement it.
> 2025-02-17 16:11:10,240: [16:11:10.695] Starting with no config file.
> 2025-02-17 16:11:10,253: [16:11:10.707] Output repaint window is 7 ms maximum.
> 2025-02-17 16:11:10,262: [16:11:10.716] Loading module
> '/usr/lib/libweston-14/headless-backend.so'
> 2025-02-17 16:11:10,313: [16:11:10.768] Loading module
> '/usr/lib/libweston-14/gl-renderer.so'
> 2025-02-17 16:11:21,858: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:21,959: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:22,023: libEGL warning: egl: failed to create dri2 screen
> 2025-02-17 16:11:22,032: [16:11:22.486] failed to initialize display
> 2025-02-17 16:11:22,033: [16:11:22.488] EGL error state:
> EGL_NOT_INITIALIZED (0x3001)
> 2025-02-17 16:11:22,036: [16:11:22.490] fatal: failed to create
> compositor backend
> 
> Then eventually the test framework times it ou and sends it
> a SIGTERM, and QEMU SEGVs inside libEGL trying to run an
> exit handler:
> 
> qemu-system-aarch64: terminating on signal 15 from pid 242824
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3)
> UndefinedBehaviorSanitizer:DEADLYSIGNAL
> ==243045==ERROR: UndefinedBehaviorSanitizer: SEGV on unknown address
> 0x73fbfefe6a31 (pc 0x73fbba9788e9 bp 0x73fbbbe0af80 sp 0x7ffd676fbfe0
> T243045)
> ==243045==The signal is caused by a READ memory access.
>      #0 0x73fbba9788e9
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #1 0x73fbbaafc178
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x16fc178)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #2 0x73fbba62564f
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x122564f)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #3 0x73fbbab067d7
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x17067d7)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #4 0x73fbba63b786
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x123b786)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #5 0x73fbba96290a
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x156290a)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #6 0x73fbba941c5c
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x1541c5c)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
>      #7 0x73fbc2041f20
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f20) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #8 0x73fbc2041f68
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x41f68) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #9 0x73fbc2034ca9
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x34ca9) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #10 0x73fbc203ae90
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3ae90) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #11 0x73fbc203aeda
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0x3aeda) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #12 0x73fbc20a45f5
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa45f5) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #13 0x73fbc20a2bfc
> (/lib/x86_64-linux-gnu/libEGL_nvidia.so.0+0xa2bfc) (BuildId:
> 6cd9e3e571aa104d4fa5512a5c7196617fea6b51)
>      #14 0x73fbd3047a75 in __run_exit_handlers stdlib/exit.c:108:8
>      #15 0x73fbd3047bbd in exit stdlib/exit.c:138:3
>      #16 0x5a5bab5e3fdb in qemu_default_main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/main.c:52:5
>      #17 0x5a5bab5e3f9e in main
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/../../system/main.c:76:9
>      #18 0x73fbd302a1c9 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #19 0x73fbd302a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>      #20 0x5a5ba9c5b554 in _start
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-aarch64+0x15dc554)
> (BuildId: 8efda3601b42aa2644dde35d1d63f7b22b649a33)
> 
> UndefinedBehaviorSanitizer can not provide additional info.
> SUMMARY: UndefinedBehaviorSanitizer: SEGV
> (/lib/x86_64-linux-gnu/libnvidia-eglcore.so.535.183.01+0x15788e9)
> (BuildId: 24b0d0b90369112e3de888a93eb8d7e00304a6db)
> ==243045==ABORTING

FWIW, I just saw this test also failing in a normal clang build (without 
sanitizers enabled). In the console log:

2025-02-18 07:08:47,497: [06:08:47.588] Loading module 
'/usr/lib/weston/kiosk-shell.so'
2025-02-18 07:08:47,914: =======================================================
2025-02-18 07:08:47,915: vkmark 2017.08
2025-02-18 07:08:47,915: =======================================================
2025-02-18 07:08:47,915: Vendor ID:      0x8086
2025-02-18 07:08:47,915: Device ID:      0x9A60
2025-02-18 07:08:47,916: Device Name:    Virtio-GPU Venus (Intel(R) UHD 
Graphics (TGL GT1))
2025-02-18 07:08:47,916: Driver Version: 100675584
2025-02-18 07:08:47,916: Device UUID:    c5930b2b12677aad53343f8a072209af
2025-02-18 07:08:47,916: =======================================================
2025-02-18 07:08:52,277: [vertex] device-local=true:MESA-VIRTIO: debug: 
stuck in fence wait with iter at 1024
2025-02-18 07:09:03,142: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 2048
2025-02-18 07:09:24,640: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 3072
2025-02-18 07:09:46,192: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 4096
2025-02-18 07:10:28,665: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 5120
2025-02-18 07:11:11,067: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 6144
2025-02-18 07:11:53,619: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 7168
2025-02-18 07:12:36,397: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 8192
2025-02-18 07:14:01,431: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 9216
2025-02-18 07:15:26,387: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 10240
2025-02-18 07:16:51,349: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 11264
2025-02-18 07:18:16,409: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 12288
2025-02-18 07:19:41,439: MESA-VIRTIO: debug: stuck in fence wait with iter 
at 13312

Should we maybe mark it as flaky for the time being?

  Thomas



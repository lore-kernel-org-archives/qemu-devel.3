Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB83DFD88C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06BH-0007Sw-QF; Tue, 10 Mar 2026 19:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06BF-0007Sa-AU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:08:01 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06BC-0001jS-44
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:08:01 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a1273de95aso8108731e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184075; x=1773788875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QpnxpHAyjsumQQONTdWDImo4bIsDlmfX2AhU4bIxn4k=;
 b=Ho32CDa0YekUuNv+aGKtpRQk7bkY1X+D9cpKhm2kYpIutq5yAYLjXQyhMMiOHme2yQ
 gG5ZJSuSXryWd4dN4nVWs6wWL4oKZfqcKibzx+6oqFOSXgOxF+ynmOVL396zJvwWxJLu
 GYUZ904ifIVFbaDTzV8wk1hWTR11EDxVUYKTmxhQArsJDTZUvj3nCrTPrbuAytkT2lAY
 0ND8LffncNLrdN49SAvtkGPtVM6krxQvjQX7tkK9ZPVVCwaJkZjGsVnc/4DKKXMTp1Dd
 4+sb3HPc+/nBA22ytLB/e3DGpXhnKVvva5l2w9E6GiVeTWS9sb4XoHTEeibK5Kqb6ZGN
 9JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184075; x=1773788875;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpnxpHAyjsumQQONTdWDImo4bIsDlmfX2AhU4bIxn4k=;
 b=hHkCSkPJMS7vErWr8mx1F1XejXWjTBNBylnxjhkP0stOr8VrmZAUzclYMtL4+ND+QF
 flWMEDy9gAwqpbQXXSRwd6lNO0YM5E4FSce0Ubp9Ckv5ZN8jEOMogK7nRKrdrkkVzoYf
 ezaIbHhz3twW6Te8TXgoadzYOX3jpHiBZLCoEvZsCoepdmr/67FNzomI/baFbiUrA5jN
 XSGt4oKoIfFOnayVA4dDc/W6spHZmfyQmsuBA1Hs8IkKsazhjUr4t0Me5OO9FLt5ssXA
 tH3lEUuSfFQKq9dp6CYhL0fO4bw1av60xnszryxbLJeK9F4RdwgAYyklgYzyMgNFTuWc
 +tTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrTQ3opMJ46ZpyJPugeMp0Mfq8x8uO9R+LSfu6XqcPYjxNreJXe5uDPRVue7urWzdkiT6INlRKrodC@nongnu.org
X-Gm-Message-State: AOJu0YwMIJNBLNFtoDqupc2q3e73N8+0JFAPDW127DpiuQLYjH0LrQkz
 t+uC23IPmJY6z3cTDLYCrGZDvFyiOgCjpHadmh7UjkG0ENmGjurKDoLHYwg1rNENuxE=
X-Gm-Gg: ATEYQzxyhwcXKMP3eQLlktb4HIQTPNFjk26zOSMaCuiDPdS2fLUNs0frAOd4FzjafhF
 hTCj50ywtUm/kaSSNhMRJQP+TH3qaRz1JbC6pPyLEs4C6UBt7ExsRocDTH8I7u1YbTPxQUyUzoy
 a55isfStnynccPpo7/yxbzslpnIqWL08layjKxiVtWGJoI3nmkHypUiwtALhKerOX2i6bcY6Vtm
 CbQ6Fs26BKv5y4Cn3RH2KDfWC8ixEdMChDOcnIueFsvOhKdFAWzDVqqemgvcwd2UFj9aNLsQJSs
 aNwHbSnxBHfr3Pz3dI1nT3Yza36AithcY73zEW5e+ORrR9YUpr6M5GBUMgbMlHOjF6CfJ/yzJIw
 KouywKmx1UfF691PReSdbu/skw16v8gUfhSCzimbysWEOcfyKwR12YFekWc1hjWqVOj+n1pHbtO
 zeXnxRWnlXWvxbLK7tUC4DCcbzQFhPFO8N2CDCUvwaBkmxI9LuODXFpM9zkSmYh7ansA==
X-Received: by 2002:a05:6512:6399:20b0:5a1:2e14:134c with SMTP id
 2adb3069b0e04-5a156ba055cmr64971e87.5.1773184075137; 
 Tue, 10 Mar 2026 16:07:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15602e239sm89267e87.23.2026.03.10.16.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:07:53 -0700 (PDT)
Message-ID: <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
Date: Wed, 11 Mar 2026 00:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
In-Reply-To: <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 10/3/26 23:33, Philippe Mathieu-Daudé wrote:
> On 6/3/26 17:17, Alex Bennée wrote:
>> This allows the gdb integration tests to be run as well.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>>   tests/lcitool/refresh                                 | 1 +
>>   2 files changed, 2 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm getting:

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x45001fff
Error occurred in Python: Cannot access memory at address 0x45001fff
qemu-hppa: QEMU: Terminated via GDBstub
make[1]: *** 
[/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121: 
run-gdbstub-prot-none] Error 1
make[1]: *** Waiting for unfinished jobs....
qemu-hppa: QEMU: Terminated via GDBstub
warning: Could not load shared library symbols for linux-vdso32.so.1.
Do you need "set solib-search-path" or "set sysroot"?
make: *** [/builds/philmd/qemu/tests/Makefile.include:66: 
run-tcg-tests-hppa-linux-user] Error 2



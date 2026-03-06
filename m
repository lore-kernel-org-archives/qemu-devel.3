Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D5FCC074
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyc7X-0004P3-G9; Fri, 06 Mar 2026 15:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyc7U-0004OX-11
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:50:00 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyc7S-0000oG-7j
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:49:59 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cb38e6d164so1243750585a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772830195; x=1773434995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jG6299/DHJoC7YKzIWxCFSB2INsmATtdrPj9lvpSrsM=;
 b=ZIStK+vppLRqWTaevK4bLp00h5ybv63kG7TkDZUqvunYCzrF7aqQPPpw6SI72g/ebu
 QX2WEE/ias5G6nk8J46f+yOReAW5ZDud3jT4OHD6FXROUKhNZks8OxzDFjBoP6Ohzeld
 I/Tw8RIPV8rWO9SHST5gsHvjA0KabUOrbee3M3OehgvT9tu0+IQAmJPjS+5TEUJzkSzD
 9XX1DPO01/RH0MbwjphyuguN7e4vIOeWaNpm2XzZkhE6MIQFH3kZUvOJNyIssjXQMTCb
 9KXHRh2mGq2uKS9WmNZ/nEEU3eOMbWtjeDW4J9y40VNGwpkPZLao/mjvjt6Ovzo2X820
 Ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772830195; x=1773434995;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jG6299/DHJoC7YKzIWxCFSB2INsmATtdrPj9lvpSrsM=;
 b=mFd/zUloKLbksKNS5HqLPtrW8pbhcbKiyrToetfbKBpnE8zIsI/kXwpxnggPGvbxix
 HRtwkpnXP0XKAIohhNcumMfmFfod/C+3a+JjRmFB5gxkqQokO2pDK5G+7Zi3BKn/M0ZA
 VGCcU9dee1poPVxT1Lr6awZwVkIhEZGBe1z/MGzzsNSFIe4z2Z+DjjWLmiIQ085tszbd
 iTLL01vranWzRDfwh+e5wd5bKKFsFTymiiQd03HRSPr07cGaQHm0I7yfctgkb1DrC9as
 Y3pIciXuBsew+lmwBjQOU02YOFplKGL5UHeNgr3psrSv27RUZjMrkS+qBCcQlMa+239e
 LmLA==
X-Gm-Message-State: AOJu0Yyf0hDqZdgLT3So34tES5qq5hds7DLIcUfIWufrncW+XfcTinH1
 uChIjLS17cfZ8mT2Atq1Vrx12E/cEATGF76gKGZ4HSqtPItzswdi/DgWz7g24rSD02k=
X-Gm-Gg: ATEYQzz1x2ksjMJJHciwxcbe1Z/bng78LvYHa/vfdVuO5fqLrF9Trvu+DfRCtVr1Cu8
 NfEPf4GHnXK8zzYkY2x6BUS7nwe6z1owmKA4Do+OIMnvGdWIIIsLvuLOSQbpmA7/Hv8EDnBbZlV
 P6le3LH3W6x11Ie2Y/gkKzxjx9QymCcqxY1pOYwoDN+D+Rnbuql/EFqeG3JkAM92UAzUZukJfSC
 HNMwbb8Y6u8nvuGUiGrNqg2rh8CGvzkWcDPQcOWuT/NM2JOVp9kapk8DLdy25ZjdPzULJ32PrWO
 1LI/WxaBmUbutjHF3FMxVdii5eHWm5T/kn7D4X8525EJg6lriz+VgtsHtpq6dX/g6NWt0q93A50
 2Av4Nx3K5AKxomugV7DkC3ajnmHGSEHxvAleBV7J0KJrNQNrHuEzohtm2BVV5NYLwGpHq20Zj5F
 tLHdT1czFhd4OCn+30/iDdp69LdqVz2JADuSnvjkUQPwx89vVMyS5uyMod7gNtcnBe7/H0
X-Received: by 2002:a05:620a:2986:b0:8c9:f996:81fd with SMTP id
 af79cd13be357-8cd6d43d168mr484878985a.33.1772830194522; 
 Fri, 06 Mar 2026 12:49:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd772f9f9bsm17905285a.24.2026.03.06.12.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 12:49:54 -0800 (PST)
Message-ID: <8632339d-f8ad-4162-a940-9310434e0219@linaro.org>
Date: Fri, 6 Mar 2026 12:49:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/tcg: allow filtering of TCG tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-3-alex.bennee@linaro.org>
 <5342a38e-ee34-4d52-928c-e60028848e2b@linaro.org>
 <87v7f8n6un.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87v7f8n6un.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/6/26 10:36 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 3/6/26 8:17 AM, Alex Bennée wrote:
>>> We have a lot of TCG tests now which can be fiddly if we just want to
>>> check one particular test type across the targets. Introduce
>>> TCG_TEST_FILTER to allow this:
>>>     make check-tcg TCG_TEST_FILTER=gdb
>>> to run all the gdb tests across the suites.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    tests/Makefile.include    |  8 +++++---
>>>    tests/tcg/Makefile.target | 12 +++++++++++-
>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>
>> Ideally, we should have a list command available also, so we don't
>> have to guess what magic pattern names follow.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> If you run "make help" in one of the TCG test dirs you will get a list:
> 
>    ➜  cd tests/tcg/aarch64-softmmu/
>    🕙18:35:48 alex@draig:tests/tcg/aarch64-softmmu  on  pr/060326-11.0-virtio-gpu-updates-1:master [$?⇡]
>    ➜  make help
>    tests/tcg/aarch64-softmmu: -march=armv8.3-a detected
>    tests/tcg/aarch64-softmmu: -march=armv8.5-a+memtag detected
>    TCG tests help aarch64
>    Built with aarch64-linux-gnu-gcc
>    Available tests:
>      run-asid2
>      run-feat-xs
>      run-pauth-3
>      run-semiconsole
>      run-semiheap
>      run-vtimer
>      run-mte
>      run-hello
>      run-interrupt
>      run-memory-sve
>      run-plugin-hello-with-libdiscons.so
>      run-plugin-interrupt-with-libempty.so
>      run-gdbstub-memory
>      run-gdbstub-interrupt
>      run-gdbstub-untimely-packet
>      run-gdbstub-registers
>      run-memory-replay
>      run-gdbstub-mte
>      run-plugin-memory-with-libmem.so
> 

Yes, but I was more thinking at something from the top, without needing 
to dive into every arch.


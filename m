Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF886CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 18:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4kAX-0001GL-Iu; Fri, 03 Oct 2025 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1v4kAM-0001FB-Ba
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 14:06:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1v4kAC-0004jM-6q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 14:06:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-26816246a0aso3354725ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759514739; x=1760119539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2YcG1705TfF+KXSCQpXW05rps93tHKK5RZuX+CjfwKg=;
 b=VcdtIaSYFhy8IP48UfRsFDWTEnl765DWESb/Qvpjd+cBNyIZrxejhdBCVI0uJM8ArH
 jw4OisHZwurVeYYQYGRnMtABxk+LSm0/8ZobeZUilH4luL+s8C6ql5UeJ6rl6sEXI3o6
 yJfOndS3c5gifTrBt9lRruv3CBDpEnyLNFHHlTY7gn8pVSrJd3sNiyA3mEeFC5FseNOA
 VhFPBaig2INsdOiWpTvyalNuJU9AFyhOFxfKj8TrkTfx6g6i6UpWGFiBDXJ9Mtkin1sC
 52gASeuveHLbq9SqB/NCdM9zEksWRYvIAeTnr0CGN5KujsSMF8Qut9bZ/YpH2hZGLzAw
 Qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759514739; x=1760119539;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2YcG1705TfF+KXSCQpXW05rps93tHKK5RZuX+CjfwKg=;
 b=BOwaeT7fkMgkGQ/084yx2pAESh44Eqj9XjKnsYuZv4C18qvePyTxEGBdb3I4TkObVx
 0J9MF07CQVbqTko/6hsIf6AzsqwLVk9ZKCx42Fek6oaPjNxUvXClO/7l7zeKU11m1xfS
 g6S2BR6m5TngsjgoSpI0n8sExf8VepDnmrZ8Pp3uBmvaDCugrBHm/OuQkI9KHBzqqXeC
 eyXZGu32FANY/OyhdcgU9GPWUOpTKCFtol1JbZ7l9P55pa31TQCBaSn8Y0dkG+piRXo6
 F3BBGVhsT7iVSMPGLNtYjNKY5xYu8FS3rwnZF30mxFvvVr7CdXwr3Jn8kOtFI6KDFiHj
 HgBQ==
X-Gm-Message-State: AOJu0YySHqyh5VqdZjn82cyfSv+Jdmd41dqaPF8Aumor3Jlg9LilgMkO
 HIfc4isLG0GwapEwVsCS2S67tGdZQ4iT1bcvE1MI6xyHi0UpuAkNvCjD
X-Gm-Gg: ASbGncvWZF1O8vXaxCaB7VdpO8dhtcFTmi3+6fdXlfSc1ouA6FLPzs2cSPfYTPrwMAs
 Rv+S2k4CicGsdE5DM8cBcCsWq+GJ//JgFz//3SuRmvqUSnFw34q4YgAr62cW98vaFPg/11ATnVW
 wRGOzokGKcWiL1wskeErwf1gaiNYgajOrf9d6R30HUMsfEbK4BAG68NsXj7P0+QWh9h6NABqaYB
 +DkuTOn+1OgbERi1UyF2y3jQsYF6wyMy9xPO+mESW3Gd0skTuiOufprb7mL0AKU0uhDBhIVFXpP
 zHN7MnctI7H/KJBdIym7cLntpOTTvIwkKjBvW5rQinhHbfCkqNpm9mLg2QD70F6FBH77gQl7hy3
 eDIQl/sOKA6/KNDcW+g6+A5JkmHUG72p0fXoehfYT1uofWQ==
X-Google-Smtp-Source: AGHT+IGimgRIeVowsGKmNmiqRZZD7SUfHNeLmxNMFvW7DMncC/pJFMKH2vVw/XsZzG3l3aJnXpdoRg==
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id
 98e67ed59e1d1-339c27a2515mr2389193a91.4.1759514739219; 
 Fri, 03 Oct 2025 11:05:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099d4d324sm5394429a12.27.2025.10.03.11.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 11:05:38 -0700 (PDT)
Message-ID: <202c4604-61f0-4d6b-8518-cb72726f2236@gmail.com>
Date: Fri, 3 Oct 2025 11:05:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: alpine docker configuration fails rust tests
From: Richard Henderson <rth7680@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <dc2a1732-5e85-4616-8304-28d00e83df35@gmail.com>
Content-Language: en-US
In-Reply-To: <dc2a1732-5e85-4616-8304-28d00e83df35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rth7680@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 10/3/25 11:00, Richard Henderson wrote:
> Hiya,
> 
> Our Alpine docker image isn't quite right, and fails testing for rust:
> 
>> Detecting compiler via: `rustc --target x86_64-unknown-linux-musl --version` -> 0
>> stdout:
>> rustc 1.83.0 (90b35a623 2024-11-26) (Alpine Linux 1.83.0-r0)
>> -----------
>> -----------
>> Called: `rustc --target x86_64-unknown-linux-musl -C linker=cc -C link-arg=-m64 -o /tmp/ 
>> qemu-test/build/meson-private/rusttest.exe /tmp/qemu-test/build/meson-private/sanity.rs` 
>> -> 1
>> stderr:
>> error[E0463]: can't find crate for `std`
>>   |
>>   = note: the `x86_64-unknown-linux-musl` target may not be installed
>>   = help: consider downloading the target with `rustup target add x86_64-unknown-linux- 
>> musl`
>>
>> error: aborting due to 1 previous error
> 
> But what's even more annoying is that --disable-rust doesn't suppress this check.

Bah.  I was too quick to point the finger.
It's a different part of the tooling that's in error:

$ make J=8 V=1 docker-test-full@alpine EXTRA_CONFIGURE_OPTS=--disable-rust
...
podman run --rm   --userns keep-id   --security-opt seccomp=unconfined  --net=none -e 
TARGET_LIST= -e EXTRA_CONFIGURE_OPTS="--disable-rust" -e TEST_COMMAND="" -e V=1 -e J=8 -e 
DEBUG= -e SHOW_ENV=  -v $HOME/.cache/qemu:$HOME/.cache/qemu -e 
CCACHE_DIR=DOCKER_QEMU_CACHE_DIR/docker-ccache  -v $(readlink -e 
/home/rth/qemu/bld-pub/docker-src.2025-10-03-10.56.14.1004950):/var/tmp/qemu:z,ro 
qemu/alpine /var/tmp/qemu/run test-full
...
Configure options:
--enable-werror --prefix=/tmp/qemu-test/install --disable-rust --enable-rust

Clearly EXTRA_CONFIGURE_OPTS should be added at the end.


r~


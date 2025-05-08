Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7630EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 17:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD4gg-0006m0-Qv; Thu, 08 May 2025 13:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD4gc-0006gt-Bi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uD4ga-0004uc-14
 for qemu-devel@nongnu.org; Thu, 08 May 2025 13:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746723926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bk/5CUbdSFAIH7x6Jt0goqqN9wx6J5dx2xknYvtLRYQ=;
 b=O8Qr1vLqRaZzHRbVRmvciGVFhBAsM7nruCzo6YccjYMMwLAWPzAQk8rQqjChxd+Cld1QE2
 xK5EsmHsB7hevmweDkQDzMdl864iEmWqZP3ofju4pNH1mKeL0Nkl0IXJaSrEdQGNnR0WYF
 n66f/VpdAbGSLrHPt4ndExVW+Cq6wIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-wcJqNOeSNT-Rp79v6Qi_cw-1; Thu, 08 May 2025 13:05:24 -0400
X-MC-Unique: wcJqNOeSNT-Rp79v6Qi_cw-1
X-Mimecast-MFC-AGG-ID: wcJqNOeSNT-Rp79v6Qi_cw_1746723923
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442d472cf7fso3811165e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 10:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746723923; x=1747328723;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bk/5CUbdSFAIH7x6Jt0goqqN9wx6J5dx2xknYvtLRYQ=;
 b=BzZEoM6IMNgRzbU1t60FW52+YiiBfeLv+GgCHrjQgGT3vEV0LHf+bazCZRE4Of+rWX
 I7rhnIc0mH1c0vdxyu1rNvOmFw6Hl6Jr9np9ZA1w3dex3zv1IAVjieA/pDRNJ6QGZObh
 XeTS79UTeDLg0nXHdyqRXXMI8SOPjtktstWAYXFqXa+cdCTaF2qybhx6v9u+byc8+Qjb
 9Ix1+ufHVAj8GJdxhPC60z6NEyT43jc4T8yAF3BrPcXNPjgU3+IPW9lZSWWmmWCIOA6h
 KbsDqyp86BsTATveWS8S2XcUZd0PR/AR+JOOJ74Nz4rEyZeQUopnGd/NfjMPQDI2e0Ch
 f5bg==
X-Gm-Message-State: AOJu0YwmeAL7rps2bNGvVEXxeVZkaQdNwa4ovlnQ2dfqhFp37XzoMEkC
 4PWgH3TOzcoE0SvmGArMw67fs5sOhw/Z0roTAo2p0DXIuJBaulZQd1tpLZWF/zEfssI+T4J50+L
 H1RzDnhRHN+DIFWD3usV+nZNurJRprL3K9Y+WBZ4gJRFY0A4WbAg7
X-Gm-Gg: ASbGnctuoLAr7jtvg7ymd1ypJDMs88lvIvj1N5KPG8d2rZkAcM9zm32NuZOoV16mBrX
 d9c5BOeEz1KHFXPtiCQ9KLXPPdHnJsb0p38owMJnB33j1xQAuBqVgBzQQAguEgVYdtxcCeprlUw
 tc+Nfmk0nql99ht8EZ8AsAS+37EjykeZV697B/AJce5mPdPH+lwoX0wDZhHtEuQ3eslGEUzemT/
 9lVnLAW8K7L8CBesJnK3/pGDWXE6EeuieiL0cY+dFCF95A8rdi9mk7UNJfjLZtDw6GyIU0phDNX
 EDDPCm8WIlMqn4AHAjsvZbZ3YTckaykmheCN42QXpcT1qV0Phv/M
X-Received: by 2002:a05:600c:6307:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-442d6c36448mr938805e9.0.1746723923438; 
 Thu, 08 May 2025 10:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhmFZ+OMhihO+7dDdSbFmljHL1No6uBq89KXxAZ5kAC1eg4NHW4AACg/iFxWUSORXw82Ne3w==
X-Received: by 2002:a05:600c:6307:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-442d6c36448mr938305e9.0.1746723923100; 
 Thu, 08 May 2025 10:05:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2f4sm488276f8f.78.2025.05.08.10.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 10:05:22 -0700 (PDT)
Message-ID: <1ca26b2d-91e9-408a-885e-87b8ef1ab944@redhat.com>
Date: Thu, 8 May 2025 19:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Rust, wasm changes for 2025-05-06
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <CAJSP0QX0wL1qJzfMoH6Di+QY3K9ML3HTLeY2gXZHNNJm_jDTTQ@mail.gmail.com>
 <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <70e9c1a7-b586-41f3-a500-347483f6c1d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/05/2025 18.08, Paolo Bonzini wrote:
> On 5/8/25 16:26, Stefan Hajnoczi wrote:
>> On Tue, May 6, 2025 at 11:30 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:
>>>
>>>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu 
>>> into staging (2025-05-05 11:26:59 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to e6b9b79c3076777b791f72ebdbc9d37ad8005fe9:
>>>
>>>    gitlab: Enable CI for wasm build (2025-05-06 16:02:04 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * ci: enable RISC-V cross jobs
>>> * rust: bump minimum supported version to 1.77
>>> * rust: enable uninlined_format_args lint
>>> * initial Emscripten support
>>> * small fixes
>>
>> I'm not sure why, but the following CI failure seems to be caused by
>> this pull request:
>> https://gitlab.com/qemu-project/qemu/-/jobs/9974291215#L4684
>>
>> Please take a look, thanks!
> 
> It is a transient failure; it reproduces 30% of the time with
> 
>     meson test --repeat 100 func-hppa-hppa_seabios

Please not that you should use -j1 when using --repeat ... otherwise the 
same test will run in parallel multiple times and the instances might 
destroy the output files of other tests while running.

... maybe we should put each test output in directory with a randomized name 
if we want to support that way of running the same test in parallel...

> even without the pull request (commit 
> a9e0c9c0f14e19d23443ac24c8080b4708d2eab8).
> 
> Before finding this I had already sent the first half (which should be safe 
> since it's all Rust code that isn't compiled on that runner---and for hppa 
> targets in general), but if you still have the merge commit perhaps you can 
> push it?

Looking at the log and tests/functional/test_hppa_seabios.py, it seems like 
this test just fires up the hppa BIOS, checks for some strings and that's 
it. However, it seems like qemu-system-hppa quits completely if the BIOS 
cannot boot from any device - so it's likely a race: QEMU quits too fast, 
while the test still tries to talk to it to shut down QEMU gracefully?

If I'm right this could likely be fixed by simply adding "-no-shutdown" to 
the QEMU options here...?

  Thomas



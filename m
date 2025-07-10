Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D834C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtik-0001t0-Vu; Thu, 10 Jul 2025 12:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZtZ0-0001IQ-RM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:52:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZtYy-0001cW-E7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:51:58 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b34ab678931so931406a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752162715; x=1752767515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cx0adoOA8S0+udYRdUtLCKMOxl8ycJQfFtUzJnp8YfY=;
 b=HEJczCakkFrDYZiBe+wSVkxBSYtFutApuXC9kyW/+I6nAPeIebldVgN0bdXmdO+aL1
 /HsgCn5vK44jknggDUJ9cT7TGD9PVQRIKZAicaXENzrqRDztHAwXVGWKGpRtGHtJWEZj
 s5/niuHLxE0kzbSokYZ/Kq4W74pg4hpjFWz52z1Z3HIGJEIqM7fB8FgpOarm+bbaCTVv
 00pqKyeaOPgl+atGl1fJVtJY8yvAaP4YXSgX+IlNaLQd/3utdOrnBbpgLjjGb593KMpE
 +ftmtuYgkXoELZKCtLQDnzILL+T/D/KqBEa7vMrRjkaRLNHHVos0BJmGHuZNqXLxu1OE
 Botg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752162715; x=1752767515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cx0adoOA8S0+udYRdUtLCKMOxl8ycJQfFtUzJnp8YfY=;
 b=ZlOiinImhssy+vYaFhlm6JHbCJBJOlknWh5JJabzwntIaM93QSte/fliGtC2bLv60h
 YvFkE6ESQ00D3tTEAYWo/aYynEDJi4E7Xrxm1JksvwG1NFVnwzjU/bYFDEY6Hubo3pVY
 ldrimQFYXBYPz9XxnrMgI2e7ofbl9QWlJ8Z5GdHIz3N9dLyu8Q6DRkcmHgaTwScHOTwD
 4d7Ht7QJFDnnCe2kVSl1pD5J+4lemVNZkr8KFLcF5TjmDqd8PDjMvf5gasdGmIgofUqP
 pKPVF2VPiXtx0DYdZgr2huNeTZQ4LpC4U+3tL/9qtRc13h7UzO6EDrqg2T7zc8Sjx+jJ
 DWKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaHGaolELJ8FeHw/vcdRhnUmePGj3srh9Ewv6a5rTC3liamgZgqdEB/zlq6B2sJrusWwRCU5oQ6q6R@nongnu.org
X-Gm-Message-State: AOJu0YznZ4Iu74zpi9r4GAggE1i9Qebu0BV7FF7nw8ew2BNmRsVwCQfj
 +oFp8s9lCimBha+j85u9bS0BxkA5bZEjNVXiT6HDwl3dRf0AL8Bq5RHZ9qQyCGquEXk=
X-Gm-Gg: ASbGnctKnfJY9dzBblGHe70/dRq7C1V1mj1CGBlMKSC91dLXv2IwEu+iFH0PnRXiTjl
 kI3mXYDeZ/qjWPU4BwcWMlaUJkKTSLNWSwiHYnQhoZWoysjz2HmTeDluDGmlWPxTq2vb5zcoZSN
 /iuXGmtl2wgv6IGO1SJTqTnXmrgezAu50XVgR6qrkD9trq4IrGEjAhuPQ1/GKkXPezqKwIpxodP
 3UCqmBonYzpdG1W0MzqAxgaQOl/100jrbEbWZMWu9a9XLHd9T9wX+mkMbhv1iMrtzSWamVL3T3i
 B48trs3gww74VLxoS4ENl3r7eHMr+qkRt6TKi1legAeoA+MhhNKzAraPfs+yGHKscfEvfq2SecE
 =
X-Google-Smtp-Source: AGHT+IE5lDrdF/uv9cFbJ6ck/iI2yiXEZOwOjA7BFlDqLJZS50Kv/p5UQz2NeetzJdZ8LYZqT9F9jg==
X-Received: by 2002:a17:90b:57ef:b0:31c:15d9:8aa with SMTP id
 98e67ed59e1d1-31c3c30cf27mr5886169a91.34.1752162713076; 
 Thu, 10 Jul 2025 08:51:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435b76dsm23049375ad.221.2025.07.10.08.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:51:52 -0700 (PDT)
Message-ID: <643f1db1-4a7a-4bc0-a187-9ff1561f8a3d@linaro.org>
Date: Thu, 10 Jul 2025 08:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250710094251.139514-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250710094251.139514-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/10/25 2:42 AM, Thomas Huth wrote:
> This patch tackles two issues. First, the tests/functional folder has
> become quite crowded already, some restructuring would be helpful here.
> Second, we currently encode the target architecture twice in the test
> names since a lot of the test file names contain the target, too.
> This contributes to the very long output lines when running "make
> check-functional".
>

I agree with the "crowded" aspect of functional tests, and subfolders 
are definitely welcome.

Concerning the long line, it seems that setup ("thorough" in this 
example) is repeated 3 times on it, which is a bigger issue than having 
arch name being repeated.

A simpler solution for the "long line" issue would be to change 
mtest2make.py to generate shorter test target names. This would not 
benefit for using meson test directly, but from what I understood, this 
is not recommended nor supported anyway.

> So let's move the individual test files to target specific folders now.
> Then we can drop the target from the file name (and thus from the test
> name).
> 
> Before the change, the output looked like this:
> 
>   ...
>   195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-microblazeel_s3adsp1800          OK                2.00s   2 subtests passed
>   196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_replay                    OK                2.78s   1 subtests passed
>   197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_s3adsp1800                OK                2.02s   2 subtests passed
>   198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_fuloong2e                       OK                1.95s   1 subtests passed
>   199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v                      SKIP              0.07s   0 subtests passed
>   200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_tuxrun                          OK                8.52s   1 subtests passed
>   ...
> 
> After this change, it gets a little bit shorter:
> 
>   ...
>   195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-s3adsp1800          OK                2.12s   2 subtests passed
>   196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-replay                  OK                2.90s   1 subtests passed
>   197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-s3adsp1800              OK                2.07s   2 subtests passed
>   198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-fuloong2e                   OK                2.05s   1 subtests passed
>   199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-loongson3v                  SKIP              0.07s   0 subtests passed
>   200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-tuxrun                      OK                8.84s   1 subtests passed
>   ...
> 
> Tests that can be used for multiple but not all targets (like the "migration"
> test) are now handled via symlinks in the target folders.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: Marked as RFC since I'm not that happy about the symlinks yet ...
>         if someone has a better idea, please let me know!

Same as Manos, correctly extracting common code looks better than 
finding a workaround with symlinks to satisfy import rules.

>         Also the update to the MAINTAINERS file is still missing - I'll add
>         that once we agreed on whether this patch is a good idea or not.
>

Thanks,
Pierrick


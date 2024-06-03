Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8252AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9a4-0003F4-EB; Mon, 03 Jun 2024 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9Zz-0003Bm-DR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:26:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9Zx-0007gg-KA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:26:35 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a30dbdb7fso4788635a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717428392; x=1718033192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iuosf3PQAILB4/Pob0XC/K1T2rd6IjBu4lJTbzrZTsg=;
 b=hqBW7OEeNUOP687lsvrrvAuUBAswRQ4LficDs5W2vmGEyURP/e2toLkjabgTnjEM48
 ysB5g0+l4nnZh+sIGxOm3hvdZS0QhZkNe3jSJn6zTsnJ6CPs5Eu4kFALIeYvLHfnZreE
 AhsoWPyivJwKYckmjzaUntnpbbqof38+AQTlDyIrl075Z0dqekuokhHQOv/r7zgr0LgU
 /cMtA6wo2kVL7Q8kEx0OqP2SEdt4uUvOQONYOrXhRKiKr0ZbD5bqqfeTv/kYj4j+MrOz
 X+bRzH7MdWBdm3ihXxixA0XVtIYwfQKN2jZwI5aA/HJZV2u670BEGWLHxedS8o6yBL4l
 KrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717428392; x=1718033192;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iuosf3PQAILB4/Pob0XC/K1T2rd6IjBu4lJTbzrZTsg=;
 b=LupxASpn8htzwKjFBoMK8smdRi6qDKChFDjxAzhWdS0dpsY4Uis/MrqxZX2aEUnWl+
 6YH2mJf7m7tSGDhXnnkXH7XkFgsGTxXUVvWN25FDWnLJd+QdXmiNVN6g5tXc1sNXKcAK
 ssvaLnUcRQ8HhuXW9FU7G95xdWkZFf6c0kACTN2L+cbO1S8i4ylcRMZ0H+z3T8I2IopA
 ZFhF7kksenhC+fJLq4v1nOzk7m8i+GFyBmjrm1IRl0u0lsVp0hO7NcIuZ/MuqxgK8mwi
 5dvuyVgBZFeIL4sZUvc6kk3ZuaUe4HaAQQCgBUOeSqS8LBf4WSjt5SZjv2bn6UQw/M//
 lixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtpQgQfjtrULkXo6tCH5MdqoZQG2PXf4LdiNDY0YpE0v9FDKgvxa5FOlUhWJlqqhzVxpvfBPNjPRdegyY+Uxa+uvWzwBc=
X-Gm-Message-State: AOJu0YxszaxnzJ6UyMzra3gh0xs2AwMDXFC2HeQuIo2g8QITtQ6jx47D
 fTDqUPmg9F+e61meKNTIalkuW/YpaMFXZ5axf+B9QEHFCb9Bf5b0Sf7Oy8kp4mI=
X-Google-Smtp-Source: AGHT+IFDkpFTO3TVP19Rgw7xu7C1A6wxzioKLaOiZWr435VhCqSowj/AGiaVgE6GEWxNQmGz4Y6kGQ==
X-Received: by 2002:a17:906:57da:b0:a68:f1ca:a8df with SMTP id
 a640c23a62f3a-a68f1caa98bmr288254466b.71.1717428391812; 
 Mon, 03 Jun 2024 08:26:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ae9bf7e2sm380474966b.213.2024.06.03.08.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:26:31 -0700 (PDT)
Message-ID: <910d4931-4e03-446c-8ff2-d4ec41944fbb@linaro.org>
Date: Mon, 3 Jun 2024 17:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
Content-Language: en-US
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

+Alex, Pierrick & Anton

On 11/5/24 22:26, Jiaxun Yang wrote:
> MTTCG was disabled in a092a9554771 ("configure: disable MTTCG
> for MIPS guests") due to test case instability.
> 
> I was able to reproduce this issue with in latest QEMU and look
> into reason behind that.
> 
> What actually happend is kernel's CP0 timer synchronisation
> mechanism assumed a consistent latency in memory access between
> cores, which TCG can't guarantee. Thus there is a huge drift in
> count value between cores, and in early kernel versions CP0 timer
> is always used as sched_clock.
> 
> sched_clock drift back on some cores triggered RCU watchdog in
> some extreme cases.
> 
> This can be resolved by setting clocksource to MIPS, which allows
> clocksource to drift together with sched_clock. However this will
> leed to other problems after boot.
> 
> Another option would beupdating kernel to later version, which
> will use GIC as sched_clock.
> 
> In non-MTTCG build, the execution is slow enough so kernel won't
> observe back drifts.
> 
> Test results:
> 
> With clocksource=MIPS
> ```
>   ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>      -display none -vga none -serial mon:stdio \
>      -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>      -cpu I6400 -smp 8 -vga std \
>      -append "printk.time=0 clocksource=MIPS console=tty0 console=ttyS0 panic=-1" \
>      --no-reboot
> 
> 100, 0, PASS, 5.258126, 100, 100, -
> Results summary:
> 0: 100 times (100.00%), avg time 6.508 (55.53 varience/7.45 deviation)
> Ran command 100 times, 100 passes
> ```
> 
> With linux-next:
> ```
>   ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>      -display none -vga none -serial mon:stdio \
>      -machine malta -kernel ~/linux-next/vmlinux \
>      -cpu I6400 -smp 8 -vga std \
>      -append "printk.time=0 console=tty0 console=ttyS0 panic=-1" \
>      --no-reboot
> 
> 100, 0, PASS, 4.507921, 100, 100, -
> Results summary:
> 0: 100 times (100.00%), avg time 4.233 (0.04 varience/0.21 deviation)
> Ran command 100 times, 100 passes
> ```
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> I'll leave the test case alone as it's already marked as QEMU_TEST_FLAKY_TESTS
> ---
>   configs/targets/mips64el-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
> index 8d9ab3ddc4b1..199b1d909a7d 100644
> --- a/configs/targets/mips64el-softmmu.mak
> +++ b/configs/targets/mips64el-softmmu.mak
> @@ -1,3 +1,4 @@
>   TARGET_ARCH=mips64
>   TARGET_BASE_ARCH=mips
> +TARGET_SUPPORTS_MTTCG=y
>   TARGET_NEED_FDT=y
> 
> ---
> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
> change-id: 20240511-mips_mttcg-47a6b19074b3
> 
> Best regards,



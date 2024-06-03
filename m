Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E1FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 18:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECDJ-0005Pf-0j; Mon, 03 Jun 2024 14:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECDF-0005PM-7u
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:15:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECD9-0006VB-WA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:15:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso214535b3a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717438509; x=1718043309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvfXxxZU3SJUWuSQ3mKhNHtEqPZa3igYEuAdMvPvdH0=;
 b=L+5G7y23EeCeORRDIXF8JZSQ2H3dKB1zmhxBddD4eOFOJRssFpaO1itrfl+jIHFNI0
 UBkqpphPCDUsxjDURM0QmGtvMdtjze2Q9+fasezlX58FKsudCycCdw7X64tHMou5z16A
 Mt14CfBp54BzHtHDv+6mjNyiNhMRxHMOiubNOReH5g9unWlhiMwidM3fa62/kcI2kvDg
 Zm1g7uFsroY/qzFBmi/yV5IhtCC9H7uXIr/1YQgn85VILqC92FMcmlS/MWJ0Z6gAxokn
 XuN6CjRhZBSpGiX+x/aRNtYOKSguzPzn3ANiB4TlJWsbGhqnnl6XQGBtaihakwmLZdIg
 Mrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717438509; x=1718043309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvfXxxZU3SJUWuSQ3mKhNHtEqPZa3igYEuAdMvPvdH0=;
 b=ZmQp3Bvo2NWCepU9oNRIj2qDwrv/iFKoq6Er7BtTSurNYEkxr6gW3drNbD7ZgXrTEi
 7BIgl/zt3LLDh+KJyY4HmVaXPpQig7Bi16Lj00llaoOxN8uZYPZsiVCTejlCS+Rzduy7
 GhOZvH4HDS5h9Ulfi0GjQxJcpr6HMcAUsLwzWHmsM13mDzg/RyJRhXB+tmOe4THRklfY
 y9RMAtLlSWrzs0uUmQbin5Uao2oDRlOb6glrRwCGu/nDdA8SzaJJdipv31HDLTW54gwe
 /uhCJ3OcqHEULJMZDTDIxrb0KbwP9jgNSa742CFtnzA/f5O3ytiZGthd8q9GfyGayBJz
 nSrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu/2rER4ROEO/oJXhnh51q1WWiQRQL3GOC9zSrszgg8kdH5KpEyYvjjcwg1F2CEWooojhxz/zjf22TUdAIDjcd/MSAugA=
X-Gm-Message-State: AOJu0YxKqTFFHzI3vEbq878XfHsf5iko4oV+saXJKI/v6p1DbKyGAO7j
 vmplufmWlY+TqllBlEolqsY8GP7Xe22Ac+wOCytK1y6o6cDt+1JVYLsQxwsw91w=
X-Google-Smtp-Source: AGHT+IHG0/GyJ4Jlml+oKxhNNRpVmrNB25mx9Ore06F0f64Fur2jUjOvFrV1UGWV3bilQztkHTDJ2A==
X-Received: by 2002:a05:6a21:99a6:b0:1a9:c4ca:dc74 with SMTP id
 adf61e73a8af0-1b26f0e6242mr12328748637.5.1717438509018; 
 Mon, 03 Jun 2024 11:15:09 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c856dsm5773787b3a.21.2024.06.03.11.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 11:15:07 -0700 (PDT)
Message-ID: <f1e66166-0e06-4a02-8d88-9faad1f0274b@linaro.org>
Date: Mon, 3 Jun 2024 11:15:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 5/11/24 13:26, Jiaxun Yang wrote:
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

Hi Jiaxun,
Thanks for your analysis!

We should see to update concerned test in another series.
I'm not sure which way is preferred between updating kernel used or 
changing current command line.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


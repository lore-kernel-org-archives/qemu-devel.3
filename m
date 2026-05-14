Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06FECD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 09:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSb3-0003Wh-CC; Thu, 14 May 2026 05:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSb1-0003WN-0j
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:43:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSaz-0005ux-CP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:43:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso6300018f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778751786; x=1779356586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBn5tkuugQF5z7V7RcBEAJ6Ks/xAqPe+17uxF5PtAFk=;
 b=bveom9qgDlbZh8LOR9ddHRiOhgEUnrds4Rl4eT72QHjncMHKTSf2nDOK7ypEDENiRq
 b0NakcWUCmAFWYHhovJ7woYwmLdPk1mxtctXJX60zbwvhAiK6n7JkSPlaxGfUG12JjMI
 jaMdQvbFjJsaMaYfToC3xNYxVmyIqQmPOgAhAKSA4LLbu8xeuo89LewDqpTbprpbGrGg
 YuEPTkWSGNi2zxi6Rpkx2aHdMYrRSEVSFzvEYI/KIHn2bePe9apGuk63zdA86eBMkwTe
 fwwr1f+mIpkF1+ROFTvW4u8sNqHUDijqFCxlzy/WH5H4i4AoZhkUFtfCPR6IaiUyMB3S
 7xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778751786; x=1779356586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EBn5tkuugQF5z7V7RcBEAJ6Ks/xAqPe+17uxF5PtAFk=;
 b=HENIak8u0kqcNPllJnxxxM5/CtANP4FFiKTZ5wNt0BiRAEbbfHvEZm6fsjBm5tNtNp
 yTScx1GPdreZT1wUZ4KkjM/8C3ZiAiiY0gXLr6tXdxoOSrjqJBQXZo8lxvu3Zq8+Bvc4
 znyHSV7bGtSTFo5tO1kyh7bDuZNAnPB6MeGv6YsA7RACJC7r8Ui494SaWRbfLB/Z1rox
 lj7uzsAFY+arupYia3hWXLdLvqciIoNP1Cds1Y8Rl0F+8BZnw29whPl8vb3mPD1gcyQ6
 6fjFJ+rYF+8CWgWWQ4UhkrnjjSJL7ugGkWg8OynJQsverMD0bfklQtVSGM5NrueY55n7
 sfaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8V+7/ejkShy9t5E+jBkFTJLj35Q+p48zC1KI9XncQSdx/gvxi0H4VUKH4IROfyylwN2t7R8h0T+ja@nongnu.org
X-Gm-Message-State: AOJu0Yxvirq56QV3uuzAVmnecT2nDuoism/O144MqarsSDQuuimNhx7R
 BBXuWfD0FHnZhKiOREjQi6+GpnLESrl/LxP584btm59gdVTzr5LI2vwUQGSiW0MWk0e3B4ykrwg
 bVzqToKc=
X-Gm-Gg: Acq92OGKo00ko/MXQjhkKuadMxuuPIoD/DJuVzzwIZ82AIvCnRgDamBHA8ua+D0wBds
 QBGJYMmdtP2WUx4p4XVTuvGwBFm241ShgR8E/QEqXMEr2Iqrq1T4mEhDzoS9c95SC2I9CCHA4Hj
 evadKAzm87gPeDhOUS7X/0YnP7Sb+Liyk4+ydHCb4nUVU56oEWX/1DvQIDeLKVLH0EvAJ2NrT3J
 oLl/K0Jhr0pBUmCKbWcpYFEy0+3gejWnrC6rNJ/sUQ/ys9TvJ/i0JBkFZdiapQ3H/YTyKpPOx8x
 /pT1AqGGj+vEtBBgkd880ExIJKG7lk+/RGRbcpKG55/t8q/g5/gvArleH1Qo1JHB1eeaIWwcTNi
 eTILlzHYBjIgDpX3uTK2q2wKLgzKVXhrMCjK25fGdp5fPWpP3iOwOcDwwWObnocGFO+p3f1a99j
 4AJHJR3dKznHp4I0B7AOxFSpVwQVlSvZFpW5nxZnZk3fSuffVvNEvcQE9YlvsEvDtDjqBxmAMya
 QkCNlla22mKnGg=
X-Received: by 2002:a05:6000:4028:b0:449:a07a:9676 with SMTP id
 ffacd0b85a97d-45c5a68a7d6mr11272965f8f.29.1778751785939; 
 Thu, 14 May 2026 02:43:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm4934191f8f.0.2026.05.14.02.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 02:43:05 -0700 (PDT)
Message-ID: <dfbd74e5-1d98-4321-a029-53870df846ee@linaro.org>
Date: Thu, 14 May 2026 11:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/mips_gic: Avoid Coverity complaint in VP writes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260512111536.3437645-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512111536.3437645-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/5/26 13:15, Peter Maydell wrote:
> The MIPS GIC does a check for a guest error in the write path for the
> SH_MAP*_VP registers which triggers a Coverity complaint because it
> assigns -1 to a uint64_t. The code doesn't misbehave because the -1
> case will be caught by the following OFFSET_CHECK(), but the code
> could be improved:
>   * there is no need to special case to avoid passing 0 to ctz64(),
>     because (unlike the compiler builtins) QEMU defines that this
>     has a specific behaviour, returning 64
>   * the OFFSET_CHECK() macro will go to the "bad_offset" label and
>     print an error implying that the guest wrote to an invalid
>     register offset. This is misleading about the actual problem,
>     which is that the guest wrote a bogus value to a valid register
>     offset
> 
> Make the error check print a better log message, and avoid the
> special casing on ctz64(); in passing, this should also make
> Coverity happier.
> 
> CID: 1547545
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/mips_gic.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45EFC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEWe-00039J-7O; Tue, 08 Jul 2025 16:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZCNu-0007TP-2C
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:45:38 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZCMK-0002CK-Rt
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:45:27 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-31223a4cddeso3506383a91.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751996636; x=1752601436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0LH90vcz1GOtJ9aUwnYZjq9sOvu3QPsISmol2AG6ZM=;
 b=pi7Y4JjM6jFMCVyqiNKJCefwc0x4SMJ6W4+lLvJocO5RaWNV5KY1gbX9bIMGRnuNzN
 szwdBsCSk1WfJYa8R0jrcpoRdIpVR7JPVR00d+Q0SpLyHBVTPv8EA25vdjsgnSAyOnIV
 suJsIIVSR1dkgSHjgFDalFdTuU64kNt3Ke8Jpt5Ra5z6zW9syVqBMzMH6pTEFBxHNI8m
 08Rt53m8/orGrsrRo4J2P5+cgBxbnhfnB5W5MNk2QlAmZZuHixfVsQNFIsjG08mi4Adw
 mtSLshBi2oEYUutsZ5KPGlPX/KYa2pngOqwndXENLRhitJGdcL0C/3SraxCjAZF8K+Vj
 o9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751996636; x=1752601436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0LH90vcz1GOtJ9aUwnYZjq9sOvu3QPsISmol2AG6ZM=;
 b=YBeUXB6Tk9Pw8JZFLn/e7vxg9lPycdm/NmRvFL2ncwt5Z2MmvxcswNC3d30vmm+Cog
 iN+PIXhkldNRNYs5W9rRWu0DpfIz5mNjgaaWKRhQ1mcz9EX1VE2sPYiR+VGmc0TbssaK
 sIGZ10DjsyFvnBr50f34HeE8n81IxHVzsQRuumgkJ4grtvfrZ1sNsTAMMVaTiI9r96Vu
 zsJGptMdtgiLTgCaUOvMmNLT6P2DWP+DSK2hqoaSawSjVdeT0BgwHzt/NDcsc+6cbsoH
 ASkU1qdY6CG2OOm9Y0DBK2jUH2PAhdKmvcmdP692GMraoTgezFcYj/CQLW/3d1/NhQwe
 sVgQ==
X-Gm-Message-State: AOJu0Yw7d4Bfnp2oKPGemzIkLmtLusY29c5hhjTIFs206G18X++C77Vm
 gROWn1jKHStoPts4uYoGr2tl6LkmkvRPQm4k+xrrXRlMc2ZXqpaWuIoXjxs1CxP8uaEvSfLxSGY
 tN56F
X-Gm-Gg: ASbGncugsqfe4D0vmVEUlj2m2WlQBQYFfHJnW22N/41iBhl/AXxi5sAq2WJev2KQAL/
 P4dbFP/3teF7jTIw0FChjF3QFKHzqSA8xLcITldOalcimb4+3jmCnPeW5PAaBHOfz5emcjaYJmJ
 xACi8KVmlDAl1U3lzPGk3vFVaBG0dBzigZlM9/bHUT2X8qpHnS2zmsCpcvDaK+BUP4/d18b/Y0W
 PQJIrl6dGkAgFYDg2pb5P7ZLi01zrvKxS6yOMWWnpA/9wcPa0Djd58FzaB1K0qBkkclRPWFhaVQ
 Y0UKKo/boBro9GhlCJTbQpxPQEIVbMLncB7i/035ITRTN0aVN7APdMKkooO9FMZl27rdpubdMm8
 =
X-Google-Smtp-Source: AGHT+IHSHsK05Ur/dR4MTQ3EXznQ5UZj7RknR8eBaHZSnJ2jeWVTuQNIigxaJRsyx8a61d3gUeJLyg==
X-Received: by 2002:a17:90b:2ed0:b0:311:f30b:c21 with SMTP id
 98e67ed59e1d1-31aadd9fd46mr20276988a91.26.1751996636499; 
 Tue, 08 Jul 2025 10:43:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c21ede5ddsm2751646a91.46.2025.07.08.10.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:43:56 -0700 (PDT)
Message-ID: <11143a5f-dd2e-49c4-b544-0ab9d3c00877@linaro.org>
Date: Tue, 8 Jul 2025 10:43:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] control guest time using a dilation factor
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 peter.maydell@linaro.org, philmd@linaro.org
References: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/27/25 5:24 PM, Pierrick Bouvier wrote:
> Depending on host cpu speed, and QEMU optimization level, it may sometimes be
> needed to slow or accelerate time guest is perceiving. A common scenario is
> hitting a timeout during a boot process, because some operations were not
> finished on time.
> 
> An existing solution for that is -icount shift=X, with low values, which will
> roughly map virtual time to how many instructions were executed.
> 
> This series introduces another approach, based on faking host time returned to
> the guest, by applying a time-dilation factor. Time will go slower/faster for
> the guest, without impacting QEMU emulation speed.
> 
> It may eventually be used to fix some of the timeouts we hit in CI, by slowing
> down time in VM, to be less sensitive to varying cpu performance.
> 
> v2
> --
> 
> In review, Paolo mentioned timers deadline should redilated in the other
> direction. After going through this part, it seems that arrival is always based
> on one of the clocks we have (which is dilated already), so I don't think we
> should redilate that, as this would create a discordance between time set, and
> real time when this happen. Feel free to correct me if this is wrong.
> 
> - keep start time per clock and apply accordingly
> - apply time dilation for cpu_get_host_ticks as well
> - use a default factor of 1.0
> - rename cli option to -rtc speed-factor
> - forbid to use option with kvm, as time is not provided by QEMU for guest
> 
> Pierrick Bouvier (2):
>    qemu/timer: introduce time dilation factor
>    system/rtc: introduce -rtc speed-factor option
> 
>   include/qemu/timer.h     | 60 ++++++++++++++++++++++++++++------------
>   system/rtc.c             | 11 ++++++++
>   system/vl.c              |  9 ++++++
>   util/qemu-timer-common.c |  7 +++++
>   qemu-options.hx          |  7 ++++-
>   5 files changed, 75 insertions(+), 19 deletions(-)
> 

Gentle ping on this series.

Regards,
Pierrick


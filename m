Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A1C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h3M-0003j8-JF; Wed, 08 May 2024 09:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4h3J-0003h4-VN
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:09:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4h3H-0000AF-S2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:09:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso30320345e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715173781; x=1715778581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6B8V0UM88iludJv8S2NPlSRGWpVJPYuG/YvkxpPfWN4=;
 b=HLGoK5le6JllWAJPzkJssxJJCWikwWeTXgVi7ioK81PZCHNVPbOJ+LcDV7Kl4H8VNS
 eY6ecHYY5SYi5/Ez3IVxNIrUDRgIVJWrExbYO+RSfet49XuQBSvQhEZLlqtybL3CD9Je
 KF0yRfqovdQIQedrUFZLsq83I7S9gsmfgLn6QaZvmANpDPSPfRYykMEH8Mbc+1/zg4Yn
 ruDeS6FoGHXvUXYjjCzc/6zOW0zRY4AovHQStC+A4hf8CWvkaTU+HMOQoL9/b0BfiU2D
 NUm//jOSCPNRlGF7hphtx36mdUxdehER0FLR7avrEK+O4c9BP1dtYlpcyGwzdmQSbTHw
 qQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173781; x=1715778581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6B8V0UM88iludJv8S2NPlSRGWpVJPYuG/YvkxpPfWN4=;
 b=nLNdTpxK6HXJD4uCrSlkLZGprFG39dW0KegA9gkxgY+Mpwv/85Q3yS2kBAglQ3L61k
 YhfmxELP87EWw930fmngSvA15+MS3c5XYs/TFHoBlk6VOUm+7CQ5hSArA1+XZomsCbzw
 10UQyuTSD1mQam5n5SHx8wnwPv8+FnC0NspMNgilLaS/1H5aRCGOTHGo0u8l5fWFdBW2
 9ZsC71b/xr+O1BrP4kcow33c1Bhvrzp+zQ1j73X/+xiLiiVl2109fuP2IqqaN3SmRzGa
 snOomf6OEajUfZkI7aBjGNOLgPM91tbsAROD7YBhqM+TP+mpeEvg5vcO3DqRSYjLUbg9
 GxCQ==
X-Gm-Message-State: AOJu0Yw+MirKNfAgokKxpqHjhyqXkbc4XVKp+fUc9gk+6BHebLwy1wKs
 udjSTSlhvoaqCnNRr5ltP9IuUr/BhtkYSGPKDiYiq5MkWIpNHC9uqaD5c9zp2+g=
X-Google-Smtp-Source: AGHT+IHneBI2BPhlwuORowqh5zZA8lxVr4o91c/eaB1auU/UW4nGP2M0gdszaV3AK9CVzi6VQwSKWA==
X-Received: by 2002:a05:600c:4ec9:b0:418:969a:b316 with SMTP id
 5b1f17b1804b1-41f71302ad9mr19200285e9.1.1715173781474; 
 Wed, 08 May 2024 06:09:41 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87d2045asm22744025e9.27.2024.05.08.06.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 06:09:41 -0700 (PDT)
Message-ID: <210757c3-c949-4dd1-bd7d-c33db3aa390e@linaro.org>
Date: Wed, 8 May 2024 15:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
To: Zhao Liu <zhao1.liu@intel.com>, Mads Ynddal <mads@ynddal.dk>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508043229.3433128-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/5/24 06:32, Zhao Liu wrote:
> In some trace log, there're unstable timestamp breaking temporal
> ordering of trace records. For example:
> 
> kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
> kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> 
> Negative delta intervals tend to get drowned in the massive trace logs,
> and an unstable timestamp can corrupt the calculation of intervals
> between two events adjacent to it.
> 
> Therefore, mark the outputs with unstable timestamps as WARN like:
> 
> WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> 
> This would help to identify unusual events.
> 
> And skip them without updating Formatter2.last_timestamp_ns to avoid
> time back.

Can't we reorder them instead?

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   scripts/simpletrace.py | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index cef81b0707f0..23911dddb8a6 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -343,6 +343,17 @@ def __init__(self):
>           def catchall(self, *rec_args, event, timestamp_ns, pid, event_id):
>               if self.last_timestamp_ns is None:
>                   self.last_timestamp_ns = timestamp_ns
> +
> +            if timestamp_ns < self.last_timestamp_ns:
> +                fields = [
> +                    f'{name}={r}' if is_string(type) else f'{name}=0x{r:x}'
> +                    for r, (type, name) in zip(rec_args, event.args)
> +                ]
> +                print(f'WARN: skip unstable timestamp: {event.name} '
> +                      f'cur({timestamp_ns})-pre({self.last_timestamp_ns}) {pid=} ' +
> +                      f' '.join(fields))
> +                return
> +
>               delta_ns = timestamp_ns - self.last_timestamp_ns
>               self.last_timestamp_ns = timestamp_ns
>   



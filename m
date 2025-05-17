Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905D7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 19:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNNh-00054E-HC; Sat, 17 May 2025 15:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNNg-000545-5G
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:39:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNNe-0005Pz-IT
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:39:35 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30eb1c68386so400552a91.2
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747510773; x=1748115573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M25NPwXUT9b0GAEckf8OpOE40VZ1C8ML6kT4urGVQjs=;
 b=mQI2kU3esxx20SO9QHwcPNU5sFJnH7uiSE/cmkQ9rJMAKG0O4eZ/8btjCvG67sdjOI
 l2XGAEnlyMJ/SwEjndUeD21FWbMtMuzuzHtw0Gyjl+4+F6NbaR27GBkT2jzUqvvAw3P1
 2WE48SYKuJuFOgOe6gUphOembPoNMToOM5lgwG/MoCUzIGgqgGH7nGxmP4666hvf5j1X
 Xkzm6VsNt2z0sia4QvbvIYY606Znr6Rnc4Bwq3eQ2LR57RzDY+eNdVv36afHO/5yN6v+
 wPmtixwoOZVX+qtv/qJ6ryxbFmv2YyXFOcc6uNqhA2fOwQKf+q1oVG1SlwEb6a0XrtQU
 9oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747510773; x=1748115573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M25NPwXUT9b0GAEckf8OpOE40VZ1C8ML6kT4urGVQjs=;
 b=pVBE+V4QbAA3CVL/6zzV7jcYzZn5gjRbBOqjqRA5Zi0opUNig3Ww7IR3lJ7/Q6vCcw
 vIDsaZr8KJEyn+Dg3vXECzSxUFUpgz3KJviHUnvQkBbWgqGxBhkeCSGfpa0b+Ttflp/1
 a1ajXt3l3mkwyUPSonhZa0yyzPp8ksS3VTr7hLsIf4OCQiR8pIeGRn3H+ShGFtKhHMUc
 nHJRrnrZ4dL1v4YlTC2mKD0Vnrt9McEHsgaLoduOAiuGz9gXQf/2y9FAiMMxIWAnwZWm
 Ct4qGF2HLPmzKHGWWvxi7tebkO9wywyf8PX0QlV8hmmdytW+7m0T/Phb5Vv0PzLbF9Bl
 TOBg==
X-Gm-Message-State: AOJu0Yyd2rpqxkiNlYVnMPNWsS753VGNGZF6q/+6DI/wFElkBaKomYO+
 T9HbqyOcARDWBCWw1GIxNGo2QqiSM21hWv2PAwz4so8EXmJjSjQ4MQQlUrFWzXZXuFs=
X-Gm-Gg: ASbGncsIwo70FBWdI2vANFESd7nn4pAfpnCA7dyVOUTExQMbcv4b1dKOjeoHwyzAenE
 2wnPkc6iitrJG5nWbW87ruNnSp5sgJhekaRT/P88HzfkvZf+rDvo/75jWnlrS95CF3RtvegJgBW
 R9z9I64xCw5PcxtRZm1TvdQ54p0CU9+tt69X1ljLpC7j0w0wOVsGjq1tqxTT1egbcrNQJBOYRU6
 Vt5iWiJBJnz3C9bWMiSIpWAk5ZQ/xn+TSR6G6bxEEziAb3CzIbsXe+0FeqdR5813OtbM76xO0Pb
 5BPndoKp7mO35PbajYMZMpB1x/d7VnYiojzdDbC0YZeckPqRoVV9DNbCGSdFejI7divYPdZ9Y6E
 =
X-Google-Smtp-Source: AGHT+IHt8TnaYPwzPX1ajmZ2cIEidufo3RMEJ8dase1jWYgLTcI1zjOejTxo4A4n8EP8K4mjqPRirw==
X-Received: by 2002:a17:902:c951:b0:211:e812:3948 with SMTP id
 d9443c01a7336-231d334d209mr107539475ad.0.1747510772832; 
 Sat, 17 May 2025 12:39:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4adbab6sm34106455ad.69.2025.05.17.12.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 12:39:32 -0700 (PDT)
Message-ID: <a54c4138-3648-46c9-93f8-44736894b77a@linaro.org>
Date: Sat, 17 May 2025 12:39:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-2-pierrick.bouvier@linaro.org>
 <87plg7myux.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87plg7myux.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/17/25 1:21 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> This removes the TARGET_I386 condition from the rtc-reset-reinjection
>> command. This requires providing a QMP command stub for non-i386 target.
>> This in turn requires moving the command out of misc-target.json, since
>> that will trigger symbol poisoning errors when built from target
>> independent code.
>>
>> Rather than putting the command into misc.json, it is proposed to create
>> misc-$TARGET.json files to hold commands whose impl is conceptually
>> only applicable to a single target. This gives an obvious docs hint to
>> consumers that the command is only useful in relation a specific target,
>> while misc.json is for commands applicable to 2 or more targets.
>>
>> The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
>> RTC is disabled in Kconfig, or if the running machine type lack any
>> RTC device.
>>
>> The stub impl for non-i386 targets retains this no-op behaviour.
>> However, it is now reporting an Error mentioning this command is not
>> available for current target.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> [...]
> 
>> diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
>> new file mode 100644
>> index 00000000000..d810f33efec
>> --- /dev/null
>> +++ b/stubs/monitor-i386-rtc.c
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-commands-misc-i386.h"
>> +
>> +void qmp_rtc_reset_reinjection(Error **errp)
>> +{
>> +    error_setg(errp,
>> +               "rtc-reset-injection is only available for x86 machines with RTC");
>> +}
> 
> We get this stub exactly when the command did not exist before the
> patch.  Thus, the command fails before and after, only error code and
> message change, which is fine.
> 
> However, the error message feels brittle: it becomes misleading when we
> implement the command for other targets.  Let's dumb it down to
> something like "RTC interrupt reinjection backlog reset is not available
> for this machine".
>

Sounds good, I'll change it.

> [...]
> 



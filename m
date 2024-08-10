Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2250C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 02:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scbvq-0005Jv-Vs; Fri, 09 Aug 2024 22:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scbvp-0005JR-LA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 22:34:13 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scbvm-00049C-GX
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 22:34:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso768419b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723257127; x=1723861927;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXAxiYkomqReRy+A64J/j5BHBw7D8FCXoQJlPdwxOTA=;
 b=BjNUKvcRAU5cMVVAMC1jYPeTSQbMdgdq//NlblV8R+cT3mB9Dqx8zM5Wgljpy/bEYY
 vHiwONZ3Oz/QARIdx6JP0iqdMOO7I9V6Ot/wBPfgA3fyy6ZakrrQrHJ/qKZRGPJmYx/x
 4+ll9DM+uKh2xCDaTjzRWk+JfZ5eKq5uwwzCa8wGWBR1d0baX5BOIikyryIBF+CX6OuQ
 cHJp3fOqZhrBirRXOhTWnolNFmfIiG7wt+gehmWV9LDgQFlr3Nynxmg3PWXKcd3XwU9F
 28WYRHwGbDhrneIR/PLEeSCBSBu4I+cumvunSCabCIRlOtftYFIvgVpC60Y0uEzk79Uy
 QAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723257127; x=1723861927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MXAxiYkomqReRy+A64J/j5BHBw7D8FCXoQJlPdwxOTA=;
 b=uiUIQWIilOrxsvPOqE2YKGp+dcP9XR7d2VmZH6nnJiSpu3Q0qOvrTe6P7dN+Rkh+3l
 Wfe95HDMl8a1sJMyPdKFoeUdBMbfTYaWMvAwZG8f15qnWoPqjFFpcC4IQdZIB94MRFVh
 E8ILtXgnoVs0B0SsCIjKYdMJv+/fqbmA1GT3mhG000Qq1BejDfhNzimz5HZu4tahJXLf
 aQEFajredLcNjL4HrwInu3cFRehQVPgEqIHDmo1f5UxnozRu1l7VwousA6OeH3g2zBbR
 O2XO7KIPHAB5dlfvaJ1rc/AYMCkqlMR89e98tn4I4N0zq4ExoSu4vXgulGojQTwvoBnA
 2Okg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/2VKoqRTYl7+u0p6EzrwSD1ks2mqWjUCxNpuw26U86qs7XZYvsq82nvTW0e8Jnnq2Yjws/HsYOLZKCX18ZvRuX5Ydnwg=
X-Gm-Message-State: AOJu0YyvB2z3e429g0Z4aKyEZtl0YXFACDsFwPv7wPK14q3Lucn10p4l
 UkM622gfuGtisAV6kX/pvXJiGjZOsYNPsmh4gq72rVZLCRa73CWbYvo9P9dgmbo=
X-Google-Smtp-Source: AGHT+IHJf88BPF8YCCDktYj8mubMcuZ63SYNHSPFC1wKrdpcQ4TFXtu3ILO5Ti7OHOM/HpkmWnnCTQ==
X-Received: by 2002:a05:6a00:6f4e:b0:70d:34a1:5ccc with SMTP id
 d2e1a72fcca58-710cc939c48mr11755213b3a.13.1723257126066; 
 Fri, 09 Aug 2024 19:32:06 -0700 (PDT)
Received: from [26.26.26.1] ([103.40.79.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a89378sm418748b3a.172.2024.08.09.19.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 19:32:05 -0700 (PDT)
Message-ID: <461963c6-356e-4b45-b883-2b313d2db038@smartx.com>
Date: Sat, 10 Aug 2024 10:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] tests/migration: Move the guestperf tool to
 scripts directory
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
 <38f6c0a2385f75f437d2b8b7b5fa82adacc2879c.1723189080.git.yong.huang@smartx.com>
 <87y155g8g3.fsf@suse.de>
From: Hyman Huang <yong.huang@smartx.com>
In-Reply-To: <87y155g8g3.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


在 2024/8/9 20:57, Fabiano Rosas 写道:
> yong.huang@smartx.com writes:
>
>> From: Hyman Huang <yong.huang@smartx.com>
>>
>> Guestperf was designed to test the performance of migration,
>> with a loose connection to the fundamental test cases of QEMU.
>>
>> To improve the repository's structure, move it to the scripts
>> directory.
>>
>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>> ---
>>   MAINTAINERS                                          | 5 +++++
>>   {tests => scripts}/migration/guestperf-batch.py      | 0
>>   {tests => scripts}/migration/guestperf-plot.py       | 0
>>   {tests => scripts}/migration/guestperf.py            | 0
>>   {tests => scripts}/migration/guestperf/__init__.py   | 0
>>   {tests => scripts}/migration/guestperf/comparison.py | 0
>>   {tests => scripts}/migration/guestperf/engine.py     | 0
>>   {tests => scripts}/migration/guestperf/hardware.py   | 0
>>   {tests => scripts}/migration/guestperf/plot.py       | 0
>>   {tests => scripts}/migration/guestperf/progress.py   | 0
>>   {tests => scripts}/migration/guestperf/report.py     | 0
>>   {tests => scripts}/migration/guestperf/scenario.py   | 0
>>   {tests => scripts}/migration/guestperf/shell.py      | 0
>>   {tests => scripts}/migration/guestperf/timings.py    | 0
>>   14 files changed, 5 insertions(+)
>>   rename {tests => scripts}/migration/guestperf-batch.py (100%)
>>   rename {tests => scripts}/migration/guestperf-plot.py (100%)
>>   rename {tests => scripts}/migration/guestperf.py (100%)
>>   rename {tests => scripts}/migration/guestperf/__init__.py (100%)
>>   rename {tests => scripts}/migration/guestperf/comparison.py (100%)
>>   rename {tests => scripts}/migration/guestperf/engine.py (100%)
>>   rename {tests => scripts}/migration/guestperf/hardware.py (100%)
>>   rename {tests => scripts}/migration/guestperf/plot.py (100%)
>>   rename {tests => scripts}/migration/guestperf/progress.py (100%)
>>   rename {tests => scripts}/migration/guestperf/report.py (100%)
>>   rename {tests => scripts}/migration/guestperf/scenario.py (100%)
>>   rename {tests => scripts}/migration/guestperf/shell.py (100%)
>>   rename {tests => scripts}/migration/guestperf/timings.py (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 10af212632..dae1535dae 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3449,6 +3449,11 @@ F: migration/dirtyrate.h
>>   F: include/sysemu/dirtyrate.h
>>   F: docs/devel/migration/dirty-limit.rst
>>   
>> +Migration performance test tool
>> +M: Hyman Huang <yong.huang@smartx.com>
>> +S: Maintained
>> +F: scripts/migration/
> This probably needs to be scripts/migration/guestperf* unless of course
> you intend to maintain all scripts that show up under
> scripts/migration/. We have analyze-migration.py and
> vmstate-static-checker.py which are candidates to be put in that same
> directory.

Ok, I'll update this section in the next version.

>
>> +
>>   Detached LUKS header
>>   M: Hyman Huang <yong.huang@smartx.com>
>>   S: Maintained
>> diff --git a/tests/migration/guestperf-batch.py b/scripts/migration/guestperf-batch.py
>> similarity index 100%
>> rename from tests/migration/guestperf-batch.py
>> rename to scripts/migration/guestperf-batch.py
>> diff --git a/tests/migration/guestperf-plot.py b/scripts/migration/guestperf-plot.py
>> similarity index 100%
>> rename from tests/migration/guestperf-plot.py
>> rename to scripts/migration/guestperf-plot.py
>> diff --git a/tests/migration/guestperf.py b/scripts/migration/guestperf.py
>> similarity index 100%
>> rename from tests/migration/guestperf.py
>> rename to scripts/migration/guestperf.py
>> diff --git a/tests/migration/guestperf/__init__.py b/scripts/migration/guestperf/__init__.py
>> similarity index 100%
>> rename from tests/migration/guestperf/__init__.py
>> rename to scripts/migration/guestperf/__init__.py
>> diff --git a/tests/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
>> similarity index 100%
>> rename from tests/migration/guestperf/comparison.py
>> rename to scripts/migration/guestperf/comparison.py
>> diff --git a/tests/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
>> similarity index 100%
>> rename from tests/migration/guestperf/engine.py
>> rename to scripts/migration/guestperf/engine.py
>> diff --git a/tests/migration/guestperf/hardware.py b/scripts/migration/guestperf/hardware.py
>> similarity index 100%
>> rename from tests/migration/guestperf/hardware.py
>> rename to scripts/migration/guestperf/hardware.py
>> diff --git a/tests/migration/guestperf/plot.py b/scripts/migration/guestperf/plot.py
>> similarity index 100%
>> rename from tests/migration/guestperf/plot.py
>> rename to scripts/migration/guestperf/plot.py
>> diff --git a/tests/migration/guestperf/progress.py b/scripts/migration/guestperf/progress.py
>> similarity index 100%
>> rename from tests/migration/guestperf/progress.py
>> rename to scripts/migration/guestperf/progress.py
>> diff --git a/tests/migration/guestperf/report.py b/scripts/migration/guestperf/report.py
>> similarity index 100%
>> rename from tests/migration/guestperf/report.py
>> rename to scripts/migration/guestperf/report.py
>> diff --git a/tests/migration/guestperf/scenario.py b/scripts/migration/guestperf/scenario.py
>> similarity index 100%
>> rename from tests/migration/guestperf/scenario.py
>> rename to scripts/migration/guestperf/scenario.py
>> diff --git a/tests/migration/guestperf/shell.py b/scripts/migration/guestperf/shell.py
>> similarity index 100%
>> rename from tests/migration/guestperf/shell.py
>> rename to scripts/migration/guestperf/shell.py
>> diff --git a/tests/migration/guestperf/timings.py b/scripts/migration/guestperf/timings.py
>> similarity index 100%
>> rename from tests/migration/guestperf/timings.py
>> rename to scripts/migration/guestperf/timings.py


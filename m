Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839DFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 19:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cNU-0005SC-AN; Thu, 02 May 2024 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2cNN-0005Q0-KC
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:45:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2cNK-0004SM-MJ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 15:45:52 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2b2b42b5126so2548122a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714679149; x=1715283949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDfLD4bQCD2r8/2sZVgdWDcYbUCUaC6pKrpC+Bx5DP4=;
 b=Cxi4FpE9yo+rHOrTdIAxfcp/fXFKboT90g9leJSff91qZc6zD4VDVar4LkYMTAI9xI
 ehgWkj9cIunXS6hZxWggL9xKarYZUIPEEWwrZwqi8AyHThZSkWIumYJAI07BVPfVwCeC
 vtSeECF/aihbSIuxhhMH+Z/zQDxBIBTNqXXwf2bON7qYmUwMqbqEuS33XFDVfkE2JTlA
 Y03DcS0bNwoldV2NaqxjYHdahCp2bYkaucyTe3SzIJSVe8VB0jM6vJxz6MAzAQmJCH6T
 Gdsml6shJURnkKMPTNPS8Sz/EpwknvwrYCKUFZ+yWDLe/ioeJk+4QHWUW8t3xGVzGMIg
 Mv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714679149; x=1715283949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDfLD4bQCD2r8/2sZVgdWDcYbUCUaC6pKrpC+Bx5DP4=;
 b=kz39tbu8YtdXMuxDW91tgXRmIBibLtvaWkm4yLzS3yBxdlvs2xT9Gik/e8upPoLy/8
 WrZlp6q/IpEW2uKD1WfnpHjro6W3V3Ntu/aUmJe1KGfua0QjjXZeVawLa6kcmNdUzWZ2
 O4/ju5U+gKLA1QJrakdpI3czgQsDq+d1UfIgmHjaRUiwirLWb3SK286Me45TKQGmz9Ly
 CGtM/7BeK5fhFoikCNnJXTu0TnUqeE8HnfbOYS3UY1DygPkvRiJHqsa4Ey3xLzvTiZgV
 WfILeGcgxpdnIMbjWjlYOtG8zsunxQEh+sgCLcvPVNjV29on2fBQR/AJxavzWyCeU5C2
 tIug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAbJalaMKqBWzV5NR0yaZuAshArmdUD/t+sGUuF5H54YU54xihWIC2Oyf6DpIYH3Dk6LUGeyFrHA00Hqmd+JZUZN7D1ug=
X-Gm-Message-State: AOJu0YzyQiq3msqW0xGzM15+64sWOVfv1jLojDr6hvo1ywdchKjOShpq
 5U5jkHFi9lidOptj8eyg7ZOgl8rajT9xSgHgiqf36+kAvwwkfllZh7Zun00eWX0=
X-Google-Smtp-Source: AGHT+IHmGBfZZKmrU+dIh1HZi9vZ5hnysOvWE0J2/eZsdcvrFezr3OEPMyEYVBTAJJRhj6IdPtjFJA==
X-Received: by 2002:a17:90a:f188:b0:2af:8d8:c90a with SMTP id
 bv8-20020a17090af18800b002af08d8c90amr884691pjb.5.1714679149128; 
 Thu, 02 May 2024 12:45:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::ecd0? ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 fz11-20020a17090b024b00b002b2cd1a0c8csm1615982pjb.41.2024.05.02.12.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 12:45:48 -0700 (PDT)
Message-ID: <b083716a-dd1e-4edb-ba57-530c7661305f@linaro.org>
Date: Thu, 2 May 2024 12:45:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
 <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Hi Gustavo,

On 5/2/24 12:16, Gustavo Romero wrote:
> Hi Pierrick,
> 
> On 5/2/24 3:08 PM, Pierrick Bouvier wrote:
>> This series implement two new operations for plugins:
>> - Store inline allows to write a specific value to a scoreboard.
>> - Conditional callback executes a callback only when a given condition is true.
>>     The condition is evaluated inline.
>>
>> It's possible to mix various inline operations (add, store) with conditional
>> callbacks, allowing efficient "trap" based counters.
>>
>> It builds on top of new scoreboard API, introduced in the previous series.
>>
>> NOTE: Two patches still need review
>>
>> v2
>> --
>>
>> - fixed issue with udata not being passed to conditional callback
>> - added specific test for this in tests/plugin/inline.c (udata was NULL before).
>>
>> v3
>> --
>>
>> - rebased on top of "plugins: Rewrite plugin code generation":
>>     20240316015720.3661236-1-richard.henderson@linaro.org
>> - single pass code generation
>> - small cleanups for code generation
>>
>> v4
>> --
>>
>> - remove op field from qemu_plugin_inline_cb
>> - use tcg_constant_i64 to load immediate value to store
>>
>> v5
>> --
>>
>> - rebase on top of master now that Richard's series was merged
>>
>> Pierrick Bouvier (9):
>>     plugins: prepare introduction of new inline ops
>>     plugins: extract generate ptr for qemu_plugin_u64
>>     plugins: add new inline op STORE_U64
>>     tests/plugin/inline: add test for STORE_U64 inline op
>>     plugins: conditional callbacks
>>     tests/plugin/inline: add test for conditional callback
>>     plugins: distinct types for callbacks
>>     plugins: extract cpu_index generate
>>     plugins: remove op from qemu_plugin_inline_cb
>>
>>    include/qemu/plugin.h        |  42 +++++++----
>>    include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
>>    plugins/plugin.h             |  12 +++-
>>    accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
>>    plugins/api.c                |  39 ++++++++++
>>    plugins/core.c               | 109 ++++++++++++++++++++--------
>>    tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
>>    plugins/qemu-plugins.symbols |   2 +
>>    8 files changed, 466 insertions(+), 84 deletions(-)
> 
> The description in the commit message of patches 1/9, 2/9, 6/9, 7/9, and 8/9 is missing.
> 
> Is this intentional?
>

Do you mean there is no multiline commit message for those changes?
Indeed, for some of those patches, the change is a single line commit 
message.

> 
> Cheers,
> Gustavo


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE7C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZjT-0002mh-EY; Fri, 23 Feb 2024 12:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZYU-0002lu-8r
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:41:50 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZYS-00049c-Ij
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:41:50 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3eafbcb1c5so143177266b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708710107; x=1709314907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VeQzTf1HI27j/S4e2f74MNw0Ba1I3PGZ0n6sLFJ50k0=;
 b=CEQ7ynGCndRbCCkGwzDu2iXn7AXrjiHLky56hvCvq+AvtwpKxGRPPntB95RegfembF
 IvwuC5N5V/a0M9+CGZ/YlnaNhPoPMER7kGcNCv94hn4kdNXtkDZUthOaRUV37YO34VLh
 XlP0wKhO16xv9H9Wy5MgEOlRXP4FYWWZ5jmca4L96GLaefdJWVEp4E2m85HcqOMYe5pr
 QlDPOnXzaHcN7O+HuQlPwQECG9rAe8jYsJl+O7ir3NtbOnF9DFfVmZhk6rtr61G5VcTe
 g/Zxn9xA7OXLBCHwo1FrVPzmRLjE72LKju4BzmvvHxd///eDMa+lbPexLTCAv00ljtJw
 6zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710107; x=1709314907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VeQzTf1HI27j/S4e2f74MNw0Ba1I3PGZ0n6sLFJ50k0=;
 b=HmIXExlIqfJfJntqM9WFYIhIOXIGTef1/F7e61fE7Gby+Ndk8UGy5MT5j5WbKcRDUS
 SyYu6oyePpPvNNhukHWKItKFpGjwUBPYMwe6ibv7wDNMBwv4ypH01doEbu7y8cSOo9eq
 M5bWjr6cyf+81qi7ZKVncnTvo9eyUFXvyVHErJVUHAjAaoNn/tvETMDgu7PVzw4UWQa0
 N6ldr2RhdWLM0CMO10a5y2PT8ViPt49QQeUyeHhk8Hh0CE3kkP6xoh3Lnqt/L52sSGzR
 hFwRrWNQObbDDTd7BV//sNkdm9CBcAUQiKxLVGge0Z2OU0sdSziq9X51aSWbmW3pSlUR
 +gpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SJ1loMR2PHHbkLF8W0/t8hlk7L/qzRz45uAdzTR5ibdltFhO1hXkPmjiSDds8jIZsfOARbfmuHLiwXoCIv8PWnF0knE=
X-Gm-Message-State: AOJu0YxzyLjC27F5mv4TYN4ppztoxH7n7LECxaIwbR2Wyz//H61B6EG/
 9HoFjmUZWhWAMctF9Oge1ZoX6KrfS4MLmadt8Ta7yEs61BJ+WIiTezUOhDiUOQE=
X-Google-Smtp-Source: AGHT+IGD+WDVvPlW8d5Gj/Xu4dx3qa1hFd32oG5cuU8SEccC9VWRmwh1dE0iEPOMf/kbY3vXvwO71Q==
X-Received: by 2002:a17:906:19c5:b0:a3f:9d69:3643 with SMTP id
 h5-20020a17090619c500b00a3f9d693643mr304788ejd.32.1708710106855; 
 Fri, 23 Feb 2024 09:41:46 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 rf20-20020a1709076a1400b00a3f2bf468b9sm2937337ejc.173.2024.02.23.09.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:41:46 -0800 (PST)
Message-ID: <ed0f8248-81d0-41a7-a8a5-05fe0575e2c4@linaro.org>
Date: Fri, 23 Feb 2024 18:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] util: str_split
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
 <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
 <ac4a19b6-9290-4c97-bc7d-eabfef079895@linaro.org>
 <34d846ab-64e9-4fd4-8d99-62315a7c0f3b@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <34d846ab-64e9-4fd4-8d99-62315a7c0f3b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 23/2/24 15:01, Steven Sistare wrote:
> On 2/23/2024 1:01 AM, Philippe Mathieu-Daudé wrote:
>> On 22/2/24 22:47, Steve Sistare wrote:
>>> Generalize hmp_split_at_comma() to take any delimiter string, rename
>>> as str_split(), and move it to util/strList.c.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    include/monitor/hmp.h  |  1 -
>>>    include/qemu/strList.h | 24 ++++++++++++++++++++++++
>>>    monitor/hmp-cmds.c     | 19 -------------------
>>>    net/net-hmp-cmds.c     |  3 ++-
>>>    stats/stats-hmp-cmds.c |  3 ++-
>>>    util/meson.build       |  1 +
>>>    util/strList.c         | 24 ++++++++++++++++++++++++
>>>    7 files changed, 53 insertions(+), 22 deletions(-)
>>>    create mode 100644 include/qemu/strList.h
>>>    create mode 100644 util/strList.c
>>
>>
>>> +#include "qapi/qapi-builtin-types.h"
>>> +
>>> +/*
>>> + * Split @str into a strList using the delimiter string @delim.
>>> + * The delimiter is not included in the result.
>>> + * Return NULL if @str is NULL or an empty string.
>>> + * A leading, trailing, or consecutive delimiter produces an
>>> + * empty string at that position in the output.
>>> + * All strings are g_strdup'd, and the result can be freed
>>> + * using qapi_free_strList.
>>
>> Note "qapi/qapi-builtin-types.h" defines:
>>
>>    G_DEFINE_AUTOPTR_CLEANUP_FUNC(strList, qapi_free_strList)
>>
>> Maybe mention we can also use:
>>
>>    g_autoptr(strList)
> 
> Thanks Philippe.  If we get to V6 for this series, I will mention this,
> and also mention g_autoptr(GStrv) in the header comment for strv_from_strlist.

If there is no need for v6, do you mind sharing here what would be
the resulting comment? Maybe Markus can update it directly...
(assuming he takes your series).



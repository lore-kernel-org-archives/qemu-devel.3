Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D77C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WZy-00004r-8z; Mon, 13 May 2024 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WZw-0008V7-PI
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:23:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WZv-0000tB-5N
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:23:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420104e5336so11140235e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610176; x=1716214976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IF5EX2w6IJp3IFaYRXbmEvcj/KiQdQ1YS32o2itDv7Y=;
 b=rr4EYV5nMAQGXWzVKD9dhzMWb27WcZ2Qc1PiYsgc30Ul4Zm4Jo6PXPc+rzBmn5gxeX
 8SYJH1oMWCT+jK16to3Z32A+1e8asSCrRtzsJtmi4v9SmZpLGv/y5LIrUM/gKm/AOy3K
 zAYGcdWSN7RH6zuNeIuNEi37y1ZDn6wpGKoBZ0sIVNmkleMmu5XJwq+o53GYx2VoKc+s
 PlkX1DSwPeaa2UN2rkAqT+wLHvy9U4Q18eqjenKywPQoNwOgLgTLlm7TeeG7W1qd+5Dp
 rtp8I3UKUOchjoRVdLf7Tc0I/sZoo0z9EmYeicDlIQc18EBOcw3AxfltSVCcEnwxpZWl
 6FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610176; x=1716214976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IF5EX2w6IJp3IFaYRXbmEvcj/KiQdQ1YS32o2itDv7Y=;
 b=cMv7U8sPZ6bFIODCqqC9c5Ga9yuLirsgM4vHhIlOjoVlZPbEqExsby4lQzocVeOhM0
 BTb8ppJa/BZ4C4JbbWpTaFnXsjY5q8IEfmN83zP/At9MF9w22Giza7/2J1eMqgN0cvom
 /K4s4FuDxNIMaWJcR3jvKc2Ya23XoAhqodAl/z8hsErNqnneLK/ABE33MKyg9Jps1eSp
 MUfSRVP+ZaNEk3LHjtp3FBzC+F6SISflCy/DZCmJijTUxjLOaobd/T4nUaTDth1aC3nT
 XsvVQAWA7EJmqJjWFHHnR3wpMiWK6SYDpyQKdKqyAO3pnYVJvrjFyzOWEwhw93IWO6J9
 SKHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXho0EDNB1L/57oiUW/2JFhqXIsRx7zor3vPB2K/5yclvXwTfdZHAPidDwyzsxEVOK8yOoXSJO+z+1FYp71I5DtJSXE7X8=
X-Gm-Message-State: AOJu0YxobwZoJI76ksdkAbzVEuSGTtB4AYXrl+Hkq6fJrQy6jgmBXmQS
 lQTix3oJgPlX/x/iVbOqMAVt+7uk9PZ7oif5PFMi4BzfsIuuSDu+K7OS3U11SNs=
X-Google-Smtp-Source: AGHT+IGv/mXr8/g0KkA4UL7SOurpqe+yYNwm8+6Upni1k49hsZUetpn9AfDFfaL5fDPLHKngAlYTxQ==
X-Received: by 2002:a05:600c:3112:b0:41b:e55c:8dc1 with SMTP id
 5b1f17b1804b1-41fbd1b2e40mr101981455e9.20.1715610176592; 
 Mon, 13 May 2024 07:22:56 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42016b88f99sm33327485e9.10.2024.05.13.07.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:22:56 -0700 (PDT)
Message-ID: <5a74f1af-6068-41b1-b875-6be060369abe@linaro.org>
Date: Mon, 13 May 2024 16:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dump/win_dump: Improve error messages on write error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 13/5/24 16:16, Markus Armbruster wrote:
> create_win_dump() and write_run report qemu_write_full() failure to
> their callers as
> 
>      An IO error has occurred
> 
> The errno set by qemu_write_full() is lost.
> 
> Improve this to
> 
>      win-dump: failed to write header: <description of errno>
> 
> and
> 
>      win-dump: failed to save memory: <description of errno>
> 
> This matches how dump.c reports similar errors.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   dump/win_dump.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index b7bfaff379..0e4fe692ce 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -12,7 +12,6 @@
>   #include "sysemu/dump.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> -#include "qapi/qmp/qerror.h"
>   #include "exec/cpu-defs.h"
>   #include "hw/core/cpu.h"
>   #include "qemu/win_dump_defs.h"
> @@ -52,6 +51,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
>       uint64_t addr = base_page << TARGET_PAGE_BITS;
>       uint64_t size = page_count << TARGET_PAGE_BITS;
>       uint64_t len, l;
> +    int eno;
>       size_t total = 0;
>   
>       while (size) {
> @@ -65,9 +65,10 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
>           }
>   
>           l = qemu_write_full(fd, buf, len);
> +        eno = errno;

Hmm this show the qemu_write_full() API isn't ideal.
Maybe we could pass &l as argument and return errno.
There are only 20 calls.

>           cpu_physical_memory_unmap(buf, addr, false, len);
>           if (l != len) {
> -            error_setg(errp, QERR_IO_ERROR);
> +            error_setg_errno(errp, eno, "win-dump: failed to save memory");
>               return 0;
>           }
>   
> @@ -459,7 +460,7 @@ void create_win_dump(DumpState *s, Error **errp)
>   
>       s->written_size = qemu_write_full(s->fd, h, hdr_size);
>       if (s->written_size != hdr_size) {
> -        error_setg(errp, QERR_IO_ERROR);
> +        error_setg_errno(errp, errno, "win-dump: failed to write header");
>           goto out_restore;
>       }
>   



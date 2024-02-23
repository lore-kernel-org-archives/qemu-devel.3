Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA40C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOcn-0000Ng-Hj; Fri, 23 Feb 2024 01:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOcl-0000NT-7R
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:01:31 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOcj-0005DM-Jb
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:01:30 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so486976a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708668088; x=1709272888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FoIRy7W0V+hytFtRoLx6BCKLQAybNtoivttYObssT4s=;
 b=JCekcFCj67MXRvWAHLqv4DupukEuvnR6U3J3YIAZcnFj0n0IoWjH0sHZ6exttzM+Dk
 H26siQXIemOpaNva+rWi9xUnYSUrL47jy/Cfyj/ZetJK3pSkA2gIxWLDBCo4fwneYfap
 KRlEblYRcxMSU5re2YBY8XX1VcUeUe1sJtIA3qA0fhLG7RoTlWoEtMj1nMVI1eKdXwRo
 WG1yqqkYUFROERSldw/3tGYT/NSir/FF3+RqpwgPOS11ybLmre80q2TMx44QtkKHZ4hD
 19J6dLdWpkXuAMsv7SymFqSx2fOwxIM5xXqZSZGZ6+3HvlrCYwrZ8DDa4sUaJSqGvV4R
 34Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668088; x=1709272888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoIRy7W0V+hytFtRoLx6BCKLQAybNtoivttYObssT4s=;
 b=Mgo5avj61WHZAKD9B9femhJkhY1ELOWOgVSHXVkeUUAdj2i1tZZ/mfO9q7bsH8RanQ
 vCLH1Mn+A2ettg6/I2zGE0uoFiuThPPNTZYEd2Ny+uTeMZoHGCPXcwUk26qgsRqi9VKu
 Ejqph2IYc9FBjr/2HUYBwa0WFlXjpuhC6WAl28G9T00aXN4ao7iCdTR++jJ9l/tk7hsc
 3sFvE98QYGiqpbaly1IDVkHs+9AddRzbJx6Cwla6jMZvUQNCTrjoLs2fux9qvOseROOo
 sML0ibx+TRz3D0OIPwDSUgf+SZD+lOwTWITMIvTLok+edZPxmMLY7civvlo5XhlbpWfK
 ouYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC0BgfYbrDXvF83z61wjkric4BGC4tDK3YMyi/uh/ig84/jmj1nDtNlD80ydcVPM7O6KTQIZfFCSFEjC7T14FcFGdOZt8=
X-Gm-Message-State: AOJu0Yz6qf0PWYCzOAwZqwKDORz25eofQOV4BashGg5prquDfGvt7PKn
 TkzE2Y9CfpEjMOGzbNTSbrOlz36BjjgtR3Zh3LzCzqBAVaF+eabTE6REQIiBQbA=
X-Google-Smtp-Source: AGHT+IH5q9GXQ01L1Zd6yw3+JSo1uvjWKPoW7czn+H+XKcnNkAUZdMo7stdzk34T8W1+NhzKvWwbVA==
X-Received: by 2002:aa7:c693:0:b0:565:3a6b:9825 with SMTP id
 n19-20020aa7c693000000b005653a6b9825mr478972edq.18.1708668088111; 
 Thu, 22 Feb 2024 22:01:28 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 q14-20020a056402248e00b0056518035195sm1617841eda.69.2024.02.22.22.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:01:27 -0800 (PST)
Message-ID: <ac4a19b6-9290-4c97-bc7d-eabfef079895@linaro.org>
Date: Fri, 23 Feb 2024 07:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] util: str_split
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1708638470-114846-1-git-send-email-steven.sistare@oracle.com>
 <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1708638470-114846-2-git-send-email-steven.sistare@oracle.com>
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

On 22/2/24 22:47, Steve Sistare wrote:
> Generalize hmp_split_at_comma() to take any delimiter string, rename
> as str_split(), and move it to util/strList.c.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/monitor/hmp.h  |  1 -
>   include/qemu/strList.h | 24 ++++++++++++++++++++++++
>   monitor/hmp-cmds.c     | 19 -------------------
>   net/net-hmp-cmds.c     |  3 ++-
>   stats/stats-hmp-cmds.c |  3 ++-
>   util/meson.build       |  1 +
>   util/strList.c         | 24 ++++++++++++++++++++++++
>   7 files changed, 53 insertions(+), 22 deletions(-)
>   create mode 100644 include/qemu/strList.h
>   create mode 100644 util/strList.c


> +#include "qapi/qapi-builtin-types.h"
> +
> +/*
> + * Split @str into a strList using the delimiter string @delim.
> + * The delimiter is not included in the result.
> + * Return NULL if @str is NULL or an empty string.
> + * A leading, trailing, or consecutive delimiter produces an
> + * empty string at that position in the output.
> + * All strings are g_strdup'd, and the result can be freed
> + * using qapi_free_strList.

Note "qapi/qapi-builtin-types.h" defines:

   G_DEFINE_AUTOPTR_CLEANUP_FUNC(strList, qapi_free_strList)

Maybe mention we can also use:

   g_autoptr(strList)

?

> + */
> +strList *str_split(const char *str, const char *delim);
> +
> +#endif



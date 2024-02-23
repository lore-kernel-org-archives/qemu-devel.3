Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEA9C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOT9-0002gA-VC; Fri, 23 Feb 2024 00:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOT7-0002fb-P3
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:51:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOT6-0002xv-8m
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:51:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso330310f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708667490; x=1709272290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=du98JuAFTGPNIDeuZhUVLEaj+AcU8975zvDnqpbUWu8=;
 b=VOf/wSvKinEn0yltGgZTFYDWx6swbCwsI930tlq5Zukka+BYPy5LKOxkuEsOE61Vrg
 J8mm8g5O1aeggWaaZpsLEp991MihHx3QTRJOVsCPQl1xl6xuP3Qs+Tje6rqAN9t4NDHf
 +jAgyCWDh6VaAoT2ld348E9p8/krMM4KM8Lf6vJgML5BMXkJW1/GdpgZBnN5MUzIlnfS
 nzOhlycs5UirXLPj3ilN7R1a/6uS1yOSiAm0O6Q45bEVtSQPqnTqxxyI/b8Mfq6KXZ8m
 degF8Uuv5Uz5TqJJ/Lh9+TSuoKYNgTVDcjWDdx97NhEit/RR1gjSwLKS7XF9Zq5ELPjm
 EfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708667490; x=1709272290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=du98JuAFTGPNIDeuZhUVLEaj+AcU8975zvDnqpbUWu8=;
 b=KJ27n5L83kAgiFjYnR+Yt8n2SaNCdrqSXI/p4t8fVmklGHej009WrQ1JifEBdXPcTv
 YMhKEGOIJFmuO43kN6/TR0tB2wC5mdxuHzNAlCf94eo5qjUPfVZEginBiEZrz3mBLcV/
 mwpHN/14Kad/r+MB+Epxx3KVmrNpcSpP2uZtJCbTM2MT5QQfH2iSVV7n9exuN+iLKv4B
 n4HZ0pO4CPD2d8Y6ITcVI+UzfXw8VS2jYArCdcRmb4Xj5stkqJV347Jez3TdQcjcEjG2
 sfWnyzlsHaM8/X/Ex44BZYFqUJhtOBNR+GuNeVOCfQThUmOTp9P7NI4bts9deKo2wy9/
 aoGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzSVfI4bmS1+0Ra7ed15uV9B9d0X2fVN/xbLHPHJgHHhBEOs7NhvuXAG9TicSu+vTScSydE94f4smSiR3k6z50d26qaPI=
X-Gm-Message-State: AOJu0Yx43xjtqSuKIFJn3AtSiJNclTgkX1hVO+iKJJcJuDbpne2585w5
 qsv01bRmUTED3p8/19GD5X9dgXnNCd+tgExLDvf96eweAB5fcpgx7Opi42A5ojPaluKZMUdvpfJ
 Ayt4=
X-Google-Smtp-Source: AGHT+IHXYQ9qodSAlGnxuHf62xbeWWhJUWxZe0Qm2GedsRyWmsy7luwPqRK63xYz2ENFUD8VSPxhXg==
X-Received: by 2002:a05:6000:144:b0:33d:500c:df17 with SMTP id
 r4-20020a056000014400b0033d500cdf17mr752732wrx.5.1708667490182; 
 Thu, 22 Feb 2024 21:51:30 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056000137900b0033ce06c303csm1409286wrz.40.2024.02.22.21.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 21:51:29 -0800 (PST)
Message-ID: <ae253529-a200-4838-b2d4-0ebd53f40973@linaro.org>
Date: Fri, 23 Feb 2024 06:51:27 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7E9C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiDd-0000j0-EG; Thu, 27 Jun 2024 02:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiDb-0000ii-Kd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:02:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiDM-0001Rv-61
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:02:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so31332895e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719468153; x=1720072953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+AtbA/rPbpf7cQJ2cVjkgw/1RbISehbqKjd+pn0Eyw=;
 b=PHwtnd1QtZ0tuAqzHgR9zgHkQLxvkZ5Pm1VRS5p/cja+ViukcE8HnEWsK4qljj8Bjj
 7O7CM82w+ZvxuEGLVr3Ps5mpss4drZhfUckvKcO7W3I3PndveHednv9GAlpQY7TWhzEc
 89gxZxHKBKewLpTqtEGSO+Oxuaf9vYrjUDKNgz9ZUTIKuKYo/YPGpSB9IJIYqQ8hKdv6
 WxQFzLLshwfYSjZJxC57N/1pBtF/0Ln0luI0N8usynq1yxZCpWkcjAv6drb6HeX2Y4t3
 YrhI933KiQO/usykAGr/E2pZX6l/kOwQWJEI/SuP8+Ky8b11/QrIit5ydJakBIKX7/Su
 mA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468153; x=1720072953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+AtbA/rPbpf7cQJ2cVjkgw/1RbISehbqKjd+pn0Eyw=;
 b=YOmpwIEbx7bbix9tqdkCfFEHqC0e506JtjLO9SpxTW5EvSyS+YklYPm7X6t4GcgAgA
 iBBzkzIYTer7pwZhPhiU4znaKFGuEc2+U2xpqPXn0NubdZMomXrcwdQkXed5SRYoXl+x
 qu/sTMRquGOPgBBMnslrE8WD+HX3msL0dpv966ajuq4QUO+9Xbz4scpe8c/D/d1shEP8
 TvztWYgSImocxLZRVfHvrirNNSuHtWH7pV8uVVr1KgciFG+vLa3/DwuBZqd9LQqYRuLI
 EzHaUltJfDDN+pEeDnjHeohCJUp63A6ge7rjU6Fg4HitOZEeK9c7ooCeLJg/ESJSB1S8
 KOIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoHWcaGanScArpF8sXiHjHPYVqaHMpMyb4zKxXFbt29zRdjDL0cwNZV/d+Ix5Fg6Z820zGgqW0EgCu59uopjP8PYjNqjQ=
X-Gm-Message-State: AOJu0Yym095a0arXmXxa0fMcb7kfO+wOXJlwMHLaE6WaUWIf7gr/pkBP
 gFYq/atGaNaBq8d872wT8XhP/oOKTUfIb/2r7ECSSuq3vjyYg+Q9SM3pC9NG/I4=
X-Google-Smtp-Source: AGHT+IEmwJvoqOJ1HOjaNN/mN0no1GsDMsq7lI9J63DayZH+Pwzlcan2ZME1IpT804b/mrzdGNws+g==
X-Received: by 2002:a5d:584b:0:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-3674383da8emr617731f8f.56.1719468153553; 
 Wed, 26 Jun 2024 23:02:33 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c117sm768878f8f.5.2024.06.26.23.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:02:32 -0700 (PDT)
Message-ID: <5ed0beab-52d7-4072-b6f0-feaeb9bbb72d@linaro.org>
Date: Thu, 27 Jun 2024 08:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] gdbstub: Move GdbCmdParseEntry into a new header
 file
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627041349.356704-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 27/6/24 06:13, Gustavo Romero wrote:
> Move GdbCmdParseEntry and its associated types into a separate header
> file to allow the use of GdbCmdParseEntry and other gdbstub command
> functions outside of gdbstub.c.
> 
> Since GdbCmdParseEntry and get_param are now public, kdoc
> GdbCmdParseEntry and rename get_param to gdb_get_cmd_param.
> 
> This commit also makes gdb_put_packet public since is used in gdbstub
> command handling.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c          | 134 ++++++++++++++-----------------------
>   gdbstub/internals.h        |  22 ------
>   gdbstub/syscalls.c         |   7 +-
>   gdbstub/system.c           |   7 +-
>   gdbstub/user-target.c      |  25 +++----
>   gdbstub/user.c             |   7 +-
>   include/gdbstub/commands.h |  74 ++++++++++++++++++++
>   7 files changed, 148 insertions(+), 128 deletions(-)
>   create mode 100644 include/gdbstub/commands.h


> +#define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))

Dead code AFAICT.


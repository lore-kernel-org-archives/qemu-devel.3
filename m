Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA733C3DA49
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 00:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYEDx-0007FS-3a; Sun, 28 Jul 2024 20:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYEDu-0007Dr-UH
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 20:26:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYEDt-0005Nv-9q
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 20:26:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc5239faebso12768515ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722212803; x=1722817603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rkz57y3ILPovqtzQiZvJPzzrDYCixL5pPsF36JPYDp4=;
 b=V7CavwwqYGgFvSBu72zum+WFtsWUyMTnueVDS7F6DxetRkJexEJzyzJBw+m/lqtbCk
 tp3h6vsid9mlpKMW91auCriLvhjKuQLmr3RGlfC/He2o/3FBCc08nScqjCS16KU7nkrj
 axXM4QfenRuX8xpDOEQdBXqG0/pNOLJbSjrfs6kajX3FS4wIo5a9HbHtBF7Mrvbi1hJh
 iOBCuPnP5S65mz9cMcn7pIoBICA+DW23JBlBSo46aUk9kXt1QQtk3mC0K73p2J8mins8
 8OGKhIXyTmcoBY4+JqCO8T1t+9mgtSwrtawcBPRp6RwQoJ+HXsV8RQfIFUJFcYjd36+k
 BktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722212803; x=1722817603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rkz57y3ILPovqtzQiZvJPzzrDYCixL5pPsF36JPYDp4=;
 b=ZTnwxPpTt8WSw0v/JCl7oo9wwwPhbZWmfwH8EmE7rmw3WLOSzKFdU1ssQL30MVUQ3o
 77+g7s/GzIt8KVZjPXYP26FErnXynTImQQneZ7sP/kCx/UXLfl/RyhM1NxD8hm3k2YIA
 pYvZI2z0WmFE29TWI0fA+aoOPf8nBeE4PBg/AF+JG9L3VbGLOvRtoK6G/8lz3RiU+GTp
 BejhrdBJe57RW0EAb6mt80+Lsq/P8B9z4QvggQ18CC8Jovd6KgKBkkHlBt0nqMI7CFYl
 P24PaRVf73AOpPhtJfPMm9Tf5NQzcV1XAcs4XlXAYiTwNm6No5kFnwmI0lv8JExcgr88
 jBNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmH79xl8oMjfBSwlqXxNI1oBANCRfegWfXUyzgd4TbGufa8WlCU7Dnrym19CCvwxx0iCS3EqnuLG7xOx01tZGoGcjzs7g=
X-Gm-Message-State: AOJu0Ywgc1sXojV4FZCekqchNxQqujMwsRPbeHC6dFSAu2qsSSigzMX1
 oCkKV57MbXC+OawMNYtSwOcac6ZNkgZLQGUl3vkIYI2hSszfC6wd/yu1VL9+Y4AOLcWOSaHv37M
 t8qG6vg==
X-Google-Smtp-Source: AGHT+IH5yobeyCJ3+eFXidz1f4th+SQlYzi+gmr626oWthxc0c4cVbk804r8z/V14lsTQSwP8LsoDQ==
X-Received: by 2002:a17:902:c941:b0:1fb:46a7:dbda with SMTP id
 d9443c01a7336-1ff048df119mr34494235ad.47.1722212802959; 
 Sun, 28 Jul 2024 17:26:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee1241sm70538675ad.172.2024.07.28.17.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 17:26:42 -0700 (PDT)
Message-ID: <b7dc87dd-53b5-4512-a349-d2867f807a27@linaro.org>
Date: Mon, 29 Jul 2024 10:26:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] linux-user: Fix handling when AT_EXECFD is 0
To: Vivian Wang <uwu@dram.page>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
References: <20240723100545.405476-1-uwu@dram.page>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723100545.405476-1-uwu@dram.page>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/23/24 20:05, Vivian Wang wrote:
> Found when trying to build coreutils under linux-user as binfmt_misc
> interpreter with "open-binary" flag.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2448
> 
> Changes since v1 [1]:
> - Removed old glibc check in patch 1
> - Added Reviewed-by
> 
> [1]: https://lore.kernel.org/qemu-devel/20240721090817.120888-1-uwu@dram.page/
> 
> Vivian Wang (2):
>    util/getauxval: Ensure setting errno if not found
>    linux-user/main: Check errno when getting AT_EXECFD
> 
>   linux-user/main.c | 3 ++-
>   util/getauxval.c  | 6 +++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> --
> 2.45.1
> 
> 

Queued, with the braces in patch 1 fixed.


r~


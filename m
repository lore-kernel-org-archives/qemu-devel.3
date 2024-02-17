Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D610C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRKS-0005Za-EH; Sat, 17 Feb 2024 15:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRKQ-0005ZB-AS
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:30:30 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRKO-0006kS-Oe
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:30:29 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so1873594a12.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708201825; x=1708806625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E3nOq8w4jF5ob0iuasxRZdtbEuAzyZerIRkZJXA+HlA=;
 b=zMwc++8XqipIdRHqj50XlxcvDsktz4r43Up9f16vYJ372vgFLW8TLh7uNMSeCW4xws
 EL6CK5Tc/s67EUmOggQj/NJweo4CiJLKhUo8JULY6wgNnFsI5RCmV8gYixMK4AGXGyyq
 gKFtEDJkmBusrFtbo63ohcfZlqBkgcb1yK62yQ19/ceDSIKlf8Qi5BJbbkxOPl95+wes
 0OWgSkzIpFZ+HosAo3Qgc5zwn5d6eo5rGY6ivNyHaRiR5sAhYwQN8weuy9ENqVI/H6ZM
 YcGffuyXM3zbkT5zN6oqH2ea9Ct/FoOCln/NvrigPnTboNwBiq7QU1D9+sw5H5IhJTnv
 N56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708201825; x=1708806625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E3nOq8w4jF5ob0iuasxRZdtbEuAzyZerIRkZJXA+HlA=;
 b=R/BXnhLkwUwohCA+RU5d1sCi/4ok65OylxkA55Y1UCWcygMziF3iIrE8XNXjsDDhz0
 3gSZS9+ebD0zD2czZDhvL3H3ikXjapICvX1eqM4nhc8Tikizr/3EwriqhDy6iTMKpAtX
 XgP5IZvVbG2ezYTg/50+w+CVBejC7StC8qo70xqwLVqlqCttAnPoxL8q9zR4o3+7G33b
 e3Gh39fioQWJ1UCQ1GfyVAdRlADfj5iEfL/L+nFXW3qLzW/U/BWo/WyjDAVg49zqAG1r
 fCJaoFR/sEY6ZTY0PSkNxXxpEwfounFzJ3Dk2f8A8U6BbAmJ283JHYSZHf+ISv6nOXA5
 sZZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN9NL6dYuUIKTF7vof9KDy1u9yg6p21o4LmIdGp9R5bbHWdBSl3D3qt5/+t6WSoX8iBNOzg393+wZhZOsLiJARt3HPRvk=
X-Gm-Message-State: AOJu0YwK7yDQKHP6Ie7xViuaV/WIFr93VtFJO8wVfJP22iIPLoQHJ9H5
 z4BGuUar591v0PNCLoTdHyTv6aIAPMFDTUHuXc2U/b5IvnS/pQnj/9XecCkl4f/6pXv6zZh6wpa
 O
X-Google-Smtp-Source: AGHT+IFxJSCZ3KwtGE7BcIeMq2Rl5Lilx6FHmraMJBisLG9RfQ9kTTxzjYK4jl/iPkk9cUc7flhIEQ==
X-Received: by 2002:a05:6a20:4f05:b0:19e:8b31:f1ae with SMTP id
 gi5-20020a056a204f0500b0019e8b31f1aemr7891398pzb.29.1708201825642; 
 Sat, 17 Feb 2024 12:30:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lb26-20020a056a004f1a00b006dde1781800sm2081245pfb.94.2024.02.17.12.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:30:25 -0800 (PST)
Message-ID: <c96d085f-9625-40f1-8b45-5daa5f4f2a12@linaro.org>
Date: Sat, 17 Feb 2024 10:30:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] gdbstub: Call gdbserver_fork() both in parent
 and in child
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-7-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216130817.369377-7-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 2/16/24 03:05, Ilya Leoshkevich wrote:
> The upcoming follow-fork-mode child support requires post-fork message
> exchange between the parent and the child. Prepare gdbserver_fork() for
> this purpose. Rename it to gdbserver_fork_end() to better reflect its
> purpose.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   bsd-user/main.c        | 3 ++-
>   gdbstub/user.c         | 5 ++---
>   include/gdbstub/user.h | 6 +++---
>   linux-user/main.c      | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1C3C27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 01:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJNeQ-0007aB-Mz; Mon, 17 Jun 2024 21:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJNeO-0007Zh-VZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 21:28:44 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJNeN-0002v7-GZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 21:28:44 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f9398390fcso1552300a34.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718674122; x=1719278922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CeDHcl8j9GHw3+3IaC2MSqv7jEEamRYynXW/la2DZrc=;
 b=kx0B+PWUrRnjM0ItV0XW5CTj5lnkdlFrzRtEObHGnvlMagvkBN4+3RPduJ5PAIQ6R2
 fM3kjHZEgeDz0CYP+mJhOuQMbZ7L7gGWFdmPCu+iWq0cvjq+CyipWUxkahNa+1eL85Cg
 QOSGtw3xo3ByLJOkpJGz+T9LE92+dMI7Jf5Ue+ahHmDSTfOmqYm9xTdRQHPSakU6GxsP
 yHnunyFD6CpHSUGtalREqR/zMZT7l8KutOtVfxW4IunMxXEN1PRJYHCoaLo+h9p1EebB
 sPsdUp1EFCuIECsrOxS3oX7QH75PdSHWaDN0jaWvm2jEpfkEJXudBI69TUTVXGDzGMHv
 rj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718674122; x=1719278922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CeDHcl8j9GHw3+3IaC2MSqv7jEEamRYynXW/la2DZrc=;
 b=thdr+wvoSL/WOhiR+wCgOvzhueOXm0GX8NL8fjNpnDp16hbfEuSxQN8mBBscO4kcE+
 HqbyRzPcw+Lseq9W/wwxo5eti3A8W4dnlQqQwHu9hZx1fXaah1auLqqtgYMIHMQcIDAg
 NSuDlC91I3SXD4CH/YwMEaaLO9th4x24KcGY1qobSw2wwoa3SrYpVxXChE5EM8LKJGlN
 uHiQi39IZvL4KFIewCWD+n9Njl6GxtPZfqx7pPneYeHE+xHjqQ3QRVt36GTgokizKUsR
 n5zC5lM/onVTtJdypgm0sv5WAgbKMif7f6GEsSogADxhbzGQyCs+KSSnMp1pSw+vsUlf
 IISw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsd3+kXgjnBQhxkqj0NUSHg6D0o7otarELpk7yI4E7+JfikRSi+gS8/1EORXJ7UshKFkLsAMpbtFZdzXMtxsOGv4khwFM=
X-Gm-Message-State: AOJu0Yz1BoHKxyLaljtdV+ejIQfpBrPPBuaqp/PLmM7f+rgIgwcg72aQ
 W5LjpobGdVlR8M6nkRaFTsByXSxM3W9Qs/YoM0ztwZxELTq2mwlDank4KWutCFY=
X-Google-Smtp-Source: AGHT+IHCduZIe6Hhm6Bh11w05fcKzGlZm3MVpF3HqEEoyMG3nuZNq3X7jYAF9UlmX8hCcDMU6CBfLA==
X-Received: by 2002:a9d:6359:0:b0:6fb:8193:85f3 with SMTP id
 46e09a7af769-6fb93b035f7mr11167081a34.29.1718674121879; 
 Mon, 17 Jun 2024 18:28:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedcf36a84sm7233271a12.4.2024.06.17.18.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 18:28:41 -0700 (PDT)
Message-ID: <7fd0eca3-cd15-48c8-ac7f-0967bbada7d2@linaro.org>
Date: Mon, 17 Jun 2024 18:28:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: array overflow in pselect6 emulation
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvmfrtbq26o.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmfrtbq26o.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 6/17/24 03:43, Andreas Schwab wrote:
> $ cat select.c
> #include <stdlib.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/resource.h>
> #include <sys/select.h>
> #include <sys/syscall.h>
> 
> int
> main (int argc, char **argv)
> {
>    int nfds = (argc > 1 ? atoi (argv[1]) : 1031);
>    fd_set *fds = calloc ((nfds + (sizeof (fd_mask) * 8) - 1)
>                          / (sizeof (fd_mask) * 8), sizeof (fd_mask));
>    setrlimit (RLIMIT_NOFILE,
>               &(struct rlimit){ .rlim_cur = nfds, .rlim_max = nfds });
>    dup2 (open ("/dev/null", O_RDONLY), nfds - 1);
>    FD_SET (nfds - 1, fds);
>    syscall (SYS_pselect6, nfds, fds, 0, 0, 0, 0);
> }

Ack.

We use libc fd_set, which is sized for FD_SETSIZE at 1024.

We can either artificially limit RLIMIT_NOFILE (not ideal), or dynamically allocate all 
fd_set within qemu (which will take some time and effort).


r~


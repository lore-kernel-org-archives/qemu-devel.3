Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E55C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgjA-0005gn-Lp; Mon, 24 Jun 2024 06:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sLgj8-0005gM-2Z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:15:10 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sLgj3-0006zs-1A
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:15:09 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-717f17d7c63so1730577a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719224103; x=1719828903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMt95/eWbzku0b99P1I1bYk1mlMIcBFWWEob7XFQtZ4=;
 b=KtVZ+5EGmzh8HZ/bYnCeZGKvsgTS151sdO9Mxaf5f/6RJtmIFvTMZW4hJh/miuLCnc
 KhOjJudnqkG0CsIJJcleOU0KsYx8GStWhahTCDlF9pJaBMF9D7pWuxZ/0Kvp3v/HpDEf
 CHTUTFd1GF6lExcJ5mBDSG/ghlaa3OQPhbmIg5W7yE0uvdXO3QTKF9b/m79o3JJ15wui
 /hMLC9h/uJ2AmMqRkX1zVTkpYinZZCigAH0k5Y1NuW4bVA5YeKtlCJGbdteQ+Ze1VHwY
 tqJg0S+T0PXxyEjVDy7Ij8Q1ZcimSFeOIVOtdjxy5Hf8YPmFtfsHWAMG+TC6Yiw83ojK
 R7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224103; x=1719828903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMt95/eWbzku0b99P1I1bYk1mlMIcBFWWEob7XFQtZ4=;
 b=VvxiYnBa+LYI7uxxBEoElV/yg0KsAU0ZHFA5b+okcphrXCj+ExPlGtFaV1l61DVsvG
 EKNOoDjvn1LVVB/JfedEcGTZd65Bczq7NH8kMJkx8ApL8deVkiEcuQdLl4VcRdPrxbfB
 DUWXN3VrypIz+suBMCR7hfI9o2R1MNJEUvvCO7ZotxcYkIlSy7CB/woaKMJVIUzZVs2a
 vGuKPnkfcHtlfSWsFSV2litD2Rb7wP3xtDBJtmykb1hHIxPGcA/vzXKEDITXHOG6RGGU
 YR0EqN5P46ubx1pLVcoPWvL9akCfs3FMa6guwAa/wURx7l6XoLiW27VkHwzpR28aAmah
 JHOg==
X-Gm-Message-State: AOJu0Yyi/2sBIGry9U7JqiTXYV2zb91ER7rvJZ6gBpuN8J+eA5NFtJUw
 TTCVV4VDoZhUUDYbNDdkoP4jaJnLtFTFCc64/LSdzu+qgaEJB7N0
X-Google-Smtp-Source: AGHT+IFKu78lB8aKs4oaU18Q/QqyLtJ4RkAHESwYkQ9FXjXp9Z0JG2wi8NU9vIXKon6y18tqs58Lxw==
X-Received: by 2002:a17:90b:a50:b0:2c8:880:fba5 with SMTP id
 98e67ed59e1d1-2c86146d12bmr3081182a91.34.1719224102879; 
 Mon, 24 Jun 2024 03:15:02 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e5af9b96sm8332589a91.35.2024.06.24.03.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 03:15:02 -0700 (PDT)
Message-ID: <fbc0a8cd-8b29-4cb0-8ea6-c7fb34f52c18@gmail.com>
Date: Mon, 24 Jun 2024 19:14:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Fix potential bugs in MMIO read|write
To: Minwoo Im <minwoo.im.dev@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Minwoo Im <minwoo.im@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240623024555.78697-1-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 6/23/2024 11:45 AM, Minwoo Im wrote:
> This patch fixes two points reported in coverity scan report [1].  Check
> the MMIO access address with (addr + size), not just with the start offset
> addr to make sure that the requested memory access not to exceed the
> actual register region.  We also updated (uint8_t *) to (uint32_t *) to
> represent we are accessing the MMIO registers by dword-sized only.
>
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA82L-WZnHMW0X+Dr40bHM-EVq2ZH4DG4pdqop4xxDP2Og@mail.gmail.com/
>
> Cc: Jeuk Kim <jeuk20.kim@gmail.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Thank you for the patch.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>


